Return-Path: <netdev+bounces-129007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B493E97CEA1
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764E728475A
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE7140E5F;
	Thu, 19 Sep 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fqbwaw6p"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50743AA1
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779706; cv=none; b=pA8Y2wWLi4TcoH78SrjYF6KRVQdnt7tHm0WfhPmfBGLLeCYn8XUPYINvU3fyKEH3akNwmDSzsrnTbTLb6iDYWFvBgBQ2McGvL8/Vf+12OwocBgHF3ZtQ7+xXIrmgbiFR7XlI80cXBNw1xExTRMsiR6MOItYdX1kZfwWO+zHq48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779706; c=relaxed/simple;
	bh=IgOLremkTluc+1bSUyBYBWgKXFJo2qRE+So66OXoPno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ2/maxy3nr1azZFOFI+4x7FQkJlCjgF55wsAPpMN6ZByh2OtF++0of1HWsRa8IAoL5fj75kKmI4vIRr8ZRGXDEM1LQarSlSMRW5VQt+pANsfDw7oSpiCFipD7Uz2WTOPtwJtIyAa4fpOQS288pWMzm4GYdR2zPP1ohE3RYe7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fqbwaw6p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1RYX000574;
	Thu, 19 Sep 2024 16:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779687;
	bh=TrC7QeET0mtJuUfj3JjOJwoOOv+aq3YydRXmnQ4tVpY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Fqbwaw6pgvhzomvYolRrlWjoJy50alCHheZMG5pBTxypUeGihYrbzts1AlGfghX/I
	 hqo1jSF9uCghclOaVs+24dDQEJhuv8ViAejgxhIXMwAb56IMavHjHIgU3T+dhtHTX3
	 UOooA9/5gtcW1Lfoq149nEaIzRfge3unNJKJCUQQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JL1RFe064365
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 16:01:27 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:26 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC5098001;
	Thu, 19 Sep 2024 16:01:26 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 1/5] net: phy: dp83tg720: Changed Macro names
Date: Thu, 19 Sep 2024 14:01:15 -0700
Message-ID: <b9ae5a74361c80becc446775258c06154e00be1d.1726263095.git.a-reyes1@ti.com>
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

Previous macro referes to DP83TG720S, where this driver works for both
DP83TG720R & DP83TG720S. Macro changed to DP83TG720 to be more generic.

Data sheets:
https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
https://www.ti.com/lit/ds/symlink/dp83tg720r-q1.pdf

Signed-off-by: Alvaro (Al-vuh-roe) Reyes <a-reyes1@ti.com>
---
 drivers/net/phy/dp83tg720.c | 116 ++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 0ef4d7dba065..7e81800cfc5b 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -10,62 +10,62 @@
 
 #include "open_alliance_helpers.h"
 
-#define DP83TG720S_PHY_ID			0x2000a284
+#define DP83TG720_PHY_ID			0x2000a284
 
 /* MDIO_MMD_VEND2 registers */
-#define DP83TG720S_MII_REG_10			0x10
-#define DP83TG720S_STS_MII_INT			BIT(7)
-#define DP83TG720S_LINK_STATUS			BIT(0)
+#define DP83TG720_MII_REG_10			0x10
+#define DP83TG720_STS_MII_INT			BIT(7)
+#define DP83TG720_LINK_STATUS			BIT(0)
 
 /* TDR Configuration Register (0x1E) */
-#define DP83TG720S_TDR_CFG			0x1e
+#define DP83TG720_TDR_CFG			0x1e
 /* 1b = TDR start, 0b = No TDR */
-#define DP83TG720S_TDR_START			BIT(15)
+#define DP83TG720_TDR_START			BIT(15)
 /* 1b = TDR auto on link down, 0b = Manual TDR start */
-#define DP83TG720S_CFG_TDR_AUTO_RUN		BIT(14)
+#define DP83TG720_CFG_TDR_AUTO_RUN		BIT(14)
 /* 1b = TDR done, 0b = TDR in progress */
-#define DP83TG720S_TDR_DONE			BIT(1)
+#define DP83TG720_TDR_DONE			BIT(1)
 /* 1b = TDR fail, 0b = TDR success */
-#define DP83TG720S_TDR_FAIL			BIT(0)
+#define DP83TG720_TDR_FAIL			BIT(0)
 
-#define DP83TG720S_PHY_RESET			0x1f
-#define DP83TG720S_HW_RESET			BIT(15)
+#define DP83TG720_PHY_RESET			0x1f
+#define DP83TG720_HW_RESET			BIT(15)
 
-#define DP83TG720S_LPS_CFG3			0x18c
+#define DP83TG720_LPS_CFG3			0x18c
 /* Power modes are documented as bit fields but used as values */
 /* Power Mode 0 is Normal mode */
