Return-Path: <netdev+bounces-32113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D4792CB9
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E2F2811FB
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29092DDBC;
	Tue,  5 Sep 2023 17:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808CDDB0
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41D3C433C9;
	Tue,  5 Sep 2023 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693936129;
	bh=BB8SGk1oflsAIsNYnjk5FTtlvzpq0nOvXRrJvmd7exo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bwq/I8PWm78lze1v0l2GpFRm0RiF3IVHRhdqxyVYeEmzVTNr+/1mEsuON13n6T4Z+
	 Xootk+RxJmsLFwI9CvCLKmnq00ziFi315ik9CFoapCOuEB91rVlU/t/FA0vCBxlOgX
	 /Lk6WVKEPo7tCTYLqh1YCt1lYC/FwoQPjHuChc///CaLinst9Hx4DD6GVeyOaFjWig
	 4d60uCdZnhM8/XBY5RLAJ5kffF8TmcXR+ejaPJs3Y8lRKbTQrQb+nezMxHNa7lnzxh
	 2fuuBznqGaWhOzofJARhZEfyhe6jDF7+VFUv3HcbK4M0CMyOXQBOZhhC5O1J4gQsSR
	 GUxYph860D0zQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Bodong Wang <bodong@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 2/2] mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode
Date: Tue,  5 Sep 2023 10:48:46 -0700
Message-ID: <20230905174846.24124-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905174846.24124-1-saeed@kernel.org>
References: <20230905174846.24124-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bodong Wang <bodong@nvidia.com>

ACL flow table is required in switchdev mode when metadata is enabled,
driver creates such table when loading each vport. However, not every
vport is loaded in switchdev mode. Such as ECPF if it's the eswitch manager.
In this case, ACL flow table is still needed.

To make it modularized, create ACL flow table for eswitch manager as
default and skip such operations when loading manager vport.

Also, there is no need to load the eswitch manager vport in switchdev mode.
This means there is no need to load it on regular connect-x HCAs where
the PF is the eswitch manager. This will avoid creating duplicate ACL
flow table for host PF vport.

Fixes: 29bcb6e4fe70 ("net/mlx5e: E-Switch, Use metadata for vport matching in send-to-vport rules")
Fixes: eb8e9fae0a22 ("mlx5/core: E-Switch, Allocate ECPF vport if it's an eswitch manager")
Fixes: 5019833d661f ("net/mlx5: E-switch, Introduce helper function to enable/disable vports")
Signed-off-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 49 +++++++++++++------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 6cd7d6497e10..d4cde6555063 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1276,12 +1276,19 @@ int
 mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 				 enum mlx5_eswitch_vport_event enabled_events)
 {
+	bool pf_needed;
 	int ret;
 
+	pf_needed = mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+		    esw->mode == MLX5_ESWITCH_LEGACY;
+
 	/* Enable PF vport */
-	ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF, enabled_events);
-	if (ret)
-		return ret;
+	if (pf_needed) {
+		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF,
+						    enabled_events);
+		if (ret)
+			return ret;
+	}
 
 	/* Enable external host PF HCA */
 	ret = host_pf_enable_hca(esw->dev);
@@ -1317,7 +1324,8 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 ecpf_err:
 	host_pf_disable_hca(esw->dev);
 pf_hca_err:
-	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+	if (pf_needed)
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 	return ret;
 }
 
@@ -1335,7 +1343,10 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 	}
 
 	host_pf_disable_hca(esw->dev);
-	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+
+	if (mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+	    esw->mode == MLX5_ESWITCH_LEGACY)
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 }
 
 static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 752fb0dfb111..b296ac52a439 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3216,26 +3216,47 @@ esw_vport_destroy_offloads_acl_tables(struct mlx5_eswitch *esw,
 	esw_acl_ingress_ofld_cleanup(esw, vport);
 }
 
-static int esw_create_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
+static int esw_create_offloads_acl_tables(struct mlx5_eswitch *esw)
 {
-	struct mlx5_vport *vport;
+	struct mlx5_vport *uplink, *manager;
+	int ret;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
+	uplink = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(uplink))
+		return PTR_ERR(uplink);
+
+	ret = esw_vport_create_offloads_acl_tables(esw, uplink);
+	if (ret)
+		return ret;
+
+	manager = mlx5_eswitch_get_vport(esw, esw->manager_vport);
+	if (IS_ERR(manager)) {
+		ret = PTR_ERR(manager);
+		goto err_manager;
+	}
 
-	return esw_vport_create_offloads_acl_tables(esw, vport);
+	ret = esw_vport_create_offloads_acl_tables(esw, manager);
+	if (ret)
+		goto err_manager;
+
+	return 0;
+
+err_manager:
+	esw_vport_destroy_offloads_acl_tables(esw, uplink);
+	return ret;
 }
 
-static void esw_destroy_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
+static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 {
 	struct mlx5_vport *vport;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
-	if (IS_ERR(vport))
-		return;
+	vport = mlx5_eswitch_get_vport(esw, esw->manager_vport);
+	if (!IS_ERR(vport))
+		esw_vport_destroy_offloads_acl_tables(esw, vport);
 
-	esw_vport_destroy_offloads_acl_tables(esw, vport);
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (!IS_ERR(vport))
+		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
 int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
@@ -3280,7 +3301,7 @@ static int esw_offloads_steering_init(struct mlx5_eswitch *esw)
 	}
 	esw->fdb_table.offloads.indir = indir;
 
-	err = esw_create_uplink_offloads_acl_tables(esw);
+	err = esw_create_offloads_acl_tables(esw);
 	if (err)
 		goto create_acl_err;
 
@@ -3321,7 +3342,7 @@ static int esw_offloads_steering_init(struct mlx5_eswitch *esw)
 create_restore_err:
 	esw_destroy_offloads_table(esw);
 create_offloads_err:
-	esw_destroy_uplink_offloads_acl_tables(esw);
+	esw_destroy_offloads_acl_tables(esw);
 create_acl_err:
 	mlx5_esw_indir_table_destroy(esw->fdb_table.offloads.indir);
 create_indir_err:
@@ -3337,7 +3358,7 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 	esw_destroy_offloads_fdb_tables(esw);
 	esw_destroy_restore_table(esw);
 	esw_destroy_offloads_table(esw);
-	esw_destroy_uplink_offloads_acl_tables(esw);
+	esw_destroy_offloads_acl_tables(esw);
 	mlx5_esw_indir_table_destroy(esw->fdb_table.offloads.indir);
 	mutex_destroy(&esw->fdb_table.offloads.vports.lock);
 }
-- 
2.41.0


