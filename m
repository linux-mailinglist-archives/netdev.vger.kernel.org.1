Return-Path: <netdev+bounces-156598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBCA071FE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB187188AFE9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B1218ADB;
	Thu,  9 Jan 2025 09:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A82185BE
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415935; cv=none; b=nYZ5GAkqqFKdTHOKe2fa4LBQkXUNwf3Xy0Qy+Purqq1yWkX7CnPfjlaKg5U1DDpSI0X02ahmlYy4sTQxLZFqHiNEqvjZhZ4UWX+N0SVdUWh3pvdBsIsFYeqdu4dLEf/eFe9qfhqzXtPH8Ks1G0L+EbYQt0xVWzhR51IMU7xLK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415935; c=relaxed/simple;
	bh=3306Rs7gQhaA+1SvJQj/mhP9MZc0HTl7FNz961NgcIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Brhfb42xH0/SlYtgRh53Tb+skUzFHdoEjjKCIg7MywqGMbUHxlkWUpzfXJnTqPHUxPWgxvBfo+VQzWfY4ctk3rORrQEUMzNl0tGaK1+ifvfDaK0vO/KSY82PEmEH/aTwBgQ+wEb1IHEKPQntxBqVX//CbB0YLqhBuB4DZaFEfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVp64-00088J-Cg; Thu, 09 Jan 2025 10:45:00 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVp62-007faE-0m;
	Thu, 09 Jan 2025 10:44:59 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVp62-000PNt-2z;
	Thu, 09 Jan 2025 10:44:58 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v6 7/7] net: phy: dp83tg720: add statistics support
Date: Thu,  9 Jan 2025 10:44:57 +0100
Message-Id: <20250109094457.97466-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109094457.97466-1-o.rempel@pengutronix.de>
References: <20250109094457.97466-1-o.rempel@pengutronix.de>
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

Add support for reporting PHY statistics in the DP83TG720 driver. This
includes cumulative tracking of link loss events, transmit/receive
packet counts, and error counts. Implemented functions to update and
provide statistics via ethtool, with optional polling support enabled
through `PHY_POLL_STATS`.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- drop ethtool_stat_add() support
changes v2:
- drop use of FIELD_GET
- add comments
---
 drivers/net/phy/dp83tg720.c | 161 ++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 0ef4d7dba065..4ea752131b8c 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -51,6 +51,9 @@
 /* Register 0x0405: Unknown Register */
 #define DP83TG720S_UNKNOWN_0405			0x405
 
+#define DP83TG720S_LINK_QUAL_3			0x547
+#define DP83TG720S_LINK_LOSS_CNT_MASK		GENMASK(15, 10)
+
 /* Register 0x0576: TDR Master Link Down Control */
 #define DP83TG720S_TDR_MASTER_LINK_DOWN		0x576
 
@@ -60,6 +63,29 @@
 /* In RGMII mode, Enable or disable the internal delay for TXD */
 #define DP83TG720S_RGMII_TX_CLK_SEL		BIT(0)
 
+/*
+ * DP83TG720S_PKT_STAT_x registers correspond to similarly named registers
+ * in the datasheet (PKT_STAT_1 through PKT_STAT_6). These registers store
+ * 32-bit or 16-bit counters for TX and RX statistics and must be read in
+ * sequence to ensure the counters are cleared correctly.
+ *
+ * - DP83TG720S_PKT_STAT_1: Contains TX packet count bits [15:0].
+ * - DP83TG720S_PKT_STAT_2: Contains TX packet count bits [31:16].
+ * - DP83TG720S_PKT_STAT_3: Contains TX error packet count.
+ * - DP83TG720S_PKT_STAT_4: Contains RX packet count bits [15:0].
+ * - DP83TG720S_PKT_STAT_5: Contains RX packet count bits [31:16].
+ * - DP83TG720S_PKT_STAT_6: Contains RX error packet count.
+ *
+ * Keeping the register names as defined in the datasheet helps maintain
+ * clarity and alignment with the documentation.
+ */
+#define DP83TG720S_PKT_STAT_1			0x639
+#define DP83TG720S_PKT_STAT_2			0x63a
+#define DP83TG720S_PKT_STAT_3			0x63b
+#define DP83TG720S_PKT_STAT_4			0x63c
+#define DP83TG720S_PKT_STAT_5			0x63d
+#define DP83TG720S_PKT_STAT_6			0x63e
+
 /* Register 0x083F: Unknown Register */
 #define DP83TG720S_UNKNOWN_083F			0x83f
 
@@ -69,6 +95,113 @@
 
 #define DP83TG720_SQI_MAX			7
 
