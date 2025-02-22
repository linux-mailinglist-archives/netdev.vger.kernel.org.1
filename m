Return-Path: <netdev+bounces-168743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2641A4071B
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F8219C13EF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17E207A2B;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itA//Fxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AC20767C;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=F89IBYRs4sKhR7MeS955JYD7WxJOrrc/lBJyp4DW73k+oXAupk7/Q+lKX5CtsOwJzHeLZqyfCbJXy4gBjbzHcG6EZ0R66f4PyoKC0n5e0jZgHEcivViOF5mfJcjfGikp2f7zj5/tiX8N0mNaUYqIF3/vPo5876SjxfHRA8fYgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtUWm8jFznv1qyCPP3S7VimGDQddkVUVAddDjAXj6sZai4b/3FFFdhcCiuVLoAD7tSMRYvTHQqutV09tUAgdU0mjG/gjToArQA5Yz6/3eFrug4y+mm24Fn9rdHDXGRW4FG3X8+HU5QvUbzei48iuL2dt/uGSpt8csP38wsBs7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itA//Fxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10078C4CEE9;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217802;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=itA//Fxv6WA7o4Z/OimTkX/+7Tig1Nr3Z2MqiqaoZ34aCIWkICXhStVFPi4v7gdAZ
	 KWILh0PGYaRcLdoB4/SVw3MHnNz3eHNM9anJFPwLsJv2ZR35Ckll6JwkWNPS25SfPa
	 JN5wUSCsuMwU752N3Xk+KyQJxBtdZG6MQ45tQWPAnjoRTr6TyHs/fNEm7hdiQK/Duq
	 uo/3kPxmhaPj4+ZSPlzByHr5Jb3IYobRjYs+EhBcN3SdQuvwkerhi3OuuhFmuEim0p
	 Pf6OwD1wyF+lJWeSLxrZJn0EoGBu3X3ZsjCst3hwp5ScqyXC/ZZK5GUfJt3PpnUSjE
	 7GMry7OIP1g0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B3C021B6;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Feb 2025 10:49:30 +0100
Subject: [PATCH net-next v5 3/7] net: phy: aquantia: search for
 firmware-name in fwnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-tn9510-v3a-v5-3-99365047e309@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
In-Reply-To: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=1169;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=0zRi7Vk41IU72s/8DzrXAvCvexTz79in+5DW1aumMeg=;
 b=w+ESjiHbOrvoQFxv3jE21IjVpHLorFg3NmMOEt25B4ZO5bLNtichdGa8ilRo4R0+FJ87ZNuMc
 j20GSsqvXO5C8n0g2j/FRJIyuQi5BKnhTwAbAU5zDETbxuQtAP+b85j
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Allow the firmware name of an Aquantia PHY alternatively be provided by the
property "firmware-name" of a swnode. This software node may be provided by
the MAC or MDIO driver.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index dab3af80593f51ff6dc670dfb54ae358c2458c40..bbbcc9736b00e1cfa193f4398889a4c172ca27a4 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -328,10 +328,11 @@ static int aqr_firmware_load_fs(struct phy_device *phydev)
 	const char *fw_name;
 	int ret;
 
-	ret = of_property_read_string(dev->of_node, "firmware-name",
-				      &fw_name);
-	if (ret)
+	ret = device_property_read_string(dev, "firmware-name", &fw_name);
+	if (ret) {
+		phydev_err(phydev, "failed to read firmware-name: %d\n", ret);
 		return ret;
+	}
 
 	ret = request_firmware(&fw, fw_name, dev);
 	if (ret) {

-- 
2.47.2



