Return-Path: <netdev+bounces-109226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18C927791
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A087E1C23312
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94F1AEFE5;
	Thu,  4 Jul 2024 13:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB1AE852
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101548; cv=none; b=An9D5eIiJrk3EoVq2/EWo8QTirFs+VE6QSCyzD1+9ROtB9WrXmiuL7jjIE/SgXnbM+WdLHv9Puw6ny6Phgtws9iFDdJc2q0pM6Pyyo+sZ3+F1YbCBpGVFXNAYk1m5mF7sRsG37S/QTs5qsD0XAv92mfYtYfqdl3E6ZaOKBmoZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101548; c=relaxed/simple;
	bh=AdrH1yAP4BQS3OHXaXlsGgtbCEKl4ndO+e9riIcJhIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgyyB/bE6xCkQFsJX8rjd2pP/ERG+CYxO+2xRpglMJCwq4PKjDB5G1dYdKQgtOwk/4nlDRQZcKcXeNfe1kujqNitrB0dxtfCvvwL+rH8BQTEhYcJbBSDURSHI3J14qWmm38ZQYnOnuJRnzENHzlS304rG44dhtMUC+tFZ0IHRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPMz7-00029i-Bl; Thu, 04 Jul 2024 15:58:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPMz5-0076Us-SF; Thu, 04 Jul 2024 15:58:51 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPMz5-00GWo5-2a;
	Thu, 04 Jul 2024 15:58:51 +0200
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add support for 100BaseTX PHY
Date: Thu,  4 Jul 2024 15:58:50 +0200
Message-Id: <20240704135850.3939342-1-o.rempel@pengutronix.de>
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
---
 drivers/net/phy/microchip_t1.c | 74 ++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a35528497a576..c7ca0d04b9e1b 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -12,6 +12,7 @@
 
 #define PHY_ID_LAN87XX				0x0007c150
 #define PHY_ID_LAN937X				0x0007c180
+#define PHY_ID_LAN937X_TX			0x0007c190
 
 /* External Register Control Register */
 #define LAN87XX_EXT_REG_CTL                     (0x14)
@@ -94,6 +95,10 @@
 /* SQI defines */
 #define LAN87XX_MAX_SQI			0x07
 
+#define LAN937X_MODE_CTRL_STATUS_REG	0x11
+#define LAN937X_AUTOMDIX_EN		BIT(7)
+#define LAN937X_MDI_MODE		BIT(6)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x T1 PHY driver"
 
@@ -860,6 +865,66 @@ static int lan87xx_get_sqi_max(struct phy_device *phydev)
 	return LAN87XX_MAX_SQI;
 }
 
+static int lan937x_tx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
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
+static int lan937x_tx_config_mdix(struct phy_device *phydev, u8 ctrl)
+{
+	u16 val;
+
+	switch (ctrl) {
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
+static int lan937x_tx_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -894,6 +959,14 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.get_sqi_max	= lan87xx_get_sqi_max,
 		.cable_test_start = lan87xx_cable_test_start,
 		.cable_test_get_status = lan87xx_cable_test_get_status,
+	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
+		.name		= "Microchip LAN937x TX",
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.config_aneg	= lan937x_tx_config_aneg,
+		.read_status	= lan937x_tx_read_status,
 	}
 };
 
@@ -902,6 +975,7 @@ module_phy_driver(microchip_t1_phy_driver);
 static struct mdio_device_id __maybe_unused microchip_t1_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX) },
 	{ }
 };
 
-- 
2.39.2


