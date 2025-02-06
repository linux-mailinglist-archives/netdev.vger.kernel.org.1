Return-Path: <netdev+bounces-163404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33333A2A2CB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F46F1881B8F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80B225419;
	Thu,  6 Feb 2025 07:59:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40ED2248BB
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828751; cv=none; b=e96YpkM2vEfZotEOXyEKsQ1e2MupROWqb8Pd7P+sJDlDT6k/11CHDuHbYMIDIdX9btbTOqr0nGHHHVM7QjxEIjwDlbobFebpxcjJWs6nTV+EQfIlDX9BddeJkK2xJumYm6D3bO8aofDFHyMxWvBjC9PWL/c7ymrBjA4xwaEV5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828751; c=relaxed/simple;
	bh=RXB09qfNVWHTz9HJ1pk+pLQhraOtSjdlBr1wimA9ayE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MzYxv4ayqoxJIiQaGPeEnIv31Rk7YQuczcOxdcBkuT8sMZKj8zGLOd0lHG4pvAz3q9mrbBTaJBLrH+02sdT16bcMyx5CcQdVPW76QWpRxfApH1UzLjhkDqCTZUGzDYjTKwz/EL1kKpRTKLO6l9hzeljECNSObrq22P9R1Dqc240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfwmp-0003Ty-5o; Thu, 06 Feb 2025 08:58:59 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfwmo-003lis-0J;
	Thu, 06 Feb 2025 08:58:58 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfwmo-00Dhep-03;
	Thu, 06 Feb 2025 08:58:58 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Byungho An <bh74.an@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 1/1] net: sxgbe: rework EEE handling to use PHY negotiation results
Date: Thu,  6 Feb 2025 08:58:56 +0100
Message-Id: <20250206075856.3266068-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

From: Andrew Lunn <andrew@lunn.ch>

The enabling/disabling of EEE in the MAC should happen as a result of
auto negotiation. So rework sxgbe_eee_adjust() to take the result of
negotiation into account.

sxgbe_set_eee() now just stores LTI timer value. Everything else is
passed to phylib, so it can correctly setup the PHY.

sxgbe_get_eee() relies on phylib doing most of the work, the MAC
driver just adds the LTI timer value.

The hw_cap.eee is now used to control timers, rather than eee_enabled,
which was wrongly being set based on the value of phy_init_eee()
before auto-neg even completed.

WARNING: This patch is only compile tested.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../net/ethernet/samsung/sxgbe/sxgbe_common.h |  2 -
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    | 19 +---------
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   | 38 +++++++------------
 3 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
index 1458939c3bf5..a9e964142c9c 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
@@ -502,7 +502,6 @@ struct sxgbe_priv_data {
 	struct timer_list eee_ctrl_timer;
 	bool tx_path_in_lpi_mode;
 	int lpi_irq;
-	int eee_enabled;
 	int tx_lpi_timer;
 };
 
@@ -527,5 +526,4 @@ int sxgbe_restore(struct net_device *ndev);
 const struct sxgbe_mtl_ops *sxgbe_get_mtl_ops(void);
 
 void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv);
-bool sxgbe_eee_init(struct sxgbe_priv_data * const priv);
 #endif /* __SXGBE_COMMON_H__ */
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index 4a439b34114d..263f1070cbed 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -150,22 +150,7 @@ static int sxgbe_set_eee(struct net_device *dev,
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
-	priv->eee_enabled = edata->eee_enabled;
-
-	if (!priv->eee_enabled) {
-		sxgbe_disable_eee_mode(priv);
-	} else {
-		/* We are asking for enabling the EEE but it is safe
-		 * to verify all by invoking the eee_init function.
-		 * In case of failure it will return an error.
-		 */
-		priv->eee_enabled = sxgbe_eee_init(priv);
-		if (!priv->eee_enabled)
-			return -EOPNOTSUPP;
-
-		/* Do not change tx_lpi_timer in case of failure */
-		priv->tx_lpi_timer = edata->tx_lpi_timer;
-	}
+	priv->tx_lpi_timer = edata->tx_lpi_timer;
 
 	return phy_ethtool_set_eee(dev->phydev, edata);
 }
