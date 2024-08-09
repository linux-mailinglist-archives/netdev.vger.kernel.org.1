Return-Path: <netdev+bounces-117103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E236B94CB41
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B261C20C0B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8A17839D;
	Fri,  9 Aug 2024 07:24:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49029176FA7
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188295; cv=none; b=Z/7ZAEM0ibNTU//oVDbKVyQZVSDvE0hi1EMdRhJ+Wj+PrXpuW7b92zuRiSDNOKVQvgroIDsuOCVk2J0QY/U1lh0ZUtAA+r5y+MfkjyfH35C3Bn/pjauKapkahP9Gql6DtrnvqHQwlTqAsj0+l9+bB2Kpb75udZFXCa/lbAZ7jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188295; c=relaxed/simple;
	bh=vlbkNoYP2j5e0GPK16xqyatdla3pugrJU/oYKYwjJSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVxi7WFAO4NQXSO8mcVuoNbx9dh87Pl7jLm/mDTa333wS5cNfvY1wsJ/3fTcUvtQInKkd+nTBGGPBXHOZHmJBsN18mYogUZlA7P/k4SbWKzUtrN23JjBKKVio/uQdYc56PwIi4Yfg5dqcxxyO0RSPn4zPTjH1CbuG9mOLqEax24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzO-0001f8-Tu; Fri, 09 Aug 2024 09:24:42 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzN-005bux-4w; Fri, 09 Aug 2024 09:24:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzN-00EaZM-0G;
	Fri, 09 Aug 2024 09:24:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing support
Date: Fri,  9 Aug 2024 09:24:39 +0200
Message-Id: <20240809072440.3477125-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809072440.3477125-1-o.rempel@pengutronix.de>
References: <20240809072440.3477125-1-o.rempel@pengutronix.de>
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

Introduce cable testing support for the DP83TG720 PHY. This implementation
is based on the "DP83TG720S-Q1: Configuring for Open Alliance Specification
Compliance (Rev. B)" application note.

The feature has been tested with cables of various lengths:
- No cable: 1m till open reported.
- 5 meter cable: reported properly.
- 20 meter cable: reported as 19m.
- 40 meter cable: reported as cable ok.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- select OPEN_ALLIANCE_HELPERS
changes v2:
- use open alliance specific helpers for the TDR results
---
 drivers/net/phy/Kconfig     |   1 +
 drivers/net/phy/dp83tg720.c | 154 ++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 874422e530ff0..f530fcd092fe4 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -417,6 +417,7 @@ config DP83TD510_PHY
 
 config DP83TG720_PHY
 	tristate "Texas Instruments DP83TG720 Ethernet 1000Base-T1 PHY"
+	select OPEN_ALLIANCE_HELPERS
 	help
 	  The DP83TG720S-Q1 is an automotive Ethernet physical layer
 	  transceiver compliant with IEEE 802.3bp and Open Alliance
diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index c706429b225a2..0ef4d7dba0656 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -3,10 +3,13 @@
  * Copyright (c) 2023 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
  */
 #include <linux/bitfield.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
 
+#include "open_alliance_helpers.h"
+
 #define DP83TG720S_PHY_ID			0x2000a284
 
 /* MDIO_MMD_VEND2 registers */
@@ -14,6 +17,17 @@
 #define DP83TG720S_STS_MII_INT			BIT(7)
 #define DP83TG720S_LINK_STATUS			BIT(0)
 
+/* TDR Configuration Register (0x1E) */
+#define DP83TG720S_TDR_CFG			0x1e
+/* 1b = TDR start, 0b = No TDR */
+#define DP83TG720S_TDR_START			BIT(15)
+/* 1b = TDR auto on link down, 0b = Manual TDR start */
+#define DP83TG720S_CFG_TDR_AUTO_RUN		BIT(14)
+/* 1b = TDR done, 0b = TDR in progress */
+#define DP83TG720S_TDR_DONE			BIT(1)
+/* 1b = TDR fail, 0b = TDR success */
+#define DP83TG720S_TDR_FAIL			BIT(0)
+
 #define DP83TG720S_PHY_RESET			0x1f
 #define DP83TG720S_HW_RESET			BIT(15)
 
@@ -22,18 +36,155 @@
 /* Power Mode 0 is Normal mode */
 #define DP83TG720S_LPS_CFG3_PWR_MODE_0		BIT(0)
 
