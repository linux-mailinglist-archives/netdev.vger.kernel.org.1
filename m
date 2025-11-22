Return-Path: <netdev+bounces-240991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE960C7D1A0
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A576353417
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5315ECD7;
	Sat, 22 Nov 2025 13:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A87261D;
	Sat, 22 Nov 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763818360; cv=none; b=D6WqHPjDTeqnxeBdpVrzvf+iMdZqjgU/juo+lpahQKjsYOdEQ/JeVFQdNZ8yeRP/XVL5IyTemRiYb054r8is9Mmwg8o12YtNAKBAx0W2iteUB4QdOU21YhFpH7iw3hi202R4kNTsrODMFDzh6q1JLDbeHq/GwmcyC+TeoCmTcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763818360; c=relaxed/simple;
	bh=odpmbImSWoGndyTgZB2K3Vi2/SS4FW6OnVT33lFfaxA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qWTd6vGpwLtT7/v3/EYlRcNAZRPogL8MZyc9G/6GGGo5dTgw81t1zN9yF0PAyDStXceocPx1FhGBhPV606LiP1IGEB+KCc4M5o6rLMYYKeaUQf8HXHcShrvmnK79MpHnyazQ2JV5jcb0u6wKUeWGBavjYWMspHSxZKeRd2AodNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vMnis-000000002pq-3NOj;
	Sat, 22 Nov 2025 13:32:18 +0000
Date: Sat, 22 Nov 2025 13:32:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: phy: mxl-gpy: add support for MxL86211C
Message-ID: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Chad Monroe <chad@monroe.io>

MxL86211C is a smaller and more efficient version of the GPY211C.
Add the PHY ID and phy_driver instance to the mxl-gpy driver.

Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 * add entry in MODULE_DEVICE_TABLE
 * unify spelling

 drivers/net/phy/mxl-gpy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 0c8dc16ee7bde..bea9072ac4a8d 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -30,6 +30,7 @@
 #define PHY_ID_GPY241B		0x67C9DE40
 #define PHY_ID_GPY241BM		0x67C9DE80
 #define PHY_ID_GPY245B		0x67C9DEC0
+#define PHY_ID_MXL86211C	0xC1335400
 
 #define PHY_CTL1		0x13
 #define PHY_CTL1_MDICD		BIT(3)
@@ -1268,6 +1269,28 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
+		.name		= "Maxlinear Ethernet MxL86211C",
+		.get_features	= genphy_c45_pma_read_abilities,
+		.config_init	= gpy_config_init,
+		.probe		= gpy_probe,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.config_aneg	= gpy_config_aneg,
+		.aneg_done	= genphy_c45_aneg_done,
+		.read_status	= gpy_read_status,
+		.config_intr	= gpy_config_intr,
+		.handle_interrupt = gpy_handle_interrupt,
+		.set_wol	= gpy_set_wol,
+		.get_wol	= gpy_get_wol,
+		.set_loopback	= gpy_loopback,
+		.led_brightness_set = gpy_led_brightness_set,
+		.led_hw_is_supported = gpy_led_hw_is_supported,
+		.led_hw_control_get = gpy_led_hw_control_get,
+		.led_hw_control_set = gpy_led_hw_control_set,
+		.led_polarity_set = gpy_led_polarity_set,
+	},
 };
 module_phy_driver(gpy_drivers);
 
@@ -1284,6 +1307,7 @@ static const struct mdio_device_id __maybe_unused gpy_tbl[] = {
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY241B)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM)},
 	{PHY_ID_MATCH_MODEL(PHY_ID_GPY245B)},
+	{PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C)},
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, gpy_tbl);
-- 
2.52.0

