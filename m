Return-Path: <netdev+bounces-30557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B23787FF2
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A171C20F28
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC917F4;
	Fri, 25 Aug 2023 06:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06205CBC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DD3C43391;
	Fri, 25 Aug 2023 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692945002;
	bh=w6gbicP90ktOcqP02j/2rjTjaLJXuB3BI+5UIAgE11o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjfSbIMZzD7dBaRhsoQ8aKNe6wzsFU6peGUfnhrVSdjUxXahvO7fTAaXqp6cqEMQN
	 EcWjhaVg4L/ycoU8l9P/EipyEqxPFYLfcjdKprvPtI3rnqQ0tFYLaYZImiZG8t0tIh
	 hnoou1pk0lmyg+tguAkRvuTPppWNwnOKGpA9A5sStTxTJ4MHnX5sWIoVV2K0HwfeU7
	 QGJfkbADKAODalMs/A23UD4pKp02z9lURbffqb2OXZgNSxq4IsCasAuTrGBRgN8n62
	 nr/6A/Daw7GHpVrXyhTZZAVt1ueIZmRapMZd/aR3PxMScO+RjHuQqVQJ86KTwUJHS7
	 QH7oLacldcQxQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>
Subject: [PATCH net-next V4 7/8] net/mlx5: Implement devlink port function cmds to control ipsec_crypto
Date: Thu, 24 Aug 2023 23:28:35 -0700
Message-ID: <20230825062836.103744-8-saeed@kernel.org>
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

From: Dima Chumak <dchumak@nvidia.com>

Implement devlink port function commands to enable / disable IPsec
crypto offloads.  This is used to control the IPsec capability of the
device.

When ipsec_crypto is enabled for a VF, it prevents adding IPsec crypto
offloads on the PF, because the two cannot be active simultaneously due
to HW constraints. Conversely, if there are any active IPsec crypto
offloads on the PF, it's not allowed to enable ipsec_crypto on a VF,
until PF IPsec offloads are cleared.

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/switchdev.rst      |  10 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   4 +
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   | 309 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   8 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |  85 +++++
 7 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
index 6e3f5ee8b0d0..de51e55dcfe3 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
@@ -190,6 +190,16 @@ explicitly enable the VF migratable capability.
 mlx5 driver support devlink port function attr mechanism to setup migratable
 capability. (refer to Documentation/networking/devlink/devlink-port.rst)
 
+IPsec crypto capability setup
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+User who wants mlx5 PCI VFs to be able to perform IPsec crypto offloading need
+to explicitly enable the VF ipsec_crypto capability. Enabling IPsec capability
+for VFs is supported starting with ConnectX6dx devices and above. When a VF has
+IPsec capability enabled, any IPsec offloading is blocked on the PF.
+
+mlx5 driver support devlink port function attr mechanism to setup ipsec_crypto
+capability. (refer to Documentation/networking/devlink/devlink-port.rst)
+
 SF state setup
 --------------
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index b56b187a9097..7e94caca4888 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -69,7 +69,7 @@ mlx5_core-$(CONFIG_MLX5_TC_SAMPLE)   += en/tc/sample.o
 #
 mlx5_core-$(CONFIG_MLX5_ESWITCH)   += eswitch.o eswitch_offloads.o eswitch_offloads_termtbl.o \
 				      ecpf.o rdma.o esw/legacy.o \
-				      esw/devlink_port.o esw/vporttbl.o esw/qos.o
+				      esw/devlink_port.o esw/vporttbl.o esw/qos.o esw/ipsec.o
 
 mlx5_core-$(CONFIG_MLX5_ESWITCH)   += esw/acl/helper.o \
 				      esw/acl/egress_lgcy.o esw/acl/egress_ofld.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 3c254a710006..12205e913417 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -92,6 +92,10 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_roce_set = mlx5_devlink_port_fn_roce_set,
 	.port_fn_migratable_get = mlx5_devlink_port_fn_migratable_get,
 	.port_fn_migratable_set = mlx5_devlink_port_fn_migratable_set,
+#ifdef CONFIG_XFRM_OFFLOAD
+	.port_fn_ipsec_crypto_get = mlx5_devlink_port_fn_ipsec_crypto_get,
+	.port_fn_ipsec_crypto_set = mlx5_devlink_port_fn_ipsec_crypto_set,
+#endif /* CONFIG_XFRM_OFFLOAD */
 };
 
 static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
