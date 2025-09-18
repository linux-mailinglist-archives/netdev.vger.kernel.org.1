Return-Path: <netdev+bounces-215831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2792B308BC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033535C8530
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC662EAB84;
	Thu, 21 Aug 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Lw8TTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589402EAB7B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813535; cv=none; b=nQbb00lIblUeVI3uEMVRcLQzFynpTj2iIYzy4IKJObpH0VePcu49gSzydKAJycY/yjhe32W3rbnWGClW6qNBESWEbLjxnQMnuNEglwtwwTYa2nIiMD5No2CvFL/xqA48oR16zdzmUec9FJWZ3rftMQ4QPG+EJbCe1oiPOvcyrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813535; c=relaxed/simple;
	bh=dVaz3M1+R7/rXVioBOMFiqA2npz/ezxXKhnK7MTzxTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghdhYk950SIwELW29Y8rybzCJ61NGf/171JCSROzUEgvSW2tyZyz7BWTxthgQEHP00l1p1c1BpSQbQUiGD1vCKt6OfaCh+pzrx+6WyVKzkzQEdO8RqhbVhHiIK0jVkq8ccyxYFVD2tk/Bir2PP+8vPlBejqnnQ8Qn17hlti6i84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Lw8TTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA62BC113D0;
	Thu, 21 Aug 2025 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813534;
	bh=dVaz3M1+R7/rXVioBOMFiqA2npz/ezxXKhnK7MTzxTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+Lw8TTsa/c1DTcC9UJdcfDpDUQaqfXeWA4BylKFd9YAQVUE81KrItv+RSUn/1YAy
	 hCXFHoRsThu8s5xdfP683hkDNeOFuuDMBB1ZryTyiV9lxDRalL9sgeU2NE3BWfF4YM
	 04mu0rytv6xiVecHsuEHopsvlkxbHlH4lcwUorilS4UP54S0TU8lGvgdVPrtHrQWQ2
	 T8PnTJJekJyF4wP2wyLJQSbN5RaLlvqSrhmzeVRzJKqQ3LSXsYr73tjyGDd7F/Zyqp
	 PLdCpgLuaG0DyMg6gGTtCAPumKVuSVMilTJbn07m9rqPt9IcbHeM87g5Gh4dhtPoUL
	 Ze82JHT6F09Zw==
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
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 3/7] net/mlx5: E-Switch, Add support for adjacent functions vports discovery
Date: Thu, 21 Aug 2025 14:58:35 -0700
Message-ID: <20250821215839.280364-4-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821215839.280364-1-saeed@kernel.org>
References: <20250821215839.280364-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adithya Jayachandran <ajayachandra@nvidia.com>

Adding driver support to query adjacent functions vports, AKA
delegated vports.

Adjacent functions can delegate their sriov vfs to other sibling PF in
the system, to be managed by the eswitch capable sibling PF.
E.g, ECPF to Host PF, multi host PF between each other, etc.

Only supported in switchdev mode.

Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/esw/adj_vport.c        | 185 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  58 +++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   7 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |   4 +
 5 files changed, 251 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index a253c73db9e5..36ef2a47e757 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -69,7 +69,7 @@ mlx5_core-$(CONFIG_MLX5_TC_SAMPLE)   += en/tc/sample.o
 # Core extra
 #
 mlx5_core-$(CONFIG_MLX5_ESWITCH)   += eswitch.o eswitch_offloads.o eswitch_offloads_termtbl.o \
-				      ecpf.o rdma.o esw/legacy.o \
+				      ecpf.o rdma.o esw/legacy.o esw/adj_vport.o \
 				      esw/devlink_port.o esw/vporttbl.o esw/qos.o esw/ipsec.o
 
 mlx5_core-$(CONFIG_MLX5_ESWITCH)   += esw/acl/helper.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
