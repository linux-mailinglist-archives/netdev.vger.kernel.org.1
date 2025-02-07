Return-Path: <netdev+bounces-163931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89751A2C10B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C558188B9DD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B651DE8AE;
	Fri,  7 Feb 2025 10:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25D1DE4CE
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925787; cv=none; b=Yol+oWz0XhpUTB1KfFUEAEY/MhcLza1gKfYQtRIRh4/jwLvyWdXnExKBPVDtV8e5EWUQfTiUHCHQY8llssVCXjEZziKXFfg35BSEklMtny116CBpo9r9CpWhGp8peAHzMLwi1HB6cbUpQE4ONjyH1bw2FOcFfjdoN5/PcS7Y06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925787; c=relaxed/simple;
	bh=bLLFVr6Bm8Tegrq2cqZjHRigcihHscrYl+BIeOaDFRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HpmDwcq4PEhMbEGmb/w9wlTYjxwSNEfp2imF0/c6p6L/4x2tbSN6L9Xrs4V3fUmTx3yeXhtJIACowd5QFsvEvFKNjHndSVZuKmQDLKHNmlqqWw7i02WEsFpn1PuqXfRkqwb57QmLTl+aa9rUtz3jjeBhNh6Fnp/64H5r+drZEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tgM1w-00054w-LI; Fri, 07 Feb 2025 11:56:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tgM1r-003xhc-2o;
	Fri, 07 Feb 2025 11:56:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tgM1r-007rrW-2a;
	Fri, 07 Feb 2025 11:56:11 +0100
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
Subject: [PATCH net-next v2 1/1] net: sxgbe: rework EEE handling based on PHY negotiation
Date: Fri,  7 Feb 2025 11:56:10 +0100
Message-Id: <20250207105610.1875327-1-o.rempel@pengutronix.de>
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

Rework EEE handling to depend on PHY negotiation results. Enable EEE
only after a valid link is established and allow proper LPI mode
activation.

Previously, sxgbe_eee_init() was called in sxgbe_open() to invoke
phy_init_eee() most probably before the PHY could complete
auto-negotiation. Non-automotive PHYs typically take ~1 sec to
establish a link, so EEE was rarely enabled.

Now, EEE activation is deferred until after PHY negotiation.  The driver
delegates EEE control to phylib via ethtool set/get calls. Timer values
are taken from phydev->eee_cfg.tx_lpi_timer, and sxgbe_eee_adjust()
configures EEE based on phydev->enable_tx_lpi and the PHY link status.

This activation of LPI may reveal issues that were hidden when LPI was
rarely active.

WARNING: This patch is only compile tested.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- major rework with many changes
- use phydev->eee_cfg.tx_lpi_timer where possible
- drop sxgbe_eee_init() and rework sxgbe_eee_adjust()
---
 .../net/ethernet/samsung/sxgbe/sxgbe_common.h |  2 -
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    | 22 +-----
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   | 69 +++++++------------
 3 files changed, 26 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
index 1458939c3bf5..a8eed188d110 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
@@ -526,6 +526,4 @@ int sxgbe_restore(struct net_device *ndev);
 
 const struct sxgbe_mtl_ops *sxgbe_get_mtl_ops(void);
 
