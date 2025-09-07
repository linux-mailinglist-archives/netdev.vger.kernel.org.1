Return-Path: <netdev+bounces-220642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9077EB4788A
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302FB7A7150
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B11A0B0E;
	Sun,  7 Sep 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZa+pz+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1851A0728
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208619; cv=none; b=mac4GI1oHxZaXZn/pTquXEeF2yhV+/pfbIdkRVroqRWRHwyKytfKUhYxFT9R1PzvHJxenhRiV7l1bIjdEZM/IRtYN238DWwSzZZtvcpK3CsAFL5kPSiOhQFOfrGfA9KGrQwc8FVQOVZBlIw5D9MjKiOaejEqkS4JsN7t5GTQDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208619; c=relaxed/simple;
	bh=DR5WK075Hfa4QU8Up7Sv+/NPsfXmjfC6ugkEtjR7zBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQotqSyD7B2VEfM8SbmNKTwmIu16PZxfBcEmKvroN2KsT101I2b79hjyEQjf7/EVpMYGUvqBTlrdr6ncYUiXZbIRukTsOKyvI96RAsUhYu22/wOulbvlPCfccwAHcb4OXmKanY47/5OQ41+c16/CWDlAwIX03I4d1r9tEFyOwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZa+pz+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C2C4CEE7;
	Sun,  7 Sep 2025 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208619;
	bh=DR5WK075Hfa4QU8Up7Sv+/NPsfXmjfC6ugkEtjR7zBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZa+pz+Nq2EglcinbSs+gzKxc0yIq3xF+pUmpgD+QTjRx1DToKnGEhw/4bRSsAs2r
	 ebvzm0zqfFqZOtmDOs5Geszt8cpYB6GuhJQ19ByTaJ8NnoPoWMsBwV9MWidrYb65fW
	 lqiu0QNKkQStci2aZB/EzWRrKcMouGQ9NfkqyyYdQ1r+Ccq/Gm3gIpb+3lmtPGoV6j
	 Las7E1HGLvIskUpl92ITmH4+P6h8TPl5wZw9KmuZLGlta2bA2KNYumW5yTUeloYI7a
	 lvlR6VnaiNF91pvjKfQEH/95dX1q/dkiXcSHRLzHgtqGEuJG5zRduI94/rfI//crjn
	 XtP6uW05VMP3w==
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
Subject: [PATCH V7 net-next 04/11] net/mlx5: Implement devlink total_vfs parameter
Date: Sat,  6 Sep 2025 18:29:46 -0700
Message-ID: <20250907012953.301746-5-saeed@kernel.org>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Kamal Heib <kheib@redhat.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/devlink/mlx5.rst     |  22 +++
 .../mellanox/mlx5/core/lib/nv_param.c         | 132 ++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index c3610f7c1d4b..07b1424cbfbb 100644
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
index ed2129843ec7..383d8cfe4c0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -412,10 +412,142 @@ static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
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
+	per_pf_support = MLX5_GET(nv_global_pci_cap, data,
+				  per_pf_total_vf_supported);
+	if (!per_pf_support) {
+		/* We don't allow global SRIOV setting on per PF devlink */
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRIOV is not per PF on this device");
+		return -EOPNOTSUPP;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
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
+			      mlx5_devlink_total_vfs_get,
+			      mlx5_devlink_total_vfs_set,
+			      mlx5_devlink_total_vfs_validate),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.51.0


