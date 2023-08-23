Return-Path: <netdev+bounces-29867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE101784FDA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F71C20C46
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6B1FB8;
	Wed, 23 Aug 2023 05:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5A1842
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFADC433C8;
	Wed, 23 Aug 2023 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767429;
	bh=cYrezqzWp0notrewCpvv4JVuIj25mpTb9jPKLzCyeSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNksXO8pJWEVN00VccnrAFIMjpeGQh/lbli2E1VErK54acJKfDfl1f9BVDLe6dbtp
	 IYk8n5FOYiIT9MgjJ97I0f7tl2NtBN1VarIM7JGu+yPHNDK+nmam8xvi71PoFwBdvs
	 UbUiIgx32HnzpFyuxJgYB221ZgVI5eWhfUJNLPYjAoaen+HP8nyI5F9rpvroclx78R
	 ET918X8xGlM/vWqHPyrFHWgxNRGSp+P5h2qHUMjmX5q8BmyKDAoL6hoj4J+v1MpkKe
	 Y94j627w7cF1DoTZ1RKOXHaUJeS0787kEEW76++LBuK4zmFchTd0WCT+HCt+ygNG5m
	 TgMt2+13l/wFA==
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
Subject: [net-next 05/15] net/mlx5: Introduce mlx5_eswitch_load/unload_sf_vport() and use it from SF code
Date: Tue, 22 Aug 2023 22:10:02 -0700
Message-ID: <20230823051012.162483-6-saeed@kernel.org>
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

Similar to the PF/VF helpers, introduce a set of load/unload helpers
for SF vports. From there, call mlx5_eswitch_load/unload_vport() which
are common for PFs/VFs and newly introduced SF helpers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  8 +++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 27 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 17 ++++++++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 12 +++++++++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  8 +++---
 5 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 60e25fbaef5f..540bebd93ea5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -112,9 +112,9 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum, !!controller);
 }
 
-static int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
-						  struct devlink_port *dl_port,
-						  u32 controller, u32 sfnum)
+int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
+					   struct devlink_port *dl_port,
+					   u32 controller, u32 sfnum)
 {
 	struct mlx5_vport *vport;
 
@@ -128,7 +128,7 @@ static int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16
 	return 0;
 }
 
-static void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_vport *vport;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 76d05e233770..f77237401ee9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1119,6 +1119,33 @@ static void mlx5_eswitch_unload_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_
 	mlx5_esw_offloads_cleanup_pf_vf_rep(esw, vport_num);
 }
 
+int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
+			       enum mlx5_eswitch_vport_event enabled_events,
+			       struct devlink_port *dl_port, u32 controller, u32 sfnum)
+{
+	int err;
+
+	err = mlx5_esw_offloads_init_sf_rep(esw, vport_num, dl_port, controller, sfnum);
+	if (err)
+		return err;
+
+	err = mlx5_eswitch_load_vport(esw, vport_num, enabled_events);
+	if (err)
+		goto err_load;
+
+	return 0;
+
+err_load:
+	mlx5_esw_offloads_cleanup_sf_rep(esw, vport_num);
+	return err;
+}
+
+void mlx5_eswitch_unload_sf_vport(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	mlx5_eswitch_unload_vport(esw, vport_num);
+	mlx5_esw_offloads_cleanup_sf_rep(esw, vport_num);
+}
+
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs)
 {
 	struct mlx5_vport *vport;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8367c639e234..89efeffa075d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -731,15 +731,32 @@ void mlx5_esw_set_spec_source_port(struct mlx5_eswitch *esw,
 
 int mlx5_esw_offloads_init_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num);
+
+int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
+				  struct devlink_port *dl_port,
+				  u32 controller, u32 sfnum);
+void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, u16 vport_num);
+
 int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num);
 
+int mlx5_eswitch_load_sf_vport(struct mlx5_eswitch *esw, u16 vport_num,
+			       enum mlx5_eswitch_vport_event enabled_events,
+			       struct devlink_port *dl_port, u32 controller, u32 sfnum);
+void mlx5_eswitch_unload_sf_vport(struct mlx5_eswitch *esw, u16 vport_num);
+
 int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events);
 void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs);
 
 int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_pf_vf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
+
+int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, u16 vport_num,
+					   struct devlink_port *dl_port,
+					   u32 controller, u32 sfnum);
+void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, u16 vport_num);
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, u16 vport_num);
 void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vport_num);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 055faaf5dbb7..998e56cf43db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2551,6 +2551,18 @@ void mlx5_esw_offloads_cleanup_pf_vf_rep(struct mlx5_eswitch *esw, u16 vport_num
 	mlx5_esw_offloads_pf_vf_devlink_port_cleanup(esw, vport_num);
 }
 
+int mlx5_esw_offloads_init_sf_rep(struct mlx5_eswitch *esw, u16 vport_num,
+				  struct devlink_port *dl_port,
+				  u32 controller, u32 sfnum)
+{
+	return mlx5_esw_offloads_sf_devlink_port_init(esw, vport_num, dl_port, controller, sfnum);
+}
+
+void mlx5_esw_offloads_cleanup_sf_rep(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	mlx5_esw_offloads_sf_devlink_port_cleanup(esw, vport_num);
+}
+
 int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 6a3fa30b2bf2..f7bdbeb92eb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -292,8 +292,8 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	if (IS_ERR(sf))
 		return PTR_ERR(sf);
 
-	err = mlx5_esw_offloads_sf_vport_enable(esw, &sf->dl_port, sf->hw_fn_id,
-						new_attr->controller, new_attr->sfnum);
+	err = mlx5_eswitch_load_sf_vport(esw, sf->hw_fn_id, MLX5_VPORT_UC_ADDR_CHANGE,
+					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
 	if (err)
 		goto esw_err;
 	*dl_port = &sf->dl_port;
@@ -400,7 +400,7 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 		goto sf_err;
 	}
 
-	mlx5_esw_offloads_sf_vport_disable(esw, sf->hw_fn_id);
+	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
 	mlx5_sf_id_erase(table, sf);
 
 	mutex_lock(&table->sf_state_lock);
@@ -472,7 +472,7 @@ static void mlx5_sf_deactivate_all(struct mlx5_sf_table *table)
 	 * arrive. It is safe to destroy all user created SFs.
 	 */
 	xa_for_each(&table->port_indices, index, sf) {
-		mlx5_esw_offloads_sf_vport_disable(esw, sf->hw_fn_id);
+		mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
 		mlx5_sf_id_erase(table, sf);
 		mlx5_sf_dealloc(table, sf);
 	}
-- 
2.41.0


