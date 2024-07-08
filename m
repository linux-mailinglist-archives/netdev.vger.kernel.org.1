Return-Path: <netdev+bounces-109915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CF92A44D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC8F283101
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E0913B798;
	Mon,  8 Jul 2024 14:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153984FA0
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447558; cv=none; b=fsPLljkKBs3HJ/N+bKcgTQVf6UWD+hXns4zfEkcyZRjPjlmMlqPU+ybVqw1FS4o/e8anbXtTTUxrPOdpL8S+qN5Y4Gqs8kAIKcf46t/TA6rZAgOTdpkGY4u2bAQrpbNj+0HThCkpyPKUgoJ/rzIjwybBj5eJvJerbQVJBhJAt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447558; c=relaxed/simple;
	bh=tI8qnwMblf0E1xUtIPkd8PDAZjv+xvfOlBhAJDpVRd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZA6m/Jp4sNOS0L+84tDN2Kaa33Qh9VYWXpqGvRu0Hay0TcOLn2TF1Oc91Nm+wUFM5LwtG0f1pxIyHTzrovP0m0RO98cSzZPcV8w6oR55ZheODnEmRqQ6FswxqqYk1DYL68ZLkZSlUQr/EPB4KEOxUHCwrhmRgZ4+6ohNMGpxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sQozw-0004Ex-LZ; Mon, 08 Jul 2024 16:05:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sQozv-0083eE-Bg; Mon, 08 Jul 2024 16:05:43 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sQozv-00AAoU-0x;
	Mon, 08 Jul 2024 16:05:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing support
Date: Mon,  8 Jul 2024 16:05:42 +0200
Message-Id: <20240708140542.2424824-1-o.rempel@pengutronix.de>
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

Implement the TDR test procedure as described in "Application Note
DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.

The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
cable length was 5 meters more for each 20 meters of actual cable length.
For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
showed as 50 meters. Since other parts of the diagnostics provided by this
PHY (e.g., Active Link Cable Diagnostics) require accurate cable
characterization to provide proper results, this tuning can be implemented
in a separate patch/interface.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 158 ++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index d7616b13c5946..3375fa82927d0 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -29,6 +30,42 @@
 #define DP83TD510E_INT1_LINK			BIT(13)
 #define DP83TD510E_INT1_LINK_EN			BIT(5)
 
+#define DP83TD510E_TDR_CFG			0x1e
+#define DP83TD510E_TDR_START			BIT(15)
+#define DP83TD510E_TDR_DONE			BIT(1)
+#define DP83TD510E_TDR_FAIL			BIT(0)
+
+#define DP83TD510E_CTRL				0x1f
+#define DP83TD510E_CTRL_HW_RESET		BIT(15)
+#define DP83TD510E_CTRL_SW_RESET		BIT(14)
+
+#define DP83TD510E_TDR_CFG1			0x300
+/* TX_TYPE: Transmit voltage level for TDR. 0 = 1V, 1 = 2.4V */
+#define DP83TD510E_TDR_TX_TYPE			BIT(12)
+
+#define DP83TD510E_TDR_CFG2			0x301
+#define DP83TD510E_TDR_END_TAP_INDEX_1		GENMASK(14, 8)
+#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF	36
+#define DP83TD510E_TDR_START_TAP_INDEX_1	GENMASK(6, 0)
+#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF	3
+
+#define DP83TD510E_TDR_FAULT_CFG1		0x303
+#define DP83TD510E_TDR_FLT_LOC_OFFSET_1		GENMASK(14, 8)
+#define DP83TD510E_TDR_FLT_LOC_OFFSET_1_DEF	4
+#define DP83TD510E_TDR_FLT_INIT_1		GENMASK(7, 0)
+#define DP83TD510E_TDR_FLT_INIT_1_DEF		62
+
+#define DP83TD510E_TDR_FAULT_STAT		0x30c
+#define DP83TD510E_TDR_PEAK_DETECT		BIT(11)
+#define DP83TD510E_TDR_PEAK_SIGN		BIT(10)
+#define DP83TD510E_TDR_PEAK_LOCATION		GENMASK(9, 0)
+
+/* Not documented registers and values but recommended according to
+ * "DP83TD510E Cable Diagnostics Toolkit revC"
+ */
+#define DP83TD510E_UNKN_030E			0x30e
+#define DP83TD510E_030E_VAL			0x2520
+
 #define DP83TD510E_AN_STAT_1			0x60c
 #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
 
