Return-Path: <netdev+bounces-153357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28269F7C37
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3761890068
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE181224AF9;
	Thu, 19 Dec 2024 13:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F6111AD
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614754; cv=none; b=XdV201gc10e55WBV2dm580UptaF9u3vWcx7pJVzJHljsZFfQYoZXcL8WIofmUeuoQuumphgPKBTUYGYWfTZl1u3U8+W3/PTb5KPsd95Vv2Mu25zTrqvdLihAdVi7TExItJpoSUJMmAdlMXG1cna9XGTLktWyRR4CFDpR3gZirEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614754; c=relaxed/simple;
	bh=9rPX7enLQubJau7pA8Xr9gZgChYKgAcHlbg/6SijClA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtvRFHzDRT0nO90qfYbQJ6iIUXQk28t5W+LWmVZMBW9VZabrP9mvJwLux4vevcQw6IqHRu5gJb0wbUxmgZaEcxnMo5i15kRB8Ww29e265RRynfiTmi5l4vwDDZelCYmeWSwmpfkAgyFxYP9Kyu+5bvZI8dRsD1ZDRvN8JG+1e2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX5-0001bC-Of; Thu, 19 Dec 2024 14:25:39 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX0-004DDJ-29;
	Thu, 19 Dec 2024 14:25:35 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX1-0032j3-15;
	Thu, 19 Dec 2024 14:25:35 +0100
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
Subject: [PATCH net-next v2 7/8] net: phy: dp83td510: add statistics support
Date: Thu, 19 Dec 2024 14:25:33 +0100
Message-Id: <20241219132534.725051-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219132534.725051-1-o.rempel@pengutronix.de>
References: <20241219132534.725051-1-o.rempel@pengutronix.de>
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

Add support for reporting PHY statistics in the DP83TD510 driver. This
includes cumulative tracking of transmit/receive packet counts, and
error counts. Implemented functions to update and provide statistics via
ethtool, with optional polling support enabled through `PHY_POLL_STATS`.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- drop use of FIELD_GET
- add comments
---
 drivers/net/phy/dp83td510.c | 112 ++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 92aa3a2b9744..2edda7c231fc 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -34,6 +34,29 @@
 #define DP83TD510E_CTRL_HW_RESET		BIT(15)
 #define DP83TD510E_CTRL_SW_RESET		BIT(14)
 
+/*
+ * DP83TD510E_PKT_STAT_x registers correspond to similarly named registers
+ * in the datasheet (PKT_STAT_1 through PKT_STAT_6). These registers store
+ * 32-bit or 16-bit counters for TX and RX statistics and must be read in
+ * sequence to ensure the counters are cleared correctly.
+ *
+ * - DP83TD510E_PKT_STAT_1: Contains TX packet count bits [15:0].
+ * - DP83TD510E_PKT_STAT_2: Contains TX packet count bits [31:16].
+ * - DP83TD510E_PKT_STAT_3: Contains TX error packet count.
+ * - DP83TD510E_PKT_STAT_4: Contains RX packet count bits [15:0].
+ * - DP83TD510E_PKT_STAT_5: Contains RX packet count bits [31:16].
+ * - DP83TD510E_PKT_STAT_6: Contains RX error packet count.
+ *
+ * Keeping the register names as defined in the datasheet helps maintain
+ * clarity and alignment with the documentation.
+ */
+#define DP83TD510E_PKT_STAT_1			0x12b
+#define DP83TD510E_PKT_STAT_2			0x12c
+#define DP83TD510E_PKT_STAT_3			0x12d
+#define DP83TD510E_PKT_STAT_4			0x12e
+#define DP83TD510E_PKT_STAT_5			0x12f
+#define DP83TD510E_PKT_STAT_6			0x130
+
 #define DP83TD510E_AN_STAT_1			0x60c
 #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
 
@@ -58,8 +81,16 @@ static const u16 dp83td510_mse_sqi_map[] = {
 	0x0000  /* 24dB =< SNR */
 };
 
