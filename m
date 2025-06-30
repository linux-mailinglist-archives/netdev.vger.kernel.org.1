Return-Path: <netdev+bounces-202551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62977AEE415
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BF217EF0C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA12E6135;
	Mon, 30 Jun 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnEkYz9/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914962E6127
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299803; cv=none; b=gltup+ll5lN2v3VeYXuC9r4wlAVz+3j4hUuEogZ0tbvg5TA/GTih0RxzM9qLiSSNWxe3FyyrDVSavzNUwtCkNV8G0BWJnGrF2cMzuGNphIF2+2FKDXxOhBwOOzcfieLOj2s/m6ASLkmWm0++RGkGguKOh7+vmCO0SPgnl80TFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299803; c=relaxed/simple;
	bh=Y9MmbBAkWOYpWmKRd7vUmrkyUy2O1s/45VWzH7JOtAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ1g6jB1+zOtyq4GH8jzcEo1hwrXD5RfpOrQOS1GP1ABkvLJVnXgvJgSDvAziZDDFxyc9izzL0bO8V5FpCQQxTr4q6DJLrfR8BpxZ+BmpeeHmzArp5KM4G/GR93Za/5fsNTNPteF9veXWIk/bO+0rHlCa/j43Jg9U1SctKWLqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnEkYz9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0156C4CEF2;
	Mon, 30 Jun 2025 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299803;
	bh=Y9MmbBAkWOYpWmKRd7vUmrkyUy2O1s/45VWzH7JOtAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnEkYz9/OxtEuUrQPdNjUG2IJQLyZCHcUpgcFqnYmUbOkbLsS4t/hDRR87yvzW/g2
	 Zcpf65lrliBTZaM8v98qcnQDowvCGuB9vx25v/ccQ/OhdYjkGaSfucW4Uv1su+Mv4O
	 NbX5zraF11CmVp70GokKSHJ71lw3Vq8HS+6SzxTAWoa+paSZ/g3Rkwzl/SzhLhi0fe
	 i8uNEpG9JFC89aQLp104tXiNkHah7OhPpwXC8D+9m3Rhn49DbEc64OGwKiFyHxXmwS
	 OWLCnnlL2toAbOzeLCxfjw1MlmLJN1dCjVZro2dvUz1pMqWaMf6/BrQqZvNWkFv5go
	 AKyReYYmRMV7Q==
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
Subject: [PATCH net-next 3/5] eth: mlx5: migrate to the *_rxfh_context ops
Date: Mon, 30 Jun 2025 09:09:51 -0700
Message-ID: <20250630160953.1093267-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630160953.1093267-1-kuba@kernel.org>
References: <20250630160953.1093267-1-kuba@kernel.org>
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

Tested with drivers/net/hw/rss_ctx.py on MCX6.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  12 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 125 +++++++++++++++---
 3 files changed, 108 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 3e09d91281af..5baa840b08ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -61,7 +61,7 @@ int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
 int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
 					struct mlx5e_packet_merge_param *pkt_merge_param);
 
-int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int init_nch);
+int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int init_nch);
 int mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx);
 int mlx5e_rx_res_rss_cnt(struct mlx5e_rx_res *res);
 int mlx5e_rx_res_rss_index(struct mlx5e_rx_res *res, struct mlx5e_rss *rss);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 5fcbe47337b0..4368c7d32674 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 995eedf7a51a..5cb50818c958 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1498,17 +1498,11 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 	return 0;
 }
 
-static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
-			  struct netlink_ext_ack *extack)
+static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
+				  const struct ethtool_rxfh_param *rxfh)
 {
-	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
-	struct mlx5e_priv *priv = netdev_priv(dev);
-	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
 	unsigned int count;
-	int err;
-
-	mutex_lock(&priv->state_lock);
 
 	count = priv->channels.params.num_channels;
 
@@ -1516,25 +1510,31 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
 
 		if (count > xor8_max_channels) {
-			err = -EINVAL;
 			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
 				   __func__, count, xor8_max_channels);
-			goto unlock;
+			return -EINVAL;
 		}
 	}
 
-	if (*rss_context && rxfh->rss_delete) {
-		err = mlx5e_rx_res_rss_destroy(priv->rx_res, *rss_context);
+	return 0;
+}
+
+static int mlx5e_set_rxfh(struct net_device *dev,
+			  struct ethtool_rxfh_param *rxfh,
+			  struct netlink_ext_ack *extack)
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
@@ -1544,6 +1544,86 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
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
@@ -2654,9 +2734,9 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 
 const struct ethtool_ops mlx5e_ethtool_ops = {
 	.cap_link_lanes_supported = true,
-	.cap_rss_ctx_supported	= true,
 	.rxfh_per_ctx_fields	= true,
 	.rxfh_per_ctx_key	= true,
+	.rxfh_max_num_contexts	= MLX5E_MAX_NUM_RSS,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
@@ -2685,6 +2765,9 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
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


