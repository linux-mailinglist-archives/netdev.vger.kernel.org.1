Return-Path: <netdev+bounces-109395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2D92843F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810471C23E68
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33595146593;
	Fri,  5 Jul 2024 08:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB7145FE0
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169766; cv=none; b=drcI+w+TOzkqZM+++dMVupinTICWpzm61egvaBYiNIhood3j/3njqE++qiGaHtHpngQq/fGtzqudJJTTjD7heHzcDflR0sAfMarhQXTMjWqXr7zyxadhPXH70nhL+Y9BKpr8P7hGccxhIpOPrIElWX5dCqgXdU8e/g/te/OmQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169766; c=relaxed/simple;
	bh=nbkxxK6UGd7Kt1FEcuVHaHCYrmPKcTQpdZE4mLL5gMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gqp/ng5BszmcFV7OKv6WKECy0yD8Vmj1H955sTHRk2tL2yjKHTg3IXsT+nlsb20fe7pujCb6REWl/E/p8+CukcOh03Wf7XFMKAbPUorAfO1opQ2iS3Sd+M1FmQqh3nP+6QqlJJyEbFI2zX1mFlNEqCxE4GjV/OqOTlj3D/HFpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPejR-0004U6-6p; Fri, 05 Jul 2024 10:55:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPejQ-007Hr7-3C; Fri, 05 Jul 2024 10:55:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPejQ-000MYL-05;
	Fri, 05 Jul 2024 10:55:52 +0200
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
Subject: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add support for 100BaseTX PHY
Date: Fri,  5 Jul 2024 10:55:50 +0200
Message-Id: <20240705085550.86678-1-o.rempel@pengutronix.de>
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
changes v2:
- move LAN937X_TX code from microchip_t1.c to microchip.c
- add Reviewed-by tags
---
 drivers/net/phy/microchip.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0b88635f4fbca..b46d5d43e2585 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -12,6 +12,12 @@
 #include <linux/of.h>
 #include <dt-bindings/net/microchip-lan78xx.h>
 
+#define PHY_ID_LAN937X_TX			0x0007c190
+
+#define LAN937X_MODE_CTRL_STATUS_REG		0x11
+#define LAN937X_AUTOMDIX_EN			BIT(7)
+#define LAN937X_MDI_MODE			BIT(6)
+
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN88XX PHY driver"
 
@@ -373,6 +379,66 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	}
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
 static struct phy_driver microchip_phy_driver[] = {
 {
 	.phy_id		= 0x0007c132,
@@ -400,12 +466,21 @@ static struct phy_driver microchip_phy_driver[] = {
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


