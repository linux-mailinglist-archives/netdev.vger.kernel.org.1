Return-Path: <netdev+bounces-181222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D7A8421C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307537AD9FF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59E2857F7;
	Thu, 10 Apr 2025 11:53:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3312853FC
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286000; cv=none; b=Z3ejqy5xInLjm5V6bAfpLHlmwL8aeYOvJycfr7LOcIrs9W68MxbAArJw/mEn+9MrH0/e1SNi9kn76KN7GDUBucTyUemrbfMr++aagwLdQ3qYYCrQT8X8Nq9k++OmYdiE6XttZiXJVaArn0Cc93kJQDU7Wg/aYUGlpiqpzlpr2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286000; c=relaxed/simple;
	bh=EsQWRvOGBerIqrNNOJNZYOyp+Nx6ENzQe+BjgFy9YEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ges0JP1sOi9JYXzpd9b3GNvhqbPMck9OqC1x1f4GBu7p3IFDwLyx4UUpkSj5hwZJHxgorqV1wiZ7jzlNOVuDbB2KKWLb7PKOX80zmD9SGPEGmvbzi1xp//XtRPylWWKccNDmRZOxq1Ochdmm67yogvLD5Eq9EVk54Q5QHWg0NjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSw-0002xs-Pw; Thu, 10 Apr 2025 13:53:06 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSt-004GKx-33;
	Thu, 10 Apr 2025 13:53:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSt-00Akef-2n;
	Thu, 10 Apr 2025 13:53:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 01/12] net: usb: lan78xx: Improve error handling in PHY initialization
Date: Thu, 10 Apr 2025 13:52:51 +0200
Message-Id: <20250410115302.2562562-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410115302.2562562-1-o.rempel@pengutronix.de>
References: <20250410115302.2562562-1-o.rempel@pengutronix.de>
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

Ensure that return values from `lan78xx_write_reg()`,
`lan78xx_read_reg()`, and `phy_find_first()` are properly checked and
propagated. Use `ERR_PTR(ret)` for error reporting in
`lan7801_phy_init()` and replace `-EIO` with `-ENODEV` where appropriate
to provide more accurate error codes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- confirmed with maintainers that fixed_phy_register() leak is acceptable
  as soon as it is fixed within the patch set
changes v5:
- make sure lan7801_phy_init() caller is testing against IS_ERR
  instead of NULL.
changes v4:
- split the patch and move part of it before PHYlink migration
---
 drivers/net/usb/lan78xx.c | 47 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 137adf6d5b08..13b5da18850a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2510,14 +2510,13 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 
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
@@ -2525,30 +2524,40 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
 		if (IS_ERR(phydev)) {
 			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
-			return NULL;
+			return ERR_PTR(-ENODEV);
 		}
 		netdev_dbg(dev->net, "Registered FIXED PHY\n");
 		dev->interface = PHY_INTERFACE_MODE_RGMII;
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
+			return ERR_PTR(-EINVAL);
 		}
 		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
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
 
@@ -2562,9 +2571,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	switch (dev->chipid) {
 	case ID_REV_CHIP_ID_7801_:
 		phydev = lan7801_phy_init(dev);
-		if (!phydev) {
-			netdev_err(dev->net, "lan7801: PHY Init Failed");
-			return -EIO;
+		if (IS_ERR(phydev)) {
+			netdev_err(dev->net, "lan7801: failed to init PHY: %pe\n",
+				   phydev);
+			return PTR_ERR(phydev);
 		}
 		break;
 
@@ -2573,7 +2583,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev = phy_find_first(dev->mdiobus);
 		if (!phydev) {
 			netdev_err(dev->net, "no PHY found\n");
-			return -EIO;
+			return -ENODEV;
 		}
 		phydev->is_internal = true;
 		dev->interface = PHY_INTERFACE_MODE_GMII;
@@ -2581,7 +2591,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	default:
 		netdev_err(dev->net, "Unknown CHIP ID found\n");
-		return -EIO;
+		return -ENODEV;
 	}
 
 	/* if phyirq is not set, use polling mode in phylib */
@@ -2633,7 +2643,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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
@@ -2642,7 +2655,9 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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