new file mode 100644
index 000000000000..187fb5f2d0cb
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/vport.h>
+#include "mlx5_core.h"
+#include "eswitch.h"
+
+static int esw_ipsec_vf_query_generic(struct mlx5_core_dev *dev, u16 vport_num, bool *result)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *hca_cap, *query_cap;
+	int err;
+
+	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
+		return -EOPNOTSUPP;
+
+	if (!mlx5_esw_ipsec_vf_offload_supported(dev)) {
+		*result = false;
+		return 0;
+	}
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	if (!query_cap)
+		return -ENOMEM;
+
+	err = mlx5_vport_get_other_func_general_cap(dev, vport_num, query_cap);
+	if (err)
+		goto free;
+
+	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	*result = MLX5_GET(cmd_hca_cap, hca_cap, ipsec_offload);
+free:
+	kvfree(query_cap);
+	return err;
+}
+
+enum esw_vport_ipsec_offload {
+	MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD,
+};
+
+int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev, struct mlx5_vport *vport)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *hca_cap, *query_cap;
+	bool ipsec_enabled;
+	int err;
+
+	/* Querying IPsec caps only makes sense when generic ipsec_offload
+	 * HCA cap is enabled
+	 */
+	err = esw_ipsec_vf_query_generic(dev, vport->vport, &ipsec_enabled);
+	if (err)
+		return err;
+
+	if (!ipsec_enabled) {
+		vport->info.ipsec_crypto_enabled = false;
+		return 0;
+	}
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	if (!query_cap)
+		return -ENOMEM;
+
+	err = mlx5_vport_get_other_func_cap(dev, vport->vport, query_cap, MLX5_CAP_IPSEC);
+	if (err)
+		goto free;
+
+	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	vport->info.ipsec_crypto_enabled =
+		MLX5_GET(ipsec_cap, hca_cap, ipsec_crypto_offload);
+free:
+	kvfree(query_cap);
+	return err;
+}
+
+static int esw_ipsec_vf_set_generic(struct mlx5_core_dev *dev, u16 vport_num, bool ipsec_ofld)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
+	void *hca_cap, *query_cap, *cap;
+	int ret;
+
+	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
+		return -EOPNOTSUPP;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
+	if (!hca_cap || !query_cap) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	ret = mlx5_vport_get_other_func_general_cap(dev, vport_num, query_cap);
+	if (ret)
+		goto free;
+
+	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
+	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
+	       MLX5_UN_SZ_BYTES(hca_cap_union));
+	MLX5_SET(cmd_hca_cap, cap, ipsec_offload, ipsec_ofld);
+
+	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
+	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
+	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport_num);
+
+	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
+		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1);
+	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+free:
+	kvfree(hca_cap);
+	kvfree(query_cap);
+	return ret;
+}
+
+static int esw_ipsec_vf_set_bytype(struct mlx5_core_dev *dev, struct mlx5_vport *vport,
+				   bool enable, enum esw_vport_ipsec_offload type)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
+	void *hca_cap, *query_cap, *cap;
+	int ret;
+
+	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
+		return -EOPNOTSUPP;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
+	if (!hca_cap || !query_cap) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	ret = mlx5_vport_get_other_func_cap(dev, vport->vport, query_cap, MLX5_CAP_IPSEC);
+	if (ret)
+		goto free;
+
+	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
+	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
+	       MLX5_UN_SZ_BYTES(hca_cap_union));
+
+	switch (type) {
+	case MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD:
+		MLX5_SET(ipsec_cap, cap, ipsec_crypto_offload, enable);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto free;
+	}
+
+	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
+	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
+	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport->vport);
+
+	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
+		 MLX5_SET_HCA_CAP_OP_MOD_IPSEC << 1);
+	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+free:
+	kvfree(hca_cap);
+	kvfree(query_cap);
+	return ret;
+}
+
+static int esw_ipsec_vf_crypto_aux_caps_set(struct mlx5_core_dev *dev, u16 vport_num, bool enable)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	void *hca_cap, *query_cap, *cap;
+	int ret;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
+	if (!hca_cap || !query_cap) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	ret = mlx5_vport_get_other_func_cap(dev, vport_num, query_cap, MLX5_CAP_ETHERNET_OFFLOADS);
+	if (ret)
+		goto free;
+
+	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
+	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
+	       MLX5_UN_SZ_BYTES(hca_cap_union));
+	MLX5_SET(per_protocol_networking_offload_caps, cap, insert_trailer, enable);
+	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
+	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
+	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport_num);
+	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
+		 MLX5_SET_HCA_CAP_OP_MOD_ETHERNET_OFFLOADS << 1);
+	ret = mlx5_cmd_exec_in(esw->dev, set_hca_cap, hca_cap);
+free:
+	kvfree(hca_cap);
+	kvfree(query_cap);
+	return ret;
+}
+
+static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+					   bool enable, enum esw_vport_ipsec_offload type)
+{
+	struct mlx5_core_dev *dev = esw->dev;
+	int err;
+
+	if (vport->vport == MLX5_VPORT_PF)
+		return -EOPNOTSUPP;
+
+	if (type == MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD) {
+		err = esw_ipsec_vf_crypto_aux_caps_set(dev, vport->vport, enable);
+		if (err)
+			return err;
+	}
+
+	if (enable) {
+		err = esw_ipsec_vf_set_generic(dev, vport->vport, enable);
+		if (err)
+			return err;
+		err = esw_ipsec_vf_set_bytype(dev, vport, enable, type);
+		if (err)
+			return err;
+	} else {
+		err = esw_ipsec_vf_set_bytype(dev, vport, enable, type);
+		if (err)
+			return err;
+		err = esw_ipsec_vf_set_generic(dev, vport->vport, enable);
+		if (err)
+			return err;
+	}
+
+	switch (type) {
+	case MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD:
+		vport->info.ipsec_crypto_enabled = enable;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int esw_ipsec_offload_supported(struct mlx5_core_dev *dev, u16 vport_num)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *hca_cap, *query_cap;
+	int ret;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	if (!query_cap)
+		return -ENOMEM;
+
+	ret = mlx5_vport_get_other_func_cap(dev, vport_num, query_cap, MLX5_CAP_GENERAL);
+	if (ret)
+		goto free;
+
+	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	if (!MLX5_GET(cmd_hca_cap, hca_cap, log_max_dek))
+		ret = -EOPNOTSUPP;
+free:
+	kvfree(query_cap);
+	return ret;
+}
+
+bool mlx5_esw_ipsec_vf_offload_supported(struct mlx5_core_dev *dev)
+{
+	/* Old firmware doesn't support ipsec_offload capability for VFs. This
+	 * can be detected by checking reformat_add_esp_trasport capability -
+	 * when this cap isn't supported it means firmware cannot be trusted
+	 * about what it reports for ipsec_offload cap.
+	 */
+	return MLX5_CAP_FLOWTABLE_NIC_TX(dev, reformat_add_esp_trasport);
+}
+
+int mlx5_esw_ipsec_vf_crypto_offload_supported(struct mlx5_core_dev *dev,
+					       u16 vport_num)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *hca_cap, *query_cap;
+	int err;
+
+	if (!mlx5_esw_ipsec_vf_offload_supported(dev))
+		return -EOPNOTSUPP;
+
+	err = esw_ipsec_offload_supported(dev, vport_num);
+	if (err)
+		return err;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	if (!query_cap)
+		return -ENOMEM;
+
+	err = mlx5_vport_get_other_func_cap(dev, vport_num, query_cap, MLX5_CAP_ETHERNET_OFFLOADS);
+	if (err)
+		goto free;
+
+	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	if (!MLX5_GET(per_protocol_networking_offload_caps, hca_cap, swp))
+		goto free;
+
+free:
+	kvfree(query_cap);
+	return err;
+}
+
+int mlx5_esw_ipsec_vf_crypto_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+					 bool enable)
+{
+	return esw_ipsec_vf_offload_set_bytype(esw, vport, enable,
+					       MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 38a149dd479f..79ae6ad94f55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -832,6 +832,9 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	vport->info.mig_enabled = MLX5_GET(cmd_hca_cap_2, hca_caps, migratable);
+
+	err = mlx5_esw_ipsec_vf_offload_get(esw->dev, vport);
+
 out_free:
 	kfree(query_ctx);
 	return err;
@@ -914,6 +917,8 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 	/* Sync with current vport context */
 	vport->enabled_events = enabled_events;
 	vport->enabled = true;
+	if (vport->vport != MLX5_VPORT_PF && vport->info.ipsec_crypto_enabled)
+		esw->enabled_ipsec_vf_count++;
 
 	/* Esw manager is trusted by default. Host PF (vport 0) is trusted as well
 	 * in smartNIC as it's a vport group manager.
@@ -970,6 +975,9 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
 		mlx5_esw_vport_vhca_id_clear(esw, vport_num);
 
+	if (vport->vport != MLX5_VPORT_PF && vport->info.ipsec_crypto_enabled)
+		esw->enabled_ipsec_vf_count--;
+
 	/* We don't assume VFs will cleanup after themselves.
 	 * Calling vport change handler while vport is disabled will cleanup
 	 * the vport resources.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 0e51fd066fcc..cde5712aa697 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -163,6 +163,7 @@ struct mlx5_vport_info {
 	u8                      trusted: 1;
 	u8                      roce_enabled: 1;
 	u8                      mig_enabled: 1;
+	u8                      ipsec_crypto_enabled: 1;
 };
 
 /* Vport context events */
@@ -559,6 +560,12 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 					struct netlink_ext_ack *extack);
+#ifdef CONFIG_XFRM_OFFLOAD
+int mlx5_devlink_port_fn_ipsec_crypto_get(struct devlink_port *port, bool *is_enabled,
+					  struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable,
+					  struct netlink_ext_ack *extack);
+#endif /* CONFIG_XFRM_OFFLOAD */
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
 int __mlx5_eswitch_set_vport_vlan(struct mlx5_eswitch *esw,
@@ -858,6 +865,13 @@ int mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_h
 				    struct mlx5_esw_flow_attr *esw_attr, int attr_idx);
 bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev);
