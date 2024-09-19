Return-Path: <netdev+bounces-129010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552297CEA4
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7728B1C20E8E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97A14F13D;
	Thu, 19 Sep 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CAwO+VsI"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72132143736
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779707; cv=none; b=FuHxHxB4i0DvfbCCtvF8MiFEAp6BuqI9JHk8iL3I8aZyJ38uVZ8sGjTI06MrMd+m/Aqmm4lnMlqL8iIYB4xSKR1U2DljSJ9+ZzXUYCW/KZgiN/T2UAvHqH+5YCKegputjn4k1y56vSJOIOREIwL9EY2WITd4ABKGJO3sPbeIuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779707; c=relaxed/simple;
	bh=ycQ7ey+WgT94gD2vrrw2mxJY+77BnneQvMzTEY9ooaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Smi5j9fgC3852Zq7GnAVctTzyB1jNKgW5fQLFNRo0aT5ohLS/RNQFsujJq5OLQHS+4IsK7b9T/mS+a/5BLiaD3Y/RpzaXeutxcf7XVmtziB5VxI/T48uHLnKM8rlaP+I1r8V4wCG9jKkFpYGNVSXHs1aBrNYjSrSH9pbN1MJBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CAwO+VsI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1WEa041161;
	Thu, 19 Sep 2024 16:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779692;
	bh=e0E/kLV2X3vBatqJ+XpTZtidZrjhlegkJyw6w/TXRIo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CAwO+VsIXaRim0OAUzeazjEKoLWdOUQ0g1WEDGeFxxK1cMG/hBp29pI9YP24KzYdr
	 U7k+9DXOjRzC2uEwZPJWP0BO1wlU9sqzFa4QigB1bnCS6dSwfTPn7WMbqXfd8AUDH0
	 6J3eluVOqM9et/5EghSKa34vyat1gsZzJSBvVVsc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1W2K008421;
	Thu, 19 Sep 2024 16:01:32 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:32 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC7098001;
	Thu, 19 Sep 2024 16:01:31 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 3/5] net: phy: dp83tg720: Extending support to DP83TG721 PHY
Date: Thu, 19 Sep 2024 14:01:17 -0700
Message-ID: <d75b772038e37452f262b6c2d87796966f92a18e.1726263095.git.a-reyes1@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1726263095.git.a-reyes1@ti.com>
References: <cover.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The DP83TG721 is the next revision of the DP83TG720 and will share the
same driver. Added PHY_ID and probe funtion to check which version is
being loaded. 

Signed-off-by: Alvaro (Al-vuh-roe) Reyes <a-reyes1@ti.com>
---
 drivers/net/phy/dp83tg720.c | 183 ++++++++++++++++++++++++++++--------
 1 file changed, 146 insertions(+), 37 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index a6f90293aa61..b70802818f3c 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -10,8 +10,8 @@
 
 #include "open_alliance_helpers.h"
 
-#define DP83TG720_PHY_ID			0x2000a284
-
+#define DP83TG720_CS_1_1_PHY_ID				0x2000a284
+#define DP83TG721_CS_1_0_PHY_ID			0x2000a290
 #define MMD1F							0x1f
 #define MMD1							0x1
 
@@ -21,41 +21,41 @@
 #define DP83TG720_LINK_STATUS			BIT(0)
 
 /* TDR Configuration Register (0x1E) */
-#define DP83TG720_TDR_CFG			0x1e
+#define DP83TG720_TDR_CFG				0x1e
 /* 1b = TDR start, 0b = No TDR */
-#define DP83TG720_TDR_START			BIT(15)
+#define DP83TG720_TDR_START				BIT(15)
 /* 1b = TDR auto on link down, 0b = Manual TDR start */
 #define DP83TG720_CFG_TDR_AUTO_RUN		BIT(14)
 /* 1b = TDR done, 0b = TDR in progress */
-#define DP83TG720_TDR_DONE			BIT(1)
+#define DP83TG720_TDR_DONE				BIT(1)
 /* 1b = TDR fail, 0b = TDR success */
-#define DP83TG720_TDR_FAIL			BIT(0)
+#define DP83TG720_TDR_FAIL				BIT(0)
 
-#define DP83TG720_PHY_RESET			0x1f
-#define DP83TG720_HW_RESET			BIT(15)
+#define DP83TG720_PHY_RESET				0x1f
+#define DP83TG720_HW_RESET				BIT(15)
 
