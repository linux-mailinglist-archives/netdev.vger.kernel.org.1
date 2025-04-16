Return-Path: <netdev+bounces-182452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19DA88C94
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E843B2FB2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CEC1DE4F3;
	Mon, 14 Apr 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKEO7cFT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3481DE4CE
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660818; cv=none; b=FgIMP2RBwW3beRttPFGlXM5lL19g9QRLjBPo6VLGx9GzQq+gR4a2VleaBbX+5LOqt0CBBerbdrdkKE/p1N1/2rQTzAE8bI7FP2yzCkaMKEPY/C1M3zX1DR86isYXT3Inhud84dd5nipym6RBCwrKgfN5ZioRqwB8cSkoOO1BVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660818; c=relaxed/simple;
	bh=t1YYcB+7Hn424ajftITWWvAUFx6Ut6nfZ+FrUYiJx1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7wRxMHhpP/sqIQOG59lhAhhfVodZ3bPnY2X+SauoluA4CqBpdKX8eFrHWUcHfudXVKubm4ZKk/+cOZGaZ2US5yLRuOjFP3Rlg5ZFGTrELxXPsh7Awgqy0I3GiqDWRK/TjN728u93jZfwXsXPXoeUCs5Oli9mrImxnUktkmf5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKEO7cFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D513DC4CEE2;
	Mon, 14 Apr 2025 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660817;
	bh=t1YYcB+7Hn424ajftITWWvAUFx6Ut6nfZ+FrUYiJx1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKEO7cFTElB7ocbqCX05VIt9fiCjE8pSqx17ovsMuNWYWIdRjn/9ifW1kCxIEjOdB
	 4j2Hq2cYUeIuug4L4+iuFTuAHSWdQ/G6ZpFxYbDdGGDkjhS7KwzgwrpqY2mwyiCNPv
	 lFMkVL6nWJmOlVhYMoa4uArszLOaossKO4uNgeI9Ed3P2r2OeChhiNF4/qyfbYYA/I
	 IZf7UqN4g7KwoxrKCeiUGRvzy8m5ePfk/YyEBGFb1C2YlWKUB4NCq4b+Nxwk3shY2y
	 IAxwVWEgon4SG8vY4dTtpguRtTVLz9FhJdwsU9QLyZ1zzxeLXpXL1wzf+S0bSI9EuG
	 +6YpuP0mm966w==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 03/14] net/mlx5: Implement cqe_compress_type via devlink params
Date: Mon, 14 Apr 2025 12:59:48 -0700
Message-ID: <20250414195959.1375031-4-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414195959.1375031-1-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Selects which algorithm should be used by the NIC in order to decide rate of
CQE compression dependeng on PCIe bus conditions.

Supported values:

1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
   but maintaining a balance between bandwidth savings and performance
2) aggressive, merges more CQEs into a single entry, achieving a higher
   compression rate and maximizing performance, particularly under high
   traffic loads.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |   9 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   8 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   1 +
 .../mellanox/mlx5/core/lib/nv_param.c         | 234 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  14 ++
 include/linux/mlx5/driver.h                   |   1 +
 7 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 7febe0aecd53..417e5cdcd35d 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -117,6 +117,15 @@ parameters.
      - driverinit
      - Control the size (in packets) of the hairpin queues.
 
+   * - ``cqe_compress_type``
+     - string
+     - permanent
+     - Configure which algorithm should be used by the NIC in order to decide
+       rate of CQE compression dependeng on PCIe bus conditions.
+
+       * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
+       * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
+
 The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
 
 Info versions
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 568bbe5f83f5..31a6406a4814 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
+		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a2cf3e79693d..ccd2ebaaeec4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -10,6 +10,7 @@
 #include "esw/qos.h"
 #include "sf/dev/dev.h"
 #include "sf/sf.h"
