Return-Path: <netdev+bounces-225335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345BB9254C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4777A6530
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D572431329C;
	Mon, 22 Sep 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U988POcJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695841400E
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560427; cv=none; b=AJnBoxcy2zRGo7k6OcLN/rN8HfjcARuyDYbL+rcgyr+OA8nh94XJIYArjlrDsbNIo97xdcLEvQJFzzjh+JyAXTT55EU4rDvYFR/wGtFgF6iJa8xXk1T8cUbjKOU2D1V5ZsplBRNc2GYFUhRXC7xOECcDvnaScs0JByYaYZ0vyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560427; c=relaxed/simple;
	bh=8uUq4f5IMJyH0U9RZZZArVdUiAkJ/iV593oWGoTm53o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHxDdebJFf7n/wMWltkli436rjEfxWjIsrVl7wi3dcoFp54VBmnhjw9RUl9qkJqAjxSq3MGR76/J5XL/37AZgl2b8Y2vW368v+fIS/NoB8/ugM1vNXqf/m+lNT/BEnCyGFODfVD+Ny+xjH1vbGqkbVhz4A18AaL4wUHtCx8bcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U988POcJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758560422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcuGc5LEZuOR60DCtoH2KUp41GelZDQcEbs9OvcBqVw=;
	b=U988POcJ+VV5l4aOtxaZnfbQdJF/KBWvwItcjeoXDAnpxJi53wuHxjURh2bk9RygXE2/T6
	HT0SWYf4pPuiCb+0F3XEeH/8Quaujo2CAUE4lyD3YKJvdM5d2OmPHYcYjoIIh7RZh+IZ5W
	ohLvOQlzBYbzXUHw3KFry41kIX8hnrk=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] mlx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 22 Sep 2025 16:51:17 +0000
Message-ID: <20250922165118.10057-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert mlx5 driver to use new timestamping configuration API.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 13 +++--
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 47 +++++++------------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 17 +------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  1 -
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |  9 +---
 .../ethernet/mellanox/mlx5/core/lib/clock.h   | 14 +++---
 10 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 4ffbc263d60f..eca0712150d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -696,7 +696,7 @@ struct mlx5e_rq {
 	struct mlx5e_rq_stats *stats;
 	struct mlx5e_cq        cq;
 	struct mlx5e_cq_decomp cqd;
-	struct hwtstamp_config *tstamp;
+	struct kernel_hwtstamp_config *tstamp;
 	struct mlx5_clock      *clock;
 	struct mlx5e_icosq    *icosq;
 	struct mlx5e_priv     *priv;
@@ -784,7 +784,7 @@ struct mlx5e_channel {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
+	struct kernel_hwtstamp_config *tstamp;
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 	int                        ix;
 	int                        vec_ix;
@@ -918,7 +918,7 @@ struct mlx5e_priv {
 	u8                         max_opened_tc;
 	bool                       tx_ptp_opened;
 	bool                       rx_ptp_opened;
-	struct hwtstamp_config     tstamp;
+	struct kernel_hwtstamp_config tstamp;
 	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
 	u16                        drop_rq_q_counter;
 	struct notifier_block      events_nb;
@@ -1026,8 +1026,11 @@ void mlx5e_self_test(struct net_device *ndev, struct ethtool_test *etest,
 		     u64 *buf);
 void mlx5e_set_rx_mode_work(struct work_struct *work);
 
-int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr);
-int mlx5e_hwstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr);
+int mlx5e_hwstamp_set(struct net_device *dev,
+		      struct kernel_hwtstamp_config *config,
+		      struct netlink_ext_ack *extack);
+int mlx5e_hwstamp_get(struct net_device *dev,
+		      struct kernel_hwtstamp_config *config);
 int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool val, bool rx_filter);
 
 int mlx5e_vlan_rx_add_vid(struct net_device *dev, __always_unused __be16 proto,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 1b3c9648220b..abc1f203ecb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -64,7 +64,7 @@ struct mlx5e_ptp {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
+	struct kernel_hwtstamp_config *tstamp;
 	DECLARE_BITMAP(state, MLX5E_PTP_STATE_NUM_STATES);
 	struct mlx5_sq_bfreg      *bfreg;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
index aa3f17658c6d..fe30fe30a47c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
@@ -22,7 +22,7 @@ struct mlx5e_trap {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
+	struct kernel_hwtstamp_config *tstamp;
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 
 	struct mlx5e_params        params;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 6760bb0336df..7e191e1569e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -92,7 +92,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget);
 void mlx5e_free_rx_descs(struct mlx5e_rq *rq);
 void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq);
 
-static inline bool mlx5e_rx_hw_stamp(struct hwtstamp_config *config)
+static inline bool mlx5e_rx_hw_stamp(struct kernel_hwtstamp_config *config)
 {
 	return config->rx_filter == HWTSTAMP_FILTER_ALL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e007bb3bad1..74a63371ab69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4755,9 +4755,11 @@ static int mlx5e_hwstamp_config_ptp_rx(struct mlx5e_priv *priv, bool ptp_rx)
 					&new_params.ptp_rx, true);
 }
 
