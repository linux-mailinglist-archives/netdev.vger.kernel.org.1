Return-Path: <netdev+bounces-57182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC950812505
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EFC1F210EB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921A15BD;
	Thu, 14 Dec 2023 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upamG0CA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8631FB0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979ECC433CB;
	Thu, 14 Dec 2023 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519725;
	bh=cGXcmEQGsgmkK41N6WLGmKurlf8Mfkx2vaRShs4ix/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upamG0CAoBa1dNTGljhP50gjr8l+rDkbOqX5ElTT7ZTQhiGgJk34BnrDcnZ8N6vcn
	 gXpHymo3z2vYQzBOApw2muCzeOd40XpjoUBdUtTI3AcawSvx9GYKcu4Yb5UK2kkpgM
	 FVqzrsesC2KTQwNnrjMu7we7qyZe9BnnmsbfDc2eR+oOrecZF6/CTiz2DwQnQ0oMVs
	 aOHSWFs3tmj54cq5ROyJnk7cQjy/u2i5C1v84I2X8lSfro/j7Qq+dKoe8OyYVzkyex
	 mX6sp+z5vYnKjJ4tYioslYlQD7X1bKxIr6cDxAzueygitjjqniLypw9JfS4o6W6rDu
	 hrPOdOvZGq5Fg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 06/11] net/mlx5: Move TISes from priv to mdev HW resources
Date: Wed, 13 Dec 2023 18:08:27 -0800
Message-ID: <20231214020832.50703-7-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

The transport interface send (TIS) object is responsible for performing
all transport related operations of the transmit side. Messages from
Send Queues get segmented and transmitted by the TIS including all
transport required implications, e.g. in the case of large send offload,
the TIS is responsible for the segmentation.

These are stateless objects and can be used by multiple netdevs (e.g.
representors) who share the same core device.

Providing the TISes as a service from the core layer to the netdev layer
reduces the number of replecated TIS objects (in case of multiple
netdevs), and will ease the transition to netdev with multiple mdevs.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  19 ++--
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |   7 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   |  74 +++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 102 ++++--------------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  10 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  19 +++-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |   2 +
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |   7 +-
 include/linux/mlx5/driver.h                   |   2 +
 11 files changed, 140 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 43f027bf2da3..6808e0d82944 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -72,7 +72,6 @@ struct page_pool;
 #define MLX5E_HW2SW_MTU(params, hwmtu) ((hwmtu) - ((params)->hard_mtu))
 #define MLX5E_SW2HW_MTU(params, swmtu) ((swmtu) + ((params)->hard_mtu))
 
-#define MLX5E_MAX_NUM_TC	8
 #define MLX5E_MAX_NUM_MQPRIO_CH_TC TC_QOPT_MAX_QUEUE
 
 #define MLX5_RX_HEADROOM NET_SKB_PAD
