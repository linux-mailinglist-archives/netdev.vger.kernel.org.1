Return-Path: <netdev+bounces-170513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA8A48E66
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DD1188F4ED
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC019341F;
	Fri, 28 Feb 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQyqTM0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D306192D7E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708814; cv=none; b=ciPtKLaGJleBmijxUwxZl743qVwecLxPd+59eEWsnoI4o5td8exTwLd1Gnl0cqrQeLqaZy+1Tw/uFNrhgA7ubpGcHC3LM68/IoQmo0Kgm4lMHqevEiDtMeUABmhpCoMeof1E/8dxNkgz2wOm5p7v6YGg72eOYwUNHgu8bxwZ0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708814; c=relaxed/simple;
	bh=Vkt3AS5V5jd83iIHDbVVN3o8rlLWc0nnnSPDuSMZznE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIQCc8xkJwTAqvYxJGoYT+GTttKNFhSdFsOS7WrCoa1dCg+hRX0kpRXkgXcnlHnObY7SSH8V5f7rgkK6CNUNnW0gneP5BTlo+qYhGgTboJDASCUk8dv08wEzzoPNYiI0qz7IqBr2iOSYC1gKQlTXXJ4klwyjTI5sc020ZPjED+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQyqTM0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05074C4CEE8;
	Fri, 28 Feb 2025 02:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708814;
	bh=Vkt3AS5V5jd83iIHDbVVN3o8rlLWc0nnnSPDuSMZznE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQyqTM0Jr8izdXAL7KAz+H8+rhz+qmo8+/ZUsrxN7vv3wdY8sQi4n1vcRgWU0K929
	 4rbiUmcWl9KIdOf3ockgGfpAcJkydq0bwtWGaWlDVlK3TCPiat/nz0nP4AmjtMgeSi
	 7dgZlGXEqDqUWm5cS8XPPsj2s6+TZpMGR0gljKh2K9kqEJyBpTyHwlmV7KktFl0Zq+
	 DqAOhycpL29gJZ/cXWFpJ8igizsBhG3H1K6RZBalik0MnMCmjNlefDc0KILdb1nNwq
	 2e0O8aOI+FPORFrh7W1ZFLBB5EmIs3oLNSbdtYTPsWyKedkk+gx8OJNejTT9cbjHXg
	 /+c4gyb7aQVRA==
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
Subject: [PATCH net-next 11/14] net/mlx5: Implement devlink keep_link_up port parameter
Date: Thu, 27 Feb 2025 18:12:24 -0800
Message-ID: <20250228021227.871993-12-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021227.871993-1-saeed@kernel.org>
References: <20250228021227.871993-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

When set, the NIC keeps the link up as long as the host is not in standby
mode, even when the driver is not loaded.

When enabled, netdev carrier state won't affect the physical port link state.

This is useful for when the link is needed to access onboard management
such as BMC, even if the host driver isn't loaded.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |   5 +
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |  16 ++-
 .../ethernet/mellanox/mlx5/core/en/devlink.h  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 129 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |   2 +
 6 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 00a43324dec2..c9c064de4699 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -45,6 +45,11 @@ Parameters
      - The range is between 1 and a device-specific max.
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``keep_link_up``
+     - permanent
+     - Boolean
+     - When set, the NIC keeps the link up as long as the host is not in standby
+       mode, even when the driver is not loaded.
 
 Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
index 0b1ac6e5c890..e9d073d1f532 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
@@ -3,6 +3,7 @@
 
 #include "en/devlink.h"
 #include "eswitch.h"
+#include "lib/nv_param.h"
 
 static const struct devlink_ops mlx5e_devlink_ops = {
 };