@@ -228,7 +213,7 @@ static void sxgbe_get_ethtool_stats(struct net_device *dev,
 	int i;
 	char *p;
 
-	if (priv->eee_enabled) {
+	if (dev->phydev->eee_active) {
 		int val = phy_get_eee_err(dev->phydev);
 
 		if (val)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 12c8396b6942..b306e12ac6bf 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -119,17 +119,10 @@ static void sxgbe_eee_ctrl_timer(struct timer_list *t)
  *  phy can also manage EEE, so enable the LPI state and start the timer
  *  to verify if the tx path can enter in LPI state.
  */
-bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
+static void sxgbe_eee_init(struct sxgbe_priv_data * const priv)
 {
-	struct net_device *ndev = priv->dev;
-	bool ret = false;
-
 	/* MAC core supports the EEE feature. */
 	if (priv->hw_cap.eee) {
-		/* Check if the PHY supports EEE */
-		if (phy_init_eee(ndev->phydev, true))
-			return false;
-
 		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
 		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
 		add_timer(&priv->eee_ctrl_timer);
@@ -139,23 +132,15 @@ bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
 					     priv->tx_lpi_timer);
 
 		pr_info("Energy-Efficient Ethernet initialized\n");
-
-		ret = true;
 	}
-
-	return ret;
 }
 
-static void sxgbe_eee_adjust(const struct sxgbe_priv_data *priv)
+static void sxgbe_eee_adjust(const struct sxgbe_priv_data *priv,
+			     bool eee_active)
 {
-	struct net_device *ndev = priv->dev;
-
-	/* When the EEE has been already initialised we have to
-	 * modify the PLS bit in the LPI ctrl & status reg according
-	 * to the PHY link status. For this reason.
-	 */
-	if (priv->eee_enabled)
-		priv->hw->mac->set_eee_pls(priv->ioaddr, ndev->phydev->link);
+	if (priv->hw_cap.eee)
+		priv->hw->mac->set_eee_pls(priv->ioaddr, eee_active);
+	phy_eee_rx_clock_stop(priv->dev->phydev, true);
 }
 
 /**
@@ -249,7 +234,7 @@ static void sxgbe_adjust_link(struct net_device *dev)
 		phy_print_status(phydev);
 
 	/* Alter the MAC settings for EEE */
-	sxgbe_eee_adjust(priv);
+	sxgbe_eee_adjust(priv, phydev->eee_active);
 }
 
 /**
@@ -296,6 +281,9 @@ static int sxgbe_init_phy(struct net_device *ndev)
 	    (phy_iface == PHY_INTERFACE_MODE_RMII))
 		phy_set_max_speed(phydev, SPEED_1000);
 
+	if (priv->hw_cap.eee)
+		phy_support_eee(phydev);
+
 	if (phydev->phy_id == 0) {
 		phy_disconnect(phydev);
 		return -ENODEV;
@@ -802,7 +790,7 @@ static void sxgbe_tx_all_clean(struct sxgbe_priv_data * const priv)
 		sxgbe_tx_queue_clean(tqueue);
 	}
 
-	if ((priv->eee_enabled) && (!priv->tx_path_in_lpi_mode)) {
+	if (priv->hw_cap.eee && !priv->tx_path_in_lpi_mode) {
 		sxgbe_enable_eee_mode(priv);
 		mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
 	}
@@ -1180,7 +1168,7 @@ static int sxgbe_open(struct net_device *dev)
 	}
 
 	priv->tx_lpi_timer = SXGBE_DEFAULT_LPI_TIMER;
-	priv->eee_enabled = sxgbe_eee_init(priv);
+	sxgbe_eee_init(priv);
 
 	napi_enable(&priv->napi);
 	netif_start_queue(dev);
@@ -1207,7 +1195,7 @@ static int sxgbe_release(struct net_device *dev)
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
-	if (priv->eee_enabled)
+	if (priv->hw_cap.eee)
 		del_timer_sync(&priv->eee_ctrl_timer);
 
 	/* Stop and disconnect the PHY */
-- 
2.39.5