-void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv);
-bool sxgbe_eee_init(struct sxgbe_priv_data * const priv);
 #endif /* __SXGBE_COMMON_H__ */
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index 4a439b34114d..a13360962e47 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -140,8 +140,6 @@ static int sxgbe_get_eee(struct net_device *dev,
 	if (!priv->hw_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->tx_lpi_timer = priv->tx_lpi_timer;
-
 	return phy_ethtool_get_eee(dev->phydev, edata);
 }
 
@@ -150,22 +148,8 @@ static int sxgbe_set_eee(struct net_device *dev,
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
+	if (!priv->hw_cap.eee)
+		return -EOPNOTSUPP;
 
 	return phy_ethtool_set_eee(dev->phydev, edata);
 }
@@ -228,7 +212,7 @@ static void sxgbe_get_ethtool_stats(struct net_device *dev,
 	int i;
 	char *p;
 
-	if (priv->eee_enabled) {
+	if (dev->phydev->eee_active) {
 		int val = phy_get_eee_err(dev->phydev);
 
 		if (val)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 12c8396b6942..8a385c92a6d1 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -87,7 +87,7 @@ static void sxgbe_enable_eee_mode(const struct sxgbe_priv_data *priv)
 		priv->hw->mac->set_eee_mode(priv->ioaddr);
 }
 
-void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv)
+static void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv)
 {
 	/* Exit and disable EEE in case of we are in LPI state. */
 	priv->hw->mac->reset_eee_mode(priv->ioaddr);
@@ -110,52 +110,25 @@ static void sxgbe_eee_ctrl_timer(struct timer_list *t)
 	mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
 }
 
-/**
- * sxgbe_eee_init
- * @priv: private device pointer
- * Description:
- *  If the EEE support has been enabled while configuring the driver,
- *  if the GMAC actually supports the EEE (from the HW cap reg) and the
- *  phy can also manage EEE, so enable the LPI state and start the timer
- *  to verify if the tx path can enter in LPI state.
- */
-bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
+static void sxgbe_eee_adjust(struct sxgbe_priv_data *priv)
 {
-	struct net_device *ndev = priv->dev;
-	bool ret = false;
+	struct phy_device *phydev = priv->dev->phydev;
 
-	/* MAC core supports the EEE feature. */
-	if (priv->hw_cap.eee) {
-		/* Check if the PHY supports EEE */
-		if (phy_init_eee(ndev->phydev, true))
-			return false;
+	if (!priv->hw_cap.eee)
+		return;
 
-		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
-		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
+	if (phydev->enable_tx_lpi) {
 		add_timer(&priv->eee_ctrl_timer);
-
 		priv->hw->mac->set_eee_timer(priv->ioaddr,
 					     SXGBE_DEFAULT_LPI_TIMER,
-					     priv->tx_lpi_timer);
-
-		pr_info("Energy-Efficient Ethernet initialized\n");
-
-		ret = true;
+					     phydev->eee_cfg.tx_lpi_timer);
+		priv->eee_enabled = true;
+	} else {
+		sxgbe_disable_eee_mode(priv);
+		priv->eee_enabled = false;
 	}
 
-	return ret;
-}
-
-static void sxgbe_eee_adjust(const struct sxgbe_priv_data *priv)
-{
-	struct net_device *ndev = priv->dev;
-
-	/* When the EEE has been already initialised we have to
-	 * modify the PLS bit in the LPI ctrl & status reg according
-	 * to the PHY link status. For this reason.
-	 */
-	if (priv->eee_enabled)
-		priv->hw->mac->set_eee_pls(priv->ioaddr, ndev->phydev->link);
+	priv->hw->mac->set_eee_pls(priv->ioaddr, phydev->link);
 }
 
 /**
@@ -301,6 +274,16 @@ static int sxgbe_init_phy(struct net_device *ndev)
 		return -ENODEV;
 	}
 
+	if (priv->hw_cap.eee) {
+		phy_support_eee(phydev);
+		phy_eee_rx_clock_stop(priv->dev->phydev, true);
+		phydev->eee_cfg.tx_lpi_timer = SXGBE_DEFAULT_LPI_TIMER;
+
+		/* configure timer which will be used for LPI handling */
+		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
+		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
+	}
+
 	netdev_dbg(ndev, "%s: attached to PHY (UID 0x%x) Link = %d\n",
 		   __func__, phydev->phy_id, phydev->link);
 
@@ -802,7 +785,7 @@ static void sxgbe_tx_all_clean(struct sxgbe_priv_data * const priv)
 		sxgbe_tx_queue_clean(tqueue);
 	}
 
-	if ((priv->eee_enabled) && (!priv->tx_path_in_lpi_mode)) {
+	if (priv->eee_enabled && !priv->tx_path_in_lpi_mode) {
 		sxgbe_enable_eee_mode(priv);
 		mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
 	}
@@ -1179,9 +1162,6 @@ static int sxgbe_open(struct net_device *dev)
 		priv->hw->dma->rx_watchdog(priv->ioaddr, SXGBE_MAX_DMA_RIWT);
 	}
 
-	priv->tx_lpi_timer = SXGBE_DEFAULT_LPI_TIMER;
-	priv->eee_enabled = sxgbe_eee_init(priv);
-
 	napi_enable(&priv->napi);
 	netif_start_queue(dev);
 
@@ -1207,9 +1187,6 @@ static int sxgbe_release(struct net_device *dev)
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
-	if (priv->eee_enabled)
-		del_timer_sync(&priv->eee_ctrl_timer);
-
 	/* Stop and disconnect the PHY */
 	if (dev->phydev) {
 		phy_stop(dev->phydev);
-- 
2.39.5