new file mode 100644
index 000000000000..0bb7f77cce1f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include "eswitch.h"
+
+enum {
+	MLX5_ADJ_VPORT_DISCONNECT = 0x0,
+	MLX5_ADJ_VPORT_CONNECT = 0x1,
+};
+
+static int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev,
+				     u16 vport, bool connect)
+{
+	u32 in[MLX5_ST_SZ_DW(modify_vport_state_in)] = {};
+
+	MLX5_SET(modify_vport_state_in, in, opcode,
+		 MLX5_CMD_OP_MODIFY_VPORT_STATE);
+	MLX5_SET(modify_vport_state_in, in, op_mod,
+		 MLX5_VPORT_STATE_OP_MOD_ESW_VPORT);
+	MLX5_SET(modify_vport_state_in, in, other_vport, 1);
+	MLX5_SET(modify_vport_state_in, in, vport_number, vport);
+	MLX5_SET(modify_vport_state_in, in, ingress_connect_valid, 1);
+	MLX5_SET(modify_vport_state_in, in, egress_connect_valid, 1);
+	MLX5_SET(modify_vport_state_in, in, ingress_connect, connect);
+	MLX5_SET(modify_vport_state_in, in, egress_connect, connect);
+
+	return mlx5_cmd_exec_in(dev, modify_vport_state, in);
+}
+
+static void mlx5_esw_destroy_esw_vport(struct mlx5_core_dev *dev, u16 vport)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_esw_vport_in)] = {};
+
+	MLX5_SET(destroy_esw_vport_in, in, opcode,
+		 MLX5_CMD_OPCODE_DESTROY_ESW_VPORT);
+	MLX5_SET(destroy_esw_vport_in, in, vport_num, vport);
+
+	mlx5_cmd_exec_in(dev, destroy_esw_vport, in);
+}
+
+static int mlx5_esw_create_esw_vport(struct mlx5_core_dev *dev, u16 vhca_id,
+				     u16 *vport_num)
+{
+	u32 out[MLX5_ST_SZ_DW(create_esw_vport_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_esw_vport_in)] = {};
+	int err;
+
+	MLX5_SET(create_esw_vport_in, in, opcode,
+		 MLX5_CMD_OPCODE_CREATE_ESW_VPORT);
+	MLX5_SET(create_esw_vport_in, in, managed_vhca_id, vhca_id);
+
+	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (!err)
+		*vport_num = MLX5_GET(create_esw_vport_out, out, vport_num);
+
+	return err;
+}
+
+static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
+{
+	struct mlx5_vport *vport;
+	u16 vport_num;
+	int err;
+
+	err = mlx5_esw_create_esw_vport(esw->dev, vhca_id, &vport_num);
+	if (err) {
+		esw_warn(esw->dev,
+			 "Failed to create adjacent vport for vhca_id %d, err %d\n",
+			 vhca_id, err);
+		return err;
+	}
+
+	esw_debug(esw->dev, "Created adjacent vport[%d] %d for vhca_id 0x%x\n",
+		  esw->last_vport_idx, vport_num, vhca_id);
+
+	err = mlx5_esw_vport_alloc(esw, esw->last_vport_idx++, vport_num);
+	if (err)
+		goto err_destroy;
+
+	xa_set_mark(&esw->vports, vport_num, MLX5_ESW_VPT_VF);
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	vport->adjacent = true;
+	vport->vhca_id = vhca_id;
+
+	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
+	return 0;
+
+err_destroy:
+	mlx5_esw_destroy_esw_vport(esw->dev, vport_num);
+	return err;
+}
+
+static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
+				       struct mlx5_vport *vport)
+{
+	u16 vport_num = vport->vport;
+
+	esw_debug(esw->dev, "Destroying adjacent vport %d for vhca_id 0x%x\n",
+		  vport_num, vport->vhca_id);
+	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
+				  MLX5_ADJ_VPORT_DISCONNECT);
+	mlx5_esw_vport_free(esw, vport);
+	/* Reset the vport index back so new adj vports can use this index.
+	 * When vport count can incrementally change, this needs to be modified.
+	 */
+	esw->last_vport_idx--;
+	mlx5_esw_destroy_esw_vport(esw->dev, vport_num);
+}
+
+void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	if (!MLX5_CAP_GEN_2(esw->dev, delegated_vhca_max))
+		return;
+
+	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
+		if (!vport->adjacent)
+			continue;
+		mlx5_esw_adj_vport_destroy(esw, vport);
+	}
+}
+
+void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw)
+{
+	u32 delegated_vhca_max = MLX5_CAP_GEN_2(esw->dev, delegated_vhca_max);
+	u32 in[MLX5_ST_SZ_DW(query_delegated_vhca_in)] = {};
+	int outlen, err, i = 0;
+	u8 *out;
+	u32 count;
+
+	if (!delegated_vhca_max)
+		return;
+
+	outlen = MLX5_ST_SZ_BYTES(query_delegated_vhca_out) +
+		 delegated_vhca_max *
+		 MLX5_ST_SZ_BYTES(delegated_function_vhca_rid_info);
+
+	esw_debug(esw->dev, "delegated_vhca_max=%d\n", delegated_vhca_max);
+
+	out = kvzalloc(outlen, GFP_KERNEL);
+	if (!out)
+		return;
+
+	MLX5_SET(query_delegated_vhca_in, in, opcode,
+		 MLX5_CMD_OPCODE_QUERY_DELEGATED_VHCA);
+
+	err = mlx5_cmd_exec(esw->dev, in, sizeof(in), out, outlen);
+	if (err) {
+		kvfree(out);
+		esw_warn(esw->dev, "Failed to query delegated vhca, err %d\n",
+			 err);
+		return;
+	}
+
+	count = MLX5_GET(query_delegated_vhca_out, out, functions_count);
+	esw_debug(esw->dev, "Delegated vhca functions count %d\n", count);
+
+	for (i = 0; i < count; i++) {
+		void *rid_info, *rid_info_reg;
+		u16 vhca_id;
+
+		rid_info = MLX5_ADDR_OF(query_delegated_vhca_out, out,
+					delegated_function_vhca_rid_info[i]);
+
+		rid_info_reg = MLX5_ADDR_OF(delegated_function_vhca_rid_info,
+					    rid_info, function_vhca_rid_info);
+
+		vhca_id = MLX5_GET(function_vhca_rid_info_reg, rid_info_reg,
+				   vhca_id);
+		esw_debug(esw->dev, "Delegating vhca_id 0x%x rid info:\n",
+			  vhca_id);
+
+		err = mlx5_esw_adj_vport_create(esw, vhca_id);
+		if (err) {
+			esw_warn(esw->dev,
+				 "Failed to init adjacent vhca 0x%x, err %d\n",
+				 vhca_id, err);
+			break;
+		}
+	}
+
+	kvfree(out);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index a8bc7a5a5dbf..0f562abf9235 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1217,7 +1217,8 @@ void mlx5_eswitch_unload_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs)
 	unsigned long i;
 
 	mlx5_esw_for_each_vf_vport(esw, i, vport, num_vfs) {
-		if (!vport->enabled)
+		/* Adjacent VFs are unloaded separately */
+		if (!vport->enabled || vport->adjacent)
 			continue;
 		mlx5_eswitch_unload_pf_vf_vport(esw, vport->vport);
 	}
