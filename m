Return-Path: <netdev+bounces-30554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E79787FEA
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55CD1C20F6E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE81C04;
	Fri, 25 Aug 2023 06:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF5210B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EFCC43395;
	Fri, 25 Aug 2023 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692944998;
	bh=0Vw+srSZZGlahIHJKPpn2jN4uiHoyK/m2tI8fYVbDLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twRIXJNCkfx5FrLtdl9M7/n9dpEmy+oU9nvpixvKoBkt+NffLEPZnYQbsOLOLz+WF
	 GWR0fg0tg4wmUPC730VdqdVGwqkVkE+BSJrv7WNoERCzpxYgl7R9HfUMv3hsuuDldC
	 qf83zSrZuVZ0UE4CUU5V3WGxLi5OYqDZ1Wyg/iQgmtTtxleUTAOACeadF6qrgeiXa+
	 rcfdAwlwbNL4wkoGUco7ouDzpyjkpc5h8S4+D3DzIX0xb66hBYxibdmSOfUrmFcF/B
	 7mPsY2vj0iFRcZniMUc0E1cyCltFhAGqggOzDPvpgkQBeGZkkHqkpuxp8hHCeeOu0R
	 0s6CI2we1XKwg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V4 4/8] net/mlx5e: Rewrite IPsec vs. TC block interface
Date: Thu, 24 Aug 2023 23:28:32 -0700
Message-ID: <20230825062836.103744-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
References: <20230825062836.103744-1-saeed@kernel.org>
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
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
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
index 6fcece69d3be..ed3abcd70c46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -829,10 +829,8 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
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
@@ -916,13 +914,8 @@ static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
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
index 28c4b9724e38..d4697dadd27d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3641,65 +3641,32 @@ static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
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
-
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


