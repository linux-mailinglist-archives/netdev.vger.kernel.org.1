Return-Path: <netdev+bounces-41024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A072F7C95A8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A99B20CA1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5C26E1A;
	Sat, 14 Oct 2023 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cblNhhHw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6226E14
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70960C433CB;
	Sat, 14 Oct 2023 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303973;
	bh=Ufks9Sv/Ky7CYlY21JajZoBaUXIbNo1Tk9j4SzAVtD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cblNhhHwpkivItv8r9WpqGmfs3iK0XS6WPFIQc2+JpQlQsnwk7Y9QPTb/zFZsF030
	 gNgb0ZCfW2DkvkcBs2H5G8ejEnNFEynltySA/PWfrU4oK05oHCNbYeQFRgm7gklIyG
	 RZJIuc1feJQ6PGv2RdHPpCXhcNXJC2iPtuIlqcLN5F3D9FYZYjKwO6s2h3YNW6G/p3
	 p/2NbMBzZHgbAXwZjGl3bRCSyNiA2c4uGxVZqP3llWh/ZIYkmWpEKbGWBre6hMcl/J
	 32ROSr4nmCDMxnPhkXFwqF9bpPLX8RoJeXBmSQKymG1L/Q0fO2SE6+n05Ex3hD/eXQ
	 kC31fwbuRPxBQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 10/15] net/mlx5e: Refactor rx_res_init() and rx_res_free() APIs
Date: Sat, 14 Oct 2023 10:19:03 -0700
Message-ID: <20231014171908.290428-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Refactor mlx5e_rx_res_init() and mlx5e_rx_res_free() by wrapping
mlx5e_rx_res_alloc() and mlx5e_rx_res_destroy() API's respectively.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 36 +++++++++++--------
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   | 11 +++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 ++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 27 ++++++--------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 24 +++++--------
 5 files changed, 56 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 56e6b8c7501f..abbd08b6d1a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -284,7 +284,12 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
 
 /* End of API rx_res_rss_* */
 
-struct mlx5e_rx_res *mlx5e_rx_res_alloc(void)
+static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
+{
+	kvfree(res);
+}
+
+static struct mlx5e_rx_res *mlx5e_rx_res_alloc(void)
 {
 	return kvzalloc(sizeof(struct mlx5e_rx_res), GFP_KERNEL);
 }
@@ -404,13 +409,19 @@ static void mlx5e_rx_res_ptp_destroy(struct mlx5e_rx_res *res)
 	mlx5e_rqt_destroy(&res->ptp.rqt);
 }
 
-int mlx5e_rx_res_init(struct mlx5e_rx_res *res, struct mlx5_core_dev *mdev,
-		      enum mlx5e_rx_res_features features, unsigned int max_nch,
-		      u32 drop_rqn, const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-		      unsigned int init_nch)
+struct mlx5e_rx_res *
+mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features features,
+		    unsigned int max_nch, u32 drop_rqn,
+		    const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+		    unsigned int init_nch)
 {
+	struct mlx5e_rx_res *res;
 	int err;
 
+	res = mlx5e_rx_res_alloc();
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
 	res->mdev = mdev;
 	res->features = features;
 	res->max_nch = max_nch;
@@ -421,7 +432,7 @@ int mlx5e_rx_res_init(struct mlx5e_rx_res *res, struct mlx5_core_dev *mdev,
 
 	err = mlx5e_rx_res_rss_init_def(res, init_nch);
 	if (err)
-		goto err_out;
+		goto err_rx_res_free;
 
 	err = mlx5e_rx_res_channels_init(res);
 	if (err)
@@ -431,14 +442,15 @@ int mlx5e_rx_res_init(struct mlx5e_rx_res *res, struct mlx5_core_dev *mdev,
 	if (err)
 		goto err_channels_destroy;
 
-	return 0;
+	return res;
 
 err_channels_destroy:
 	mlx5e_rx_res_channels_destroy(res);
 err_rss_destroy:
 	__mlx5e_rx_res_rss_destroy(res, 0);
-err_out:
-	return err;
+err_rx_res_free:
+	mlx5e_rx_res_free(res);
+	return ERR_PTR(err);
 }
 
 void mlx5e_rx_res_destroy(struct mlx5e_rx_res *res)
@@ -446,11 +458,7 @@ void mlx5e_rx_res_destroy(struct mlx5e_rx_res *res)
 	mlx5e_rx_res_ptp_destroy(res);
 	mlx5e_rx_res_channels_destroy(res);
 	mlx5e_rx_res_rss_destroy_all(res);
-}
-
-void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
-{
-	kvfree(res);
+	mlx5e_rx_res_free(res);
 }
 
 u32 mlx5e_rx_res_get_tirn_direct(struct mlx5e_rx_res *res, unsigned int ix)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 580fe8bc3cd2..4fa8366db31f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -21,13 +21,12 @@ enum mlx5e_rx_res_features {
 };
 
 /* Setup */
-struct mlx5e_rx_res *mlx5e_rx_res_alloc(void);
-int mlx5e_rx_res_init(struct mlx5e_rx_res *res, struct mlx5_core_dev *mdev,
-		      enum mlx5e_rx_res_features features, unsigned int max_nch,
-		      u32 drop_rqn, const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-		      unsigned int init_nch);
+struct mlx5e_rx_res *
+mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features features,
+		    unsigned int max_nch, u32 drop_rqn,
+		    const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+		    unsigned int init_nch);
 void mlx5e_rx_res_destroy(struct mlx5e_rx_res *res);