@@ -1236,6 +1237,42 @@ static void mlx5_eswitch_unload_ec_vf_vports(struct mlx5_eswitch *esw,
 	}
 }
 
+static void mlx5_eswitch_unload_adj_vf_vports(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
+		if (!vport->enabled || !vport->adjacent)
+			continue;
+		mlx5_eswitch_unload_pf_vf_vport(esw, vport->vport);
+	}
+}
+
+static int
+mlx5_eswitch_load_adj_vf_vports(struct mlx5_eswitch *esw,
+				enum mlx5_eswitch_vport_event enabled_events)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+	int err;
+
+	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
+		if (!vport->adjacent)
+			continue;
+		err = mlx5_eswitch_load_pf_vf_vport(esw, vport->vport,
+						    enabled_events);
+		if (err)
+			goto adj_vf_err;
+	}
+
+	return 0;
+
+adj_vf_err:
+	mlx5_eswitch_unload_adj_vf_vports(esw);
+	return err;
+}
+
 int mlx5_eswitch_load_vf_vports(struct mlx5_eswitch *esw, u16 num_vfs,
 				enum mlx5_eswitch_vport_event enabled_events)
 {
@@ -1345,7 +1382,15 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 					  enabled_events);
 	if (ret)
 		goto vf_err;
+
+	/* Enable adjacent VF vports */
+	ret = mlx5_eswitch_load_adj_vf_vports(esw, enabled_events);
+	if (ret)
+		goto adj_vf_err;
+
 	return 0;