-#define DP83TG720S_LPS_CFG3_PWR_MODE_0		BIT(0)
+#define DP83TG720_LPS_CFG3_PWR_MODE_0		BIT(0)
 
 /* Open Aliance 1000BaseT1 compatible HDD.TDR Fault Status Register */
-#define DP83TG720S_TDR_FAULT_STATUS		0x30f
+#define DP83TG720_TDR_FAULT_STATUS		0x30f
 
 /* Register 0x0301: TDR Configuration 2 */
-#define DP83TG720S_TDR_CFG2			0x301
+#define DP83TG720_TDR_CFG2			0x301
 
 /* Register 0x0303: TDR Configuration 3 */
-#define DP83TG720S_TDR_CFG3			0x303
+#define DP83TG720_TDR_CFG3			0x303
 
 /* Register 0x0304: TDR Configuration 4 */
-#define DP83TG720S_TDR_CFG4			0x304
+#define DP83TG720_TDR_CFG4			0x304
 
 /* Register 0x0405: Unknown Register */
-#define DP83TG720S_UNKNOWN_0405			0x405
+#define DP83TG720_UNKNOWN_0405			0x405
 
 /* Register 0x0576: TDR Master Link Down Control */
-#define DP83TG720S_TDR_MASTER_LINK_DOWN		0x576
+#define DP83TG720_TDR_MASTER_LINK_DOWN		0x576
 
-#define DP83TG720S_RGMII_DELAY_CTRL		0x602
+#define DP83TG720_RGMII_DELAY_CTRL		0x602
 /* In RGMII mode, Enable or disable the internal delay for RXD */
-#define DP83TG720S_RGMII_RX_CLK_SEL		BIT(1)
+#define DP83TG720_RGMII_RX_CLK_SEL		BIT(1)
 /* In RGMII mode, Enable or disable the internal delay for TXD */
-#define DP83TG720S_RGMII_TX_CLK_SEL		BIT(0)
+#define DP83TG720_RGMII_TX_CLK_SEL		BIT(0)
 
 /* Register 0x083F: Unknown Register */
-#define DP83TG720S_UNKNOWN_083F			0x83f
+#define DP83TG720_UNKNOWN_083F			0x83f
 
-#define DP83TG720S_SQI_REG_1			0x871
-#define DP83TG720S_SQI_OUT_WORST		GENMASK(7, 5)
-#define DP83TG720S_SQI_OUT			GENMASK(3, 1)
+#define DP83TG720_SQI_REG_1			0x871
+#define DP83TG720_SQI_OUT_WORST		GENMASK(7, 5)
+#define DP83TG720_SQI_OUT			GENMASK(3, 1)
 
 #define DP83TG720_SQI_MAX			7
 
@@ -82,7 +82,7 @@ static int dp83tg720_cable_test_start(struct phy_device *phydev)
 	int ret;
 
 	/* Initialize the PHY to run the TDR test as described in the
-	 * "DP83TG720S-Q1: Configuring for Open Alliance Specification
+	 * "DP83TG720-Q1: Configuring for Open Alliance Specification
 	 * Compliance (Rev. B)" application note.
 	 * Most of the registers are not documented. Some of register names
 	 * are guessed by comparing the register offsets with the DP83TD510E.
@@ -90,38 +90,38 @@ static int dp83tg720_cable_test_start(struct phy_device *phydev)
 
 	/* Force master link down */
 	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
-			       DP83TG720S_TDR_MASTER_LINK_DOWN, 0x0400);
+			       DP83TG720_TDR_MASTER_LINK_DOWN, 0x0400);
 	if (ret)
 		return ret;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG2,
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_TDR_CFG2,
 			    0xa008);
 	if (ret)
 		return ret;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG3,
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_TDR_CFG3,
 			    0x0928);
 	if (ret)
 		return ret;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG4,
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_TDR_CFG4,
 			    0x0004);
 	if (ret)
 		return ret;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_UNKNOWN_0405,
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_UNKNOWN_0405,
 			    0x6400);
 	if (ret)
 		return ret;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_UNKNOWN_083F,
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_UNKNOWN_083F,
 			    0x3003);
 	if (ret)
 		return ret;
 
 	/* Start the TDR */
-	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG,
-			       DP83TG720S_TDR_START);
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_TDR_CFG,
+			       DP83TG720_TDR_START);
 	if (ret)
 		return ret;
 
@@ -146,21 +146,21 @@ static int dp83tg720_cable_test_get_status(struct phy_device *phydev,
 	*finished = false;
 
 	/* Read the TDR status */
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG);
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_TDR_CFG);
 	if (ret < 0)
 		return ret;
 
 	/* Check if the TDR test is done */
-	if (!(ret & DP83TG720S_TDR_DONE))
+	if (!(ret & DP83TG720_TDR_DONE))
 		return 0;
 
 	/* Check for TDR test failure */
