Return-Path: <netdev+bounces-170507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04AA48E5E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3C6188F4A9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D517A2F4;
	Fri, 28 Feb 2025 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqVapGMJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFB178395
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708809; cv=none; b=if1YOvVlx6ORh+Dl4LTw1LWiPtIByCuBfaB1rHn96XHjr6uhasj4t6TQQ9FYndq7EPWxwhGsB7eEU7y/KrY4eY1de3fPwdJoJog9cDBLzkN2LcQnW0k+ALk6or5thfurlL4/IO4lrl4a3IJVBb4lP4p+1zDpUI9TGpRqTOSTs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708809; c=relaxed/simple;
	bh=xMw/7/F5X7Vep48TmlKnNROM5lwGAbCiqCBdjrb5kqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbgPlhgCGpmttc3U1DYEpyL5bjWl09xr4wer2qFfqETJWoWEe4xrgASE7FGWK/qldEgQBNQUbNvcEUTGBJbDNQ+P8WhYNTXZt2akw2rRa0jV+zxfUATdggF83/+EC8YWQ1e4xkPFuuNDfZFvumgfKmMTFMV+EiGfWrUdmGCuAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqVapGMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E32C4CEE7;
	Fri, 28 Feb 2025 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708809;
	bh=xMw/7/F5X7Vep48TmlKnNROM5lwGAbCiqCBdjrb5kqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqVapGMJzhVGw685mTFOmyeMY8NpvBui4y8crE9kw2dx3EVx9dVSoom/5w3pJfupm
	 dPulAGlfd4mo2cxO8LW2tFHBfTE492lQjenY7x1FACVvQTOdI/hNcG3N7gINcGvYtL
	 nXO4547AtO5m5ypGhw7GHPbMYPzutQvpthtpOz8CNrLrXSdTJpvOWYbSCHxreHA40K
	 3sF1yCzw88XWbmu9qZngGyp6Qqzmv7N6iIY2Y4lZ6tybEyUNfKGHMUn+TFdF+1yUfA
	 gWufCQokiPZo5SDm4/ipTFfngoFZEIGCXTBff2yh2ppbea1CQyLTWITo58QCsMx6ep
	 Fj4i1yegy627Q==
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
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH net-next 05/14] net/mlx5: Implement devlink total_vfs parameter
Date: Thu, 27 Feb 2025 18:12:18 -0800
Message-ID: <20250228021227.871993-6-saeed@kernel.org>
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

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Some devices support both symmetric (same value for all PFs) and
asymmetric, while others only support symmetric configuration. This
implementation prefers asymmetric, since it is closer to the devlink
model (per function settings), but falls back to symmetric when needed.

Example usage:
  devlink dev param set pci/0000:01:00.0 name total_vfs value <u16> cmode permanent
  devlink dev reload pci/0000:01:00.0 action fw_activate
  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
  echo 1 >/sys/bus/pci/rescan
  cat /sys/bus/pci/devices/0000:01:00.0/sriov_totalvfs

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  22 +++
 .../mellanox/mlx5/core/lib/nv_param.c         | 125 ++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 587e0200c1cd..00a43324dec2 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -40,6 +40,28 @@ Parameters
      - Boolean
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``total_vfs``
+     - permanent
+     - The range is between 1 and a device-specific max.
+     - Applies to each physical function (PF) independently, if the device
+       supports it. Otherwise, it applies symmetrically to all PFs.
+
+Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
+
+.. code-block:: bash
+
+   # setup parameters
+   devlink dev param set pci/0000:01:00.0 name enable_sriov value true cmode permanent
+   devlink dev param set pci/0000:01:00.0 name total_vfs value 8 cmode permanent
+
+   # Fw reset
+   devlink dev reload pci/0000:01:00.0 action fw_activate
+
+   # for PCI related config such as sriov PCI reset/rescan is required:
+   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
+   echo 1 >/sys/bus/pci/rescan
+   grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
+
 
 The ``mlx5`` driver also implements the following driver-specific
 parameters.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 6b63fc110e2d..97d74d890582 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -387,10 +387,135 @@ static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 }
 
+static int mlx5_devlink_total_vfs_get(struct devlink *devlink, u32 id,
+				      struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
+		ctx->val.vu32 = 0;
+		return 0;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
+		ctx->val.vu32 = MLX5_GET(nv_global_pci_conf, data, total_vfs);
+		return 0;
+	}
+
+	/* SRIOV is per PF */
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_vf);
+
+	return 0;
+}
+
+static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
+				      struct devlink_param_gset_ctx *ctx,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)];
+	bool per_pf_support;
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read global pci cap");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
+		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
+		return -EOPNOTSUPP;
+	}
+
+	per_pf_support = MLX5_GET(nv_global_pci_cap, data, per_pf_total_vf_supported);
+	memset(mnvda, 0, sizeof(mnvda));
+
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
+	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
+
+	if (!per_pf_support) {
+		MLX5_SET(nv_global_pci_conf, data, total_vfs, ctx->val.vu32);
+		return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	}
+
+	/* SRIOV is per PF */
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, 1);
+	MLX5_SET(nv_pf_pci_conf, data, total_vf, ctx->val.vu32);
+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+}
+
+static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
+					   union devlink_param_value val,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 cap[MLX5_ST_SZ_DW(mnvda_reg)];
+	void *data;
+	u16 max;
+	int err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, cap, configuration_item_data);
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, cap, sizeof(cap));
+	if (err)
+		return err;
+
+	if (!MLX5_GET(nv_global_pci_cap, data, max_vfs_per_pf_valid))
+		return 0; /* optimistic, but set might fail later */
+
+	max = MLX5_GET(nv_global_pci_cap, data, max_vfs_per_pf);
+	if (val.vu16 > max) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Max allowed by device is %u", max);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      mlx5_devlink_enable_sriov_get,
 			      mlx5_devlink_enable_sriov_set, NULL),
+	DEVLINK_PARAM_GENERIC(TOTAL_VFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_devlink_total_vfs_get, mlx5_devlink_total_vfs_set,
+			      mlx5_devlink_total_vfs_validate),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.48.1


