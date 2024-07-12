Return-Path: <netdev+bounces-111098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4B92FD95
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878A828625F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82721741C6;
	Fri, 12 Jul 2024 15:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B717085D
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798140; cv=none; b=KIUyx8CRyJmmNO4vt+mW3qao6JjZqD3M3Lb2Bo1kkYq5hSXaqRRNjbTuNoSgNoJPXd0sfPW50yDBqh0ez85Gn+a4X9kZ81NWrICX/F9YTeoHaeLqAl7T0LG45fBNyPajlntLqShx21wK5YWwIAYae1MyNkSRc+HDKZ0JxO3DSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798140; c=relaxed/simple;
	bh=vAZkvgSq4JcEqKV4rgGpXHYU3ZoRIdAvjSzs2zjQWyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GIJCA0vfhI/EJgR7gThxmXtaIolw7ak4WiuJqHpK1+Ikhef8Ae4OMVP8lmmAEIS8NgYszoj3Yph6RA90EzZEcUQe5ev/FgCHcb8JY2NqF5lLvn3YG7VHCG7Sn8y0hTGLMchtcVHRj3dUYRGO63BtK1POSGLCaH+EmYYJcReDHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sSICY-0003Ok-I3; Fri, 12 Jul 2024 17:28:50 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sSICX-0091uO-Ud; Fri, 12 Jul 2024 17:28:49 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sSICX-00AP8t-2r;
	Fri, 12 Jul 2024 17:28:49 +0200
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
Subject: [PATCH net-next v2 1/1] net: phy: dp83td510: add cable testing support
Date: Fri, 12 Jul 2024 17:28:48 +0200
Message-Id: <20240712152848.2479912-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

This patch implements the TDR test procedure as described in
"Application Note DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.

The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
cable length was 5 meters more for each 20 meters of actual cable length.
For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
showed as 50 meters. Since other parts of the diagnostics provided by this
PHY (e.g., Active Link Cable Diagnostics) require accurate cable
characterization to provide proper results, this tuning can be implemented
in a separate patch/interface.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
changes v2:
- add comments
- change post silence time to 1000ms
---
 drivers/net/phy/dp83td510.c | 264 ++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index d7616b13c5946..551e37786c2da 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -29,6 +30,10 @@
 #define DP83TD510E_INT1_LINK			BIT(13)
 #define DP83TD510E_INT1_LINK_EN			BIT(5)
 
+#define DP83TD510E_CTRL				0x1f
+#define DP83TD510E_CTRL_HW_RESET		BIT(15)
+#define DP83TD510E_CTRL_SW_RESET		BIT(14)
+
 #define DP83TD510E_AN_STAT_1			0x60c
 #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
 
@@ -53,6 +58,117 @@ static const u16 dp83td510_mse_sqi_map[] = {
 	0x0000  /* 24dB =< SNR */
 };
 
