Return-Path: <netdev+bounces-204672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35DAFBAEB
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9169170DEF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D82652B2;
	Mon,  7 Jul 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrdtSndX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C76263F44
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913684; cv=none; b=dX95dBnHTk5dsUwM+SPH3tagxLI6im/SR/zg58Li8ppiJ82VMaMWu0fvsEZv1phlunr09wRAQ4UcGweyXyMmhRYcRzWe7KElq5IljIzT8tehhIZZqZ9RnI9syxa/tuKWt0RbQKq/09/QYnmJ3mdnWCAKgNmqqh6uWCRSHm3XJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913684; c=relaxed/simple;
	bh=IuQUaYnEZmmWj03CA57WowDWTss1f11Io0ikkfrfe8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXXfLrRvF9g6+gE5JPM1xfteiZP9RLprviP4CbcdoAXNEDCV1vZCniWMXitaHHuJWTut1dPJoqbYNiUSDWg7MUttvzQa3U7llbPNXPfFy+EZg1dWHXzqr6Qk31ONnuR+N855FP8WDc0A28O+g7tD3brcRiPj26PNXrp5FXtHOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrdtSndX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2774FC4CEF6;
	Mon,  7 Jul 2025 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913683;
	bh=IuQUaYnEZmmWj03CA57WowDWTss1f11Io0ikkfrfe8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrdtSndXqqNffB6RnzSA1U2X9HJiRiwvjQu4qBS+uG2LTEUgMnfo2X8htUmfdvYhZ
	 vyL6w0fNerh7H11ov8L1tvYCIrOvr5JbST3bJoF+nIFeP0MniRjFgLqjJHOqkThqUB
	 EqZyuFXbcASQyjSJQoWeGJjPctWbsdmn9+5wKy5Bg4drr5Qlm6/u0JQnD3daovYw3h
	 CFJRCT/ATDjkGt2V3Sn7GrQ382F/Fp9QnjpQUQRD8WSiC1Ok35hUmwOCXymZuHB8dL
	 z9mlWwG1TNDvpq0cQNu/DsdHYzrsYUC0TZ63s0nCBBiyGlCr4Eq+I5V+ozfceMDLxk
	 8tGDJJpcHm9mg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/5] eth: mlx5: migrate to the *_rxfh_context ops
Date: Mon,  7 Jul 2025 11:41:13 -0700
Message-ID: <20250707184115.2285277-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707184115.2285277-1-kuba@kernel.org>
References: <20250707184115.2285277-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mlx5 to dedicated RXFH ops. This is a fairly shallow
conversion, TBH, most of the driver code stays as is, but we
let the core allocate the context ID for the driver.

mlx5e_rx_res_rss_get_rxfh() and friends are made void, since
core only calls the driver for context 0. The second call
is right after context creation so it must exist (tm).

Tested with drivers/net/hw/rss_ctx.py on MCX6.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - remove the stale return
 - move init
v2: https://lore.kernel.org/20250702030606.1776293-4-kuba@kernel.org
 - remove hfunc local var in mlx5e_rxfh_hfunc_check()
 - make the get functions void and add WARN_ON_ONCE()
v1: https://lore.kernel.org/20250630160953.1093267-4-kuba@kernel.org
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   5 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  30 ++--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 145 ++++++++++++++----
 5 files changed, 130 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 8ac902190010..c6c1b2847cf5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -47,7 +47,8 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 				     struct mlx5e_packet_merge_param *pkt_merge_param);
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
+void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
+			bool *symmetric);
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 3e09d91281af..1d049e2aa264 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -48,8 +48,9 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
 
 /* Configuration API */
 void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch);
-int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
+void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
+			       u32 *indir, u8 *key, u8 *hfunc,
+			       bool *symmetric);
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			      const u32 *indir, const u8 *key, const u8 *hfunc,
 			      const bool *symmetric);
@@ -61,7 +62,7 @@ int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
 int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
 					struct mlx5e_packet_merge_param *pkt_merge_param);
 
-int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int init_nch);
+int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int init_nch);
 int mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx);
 int mlx5e_rx_res_rss_cnt(struct mlx5e_rx_res *res);
 int mlx5e_rx_res_rss_index(struct mlx5e_rx_res *res, struct mlx5e_rss *rss);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 74cd111ee320..c68ba0e58fa6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -567,7 +567,8 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 	return final_err;
 }
 
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
+void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
+			bool *symmetric)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
@@ -582,8 +583,6 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bo
 
 	if (symmetric)
 		*symmetric = rss->hash.symmetric;
-
-	return 0;
 }
 
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 5fcbe47337b0..e5cce2df3649 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -71,17 +71,12 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 	return 0;
 }
 
-int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int init_nch)
+int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int init_nch)
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
 	struct mlx5e_rss *rss;
-	int i;
 
-	for (i = 1; i < MLX5E_MAX_NUM_RSS; i++)
-		if (!res->rss[i])
-			break;
-
-	if (i == MLX5E_MAX_NUM_RSS)
+	if (WARN_ON_ONCE(res->rss[rss_idx]))
 		return -ENOSPC;
 
 	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
@@ -97,8 +92,7 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int i
 		mlx5e_rss_enable(rss, res->rss_rqns, vhca_ids, res->rss_nch);
 	}
 
-	res->rss[i] = rss;
-	*rss_idx = i;
+	res->rss[rss_idx] = rss;
 
 	return 0;
 }
@@ -193,19 +187,17 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 	mlx5e_rss_set_indir_uniform(res->rss[0], nch);
 }
 
-int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
+void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
+			       u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
-	struct mlx5e_rss *rss;
+	struct mlx5e_rss *rss = NULL;
 
