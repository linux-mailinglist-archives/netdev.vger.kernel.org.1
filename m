Return-Path: <netdev+bounces-110620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D449792D7C9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A13EB20BA9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A26194C88;
	Wed, 10 Jul 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn9Vks/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114911946C0
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634113; cv=none; b=fQA5Ub25FVfz4xCIMkumD8GEu8Hil9cjERzlY3W/DGYbeFTPmF5SGszs9KWg/6aKFJgnlR8SJwCbj3n3A9rrBt50jpxjg5SsyYmXmBb2FPUDyLhid5nqhhExiOz5gXUe3jNfTZK4JeeqGiLabDMjzlBBmDUKLErOUl8nqX8hH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634113; c=relaxed/simple;
	bh=RnQIyL9J/i5rGME6ulMv1Yko2uKIA5s3jG9I7hKGlBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SF114MqZub0Tpj2yo1l1jcNo2J4nf7h+91RKLExgKg6UCoelxBXDaSgC8Hp1qkQK5tcy4IyPvmAdKh1kJtLjU9nWEzRmwqFu2M6kphcdEX6lBVSZIXUiBbOe1XsNJXUQsbK9eyAuJFg+VetIE4ukiRaduPkyxiA7a7Gcuqr3/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn9Vks/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34323C32781;
	Wed, 10 Jul 2024 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720634112;
	bh=RnQIyL9J/i5rGME6ulMv1Yko2uKIA5s3jG9I7hKGlBo=;
	h=From:To:Cc:Subject:Date:From;
	b=nn9Vks/QI7mJ007vtFcTsPZNl2zpu94yZqS5qYZLVwXsN+xvBWMBHHu4ta09Ir2Ts
	 MBUKxzOB41rEHqAiOsebe6TyS5JUBSFuMoLuMlL27AxIty0lEYL7CR622pmMPbyGFT
	 oi2AvxaUL1721k2mKSaNnsEnljw36gvDpbFIR/e2jXIVQc9bVSKialAvtTAld6i1DO
	 xW671ym55Mq9b0oRB4bPbrM9Rkb1IkMHBsfc5bkHuzdy976PfMcmR0l57w8q/jwxuE
	 q9CdcaPJP+45Jfuec9SnoQUGpLeiEjoYgxearpNUAgeHLBIMTVWJ2VQSpbvypUExaI
	 oy3WKIAx+j7/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	tariqt@nvidia.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	yuehaibing@huawei.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	afaris@nvidia.com
Subject: [PATCH net-next] eth: mlx5: let NETIF_F_NTUPLE float when ARFS is not enabled
Date: Wed, 10 Jul 2024 10:55:02 -0700
Message-ID: <20240710175502.760194-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARFS depends on NTUPLE filters, but the inverse is not true.
Drivers which don't support ARFS commonly still support NTUPLE
filtering. mlx5 has a Kconfig option to disable ARFS (MLX5_EN_ARFS)
and does not advertise NTUPLE filters as a feature at all when ARFS
is compiled out. That's not correct, ntuple filters indeed still work
just fine (as long as MLX5_EN_RXNFC is enabled).

