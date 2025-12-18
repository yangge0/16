local WBG=GameMain:GetMod("WBG");
local WBB=0;
local sj=0;
local wps={"Item_ParasolWoodBlock","Item_SkyStoneBlock"}
--初始化
function WBG:OnInit()
end
--当
function WBG:OnEnter()
end
function WBG:OnLeave()
end
--当环境更新的时候
function WBG.OnSecretUpdate(t,obj)
end

function WBG:add(i)
    WBG:chongzhisuiji();
	local n = me:RandomInt(0,10);
	i=i+n-5;
	me:AddMsg(string.format(XT("[NAME]发现这里面有%s仙灵币。"), tostring(i)));
	me:AddMsg(string.format(XT("你需要缴纳%s仙灵币的赋税。"), tostring(i*0.08)));
	WBG:ObServer();
	me:AddMsg(string.format(XT("       ↓↓↓(+%s) "), tostring(i*0.92)));
	
	
	WBB=WBB+i*0.92;
	WBG:ObServer();
	
end
function WBG:chongzhisuiji()
if sj==0 then
 world:SetRandomSeed();
 me:AddMsg("初始化随机环境。");
 sj=1;
 end
 
end

--查看还有多少仙灵币
function WBG:ObServer()
	me:AddMsg(string.format(XT("余额：%s仙灵币。"), tostring(WBB)));
end

function WBG:MaiWp(x,wp,wpn)
WBG:chongzhisuiji();

if WBB-x>0 then





WBG:ObServer();
me:AddMsg(string.format(XT("       ↓↓↓(-%s) "), tostring(x)));
WBB=WBB-x;
WBG:ObServer();
me:AddMsg("购得：");
me:DropAwardItem(wp,wpn)

local nn=me:RandomInt(0,100);


if	nn==1 then
me:AddMsg("[NAME]惊奇的发现仙灵币居然没有消耗");
WBG:ObServer();
me:AddMsg(string.format(XT("       ↓↓↓(-%s) "), tostring(x)));
WBB=WBB+x;
WBG:ObServer();
elseif nn==2 then
me:AddMsg("[NAME]仔细的翻了翻发现夹层里面居然有赠品");
me:DropAwardItem(wp,1)
end






else
me:AddMsg(string.format(XT("需要%s仙灵币，你的余额不足 "), tostring(x)));
WBG:ObServer();

end


end

function WBG:OnSave()
	local tbSave = { wanbaobi = WBB };
	return tbSave;
end

function WBG:OnLoad(tbLoad)
	if tbLoad ~= nil then
	WBB = tbLoad["wanbaobi"];
	
	end
end