+bool mlx5_esw_ipsec_vf_offload_supported(struct mlx5_core_dev *dev);
+int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev,
+				  struct mlx5_vport *vport);
+int mlx5_esw_ipsec_vf_crypto_offload_supported(struct mlx5_core_dev *dev,
+					       u16 vport_num);
+int mlx5_esw_ipsec_vf_crypto_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+					 bool enable);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d4697dadd27d..f37d30a096c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4367,3 +4367,88 @@ mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_handl
 
 	return mlx5_modify_rule_destination(rule, &new_dest, &old_dest);
 }
+
+#ifdef CONFIG_XFRM_OFFLOAD
+int mlx5_devlink_port_fn_ipsec_crypto_get(struct devlink_port *port, bool *is_enabled,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	struct mlx5_vport *vport;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(port->devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	if (!mlx5_esw_ipsec_vf_offload_supported(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPSec crypto");
+		return -EOPNOTSUPP;
+	}
+
+	vport = mlx5_devlink_port_vport_get(port);
+
+	mutex_lock(&esw->state_lock);
+	if (!vport->enabled) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	*is_enabled = vport->info.ipsec_crypto_enabled;
+unlock:
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
+
+int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	struct mlx5_vport *vport;
+	u16 vport_num;
+	int err;
+
+	esw = mlx5_devlink_eswitch_get(port->devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
+	err = mlx5_esw_ipsec_vf_crypto_offload_supported(esw->dev, vport_num);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support IPsec crypto");
+		return err;
+	}
+
+	vport = mlx5_devlink_port_vport_get(port);
+
+	mutex_lock(&esw->state_lock);
+	if (!vport->enabled) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
+		goto unlock;
+	}
+
+	if (vport->info.ipsec_crypto_enabled == enable)
+		goto unlock;
+
+	if (!esw->enabled_ipsec_vf_count && esw->dev->num_ipsec_offloads) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	err = mlx5_esw_ipsec_vf_crypto_offload_set(esw, vport, enable);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set IPsec crypto");
+		goto unlock;
+	}
+
+	vport->info.ipsec_crypto_enabled = enable;
+	if (enable)
+		esw->enabled_ipsec_vf_count++;
+	else
+		esw->enabled_ipsec_vf_count--;
+unlock:
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
+#endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.41.0


