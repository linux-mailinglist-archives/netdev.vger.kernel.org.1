Return-Path: <netdev+bounces-120955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3695B476
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48F5283F69
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3651CB131;
	Thu, 22 Aug 2024 12:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48A1C9EDA
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328004; cv=none; b=J72V7STLmq/kh2sZCkflkyD++kb0NMLEHNTYTvEdUTI8QliQru7g9wHULN1YGFKDgIawpyIY2h77OGfJo9yQTYgctL9LLPNyKDzJMa5TstKfMQnj82efEfNQghlzZtAavm4ws+S8QD1J5noUmHeyGz/1U4njt2xdjrX0eZhRN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328004; c=relaxed/simple;
	bh=1um7bip5EkIlJn3kWPC8VoCHBHi06nTjZFk0wC/q+38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjMYEnTV1eHgq5JX/RoQ2dp3HfuAYLklgT7jQS2JT8H1SY8Xe2qaNbNri7VpRTikWQIpocY/WDTgcEcJFYQJG1Jw9YCpI/0oNaIsjIDhGd3d66d+zAbFi59OpjISJA5Gihj+XTbVEaKC0YtpGEg4BhDvQ68IaeVDMg2+0bGnjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Te-0005oy-WB; Thu, 22 Aug 2024 13:59:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-002EyT-5p; Thu, 22 Aug 2024 13:59:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-005oqB-0M;
	Thu, 22 Aug 2024 13:59:41 +0200
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
Subject: [PATCH net-next v3 3/3] phy: dp83tg720: Add statistics support
Date: Thu, 22 Aug 2024 13:59:39 +0200
Message-Id: <20240822115939.1387015-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822115939.1387015-1-o.rempel@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
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
changes v3:
- update comment for dp83tg720_get_stats()
changes v2:
- use ethtool_puts()
- use defines for statistic names
---
 drivers/net/phy/dp83tg720.c | 324 ++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 0ef4d7dba0656..43d7febdfd772 100644
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
 
@@ -69,6 +101,280 @@
 
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
@@ -208,6 +514,7 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 	u16 phy_sts;
 	int ret;
 
+	dp83tg720_update_stats(phydev);
 	phydev->pause = 0;
 	phydev->asym_pause = 0;
 
@@ -341,12 +648,26 @@ static int dp83tg720_config_init(struct phy_device *phydev)
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
@@ -355,6 +676,9 @@ static struct phy_driver dp83tg720_driver[] = {
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


