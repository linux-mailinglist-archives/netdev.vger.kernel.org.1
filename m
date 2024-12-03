Return-Path: <netdev+bounces-148397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C49E14C0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1551E1623F1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FC21DEFC2;
	Tue,  3 Dec 2024 07:56:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E01DD9AD
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212606; cv=none; b=cfKQqm6aZ4SqLdavjK/lgIncjZhev6BrjR9MTrXAQktvDehMLIl6DzgEA5X/bYmlSn7n/DH9eLLYIvBy+I93J/t4jMRRSSBxhlxJzLQo5/5LqJaJj1e2HDNxC+3VGiotVb2AuipduIfF8jqUczeotpq+WL5tN8krMLPTWKywFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212606; c=relaxed/simple;
	bh=KvgKfIw/lL22aGiulcuLraD/URWJ60B/wcfyKrnFy2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8sDPZK+EBvyKfohHg9WAKEympK3m7bo2BhFtwEi4YEWjIsmHYh1HVT/PWYOrw1J/ryTQw2XCgyEtVe8jhov3VPYyW6dMwVd8WiayP/ArC1Izi/8QyPfKU6RpevlAZWN8sYl3sUFirVo/OtdMGfQUiuxKEgECafvkBoq40KugOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINlj-000398-Kl; Tue, 03 Dec 2024 08:56:27 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-001R94-0v;
	Tue, 03 Dec 2024 08:56:23 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-00AHwd-37;
	Tue, 03 Dec 2024 08:56:22 +0100
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
Subject: [PATCH net-next v1 6/7] phy: dp83td510: add statistics support
Date: Tue,  3 Dec 2024 08:56:20 +0100
Message-Id: <20241203075622.2452169-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203075622.2452169-1-o.rempel@pengutronix.de>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
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
 drivers/net/phy/dp83td510.c | 98 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 92aa3a2b9744..08d61a6a8c61 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -34,6 +34,24 @@
 #define DP83TD510E_CTRL_HW_RESET		BIT(15)
 #define DP83TD510E_CTRL_SW_RESET		BIT(14)
 
+#define DP83TD510E_PKT_STAT_1			0x12b
+#define DP83TD510E_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
+
+#define DP83TD510E_PKT_STAT_2			0x12c
+#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
+
+#define DP83TD510E_PKT_STAT_3			0x12d
+#define DP83TD510E_TX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
+
+#define DP83TD510E_PKT_STAT_4			0x12e
+#define DP83TD510E_RX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
+
+#define DP83TD510E_PKT_STAT_5			0x12f
+#define DP83TD510E_RX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
+
+#define DP83TD510E_PKT_STAT_6			0x130
+#define DP83TD510E_RX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
+
 #define DP83TD510E_AN_STAT_1			0x60c
 #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
 
@@ -58,8 +76,16 @@ static const u16 dp83td510_mse_sqi_map[] = {
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
@@ -177,6 +203,74 @@ struct dp83td510_priv {
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
+	u64 count;
+	int ret;
+
+	/* DP83TD510E_PKT_STAT_1 to DP83TD510E_PKT_STAT_6 registers are cleared
+	 * after reading them in a sequence. A reading of this register not in
+	 * sequence will prevent them from being cleared.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_1);
+	if (ret < 0)
+		return ret;
+	count = FIELD_GET(DP83TD510E_TX_PKT_CNT_15_0_MASK, ret);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_2);
+	if (ret < 0)
+		return ret;
+	count |= (u64)FIELD_GET(DP83TD510E_TX_PKT_CNT_31_16_MASK, ret) << 16;
+	ethtool_stat_add(&priv->stats.tx_pkt_cnt, count);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_3);
+	if (ret < 0)
+		return ret;
+	count = FIELD_GET(DP83TD510E_TX_ERR_PKT_CNT_MASK, ret);
+	ethtool_stat_add(&priv->stats.tx_err_pkt_cnt, count);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_4);
+	if (ret < 0)
+		return ret;
+	count = FIELD_GET(DP83TD510E_RX_PKT_CNT_15_0_MASK, ret);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_5);
+	if (ret < 0)
+		return ret;
+	count |= (u64)FIELD_GET(DP83TD510E_RX_PKT_CNT_31_16_MASK, ret) << 16;
+	ethtool_stat_add(&priv->stats.rx_pkt_cnt, count);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_6);
+	if (ret < 0)
+		return ret;
+	count = FIELD_GET(DP83TD510E_RX_ERR_PKT_CNT_MASK, ret);
+	ethtool_stat_add(&priv->stats.rx_err_pkt_cnt, count);
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
@@ -588,7 +682,7 @@ static struct phy_driver dp83td510_driver[] = {
 	PHY_ID_MATCH_MODEL(DP83TD510E_PHY_ID),
 	.name		= "TI DP83TD510E",
 
-	.flags          = PHY_POLL_CABLE_TEST,
+	.flags          = PHY_POLL_CABLE_TEST | PHY_POLL_STATS,
 	.probe		= dp83td510_probe,
 	.config_aneg	= dp83td510_config_aneg,
 	.read_status	= dp83td510_read_status,
@@ -599,6 +693,8 @@ static struct phy_driver dp83td510_driver[] = {
 	.get_sqi_max	= dp83td510_get_sqi_max,
 	.cable_test_start = dp83td510_cable_test_start,
 	.cable_test_get_status = dp83td510_cable_test_get_status,
+	.get_phy_stats	= dp83td510_get_phy_stats,
+	.update_stats	= dp83td510_update_stats,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.5