-#define DP83TG720_LPS_CFG3			0x18c
+#define DP83TG720_LPS_CFG3				0x18c
 /* Power modes are documented as bit fields but used as values */
 /* Power Mode 0 is Normal mode */
-#define DP83TG720_LPS_CFG3_PWR_MODE_0		BIT(0)
+#define DP83TG720_LPS_CFG3_PWR_MODE_0	BIT(0)
 
 /* Open Aliance 1000BaseT1 compatible HDD.TDR Fault Status Register */
 #define DP83TG720_TDR_FAULT_STATUS		0x30f
 
 /* Register 0x0301: TDR Configuration 2 */
-#define DP83TG720_TDR_CFG2			0x301
+#define DP83TG720_TDR_CFG2				0x301
 
 /* Register 0x0303: TDR Configuration 3 */
-#define DP83TG720_TDR_CFG3			0x303
+#define DP83TG720_TDR_CFG3				0x303
 
 /* Register 0x0304: TDR Configuration 4 */
-#define DP83TG720_TDR_CFG4			0x304
+#define DP83TG720_TDR_CFG4				0x304
 
 /* Register 0x0405: Unknown Register */
 #define DP83TG720_UNKNOWN_0405			0x405
 
 /* Register 0x0576: TDR Master Link Down Control */
-#define DP83TG720_TDR_MASTER_LINK_DOWN		0x576
+#define DP83TG720_TDR_MASTER_LINK_DOWN	0x576
 
 #define DP83TG720_RGMII_DELAY_CTRL		0x602
 /* In RGMII mode, Enable or disable the internal delay for RXD */
@@ -66,11 +66,11 @@
 /* Register 0x083F: Unknown Register */
 #define DP83TG720_UNKNOWN_083F			0x83f
 
-#define DP83TG720_SQI_REG_1			0x871
-#define DP83TG720_SQI_OUT_WORST		GENMASK(7, 5)
-#define DP83TG720_SQI_OUT			GENMASK(3, 1)
+#define DP83TG720_SQI_REG_1				0x871
+#define DP83TG720_SQI_OUT_WORST			GENMASK(7, 5)
+#define DP83TG720_SQI_OUT				GENMASK(3, 1)
 
-#define DP83TG720_SQI_MAX			7
+#define DP83TG720_SQI_MAX				7
 
 /* SGMII CTRL Registers/bits */
 #define DP83TG720_SGMII_CTRL			0x0608
@@ -78,6 +78,54 @@
 #define DP83TG720_SGMII_AUTO_NEG_EN		BIT(0)
 #define DP83TG720_SGMII_EN				BIT(9)
 
