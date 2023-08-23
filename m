Return-Path: <netdev+bounces-29875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A329C784FE3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBEF1C20C70
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DDA959;
	Wed, 23 Aug 2023 05:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E83AD29
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F47C433B7;
	Wed, 23 Aug 2023 05:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767440;
	bh=y/2E8i+xwjBbtrafhAcdvqxlKxuciknFKTCEpBiggS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHK/WJR5WDLVqqNXowvnXwMEOhSMbAmIWFj15s4ldjpyXoZ3X4gAtB+UwjbycLmHT
	 SRmC6Q6+IIDzENFuDeWgbsHkR6Uevy2ID1wQETTkJPs6QF0mMJ438y5aPBtZDATovP
	 gmxYGt1BieMuNvgaqM0K1FpSiBAWF1aJioMFAOn5ETL+amOZGY0vANZM4eaQQxqpGL
	 dX4Bn9NMhvFhCcYO/rKMrKUOI7xQppdV/RujXLb++VOX2Z/V55zSkSQfGRDZDSTR+I
	 bIvWsBrHmepR3y7oYv2q2ePp+OInscwiSdWmibyMUdLQRYQsX1mY/kRjkwFx07LCwb
	 amQ4LryJaJ05g==
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
Subject: [net-next 13/15] net/mlx5: Store vport in struct mlx5_devlink_port and use it in port ops
Date: Tue, 22 Aug 2023 22:10:10 -0700
Message-ID: <20230823051012.162483-14-saeed@kernel.org>
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

Instead of using internal devlink_port->index to perform vport lookup in
every devlink port op, store the vport pointer to the container struct
mlx5_devlink_port and use it directly in port ops.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 19 ++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 61 +++----------------
 3 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 2dc7b0bf38c7..3c254a710006 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -71,6 +71,7 @@ int mlx5_esw_offloads_pf_vf_devlink_port_init(struct mlx5_eswitch *esw,
 						       &dl_port->dl_port);
 
 	vport->dl_port = dl_port;
+	mlx5_devlink_port_init(dl_port, vport);
 	return 0;
 }
 
@@ -115,6 +116,7 @@ int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, struct mlx5
 	mlx5_esw_offloads_sf_devlink_port_attrs_set(esw, &dl_port->dl_port, controller, sfnum);
 
 	vport->dl_port = dl_port;
+	mlx5_devlink_port_init(dl_port, vport);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9f94c3d6d6e5..6fcece69d3be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -172,10 +172,29 @@ enum mlx5_eswitch_vport_event {
 	MLX5_VPORT_PROMISC_CHANGE = BIT(3),
 };
 
+struct mlx5_vport;
+
 struct mlx5_devlink_port {
 	struct devlink_port dl_port;
+	struct mlx5_vport *vport;
 };
 
+static inline void mlx5_devlink_port_init(struct mlx5_devlink_port *dl_port,
+					  struct mlx5_vport *vport)
+{
+	dl_port->vport = vport;
+}
+
+static inline struct mlx5_devlink_port *mlx5_devlink_port_get(struct devlink_port *dl_port)
+{
+	return container_of(dl_port, struct mlx5_devlink_port, dl_port);
+}
+
+static inline struct mlx5_vport *mlx5_devlink_port_vport_get(struct devlink_port *dl_port)
+{
+	return mlx5_devlink_port_get(dl_port)->vport;
+}
+
 struct mlx5_vport {
 	struct mlx5_core_dev    *dev;
 	struct hlist_head       uc_list[MLX5_L2_ADDR_HASH_SIZE];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e4d1744516f7..67eab99f95b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4223,17 +4223,7 @@ int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	struct mlx5_vport *vport;
-	u16 vport_num;
-
-
-	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-		return PTR_ERR(vport);
-	}
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	mutex_lock(&esw->state_lock);
 	ether_addr_copy(hw_addr, vport->info.mac);
@@ -4247,26 +4237,16 @@ int mlx5_devlink_port_fn_hw_addr_set(struct devlink_port *port,
 				     struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	u16 vport_num;
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
-	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-	return mlx5_eswitch_set_vport_mac(esw, vport_num, hw_addr);
-}
-
-static struct mlx5_vport *
-mlx5_devlink_port_fn_get_vport(struct devlink_port *port, struct mlx5_eswitch *esw)
-{
-	u16 vport_num;
-
-	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
-	return mlx5_eswitch_get_vport(esw, vport_num);
+	return mlx5_eswitch_set_vport_mac(esw, vport->vport, hw_addr);
 }
 
 int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enabled,
 					struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	struct mlx5_vport *vport;
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
@@ -4278,12 +4258,6 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 		return -EOPNOTSUPP;
 	}
 
-	vport = mlx5_devlink_port_fn_get_vport(port, esw);
-	if (IS_ERR(vport)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-		return PTR_ERR(vport);
-	}
-
 	mutex_lock(&esw->state_lock);
 	*is_enabled = vport->info.mig_enabled;
 	mutex_unlock(&esw->state_lock);
@@ -4294,8 +4268,8 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 					struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	struct mlx5_vport *vport;
 	void *query_ctx;
 	void *hca_caps;
 	int err;
@@ -4310,12 +4284,6 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 		return -EOPNOTSUPP;
 	}
 
-	vport = mlx5_devlink_port_fn_get_vport(port, esw);
-	if (IS_ERR(vport)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-		return PTR_ERR(vport);
-	}
-
 	mutex_lock(&esw->state_lock);
 
 	if (vport->info.mig_enabled == enable) {
@@ -4359,19 +4327,13 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 				  struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	struct mlx5_vport *vport;
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
 		return -EOPNOTSUPP;
 	}
 
-	vport = mlx5_devlink_port_fn_get_vport(port, esw);
-	if (IS_ERR(vport)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-		return PTR_ERR(vport);
-	}
-
 	mutex_lock(&esw->state_lock);
 	*is_enabled = vport->info.roce_enabled;
 	mutex_unlock(&esw->state_lock);
@@ -4382,11 +4344,11 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 				  struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	struct mlx5_vport *vport;
+	u16 vport_num = vport->vport;
 	void *query_ctx;
 	void *hca_caps;
-	u16 vport_num;
 	int err;
 
 	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
@@ -4394,13 +4356,6 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 		return -EOPNOTSUPP;
 	}
 
-	vport = mlx5_devlink_port_fn_get_vport(port, esw);
-	if (IS_ERR(vport)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
-		return PTR_ERR(vport);
-	}
-	vport_num = vport->vport;
-
 	mutex_lock(&esw->state_lock);
 
 	if (vport->info.roce_enabled == enable) {
-- 
2.41.0


