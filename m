Return-Path: <netdev+bounces-29865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A53784FD6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B74A1C20C46
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459C749C;
	Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5094185C
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C99DC433C9;
	Wed, 23 Aug 2023 05:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767427;
	bh=KapdJ/2uE9/K3dW6ge83OPgQxh6apkkL9STdT6lVU4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ji7OWrHS2aXIv3WQ0PfQ7tmJrJo8QcNobLHyyLWwY8kiBT6/EvWJ1Xv5fxF4IhByO
	 jaEuwz/UbpkJPu1ZmVJnKaowC0FdfiLQHxF0NuZg1Oq2MeE5PzILnUUg7PfE07Vk7A
	 P+/Dcjfk3699XqVD06hp7chVhzUEG+UZI6wIph039LrYb9x+kTfEeyTysnQ12u64qS
	 q9INF9Y2V4Ug4I3sHNI1MJxyFrf000vzUf3OZJJUaNbMoo99dCL3rBrYJK/zKkjAzL
	 1I/ApjJbpie7FqMh9q65M9iB+eCXG9uW0+IoogngUt0DodifV6t5/lGQjNFXJgsR/4
	 A+yI/Jnl2ax0g==
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
Subject: [net-next 03/15] net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()
Date: Tue, 22 Aug 2023 22:10:00 -0700
Message-ID: <20230823051012.162483-4-saeed@kernel.org>
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

In order to prepare for
mlx5_esw_offloads_devlink_port_register/unregister() to be used
for SFs as well, push out the PF/VF specific init/cleanup calls outside.
Introduce mlx5_eswitch_load/unload_pf_vf_vport() and call them from
there. Use these new helpers of PF/VF loading and make
mlx5_eswitch_local/unload_vport() reusable for SFs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 13 ++----
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 45 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 16 +++++++
 4 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index dfb1101dfef0..5e8557f7564c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -54,7 +54,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 	}
 }
 
-static int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct devlink_port *dl_port;
 	struct mlx5_vport *vport;
@@ -76,7 +76,7 @@ static int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u
 	return 0;
 }
 
-static void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_vport *vport;
 
@@ -152,10 +152,6 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	err = mlx5_esw_offloads_pf_vf_devlink_port_init(esw, vport_num);
-	if (err)
-		return err;
-
 	dl_port = vport->dl_port;
 	if (!dl_port)
 		return 0;
@@ -165,7 +161,7 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 	err = devl_port_register_with_ops(devlink, dl_port, dl_port_index,
 					  &mlx5_esw_pf_vf_dl_port_ops);
 	if (err)
-		goto reg_err;
+		return err;
 
 	err = devl_rate_leaf_create(dl_port, vport, NULL);
 	if (err)
@@ -175,8 +171,6 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_
 
 rate_err:
 	devl_port_unregister(dl_port);
-reg_err:
-	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
 	return err;
 }
 
@@ -192,7 +186,6 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vpo
 	devl_rate_leaf_destroy(vport->dl_port);
 
 	devl_port_unregister(vport->dl_port);
-	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
 }
 
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4a7a13169a90..76d05e233770 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1094,6 +1094,31 @@ static void mlx5_eswitch_unload_vport(struct mlx5_eswitch *esw, u16 vport_num)
 	mlx5_esw_vport_disable(esw, vport_num);
 }
 
+static int mlx5_eswitch_load_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num,
+					 enum mlx5_eswitch_vport_event enabled_events)
+{
+	int err;
+
+	err = mlx5_esw_offloads_init_pf_vf_rep(esw, vport_num);
+	if (err)
+		return err;
+
+	err = mlx5_eswitch_load_vport(esw, vport_num, enabled_events);
+	if (err)
+		goto err_load;
+	return 0;
+
+err_load:
+	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport_num);
+	return err;
+}
+
+static void mlx5_eswitch_unload_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	mlx5_eswitch_unload_vport(esw, vport_num);
+	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport_num);
+}
+
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs)
 {
 	struct mlx5_vport *vport;
@@ -1102,7 +1127,7 @@ void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs)
 	mlx5_esw_for_each_vf_vport(esw, i, vport, num_vfs) {
 		if (!vport->enabled)
 			continue;
-		mlx5_eswitch_unload_vport(esw, vport->vport);
+		mlx5_eswitch_unload_pf_vf_vport(esw, vport->vport);
 	}
 }
 
