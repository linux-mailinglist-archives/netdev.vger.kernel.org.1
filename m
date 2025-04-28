Return-Path: <netdev+bounces-186441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21920A9F1C1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A8B5A52AD
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8092741C6;
	Mon, 28 Apr 2025 13:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521D26F475
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845558; cv=none; b=NZBtjPufLan4s4e9PYnfQEB4EqEMkBiVMix1SgweUk38vYd0VvEPTfCAFq7/lmEYNOohVymmDiqfE3WvaPDzP3wgDqmclPmM2HLg62a9luoW6d0+MgHy+601mtDSA5fRFFFRcCNMGJ/Jf+PigMMr8lquC2kITkDbH09pMqbi/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845558; c=relaxed/simple;
	bh=5URiGYR5zlAEfTrePIZ8K4h++6AoVHBDIfSU+U1wtuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upGOh/6/UZl1d1heGvjkNnlaMXAZYk5Om5k69aAiuLNFXNTRqti+Tih91kAU/AF7Euym7EWHSJmH2XfLThnUEGvmsiwcYWSiHF3qZneSLpioJ9pb9xgLIzo7g9Q6hoLfBcM7rHIKMDGea7AmFiF7MWaHaBO4m60Kb8N2eMvrhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB7-0000MQ-L7; Mon, 28 Apr 2025 15:05:45 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-0006FM-0Y;
	Mon, 28 Apr 2025 15:05:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-00GJ7J-0J;
	Mon, 28 Apr 2025 15:05:44 +0200
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
Subject: [PATCH net-next v7 03/12] net: usb: lan78xx: refactor PHY init to separate detection and MAC configuration
Date: Mon, 28 Apr 2025 15:05:33 +0200
Message-Id: <20250428130542.3879769-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428130542.3879769-1-o.rempel@pengutronix.de>
References: <20250428130542.3879769-1-o.rempel@pengutronix.de>
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