+/* Time Domain Reflectometry (TDR) Functionality of DP83TD510 PHY
+ *
+ * I assume that this PHY is using a variation of Spread Spectrum Time Domain
+ * Reflectometry (SSTDR) rather than the commonly used TDR found in many PHYs.
+ * Here are the following observations which likely confirm this:
+ * - The DP83TD510 PHY transmits a modulated signal of configurable length
+ *   (default 16000 µs) instead of a single pulse pattern, which is typical
+ *   for traditional TDR.
+ * - The pulse observed on the wire, triggered by the HW RESET register, is not
+ *   part of the cable testing process.
+ *
+ * I assume that SSTDR seems to be a logical choice for the 10BaseT1L
+ * environment due to improved noise resistance, making it suitable for
+ * environments  with significant electrical noise, such as long 10BaseT1L cable
+ * runs.
+ *
+ * Configuration Variables:
+ * The SSTDR variation used in this PHY involves more configuration variables
+ * that can dramatically affect the functionality and precision of cable
+ * testing. Since most of  these configuration options are either not well
+ * documented or documented with minimal details, the following sections
+ * describe my understanding and observations of these variables and their
+ * impact on TDR functionality.
+ *
+ * Timeline:
+ *     ,<--cfg_pre_silence_time
+ *     |            ,<-SSTDR Modulated Transmission
+ *     |	    |            ,<--cfg_post_silence_time
+ *     |	    |            |             ,<--Force Link Mode
+ * |<--'-->|<-------'------->|<--'-->|<--------'------->|
+ *
+ * - cfg_pre_silence_time: Optional silence time before TDR transmission starts.
+ * - SSTDR Modulated Transmission: Transmission duration configured by
+ *   cfg_tdr_tx_duration and amplitude configured by cfg_tdr_tx_type.
+ * - cfg_post_silence_time: Silence time after TDR transmission.
+ * - Force Link Mode: If nothing is configured after cfg_post_silence_time,
+ *   the PHY continues in force link mode without autonegotiation.
+ */
+
+#define DP83TD510E_TDR_CFG				0x1e
+#define DP83TD510E_TDR_START				BIT(15)
+#define DP83TD510E_TDR_DONE				BIT(1)
+#define DP83TD510E_TDR_FAIL				BIT(0)
+
+#define DP83TD510E_TDR_CFG1				0x300
+/* cfg_tdr_tx_type: Transmit voltage level for TDR.
+ * 0 = 1V, 1 = 2.4V
+ * Note: Using different voltage levels may not work
+ * in all configuration variations. For example, setting
+ * 2.4V may give different cable length measurements.
+ * Other settings may be needed to make it work properly.
+ */
+#define DP83TD510E_TDR_TX_TYPE				BIT(12)
+#define DP83TD510E_TDR_TX_TYPE_1V			0
+#define DP83TD510E_TDR_TX_TYPE_2_4V			1
+/* cfg_post_silence_time: Time after the TDR sequence. Since we force master mode
+ * for the TDR will proceed with forced link state after this time. For Linux
+ * it is better to set max value to avoid false link state detection.
+ */
+#define DP83TD510E_TDR_CFG1_POST_SILENCE_TIME		GENMASK(3, 2)
+#define DP83TD510E_TDR_CFG1_POST_SILENCE_TIME_0MS	0
+#define DP83TD510E_TDR_CFG1_POST_SILENCE_TIME_10MS	1
+#define DP83TD510E_TDR_CFG1_POST_SILENCE_TIME_100MS	2
+#define DP83TD510E_TDR_CFG1_POST_SILENCE_TIME_1000MS	3
+/* cfg_pre_silence_time: Time before the TDR sequence. It should be enough to
+ * settle down all pulses and reflections. Since for 10BASE-T1L we have
+ * maximum 2000m cable length, we can set it to 1ms.
+ */
+#define DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME		GENMASK(1, 0)
+#define DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME_0MS	0
+#define DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME_10MS	1
+#define DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME_100MS	2
+#define DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME_1000MS	3
+
+#define DP83TD510E_TDR_CFG2				0x301
+#define DP83TD510E_TDR_END_TAP_INDEX_1			GENMASK(14, 8)
+#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF		36
+#define DP83TD510E_TDR_START_TAP_INDEX_1		GENMASK(6, 0)
+#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF		4
+
+#define DP83TD510E_TDR_CFG3				0x302
+/* cfg_tdr_tx_duration: Duration of the TDR transmission in microseconds.
+ * This value sets the duration of the modulated signal used for TDR
+ * measurements.
+ * - Default: 16000 µs
+ * - Observation: A minimum duration of 6000 µs is recommended to ensure
+ *   accurate detection of cable faults. Durations shorter than 6000 µs may
+ *   result in incomplete data, especially for shorter cables (e.g., 20 meters),
+ *   leading to false "OK" results. Longer durations (e.g., 6000 µs or more)
+ *   provide better accuracy, particularly for detecting open circuits.
+ */
+#define DP83TD510E_TDR_TX_DURATION_US			GENMASK(15, 0)
+#define DP83TD510E_TDR_TX_DURATION_US_DEF		16000
+
+#define DP83TD510E_TDR_FAULT_CFG1			0x303
+#define DP83TD510E_TDR_FLT_LOC_OFFSET_1			GENMASK(14, 8)
+#define DP83TD510E_TDR_FLT_LOC_OFFSET_1_DEF		4
+#define DP83TD510E_TDR_FLT_INIT_1			GENMASK(7, 0)
+#define DP83TD510E_TDR_FLT_INIT_1_DEF			62
+
+#define DP83TD510E_TDR_FAULT_STAT			0x30c
+#define DP83TD510E_TDR_PEAK_DETECT			BIT(11)
+#define DP83TD510E_TDR_PEAK_SIGN			BIT(10)
+#define DP83TD510E_TDR_PEAK_LOCATION			GENMASK(9, 0)
+
+/* Not documented registers and values but recommended according to
+ * "DP83TD510E Cable Diagnostics Toolkit revC"
+ */
+#define DP83TD510E_UNKN_030E				0x30e
+#define DP83TD510E_030E_VAL				0x2520
+
 static int dp83td510_config_intr(struct phy_device *phydev)
 {
 	int ret;
@@ -198,6 +314,151 @@ static int dp83td510_get_sqi_max(struct phy_device *phydev)
 	return DP83TD510_SQI_MAX;
 }
 
