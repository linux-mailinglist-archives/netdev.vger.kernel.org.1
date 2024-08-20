Return-Path: <netdev+bounces-120139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D829586ED
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A956B1F21F51
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD919046E;
	Tue, 20 Aug 2024 12:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFC18FC9E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156970; cv=none; b=tw5hum3tgpnXtx/TlyMYrRUuBtduG2NSlgNmhDmjaCuAJsfK6fji8Aoh3QHl9D1oL8tzTOVjHyGUGy9YoptLKZFP/211E7Le3AWOJbG8v0z0CmmsbE9x2zceoZQwv8maMoi7RCsg+I5eKGvJgJKykMG4X1PGLhhL2IsT907LAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156970; c=relaxed/simple;
	bh=B3wC63KUBfBMnD8KXezLklSZglr7bQftlfmuYMPfNRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTYaKc8vYzthwde2YqFo9wjqFp9yqLklw4OqkfF5DVQzOEm4e88izH1mxffW2DabsTA5CPiytIjVvpCoMCYRhSUQFQYVnAxc7rovFt6lbRy1+PgQMnR4Z+jczWzms3zn6NRc/C0Iqfpphdw/WkRb0VL7DlhDfWYyu6GUD/Zli1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNzA-0004N0-7x; Tue, 20 Aug 2024 14:29:16 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNz8-001lnU-VA; Tue, 20 Aug 2024 14:29:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNz8-008DcE-2q;
	Tue, 20 Aug 2024 14:29:14 +0200
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
Subject: [PATCH net-next v2 3/3] phy: dp83tg720: Add statistics support
Date: Tue, 20 Aug 2024 14:29:14 +0200
Message-Id: <20240820122914.1958664-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820122914.1958664-1-o.rempel@pengutronix.de>
References: <20240820122914.1958664-1-o.rempel@pengutronix.de>
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

Introduce statistics support for the DP83TG720 PHY driver, enabling
detailed monitoring and reporting of link quality and packet-related
metrics.

To avoid double reading of certain registers, the implementation caches
all relevant register values in a single operation. This approach
ensures accurate and consistent data retrieval, particularly for
registers that clear upon reading or require special handling.

Some of the statistics, such as link training times, do not increment
and therefore require special handling during the extraction process.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- use ethtool_puts()
- use defines for statistic names
---
 drivers/net/phy/dp83tg720.c | 327 ++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 0ef4d7dba0656..080cac71d1d0b 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -51,6 +51,20 @@
 /* Register 0x0405: Unknown Register */
 #define DP83TG720S_UNKNOWN_0405			0x405
 
+#define DP83TG720S_A2D_REG_66			0x442
+#define DP83TG720S_ESD_EVENT_COUNT_MASK		GENMASK(14, 9)
+
+#define DP83TG720S_LINK_QUAL_1			0x543
+#define DP83TG720S_LINK_TRAINING_TIME_MASK	GENMASK(7, 0)
+
+#define DP83TG720S_LINK_QUAL_2			0x544
+#define DP83TG720S_REMOTE_RECEIVER_TIME_MASK	GENMASK(15, 8)
+#define DP83TG720S_LOCAL_RECEIVER_TIME_MASK	GENMASK(7, 0)
+
+#define DP83TG720S_LINK_QUAL_3			0x547
+#define DP83TG720S_LINK_LOSS_CNT_MASK		GENMASK(15, 10)
+#define DP83TG720S_LINK_FAIL_CNT_MASK		GENMASK(9, 0)
+
 /* Register 0x0576: TDR Master Link Down Control */
 #define DP83TG720S_TDR_MASTER_LINK_DOWN		0x576
 
@@ -60,6 +74,24 @@
 /* In RGMII mode, Enable or disable the internal delay for TXD */
 #define DP83TG720S_RGMII_TX_CLK_SEL		BIT(0)
 
+#define DP83TG720S_PKT_STAT_1			0x639
+#define DP83TG720S_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
+
+#define DP83TG720S_PKT_STAT_2			0x63A
+#define DP83TG720S_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
+
+#define DP83TG720S_PKT_STAT_3			0x63B
+#define DP83TG720S_TX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
+
+#define DP83TG720S_PKT_STAT_4			0x63C
+#define DP83TG720S_RX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
+
+#define DP83TG720S_PKT_STAT_5			0x63D
+#define DP83TG720S_RX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
+
+#define DP83TG720S_PKT_STAT_6			0x63E
+#define DP83TG720S_RX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
+
 /* Register 0x083F: Unknown Register */
 #define DP83TG720S_UNKNOWN_083F			0x83f
 
@@ -69,6 +101,283 @@
 
 #define DP83TG720_SQI_MAX			7
 