+struct dp83tg720_stats {
+	u64 link_loss_cnt;
+	u64 tx_pkt_cnt;
+	u64 tx_err_pkt_cnt;
+	u64 rx_pkt_cnt;
+	u64 rx_err_pkt_cnt;
+};
+
+struct dp83tg720_priv {
+	struct dp83tg720_stats stats;
+};
+
+/**
+ * dp83tg720_update_stats - Update the PHY statistics for the DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * The function reads the PHY statistics registers and updates the statistics
+ * structure.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static int dp83tg720_update_stats(struct phy_device *phydev)
+{
+	struct dp83tg720_priv *priv = phydev->priv;
+	u32 count;
+	int ret;
+
+	/* Read the link loss count */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LINK_QUAL_3);
+	if (ret < 0)
+		return ret;
+	/* link_loss_cnt */
+	count = FIELD_GET(DP83TG720S_LINK_LOSS_CNT_MASK, ret);
+	priv->stats.link_loss_cnt += count;
+
+	/* The DP83TG720S_PKT_STAT registers are divided into two groups:
+	 * - Group 1 (TX stats): DP83TG720S_PKT_STAT_1 to DP83TG720S_PKT_STAT_3
+	 * - Group 2 (RX stats): DP83TG720S_PKT_STAT_4 to DP83TG720S_PKT_STAT_6
+	 *
+	 * Registers in each group are cleared only after reading them in a
+	 * plain sequence (e.g., 1, 2, 3 for Group 1 or 4, 5, 6 for Group 2).
+	 * Any deviation from the sequence, such as reading 1, 2, 1, 2, 3, will
+	 * prevent the group from being cleared. Additionally, the counters
+	 * for a group are frozen as soon as the first register in that group
+	 * is accessed.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_1);
+	if (ret < 0)
+		return ret;
+	/* tx_pkt_cnt_15_0 */
+	count = ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_2);
+	if (ret < 0)
+		return ret;
+	/* tx_pkt_cnt_31_16 */
+	count |= ret << 16;
+	priv->stats.tx_pkt_cnt += count;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_3);
+	if (ret < 0)
+		return ret;
+	/* tx_err_pkt_cnt */
+	priv->stats.tx_err_pkt_cnt += ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_4);
+	if (ret < 0)
+		return ret;
+	/* rx_pkt_cnt_15_0 */
+	count = ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_5);
+	if (ret < 0)
+		return ret;
+	/* rx_pkt_cnt_31_16 */
+	count |= ret << 16;
+	priv->stats.rx_pkt_cnt += count;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_PKT_STAT_6);
+	if (ret < 0)
+		return ret;
+	/* rx_err_pkt_cnt */
+	priv->stats.rx_err_pkt_cnt += ret;
+
+	return 0;
+}
+
+static void dp83tg720_get_link_stats(struct phy_device *phydev,
+				     struct ethtool_link_ext_stats *link_stats)
+{
+	struct dp83tg720_priv *priv = phydev->priv;
+
+	link_stats->link_down_events = priv->stats.link_loss_cnt;
+}
+
+static void dp83tg720_get_phy_stats(struct phy_device *phydev,
+				    struct ethtool_eth_phy_stats *eth_stats,
+				    struct ethtool_phy_stats *stats)
+{
+	struct dp83tg720_priv *priv = phydev->priv;
+
+	stats->tx_packets = priv->stats.tx_pkt_cnt;
+	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
+	stats->rx_packets = priv->stats.rx_pkt_cnt;
+	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
+}
+
 /**
  * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
  * @phydev: Pointer to the phy_device structure.
@@ -182,6 +315,11 @@ static int dp83tg720_cable_test_get_status(struct phy_device *phydev,
 
 	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A, stat);
 
+	/* save the current stats before resetting the PHY */
+	ret = dp83tg720_update_stats(phydev);
+	if (ret)
+		return ret;
+
 	return phy_init_hw(phydev);
 }
 
@@ -217,6 +355,11 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 	phy_sts = phy_read(phydev, DP83TG720S_MII_REG_10);
 	phydev->link = !!(phy_sts & DP83TG720S_LINK_STATUS);
 	if (!phydev->link) {
+		/* save the current stats before resetting the PHY */
+		ret = dp83tg720_update_stats(phydev);
+		if (ret)
+			return ret;
+
 		/* According to the "DP83TC81x, DP83TG72x Software
 		 * Implementation Guide", the PHY needs to be reset after a
 		 * link loss or if no link is created after at least 100ms.
@@ -341,12 +484,27 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
+static int dp83tg720_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct dp83tg720_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
 static struct phy_driver dp83tg720_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
 	.name		= "TI DP83TG720S",
 
 	.flags          = PHY_POLL_CABLE_TEST,
+	.probe		= dp83tg720_probe,
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
@@ -355,6 +513,9 @@ static struct phy_driver dp83tg720_driver[] = {
 	.get_sqi_max	= dp83tg720_get_sqi_max,
 	.cable_test_start = dp83tg720_cable_test_start,
 	.cable_test_get_status = dp83tg720_cable_test_get_status,
+	.get_link_stats	= dp83tg720_get_link_stats,
+	.get_phy_stats	= dp83tg720_get_phy_stats,
+	.update_stats	= dp83tg720_update_stats,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.5


