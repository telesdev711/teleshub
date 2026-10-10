-- Teles Hub - Módulo de Roubar o Ovo
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Remove instâncias anteriores do Teles Hub se já existirem
if CoreGui:FindFirstChild("TelesHubGui") then
    CoreGui.TelesHubGui:Destroy()
end
if character:FindFirstChild("OvoTelesHub") then
    character.OvoTelesHub:Destroy()
end

-- Cria a Interface Principal (Teles Hub UI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TelesHubGui"
screenGui.Parent = CoreGui

-- Janela Principal do Hub
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 140)
mainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Permite arrastar a janela na tela
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Título do Hub
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleLabel.Text = "⚡ TELES HUB ⚡"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Botão de Ativar/Desativar o Ovo
local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(0.9, 0, 0, 45)
actionButton.Position = UDim2.new(0.05, 0, 0, 50)
actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
actionButton.Text = "🥚 Pegar o Ovo"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.TextSize = 15
actionButton.Font = Enum.Font.SourceSansBold
actionButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = actionButton

-- Botão de Fechar o Hub
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.9, 0, 0, 30)
closeButton.Position = UDim2.new(0.05, 0, 0, 102)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "Fechar Hub"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 13
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Lógica do Ovo
local ovoAtivo = false
local ovoPart = nil
local conexaoRender = nil

actionButton.MouseButton1Click:Connect(function()
    if not ovoAtivo then
        ovoAtivo = true
        actionButton.Text = "❌ Soltar o Ovo"
        actionButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

        -- Cria o objeto do ovo nas costas
        ovoPart = Instance.new("Part")
        ovoPart.Name = "OvoTelesHub"
        ovoPart.Size = Vector3.new(2, 2.5, 2)
        ovoPart.Shape = Enum.PartType.Ball
        ovoPart.BrickColor = BrickColor.new("Bright yellow")
        ovoPart.Material = Enum.Material.Neon
        ovoPart.CanCollide = false
        ovoPart.Parent = character

        -- Faz o ovo seguir o jogador
        conexaoRender = RunService.RenderStepped:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") and ovoPart then
                ovoPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
            end
        end)
    else
        ovoAtivo = false
        actionButton.Text = "🥚 Pegar o Ovo"
        actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)

        if conexaoRender then conexaoRender:Disconnect() end
        if ovoPart then ovoPart:Destroy() end
    end
end)

closeButton.MouseButton1Click:Connect(function()
    if conexaoRender then conexaoRender:Disconnect() end
    if ovoPart then ovoPart:Destroy() end
    screenGui:Destroy()
end)

print("Teles Hub carregado com sucesso!")