-int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
+int mlx5e_hwstamp_set(struct net_device *dev,
+		      struct kernel_hwtstamp_config *config,
+		      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct mlx5e_priv *priv = netdev_priv(dev);
 	bool rx_cqe_compress_def;
 	bool ptp_rx;
 	int err;
@@ -4766,11 +4768,8 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	    (mlx5_clock_get_ptp_index(priv->mdev) == -1))
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
 	/* TX HW timestamp */
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 		break;
@@ -4782,7 +4781,7 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	rx_cqe_compress_def = priv->channels.params.rx_cqe_compress_def;
 
 	/* RX HW timestamp */
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ptp_rx = false;
 		break;
@@ -4801,7 +4800,7 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		/* ptp_rx is set if both HW TS is set and CQE
 		 * compression is set
 		 */
@@ -4814,47 +4813,34 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 
 	if (!mlx5e_profile_feature_cap(priv->profile, PTP_RX))
 		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
-						     config.rx_filter != HWTSTAMP_FILTER_NONE);
+						     config->rx_filter != HWTSTAMP_FILTER_NONE);
 	else
 		err = mlx5e_hwstamp_config_ptp_rx(priv, ptp_rx);
 	if (err)
 		goto err_unlock;
 
-	memcpy(&priv->tstamp, &config, sizeof(config));
+	memcpy(&priv->tstamp, config, sizeof(*config));
 	mutex_unlock(&priv->state_lock);
 
 	/* might need to fix some features */
 	netdev_update_features(priv->netdev);
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
 err_unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
 
-int mlx5e_hwstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr)
+int mlx5e_hwstamp_get(struct net_device *dev,
+		      struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config *cfg = &priv->tstamp;
+	struct mlx5e_priv *priv = netdev_priv(dev);
 
 	if (!MLX5_CAP_GEN(priv->mdev, device_frequency_khz))
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, cfg, sizeof(*cfg)) ? -EFAULT : 0;
-}
-
-static int mlx5e_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct mlx5e_priv *priv = netdev_priv(dev);
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return mlx5e_hwstamp_set(priv, ifr);
-	case SIOCGHWTSTAMP:
-		return mlx5e_hwstamp_get(priv, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	*config = priv->tstamp;
+	return 0;
 }
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -5295,7 +5281,6 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_set_features        = mlx5e_set_features,
 	.ndo_fix_features        = mlx5e_fix_features,
 	.ndo_change_mtu          = mlx5e_change_nic_mtu,
-	.ndo_eth_ioctl            = mlx5e_ioctl,
 	.ndo_set_tx_maxrate      = mlx5e_set_tx_maxrate,
 	.ndo_features_check      = mlx5e_features_check,
 	.ndo_tx_timeout          = mlx5e_tx_timeout,