+struct dp83td510_stats {
+	u64 tx_pkt_cnt;
+	u64 tx_err_pkt_cnt;
+	u64 rx_pkt_cnt;
+	u64 rx_err_pkt_cnt;
+};
+
 struct dp83td510_priv {
 	bool alcd_test_active;
+	struct dp83td510_stats stats;
 };
 
 /* Time Domain Reflectometry (TDR) Functionality of DP83TD510 PHY
@@ -177,6 +208,85 @@ struct dp83td510_priv {
 #define DP83TD510E_ALCD_COMPLETE			BIT(15)
 #define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
 
+/**
+ * dp83td510_update_stats - Update the PHY statistics for the DP83TD510 PHY.
+ * @phydev: Pointer to the phy_device structure.
+ *
+ * The function reads the PHY statistics registers and updates the statistics
+ * structure.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static int dp83td510_update_stats(struct phy_device *phydev)
+{
+	struct dp83td510_priv *priv = phydev->priv;
+	u32 count;
+	int ret;
+
+	/* The DP83TD510E_PKT_STAT registers are divided into two groups:
+	 * - Group 1 (TX stats): DP83TD510E_PKT_STAT_1 to DP83TD510E_PKT_STAT_3
+	 * - Group 2 (RX stats): DP83TD510E_PKT_STAT_4 to DP83TD510E_PKT_STAT_6
+	 *
+	 * Registers in each group are cleared only after reading them in a
+	 * plain sequence (e.g., 1, 2, 3 for Group 1 or 4, 5, 6 for Group 2).
+	 * Any deviation from the sequence, such as reading 1, 2, 1, 2, 3, will
+	 * prevent the group from being cleared. Additionally, the counters
+	 * for a group are frozen as soon as the first register in that group
+	 * is accessed.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_1);
+	if (ret < 0)
+		return ret;
+	/* tx_pkt_cnt_15_0 */
+	count = ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_2);
+	if (ret < 0)
+		return ret;
+	/* tx_pkt_cnt_31_16 */
+	count |= ret << 16;
+	ethtool_stat_add(&priv->stats.tx_pkt_cnt, count);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_3);
+	if (ret < 0)
+		return ret;
+	/* tx_err_pkt_cnt */
+	ethtool_stat_add(&priv->stats.tx_err_pkt_cnt, ret);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_4);
+	if (ret < 0)
+		return ret;
+	/* rx_pkt_cnt_15_0 */
+	count = ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_5);
+	if (ret < 0)
+		return ret;
+	/* rx_pkt_cnt_31_16 */
+	count |= ret << 16;
+	ethtool_stat_add(&priv->stats.rx_pkt_cnt, count);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_6);
+	if (ret < 0)
+		return ret;
+	/* rx_err_pkt_cnt */
+	ethtool_stat_add(&priv->stats.rx_err_pkt_cnt, ret);
+
+	return 0;
+}
+
+static void dp83td510_get_phy_stats(struct phy_device *phydev,
+				    struct ethtool_eth_phy_stats *eth_stats,
+				    struct ethtool_phy_stats *stats)
+{
+	struct dp83td510_priv *priv = phydev->priv;
+
+	stats->tx_packets = priv->stats.tx_pkt_cnt;
+	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
+	stats->rx_packets = priv->stats.rx_pkt_cnt;
+	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
+}
+
 static int dp83td510_config_intr(struct phy_device *phydev)
 {
 	int ret;
@@ -599,6 +709,8 @@ static struct phy_driver dp83td510_driver[] = {
 	.get_sqi_max	= dp83td510_get_sqi_max,
 	.cable_test_start = dp83td510_cable_test_start,
 	.cable_test_get_status = dp83td510_cable_test_get_status,
+	.get_phy_stats	= dp83td510_get_phy_stats,
+	.update_stats	= dp83td510_update_stats,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.5