@@ -758,7 +757,7 @@ struct mlx5e_channel {
 	/* data path */
 	struct mlx5e_rq            rq;
 	struct mlx5e_xdpsq         rq_xdpsq;
-	struct mlx5e_txqsq         sq[MLX5E_MAX_NUM_TC];
+	struct mlx5e_txqsq         sq[MLX5_MAX_NUM_TC];
 	struct mlx5e_icosq         icosq;   /* internal control operations */
 	struct mlx5e_txqsq __rcu * __rcu *qos_sqs;
 	bool                       xdp;
@@ -808,7 +807,7 @@ struct mlx5e_channels {
 
 struct mlx5e_channel_stats {
 	struct mlx5e_ch_stats ch;
-	struct mlx5e_sq_stats sq[MLX5E_MAX_NUM_TC];
+	struct mlx5e_sq_stats sq[MLX5_MAX_NUM_TC];
 	struct mlx5e_rq_stats rq;
 	struct mlx5e_rq_stats xskrq;
 	struct mlx5e_xdpsq_stats rq_xdpsq;
@@ -818,8 +817,8 @@ struct mlx5e_channel_stats {
 
 struct mlx5e_ptp_stats {
 	struct mlx5e_ch_stats ch;
-	struct mlx5e_sq_stats sq[MLX5E_MAX_NUM_TC];
-	struct mlx5e_ptp_cq_stats cq[MLX5E_MAX_NUM_TC];
+	struct mlx5e_sq_stats sq[MLX5_MAX_NUM_TC];
+	struct mlx5e_ptp_cq_stats cq[MLX5_MAX_NUM_TC];
 	struct mlx5e_rq_stats rq;
 } ____cacheline_aligned_in_smp;
 
@@ -886,7 +885,6 @@ struct mlx5e_priv {
 	struct mlx5e_rq            drop_rq;
 
 	struct mlx5e_channels      channels;
-	u32                        tisn[MLX5_MAX_PORTS][MLX5E_MAX_NUM_TC];
 	struct mlx5e_rx_res       *rx_res;
 	u32                       *tx_rates;
 
@@ -984,6 +982,8 @@ struct mlx5e_profile {
 	void	(*update_stats)(struct mlx5e_priv *priv);
 	void	(*update_carrier)(struct mlx5e_priv *priv);
 	int	(*max_nch_limit)(struct mlx5_core_dev *mdev);
+	u32	(*get_tisn)(struct mlx5_core_dev *mdev, struct mlx5e_priv *priv,
+			    u8 lag_port, u8 tc);
 	unsigned int (*stats_grps_num)(struct mlx5e_priv *priv);
 	mlx5e_stats_grp_t *stats_grps;
 	const struct mlx5e_rx_handlers *rx_handlers;
@@ -991,6 +991,11 @@ struct mlx5e_profile {
 	u32     features;
 };
 
+u32 mlx5e_profile_get_tisn(struct mlx5_core_dev *mdev,
+			   struct mlx5e_priv *priv,
+			   const struct mlx5e_profile *profile,
+			   u8 lag_port, u8 tc);
+
 #define mlx5e_profile_feature_cap(profile, feature)	\
 	((profile)->features & BIT(MLX5E_PROFILE_FEATURE_##feature))
 
@@ -1132,8 +1137,6 @@ void mlx5e_close_drop_rq(struct mlx5e_rq *drop_rq);
 int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn);
 void mlx5e_destroy_tis(struct mlx5_core_dev *mdev, u32 tisn);
 
-int mlx5e_create_tises(struct mlx5e_priv *priv);
-void mlx5e_destroy_tises(struct mlx5e_priv *priv);
 int mlx5e_update_nic_rx(struct mlx5e_priv *priv);
 void mlx5e_update_carrier(struct mlx5e_priv *priv);
 int mlx5e_close(struct net_device *netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index af3928eddafd..04cec76c1ac4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -518,9 +518,11 @@ static int mlx5e_ptp_open_txqsqs(struct mlx5e_ptp *c,
 
 	for (tc = 0; tc < num_tc; tc++) {
 		int txq_ix = ix_base + tc;
+		u32 tisn;
 
-		err = mlx5e_ptp_open_txqsq(c, c->priv->tisn[c->lag_port][tc], txq_ix,
-					   cparams, tc, &c->ptpsq[tc]);
+		tisn = mlx5e_profile_get_tisn(c->mdev, c->priv, c->priv->profile,
+					      c->lag_port, tc);
+		err = mlx5e_ptp_open_txqsq(c, tisn, txq_ix, cparams, tc, &c->ptpsq[tc]);
 		if (err)
 			goto close_txqsq;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 7b700d0f956a..86f1854698b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -49,7 +49,7 @@ enum {
 
 struct mlx5e_ptp {
 	/* data path */
-	struct mlx5e_ptpsq         ptpsq[MLX5E_MAX_NUM_TC];
+	struct mlx5e_ptpsq         ptpsq[MLX5_MAX_NUM_TC];
 	struct mlx5e_rq            rq;
 	struct napi_struct         napi;
 	struct device             *pdev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 244bc15a42ab..9e2211f0c3a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -77,6 +77,7 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 	struct mlx5e_params *params;
 	struct mlx5e_channel *c;
 	struct mlx5e_txqsq *sq;
+	u32 tisn;
 
 	params = &chs->params;
 
@@ -126,8 +127,10 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 	err = mlx5e_open_cq(priv, params->tx_cq_moderation, &param_cq, &ccp, &sq->cq);
 	if (err)
 		goto err_free_sq;
-	err = mlx5e_open_txqsq(c, priv->tisn[c->lag_port][0], txq_ix, params,
-			       &param_sq, sq, 0, hw_id,
+
+	tisn = mlx5e_profile_get_tisn(c->mdev, c->priv, c->priv->profile,
+				      c->lag_port, 0);
+	err = mlx5e_open_txqsq(c, tisn, txq_ix, params, &param_sq, sq, 0, hw_id,
 			       priv->htb_qos_sq_stats[node_qid]);
 	if (err)
 		goto err_close_cq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 41c396e76457..67f546683e85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -74,6 +74,72 @@ int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey)
 	return err;
 }
 
+int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn)
+{
+	void *tisc = MLX5_ADDR_OF(create_tis_in, in, ctx);
+
+	MLX5_SET(tisc, tisc, transport_domain, mdev->mlx5e_res.hw_objs.td.tdn);
+
+	if (mlx5_lag_is_lacp_owner(mdev))
+		MLX5_SET(tisc, tisc, strict_lag_tx_port_affinity, 1);
+
+	return mlx5_core_create_tis(mdev, in, tisn);
+}
+
+void mlx5e_destroy_tis(struct mlx5_core_dev *mdev, u32 tisn)
+{
+	mlx5_core_destroy_tis(mdev, tisn);
+}
+
+static void mlx5e_destroy_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC])
+{
+	int tc, i;
+
+	for (i = 0; i < MLX5_MAX_PORTS; i++)
+		for (tc = 0; tc < MLX5_MAX_NUM_TC; tc++)
+			mlx5e_destroy_tis(mdev, tisn[i][tc]);
+}
+
+static bool mlx5_lag_should_assign_affinity(struct mlx5_core_dev *mdev)
+{
+	return MLX5_CAP_GEN(mdev, lag_tx_port_affinity) && mlx5e_get_num_lag_ports(mdev) > 1;
+}
+
+static int mlx5e_create_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC])
+{
+	int tc, i;
+	int err;
+
+	for (i = 0; i < MLX5_MAX_PORTS; i++) {
+		for (tc = 0; tc < MLX5_MAX_NUM_TC; tc++) {
+			u32 in[MLX5_ST_SZ_DW(create_tis_in)] = {};
+			void *tisc;
+
+			tisc = MLX5_ADDR_OF(create_tis_in, in, ctx);
+
+			MLX5_SET(tisc, tisc, prio, tc << 1);
+
+			if (mlx5_lag_should_assign_affinity(mdev))
+				MLX5_SET(tisc, tisc, lag_tx_port_affinity, i + 1);
+
+			err = mlx5e_create_tis(mdev, in, &tisn[i][tc]);
+			if (err)
+				goto err_close_tises;
+		}
+	}
+
+	return 0;
+
+err_close_tises:
+	for (; i >= 0; i--) {
+		for (tc--; tc >= 0; tc--)
+			mlx5e_destroy_tis(mdev, tisn[i][tc]);
+		tc = MLX5_MAX_NUM_TC;
+	}
+
+	return err;
+}
+
 int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
 {
 	struct mlx5e_hw_objs *res = &mdev->mlx5e_res.hw_objs;
@@ -103,6 +169,11 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
 		goto err_destroy_mkey;
 	}
 
+	err = mlx5e_create_tises(mdev, res->tisn);
+	if (err) {
+		mlx5_core_err(mdev, "alloc tises failed, %d\n", err);
+		goto err_destroy_bfreg;
+	}
 	INIT_LIST_HEAD(&res->td.tirs_list);
 	mutex_init(&res->td.list_lock);
 
@@ -115,6 +186,8 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
 
 	return 0;
 
+err_destroy_bfreg:
+	mlx5_free_bfreg(mdev, &res->bfreg);
 err_destroy_mkey:
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 err_dealloc_transport_domain:
@@ -130,6 +203,7 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 
 	mlx5_crypto_dek_cleanup(mdev->mlx5e_res.dek_priv);
 	mdev->mlx5e_res.dek_priv = NULL;
+	mlx5e_destroy_tises(mdev, res->tisn);
 	mlx5_free_bfreg(mdev, &res->bfreg);
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 	mlx5_core_dealloc_transport_domain(mdev, res->td.tdn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b49b7c28863c..ecb40950ec8d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1352,6 +1352,17 @@ void mlx5e_close_rq(struct mlx5e_rq *rq)
 	mlx5e_free_rq(rq);
 }
 
+u32 mlx5e_profile_get_tisn(struct mlx5_core_dev *mdev,
+			   struct mlx5e_priv *priv,
+			   const struct mlx5e_profile *profile,
+			   u8 lag_port, u8 tc)
+{
+	if (profile->get_tisn)
+		return profile->get_tisn(mdev, priv, lag_port, tc);
+
+	return mdev->mlx5e_res.hw_objs.tisn[lag_port][tc];
+}
+
 static void mlx5e_free_xdpsq_db(struct mlx5e_xdpsq *sq)
 {
 	kvfree(sq->db.xdpi_fifo.xi);
@@ -1920,7 +1931,8 @@ int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 		return err;
 
 	csp.tis_lst_sz      = 1;
-	csp.tisn            = c->priv->tisn[c->lag_port][0]; /* tc = 0 */
+	csp.tisn            = mlx5e_profile_get_tisn(c->mdev, c->priv, c->priv->profile,
+						     c->lag_port, 0); /* tc = 0 */
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = sq->min_inline_mode;
@@ -2204,12 +2216,15 @@ static int mlx5e_open_sqs(struct mlx5e_channel *c,
 	for (tc = 0; tc < mlx5e_get_dcb_num_tc(params); tc++) {
 		int txq_ix = c->ix + tc * params->num_channels;
 		u32 qos_queue_group_id;
+		u32 tisn;
 
+		tisn = mlx5e_profile_get_tisn(c->mdev, c->priv, c->priv->profile,
+					      c->lag_port, tc);
 		err = mlx5e_txq_get_qos_node_hw_id(params, txq_ix, &qos_queue_group_id);
 		if (err)
 			goto err_close_sqs;
 
-		err = mlx5e_open_txqsq(c, c->priv->tisn[c->lag_port][tc], txq_ix,
+		err = mlx5e_open_txqsq(c, tisn, txq_ix,
 				       params, &cparam->txq_sq, &c->sq[tc], tc,
 				       qos_queue_group_id,
 				       &c->priv->channel_stats[c->ix]->sq[tc]);
@@ -3351,72 +3366,6 @@ void mlx5e_close_drop_rq(struct mlx5e_rq *drop_rq)
 	mlx5e_free_cq(&drop_rq->cq);
 }
 
-int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn)
-{
-	void *tisc = MLX5_ADDR_OF(create_tis_in, in, ctx);
-
-	MLX5_SET(tisc, tisc, transport_domain, mdev->mlx5e_res.hw_objs.td.tdn);
-
-	if (mlx5_lag_is_lacp_owner(mdev))
-		MLX5_SET(tisc, tisc, strict_lag_tx_port_affinity, 1);
-
-	return mlx5_core_create_tis(mdev, in, tisn);
-}
-
-void mlx5e_destroy_tis(struct mlx5_core_dev *mdev, u32 tisn)
-{
-	mlx5_core_destroy_tis(mdev, tisn);
-}
-
-void mlx5e_destroy_tises(struct mlx5e_priv *priv)
-{
-	int tc, i;
-
-	for (i = 0; i < mlx5e_get_num_lag_ports(priv->mdev); i++)
-		for (tc = 0; tc < priv->profile->max_tc; tc++)
-			mlx5e_destroy_tis(priv->mdev, priv->tisn[i][tc]);
-}
-
-static bool mlx5e_lag_should_assign_affinity(struct mlx5_core_dev *mdev)
-{
-	return MLX5_CAP_GEN(mdev, lag_tx_port_affinity) && mlx5e_get_num_lag_ports(mdev) > 1;
-}
-
-int mlx5e_create_tises(struct mlx5e_priv *priv)
-{
-	int tc, i;
-	int err;
-
-	for (i = 0; i < mlx5e_get_num_lag_ports(priv->mdev); i++) {
-		for (tc = 0; tc < priv->profile->max_tc; tc++) {
-			u32 in[MLX5_ST_SZ_DW(create_tis_in)] = {};
-			void *tisc;
-
-			tisc = MLX5_ADDR_OF(create_tis_in, in, ctx);
-
-			MLX5_SET(tisc, tisc, prio, tc << 1);
-
-			if (mlx5e_lag_should_assign_affinity(priv->mdev))
-				MLX5_SET(tisc, tisc, lag_tx_port_affinity, i + 1);
-
-			err = mlx5e_create_tis(priv->mdev, in, &priv->tisn[i][tc]);
-			if (err)
-				goto err_close_tises;
-		}
-	}
-
-	return 0;
-
-err_close_tises:
-	for (; i >= 0; i--) {
-		for (tc--; tc >= 0; tc--)
-			mlx5e_destroy_tis(priv->mdev, priv->tisn[i][tc]);
-		tc = priv->profile->max_tc;
-	}
-
-	return err;
-}
-
 static void mlx5e_cleanup_nic_tx(struct mlx5e_priv *priv)
 {
 	if (priv->mqprio_rl) {
@@ -3425,7 +3374,6 @@ static void mlx5e_cleanup_nic_tx(struct mlx5e_priv *priv)
 		priv->mqprio_rl = NULL;
 	}
 	mlx5e_accel_cleanup_tx(priv);
-	mlx5e_destroy_tises(priv);
 }
 
 static int mlx5e_modify_channels_vsd(struct mlx5e_channels *chs, bool vsd)
@@ -3527,7 +3475,7 @@ static int mlx5e_setup_tc_mqprio_dcb(struct mlx5e_priv *priv,
 
 	mqprio->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 
-	if (tc && tc != MLX5E_MAX_NUM_TC)
+	if (tc && tc != MLX5_MAX_NUM_TC)
 		return -EINVAL;
 
 	new_params = priv->channels.params;
@@ -5482,23 +5430,13 @@ static int mlx5e_init_nic_tx(struct mlx5e_priv *priv)
 {
 	int err;
 
-	err = mlx5e_create_tises(priv);
-	if (err) {
-		mlx5_core_warn(priv->mdev, "create tises failed, %d\n", err);
-		return err;
-	}
-
 	err = mlx5e_accel_init_tx(priv);
 	if (err)
-		goto err_destroy_tises;
+		return err;
 
 	mlx5e_set_mqprio_rl(priv);
 	mlx5e_dcbnl_initialize(priv);
 	return 0;
-
-err_destroy_tises:
-	mlx5e_destroy_tises(priv);
-	return err;
 }
 
 static void mlx5e_nic_enable(struct mlx5e_priv *priv)
@@ -5593,7 +5531,7 @@ static const struct mlx5e_profile mlx5e_nic_profile = {
 	.update_stats	   = mlx5e_stats_update_ndo_stats,
 	.update_carrier	   = mlx5e_update_carrier,
 	.rx_handlers       = &mlx5e_rx_handlers_nic,
-	.max_tc		   = MLX5E_MAX_NUM_TC,
+	.max_tc		   = MLX5_MAX_NUM_TC,
 	.stats_grps	   = mlx5e_nic_stats_grps,
 	.stats_grps_num	   = mlx5e_nic_stats_grps_num,
 	.features          = BIT(MLX5E_PROFILE_FEATURE_PTP_RX) |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index fe0726c7b847..e3018a141b6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1180,12 +1180,6 @@ static int mlx5e_init_rep_tx(struct mlx5e_priv *priv)
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	int err;
 
-	err = mlx5e_create_tises(priv);
-	if (err) {
-		mlx5_core_warn(priv->mdev, "create tises failed, %d\n", err);
-		return err;
-	}
-
 	err = mlx5e_rep_neigh_init(rpriv);
 	if (err)
 		goto err_neigh_init;
@@ -1208,7 +1202,6 @@ static int mlx5e_init_rep_tx(struct mlx5e_priv *priv)
 err_init_tx:
 	mlx5e_rep_neigh_cleanup(rpriv);
 err_neigh_init:
-	mlx5e_destroy_tises(priv);
 	return err;
 }
 
@@ -1222,7 +1215,6 @@ static void mlx5e_cleanup_rep_tx(struct mlx5e_priv *priv)
 		mlx5e_cleanup_uplink_rep_tx(rpriv);
 
 	mlx5e_rep_neigh_cleanup(rpriv);
-	mlx5e_destroy_tises(priv);
 }
 
 static void mlx5e_rep_enable(struct mlx5e_priv *priv)
@@ -1452,7 +1444,7 @@ static const struct mlx5e_profile mlx5e_uplink_rep_profile = {
 	.update_stats           = mlx5e_stats_update_ndo_stats,
 	.update_carrier	        = mlx5e_update_carrier,
 	.rx_handlers            = &mlx5e_rx_handlers_rep,
-	.max_tc			= MLX5E_MAX_NUM_TC,
+	.max_tc			= MLX5_MAX_NUM_TC,
 	.stats_grps		= mlx5e_ul_rep_stats_grps,
 	.stats_grps_num		= mlx5e_ul_rep_stats_grps_num,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 2bf77a5251b4..58845121954c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -339,7 +339,7 @@ static int mlx5i_init_tx(struct mlx5e_priv *priv)
 		return err;
 	}
 
-	err = mlx5i_create_tis(priv->mdev, ipriv->qpn, &priv->tisn[0][0]);
+	err = mlx5i_create_tis(priv->mdev, ipriv->qpn, &ipriv->tisn);
 	if (err) {
 		mlx5_core_warn(priv->mdev, "create tis failed, %d\n", err);
 		goto err_destroy_underlay_qp;
@@ -356,7 +356,7 @@ static void mlx5i_cleanup_tx(struct mlx5e_priv *priv)
 {
 	struct mlx5i_priv *ipriv = priv->ppriv;
 
-	mlx5e_destroy_tis(priv->mdev, priv->tisn[0][0]);
+	mlx5e_destroy_tis(priv->mdev, ipriv->tisn);
 	mlx5i_destroy_underlay_qp(priv->mdev, ipriv->qpn);
 }
 
@@ -483,6 +483,18 @@ static unsigned int mlx5i_stats_grps_num(struct mlx5e_priv *priv)
 	return ARRAY_SIZE(mlx5i_stats_grps);
 }
 
+u32 mlx5i_get_tisn(struct mlx5_core_dev *mdev, struct mlx5e_priv *priv, u8 lag_port, u8 tc)
+{
+	struct mlx5i_priv *ipriv = priv->ppriv;
+
+	if (WARN(lag_port || tc,
+		 "IPoIB unexpected non-zero value: lag_port (%u), tc (%u)\n",
+		 lag_port, tc))
+		return 0;
+
+	return ipriv->tisn;
+}
+
 static const struct mlx5e_profile mlx5i_nic_profile = {
 	.init		   = mlx5i_init,
 	.cleanup	   = mlx5i_cleanup,
@@ -499,6 +511,7 @@ static const struct mlx5e_profile mlx5i_nic_profile = {
 	.max_tc		   = MLX5I_MAX_NUM_TC,
 	.stats_grps        = mlx5i_stats_grps,
 	.stats_grps_num    = mlx5i_stats_grps_num,
+	.get_tisn          = mlx5i_get_tisn,
 };
 
 /* mlx5i netdev NDos */
@@ -829,7 +842,7 @@ int mlx5_rdma_rn_get_params(struct mlx5_core_dev *mdev,
 	*params = (struct rdma_netdev_alloc_params){
 		.sizeof_priv = sizeof(struct mlx5i_priv) +
 			       sizeof(struct mlx5e_priv),
-		.txqs = nch * MLX5E_MAX_NUM_TC,
+		.txqs = nch * MLX5_MAX_NUM_TC,
 		.rxqs = nch,
 		.param = mdev,
 		.initialize_rdma_netdev = mlx5_rdma_setup_rn,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
index f3f2af972020..2ab6437a1c49 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
@@ -53,6 +53,7 @@ extern const struct mlx5e_rx_handlers mlx5i_rx_handlers;
 struct mlx5i_priv {
 	struct rdma_netdev rn; /* keep this first */
 	u32 qpn;
+	u32 tisn;
 	bool   sub_interface;
 	u32    num_sub_interfaces;
 	u32    qkey;
@@ -63,6 +64,7 @@ struct mlx5i_priv {
 };
 
 int mlx5i_create_tis(struct mlx5_core_dev *mdev, u32 underlay_qpn, u32 *tisn);
+u32 mlx5i_get_tisn(struct mlx5_core_dev *mdev, struct mlx5e_priv *priv, u8 lag_port, u8 tc);
 
 /* Underlay QP create/destroy functions */
 int mlx5i_create_underlay_qp(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index 03e681297937..f87471306f6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -218,7 +218,7 @@ static int mlx5i_pkey_open(struct net_device *netdev)
 		goto err_unint_underlay_qp;
 	}
 
-	err = mlx5i_create_tis(mdev, ipriv->qpn, &epriv->tisn[0][0]);
+	err = mlx5i_create_tis(mdev, ipriv->qpn, &ipriv->tisn);
 	if (err) {
 		mlx5_core_warn(mdev, "create child tis failed, %d\n", err);
 		goto err_remove_rx_uderlay_qp;
@@ -240,7 +240,7 @@ static int mlx5i_pkey_open(struct net_device *netdev)
 err_close_channels:
 	mlx5e_close_channels(&epriv->channels);
 err_clear_state_opened_flag:
-	mlx5e_destroy_tis(mdev, epriv->tisn[0][0]);
+	mlx5e_destroy_tis(mdev, ipriv->tisn);
 err_remove_rx_uderlay_qp:
 	mlx5_fs_remove_rx_underlay_qpn(mdev, ipriv->qpn);
 err_unint_underlay_qp:
@@ -269,7 +269,7 @@ static int mlx5i_pkey_close(struct net_device *netdev)
 	mlx5i_uninit_underlay_qp(priv);
 	mlx5e_deactivate_priv_channels(priv);
 	mlx5e_close_channels(&priv->channels);
-	mlx5e_destroy_tis(mdev, priv->tisn[0][0]);
+	mlx5e_destroy_tis(mdev, ipriv->tisn);
 unlock:
 	mutex_unlock(&priv->state_lock);
 	return 0;
@@ -361,6 +361,7 @@ static const struct mlx5e_profile mlx5i_pkey_nic_profile = {
 	.update_stats	   = NULL,
 	.rx_handlers       = &mlx5i_rx_handlers,
 	.max_tc		   = MLX5I_MAX_NUM_TC,
+	.get_tisn          = mlx5i_get_tisn,
 };
 
 const struct mlx5e_profile *mlx5i_pkey_get_profile(void)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 2f67cec1a898..7ee5b79ff3d6 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -679,6 +679,8 @@ struct mlx5e_resources {
 		struct mlx5_td             td;
 		u32			   mkey;
 		struct mlx5_sq_bfreg       bfreg;
+#define MLX5_MAX_NUM_TC 8
+		u32                        tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC];
 	} hw_objs;
 	struct net_device *uplink_netdev;
 	struct mutex uplink_netdev_lock;
-- 
2.43.0