+#include "lib/nv_param.h"
 
 static int mlx5_devlink_flash_update(struct devlink *devlink,
 				     struct devlink_flash_update_params *params,
@@ -839,8 +840,14 @@ int mlx5_devlink_params_register(struct devlink *devlink)
 	if (err)
 		goto max_uc_list_err;
 
+	err = mlx5_nv_param_register_dl_params(devlink);
+	if (err)
+		goto nv_param_err;
+
 	return 0;
 
+nv_param_err:
+	mlx5_devlink_max_uc_list_params_unregister(devlink);
 max_uc_list_err:
 	mlx5_devlink_auxdev_params_unregister(devlink);
 auxdev_reg_err:
@@ -851,6 +858,7 @@ int mlx5_devlink_params_register(struct devlink *devlink)
 
 void mlx5_devlink_params_unregister(struct devlink *devlink)
 {
+	mlx5_nv_param_unregister_dl_params(devlink);
 	mlx5_devlink_max_uc_list_params_unregister(devlink);
 	mlx5_devlink_auxdev_params_unregister(devlink);
 	devl_params_unregister(devlink, mlx5_devlink_params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 961f75da6227..74bcdfa70361 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -22,6 +22,7 @@ enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_ESW_MULTIPORT,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE,
+	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
 };
 
 struct mlx5_trap_ctx {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
new file mode 100644
index 000000000000..5ab37a88c260
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "nv_param.h"
+#include "mlx5_core.h"
+
+enum {
+	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
+};
+
+struct mlx5_ifc_configuration_item_type_class_global_bits {
+	u8         type_class[0x8];
+	u8         parameter_index[0x18];
+};
+
+union mlx5_ifc_config_item_type_auto_bits {
+	struct mlx5_ifc_configuration_item_type_class_global_bits
+				configuration_item_type_class_global;
+	u8 reserved_at_0[0x20];
+};
+
+struct mlx5_ifc_config_item_bits {
+	u8         valid[0x2];
+	u8         priority[0x2];
+	u8         header_type[0x2];
+	u8         ovr_en[0x1];
+	u8         rd_en[0x1];
+	u8         access_mode[0x2];
+	u8         reserved_at_a[0x1];
+	u8         writer_id[0x5];
+	u8         version[0x4];
+	u8         reserved_at_14[0x2];
+	u8         host_id_valid[0x1];
+	u8         length[0x9];
+
+	union mlx5_ifc_config_item_type_auto_bits type;
+
+	u8         reserved_at_40[0x10];
+	u8         crc16[0x10];
+};
+
+struct mlx5_ifc_mnvda_reg_bits {
+	struct mlx5_ifc_config_item_bits configuration_item_header;
+
+	u8         configuration_item_data[64][0x20];
+};
+
+struct mlx5_ifc_nv_sw_offload_conf_bits {
+	u8         ip_over_vxlan_port[0x10];
+	u8         tunnel_ecn_copy_offload_disable[0x1];
+	u8         pci_atomic_mode[0x3];
+	u8         sr_enable[0x1];
+	u8         ptp_cyc2realtime[0x1];
+	u8         vector_calc_disable[0x1];
+	u8         uctx_en[0x1];
+	u8         prio_tag_required_en[0x1];
+	u8         esw_fdb_ipv4_ttl_modify_enable[0x1];
+	u8         mkey_by_name[0x1];
+	u8         ip_over_vxlan_en[0x1];
+	u8         one_qp_per_recovery[0x1];
+	u8         cqe_compression[0x3];
+	u8         tunnel_udp_entropy_proto_disable[0x1];
+	u8         reserved_at_21[0x1];
+	u8         ar_enable[0x1];
+	u8         log_max_outstanding_wqe[0x5];
+	u8         vf_migration[0x2];
+	u8         log_tx_psn_win[0x6];
+	u8         lro_log_timeout3[0x4];
+	u8         lro_log_timeout2[0x4];
+	u8         lro_log_timeout1[0x4];
+	u8         lro_log_timeout0[0x4];
+};
+
+#define MNVDA_HDR_SZ \
+	(MLX5_ST_SZ_BYTES(mnvda_reg) - MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
+
+#define MLX5_SET_CONFIG_ITEM_TYPE(_cls_name, _mnvda_ptr, _field, _val) \
+	MLX5_SET(mnvda_reg, _mnvda_ptr, \
+		 configuration_item_header.type.configuration_item_type_class_##_cls_name._field, \
+		 _val)
+
+#define MLX5_SET_CONFIG_HDR_LEN(_mnvda_ptr, _cls_name) \
+	MLX5_SET(mnvda_reg, _mnvda_ptr, configuration_item_header.length, \
+		 MLX5_ST_SZ_BYTES(_cls_name))
+
+#define MLX5_GET_CONFIG_HDR_LEN(_mnvda_ptr) \
+	MLX5_GET(mnvda_reg, _mnvda_ptr, configuration_item_header.length)
+
+static int mlx5_nv_param_read(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	u32 param_idx, type_class;
+	u32 header_len;
+	void *cls_ptr;
+	int err;
+
+	if (WARN_ON(len > MLX5_ST_SZ_BYTES(mnvda_reg)) || len < MNVDA_HDR_SZ)
+		return -EINVAL; /* A caller bug */
+
+	err = mlx5_core_access_reg(dev, mnvda, len, mnvda, len, MLX5_REG_MNVDA, 0, 0);
+	if (!err)
+		return 0;
+
+	cls_ptr = MLX5_ADDR_OF(mnvda_reg, mnvda,
+			       configuration_item_header.type.configuration_item_type_class_global);
+
+	type_class = MLX5_GET(configuration_item_type_class_global, cls_ptr, type_class);
+	param_idx = MLX5_GET(configuration_item_type_class_global, cls_ptr, parameter_index);
+	header_len = MLX5_GET_CONFIG_HDR_LEN(mnvda);
+
+	mlx5_core_warn(dev, "Failed to read mnvda reg: type_class 0x%x, param_idx 0x%x, header_len %u, err %d\n",
+		       type_class, param_idx, header_len, err);
+
+	/* Let devlink skip this one if it fails, kernel log will have the failure */
+	return -EOPNOTSUPP;
+}
+
+static int mlx5_nv_param_write(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	if (WARN_ON(len > MLX5_ST_SZ_BYTES(mnvda_reg)) || len < MNVDA_HDR_SZ)
+		return -EINVAL;
+
+	if (WARN_ON(MLX5_GET_CONFIG_HDR_LEN(mnvda) == 0))
+		return -EINVAL;
+
+	return mlx5_core_access_reg(dev, mnvda, len, mnvda, len, MLX5_REG_MNVDA, 0, 1);
+}
+
+static int
+mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
+				  MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG);
+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_sw_offload_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static const char *const
+	cqe_compress_str[] = { "balanced", "aggressive" };
+
+static int mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
+						  struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	u8 value = U8_MAX;
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_sw_offload_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	value = MLX5_GET(nv_sw_offload_conf, data, cqe_compression);
+
+	if (value >= ARRAY_SIZE(cqe_compress_str))
+		return -EOPNOTSUPP;
+
+	strscpy(ctx->val.vstr, cqe_compress_str[value], sizeof(ctx->val.vstr));
+	return 0;
+}
+
+static int
+mlx5_nv_param_devlink_cqe_compress_validate(struct devlink *devlink, u32 id,
+					    union devlink_param_value val,
+					    struct netlink_ext_ack *extack)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cqe_compress_str); i++) {
+		if (!strcmp(val.vstr, cqe_compress_str[i]))
+			return 0;
+	}
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "Invalid value, supported values are balanced/aggressive");
+	return -EOPNOTSUPP;
+}
+
+static int mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
+						  struct devlink_param_gset_ctx *ctx,
+						  struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	int err = 0;
+	void *data;
+	u8 value;
+
+	if (!strcmp(ctx->val.vstr, "aggressive"))
+		value = 1;
+	else /* balanced: can't be anything else already validated above */
+		value = 0;
+
+	err = mlx5_nv_param_read_sw_offload_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read sw_offload_conf mnvda reg");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_sw_offload_conf, data, cqe_compression, value);
+
+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+}
+
+static const struct devlink_param mlx5_nv_param_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
+			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			     mlx5_nv_param_devlink_cqe_compress_get,
+			     mlx5_nv_param_devlink_cqe_compress_set,
+			     mlx5_nv_param_devlink_cqe_compress_validate),
+};
+
+int mlx5_nv_param_register_dl_params(struct devlink *devlink)
+{
+	if (!mlx5_core_is_pf(devlink_priv(devlink)))
+		return 0;
+
+	return devl_params_register(devlink, mlx5_nv_param_devlink_params,
+				    ARRAY_SIZE(mlx5_nv_param_devlink_params));
+}
+
+void mlx5_nv_param_unregister_dl_params(struct devlink *devlink)
+{
+	if (!mlx5_core_is_pf(devlink_priv(devlink)))
+		return;
+
+	devl_params_unregister(devlink, mlx5_nv_param_devlink_params,
+			       ARRAY_SIZE(mlx5_nv_param_devlink_params));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
new file mode 100644
index 000000000000..9f4922ff7745
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_NV_PARAM_H
+#define __MLX5_NV_PARAM_H
+
+#include <linux/mlx5/driver.h>
+#include "devlink.h"
+
+int mlx5_nv_param_register_dl_params(struct devlink *devlink);
+void mlx5_nv_param_unregister_dl_params(struct devlink *devlink);
+
+#endif
+
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d1dfbad9a447..a17860c3e340 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -135,6 +135,7 @@ enum {
 	MLX5_REG_MTCAP		 = 0x9009,
 	MLX5_REG_MTMP		 = 0x900A,
 	MLX5_REG_MCIA		 = 0x9014,
+	MLX5_REG_MNVDA		 = 0x9024,
 	MLX5_REG_MFRL		 = 0x9028,
 	MLX5_REG_MLCR		 = 0x902b,
 	MLX5_REG_MRTC		 = 0x902d,
-- 
2.49.0


