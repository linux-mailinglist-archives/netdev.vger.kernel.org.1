Return-Path: <netdev+bounces-29871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACC784FDF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75411C20C89
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA3A93B;
	Wed, 23 Aug 2023 05:10:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71CA92B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65109C433C8;
	Wed, 23 Aug 2023 05:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767434;
	bh=PwYUg6qqmN2fh7HtdByVkHz+jLS+OnmbRRhKpKMSHJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrDuW1kkXaEOpCbQ30eJaZe7XI1HKF8tB2lLtIrmA8ivhJrDGk6SiQaUs5gVL2gVJ
	 ytaH6vlRKJ73bAkIxCf75U6zVyks2O+0gRhckaE/B6on2CwYpaJ0uC0yOaq4CQoL0b
	 /W3HfgAR5nl20G+l9yNy9DylOcWEyimyUxJLm33bdnYcNk3A8IlJADS8loZRVhiy5Z
	 B4d0K/7p2C58NcRPmFDIDZzu6Eb+XFl0Tm5OK/NjVtfesV/VX/uTVK4GZK4k/XlurO
	 qjuMkP1MTx9KtXZGsTVBzfTdJj+ZwfGe4v+aN9LRmmUlMFRGl1n30OEEQwX/Hth/Au
	 iHQWvIj79+ooQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 09/15] net/mlx5: Reduce number of vport lookups passing vport pointer instead of index
Date: Tue, 22 Aug 2023 22:10:06 -0700
Message-ID: <20230823051012.162483-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823051012.162483-1-saeed@kernel.org>
References: <20230823051012.162483-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

During devlink port init/cleanup and register/unregister calls, there
are many lookups of vport. Instead of passing vport_num as argument to
functions, pass the vport struct pointer directly and avoid repeated
lookups.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 47 +++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 79 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 30 +++----
 .../mellanox/mlx5/core/eswitch_offloads.c     | 30 +++----
 4 files changed, 90 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 35cf2739a2aa..2dc7b0bf38c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -54,18 +54,15 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 	}
 }
 
-int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw,
+					      struct mlx5_vport *vport)
 {
 	struct mlx5_devlink_port *dl_port;
-	struct mlx5_vport *vport;
+	u16 vport_num = vport->vport;
 
 	if (!mlx5_esw_devlink_port_supported(esw, vport_num))
 		return 0;
 
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
-
 	dl_port = kzalloc(sizeof(*dl_port), GFP_KERNEL);
 	if (!dl_port)
 		return -ENOMEM;
@@ -77,12 +74,10 @@ int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vpor
 	return 0;
 }
 
-void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw,
+						  struct mlx5_vport *vport)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport) || !vport->dl_port)
+	if (!vport->dl_port)
 		return;
 
 	kfree(vport->dl_port);
@@ -113,30 +108,18 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum, !!controller);
 }
 
-int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 					   struct mlx5_devlink_port *dl_port,
 					   u32 controller, u32 sfnum)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
-
 	mlx5_esw_offloads_sf_devlink_port_attrs_set(esw, &dl_port->dl_port, controller, sfnum);
 
 	vport->dl_port = dl_port;
 	return 0;
 }
 
-void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return;
-
 	vport->dl_port = NULL;
 }
 
@@ -154,20 +137,16 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 #endif
 };
 
-int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	struct mlx5_core_dev *dev = esw->dev;
 	const struct devlink_port_ops *ops;
 	struct mlx5_devlink_port *dl_port;
+	u16 vport_num = vport->vport;
 	unsigned int dl_port_index;
-	struct mlx5_vport *vport;
 	struct devlink *devlink;
 	int err;
 
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
-
 	dl_port = vport->dl_port;
 	if (!dl_port)
 		return 0;
@@ -196,13 +175,11 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	return err;
 }
 