This is needed to make the RSS test not skip all RSS context
related testing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: tariqt@nvidia.com
CC: rrameshbabu@nvidia.com
CC: saeedm@nvidia.com
CC: yuehaibing@huawei.com
CC: horms@kernel.org
CC: jacob.e.keller@intel.com
CC: afaris@nvidia.com
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h     | 13 +++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c     |  5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   |  6 +++---
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c   |  8 +++-----
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 4d6225e0eec7..1e8b7d330701 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -154,6 +154,19 @@ struct mlx5e_tc_table *mlx5e_fs_get_tc(struct mlx5e_flow_steering *fs);
 struct mlx5e_l2_table *mlx5e_fs_get_l2(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_namespace *mlx5e_fs_get_ns(struct mlx5e_flow_steering *fs, bool egress);
 void mlx5e_fs_set_ns(struct mlx5e_flow_steering *fs, struct mlx5_flow_namespace *ns, bool egress);
+
+static inline bool mlx5e_fs_has_arfs(struct net_device *netdev)
+{
+	return IS_ENABLED(CONFIG_MLX5_EN_ARFS) &&
+		netdev->hw_features & NETIF_F_NTUPLE;
+}
+
+static inline bool mlx5e_fs_want_arfs(struct net_device *netdev)
+{
+	return IS_ENABLED(CONFIG_MLX5_EN_ARFS) &&
+		netdev->features & NETIF_F_NTUPLE;
+}
+
 #ifdef CONFIG_MLX5_EN_RXNFC
 struct mlx5e_ethtool_steering *mlx5e_fs_get_ethtool(struct mlx5e_flow_steering *fs);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 3320f12ba2db..5582c93a62f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -525,7 +525,7 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	opened = test_bit(MLX5E_STATE_OPENED, &priv->state);
 
-	arfs_enabled = opened && (priv->netdev->features & NETIF_F_NTUPLE);
+	arfs_enabled = opened && mlx5e_fs_want_arfs(priv->netdev);
 	if (arfs_enabled)
 		mlx5e_arfs_disable(priv->fs);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 8c5b291a171f..05058710d2c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -1307,8 +1307,7 @@ int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
 		return -EOPNOTSUPP;
 
 	mlx5e_fs_set_ns(fs, ns, false);
-	err = mlx5e_arfs_create_tables(fs, rx_res,
-				       !!(netdev->hw_features & NETIF_F_NTUPLE));
+	err = mlx5e_arfs_create_tables(fs, rx_res, mlx5e_fs_has_arfs(netdev));
 	if (err) {
 		fs_err(fs, "Failed to create arfs tables, err=%d\n", err);
 		netdev->hw_features &= ~NETIF_F_NTUPLE;
@@ -1355,7 +1354,7 @@ int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
 err_destroy_inner_ttc_table:
 	mlx5e_destroy_inner_ttc_table(fs);
 err_destroy_arfs_tables:
-	mlx5e_arfs_destroy_tables(fs, !!(netdev->hw_features & NETIF_F_NTUPLE));
+	mlx5e_arfs_destroy_tables(fs, mlx5e_fs_has_arfs(netdev));
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ff335527c10a..c2c56ffc08d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5556,7 +5556,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 		netdev->hw_features      |= NETIF_F_HW_TC;
 #endif
-#ifdef CONFIG_MLX5_EN_ARFS
+#if IS_ENABLED(CONFIG_MLX5_EN_ARFS) || IS_ENABLED(CONFIG_MLX5_EN_RXNFC)
 		netdev->hw_features	 |= NETIF_F_NTUPLE;
 #endif
 	}
@@ -5731,7 +5731,7 @@ static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
 err_tc_nic_cleanup:
 	mlx5e_tc_nic_cleanup(priv);
 err_destroy_flow_steering:
-	mlx5e_destroy_flow_steering(priv->fs, !!(priv->netdev->hw_features & NETIF_F_NTUPLE),
+	mlx5e_destroy_flow_steering(priv->fs, mlx5e_fs_has_arfs(priv->netdev),
 				    priv->profile);
 err_destroy_rx_res:
 	mlx5e_rx_res_destroy(priv->rx_res);
@@ -5747,7 +5747,7 @@ static void mlx5e_cleanup_nic_rx(struct mlx5e_priv *priv)
 {
 	mlx5e_accel_cleanup_rx(priv);
 	mlx5e_tc_nic_cleanup(priv);
-	mlx5e_destroy_flow_steering(priv->fs, !!(priv->netdev->hw_features & NETIF_F_NTUPLE),
+	mlx5e_destroy_flow_steering(priv->fs, mlx5e_fs_has_arfs(priv->netdev),
 				    priv->profile);
 	mlx5e_rx_res_destroy(priv->rx_res);
 	priv->rx_res = NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 8e0404c0d1ca..0979d672d47f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -372,7 +372,7 @@ static int mlx5i_create_flow_steering(struct mlx5e_priv *priv)
 
 	mlx5e_fs_set_ns(priv->fs, ns, false);
 	err = mlx5e_arfs_create_tables(priv->fs, priv->rx_res,
-				       !!(priv->netdev->hw_features & NETIF_F_NTUPLE));
+				       mlx5e_fs_has_arfs(priv->netdev));
 	if (err) {
 		netdev_err(priv->netdev, "Failed to create arfs tables, err=%d\n",
 			   err);
@@ -391,8 +391,7 @@ static int mlx5i_create_flow_steering(struct mlx5e_priv *priv)
 	return 0;
 
 err_destroy_arfs_tables:
-	mlx5e_arfs_destroy_tables(priv->fs,
-				  !!(priv->netdev->hw_features & NETIF_F_NTUPLE));
+	mlx5e_arfs_destroy_tables(priv->fs, mlx5e_fs_has_arfs(priv->netdev));
 
 	return err;
 }
@@ -400,8 +399,7 @@ static int mlx5i_create_flow_steering(struct mlx5e_priv *priv)
 static void mlx5i_destroy_flow_steering(struct mlx5e_priv *priv)
 {
 	mlx5e_destroy_ttc_table(priv->fs);
-	mlx5e_arfs_destroy_tables(priv->fs,
-				  !!(priv->netdev->hw_features & NETIF_F_NTUPLE));
+	mlx5e_arfs_destroy_tables(priv->fs, mlx5e_fs_has_arfs(priv->netdev));
 	mlx5e_ethtool_cleanup_steering(priv->fs);
 }
 
-- 
2.45.2


