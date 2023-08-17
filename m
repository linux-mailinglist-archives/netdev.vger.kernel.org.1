Return-Path: <netdev+bounces-28361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892477F2D5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD4B1C2132B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8110974;
	Thu, 17 Aug 2023 09:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D3125DC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8A3C433CB;
	Thu, 17 Aug 2023 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263548;
	bh=kLTRJ0ZMN2abipeMYScnY4IlXKoPyQ4Pp2fvgtrZkC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXPHLvp9exT3G7Nw6V8Q8u/+tRGaYmMYqA6LGiO/yN6RcZ7Bh46HYxE6bMCcPPIwF
	 ZLx3h+8H2X7rbeAHcYSeN7DzCYMFJKTo95PZ26FQlFLwgd6bW/VwQWRGgikV3qFZfA
	 7JQaY2QMrh4zsmOCdz03uS8p8X86nWjqqGwFPU1XLax1QmwTI1FtY01fC4rJFRHykV
	 XUeSx8kkkpoTTsZv1fTcrpSSSsEvl7gDCs7xNws91FVdriwZWfSNX9So2iBqSOGHXC
	 qZfjxa7XojLd3bEvEA8kQEDxdeLDN2JMx/1HyoWJhMXpWzqdX1MIwK/77mYWmPHEKd
	 X0g3w5G2rqBYg==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 4/8] net/mlx5e: Rewrite IPsec vs. TC block interface
