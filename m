Return-Path: <netdev+bounces-159072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B6A1444D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1953F3AAA1E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43D24386F;
	Thu, 16 Jan 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuQ4+eKl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27616243853
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064561; cv=none; b=aJBFuhBxGaNd2T2k03n+1yWtxPXvTctA8bYPulhofz3N0zrZaaxaaA2Oxh/4v4bOAGBc4q+T0LKky+2230E/8deCM9rrSwJjIiGo9TohWYOF+3apxqhmnacFF4CqgSkrpoq5NfZW5D0LTXuftdpEf6jMY71Jf3lk3/QqQ1C5Yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064561; c=relaxed/simple;
	bh=3a1Kgxkp7cFO0SKRQVCaOOhbnuY6OHqdt5jjCtEd06k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP8KIYL+ryOZ8qlLYP7EQP0aRNL/yYPwu2MtfHSGbObMeeNnBxmzfpmlA2CGf6G760hn4RR8JO2QnlXxTKdsalyi8b23ZnPm5xhs9TmJEtxW0rEhTRDh0vfEpGGaS3HPQvn7VkvbhgTCUS9YkMl3Aa9r0n45gxArzWIT8eSL5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuQ4+eKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8BC4CED6;
	Thu, 16 Jan 2025 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064561;
	bh=3a1Kgxkp7cFO0SKRQVCaOOhbnuY6OHqdt5jjCtEd06k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuQ4+eKlpj3HjqxmsF61YZPpaPQBnt4tRJhURbb4MfXUqoE5sJM8yjVI8Ah8Ig/gQ
	 DE37yI+TqFhjoNxXtXXyVEEh1ePufpK+EKVHtyqjwXCsu95iuCoKVC62audKDAJesk
	 wyV/dQKEIYQNn345jNnkao+PvjWzsudxwUJewFpKbHdNKN4In5WFyq3zI/pJ47zfmH
	 mvCMYBrtP81JPecx69VDZor36+CA7sFV1yZRSz3PNpMpYZkzu1J+9lQMRAMMh+auAd
	 P/rFFjH4Jj2hRG3xhgmEZwGAy7HzhkAGFBmerxqOCxGDVvKGsxTxto9gqrSLpRe8Yk
	 PYRK1cC/T2NZw==
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 11/11] net/mlx5e: Support ethtool tcp-data-split settings
Date: Thu, 16 Jan 2025 13:55:29 -0800
Message-ID: <20250116215530.158886-12-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Try enabling HW GRO when requested.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cae39198b4db..ee188e033e99 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -349,6 +349,14 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
 		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
 		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+
+	/* if HW GRO is not enabled due to external limitations but is wanted,
+	 * report HDS state as unknown so it won't get truned off explicitly.
+	 */
+	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    priv->netdev->wanted_features & NETIF_F_GRO_HW)
+		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -361,6 +369,43 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
 }
 
+static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
+					     u8 tcp_data_split)
+{
+	bool enable = (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED);
+	struct net_device *dev = priv->netdev;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		return true;
+
+	if (enable && !(dev->hw_features & NETIF_F_GRO_HW)) {
+		netdev_warn(dev, "TCP-data-split is not supported when GRO HW is not supported\n");
+		return false; /* GRO HW is not supported */
+	}
+
+	if (enable && (dev->features & NETIF_F_GRO_HW)) {
+		/* Already enabled */
+		dev->wanted_features |= NETIF_F_GRO_HW;
+		return true;
+	}
+
+	if (!enable && !(dev->features & NETIF_F_GRO_HW)) {
+		/* Already disabled */
+		dev->wanted_features &= ~NETIF_F_GRO_HW;
+		return true;
+	}
+
+	/* Try enable or disable GRO HW */
+	if (enable)
+		dev->wanted_features |= NETIF_F_GRO_HW;
+	else
+		dev->wanted_features &= ~NETIF_F_GRO_HW;
+
+	netdev_change_features(dev);
+
+	return enable == !!(dev->features & NETIF_F_GRO_HW);
+}
+
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 				struct ethtool_ringparam *param,
 				struct netlink_ext_ack *extack)
@@ -419,6 +464,9 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
+	if (!mlx5e_ethtool_set_tcp_data_split(priv, kernel_param->tcp_data_split))
+		return -EINVAL;
+
 	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
@@ -2613,6 +2661,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.48.0