+struct dp83tg720_cache_reg {
+	u16 mmd;
+	u16 reg;
+};
+
+#define DP83TG720_FLAG_COUNTER BIT(0)
+
+struct dp83tg720_hw_stat {
+	const char *string;
+	u8 cache_index1;
+	u8 cache_index2;  /* If a statistic spans multiple registers */
+	u32 mask1;
+	u32 mask2;        /* Mask for the second register */
+	u8 shift1;
+	u8 shift2;        /* Shift for the second register */
+	u8 flags;
+};
+
+enum dp83tg720_cache_reg_idx {
+	DP83TG720_CACHE_A2D_REG_66 = 0,
+	DP83TG720_CACHE_LINK_QUAL_1,
+	DP83TG720_CACHE_LINK_QUAL_2,
+	DP83TG720_CACHE_LINK_QUAL_3,
+	DP83TG720_CACHE_PKT_STAT_1,
+	DP83TG720_CACHE_PKT_STAT_2,
+	DP83TG720_CACHE_PKT_STAT_3,
+	DP83TG720_CACHE_PKT_STAT_4,
+	DP83TG720_CACHE_PKT_STAT_5,
+	DP83TG720_CACHE_PKT_STAT_6,
+
+	DP83TG720_CACHE_EMPTY,
+};
+
+static const struct dp83tg720_cache_reg dp83tg720_cache_regs[] = {
+	[DP83TG720_CACHE_A2D_REG_66] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_A2D_REG_66,
+	},
+	[DP83TG720_CACHE_LINK_QUAL_1] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_LINK_QUAL_1,
+	},
+	[DP83TG720_CACHE_LINK_QUAL_2] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_LINK_QUAL_2,
+	},
+	[DP83TG720_CACHE_LINK_QUAL_3] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_LINK_QUAL_3,
+	},
+	[DP83TG720_CACHE_PKT_STAT_1] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_1,
+	},
+	[DP83TG720_CACHE_PKT_STAT_2] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_2,
+	},
+	[DP83TG720_CACHE_PKT_STAT_3] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_3,
+	},
+	[DP83TG720_CACHE_PKT_STAT_4] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_4,
+	},
+	[DP83TG720_CACHE_PKT_STAT_5] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_5,
+	},
+	[DP83TG720_CACHE_PKT_STAT_6] = {
+		.mmd = MDIO_MMD_VEND2,
+		.reg = DP83TG720S_PKT_STAT_6,
+	},
+};
+
+static const struct dp83tg720_hw_stat dp83tg720_hw_stats[] = {
+	{
+		.string = OA_LQ_LFL_ESD_EVENT_COUNT,
+		.cache_index1 = DP83TG720_CACHE_A2D_REG_66,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_ESD_EVENT_COUNT_MASK,
+		.shift1 = 9,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = OA_LQ_LINK_TRAINING_TIME,
+		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_1,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_LINK_TRAINING_TIME_MASK,
+	},
+	{
+		.string = OA_LQ_REMOTE_RECEIVER_TIME,
+		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_2,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_REMOTE_RECEIVER_TIME_MASK,
+		.shift1 = 8,
+	},
+	{
+		.string = OA_LQ_LOCAL_RECEIVER_TIME,
+		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_2,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_LOCAL_RECEIVER_TIME_MASK,
+	},
+	{
+		.string = OA_LQ_LFL_LINK_LOSS_COUNT,
+		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_3,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_LINK_LOSS_CNT_MASK,
+		.shift1 = 10,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = OA_LQ_LFL_LINK_FAILURE_COUNT,
+		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_3,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_LINK_FAIL_CNT_MASK,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = PHY_TX_PKT_COUNT,
+		.cache_index1 = DP83TG720_CACHE_PKT_STAT_1,
+		.cache_index2 = DP83TG720_CACHE_PKT_STAT_2,
+		.mask1 = DP83TG720S_TX_PKT_CNT_15_0_MASK,
+		.mask2 = DP83TG720S_TX_PKT_CNT_31_16_MASK,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = PHY_TX_ERR_COUNT,
+		.cache_index1 = DP83TG720_CACHE_PKT_STAT_3,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_TX_ERR_PKT_CNT_MASK,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = PHY_RX_PKT_COUNT,
+		.cache_index1 = DP83TG720_CACHE_PKT_STAT_4,
+		.cache_index2 = DP83TG720_CACHE_PKT_STAT_5,
+		.mask1 = DP83TG720S_RX_PKT_CNT_15_0_MASK,
+		.mask2 = DP83TG720S_RX_PKT_CNT_31_16_MASK,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+	{
+		.string = PHY_RX_ERR_COUNT,
+		.cache_index1 = DP83TG720_CACHE_PKT_STAT_6,
+		.cache_index2 = DP83TG720_CACHE_EMPTY,
+		.mask1 = DP83TG720S_RX_ERR_PKT_CNT_MASK,
+		.flags = DP83TG720_FLAG_COUNTER,
+	},
+};
+
+struct dp83tg720_priv {
+	u64 stats[ARRAY_SIZE(dp83tg720_hw_stats)];
+	u16 reg_cache[ARRAY_SIZE(dp83tg720_cache_regs)];
+};
+
+/**
+ * dp83tg720_cache_reg_values - Cache register values to avoid clearing counters.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * Reads and caches the values of all relevant registers.
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ */
+static int dp83tg720_cache_reg_values(struct phy_device *phydev)
+{
+	struct dp83tg720_priv *priv = phydev->priv;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(dp83tg720_cache_regs); i++) {
+		const struct dp83tg720_cache_reg *cache_reg =
+			&dp83tg720_cache_regs[i];
+
+		ret = phy_read_mmd(phydev, cache_reg->mmd, cache_reg->reg);
+		if (ret < 0)
+			return ret;
+
+		priv->reg_cache[i] = (u16)ret;
+	}
+
+	return 0;
+}
+
+/**
+ * dp83tg720_extract_stat_value - Extract specific statistic value from cache.
+ * @phydev: Pointer to the phy_device structure.
+ * @i: Index of the statistic in the dp83tg720_hw_stats array.
+ *
+ * Extracts the specific statistic value from the cached register values.
+ *
+ * Returns: The extracted statistic value.
+ */
+static u64 dp83tg720_extract_stat_value(struct phy_device *phydev, int i)
+{
+	const struct dp83tg720_hw_stat *stat = &dp83tg720_hw_stats[i];
+	struct dp83tg720_priv *priv = phydev->priv;
+	u32 val1, val2 = 0;
+
+	val1 = (priv->reg_cache[stat->cache_index1] & stat->mask1);
+	val1 >>= stat->shift1;
+	if (stat->cache_index2 != DP83TG720_CACHE_EMPTY) {
+		val2 = (priv->reg_cache[stat->cache_index2] & stat->mask2);
+		val2 >>= stat->shift2;
+	}
+
+	if (stat->flags & DP83TG720_FLAG_COUNTER)
+		priv->stats[i] += val1 | (val2 << 16);
+	else
+		priv->stats[i] = val1 | (val2 << 16);
+
+	return priv->stats[i];
+}
+
+/**
+ * dp83tg720_get_sset_count - Get the number of statistics sets.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * Returns: The number of statistics sets.
+ */
+static int dp83tg720_get_sset_count(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(dp83tg720_hw_stats);
+}
+
+/**
+ * dp83tg720_get_strings - Get the strings for the statistics.
+ * @phydev: Pointer to the phy_device structure.
+ * @data: Pointer to the buffer where the strings will be stored.
+ *
+ * Fills the buffer with the strings for the statistics
+ */
+static void dp83tg720_get_strings(struct phy_device *phydev, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dp83tg720_hw_stats); i++)
+		ethtool_puts(&data, dp83tg720_hw_stats[i].string);
+}
+
+/**
+ * dp83tg720_get_stats - Get the statistics values.
+ * @phydev: Pointer to the phy_device structure.
+ * @stats: Pointer to the ethtool_stats structure.
+ * @data: Pointer to the buffer where the statistics values will be stored.
+ *
+ * Fills the buffer with the statistics values, filtering out those that are
+ * not applicable based on the PHY's operating mode (e.g., RGMII).
+ */
+static void dp83tg720_get_stats(struct phy_device *phydev,
+				struct ethtool_stats *stats, u64 *data)
+{
+	int i, j = 0;
+
+	dp83tg720_cache_reg_values(phydev);
+
+	for (i = 0; i < ARRAY_SIZE(dp83tg720_hw_stats); i++) {
+		data[j] = dp83tg720_extract_stat_value(phydev, i);
+		j++;
+	}
+}
+
+/**
+ * dp83tg720_update_stats - Update the statistics values.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * Updates the statistics values.
+ */
+static void dp83tg720_update_stats(struct phy_device *phydev)
+{
+	int i;
+
+	dp83tg720_cache_reg_values(phydev);
+
+	for (i = 0; i < ARRAY_SIZE(dp83tg720_hw_stats); i++)
+		dp83tg720_extract_stat_value(phydev, i);
+}
+
 /**
  * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
  * @phydev: Pointer to the phy_device structure.
@@ -208,6 +517,7 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 	u16 phy_sts;
 	int ret;
 
+	dp83tg720_update_stats(phydev);
 	phydev->pause = 0;
 	phydev->asym_pause = 0;
 
@@ -341,12 +651,26 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
+static int dp83tg720_probe(struct phy_device *phydev)
+{
+	struct dp83tg720_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
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
@@ -355,6 +679,9 @@ static struct phy_driver dp83tg720_driver[] = {
 	.get_sqi_max	= dp83tg720_get_sqi_max,
 	.cable_test_start = dp83tg720_cable_test_start,
 	.cable_test_get_status = dp83tg720_cable_test_get_status,
+	.get_sset_count = dp83tg720_get_sset_count,
+	.get_strings	= dp83tg720_get_strings,
+	.get_stats	= dp83tg720_get_stats,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.2


