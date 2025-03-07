Return-Path: <netdev+bounces-173055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680AA57073
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2263B643B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26224889A;
	Fri,  7 Mar 2025 18:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794C24418E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371888; cv=none; b=SxlCvetc5JI1WwUSGsP58RE011WnvhcI5O53fApbleFVH6x/fvl7zm97jMCL4Pg7i8Ba651r+EdmpfZPF2Sf/oOvndfGWLk8ei/qxdHqhKfgH0b9Crr3nDysiRnlV1UeFIlWGehyoqjxwEZ3nn68b+DedxEY71oXQlkAZe/HDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371888; c=relaxed/simple;
	bh=HtupHnKx5taVGtd5zeI40jljUlk4Cylsdbx3BBSYa88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8FRJ4QJk8olbd40mKBe9Ugefruh1XQAIbx3CyO/qlPoLpHUzgxFqhEbUMp+SrtywocE7vADrHNX21nvXMf36mN5nJxl859eE6/vD4qyfStS7mv6nbBk3a4x2HPrjYu4qvBpd8HhdB0bL8aEBmcHJ5PEz6HFyWpR5B5vNDv1P2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005mc-4w; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2U-1m;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I8c-1V;
	Fri, 07 Mar 2025 19:24:33 +0100
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
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 3/7] net: usb: lan78xx: Improve error handling for PHY init path
Date: Fri,  7 Mar 2025 19:24:28 +0100
Message-Id: <20250307182432.1976273-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307182432.1976273-1-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
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
 drivers/net/usb/lan78xx.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 4efe7a956667..68ca507b6412 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2569,31 +2569,40 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 {
 	struct phy_device *phydev;
 	int ret;
-	u32 buf;
 
 	phydev = phy_find_first(dev->mdiobus);
 	if (!phydev) {
 		netdev_dbg(dev->net, "PHY Not Found!! Forcing RGMII configuration\n");
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
 
@@ -2668,7 +2677,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev = phy_find_first(dev->mdiobus);
 		if (!phydev) {
 			netdev_err(dev->net, "no PHY found\n");
-			return -EIO;
+			return -ENODEV;
 		}
 		phydev->is_internal = true;
 		phydev->interface = PHY_INTERFACE_MODE_GMII;
@@ -2676,7 +2685,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	default:
 		netdev_err(dev->net, "Unknown CHIP ID found\n");
-		return -EIO;
+		return -ENODEV;
 	}
 
 	/* if phyirq is not set, use polling mode in phylib */
@@ -2690,10 +2699,15 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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
 
@@ -2706,7 +2720,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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
@@ -2715,7 +2732,9 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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


