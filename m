Return-Path: <netdev+bounces-187686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A701BAA8E78
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B683B8177
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9D1F5430;
	Mon,  5 May 2025 08:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4771F75A9
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434635; cv=none; b=NRhatNyPmZBpIjQli3i0cCUo3dqygB56FUzFZp8RH7Ehh90DVwZj/1/BaIEOdDW443ayasZs+470CkP7y2th7oBmeT8O+ToBy8o5sq6D6W2T+TfK38mncZKddUm1SVUCTiUw1GEEoX+Kkmvpsw67XCW0nAjMHcX9XkJNI6DloBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434635; c=relaxed/simple;
	bh=5URiGYR5zlAEfTrePIZ8K4h++6AoVHBDIfSU+U1wtuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcBdBmrXXL4wxzlEHe2qyBo+G4wKHlAUnIfmYbfpw45DGZskzg9a4Z8dP4K9aF79Cx4PpoXL5iSb2S58vx+WqDtHr05FQMAtnPf3lhbE7sPadCKDzppI/NDD3tajLQ3H6oD68hxkbWXIACcSLg4tsIsiMSKlTKI5xVpWn2ntioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQN-0005W8-Al; Mon, 05 May 2025 10:43:43 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-001CSC-1M;
	Mon, 05 May 2025 10:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-003SQ5-11;
	Mon, 05 May 2025 10:43:42 +0200
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
Subject: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to separate detection and MAC configuration
Date: Mon,  5 May 2025 10:43:37 +0200
Message-Id: <20250505084341.824165-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505084341.824165-1-o.rempel@pengutronix.de>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Split out PHY detection into lan78xx_get_phy() and MAC-side setup into
lan78xx_mac_prepare_for_phy(), making the main lan78xx_phy_init() cleaner
and easier to follow.

This improves separation of concerns and prepares the code for a future
transition to phylink. Fixed PHY registration and interface selection
are now handled in lan78xx_get_phy(), while MAC-side delay configuration
is done in lan78xx_mac_prepare_for_phy().

The fixed PHY fallback is preserved for setups like EVB-KSZ9897-1,
where LAN7801 connects directly to a KSZ switch without a standard PHY
or device tree support.

No functional changes intended.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 174 ++++++++++++++++++++++++++++----------
 1 file changed, 128 insertions(+), 46 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 9c0658227bde..7f1ecc415d53 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2508,53 +2508,145 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
