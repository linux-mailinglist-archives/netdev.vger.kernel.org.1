Return-Path: <netdev+bounces-109649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64F9294A2
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859D3283769
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2F13BAD7;
	Sat,  6 Jul 2024 15:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83758757E5
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720280562; cv=none; b=LIecezFDLKYjpj2A0QMwfrVspx83XeE4rP3YJ5/iODIR/U0IOqdihOwxNZdht7XmYKzsQejyDisX4um0O5J8nl5P2QZnRgFq04cjSgK5hxHivRCnotNH0VJF0JOY/H3LOg2t4XA8PRpB09LuM0eYLCPzzFjrJj5/czG+VY3U9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720280562; c=relaxed/simple;
	bh=DWLUaXqYP1mg61bu9brJr6ahpMLrmmgFA0Hc/DO8xoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWfs18gfNWuA0IW56xSGeoguAI/2N2rRQSa1pldj+Fuk18W+rxpRo1TErSIm+shZtxqIq2LWJD/TQUAooAgXXJM+Yvv27UHN8ADfjsvTgE7s0/zHvmj9JvgfWysdPQ6TQ6dgbdXnQoJs8zQSVIpNRnlb89Wy5NBLDi5EDZbLHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sQ7Y5-0006YD-MF; Sat, 06 Jul 2024 17:42:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sQ7Y2-007bN9-Sb; Sat, 06 Jul 2024 17:42:02 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sQ7Y2-0066nl-2c;
	Sat, 06 Jul 2024 17:42:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v3 1/1] net: phy: microchip: lan937x: add support for 100BaseTX PHY
Date: Sat,  6 Jul 2024 17:42:01 +0200
Message-Id: <20240706154201.1456098-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Add support of 100BaseTX PHY build in to LAN9371 and LAN9372 switches.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
changes v3:
- add function comments
- split read_status function
- use (ret < 0) instead of (ret)
changes v2:
- move LAN937X_TX code from microchip_t1.c to microchip.c
- add Reviewed-by tags
---
 drivers/net/phy/microchip.c | 126 +++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0b88635f4fbca..d3273bc0da4a1 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -12,8 +12,14 @@
 #include <linux/of.h>
 #include <dt-bindings/net/microchip-lan78xx.h>
 
+#define PHY_ID_LAN937X_TX			0x0007c190
+
+#define LAN937X_MODE_CTRL_STATUS_REG		0x11
+#define LAN937X_AUTOMDIX_EN			BIT(7)
+#define LAN937X_MDI_MODE			BIT(6)
+
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
-#define DRIVER_DESC	"Microchip LAN88XX PHY driver"
+#define DRIVER_DESC	"Microchip LAN88XX/LAN937X TX PHY driver"
 
 struct lan88xx_priv {
 	int	chip_id;
@@ -373,6 +379,115 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	}
 }
 
+/**
+ * lan937x_tx_read_mdix_status - Read the MDIX status for the LAN937x TX PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This function reads the MDIX status of the LAN937x TX PHY and sets the
+ * mdix_ctrl and mdix fields of the phy_device structure accordingly.
+ * Note that MDIX status is not supported in AUTO mode, and will be set
+ * to invalid in such cases.
+ *
+ * Return: 0 on success, a negative error code on failure.
+ */
+static int lan937x_tx_read_mdix_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read(phydev, LAN937X_MODE_CTRL_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	if (ret & LAN937X_AUTOMDIX_EN) {
+		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+		/* MDI/MDIX status is unknown */
+		phydev->mdix = ETH_TP_MDI_INVALID;
+	} else if (ret & LAN937X_MDI_MODE) {
+		phydev->mdix_ctrl = ETH_TP_MDI_X;
+		phydev->mdix = ETH_TP_MDI_X;
+	} else {
+		phydev->mdix_ctrl = ETH_TP_MDI;
+		phydev->mdix = ETH_TP_MDI;
+	}
+
+	return 0;
+}
+
+/**
+ * lan937x_tx_read_status - Read the status for the LAN937x TX PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This function reads the status of the LAN937x TX PHY and updates the
+ * phy_device structure accordingly.
+ *
+ * Return: 0 on success, a negative error code on failure.
+ */
+static int lan937x_tx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	return lan937x_tx_read_mdix_status(phydev);
+}
+
+/**
+ * lan937x_tx_set_mdix - Set the MDIX mode for the LAN937x TX PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This function configures the MDIX mode of the LAN937x TX PHY based on the
+ * mdix_ctrl field of the phy_device structure. The MDIX mode can be set to
+ * MDI (straight-through), MDIX (crossover), or AUTO (auto-MDIX). If the mode
+ * is not recognized, it returns 0 without making any changes.
+ *
+ * Return: 0 on success, a negative error code on failure.
+ */
+static int lan937x_tx_set_mdix(struct phy_device *phydev)
+{
+	u16 val;
+
+	switch (phydev->mdix_ctrl) {
+	case ETH_TP_MDI:
+		val = 0;
+		break;
+	case ETH_TP_MDI_X:
+		val = LAN937X_MDI_MODE;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = LAN937X_AUTOMDIX_EN;
+		break;
+	default:
+		return 0;
+	}
+
+	return phy_modify(phydev, LAN937X_MODE_CTRL_STATUS_REG,
+			  LAN937X_AUTOMDIX_EN | LAN937X_MDI_MODE, val);
+}
+
+/**
+ * lan937x_tx_config_aneg - Configure auto-negotiation and fixed modes for the
+ *                          LAN937x TX PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This function configures the MDIX mode for the LAN937x TX PHY and then
+ * proceeds to configure the auto-negotiation or fixed mode settings
+ * based on the phy_device structure.
+ *
+ * Return: 0 on success, a negative error code on failure.
+ */
+static int lan937x_tx_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = lan937x_tx_set_mdix(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
 static struct phy_driver microchip_phy_driver[] = {
 {
 	.phy_id		= 0x0007c132,
@@ -400,12 +515,21 @@ static struct phy_driver microchip_phy_driver[] = {
 	.set_wol	= lan88xx_set_wol,
 	.read_page	= lan88xx_read_page,
 	.write_page	= lan88xx_write_page,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
+	.name		= "Microchip LAN937x TX",
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+	.config_aneg	= lan937x_tx_config_aneg,
+	.read_status	= lan937x_tx_read_status,
 } };
 
 module_phy_driver(microchip_phy_driver);
 
 static struct mdio_device_id __maybe_unused microchip_tbl[] = {
 	{ 0x0007c132, 0xfffffff2 },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX) },
 	{ }
 };
 
-- 
2.39.2


