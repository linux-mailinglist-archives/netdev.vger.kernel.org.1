Return-Path: <netdev+bounces-203131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68427AF08F8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B3E3BB1D8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B31DACB1;
	Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5j33HTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F91D799D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425612; cv=none; b=tR0mnVtFyIrzK0qpwoCk0XAgxHn/oeG/lYqSAFm27iN/OtLgwUCMaISrlVKSn6CQiv8POXQGGk+DoFepjANbMZKfOVcnEnrIkDGnhEh3dT08NtXkVjK/eqh9K6J8Uvs34u7S4r7A1g3wkYzv+wGInQwsTXS+6pVnxBQ0v0OFaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425612; c=relaxed/simple;
	bh=QXHCVwfGZ5dpdS6/+/WnJrdvTmX/caRLQD64A0zHzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6IjriZwjMTdXRU8fJ3xfiII8NauzBXoijrupzYG7Ln2Gzz/OP4qmqqK0LtuK238tpxc9yMmisK8PlB1/mGmBs6g1kfbHACoepQAwX9Q5+HIkLgswROsRjLsVYseUAEbOGycL44AIHdODku5eTCsjVoW90V+NF/7s7Syx2GEeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5j33HTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72166C4CEEB;
	Wed,  2 Jul 2025 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425611;
	bh=QXHCVwfGZ5dpdS6/+/WnJrdvTmX/caRLQD64A0zHzZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5j33HTQiMVE0yvy6wWQFoK3uuEyr0Q+n67YpZuHYrYlVa1VAqWa/W0pPrLKKp+8V
	 J4YS4MfBUW1u9LIi+ZBfwC7W7+Zp1SXKQPYCtCuJY0BpelX2wW1fXXH5fhI/vj89sc
	 W3pF/+QJQIUxEJR3XT7180KDfPVphp/uz/bkznmTC0dTevDb6xcNxRUMqEno1h5crM
	 yyypt9oTjhsgbAASCzIEENxHdiJB7JsyALsJ6wDRxDB3s0Im/8XxYF0PE1K/1Lob3i
	 Vn6LkEmVTxtINmOb7ZyKHnWnJiCrpQrgzY1c5k9469bHy+BLFYfsPfxc89QyC7mtnb
	 6MsVITwzezo+g==
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
Subject: [PATCH net-next v2 3/5] eth: mlx5: migrate to the *_rxfh_context ops
Date: Tue,  1 Jul 2025 20:06:04 -0700
Message-ID: <20250702030606.1776293-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702030606.1776293-1-kuba@kernel.org>
References: <20250702030606.1776293-1-kuba@kernel.org>
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
v2:
 - remove hfunc local var in mlx5e_rxfh_hfunc_check()
 - make the get functions void and add WARN_ON_ONCE()
v1: https://lore.kernel.org/20250630160953.1093267-4-kuba@kernel.org
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  29 ++--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 145 ++++++++++++++----
 5 files changed, 130 insertions(+), 57 deletions(-)

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
index 74cd111ee320..5d8964c46e9c 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 5fcbe47337b0..4bdb4060e861 100644
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
@@ -193,19 +187,18 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 	mlx5e_rss_set_indir_uniform(res->rss[0], nch);
 }
 
-int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
+void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
+			       u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	struct mlx5e_rss *rss;
 
-	if (rss_idx >= MLX5E_MAX_NUM_RSS)
-		return -EINVAL;
+	rss = NULL;
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


