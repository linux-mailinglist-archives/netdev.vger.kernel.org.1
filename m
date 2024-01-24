Return-Path: <netdev+bounces-65358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4FB83A3EA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649BC1F2CE0E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114617560;
	Wed, 24 Jan 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stcKFqpn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCF1755B
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084343; cv=none; b=KWGB20U5OQ+scHMYd1DAwpjHi3h0PGr+hJwYPRH/sFP4ZK8+SQmF+rRuTwmS1kqfsVgm+5xQGczYidVAoi2rdbtiwkTUyJCVm6d/Yi7b+L8HS/FyH4ERXN+3HzsrwTRfypAqp2emiT414c+ckUvaz5v8RrwGb75/B4SEFgeKxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084343; c=relaxed/simple;
	bh=rA6dn+6bYLuo3/wdbkYCg5ckmOYSKUVrOiqp356DWWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GovSj6jljCL2X91oZ9HVKszRHKc7wUl4j5jnCIMXpQAz2qsQVCcbH3KJIyyVlFnS5D74LH5TD8f+dGG/kLfzNvXkVgmHOOH5eUeJ7W4FliDLs5HA8YBgVbFLOzlokxMumRHfztHm4ojcNRYP04UNryuh8G5DQ6XkA21/Yz7dtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stcKFqpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB45C433A6;
	Wed, 24 Jan 2024 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084342;
	bh=rA6dn+6bYLuo3/wdbkYCg5ckmOYSKUVrOiqp356DWWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stcKFqpn74wDokA0mAqFgvMl/9pBZNRMcssTZXe1qdyV92dGOvhzI5CxYxlk3rJcS
	 1z40EmPNRijWZXESg8WiX2JauZB4XcUitJK78CM1wQE9xFQjTiZa9r/6XYgn/2WsAI
	 cDw9JGRhOZ+jbXRVbvwNjYYNuBRR8Zufv04ErmCi9lu+anJ3vdfTWEv6VNeuiYg+6M
	 ZbZ3Pg1/9MOD2axMDiZd6cW/upJ3GX8xPWBWSoSD4Ye97TSG8H5bMTNw5V7zdq5K8o
	 oVtw2RyvAoAO+9uo4Ikz7p4XEGx+Rg1V6H5NchhhUOy3eS4U18RnKFdIZjc4fLAh8G
	 hvUooYaJwB7qg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net 01/14] net/mlx5e: Use the correct lag ports number when creating TISes
Date: Wed, 24 Jan 2024 00:18:42 -0800
Message-ID: <20240124081855.115410-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

The cited commit moved the code of mlx5e_create_tises() and changed the
loop to create TISes over MLX5_MAX_PORTS constant value, instead of
getting the correct lag ports supported by the device, which can cause
FW errors on devices with less than MLX5_MAX_PORTS ports.

Change that back to mlx5e_get_num_lag_ports(mdev).

Also IPoIB interfaces create there own TISes, they don't use the eth
TISes, pass a flag to indicate that.

This fixes the following errors that might appear in kernel log:
mlx5_cmd_out_err:808:(pid 650): CREATE_TIS(0x912) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x595b5d), err(-22)
mlx5e_create_mdev_resources:174:(pid 650): alloc tises failed, -22

Fixes: b25bd37c859f ("net/mlx5: Move TISes from priv to mdev HW resources")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   | 21 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  2 +-
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0bfe1ca8a364..55c6ace0acd5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1124,7 +1124,7 @@ static inline bool mlx5_tx_swp_supported(struct mlx5_core_dev *mdev)
 extern const struct ethtool_ops mlx5e_ethtool_ops;
 
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey);
-int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev);
+int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises);
 void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev);
 int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 		       bool enable_mc_lb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 67f546683e85..6ed3a32b7e22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -95,7 +95,7 @@ static void mlx5e_destroy_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PO
 {
 	int tc, i;
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < mlx5e_get_num_lag_ports(mdev); i++)
 		for (tc = 0; tc < MLX5_MAX_NUM_TC; tc++)
 			mlx5e_destroy_tis(mdev, tisn[i][tc]);
 }
@@ -110,7 +110,7 @@ static int mlx5e_create_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORT
 	int tc, i;
 	int err;
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++) {
+	for (i = 0; i < mlx5e_get_num_lag_ports(mdev); i++) {
 		for (tc = 0; tc < MLX5_MAX_NUM_TC; tc++) {
 			u32 in[MLX5_ST_SZ_DW(create_tis_in)] = {};
 			void *tisc;
@@ -140,7 +140,7 @@ static int mlx5e_create_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORT
 	return err;
 }
 
-int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
+int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 {
 	struct mlx5e_hw_objs *res = &mdev->mlx5e_res.hw_objs;
 	int err;
@@ -169,11 +169,15 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
 		goto err_destroy_mkey;
 	}
 
-	err = mlx5e_create_tises(mdev, res->tisn);
-	if (err) {
-		mlx5_core_err(mdev, "alloc tises failed, %d\n", err);
-		goto err_destroy_bfreg;
+	if (create_tises) {
+		err = mlx5e_create_tises(mdev, res->tisn);
+		if (err) {
+			mlx5_core_err(mdev, "alloc tises failed, %d\n", err);
+			goto err_destroy_bfreg;
+		}
+		res->tisn_valid = true;
 	}
+
 	INIT_LIST_HEAD(&res->td.tirs_list);
 	mutex_init(&res->td.list_lock);
 
@@ -203,7 +207,8 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 
 	mlx5_crypto_dek_cleanup(mdev->mlx5e_res.dek_priv);
 	mdev->mlx5e_res.dek_priv = NULL;
-	mlx5e_destroy_tises(mdev, res->tisn);
+	if (res->tisn_valid)
+		mlx5e_destroy_tises(mdev, res->tisn);
 	mlx5_free_bfreg(mdev, &res->bfreg);
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 	mlx5_core_dealloc_transport_domain(mdev, res->td.tdn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b5f1c4ca38ba..c8e8f512803e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5992,7 +5992,7 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 	if (netif_device_present(netdev))
 		return 0;
 
-	err = mlx5e_create_mdev_resources(mdev);
+	err = mlx5e_create_mdev_resources(mdev, true);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 58845121954c..d77be1b4dd9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -783,7 +783,7 @@ static int mlx5_rdma_setup_rn(struct ib_device *ibdev, u32 port_num,
 		}
 
 		/* This should only be called once per mdev */
-		err = mlx5e_create_mdev_resources(mdev);
+		err = mlx5e_create_mdev_resources(mdev, false);
 		if (err)
 			goto destroy_ht;
 	}
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8c55ff351e5f..41f03b352401 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -681,6 +681,7 @@ struct mlx5e_resources {
 		struct mlx5_sq_bfreg       bfreg;
 #define MLX5_MAX_NUM_TC 8
 		u32                        tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC];
+		bool			   tisn_valid;
 	} hw_objs;
 	struct net_device *uplink_netdev;
 	struct mutex uplink_netdev_lock;
-- 
2.43.0


