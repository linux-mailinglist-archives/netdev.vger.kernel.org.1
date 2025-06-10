Return-Path: <netdev+bounces-196011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31245AD318B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8D31730F7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608A28C86D;
	Tue, 10 Jun 2025 09:14:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663128C848
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546856; cv=none; b=gu5qtjvOWDI3p5/fcHPhKuZlqiqk8mkI8JMD8EapdpHfCgfqqNzZrHdD4BwtNVxjor170yJweVyQmrWv8ihFJIYOXg99NxcOwrkL+ZMURXjHmmj+pIlmD1VfVBcwhWNyb92UbQ93B7R5Zkra68C7/GkSp8b5NcvFRHY+yGWS5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546856; c=relaxed/simple;
	bh=Q62Wl2/b0pdmfIYmgYrXdZoIFmo/FdG0nsq1moxUNOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmVspy877wSS5Erl2A0a2AEmE9EU9Q0d0ZI6WCczxjJMOnWUMap8V4iPBM5t1lPd5uL4b8ewPEsxXB57m1q0CGkr2TqFxeGL5UiYq/GW3r8etIxwDvQPyxdD8V0e07skF8T5yThgXu24kdhuJksda1joiS3wtN61CzkLp1Lymdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3M-000489-VX; Tue, 10 Jun 2025 11:13:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-002kQJ-1k;
	Tue, 10 Jun 2025 11:13:55 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-00H2KF-1V;
	Tue, 10 Jun 2025 11:13:55 +0200
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
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 2/3] net: phy: micrel: Add RX error counter support for KSZ9477 switch-integrated PHYs
Date: Tue, 10 Jun 2025 11:13:53 +0200
Message-Id: <20250610091354.4060454-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610091354.4060454-1-o.rempel@pengutronix.de>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
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

Add support for tracking receive error statistics from PHYs integrated
into the KSZ9477 family of Ethernet switches.

The integrated PHYs expose a receive error (RXER) counter in register 0x15.
This counter increments when the PHY detects one or more symbol errors
on a received frame. The register is cleared upon reading.

Changes include:
- `kszphy_update_stats()` to accumulate the RX error count.
- `kszphy_get_phy_stats()` to expose this count via ethtool PHY stats.
- Addition of a private `rx_err_pkt_cnt` field in the driver.
- Registration of `.update_stats` and `.get_phy_stats` callbacks in the
  KSZ9477 PHY driver structure.

The functionality of this counter was confirmed by physically disturbing
the signal lines - specifically by wiggling exposed twisted pair wires and
intentionally shorting between pairs. These actions triggered RXER
increments, validating the counter's behavior.

This RXER counter is confirmed for KSZ9477 and likely applicable to
other related PHYs like those in KSZ9313.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index a51010e64444..68d86383e6c7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -431,6 +431,10 @@ struct kszphy_ptp_priv {
 	spinlock_t seconds_lock;
 };
 
+struct kszphy_phy_stats {
+	u64 rx_err_pkt_cnt;
+};
+
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
@@ -441,6 +445,7 @@ struct kszphy_priv {
 	bool rmii_ref_clk_sel_val;
 	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
+	struct kszphy_phy_stats phy_stats;
 };
 
 static const struct kszphy_type lan8814_type = {
@@ -2130,6 +2135,35 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+/* KSZ9477 PHY RXER Counter. Probably supported by other PHYs like KSZ9313,
+ * etc. The counter is incremented when the PHY receives a frame with one or
+ * more symbol errors. The counter is cleared when the register is read.
+ */
+#define MII_KSZ9477_PHY_RXER_COUNTER	0x15
+
+static int kszphy_update_stats(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = phy_read(phydev, MII_KSZ9477_PHY_RXER_COUNTER);
+	if (ret < 0)
+		return ret;
+
+	priv->phy_stats.rx_err_pkt_cnt += ret;
+
+	return 0;
+}
+
+static void kszphy_get_phy_stats(struct phy_device *phydev,
+				 struct ethtool_eth_phy_stats *eth_stats,
+				 struct ethtool_phy_stats *stats)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	stats->rx_errors = priv->phy_stats.rx_err_pkt_cnt;
+}
+
 static void kszphy_enable_clk(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -5745,6 +5779,7 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id		= PHY_ID_KSZ9477,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip KSZ9477",
+	.probe		= kszphy_probe,
 	/* PHY_GBIT_FEATURES */
 	.config_init	= ksz9477_config_init,
 	.config_intr	= kszphy_config_intr,
@@ -5753,6 +5788,8 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= ksz9477_resume,
+	.get_phy_stats	= kszphy_get_phy_stats,
+	.update_stats	= kszphy_update_stats,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.39.5


