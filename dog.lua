local Player = game:GetService("Players").LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(" sleaqse my goat | I love gill |", "GrapeTheme")

local ATab = Window:NewTab("Autofarm")
local ASection = ATab:NewSection("Autofarm")

local Enemies = workspace.Enemies:GetDescendants()
local Mobs = {}

for i,v in pairs(Enemies) do
if v:IsA("ObjectValue") and v.Parent.Name == "Enemy" and v.Parent:IsA("Model") and v.Name == "Model" then
    if not table.find(Mobs,tostring(v.Value)) then
        table.insert(Mobs,tostring(v.Value))
    end
end
end

ASection:NewDropdown("Teleport To Mob", "Teleports you to the mob selected once(repeatable)", Mobs, function(CurrentOption)
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local Enemies = workspace.Enemies:GetDescendants()
   for i,v in next, Enemies do 
      if v.Parent.Name == "Enemy" and v:IsA("BasePart") and v.Name == "EnemyLocation" and tostring(v.Parent.Model.Value) == CurrentOption and v.Parent.InCombat.Value == false and v.Parent:FindFirstChild("EnemyDefeat") ~= true then
         HRP.CFrame = v.CFrame
      end
   end
end)

getgenv().stopautotpmobloop = false

ASection:NewDropdown("Autoteleport To Mob", "Automatically teleports you to the mob selected", Mobs, function(CurrentOption)
spawn(function()
    while not stopautotpmobloop and wait(0.5) do
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local Enemies = workspace.Enemies:GetDescendants()
        if getgenv().stopautotpmobloop == true then
            break
        end
    local CombatFolder = workspace:FindFirstChild("CombatFolder")
        if CombatFolder == nil then
            for i,v in next, Enemies do 
                if v.Parent.Name == "Enemy" and v:IsA("BasePart") and v.Name == "EnemyLocation" and tostring(v.Parent.Model.Value) == CurrentOption and v.Parent.InCombat.Value == false and v.Parent:FindFirstChild("EnemyDefeat") ~= true then
                    HRP.CFrame = v.CFrame
                    break
                end
            end
        end
    end
end)
end)

ASection:NewButton("Stop AutoMobTP", "Stops automatically teleporting to the mob selected", function()
getgenv().stopautotpmobloop = true
wait(0.4)
getgenv().stopautotpmobloop = false
end)

ASection:NewButton("GodMode", "Activates GodMode", function()
    local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("DamageNew", true)
    local Player = game:GetService("Players").LocalPlayer
    local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
   local Args = {...}
   local Self = Args[1]
       if self == Remote and Args[1] == Player.Character then
           return
       end
   return OldNameCall(self, unpack(Args))
end)
end)

local Tp = true

ASection:NewToggle("Auto OrbTP", "Teleports you to orbs automatically (portal relic)", function(State)
    Tp = State
task.spawn(function()
   while Tp and wait(0.1) do
	local MyFol
        local CombatFolder = workspace:FindFirstChild("CombatFolder")
        if CombatFolder ~= nil and CombatFolder:FindFirstChild(Player.Name) then
	    local Player = game:GetService("Players").LocalPlayer	
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            MyFol = CombatFolder:FindFirstChild(Player.Name):GetDescendants()
	    if MyFol then
            for i,v in pairs(MyFol) do
                if v:IsA("BasePart") and v.Name == "HitBox" or v.Name == "Base" then
                    HRP.CFrame = v.CFrame
                end
            end
	end
        end
    end
end)
end)

local Acts = true

ASection:NewToggle("Spam All Actives", "Spams all Actives", function(State)
Acts = State

while Acts and wait(6.3) do
local args = {
[1] = "UseItem",
[2] = 1,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))

local args = {
[1] = "UseItem",
[2] = 2,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))

local args = {
[1] = "UseItem",
[2] = 3,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
} 
game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)

ASection:NewButton("AntiAFK", "You will not get disconnected for idling", function()
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
   v:Disable()
end
end)

ASection:NewButton("AntiAFK", "You will not get disconnected for idling", function()
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
   v:Disable()
end
end)

ASection:NewButton("AntiAFK", "You will not get disconnected for idling", function()
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
   v:Disable()
end
end)


local BMTab = Window:NewTab("Black Market")
local BMSection = BMTab:NewSection("Black Market Items")