@@ -198,6 +235,124 @@ static int dp83td510_get_sqi_max(struct phy_device *phydev)
 	return DP83TD510_SQI_MAX;
 }
 
+/**
+ * dp83td510_cable_test_start - Start the cable test for the DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This sequence is implemented according to the "Application Note DP83TD510E
+ * Cable Diagnostics Toolkit revC".
+ *
+ * Return: 0 on success, a negative error code on failure.
+ */
+static int dp83td510_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_CTRL,
+			       DP83TD510E_CTRL_HW_RESET);
+	if (ret)
+		return ret;
+
+	ret = genphy_c45_an_disable_aneg(phydev);
+	if (ret)
+		return ret;
+
+	/* Force master mode */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
+			       MDIO_PMA_PMD_BT1_CTRL_CFG_MST);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG2,
+			    FIELD_PREP(DP83TD510E_TDR_END_TAP_INDEX_1,
+				       DP83TD510E_TDR_END_TAP_INDEX_1_DEF) |
+			    FIELD_PREP(DP83TD510E_TDR_START_TAP_INDEX_1,
+				       DP83TD510E_TDR_START_TAP_INDEX_1_DEF));
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_FAULT_CFG1,
+			    FIELD_PREP(DP83TD510E_TDR_FLT_LOC_OFFSET_1,
+				       DP83TD510E_TDR_FLT_LOC_OFFSET_1_DEF) |
+			    FIELD_PREP(DP83TD510E_TDR_FLT_INIT_1,
+				       DP83TD510E_TDR_FLT_INIT_1_DEF));
+	if (ret)
+		return ret;
+
+	/* Undocumented register, from the "Application Note DP83TD510E Cable
+	 * Diagnostics Toolkit revC".
+	 */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_UNKN_030E,
+			    DP83TD510E_030E_VAL);
+	if (ret)
+		return ret;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_CTRL,
+			       DP83TD510E_CTRL_SW_RESET);
+	if (ret)
+		return ret;
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG,
+				DP83TD510E_TDR_START);
+}
+
+/**
+ * dp83td510_cable_test_get_status - Get the status of the cable test for the
+ *                                   DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ * @finished: Pointer to a boolean that indicates whether the test is finished.
+ *
+ * The function sets the @finished flag to true if the test is complete, and
+ * returns 0 on success or a negative error code on failure.
+ */
+static int dp83td510_cable_test_get_status(struct phy_device *phydev,
+					   bool *finished)
+{
+	int ret, stat;
+
+	*finished = false;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & DP83TD510E_TDR_DONE))
+		return 0;
+
+	if (!(ret & DP83TD510E_TDR_FAIL)) {
+		int location;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   DP83TD510E_TDR_FAULT_STAT);
+		if (ret < 0)
+			return ret;
+
+		if (ret & DP83TD510E_TDR_PEAK_DETECT) {
+			if (ret & DP83TD510E_TDR_PEAK_SIGN)
+				stat = ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+			else
+				stat = ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+
+			location = FIELD_GET(DP83TD510E_TDR_PEAK_LOCATION,
+					     ret) * 100;
+			ethnl_cable_test_fault_length(phydev,
+						      ETHTOOL_A_CABLE_PAIR_A,
+						      location);
+		} else {
+			stat = ETHTOOL_A_CABLE_RESULT_CODE_OK;
+		}
+	} else {
+		/* Most probably we have active link partner */
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
 static int dp83td510_get_features(struct phy_device *phydev)
 {
 	/* This PHY can't respond on MDIO bus if no RMII clock is enabled.
@@ -221,6 +376,7 @@ static struct phy_driver dp83td510_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TD510E_PHY_ID),
 	.name		= "TI DP83TD510E",
 
+	.flags          = PHY_POLL_CABLE_TEST,
 	.config_aneg	= dp83td510_config_aneg,
 	.read_status	= dp83td510_read_status,
 	.get_features	= dp83td510_get_features,
@@ -228,6 +384,8 @@ static struct phy_driver dp83td510_driver[] = {
 	.handle_interrupt = dp83td510_handle_interrupt,
 	.get_sqi	= dp83td510_get_sqi,
 	.get_sqi_max	= dp83td510_get_sqi_max,
+	.cable_test_start = dp83td510_cable_test_start,
+	.cable_test_get_status = dp83td510_cable_test_get_status,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.2


