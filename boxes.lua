CreateClientConVar("jeff_prop1_r", 0, true);
CreateClientConVar("jeff_prop1_g", 0, true);
CreateClientConVar("jeff_prop1_b", 0, true);

CreateClientConVar("jeff_prop2_r", 255, true);
CreateClientConVar("jeff_prop2_g", 255, true);
CreateClientConVar("jeff_prop2_b", 0, true);

CreateClientConVar("jeff_prop3_r", 0, true);
CreateClientConVar("jeff_prop3_g", 255, true);
CreateClientConVar("jeff_prop3_b", 0, true);

CreateClientConVar("jeff_player_color_r", 255, true);
CreateClientConVar("jeff_player_color_g", 0, true);
CreateClientConVar("jeff_player_color_b", 0, true);

CreateClientConVar("jeff_fov", 110, true);
CreateClientConVar("jeff_noshake", 1, true);


hook.Add("PostDrawOpaqueRenderables", "pk_esp_box", function()

	for i=1,#player.GetAll() do

		local currPlayer = player.GetAll()[i];

		if currPlayer:IsPlayer() && currPlayer != LocalPlayer() && currPlayer:Alive() && currPlayer:Team() != "TEAM_SPECTATOR" && currPlayer:Team() != "Unassigned" then
			render.DrawWireframeBox(currPlayer:GetPos(), Angle(0,0,0), Vector(currPlayer:OBBMins().x - .5, currPlayer:OBBMins().y - .5, currPlayer:OBBMins().z - .5), Vector(currPlayer:OBBMaxs().x + .5, currPlayer:OBBMaxs().y + .5, currPlayer:OBBMaxs().z + .5), Color(GetConVar("jeff_player_color_r"):GetInt(), GetConVar("jeff_player_color_g"):GetInt(), GetConVar("jeff_player_color_b"):GetInt()), false);
			render.DrawWireframeBox(currPlayer:GetPos(), Angle(0,0,0), currPlayer:OBBMins(), Vector(currPlayer:OBBMaxs().x, currPlayer:OBBMaxs().y, currPlayer:OBBMaxs().z), Color(GetConVar("jeff_player_color_r"):GetInt(), GetConVar("jeff_player_color_g"):GetInt(), GetConVar("jeff_player_color_b"):GetInt()), false);
			render.DrawWireframeBox(currPlayer:GetPos(), Angle(0,0,0), Vector(currPlayer:OBBMins().x + .5, currPlayer:OBBMins().y + .5, currPlayer:OBBMins().z + .5), Vector(currPlayer:OBBMaxs().x - .5, currPlayer:OBBMaxs().y - .5, currPlayer:OBBMaxs().z - .5), Color(GetConVar("jeff_player_color_r"):GetInt(), GetConVar("jeff_player_color_g"):GetInt(), GetConVar("jeff_player_color_b"):GetInt()), false);
		end

	end

	for i=1,#ents.FindByClass("prop_physics") do

		local currProp = ents.FindByClass("prop_physics")[i];
		local pAngs = currProp:GetAngles();
		
		render.DrawWireframeBox(currProp:GetPos(), pAngs, currProp:OBBMins(), Vector(currProp:OBBMaxs().x, currProp:OBBMaxs().y, currProp:OBBMaxs().z), Color(GetConVar("jeff_prop1_r"):GetInt(), GetConVar("jeff_prop1_g"):GetInt(), GetConVar("jeff_prop1_b"):GetInt(), 255), false);
		render.DrawWireframeBox(currProp:GetPos(), pAngs, Vector(currProp:OBBMins().x + 2, currProp:OBBMins().y + 2, currProp:OBBMins().z + 2), Vector(currProp:OBBMaxs().x - 2, currProp:OBBMaxs().y - 2, currProp:OBBMaxs().z - 2), Color(GetConVar("jeff_prop2_r"):GetInt(), GetConVar("jeff_prop2_g"):GetInt(), GetConVar("jeff_prop2_b"):GetInt(), 255), false);
		render.DrawWireframeBox(currProp:GetPos(), pAngs, Vector(currProp:OBBMins().x + 4, currProp:OBBMins().y + 4, currProp:OBBMins().z + 4), Vector(currProp:OBBMaxs().x - 4, currProp:OBBMaxs().y - 4, currProp:OBBMaxs().z - 4), Color(GetConVar("jeff_prop3_r"):GetInt(), GetConVar("jeff_prop3_g"):GetInt(), GetConVar("jeff_prop3_b"):GetInt(), 255), false);

	end

end)

hook.Add( "HUDPaint", "pk_esp_names", function()

	for i=1,#player.GetAll() do

		local currPlayer = player.GetAll()[i];
		local nameLen;
		local teamCol;

		if currPlayer != LocalPlayer() then
			
			nameLen = select(1, surface.GetTextSize(currPlayer:GetName()))
			teamCol = team.GetColor(currPlayer:Team());

			surface.SetFont( "Default" );
			surface.SetTextColor( 255, 255, 255 );
			surface.SetTextPos( currPlayer:GetPos():ToScreen().x - (nameLen / 2), currPlayer:GetPos():ToScreen().y );
			surface.DrawText( currPlayer:GetName() );

		end

	end

end );

hook.Add( "CalcView", "fov_noshake", function() 

	local view = {}
	view.fov = GetConVar("jeff_fov"):GetInt();
	view.drawviewer = false;

	if (GetConVar("jeff_noshake"):GetInt() == 1) then
		view.angles = LocalPlayer():EyeAngles();
	end

	return view;

end);