@@ -54,6 +55,7 @@ int mlx5e_devlink_port_register(struct mlx5e_dev *mlx5e_dev,
 	struct devlink_port_attrs attrs = {};
 	struct netdev_phys_item_id ppid = {};
 	unsigned int dl_port_index;
+	int err;
 
 	if (mlx5_core_is_pf(mdev)) {
 		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
@@ -72,11 +74,19 @@ int mlx5e_devlink_port_register(struct mlx5e_dev *mlx5e_dev,
 
 	devlink_port_attrs_set(&mlx5e_dev->dl_port, &attrs);
 
-	return devlink_port_register(devlink, &mlx5e_dev->dl_port,
-				     dl_port_index);
+	err = devlink_port_register(devlink, &mlx5e_dev->dl_port,
+				    dl_port_index);
+	if (err)
+		return err;
+
+	err = mlx5_nv_port_param_register(mdev, &mlx5e_dev->dl_port);
+	if (err)
+		mlx5_core_warn(mdev, "Failed to register eth port params\n");
+	return 0;
 }
 
-void mlx5e_devlink_port_unregister(struct mlx5e_dev *mlx5e_dev)
+void mlx5e_devlink_port_unregister(struct mlx5e_dev *mlx5e_dev, struct mlx5_core_dev *mdev)
 {
+	mlx5_nv_port_param_unregister(mdev, &mlx5e_dev->dl_port);
 	devlink_port_unregister(&mlx5e_dev->dl_port);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.h
index d5ec4461f300..049d82732f72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.h
@@ -12,6 +12,7 @@ struct mlx5e_dev *mlx5e_create_devlink(struct device *dev,
 void mlx5e_destroy_devlink(struct mlx5e_dev *mlx5e_dev);
 int mlx5e_devlink_port_register(struct mlx5e_dev *mlx5e_dev,
 				struct mlx5_core_dev *mdev);
-void mlx5e_devlink_port_unregister(struct mlx5e_dev *mlx5e_dev);
+void mlx5e_devlink_port_unregister(struct mlx5e_dev *mlx5e_dev,
+				   struct mlx5_core_dev *mdev);
 
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5d5e7b19c396..e7828203e29b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6484,7 +6484,7 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 err_destroy_netdev:
 	mlx5e_destroy_netdev(priv);
 err_devlink_port_unregister:
-	mlx5e_devlink_port_unregister(mlx5e_dev);
+	mlx5e_devlink_port_unregister(mlx5e_dev, mdev);
 err_devlink_unregister:
 	mlx5e_destroy_devlink(mlx5e_dev);
 	return err;
@@ -6538,7 +6538,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	if (priv->profile)
 		priv->profile->cleanup(priv);
 	mlx5e_destroy_netdev(priv);
-	mlx5e_devlink_port_unregister(mlx5e_dev);
+	mlx5e_devlink_port_unregister(mlx5e_dev, mdev);
 	mlx5e_destroy_devlink(mlx5e_dev);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 97d74d890582..159d75967a48 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -3,12 +3,15 @@
 
 #include "nv_param.h"
 #include "mlx5_core.h"
+#include "en.h"
 
 enum {
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
 
+	MLX5_CLASS_1_CTRL_ID_NV_KEEP_LINK_UP                  = 0x190,
+
 	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
 };
 
@@ -17,6 +20,12 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
 	u8         parameter_index[0x18];
 };
 
+struct mlx5_ifc_configuration_item_type_class_physical_port_bits {
+	u8    type_class[0x8];
+	u8    port[0x8];
+	u8    parameter_index[0x10];
+};
+
 struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
 	u8         type_class[0x8];
 	u8         pf_index[0x6];
@@ -29,6 +38,9 @@ union mlx5_ifc_config_item_type_auto_bits {
 				configuration_item_type_class_global;
 	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
 				configuration_item_type_class_per_host_pf;
+	struct mlx5_ifc_configuration_item_type_class_physical_port_bits
+				configuration_item_type_class_physical_port;
+
 	u8 reserved_at_0[0x20];
 };
 
@@ -123,6 +135,16 @@ struct mlx5_ifc_nv_sw_offload_conf_bits {
 	u8         lro_log_timeout0[0x4];
 };
 
+struct mlx5_ifc_nv_keep_link_up_bits {
+	u8    reserved_at_0[0x1a];
+	u8    auto_power_save_link_down[0x1];
+	u8    do_not_clear_port_stats[0x1];
+	u8    keep_link_up_on_standby[0x1];
+	u8    keep_link_up_on_boot[0x1];
+	u8    keep_ib_link_up[0x1];
+	u8    keep_eth_link_up[0x1];
+};
+
 #define MNVDA_HDR_SZ \
 	(MLX5_ST_SZ_BYTES(mnvda_reg) - MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
 
@@ -541,3 +563,110 @@ void mlx5_nv_param_unregister_dl_params(struct devlink *devlink)
 	devl_params_unregister(devlink, mlx5_nv_param_devlink_params,
 			       ARRAY_SIZE(mlx5_nv_param_devlink_params));
 }
+
+/* mlx5e devlink port params */
+
+static int
+mlx5_nv_param_read_keep_link_up(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	MLX5_SET_CONFIG_ITEM_TYPE(physical_port, mnvda, type_class, 1);
+	MLX5_SET_CONFIG_ITEM_TYPE(physical_port, mnvda, parameter_index,
+				  MLX5_CLASS_1_CTRL_ID_NV_KEEP_LINK_UP);
+	MLX5_SET_CONFIG_ITEM_TYPE(physical_port, mnvda, port, mlx5_get_dev_index(dev) + 1);
+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_keep_link_up);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int
+mlx5_nv_port_param_keep_link_up_get(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5e_dev *edev = devlink_priv(devlink);
+	struct mlx5_core_dev *dev = edev->priv->mdev;
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_keep_link_up(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_ETH)
+		ctx->val.vbool = !!MLX5_GET(nv_keep_link_up, data, keep_eth_link_up);
+	else if (MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB)
+		ctx->val.vbool = !!MLX5_GET(nv_keep_link_up, data, keep_ib_link_up);
+	else
+		ctx->val.vbool = false;
+
+	return 0;
+}
+
+static int
+mlx5_nv_port_param_keep_link_up_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5e_dev *edev = devlink_priv(devlink);
+	struct mlx5_core_dev *dev = edev->priv->mdev;
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_keep_link_up(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	if (MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_ETH)
+		MLX5_SET(nv_keep_link_up, data, keep_eth_link_up, ctx->val.vbool);
+	else if (MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB)
+		MLX5_SET(nv_keep_link_up, data, keep_ib_link_up, ctx->val.vbool);
+	else
+		return -EOPNOTSUPP;
+
+	return mlx5_nv_param_write(dev, mnvda,  sizeof(mnvda));
+}
+
+static int
+mlx5_nv_port_param_keep_link_up_validate(struct devlink *devlink, u32 id,
+					 union devlink_param_value val,
+					 struct netlink_ext_ack *extack)
+{
+	struct mlx5e_dev *edev = devlink_priv(devlink);
+	struct mlx5_core_dev *dev = edev->priv->mdev;
+
+	if (MLX5_CAP_GEN(dev, port_type) != MLX5_CAP_PORT_TYPE_ETH &&
+	    MLX5_CAP_GEN(dev, port_type) != MLX5_CAP_PORT_TYPE_IB) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Not supported on this device link type");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct devlink_param mlx5_nv_param_devlink_port_params[] = {
+	DEVLINK_PARAM_GENERIC(KEEP_LINK_UP, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_nv_port_param_keep_link_up_get,
+			      mlx5_nv_port_param_keep_link_up_set,
+			      mlx5_nv_port_param_keep_link_up_validate),
+};
+
+int mlx5_nv_port_param_register(struct mlx5_core_dev *dev, struct devlink_port *port)
+{
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+	return devlink_port_params_register(port, mlx5_nv_param_devlink_port_params,
+					    ARRAY_SIZE(mlx5_nv_param_devlink_port_params));
+}
+
+void mlx5_nv_port_param_unregister(struct mlx5_core_dev *dev, struct devlink_port *port)
+{
+	if (!mlx5_core_is_pf(dev))
+		return;
+	devlink_port_params_unregister(port, mlx5_nv_param_devlink_port_params,
+				       ARRAY_SIZE(mlx5_nv_param_devlink_port_params));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
index 9f4922ff7745..943933bdc246 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
@@ -9,6 +9,8 @@
 
 int mlx5_nv_param_register_dl_params(struct devlink *devlink);
 void mlx5_nv_param_unregister_dl_params(struct devlink *devlink);
+int mlx5_nv_port_param_register(struct mlx5_core_dev *dev, struct devlink_port *port);
+void mlx5_nv_port_param_unregister(struct mlx5_core_dev *dev, struct devlink_port *port);
 
 #endif
 
-- 
2.48.1