@@ -1115,7 +1140,7 @@ static void mlx5_eswitch_unload_ec_vf_vports(struct mlx5_eswitch *esw,
 	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, num_ec_vfs) {
 		if (!vport->enabled)
 			continue;
-		mlx5_eswitch_unload_vport(esw, vport->vport);
+		mlx5_eswitch_unload_pf_vf_vport(esw, vport->vport);
 	}
 }
 
@@ -1127,7 +1152,7 @@ int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 	int err;
 
 	mlx5_esw_for_each_vf_vport(esw, i, vport, num_vfs) {
-		err = mlx5_eswitch_load_vport(esw, vport->vport, enabled_events);
+		err = mlx5_eswitch_load_pf_vf_vport(esw, vport->vport, enabled_events);
 		if (err)
 			goto vf_err;
 	}
@@ -1147,7 +1172,7 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
 	int err;
 
 	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, num_ec_vfs) {
-		err = mlx5_eswitch_load_vport(esw, vport->vport, enabled_events);
+		err = mlx5_eswitch_load_pf_vf_vport(esw, vport->vport, enabled_events);
 		if (err)
 			goto vf_err;
 	}
@@ -1189,7 +1214,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 	int ret;
 
 	/* Enable PF vport */
-	ret = mlx5_eswitch_load_vport(esw, MLX5_VPORT_PF, enabled_events);
+	ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF, enabled_events);
 	if (ret)
 		return ret;
 
@@ -1200,7 +1225,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 
 	/* Enable ECPF vport */
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		ret = mlx5_eswitch_load_vport(esw, MLX5_VPORT_ECPF, enabled_events);
+		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_ECPF, enabled_events);
 		if (ret)
 			goto ecpf_err;
 		if (mlx5_core_ec_sriov_enabled(esw->dev)) {
@@ -1223,11 +1248,11 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_ec_vfs);
 ec_vf_err:
 	if (mlx5_ecpf_vport_exists(esw->dev))
-		mlx5_eswitch_unload_vport(esw, MLX5_VPORT_ECPF);
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 ecpf_err:
 	host_pf_disable_hca(esw->dev);
 pf_hca_err:
-	mlx5_eswitch_unload_vport(esw, MLX5_VPORT_PF);
+	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 	return ret;
 }
 
@@ -1241,11 +1266,11 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
 		if (mlx5_core_ec_sriov_enabled(esw->dev))
 			mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_vfs);
-		mlx5_eswitch_unload_vport(esw, MLX5_VPORT_ECPF);
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 	}
 
 	host_pf_disable_hca(esw->dev);
-	mlx5_eswitch_unload_vport(esw, MLX5_VPORT_PF);
+	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 }
 
 static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f3a6a1826e00..8367c639e234 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -729,6 +729,8 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 				   u16 vport,
 				   struct mlx5_flow_spec *spec);
 
+int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
 int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
@@ -736,6 +738,8 @@ int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs);
 
+int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num);
+void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c0b1b7b66cff..055faaf5dbb7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2535,6 +2535,22 @@ static void mlx5_esw_offloads_rep_unload(struct mlx5_eswitch *esw, u16 vport_num
 		__esw_offloads_unload_rep(esw, rep, rep_type);
 }
 
+int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return 0;
+
+	return mlx5_esw_offloads_pf_vf_devlink_port_init(esw, vport_num);
+}
+
+void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return;
+
+	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
+}
+
 int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	int err;
-- 
2.41.0