+/* Open Aliance 1000BaseT1 compatible HDD.TDR Fault Status Register */
+#define DP83TG720S_TDR_FAULT_STATUS		0x30f
+
+/* Register 0x0301: TDR Configuration 2 */
+#define DP83TG720S_TDR_CFG2			0x301
+
+/* Register 0x0303: TDR Configuration 3 */
+#define DP83TG720S_TDR_CFG3			0x303
+
+/* Register 0x0304: TDR Configuration 4 */
+#define DP83TG720S_TDR_CFG4			0x304
+
+/* Register 0x0405: Unknown Register */
+#define DP83TG720S_UNKNOWN_0405			0x405
+
+/* Register 0x0576: TDR Master Link Down Control */
+#define DP83TG720S_TDR_MASTER_LINK_DOWN		0x576
+
 #define DP83TG720S_RGMII_DELAY_CTRL		0x602
 /* In RGMII mode, Enable or disable the internal delay for RXD */
 #define DP83TG720S_RGMII_RX_CLK_SEL		BIT(1)
 /* In RGMII mode, Enable or disable the internal delay for TXD */
 #define DP83TG720S_RGMII_TX_CLK_SEL		BIT(0)
 
+/* Register 0x083F: Unknown Register */
+#define DP83TG720S_UNKNOWN_083F			0x83f
+
 #define DP83TG720S_SQI_REG_1			0x871
 #define DP83TG720S_SQI_OUT_WORST		GENMASK(7, 5)
 #define DP83TG720S_SQI_OUT			GENMASK(3, 1)
 
 #define DP83TG720_SQI_MAX			7
 
+/**
+ * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This sequence is based on the documented procedure for the DP83TG720 PHY.
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ */
+static int dp83tg720_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Initialize the PHY to run the TDR test as described in the
+	 * "DP83TG720S-Q1: Configuring for Open Alliance Specification
+	 * Compliance (Rev. B)" application note.
+	 * Most of the registers are not documented. Some of register names
+	 * are guessed by comparing the register offsets with the DP83TD510E.
+	 */
+
+	/* Force master link down */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
+			       DP83TG720S_TDR_MASTER_LINK_DOWN, 0x0400);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG2,
+			    0xa008);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG3,
+			    0x0928);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG4,
+			    0x0004);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_UNKNOWN_0405,
+			    0x6400);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_UNKNOWN_083F,
+			    0x3003);
+	if (ret)
+		return ret;
+
+	/* Start the TDR */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG,
+			       DP83TG720S_TDR_START);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * dp83tg720_cable_test_get_status - Get the status of the cable test for the
+ *                                   DP83TG720 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ * @finished: Pointer to a boolean that indicates whether the test is finished.
+ *
+ * The function sets the @finished flag to true if the test is complete.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static int dp83tg720_cable_test_get_status(struct phy_device *phydev,
+					   bool *finished)
+{
+	int ret, stat;
+
+	*finished = false;
+
+	/* Read the TDR status */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_TDR_CFG);
+	if (ret < 0)
+		return ret;
+
+	/* Check if the TDR test is done */
+	if (!(ret & DP83TG720S_TDR_DONE))
+		return 0;
+
+	/* Check for TDR test failure */
+	if (!(ret & DP83TG720S_TDR_FAIL)) {
+		int location;
+
+		/* Read fault status */
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   DP83TG720S_TDR_FAULT_STATUS);
+		if (ret < 0)
+			return ret;
+
+		/* Get fault type */
+		stat = oa_1000bt1_get_ethtool_cable_result_code(ret);
+
+		/* Determine fault location */
+		location = oa_1000bt1_get_tdr_distance(ret);
+		if (location > 0)
+			ethnl_cable_test_fault_length(phydev,
+						      ETHTOOL_A_CABLE_PAIR_A,
+						      location);
+	} else {
+		/* Active link partner or other issues */
+		stat = ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+
+	*finished = true;
+
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A, stat);
+
+	return phy_init_hw(phydev);
+}
+
 static int dp83tg720_config_aneg(struct phy_device *phydev)
 {
 	int ret;
@@ -195,12 +346,15 @@ static struct phy_driver dp83tg720_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
 	.name		= "TI DP83TG720S",
 
+	.flags          = PHY_POLL_CABLE_TEST,
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
 	.config_init	= dp83tg720_config_init,
 	.get_sqi	= dp83tg720_get_sqi,
 	.get_sqi_max	= dp83tg720_get_sqi_max,
+	.cable_test_start = dp83tg720_cable_test_start,
+	.cable_test_get_status = dp83tg720_cable_test_get_status,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.2


