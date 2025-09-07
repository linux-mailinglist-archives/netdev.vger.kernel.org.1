Return-Path: <netdev+bounces-220640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A24B47888
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5094D189A3E2
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC46199920;
	Sun,  7 Sep 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anz4arec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38446186284
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208618; cv=none; b=SG8x+k6u2h+GGYA9HVeL2pavLDpXkweYr3ddSxj1Cr7U4/sm7eNqQAgbUXqKylm832nJnpSv0DCl0rOUTegwUQ+x6rWKfVHp4d0+hKJqCKSMlxx6wmc5RnoLyYqkWc9VCWjtOwiT1Dv+vrqrdvvS2s56CxAHK9LZi+4/KsvDutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208618; c=relaxed/simple;
	bh=tXhVUaEldrlQK+kdz8Euo1im2+L5w+uiD2TVMN0ATa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V98MCoDT8MsuqWH7FD8U6OexKH87A3soypHI/HBxfhMMhbK5pQ0IQRERjr0n/kH0HZVDbHQe3Sbnrd+WlRMNsVOUY9W9SE48fR7JmKxLS3nsXauvuN8dgJ8m22vv3cuEtkdgNeEk/ms2gg7b2G5BGsry1aO1tbpEXyFYWqu5Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anz4arec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2367C4CEE7;
	Sun,  7 Sep 2025 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208618;
	bh=tXhVUaEldrlQK+kdz8Euo1im2+L5w+uiD2TVMN0ATa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Anz4arecB8cBqgJRKei70xrZ93K3iX259ccgHjd1ng7hZrXfpIMAseZB6Mn9JV6pE
	 33wpPwt3ygP372oII0q3ruEIXEMABOoE/NswWOYaBa5d5mfKFoggVUS6N281ugWV8k
	 aXOU092r5sNnf59Lt2n5Du0ovE4/EofnwE1IzCLLpXmOSfUznJMVuwmmog/IEFo2A3
	 d7OtGCzuukkAK+o4wLCtpbj9wk45d2qLJVUPTnS3UqNS47R+dBILqVaf1jnnzZKHJj
	 4noYaV9Yirba3atCVvsxGlu8gEec2xAj9oaLJTQORPMTNgHfY/taZWlyw0tNzANjdj
	 J9NE3k+w8YcNg==
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
	Jiri Pirko <jiri@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH V7 net-next 03/11] net/mlx5: Implement devlink enable_sriov parameter
Date: Sat,  6 Sep 2025 18:29:45 -0700
Message-ID: <20250907012953.301746-4-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907012953.301746-1-saeed@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Example usage:
  devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
  devlink dev reload pci/0000:01:00.0 action fw_activate
  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
  echo 1 >/sys/bus/pci/rescan
  grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Tested-by: Kamal Heib <kheib@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/devlink/mlx5.rst     |  14 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 199 ++++++++++++++++++
 2 files changed, 210 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 2edc842b620d..c3610f7c1d4b 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -15,23 +15,31 @@ Parameters
    * - Name
      - Mode
      - Validation
+     - Notes
    * - ``enable_roce``
      - driverinit
-     - Type: Boolean
-
-       If the device supports RoCE disablement, RoCE enablement state controls
+     - Boolean
+     - If the device supports RoCE disablement, RoCE enablement state controls
        device support for RoCE capability. Otherwise, the control occurs in the
        driver stack. When RoCE is disabled at the driver level, only raw
        ethernet QPs are supported.
    * - ``io_eq_size``
      - driverinit
      - The range is between 64 and 4096.
+     -
    * - ``event_eq_size``
      - driverinit
      - The range is between 64 and 4096.
+     -
    * - ``max_macs``
      - driverinit
      - The range is between 1 and 2^31. Only power of 2 values are supported.
+     -
+   * - ``enable_sriov``
+     - permanent
+     - Boolean
+     - Applies to each physical function (PF) independently, if the device
+       supports it. Otherwise, it applies symmetrically to all PFs.
 
 The ``mlx5`` driver also implements the following driver-specific
 parameters.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 20a39483be04..ed2129843ec7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -5,7 +5,11 @@
 #include "mlx5_core.h"
 
 enum {
+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
+
+	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
 };
 
 struct mlx5_ifc_configuration_item_type_class_global_bits {
@@ -13,9 +17,18 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
 	u8         parameter_index[0x18];
 };
 
+struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
+	u8         type_class[0x8];
+	u8         pf_index[0x6];
+	u8         pci_bus_index[0x8];
+	u8         parameter_index[0xa];
+};
+
 union mlx5_ifc_config_item_type_auto_bits {
 	struct mlx5_ifc_configuration_item_type_class_global_bits
 				configuration_item_type_class_global;
+	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
+				configuration_item_type_class_per_host_pf;
 	u8 reserved_at_0[0x20];
 };
 
@@ -45,6 +58,45 @@ struct mlx5_ifc_mnvda_reg_bits {
 	u8         configuration_item_data[64][0x20];
 };
 
+struct mlx5_ifc_nv_global_pci_conf_bits {
+	u8         sriov_valid[0x1];
+	u8         reserved_at_1[0x10];
+	u8         per_pf_total_vf[0x1];
+	u8         reserved_at_12[0xe];
+
+	u8         sriov_en[0x1];
+	u8         reserved_at_21[0xf];
+	u8         total_vfs[0x10];
+
+	u8         reserved_at_40[0x20];
+};
+
+struct mlx5_ifc_nv_global_pci_cap_bits {
+	u8         max_vfs_per_pf_valid[0x1];
+	u8         reserved_at_1[0x13];
+	u8         per_pf_total_vf_supported[0x1];
+	u8         reserved_at_15[0xb];
+
+	u8         sriov_support[0x1];
+	u8         reserved_at_21[0xf];
+	u8         max_vfs_per_pf[0x10];
+
+	u8         reserved_at_40[0x60];
+};
+
+struct mlx5_ifc_nv_pf_pci_conf_bits {
+	u8         reserved_at_0[0x9];
+	u8         pf_total_vf_en[0x1];
+	u8         reserved_at_a[0x16];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x10];
+	u8         total_vf[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_nv_sw_offload_conf_bits {
 	u8         ip_over_vxlan_port[0x10];
 	u8         tunnel_ecn_copy_offload_disable[0x1];
@@ -216,7 +268,154 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 }
 
+static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
+					      void *mnvda, size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_global_pci_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev,
+					     void *mnvda, size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_global_pci_cap);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev,
+					       void *mnvda, size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(per_host_pf, mnvda, type_class, 3);
+	MLX5_SET_CFG_ITEM_TYPE(per_host_pf, mnvda, parameter_index,
+			       MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_pf_pci_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
+					 struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	bool sriov_en = false;
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
+		ctx->val.vbool = false;
+		return 0;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	sriov_en = MLX5_GET(nv_global_pci_conf, data, sriov_en);
+	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
+		ctx->val.vbool = sriov_en;
+		return 0;
+	}
+
+	/* SRIOV is per PF */
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	ctx->val.vbool = sriov_en &&
+			 MLX5_GET(nv_pf_pci_conf, data, pf_total_vf_en);
+	return 0;
+}
+
+static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	bool per_pf_support;
+	void *cap, *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read global PCI capability");
+		return err;
+	}
+
+	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	per_pf_support = MLX5_GET(nv_global_pci_cap, cap,
+				  per_pf_total_vf_supported);
+
+	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRIOV is not supported on this device");
+		return -EOPNOTSUPP;
+	}
+
+	if (!per_pf_support) {
+		/* We don't allow global SRIOV setting on per PF devlink */
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRIOV is not per PF on this device");
+		return -EOPNOTSUPP;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	/* setup per PF sriov mode */
+	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
+	MLX5_SET(nv_global_pci_conf, data, sriov_en, 1);
+	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, 1);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to write global PCI configuration");
+		return err;
+	}
+
+	/* enable/disable sriov on this PF */
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to read per host PF configuration");
+		return err;
+	}
+	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, ctx->val.vbool);
+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
+	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_devlink_enable_sriov_get,
+			      mlx5_devlink_enable_sriov_set, NULL),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.51.0