-	if (rss_idx >= MLX5E_MAX_NUM_RSS)
-		return -EINVAL;
+	if (rss_idx < MLX5E_MAX_NUM_RSS)
+		rss = res->rss[rss_idx];
+	if (WARN_ON_ONCE(!rss))
+		return;
 
-	rss = res->rss[rss_idx];
-	if (!rss)
-		return -ENOENT;
-
-	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
+	mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
 }
 
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 995eedf7a51a..d507366d773e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1480,61 +1480,55 @@ static u32 mlx5e_get_rxfh_indir_size(struct net_device *netdev)
 static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
-	u32 rss_context = rxfh->rss_context;
 	bool symmetric;
-	int err;
 
 	mutex_lock(&priv->state_lock);
-	err = mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rss_context,
-					rxfh->indir, rxfh->key, &rxfh->hfunc, &symmetric);
+	mlx5e_rx_res_rss_get_rxfh(priv->rx_res, 0, rxfh->indir, rxfh->key,
+				  &rxfh->hfunc, &symmetric);
 	mutex_unlock(&priv->state_lock);
 
-	if (err)
-		return err;
-
 	if (symmetric)
 		rxfh->input_xfrm = RXH_XFRM_SYM_OR_XOR;
 
 	return 0;
 }
 
-static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
+static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
+				  const struct ethtool_rxfh_param *rxfh)
+{
+	unsigned int count;
+
+	count = priv->channels.params.num_channels;
+
+	if (rxfh->hfunc == ETH_RSS_HASH_XOR) {
+		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
+
+		if (count > xor8_max_channels) {
+			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
+				   __func__, count, xor8_max_channels);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int mlx5e_set_rxfh(struct net_device *dev,
+			  struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
 {
 	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
 	struct mlx5e_priv *priv = netdev_priv(dev);
-	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
-	unsigned int count;
 	int err;
 
 	mutex_lock(&priv->state_lock);
 
-	count = priv->channels.params.num_channels;
-
-	if (hfunc == ETH_RSS_HASH_XOR) {
-		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
-
-		if (count > xor8_max_channels) {
-			err = -EINVAL;
-			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
-				   __func__, count, xor8_max_channels);
-			goto unlock;
-		}
-	}
-
-	if (*rss_context && rxfh->rss_delete) {
-		err = mlx5e_rx_res_rss_destroy(priv->rx_res, *rss_context);
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	if (err)
 		goto unlock;
-	}
 
-	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		err = mlx5e_rx_res_rss_init(priv->rx_res, rss_context, count);
-		if (err)
-			goto unlock;
-	}
-
-	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, *rss_context,
+	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
 					rxfh->indir, rxfh->key,
 					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
 					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
@@ -1544,6 +1538,86 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 	return err;
 }
 
+static int mlx5e_create_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     const struct ethtool_rxfh_param *rxfh,
+				     struct netlink_ext_ack *extack)
+{
+	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	u8 hfunc = rxfh->hfunc;
+	int err;
+
+	mutex_lock(&priv->state_lock);
+
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	if (err)
+		goto unlock;
+
+	err = mlx5e_rx_res_rss_init(priv->rx_res, rxfh->rss_context,
+				    priv->channels.params.num_channels);
+	if (err)
+		goto unlock;
+
+	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
+					rxfh->indir, rxfh->key,
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
+	if (err)
+		goto unlock;
+
+	mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rxfh->rss_context,
+				  ethtool_rxfh_context_indir(ctx),
+				  ethtool_rxfh_context_key(ctx),
+				  &ctx->hfunc, &symmetric);
+	if (symmetric)
+		ctx->input_xfrm = RXH_XFRM_SYM_OR_XOR;
+
+unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+static int mlx5e_modify_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     const struct ethtool_rxfh_param *rxfh,
+				     struct netlink_ext_ack *extack)
+{
+	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	u8 hfunc = rxfh->hfunc;
+	int err;
+
+	mutex_lock(&priv->state_lock);
+
+	err = mlx5e_rxfh_hfunc_check(priv, rxfh);
+	if (err)
+		goto unlock;
+
+	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
+					rxfh->indir, rxfh->key,
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
+
+unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+static int mlx5e_remove_rxfh_context(struct net_device *dev,
+				     struct ethtool_rxfh_context *ctx,
+				     u32 rss_context,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	int err;
+
+	mutex_lock(&priv->state_lock);
+	err = mlx5e_rx_res_rss_destroy(priv->rx_res, rss_context);
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
 #define MLX5E_PFC_PREVEN_AUTO_TOUT_MSEC		100
 #define MLX5E_PFC_PREVEN_TOUT_MAX_MSEC		8000
 #define MLX5E_PFC_PREVEN_MINOR_PRECENT		85
@@ -2654,9 +2728,9 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 
 const struct ethtool_ops mlx5e_ethtool_ops = {
 	.cap_link_lanes_supported = true,
-	.cap_rss_ctx_supported	= true,
 	.rxfh_per_ctx_fields	= true,
 	.rxfh_per_ctx_key	= true,
+	.rxfh_max_num_contexts	= MLX5E_MAX_NUM_RSS,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
@@ -2685,6 +2759,9 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.set_rxfh          = mlx5e_set_rxfh,
 	.get_rxfh_fields   = mlx5e_get_rxfh_fields,
 	.set_rxfh_fields   = mlx5e_set_rxfh_fields,
+	.create_rxfh_context	= mlx5e_create_rxfh_context,
+	.modify_rxfh_context	= mlx5e_modify_rxfh_context,
+	.remove_rxfh_context	= mlx5e_remove_rxfh_context,
 	.get_rxnfc         = mlx5e_get_rxnfc,
 	.set_rxnfc         = mlx5e_set_rxnfc,
 	.get_tunable       = mlx5e_get_tunable,
-- 
2.50.0