-- Function to check if the Black Market is available
local function isBlackMarketAvailable()
    local market = workspace:FindFirstChild("BlackMarket")
    return market and market:FindFirstChild("Items")
end

-- Function to buy an item
local function buyItem(itemName)
    local args = {
        [1] = itemName
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
end

-- Auto-buy loop
spawn(function()
    while true do
        if isBlackMarketAvailable() then
            local items = workspace.BlackMarket.Items:GetChildren()
            for _, item in pairs(items) do
                buyItem(item.Name) -- Auto-buy each item
                wait(1) -- Small delay to prevent overload
            end
        end
        wait(5) -- Check every 5 seconds
    end
end)

local BTab = Window:NewTab("Fruits/Trees/Pickups")
local BSection = BTab:NewSection("Fruits/Trees/Pickups")

local Mats = true
local MaterialGivers = game:GetService("Workspace"):FindFirstChild("MaterialGivers"):GetDescendants()

BSection:NewToggle("Gather Fruits", "Automatically gathers all fruits/trees", function(State)
    Mats = State
spawn(function()
while Mats and wait(0.1) do
	local Player = game:GetService("Players").LocalPlayer
           local Character = Player.Character or Player.CharacterAdded:Wait()
           local HRP = Character:FindFirstChild("HumanoidRootPart")
     if HRP then
        for i,v in pairs(MaterialGivers) do
            if v:IsA("BasePart") and v.Parent.Parent.Parent.Name == "MaterialGivers" then
               firetouchinterest(HRP,v,0)
               firetouchinterest(HRP,v,1)
            end
        end
    end
end
end)
end)

BSection:NewButton("Activate Telescope", "Teleports you to the telescope and activates the ProximityPrompt", function()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HRP = Character:FindFirstChild("HumanoidRootPart")

   getgenv().stopautotpmobloop = true
   wait(0.4)
   getgenv().stopautotpmobloop = false
    -- Teleport to the telescope coordinates
    HRP.CFrame = CFrame.new(1989, 415, 3406)
    wait(0.2) -- Small delay before interacting

    -- Find and activate the ProximityPrompt in the workspace
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            fireproximityprompt(v)  -- Activate the ProximityPrompt
            print("Activated Telescope!")
            return
        end
    end

    print("No ProximityPrompt found!")
end)

local autoCollectStarsEnabled = false  -- Toggle state

BSection:NewToggle("Auto Collect Stars", "Continuously collects Stars and Blue Stars", function(state)
    autoCollectStarsEnabled = state  -- Toggle ON/OFF

    while autoCollectStarsEnabled do  -- Keep looping while enabled
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        local foundStar = false  -- Track if any star was found

        for _, v in ipairs(workspace:GetChildren()) do -- Scan all top-level objects
            if v:IsA("Model") and (v.Name == "Star" or v.Name == "BlueStar") then
                local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    HRP.CFrame = v:GetPivot() + Vector3.new(0, 3, 0) -- Teleport slightly above
                    wait(0.5) -- Small delay before interaction
                    fireproximityprompt(prompt) -- Collects the star
                    print("Collected a " .. v.Name .. "!")
                    foundStar = true
                end
            end
        end

        if not foundStar then
            print("No Stars found! Waiting...")
        end

        wait(1) -- Prevents excessive looping and keeps checking
    end
end)

local HRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")


-- Connect the function to the ChildRemoved event of the Black Market stall
workspace.Stalls["Black Market"].ChildRemoved:Connect(onBlackMarketDealerRemoved)

BSection:NewButton("Teleport To Meteorite", "Teleports you to the meteorite", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
if HRP then
    HRP.CFrame = CFrame.new(-427, 232.5, -414)
end
end)

BSection:NewButton("Teleport To A Graveshard Grave", "Teleports you to a Grave if it exists (Mining Pickaxe)", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local WorkspaceD = workspace:GetDescendants()
   for i,v in next, WorkspaceD do 
      if v.Name == "Hitbox" and v.Parent == workspace then
         HRP.CFrame = v.CFrame
      end
   end
end)


BSection:NewButton("Teleport To A Dragonball", "Teleports you to a dragonball if it exists", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local WorkspaceD = workspace:GetDescendants()
   for i,v in next, WorkspaceD do 
      if v.Name == "Middle" and v.Parent.Parent == workspace and v.Parent.Name == "DragonBall" then
         HRP.CFrame = v.CFrame
      end
   end
end)

BSection:NewButton("Teleport To A Lily", "Teleports you to a lily if it exists", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local WorkspaceD = workspace:GetDescendants()
   for i,v in next, WorkspaceD do 
      if v.Name == "Middle" and v.Parent.Parent == workspace and v.Parent.Name == "Lily" then
         HRP.CFrame = v.CFrame
      end
   end
end)

BSection:NewButton("Teleport To A Deathbush/SweetLoveBush", "Teleports you to a Deathbush if it exists", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local WorkspaceD = workspace:GetDescendants()
   for i,v in next, WorkspaceD do 
      if v.Name == "Middle" and v.Parent.Parent == workspace and v.Parent.Name == "DeathBush" then
         HRP.CFrame = v.CFrame
      end
   end
end)

local CTab = Window:NewTab("Teleport")
local CSection = CTab:NewSection("Teleport")

local ArsenalTab = {}
local Arsenals = workspace:WaitForChild("Arsenals"):GetDescendants()

for i,v in pairs(Arsenals) do
    if v:IsA("BasePart") and v.Parent.Parent.Name == "Arsenals" then
        if not table.find(ArsenalTab,v.Parent.Name) then
            table.insert(ArsenalTab,v.Parent.Name)
        end
    end
end

table.insert(ArsenalTab,"Void")
table.insert(ArsenalTab,"Land Under The Waterfall")
table.sort(ArsenalTab)

CSection:NewDropdown("Teleport To Arsenal", "Teleports you to the selected arsenal", ArsenalTab, function(CurrentOption)
    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
    if CurrentOption == "Land Under The Waterfall" then
        HRP.CFrame = CFrame.new(-19912,-110,-6258)
    elseif CurrentOption == "Void" then
        HRP.CFrame = CFrame.new(-19396,-73,-4085)
    else
        HRP.CFrame = workspace.Arsenals:FindFirstChild(CurrentOption):FindFirstChild("Base").CFrame
    end
end)

local NPCs = {}
table.insert(NPCs,"Smile (Hyper)")
table.insert(NPCs,"Bottle of ??? (Hunter)")
table.insert(NPCs,"Blind Grillby (Burning Head)")
table.insert(NPCs,"Cursed Altar (Cursed)")
table.insert(NPCs,"Gabriel (Ocean Glider)")
table.insert(NPCs,"Green Light Green Light (Portal)")
table.insert(NPCs,"Gears (Time Grinders)")
table.insert(NPCs,"Mixed Letter (Ghoul)")
table.insert(NPCs,"Holy Cross (Holy)")
table.insert(NPCs,"Bottle (Gravity Boots)")
table.insert(NPCs,"Ancient Paw (Pull)")
table.insert(NPCs,"Noob (Torch)")
table.insert(NPCs,"Broski (Bounty Hunter)")
table.insert(NPCs,"Jeff (Berserk)")
table.insert(NPCs,"Gem (Crystalized)")
table.insert(NPCs,"Avatar of Radismus (Blood Wipe)")


CSection:NewDropdown("Teleport To Chosen Relic NPC", "Teleports you to the chosen Relic NPC", NPCs, function(CurrentOption)
local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if CurrentOption == "Bottle of ??? (Hunter)" then HRP.CFrame = CFrame.new(-1040.1, 195.214, -4722.89)
    elseif CurrentOption == "Blind Grillby (Burning Head)" then HRP.CFrame = CFrame.new(156.598, 162.562, -2334.68)
    elseif CurrentOption == "Cursed Altar (Cursed)" then HRP.CFrame = CFrame.new(-201.773, -98.5357, 2893.72)
    elseif CurrentOption == "Gabriel (Ocean Glider)" then HRP.CFrame = CFrame.new(1721.16, 4.14446, -5437.34)
    elseif CurrentOption == "Green Light Green Light (Portal)" then HRP.CFrame = CFrame.new(-529.14,-92.2,2063.35)
    elseif CurrentOption == "Gears (Time Grinders)" then HRP.CFrame = CFrame.new(-1848,203.5,-3941.5)
    elseif CurrentOption == "Mixed Letter (Ghoul)" then HRP.CFrame = CFrame.new(-1092.88, -101, 2155.55)
    elseif CurrentOption == "Holy Cross (Holy)" then HRP.CFrame = CFrame.new(-1275, 493, 67)
    elseif CurrentOption == "Bottle (Gravity Boots)" then HRP.CFrame = CFrame.new(5319.36, 13.2782, -8510.45)
    elseif CurrentOption == "Ancient Paw (Pull)" then HRP.CFrame = CFrame.new(-904, 70, -2592.5)
    elseif CurrentOption == "Noob (Torch)" then HRP.CFrame = CFrame.new(-124.406, 43.0267, -415.472)
    elseif CurrentOption == "Broski (Bounty Hunter)" then HRP.CFrame = CFrame.new(569.595, 194.855, -2082.55)
    elseif CurrentOption == "Jeff (Berserk)" then HRP.CFrame = CFrame.new(311.894, 66.9847, -1380.45)
    elseif CurrentOption == "Gem (Crystalized)" then HRP.CFrame = CFrame.new(681.1, 34.6, -1334.6)
    elseif CurrentOption == "Avatar of Radismus (Blood Wipe)" then HRP.CFrame = CFrame.new(5230.36, 384.857, 1645.1)
    elseif CurrentOption == "Smile (Hyper)" then HRP.CFrame = CFrame.new(-1201, -123, 2573)
    end
end)

local NPCTable = {}
local NPCFol = workspace.QuestNPCs:GetDescendants()
table.insert(NPCTable,"Grani")
table.insert(NPCTable,"King Blubb")

for i,v in pairs(NPCFol) do
if v.Name == "HumanoidRootPart" and v.Parent:IsA("Model") then
if not table.find(NPCTable,v.Parent.Name) then
table.insert(NPCTable,v.Parent.Name)
end
end
end

CSection:NewDropdown("Teleport To QuestNPC (Grani/Blubb too)", "Teleports you to the chosen Quest NPC", NPCTable, function(CurrentOption)
local Player = game:GetService("Players").LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()
HRP = Player.Character:FindFirstChild("HumanoidRootPart")
if HRP then
	if CurrentOption == "Grani" then
		HRP.CFrame = CFrame.new(6737.32, 144.011, 9794.26)
	elseif CurrentOption == "King Blubb" then
		HRP.CFrame = CFrame.new(-3723.83, 431.422, -5055.45)
	else  HRP.CFrame = workspace.QuestNPCs:FindFirstChild(CurrentOption).HumanoidRootPart.CFrame
	end
end
end)

local StatuesFol = workspace.Statues:GetDescendants()
local StatuesTable = {}

for i,v in pairs(StatuesFol) do
if v.Name == "ProximityPrompt" and v.Parent.Name == "Attachment" then
if not table.find(StatuesTable,v.Parent.Parent.Parent.Name) then
table.insert(StatuesTable,v.Parent.Parent.Parent.Name)
end
end
end

CSection:NewDropdown("Teleport To Class Statue", "Teleports you to the chosen Class Statue", StatuesTable, function(CurrentOption)
local Player = game:GetService("Players").LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()
HRP = Player.Character:FindFirstChild("HumanoidRootPart")

if HRP then
HRP.CFrame = workspace.Statues:FindFirstChild(CurrentOption):FindFirstChild("ProximityPrompt", true).Parent.Parent.CFrame
end
end)

CSection:NewButton("Teleport To Blackmarket", "Teleports the player to blackmarket", function()
    local BlackMarket = workspace:FindFirstChild("Stalls"):FindFirstChild("Black Market"):GetDescendants()
for i,v in pairs(BlackMarket) do
if v.Name == "Grani" and v.Parent.Parent.Name == "Grani" then
	local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = v.CFrame
end
end
end)

CSection:NewButton("Teleport To Vanessa", "Teleports the player to Vanessa(bluemoon fairy)", function()
local fairy = workspace:FindFirstChild("Vanessa")
if fairy ~= nil then
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = fairy.HumanoidRootPart.CFrame
end
end)

CSection:NewButton("Teleport To Harvestia", "Teleports the player to Harvestia", function()
local fairy = workspace:FindFirstChild("Harvestia")
if fairy ~= nil then
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = fairy.HumanoidRootPart.CFrame
end
end)

local Players = game:GetService("Players"):GetChildren()
local onJoinList = {}
local updateList = {}

local LocalPlayer = game:GetService("Players").LocalPlayer

for i,v in pairs(Players) do
    if not table.find(onJoinList,v.Name) and v.Name ~= LocalPlayer.Name then
        table.insert(onJoinList,v.Name)
    end
end

local dropdown = CSection:NewDropdown("Teleport To Player", "Teleports you to the player selected", onJoinList, function(CurrentOption)
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local Players = game:GetService("Players"):GetChildren()
   for i,v in next, Players do 
      if v.Name == CurrentOption then
         HRP.CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame
      end
   end
end)

CSection:NewButton("Update Playerlist", "Refreshes Playerlist", function()
local Players = game:GetService("Players"):GetChildren()
for i,v in pairs(Players) do
    if not table.find(updateList,tostring(v.Name)) and v.Name ~= LocalPlayer.Name then
        table.insert(updateList,tostring(v.Name))
    end
end
  dropdown:Refresh(updateList)
end)

local DTab = Window:NewTab("Other")
local DSection = DTab:NewSection("Other")

DSection:NewKeybind("Toggle UI Button", "Toggle UI Button", Enum.KeyCode.LeftControl, function()
	Library:ToggleUI()
end)

DSection:NewButton("Infinite Combo ComboSword", "Infinite Combo on any tier of ComboSword", function()
    -- Variable
local Player = game.Players.LocalPlayer
local De = game:GetService("Debris")

-- Function
function InfCombo(Plr)
    local head = Plr:WaitForChild("Head")
    head.DescendantAdded:Connect(function(v)
        if v:IsA("Script") then
            De:AddItem(v,0.5)
        end
    end)
end

-- Connect
player.CharacterAdded:Connect(InfCombo)
InfCombo(Player.Character)
end)

DSection:NewButton("InfiniteYield", "InfiniteYield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

DSection:NewButton("Open all Chests", "Opens all the chests", function()
    local Chests = workspace:FindFirstChild("Chests"):GetDescendants()
local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i,v in pairs (Chests) do
if v.Name == "TouchInterest" and v.Parent.Name == "Giver" and v.Parent.Parent.Parent.Name == "Chests" and v.Parent.Parent.Parent:IsA("Folder") then
firetouchinterest(HRP,v.Parent,0)
firetouchinterest(HRP,v.Parent,1)
end
end
end)

local BlubbToggle = true

DSection:NewToggle("Autobuy Blubb's Pizza", "Automatically buys blubb's pizza", function(State)
BlubbToggle = State
local args = {
[1] = "Buy5", [2]=workspace:WaitForChild("Stalls"):WaitForChild("Initus Bay"):WaitForChild("Item Shop"):WaitForChild("Shop"):WaitForChild("Blubb Pizza")
}
spawn(function()
while BlubbToggle and wait(0.1) do
local Gold = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Gold")
if Gold.Value > 12500 then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Effected"):FireServer(unpack(args))
end
end
end)
end)

local FTab = Window:NewTab("Stats")
local FSection = FTab:NewSection("Stats")


FSection:NewButton("Auto Damage Stat", "Adds +1 to Damage repeatedly", function()
spawn(function()
while wait() do
	local args = {[1]="Invest",[2]="Damage",[3]=1}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)
end)

FSection:NewButton("Auto Health Stat", "Adds +1 to Health repeatedly", function()
spawn(function()
while wait() do
	local args = {[1]="Invest",[2]="Health",[3]=1}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)
end)

FSection:NewButton("Auto Magic Stat", "Adds +1 to Magic repeatedly", function()
spawn(function()
while wait() do
	local args = {[1]="Invest",[2]="Magic",[3]=1}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)
end)

FSection:NewButton("Auto Mana Stat", "Adds +1 to Mana repeatedly", function()
spawn(function()
while wait() do
	local args = {[1]="Invest",[2]="Mana",[3]=1}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)
end)

FSection:NewButton("Auto Shield Stat", "Adds +1 to Shield repeatedly", function()
spawn(function()
while wait() do
	local args = {[1]="Invest",[2]="Shield",[3]=1}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end) 
end)