+adj_vf_err:
+	mlx5_eswitch_unload_adj_vf_vports(esw);
 
 vf_err:
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
@@ -1367,6 +1412,8 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
  */
 void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 {
+	mlx5_eswitch_unload_adj_vf_vports(esw);
+
 	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
@@ -1791,8 +1838,7 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *
 	return err;
 }
 
-static int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw,
-				int index, u16 vport_num)
+int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw, int index, u16 vport_num)
 {
 	struct mlx5_vport *vport;
 	int err;
@@ -1819,8 +1865,9 @@ static int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw,
 	return err;
 }
 
-static void mlx5_esw_vport_free(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
+void mlx5_esw_vport_free(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
+	esw->total_vports--;
 	xa_erase(&esw->vports, vport->vport);
 	kfree(vport);
 }
@@ -1904,6 +1951,9 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 	err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_UPLINK);
 	if (err)
 		goto err;
+
+	/* Adjacent vports or other dynamically create vports will use this */
+	esw->last_vport_idx = ++idx;
 	return 0;
 
 err:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index cfd6b1b8c6f4..9f8bb397eae5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -216,6 +216,7 @@ struct mlx5_vport {
 	u32                     metadata;
 	int                     vhca_id;
 
+	bool adjacent; /* delegated vhca from adjacent function */
 	struct mlx5_vport_info  info;
 
 	/* Protected with the E-Switch qos domain lock. The Vport QoS can
@@ -384,6 +385,7 @@ struct mlx5_eswitch {
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
 	struct mlx5_esw_offload offloads;
+	u32 last_vport_idx; /* ++ every time a vport is created */
 	int                     mode;
 	u16                     manager_vport;
 	u16                     first_host_vport;
@@ -417,6 +419,8 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 /* E-Switch API */
 int mlx5_eswitch_init(struct mlx5_core_dev *dev);
 void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw);
+int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw, int index, u16 vport_num);
+void mlx5_esw_vport_free(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
 #define MLX5_ESWITCH_IGNORE_NUM_VFS (-1)
 int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs);
@@ -622,6 +626,9 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
 
+void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw);
+void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw);
+
 #define MLX5_DEBUG_ESWITCH_MASK BIT(3)
 
 #define esw_info(__dev, format, ...)			\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index cdba7bc448ee..fb03981d5036 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3538,6 +3538,8 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
+	mlx5_esw_adjacent_vhcas_setup(esw);
+
 	err = mlx5_rdma_enable_roce(esw->dev);
 	if (err)
 		goto err_roce;
@@ -3602,6 +3604,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 err_metadata:
 	mlx5_rdma_disable_roce(esw->dev);
 err_roce:
+	mlx5_esw_adjacent_vhcas_cleanup(esw);
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
@@ -3635,6 +3638,7 @@ void esw_offloads_disable(struct mlx5_eswitch *esw)
 	mapping_destroy(esw->offloads.reg_c0_obj_pool);
 	esw_offloads_metadata_uninit(esw);
 	mlx5_rdma_disable_roce(esw->dev);
+	mlx5_esw_adjacent_vhcas_cleanup(esw);
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 }
 
-- 
2.50.1