Date: Thu, 17 Aug 2023 12:11:26 +0300
Message-ID: <ef01b3ae576fa4d576e59ee01c6cf7ef67c64f99.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In the commit 366e46242b8e ("net/mlx5e: Make IPsec offload work together
with eswitch and TC"), new API to block IPsec vs. TC creation was introduced.

Internally, that API used devlink lock to avoid races with userspace, but it is
not really needed as dev->priv.eswitch is stable and can't be changed. So remove
dependency on devlink lock and move block encap code back to its original place.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 63 +++++++------------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 15 ++---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 53 +++-------------
 3 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index a1cfddd05bc4..7dba4221993f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -254,6 +254,8 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_del_flow_rules(rx->sa.rule);
 	mlx5_destroy_flow_group(rx->sa.group);
 	mlx5_destroy_flow_table(rx->ft.sa);
+	if (rx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(mdev);
 	if (rx == ipsec->rx_esw) {
 		mlx5_esw_ipsec_rx_status_destroy(ipsec, rx);
 	} else {
@@ -357,6 +359,8 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		goto err_add;
 
 	/* Create FT */
+	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
+		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (rx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 2, flags);
@@ -411,6 +415,8 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 err_fs:
 	mlx5_destroy_flow_table(rx->ft.sa);
 err_fs_ft:
+	if (rx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(mdev);
 	mlx5_del_flow_rules(rx->status.rule);
 	mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
 err_add:
@@ -428,26 +434,19 @@ static int rx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (rx->ft.refcnt)
 		goto skip;
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
-
-	err = mlx5_eswitch_block_mode_trylock(mdev);
+	err = mlx5_eswitch_block_mode(mdev);
 	if (err)
-		goto err_out;
+		return err;
 
 	err = rx_create(mdev, ipsec, rx, family);
-	mlx5_eswitch_block_mode_unlock(mdev, err);
-	if (err)
-		goto err_out;
+	if (err) {
+		mlx5_eswitch_unblock_mode(mdev);
+		return err;
+	}
 
 skip:
 	rx->ft.refcnt++;
 	return 0;
-
-err_out:
-	if (rx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
-	return err;
 }
 
 static void rx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_rx *rx,
@@ -456,12 +455,8 @@ static void rx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_rx *rx,
 	if (--rx->ft.refcnt)
 		return;
 
-	mlx5_eswitch_unblock_mode_lock(ipsec->mdev);
 	rx_destroy(ipsec->mdev, ipsec, rx, family);
-	mlx5_eswitch_unblock_mode_unlock(ipsec->mdev);
-
-	if (rx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(ipsec->mdev);
+	mlx5_eswitch_unblock_mode(ipsec->mdev);
 }
 
 static struct mlx5e_ipsec_rx *rx_ft_get(struct mlx5_core_dev *mdev,
@@ -581,6 +576,8 @@ static void tx_destroy(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		mlx5_destroy_flow_group(tx->sa.group);
 	}
 	mlx5_destroy_flow_table(tx->ft.sa);
+	if (tx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(ipsec->mdev);
 	mlx5_del_flow_rules(tx->status.rule);
 	mlx5_destroy_flow_table(tx->ft.status);
 }
@@ -621,6 +618,8 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	if (err)
 		goto err_status_rule;
 
+	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
+		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (tx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 4, flags);
@@ -687,6 +686,8 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 err_sa_miss:
 	mlx5_destroy_flow_table(tx->ft.sa);
 err_sa_ft:
+	if (tx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(mdev);
 	mlx5_del_flow_rules(tx->status.rule);
 err_status_rule:
 	mlx5_destroy_flow_table(tx->ft.status);
@@ -720,32 +721,22 @@ static int tx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (tx->ft.refcnt)
 		goto skip;
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
-
-	err = mlx5_eswitch_block_mode_trylock(mdev);
+	err = mlx5_eswitch_block_mode(mdev);
 	if (err)
-		goto err_out;
+		return err;
 
 	err = tx_create(ipsec, tx, ipsec->roce);
 	if (err) {
-		mlx5_eswitch_block_mode_unlock(mdev, err);
-		goto err_out;
+		mlx5_eswitch_unblock_mode(mdev);
+		return err;
 	}
 
 	if (tx == ipsec->tx_esw)
 		ipsec_esw_tx_ft_policy_set(mdev, tx->ft.pol);
 
-	mlx5_eswitch_block_mode_unlock(mdev, err);
-
 skip:
 	tx->ft.refcnt++;
 	return 0;
-
-err_out:
-	if (tx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
-	return err;
 }
 
 static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
@@ -753,19 +744,13 @@ static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
 	if (--tx->ft.refcnt)
 		return;
 
-	mlx5_eswitch_unblock_mode_lock(ipsec->mdev);
-
 	if (tx == ipsec->tx_esw) {
 		mlx5_esw_ipsec_restore_dest_uplink(ipsec->mdev);
 		ipsec_esw_tx_ft_policy_set(ipsec->mdev, NULL);
 	}
 
 	tx_destroy(ipsec, tx, ipsec->roce);
-
-	mlx5_eswitch_unblock_mode_unlock(ipsec->mdev);
-
-	if (tx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(ipsec->mdev);
+	mlx5_eswitch_unblock_mode(ipsec->mdev);
 }
 
 static struct mlx5_flow_table *tx_ft_get_policy(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f3a6a1826e00..8042e2222ee9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -785,10 +785,8 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
 
-int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev);
-void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err);
-void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev);
-void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev);
+int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev);
+void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev);
 
 static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 {
@@ -872,13 +870,8 @@ static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 {
 }
 
-static inline int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev) { return 0; }
-
-static inline void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err) {}
-
-static inline void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev) {}
-
-static inline void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev) {}
+static inline int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev) { return 0; }
+static inline void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ef2bb04f10be..1cdaba5dca25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3617,65 +3617,32 @@ static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
 	return net_eq(devl_net, netdev_net);
 }
 
-int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev)
+int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	int err;
 
-	devl_lock(devlink);
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw)) {
-		/* Failure means no eswitch => not possible to change eswitch mode */
-		devl_unlock(devlink);
+	if (!mlx5_esw_allowed(esw))
 		return 0;
-	}
 
+	/* Take TC into account */
 	err = mlx5_esw_try_lock(esw);
-	if (err < 0) {
-		devl_unlock(devlink);
+	if (err < 0)
 		return err;
-	}
 
-	return 0;
-}
-
-void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err)
-{
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
-
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw))
-		return;
-
-	if (!err)
-		esw->offloads.num_block_mode++;
+	esw->offloads.num_block_mode++;
 	mlx5_esw_unlock(esw);
-	devl_unlock(devlink);
+	return 0;
 }
 
-void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev)
+void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw))
+	if (!mlx5_esw_allowed(esw))
 		return;
 
 	down_write(&esw->mode_lock);
-}
-
-void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev)
-{
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
-
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw))
-		return;
-
 	esw->offloads.num_block_mode--;
 	up_write(&esw->mode_lock);
 }
-- 
2.41.0