@@ -5321,6 +5306,8 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+	.ndo_hwtstamp_get	 = mlx5e_hwstamp_get,
+	.ndo_hwtstamp_set	 = mlx5e_hwstamp_set,
 };
 
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 4ed43ee9aa35..f774fee2e391 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2609,7 +2609,7 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
 {
-	struct hwtstamp_config *tstamp;
+	struct kernel_hwtstamp_config *tstamp;
 	struct mlx5e_rq_stats *stats;
 	struct net_device *netdev;
 	struct mlx5e_priv *priv;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 79ae3a51a4b3..ff8ffd997b17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -52,7 +52,8 @@ static const struct net_device_ops mlx5i_netdev_ops = {
 	.ndo_init                = mlx5i_dev_init,
 	.ndo_uninit              = mlx5i_dev_cleanup,
 	.ndo_change_mtu          = mlx5i_change_mtu,
-	.ndo_eth_ioctl            = mlx5i_ioctl,
+	.ndo_hwtstamp_get        = mlx5e_hwstamp_get,
+	.ndo_hwtstamp_set        = mlx5e_hwstamp_set,
 };
 
 /* IPoIB mlx5 netdev profile */
@@ -557,20 +558,6 @@ int mlx5i_dev_init(struct net_device *dev)
 	return 0;
 }
 
-int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct mlx5e_priv *priv = mlx5i_epriv(dev);
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return mlx5e_hwstamp_set(priv, ifr);
-	case SIOCGHWTSTAMP:
-		return mlx5e_hwstamp_get(priv, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 void mlx5i_dev_cleanup(struct net_device *dev)
 {
 	struct mlx5e_priv    *priv   = mlx5i_epriv(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
index 2ab6437a1c49..98229bdd8a8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
@@ -88,7 +88,6 @@ struct net_device *mlx5i_pkey_get_netdev(struct net_device *netdev, u32 qpn);
 /* Shared ndo functions */
 int mlx5i_dev_init(struct net_device *dev);
 void mlx5i_dev_cleanup(struct net_device *dev);
-int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 
 /* Parent profile functions */
 int mlx5i_init(struct mlx5_core_dev *mdev, struct net_device *netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index 028a76944d82..c44c0b2c82ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -140,7 +140,6 @@ static int mlx5i_pkey_close(struct net_device *netdev);
 static int mlx5i_pkey_dev_init(struct net_device *dev);
 static void mlx5i_pkey_dev_cleanup(struct net_device *netdev);
 static int mlx5i_pkey_change_mtu(struct net_device *netdev, int new_mtu);
-static int mlx5i_pkey_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 
 static const struct net_device_ops mlx5i_pkey_netdev_ops = {
 	.ndo_open                = mlx5i_pkey_open,
@@ -149,7 +148,8 @@ static const struct net_device_ops mlx5i_pkey_netdev_ops = {
 	.ndo_get_stats64         = mlx5i_get_stats,
 	.ndo_uninit              = mlx5i_pkey_dev_cleanup,
 	.ndo_change_mtu          = mlx5i_pkey_change_mtu,
-	.ndo_eth_ioctl            = mlx5i_pkey_ioctl,
+	.ndo_hwtstamp_get        = mlx5e_hwstamp_get,
+	.ndo_hwtstamp_set        = mlx5e_hwstamp_set,
 };
 
 /* Child NDOs */
@@ -184,11 +184,6 @@ static int mlx5i_pkey_dev_init(struct net_device *dev)
 	return mlx5i_dev_init(dev);
 }
 
-static int mlx5i_pkey_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	return mlx5i_ioctl(dev, ifr, cmd);
-}
-
 static void mlx5i_pkey_dev_cleanup(struct net_device *netdev)
 {
 	mlx5i_parent_put(netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index c18a652c0faa..e65220f50524 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -53,13 +53,13 @@ struct mlx5_timer {
 };
 
 struct mlx5_clock {
-	seqlock_t                  lock;
-	struct hwtstamp_config     hwtstamp_config;
-	struct ptp_clock          *ptp;
-	struct ptp_clock_info      ptp_info;
-	struct mlx5_pps            pps_info;
-	struct mlx5_timer          timer;
-	bool                       shared;
+	seqlock_t                     lock;
+	struct kernel_hwtstamp_config hwtstamp_config;
+	struct ptp_clock             *ptp;
+	struct ptp_clock_info         ptp_info;
+	struct mlx5_pps               pps_info;
+	struct mlx5_timer             timer;
+	bool                          shared;
 };
 
 static inline bool mlx5_is_real_time_rq(struct mlx5_core_dev *mdev)
-- 
2.47.3