-void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	struct mlx5_devlink_port *dl_port;
-	struct mlx5_vport *vport;
 
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport) || !vport->dl_port)
+	if (!vport->dl_port)
 		return;
 	dl_port = vport->dl_port;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 044d0ba9fcf6..5368b33fde63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -882,16 +882,12 @@ static void esw_vport_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport
 	esw_vport_cleanup_acl(esw, vport);
 }
 
-int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 			  enum mlx5_eswitch_vport_event enabled_events)
 {
-	struct mlx5_vport *vport;
+	u16 vport_num = vport->vport;
 	int ret;
 
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
-
 	mutex_lock(&esw->state_lock);
 	WARN_ON(vport->enabled);
 
@@ -912,7 +908,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, u16 vport_num,
 	    (!vport_num && mlx5_core_is_ecpf(esw->dev)))
 		vport->info.trusted = true;
 
-	if (!mlx5_esw_is_manager_vport(esw, vport->vport) &&
+	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
 		ret = mlx5_esw_vport_vhca_id_set(esw, vport_num);
 		if (ret)
@@ -939,15 +935,12 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, u16 vport_num,
 	return ret;
 }
 
-void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return;
+	u16 vport_num = vport->vport;
 
 	mutex_lock(&esw->state_lock);
+
 	if (!vport->enabled)
 		goto done;
 
@@ -957,9 +950,9 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, u16 vport_num)
 
 	/* Disable events from this vport */
 	if (MLX5_CAP_GEN(esw->dev, log_max_l2_table))
-		arm_vport_context_events_cmd(esw->dev, vport->vport, 0);
+		arm_vport_context_events_cmd(esw->dev, vport_num, 0);
 
-	if (!mlx5_esw_is_manager_vport(esw, vport->vport) &&
+	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
 		mlx5_esw_vport_vhca_id_clear(esw, vport_num);
 
@@ -1068,82 +1061,104 @@ static void mlx5_eswitch_clear_ec_vf_vports_info(struct mlx5_eswitch *esw)
 	}
 }
 
-static int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, u16 vport_num,
+static int mlx5_eswitch_load_vport(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 				   enum mlx5_eswitch_vport_event enabled_events)
 {
 	int err;
 
-	err = mlx5_esw_vport_enable(esw, vport_num, enabled_events);
+	err = mlx5_esw_vport_enable(esw, vport, enabled_events);
 	if (err)
 		return err;
 
-	err = mlx5_esw_offloads_load_rep(esw, vport_num);
+	err = mlx5_esw_offloads_load_rep(esw, vport);
 	if (err)
 		goto err_rep;
 
 	return err;
 
 err_rep:
-	mlx5_esw_vport_disable(esw, vport_num);
+	mlx5_esw_vport_disable(esw, vport);
 	return err;
 }
 
-static void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num)
+static void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
-	mlx5_esw_offloads_unload_rep(esw, vport_num);
-	mlx5_esw_vport_disable(esw, vport_num);
+	mlx5_esw_offloads_unload_rep(esw, vport);
+	mlx5_esw_vport_disable(esw, vport);
 }
 
 static int mlx5_eswitch_load_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num,
 					 enum mlx5_eswitch_vport_event enabled_events)
 {
+	struct mlx5_vport *vport;
 	int err;
 
-	err = mlx5_esw_offloads_init_pf_vf_rep(esw, vport_num);
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
+	err = mlx5_esw_offloads_init_pf_vf_rep(esw, vport);
 	if (err)
 		return err;
 
-	err = mlx5_eswitch_load_vport(esw, vport_num, enabled_events);
+	err = mlx5_eswitch_load_vport(esw, vport, enabled_events);
 	if (err)
 		goto err_load;
 	return 0;
 
 err_load:
-	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport_num);
+	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport);
 	return err;
 }
 
 static void mlx5_eswitch_unload_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	mlx5_eswitch_unload_vport(esw, vport_num);