-void mlx5e_rx_res_free(struct mlx5e_rx_res *res);
 
 /* TIRN getters for flow steering */
 u32 mlx5e_rx_res_get_tirn_direct(struct mlx5e_rx_res *res, unsigned int ix);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index afc3d488b8f6..5daec30380fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5389,10 +5389,6 @@ static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
 	enum mlx5e_rx_res_features features;
 	int err;
 
-	priv->rx_res = mlx5e_rx_res_alloc();
-	if (!priv->rx_res)
-		return -ENOMEM;
-
 	mlx5e_create_q_counters(priv);
 
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
@@ -5404,12 +5400,16 @@ static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
 	features = MLX5E_RX_RES_FEATURE_PTP;
 	if (mlx5_tunnel_inner_ft_supported(mdev))
 		features |= MLX5E_RX_RES_FEATURE_INNER_FT;
-	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, features,
-				priv->max_nch, priv->drop_rq.rqn,
-				&priv->channels.params.packet_merge,
-				priv->channels.params.num_channels);
-	if (err)
+
+	priv->rx_res = mlx5e_rx_res_create(priv->mdev, features, priv->max_nch, priv->drop_rq.rqn,
+					   &priv->channels.params.packet_merge,
+					   priv->channels.params.num_channels);
+	if (IS_ERR(priv->rx_res)) {
+		err = PTR_ERR(priv->rx_res);
+		priv->rx_res = NULL;
+		mlx5_core_err(mdev, "create rx resources failed, %d\n", err);
 		goto err_close_drop_rq;
+	}
 
 	err = mlx5e_create_flow_steering(priv->fs, priv->rx_res, priv->profile,
 					 priv->netdev);
@@ -5439,12 +5439,11 @@ static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
 				    priv->profile);
 err_destroy_rx_res:
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = NULL;
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
 err_destroy_q_counters:
 	mlx5e_destroy_q_counters(priv);
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
 	return err;
 }
 
