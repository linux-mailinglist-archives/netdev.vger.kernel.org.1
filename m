Return-Path: <netdev+bounces-156243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6249A05B35
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1603A67B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83F1FCD11;
	Wed,  8 Jan 2025 12:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435B1FBC8C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338436; cv=none; b=YvhwpNP2eE6Uavp3K7Zq7+xAjxfUWCdTvgZfIwL//hnveF4FVHVuF627KqL7LKONJStNYkZcuMT62TJZKqCJn9wHHdhwhQsGZiBxw7X6P65ExsdxHnjytpETgXvrV3LEC+/4chuCxIyO7d8IPlSlBPD/VKOcjwEwYJmWrEcA3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338436; c=relaxed/simple;
	bh=MQfZq8PGxT7S9D/7J0vVRfREg8F29R9yC7yCNVfLxe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSuaIrGrJlJy3iQ890sFnK3D8th13GRwWWx9IXSfxWoR+4j+8tzzxDmQGkBXHcX21dALcMHMCPI+IfV7IUdpvl9zK0ku8UCiLKlz+Tc5K28fBE/AkvOuJi5u6y5hVc2zHNE1i1VWRuUMgK+gVRI+9ztMvsjDZUZlw80jHTSR1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwR-0002eD-PS; Wed, 08 Jan 2025 13:13:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwP-007W4c-1E;
	Wed, 08 Jan 2025 13:13:42 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwQ-00BHa5-0F;
	Wed, 08 Jan 2025 13:13:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 3/7] net: usb: lan78xx: Improve error handling for PHY init path
Date: Wed,  8 Jan 2025 13:13:37 +0100
Message-Id: <20250108121341.2689130-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121341.2689130-1-o.rempel@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Make sure existing return values are actually used.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d0097d07bcd..dde127d18a07 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2574,22 +2574,24 @@ static const struct phylink_mac_ops lan78xx_phylink_mac_ops = {
 
 static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 {
-	u32 buf;
-	int ret;
 	struct fixed_phy_status fphy_status = {
 		.link = 1,
 		.speed = SPEED_1000,
 		.duplex = DUPLEX_FULL,
 	};
 	struct phy_device *phydev;
+	int ret;
 
 	phydev = phy_find_first(dev->mdiobus);
 	if (!phydev) {
 		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (IS_ERR(phydev)) {
+		if (PTR_ERR_OR_ZERO(phydev)) {
 			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
-			return NULL;
+			if (IS_ERR(phydev))
+				return phydev;
+			else
+				return ERR_PTR(-ENODEV);
 		}
 
 		dev->fixed_phy = phydev;
@@ -2597,24 +2599,34 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		phydev->interface = PHY_INTERFACE_MODE_RGMII;
 		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
 					MAC_RGMII_ID_TXC_DELAY_EN_);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
 		ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
-		ret = lan78xx_read_reg(dev, HW_CFG, &buf);
-		buf |= HW_CFG_CLK125_EN_;
-		buf |= HW_CFG_REFCLK25_EN_;
-		ret = lan78xx_write_reg(dev, HW_CFG, buf);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		ret = lan78xx_update_reg(dev, HW_CFG, HW_CFG_CLK125_EN_ |
+					 HW_CFG_REFCLK25_EN_,
+					 HW_CFG_CLK125_EN_ | HW_CFG_REFCLK25_EN_);
+		if (ret < 0)
+			return ERR_PTR(ret);
 	} else {
 		if (!phydev->drv) {
 			netdev_err(dev->net, "no PHY driver found\n");
-			return NULL;
+			return ERR_PTR(-ENODEV);
 		}
 		phydev->interface = PHY_INTERFACE_MODE_RGMII_ID;
 		/* The PHY driver is responsible to configure proper RGMII
 		 * interface delays. Disable RGMII delays on MAC side.
 		 */
-		lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
+		ret = lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
+		if (ret < 0)
+			return ERR_PTR(ret);
 
 		phydev->is_internal = false;
 	}
+
 	return phydev;
 }
 
@@ -2663,9 +2675,9 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	switch (dev->chipid) {
 	case ID_REV_CHIP_ID_7801_:
 		phydev = lan7801_phy_init(dev);
-		if (!phydev) {
+		if (IS_ERR(phydev)) {
 			netdev_err(dev->net, "lan7801: PHY Init Failed");
-			return -EIO;
+			return PTR_ERR(phydev);
 		}
 		break;
 
@@ -2674,7 +2686,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev = phy_find_first(dev->mdiobus);
 		if (!phydev) {
 			netdev_err(dev->net, "no PHY found\n");
-			return -EIO;
+			return -ENODEV;
 		}
 		phydev->is_internal = true;
 		phydev->interface = PHY_INTERFACE_MODE_INTERNAL;
@@ -2682,7 +2694,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	default:
 		netdev_err(dev->net, "Unknown CHIP ID found\n");
-		return -EIO;
+		return -ENODEV;
 	}
 
 	/* if phyirq is not set, use polling mode in phylib */
@@ -2696,10 +2708,15 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	if (ret) {
 		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
 			   dev->mdiobus->id, ERR_PTR(ret));
-		return -EIO;
+		return ret;
 	}
 
-	phy_suspend(phydev);
+	ret = phy_suspend(phydev);
+	if (ret) {
+		netdev_err(dev->net, "can't suspend PHY, error %pe\n",
+			   ERR_PTR(ret));
+		return ret;
+	}
 
 	phy_support_eee(phydev);
 
@@ -2712,7 +2729,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 						      sizeof(u32));
 		if (len >= 0) {
 			/* Ensure the appropriate LEDs are enabled */
-			lan78xx_read_reg(dev, HW_CFG, &reg);
+			ret = lan78xx_read_reg(dev, HW_CFG, &reg);
+			if (ret < 0)
+				return ret;
+
 			reg &= ~(HW_CFG_LED0_EN_ |
 				 HW_CFG_LED1_EN_ |
 				 HW_CFG_LED2_EN_ |
@@ -2721,7 +2741,9 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 				(len > 1) * HW_CFG_LED1_EN_ |
 				(len > 2) * HW_CFG_LED2_EN_ |
 				(len > 3) * HW_CFG_LED3_EN_;
-			lan78xx_write_reg(dev, HW_CFG, reg);
+			ret = lan78xx_write_reg(dev, HW_CFG, reg);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
2.39.5