+/**
+ * dp83td510_cable_test_start - Start the cable test for the DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * This sequence is implemented according to the "Application Note DP83TD510E
+ * Cable Diagnostics Toolkit revC".
+ *
+ * Returns: 0 on success, a negative error code on failure.
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
+	/* There is no official recommendation for this register, but it is
+	 * better to use 1V for TDR since other values seems to be optimized
+	 * for this amplitude. Except of amplitude, it is better to configure
+	 * pre TDR silence time to 10ms to avoid false reflections (value 0
+	 * seems to be too short, otherwise we need to implement own silence
+	 * time). Also, post TDR silence time should be set to 1000ms to avoid
+	 * false link state detection, it fits to the polling time of the
+	 * PHY framework. The idea is to wait until
+	 * dp83td510_cable_test_get_status() will be called and reconfigure
+	 * the PHY to the default state within the post silence time window.
+	 */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG1,
+			     DP83TD510E_TDR_TX_TYPE |
+			     DP83TD510E_TDR_CFG1_POST_SILENCE_TIME |
+			     DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME,
+			     DP83TD510E_TDR_TX_TYPE_1V |
+			     DP83TD510E_TDR_CFG1_PRE_SILENCE_TIME_10MS |
+			     DP83TD510E_TDR_CFG1_POST_SILENCE_TIME_1000MS);
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
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_TDR_CFG3,
+			    DP83TD510E_TDR_TX_DURATION_US_DEF);
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
+ * The function sets the @finished flag to true if the test is complete.
+ *
+ * Returns: 0 on success or a negative error code on failure.
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
@@ -221,6 +482,7 @@ static struct phy_driver dp83td510_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TD510E_PHY_ID),
 	.name		= "TI DP83TD510E",
 
+	.flags          = PHY_POLL_CABLE_TEST,
 	.config_aneg	= dp83td510_config_aneg,
 	.read_status	= dp83td510_read_status,
 	.get_features	= dp83td510_get_features,
@@ -228,6 +490,8 @@ static struct phy_driver dp83td510_driver[] = {
 	.handle_interrupt = dp83td510_handle_interrupt,
 	.get_sqi	= dp83td510_get_sqi,
 	.get_sqi_max	= dp83td510_get_sqi_max,
+	.cable_test_start = dp83td510_cable_test_start,
+	.cable_test_get_status = dp83td510_cable_test_get_status,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.2