-	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport_num);
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return;
+
+	mlx5_eswitch_unload_vport(esw, vport);
+	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport);
 }
 
 int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
 			       enum mlx5_eswitch_vport_event enabled_events,
 			       struct mlx5_devlink_port *dl_port, u32 controller, u32 sfnum)
 {
+	struct mlx5_vport *vport;
 	int err;
 
-	err = mlx5_esw_offloads_init_sf_rep(esw, vport_num, dl_port, controller, sfnum);
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
+	err = mlx5_esw_offloads_init_sf_rep(esw, vport, dl_port, controller, sfnum);
 	if (err)
 		return err;
 
-	err = mlx5_eswitch_load_vport(esw, vport_num, enabled_events);
+	err = mlx5_eswitch_load_vport(esw, vport, enabled_events);
 	if (err)
 		goto err_load;
 
 	return 0;
 
 err_load:
-	mlx5_esw_offloads_cleanup_sf_rep(esw, vport_num);
+	mlx5_esw_offloads_cleanup_sf_rep(esw, vport);
 	return err;
 }
 
 void mlx5_eswitch_unload_sf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	mlx5_eswitch_unload_vport(esw, vport_num);
-	mlx5_esw_offloads_cleanup_sf_rep(esw, vport_num);
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return;
+
+	mlx5_eswitch_unload_vport(esw, vport);
+	mlx5_esw_offloads_cleanup_sf_rep(esw, vport);
 }
 
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b45013465738..8d03d4fe6eec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -694,9 +694,9 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 				 enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw);
 
-int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 			  enum mlx5_eswitch_vport_event enabled_events);
-void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
 int
 esw_vport_create_offloads_acl_tables(struct mlx5_eswitch *esw,
@@ -734,16 +734,16 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 				   u16 vport,
 				   struct mlx5_flow_spec *spec);
 
-int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
-int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 				  struct mlx5_devlink_port *dl_port,
 				  u32 controller, u32 sfnum);
-void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
-int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
 int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
 			       enum mlx5_eswitch_vport_event enabled_events,
@@ -754,16 +754,18 @@ int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs);
 
-int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw,
+					      struct mlx5_vport *vport);
+void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw,
+						  struct mlx5_vport *vport);
 
-int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 					   struct mlx5_devlink_port *dl_port,
 					   u32 controller, u32 sfnum);
-void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
-int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b7ece8767ffe..609605c42d6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2535,63 +2535,63 @@ static void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num
 		__esw_offloads_unload_rep(esw, rep, rep_type);
 }
 
-int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return 0;
 
-	return mlx5_esw_offloads_pf_vf_devlink_port_init(esw, vport_num);
+	return mlx5_esw_offloads_pf_vf_devlink_port_init(esw, vport);
 }
 
-void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return;
 
-	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
+	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport);
 }
 
-int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
+int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 				  struct mlx5_devlink_port *dl_port,
 				  u32 controller, u32 sfnum)
 {
-	return mlx5_esw_offloads_sf_devlink_port_init(esw, vport_num, dl_port, controller, sfnum);
+	return mlx5_esw_offloads_sf_devlink_port_init(esw, vport, dl_port, controller, sfnum);
 }
 
-void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
-	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
+	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport);
 }
 
-int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	int err;
 
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return 0;
 
-	err = mlx5_esw_offloads_devlink_port_register(esw, vport_num);
+	err = mlx5_esw_offloads_devlink_port_register(esw, vport);
 	if (err)
 		return err;
 
-	err = mlx5_esw_offloads_rep_load(esw, vport_num);
+	err = mlx5_esw_offloads_rep_load(esw, vport->vport);
 	if (err)
 		goto load_err;
 	return err;
 
 load_err:
-	mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
+	mlx5_esw_offloads_devlink_port_unregister(esw, vport);
 	return err;
 }
 
-void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return;
 
-	mlx5_esw_offloads_rep_unload(esw, vport_num);
+	mlx5_esw_offloads_rep_unload(esw, vport->vport);
 
-	mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
+	mlx5_esw_offloads_devlink_port_unregister(esw, vport);
 }
 
 static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
-- 
2.41.0