-	if (!(ret & DP83TG720S_TDR_FAIL)) {
+	if (!(ret & DP83TG720_TDR_FAIL)) {
 		int location;
 
 		/* Read fault status */
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-				   DP83TG720S_TDR_FAULT_STATUS);
+				   DP83TG720_TDR_FAULT_STATUS);
 		if (ret < 0)
 			return ret;
 
@@ -214,8 +214,8 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 	/* Most of Clause 45 registers are not present, so we can't use
 	 * genphy_c45_read_status() here.
 	 */
-	phy_sts = phy_read(phydev, DP83TG720S_MII_REG_10);
-	phydev->link = !!(phy_sts & DP83TG720S_LINK_STATUS);
+	phy_sts = phy_read(phydev, DP83TG720_MII_REG_10);
+	phydev->link = !!(phy_sts & DP83TG720_LINK_STATUS);
 	if (!phydev->link) {
 		/* According to the "DP83TC81x, DP83TG72x Software
 		 * Implementation Guide", the PHY needs to be reset after a
@@ -261,11 +261,11 @@ static int dp83tg720_get_sqi(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_SQI_REG_1);
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_SQI_REG_1);
 	if (ret < 0)
 		return ret;
 
-	return FIELD_GET(DP83TG720S_SQI_OUT, ret);
+	return FIELD_GET(DP83TG720_SQI_OUT, ret);
 }
 
 static int dp83tg720_get_sqi_max(struct phy_device *phydev)
@@ -283,24 +283,24 @@ static int dp83tg720_config_rgmii_delay(struct phy_device *phydev)
 		rgmii_delay = 0;
 		break;
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rgmii_delay = DP83TG720S_RGMII_RX_CLK_SEL |
-				DP83TG720S_RGMII_TX_CLK_SEL;
+		rgmii_delay = DP83TG720_RGMII_RX_CLK_SEL |
+				DP83TG720_RGMII_TX_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		rgmii_delay = DP83TG720S_RGMII_RX_CLK_SEL;
+		rgmii_delay = DP83TG720_RGMII_RX_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		rgmii_delay = DP83TG720S_RGMII_TX_CLK_SEL;
+		rgmii_delay = DP83TG720_RGMII_TX_CLK_SEL;
 		break;
 	default:
 		return 0;
 	}
 
-	rgmii_delay_mask = DP83TG720S_RGMII_RX_CLK_SEL |
-		DP83TG720S_RGMII_TX_CLK_SEL;
+	rgmii_delay_mask = DP83TG720_RGMII_RX_CLK_SEL |
+		DP83TG720_RGMII_TX_CLK_SEL;
 
 	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
-			      DP83TG720S_RGMII_DELAY_CTRL, rgmii_delay_mask,
+			      DP83TG720_RGMII_DELAY_CTRL, rgmii_delay_mask,
 			      rgmii_delay);
 }
 
@@ -311,12 +311,12 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	/* Software Restart is not enough to recover from a link failure.
 	 * Using Hardware Reset instead.
 	 */
-	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	ret = phy_write(phydev, DP83TG720_PHY_RESET, DP83TG720_HW_RESET);
 	if (ret)
 		return ret;
 
 	/* Wait until MDC can be used again.
-	 * The wait value of one 1ms is documented in "DP83TG720S-Q1 1000BASE-T1
+	 * The wait value of one 1ms is documented in "DP83TG720-Q1 1000BASE-T1
 	 * Automotive Ethernet PHY with SGMII and RGMII" datasheet.
 	 */
 	usleep_range(1000, 2000);
@@ -330,8 +330,8 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	/* In case the PHY is bootstrapped in managed mode, we need to
 	 * wake it.
 	 */
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LPS_CFG3,
-			    DP83TG720S_LPS_CFG3_PWR_MODE_0);
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720_LPS_CFG3,
+			    DP83TG720_LPS_CFG3_PWR_MODE_0);
 	if (ret)
 		return ret;
 
@@ -343,8 +343,8 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 
 static struct phy_driver dp83tg720_driver[] = {
 {
-	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
-	.name		= "TI DP83TG720S",
+	PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID),
+	.name		= "TI DP83TG720",
 
 	.flags          = PHY_POLL_CABLE_TEST,
 	.config_aneg	= dp83tg720_config_aneg,
@@ -362,11 +362,11 @@ static struct phy_driver dp83tg720_driver[] = {
 module_phy_driver(dp83tg720_driver);
 
 static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
-	{ PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
 
-MODULE_DESCRIPTION("Texas Instruments DP83TG720S PHY driver");
+MODULE_DESCRIPTION("Texas Instruments DP83TG720 PHY driver");
 MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
 MODULE_LICENSE("GPL");
-- 
2.17.1