+/* Strap Register/bits */
+#define DP83TG720_STRAP					0x045d
+#define DP83TG720_MASTER_MODE			BIT(5)
+#define DP83TG720_RGMII_IS_EN			BIT(12)
+#define DP83TG720_SGMII_IS_EN			BIT(13)
+#define DP83TG720_RX_SHIFT_EN			BIT(14)
+#define DP83TG720_TX_SHIFT_EN			BIT(15)
+
+enum DP83TG720_chip_type {
+	DP83TG720_CS1_1,
+	DP83TG721_CS1,
+};
+
+struct DP83TG720_private {
+	int chip;
+	bool is_master;
+	bool is_rgmii;
+	bool is_sgmii;
+	bool rx_shift;
+	bool tx_shift;
+};
+
+static int dp83tg720_read_straps(struct phy_device *phydev)
+{
+	struct DP83TG720_private *DP83TG720 = phydev->priv;
+	int strap;
+
+	strap = phy_read_mmd(phydev, MMD1F, DP83TG720_STRAP);
+	if (strap < 0)
+		return strap;
+
+	if (strap & DP83TG720_MASTER_MODE)
+		DP83TG720->is_master = true;
+
+	if (strap & DP83TG720_RGMII_IS_EN)
+		DP83TG720->is_rgmii = true;
+
+	if (strap & DP83TG720_SGMII_IS_EN)
+		DP83TG720->is_sgmii = true;
+
+	if (strap & DP83TG720_RX_SHIFT_EN)
+		DP83TG720->rx_shift = true;
+
+	if (strap & DP83TG720_TX_SHIFT_EN)
+		DP83TG720->tx_shift = true;
+
+	return 0;
+};
 
 /**
  * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
@@ -364,32 +412,93 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
-static struct phy_driver dp83tg720_driver[] = {
+static int dp83tg720_probe(struct phy_device *phydev)
 {
-	PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID),
-	.name		= "TI DP83TG720",
-
-	.flags          = PHY_POLL_CABLE_TEST,
-	.config_aneg	= dp83tg720_config_aneg,
-	.read_status	= dp83tg720_read_status,
-	.get_features	= genphy_c45_pma_read_ext_abilities,
-	.config_init	= dp83tg720_config_init,
-	.get_sqi	= dp83tg720_get_sqi,
-	.get_sqi_max	= dp83tg720_get_sqi_max,
-	.cable_test_start = dp83tg720_cable_test_start,
-	.cable_test_get_status = dp83tg720_cable_test_get_status,
-
-	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
-} };
+	struct DP83TG720_private *DP83TG720;
+	int ret;
+
+	DP83TG720 = devm_kzalloc(&phydev->mdio.dev, sizeof(*DP83TG720),
+			       GFP_KERNEL);
+	if (!DP83TG720)
+		return -ENOMEM;
+
+	phydev->priv = DP83TG720;
+
+	ret = dp83tg720_read_straps(phydev);
+	if (ret)
+		return ret;
+
+	switch (phydev->phy_id) {
+	case DP83TG720_CS_1_1_PHY_ID:
+		DP83TG720->chip = DP83TG720_CS1_1;
+		break;
+	case DP83TG721_CS_1_0_PHY_ID:
+		DP83TG720->chip = DP83TG721_CS1;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return dp83tg720_config_init(phydev);
+}
+
+#define DP83TG720_PHY_DRIVER(_id, _name)                                \
+{                                                                       \
+    PHY_ID_MATCH_EXACT(_id),                                            \
+    .name                   = (_name),                                  \
+    .probe                  = dp83tg720_probe,                          \
+    .flags                  = PHY_POLL_CABLE_TEST,                      \
+    .config_aneg            = dp83tg720_config_aneg,                    \
+    .read_status            = dp83tg720_read_status,                    \
+    .get_features           = genphy_c45_pma_read_ext_abilities,        \
+    .config_init            = dp83tg720_config_init,                    \
+    .get_sqi                = dp83tg720_get_sqi,                        \
+    .get_sqi_max            = dp83tg720_get_sqi_max,                    \
+    .cable_test_start       = dp83tg720_cable_test_start,               \
+    .cable_test_get_status  = dp83tg720_cable_test_get_status,          \
+    .suspend                = genphy_suspend,                           \
+    .resume                 = genphy_resume,                            \
+}
+
+static struct phy_driver dp83tg720_driver[] = {
+    DP83TG720_PHY_DRIVER(DP83TG720_CS_1_1_PHY_ID, "TI DP83TG720CS1.1"),
+	DP83TG720_PHY_DRIVER(DP83TG721_CS_1_0_PHY_ID, "TI DP83TG721CS1.0"),
+};
 module_phy_driver(dp83tg720_driver);
 
 static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
-	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
-	{ }
+    { PHY_ID_MATCH_EXACT(DP83TG720_CS_1_1_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(DP83TG721_CS_1_0_PHY_ID) },
+	{ },
 };
 MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
 
+// static struct phy_driver dp83tg720_driver[] = {
+// {
+// 	PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID),
+// 	.name		= "TI DP83TG720",
+
+// 	.flags          = PHY_POLL_CABLE_TEST,
+// 	.config_aneg	= dp83tg720_config_aneg,
+// 	.read_status	= dp83tg720_read_status,
+// 	.get_features	= genphy_c45_pma_read_ext_abilities,
+// 	.config_init	= dp83tg720_config_init,
+// 	.get_sqi	= dp83tg720_get_sqi,
+// 	.get_sqi_max	= dp83tg720_get_sqi_max,
+// 	.cable_test_start = dp83tg720_cable_test_start,
+// 	.cable_test_get_status = dp83tg720_cable_test_get_status,
+
+// 	.suspend	= genphy_suspend,
+// 	.resume		= genphy_resume,
+// } };
+// module_phy_driver(dp83tg720_driver);
+
+// static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
+// 	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
+// 	{ }
+// };
+// MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
+
 MODULE_DESCRIPTION("Texas Instruments DP83TG720 PHY driver");
 MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
 MODULE_LICENSE("GPL");
-- 
2.17.1