-static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
+/**
+ * lan78xx_register_fixed_phy() - Register a fallback fixed PHY
+ * @dev: LAN78xx device
+ *
+ * Registers a fixed PHY with 1 Gbps full duplex. This is used in special cases
+ * like EVB-KSZ9897-1, where LAN7801 acts as a USB-to-Ethernet interface to a
+ * switch without a visible PHY.
+ *
+ * Return: pointer to the registered fixed PHY, or ERR_PTR() on error.
+ */
+static struct phy_device *lan78xx_register_fixed_phy(struct lan78xx_net *dev)
 {
 	struct fixed_phy_status fphy_status = {
 		.link = 1,
 		.speed = SPEED_1000,
 		.duplex = DUPLEX_FULL,
 	};
+
+	netdev_info(dev->net,
+		    "No PHY found on LAN7801 – registering fixed PHY (e.g. EVB-KSZ9897-1)\n");
+
+	return fixed_phy_register(PHY_POLL, &fphy_status, NULL);
+}
+
+/**
+ * lan78xx_get_phy() - Probe or register PHY device and set interface mode
+ * @dev: LAN78xx device structure
+ *
+ * This function attempts to find a PHY on the MDIO bus. If no PHY is found
+ * and the chip is LAN7801, it registers a fixed PHY as fallback. It also
+ * sets dev->interface based on chip ID and detected PHY type.
+ *
+ * Return: a valid PHY device pointer, or ERR_PTR() on failure.
+ */
+static struct phy_device *lan78xx_get_phy(struct lan78xx_net *dev)
+{
 	struct phy_device *phydev;
-	int ret;
 
+	/* Attempt to locate a PHY on the MDIO bus */
 	phydev = phy_find_first(dev->mdiobus);
-	if (!phydev) {
-		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
-		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (IS_ERR(phydev)) {
-			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
-			return ERR_PTR(-ENODEV);
+
+	switch (dev->chipid) {
+	case ID_REV_CHIP_ID_7801_:
+		if (phydev) {
+			/* External RGMII PHY detected */
+			dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
+			phydev->is_internal = false;
+
+			if (!phydev->drv)
+				netdev_warn(dev->net,
+					    "PHY driver not found – assuming RGMII delays are on PCB or strapped for the PHY\n");
+
+			return phydev;
 		}
-		netdev_dbg(dev->net, "Registered FIXED PHY\n");
+
 		dev->interface = PHY_INTERFACE_MODE_RGMII;
+		/* No PHY found – fallback to fixed PHY (e.g. KSZ switch board) */
+		return lan78xx_register_fixed_phy(dev);
+
+	case ID_REV_CHIP_ID_7800_:
+	case ID_REV_CHIP_ID_7850_:
+		if (!phydev)
+			return ERR_PTR(-ENODEV);
+
+		/* These use internal GMII-connected PHY */
+		dev->interface = PHY_INTERFACE_MODE_GMII;
+		phydev->is_internal = true;
+		return phydev;
+
+	default:
+		netdev_err(dev->net, "Unknown CHIP ID: 0x%08x\n", dev->chipid);
+		return ERR_PTR(-ENODEV);
+	}
+}
+
+/**
+ * lan78xx_mac_prepare_for_phy() - Preconfigure MAC-side interface settings
+ * @dev: LAN78xx device
+ *
+ * Configure MAC-side registers according to dev->interface, which should be
+ * set by lan78xx_get_phy().
+ *
+ * - For PHY_INTERFACE_MODE_RGMII:
+ *   Enable MAC-side TXC delay. This mode seems to be used in a special setup
+ *   without a real PHY, likely on EVB-KSZ9897-1. In that design, LAN7801 is
+ *   connected to the KSZ9897 switch, and the link timing is expected to be
+ *   hardwired (e.g. via strapping or board layout). No devicetree support is
+ *   assumed here.
+ *
+ * - For PHY_INTERFACE_MODE_RGMII_ID:
+ *   Disable MAC-side delay and rely on the PHY driver to provide delay.
+ *
+ * - For GMII, no MAC-specific config is needed.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static int lan78xx_mac_prepare_for_phy(struct lan78xx_net *dev)
+{
+	int ret;
+
+	switch (dev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		/* Enable MAC-side TX clock delay */
 		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
 					MAC_RGMII_ID_TXC_DELAY_EN_);
 		if (ret < 0)
-			return ERR_PTR(ret);
+			return ret;
 
 		ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
 		if (ret < 0)
-			return ERR_PTR(ret);
+			return ret;
 
-		ret = lan78xx_update_reg(dev, HW_CFG, HW_CFG_CLK125_EN_ |
-					 HW_CFG_REFCLK25_EN_,
+		ret = lan78xx_update_reg(dev, HW_CFG,
+					 HW_CFG_CLK125_EN_ | HW_CFG_REFCLK25_EN_,
 					 HW_CFG_CLK125_EN_ | HW_CFG_REFCLK25_EN_);
 		if (ret < 0)
-			return ERR_PTR(ret);
-	} else {
-		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
-		/* The PHY driver is responsible to configure proper RGMII
-		 * interface delays. Disable RGMII delays on MAC side.
-		 */
+			return ret;
+
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		/* Disable MAC-side TXC delay, PHY provides it */
 		ret = lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
 		if (ret < 0)
-			return ERR_PTR(ret);
+			return ret;
 
-		phydev->is_internal = false;
+		break;
+
+	case PHY_INTERFACE_MODE_GMII:
+		/* No MAC-specific configuration required */
+		break;
+
+	default:
+		netdev_warn(dev->net, "Unsupported interface mode: %d\n",
+			    dev->interface);
+		break;
 	}
 
-	return phydev;
+	return 0;
 }
 
 static int lan78xx_phy_init(struct lan78xx_net *dev)
@@ -2564,31 +2656,13 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	u32 mii_adv;
 	struct phy_device *phydev;
 
-	switch (dev->chipid) {
-	case ID_REV_CHIP_ID_7801_:
-		phydev = lan7801_phy_init(dev);
-		if (IS_ERR(phydev)) {
-			netdev_err(dev->net, "lan7801: failed to init PHY: %pe\n",
-				   phydev);
-			return PTR_ERR(phydev);
-		}
-		break;
-
-	case ID_REV_CHIP_ID_7800_:
-	case ID_REV_CHIP_ID_7850_:
-		phydev = phy_find_first(dev->mdiobus);
-		if (!phydev) {
-			netdev_err(dev->net, "no PHY found\n");
-			return -ENODEV;
-		}
-		phydev->is_internal = true;
-		dev->interface = PHY_INTERFACE_MODE_GMII;
-		break;
+	phydev = lan78xx_get_phy(dev);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
 
-	default:
-		netdev_err(dev->net, "Unknown CHIP ID found\n");
-		return -ENODEV;
-	}
+	ret = lan78xx_mac_prepare_for_phy(dev);
+	if (ret < 0)
+		goto free_phy;
 
 	/* if phyirq is not set, use polling mode in phylib */
 	if (dev->domain_data.phyirq > 0)
@@ -2662,6 +2736,14 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	dev->fc_autoneg = phydev->autoneg;
 
 	return 0;
+
+free_phy:
+	if (phy_is_pseudo_fixed_link(phydev)) {
+		fixed_phy_unregister(phydev);
+		phy_device_free(phydev);
+	}
+
+	return ret;
 }
 
 static int lan78xx_set_rx_max_frame_length(struct lan78xx_net *dev, int size)
-- 
2.39.5