@@ -5455,10 +5454,9 @@ static void mlx5e_cleanup_nic_rx(struct mlx5e_priv *priv)
 	mlx5e_destroy_flow_steering(priv->fs, !!(priv->netdev->hw_features & NETIF_F_NTUPLE),
 				    priv->profile);
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = NULL;
 	mlx5e_close_drop_rq(&priv->drop_rq);
 	mlx5e_destroy_q_counters(priv);
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
 }
 
 static void mlx5e_set_mqprio_rl(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 2fdb8895aecd..82dc27e31d9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -998,26 +998,22 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
 
-	priv->rx_res = mlx5e_rx_res_alloc();
-	if (!priv->rx_res) {
-		err = -ENOMEM;
-		goto err_free_fs;
-	}
-
 	mlx5e_fs_init_l2_addr(priv->fs, priv->netdev);
 
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
 	if (err) {
 		mlx5_core_err(mdev, "open drop rq failed, %d\n", err);
-		goto err_rx_res_free;
+		goto err_free_fs;
 	}
 
-	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, 0,
-				priv->max_nch, priv->drop_rq.rqn,
-				&priv->channels.params.packet_merge,
-				priv->channels.params.num_channels);
-	if (err)
+	priv->rx_res = mlx5e_rx_res_create(priv->mdev, 0, priv->max_nch, priv->drop_rq.rqn,
+					   &priv->channels.params.packet_merge,
+					   priv->channels.params.num_channels);
+	if (IS_ERR(priv->rx_res)) {
+		err = PTR_ERR(priv->rx_res);
+		mlx5_core_err(mdev, "Create rx resources failed, err=%d\n", err);
 		goto err_close_drop_rq;
+	}
 
 	err = mlx5e_create_rep_ttc_table(priv);
 	if (err)
@@ -1041,11 +1037,9 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	mlx5_destroy_ttc_table(mlx5e_fs_get_ttc(priv->fs, false));
 err_destroy_rx_res:
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = ERR_PTR(-EINVAL);
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
-err_rx_res_free:
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
 err_free_fs:
 	mlx5e_fs_cleanup(priv->fs);
 	priv->fs = NULL;
@@ -1059,9 +1053,8 @@ static void mlx5e_cleanup_rep_rx(struct mlx5e_priv *priv)
 	mlx5e_destroy_rep_root_ft(priv);
 	mlx5_destroy_ttc_table(mlx5e_fs_get_ttc(priv->fs, false));
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = ERR_PTR(-EINVAL);
 	mlx5e_close_drop_rq(&priv->drop_rq);
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
 }
 
 static void mlx5e_rep_mpesw_work(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index baa7ef812313..2bf77a5251b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -418,12 +418,6 @@ static int mlx5i_init_rx(struct mlx5e_priv *priv)
 		return -ENOMEM;
 	}
 
-	priv->rx_res = mlx5e_rx_res_alloc();
-	if (!priv->rx_res) {
-		err = -ENOMEM;
-		goto err_free_fs;
-	}
-
 	mlx5e_create_q_counters(priv);
 
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
@@ -432,12 +426,13 @@ static int mlx5i_init_rx(struct mlx5e_priv *priv)
 		goto err_destroy_q_counters;
 	}
 
-	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, 0,
-				priv->max_nch, priv->drop_rq.rqn,
-				&priv->channels.params.packet_merge,
-				priv->channels.params.num_channels);
-	if (err)
+	priv->rx_res = mlx5e_rx_res_create(priv->mdev, 0, priv->max_nch, priv->drop_rq.rqn,
+					   &priv->channels.params.packet_merge,
+					   priv->channels.params.num_channels);
+	if (IS_ERR(priv->rx_res)) {
+		err = PTR_ERR(priv->rx_res);
 		goto err_close_drop_rq;
+	}
 
 	err = mlx5i_create_flow_steering(priv);
 	if (err)
@@ -447,13 +442,11 @@ static int mlx5i_init_rx(struct mlx5e_priv *priv)
 
 err_destroy_rx_res:
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = ERR_PTR(-EINVAL);
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
 err_destroy_q_counters:
 	mlx5e_destroy_q_counters(priv);
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
-err_free_fs:
 	mlx5e_fs_cleanup(priv->fs);
 	return err;
 }
@@ -462,10 +455,9 @@ static void mlx5i_cleanup_rx(struct mlx5e_priv *priv)
 {
 	mlx5i_destroy_flow_steering(priv);
 	mlx5e_rx_res_destroy(priv->rx_res);
+	priv->rx_res = ERR_PTR(-EINVAL);
 	mlx5e_close_drop_rq(&priv->drop_rq);
 	mlx5e_destroy_q_counters(priv);
-	mlx5e_rx_res_free(priv->rx_res);
-	priv->rx_res = NULL;
 	mlx5e_fs_cleanup(priv->fs);
 }
 
-- 
2.41.0


