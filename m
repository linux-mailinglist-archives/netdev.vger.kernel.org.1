Return-Path: <netdev+bounces-82127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A988C59C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE00C3048AC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8DB13C910;
	Tue, 26 Mar 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtFCZ0Zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653013C90F
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464428; cv=none; b=cQI+etEmmVT+YTVC29HWdL9SoC4p5Ld4z90liBycbF7jQ82UPt8LAZfuHW4jrQS4aIKep1V8a+aCi2+0f1z3mrt6uZeujjfIEgm85+8au99udu7Mv9STkZWOb44Pe9LC6qH4olHFrtNj3qbger5gfk0fTyFnSL/uluzwjyISmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464428; c=relaxed/simple;
	bh=R42jsIDG/t+XNrhIdId5YWvl61mgtbTcHWQRtcC7afo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKgN3zwYvaCGwLhqiMz1AwiH7W7CQncpw+mDq78fMbCfZPIoqnhPNwpVu5R8qxSkvtNemdp4vbGZEGgUqVGO9NZh1aY24fY94GkDBMGl+HnieOBlOZ+GaKqIk3A+B5dE0J2DJJ31nxEN+wEr8XVDkmkuVBVd25jbWxq8+IkiZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtFCZ0Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62810C433B2;
	Tue, 26 Mar 2024 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464428;
	bh=R42jsIDG/t+XNrhIdId5YWvl61mgtbTcHWQRtcC7afo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtFCZ0ZhGt8HIPfE78eJ0NutkTPs7aUUEUHeUAHrDaDBsLqVqT7yTn2oLkVV/pfxY
	 dCuIf5f65a9ZkN76Jw3+WOza90xcVvZBb5o7EPZpHyCKvAl/fAYBoNnSh3GPLNYebr
	 Qdh2kDVqlvlL/aFzAfxlWkuDGhIXviuoLz3xEGrOttvug8BIRp5WxC+XOx6ChU/DES
	 sYBAgtiOJeNhXlREwYNxOv/WP6HXqIUza16hUmfPbSG/nKU+W9Kig7ar4vXHvtNEYu
	 FS0019YupmS1ywWvxbENM5BQEwyZf6Bp2dHp/vXSFdWZ1WXoR9B3juzs8b9410XTcd
	 b7P/EeDAVeV+g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net 10/10] net/mlx5e: RSS, Block XOR hash with over 128 channels
Date: Tue, 26 Mar 2024 07:46:46 -0700
Message-ID: <20240326144646.2078893-11-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

When supporting more than 128 channels, the RQT size is
calculated by multiplying the number of channels by 2
and rounding up to the nearest power of 2.

The index of the RQT is derived from the RSS hash
calculations. If XOR8 is used as the RSS hash function,
there are only 256 possible hash results, and therefore,
only 256 indexes can be reached in the RQT.

Block setting the RSS hash function to XOR when the number
of channels exceeds 128.

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  7 +++++
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 +++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index bcafb4bf9415..8d9a3b5ec973 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -179,6 +179,13 @@ u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels)
 	return min_t(u32, rqt_size, max_cap_rqt_size);
 }
 
+#define MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH 256
+
+unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void)
+{
+	return MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH / MLX5E_UNIFORM_SPREAD_RQT_FACTOR;
+}
+
 void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt)
 {
 	mlx5_core_destroy_rqt(rqt->mdev, rqt->rqtn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index e0bc30308c77..2f9e04a8418f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -38,6 +38,7 @@ static inline u32 mlx5e_rqt_get_rqtn(struct mlx5e_rqt *rqt)
 }
 
 u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels);
+unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void);
 int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn, u32 *vhca_id);
 int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
 			     unsigned int num_rqns,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index c5a203b5119d..d60cb6d47d26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -451,6 +451,17 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	mutex_lock(&priv->state_lock);
 
+	if (mlx5e_rx_res_get_current_hash(priv->rx_res).hfunc == ETH_RSS_HASH_XOR) {
+		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
+
+		if (count > xor8_max_channels) {
+			err = -EINVAL;
+			netdev_err(priv->netdev, "%s: Requested number of channels (%d) exceeds the maximum allowed by the XOR8 RSS hfunc (%d)\n",
+				   __func__, count, xor8_max_channels);
+			goto out;
+		}
+	}
+
 	/* Don't allow changing the number of channels if RXFH was previously configured.
 	 * Changing the channels number after configuring the RXFH may alter the RSS table size,
 	 * the previous configuration may no longer be compatible with the new RSS table.
@@ -1292,17 +1303,30 @@ int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
+	unsigned int count;
 	int err;
 
 	mutex_lock(&priv->state_lock);
+
+	count = priv->channels.params.num_channels;
+
+	if (hfunc == ETH_RSS_HASH_XOR) {
+		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
+
+		if (count > xor8_max_channels) {
+			err = -EINVAL;
+			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
+				   __func__, count, xor8_max_channels);
+			goto unlock;
+		}
+	}
+
 	if (*rss_context && rxfh->rss_delete) {
 		err = mlx5e_rx_res_rss_destroy(priv->rx_res, *rss_context);
 		goto unlock;
 	}
 
 	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		unsigned int count = priv->channels.params.num_channels;
-
 		err = mlx5e_rx_res_rss_init(priv->rx_res, rss_context, count);
 		if (err)
 			goto unlock;
-- 
2.44.0


