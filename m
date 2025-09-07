Return-Path: <netdev+bounces-220649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B5B4788F
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39F020137B
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F481DE3B7;
	Sun,  7 Sep 2025 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy/TQGYJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343821946DA
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208627; cv=none; b=JpHxlaM2aeI5c3qNl90hq62ByodTejs5hEkBhbPZeYj23AyIyH7tzBPmtwsfEr15kEqPZOAMuHHd8ZJmSfWi0gOxUTWmwdk+gzAO2t/GYNp8nnZuSlmLPOWgfrR1Y5W5n7wEeaOml43ANdN2bZEFtwUm2564bi0Kw2O7J/Mh6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208627; c=relaxed/simple;
	bh=+DXc5p81bfq/dhM5wdlZfLkgHo64bRmOSng5e878BjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2gI/Nf6i42RYDa5GucleVwcQn+69hgE8Olx6yvsdWygeIN+28bpkxpl8snmEFyxzRjms/6QEqa9ggk3KGrF3Nst7fgwIIMf9J2l4l5m++x/Ltcq2Il+cJJx/1dTgcFQqIIcLCzHad76a2HsA5XkDGGTBYoqVqAmZOHVhZk4uYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy/TQGYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3257C4CEF8;
	Sun,  7 Sep 2025 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208627;
	bh=+DXc5p81bfq/dhM5wdlZfLkgHo64bRmOSng5e878BjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy/TQGYJpCvcqPIDhLB1hHRV3z/JdLtpWEC9E8qvNSV/8cSxqxc+xdXBkwVzspA53
	 h+82YkfaqSrF5Hbt6wxfLvttqFu/fbAnrY9UUySeMRyHqHe+7n17TMVC4WFFRlFG7G
	 qDIgjhJ4VVBXHTq8zEip680IOWuR9z6r6XoiRl66jULVxofDBUMaDmM93qr7sEql5h
	 IyI+/tZhQr2EpaGY+u/sEK2CbidfrH1gJd/OW+Qt///8owrnyy1rKg/DnQRC6qG9bp
	 CrAksk3xbtumd1nT+xJWNhXdxiGofiTmujk3DSEK8d9+I2ZlvBrhFB1fRm1WkWk+eS
	 Q8LSxnwryKAfw==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH V7 net-next 11/11] net/mlx5: Implement eSwitch hairpin per prio buffers devlink params
Date: Sat,  6 Sep 2025 18:29:53 -0700
Message-ID: <20250907012953.301746-12-saeed@kernel.org>
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

From: Saeed Mahameed <saeedm@nvidia.com>

E-Switch hairpin per prio buffers are controlled and configurable by the
device, add two devlink params to control them.

esw_haripin_per_prio_log_queue_size: p0,p1,....,p7
  Log(base 2) of the number of packets descriptors allocated
  internally for hairpin for IEEE802.1p priorities.
  0 means that no descriptors are allocated for this priority
  and traffic with this priority will be dropped.

esw_hairpin_per_prio_log_buf_size: p0,p1,...,p7
  Log(base 2) of the buffer size (in bytes) allocated internally
  for hairpin for IEEE802.1p priorities.
  0 means no buffer for this priority and traffic with this
  priority will be dropped.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/devlink/mlx5.rst     |  15 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 283 ++++++++++++++++++
 3 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 07b1424cbfbb..dd65f7da33bc 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -157,6 +157,21 @@ parameters.
        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
 
+   * - ``esw_hairpin_per_prio_log_queue_size``
+     - u32 array[8]
+     - permanent
+     - each item is log(base 2) of the number of packet descriptors allocated
+       internally for hairpin for IEEE802.1p priorities.
+       0 means that no descriptors are allocated for this priority
+       and traffic with this priority will be dropped.
+
+   * - ``esw_hairpin_per_prio_log_buf_size``
+     - u32 array[8]
+     - permanent
+     - each item is log(base 2) of the buffer size (in bytes) allocated internally
+       for hairpin for IEEE802.1p priorities.
+       0 means no buffer for this priority and traffic with this priority will be dropped.
+
 The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
 
 Info versions
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 74bcdfa70361..b2c10ce1eac5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -22,7 +22,9 @@ enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_ESW_MULTIPORT,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES,
 	MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE,
-	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
+	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
+	MLX5_DEVLINK_PARAM_ID_ESW_HAIRPIN_DESCRIPTORS,
+	MLX5_DEVLINK_PARAM_ID_ESW_HAIRPIN_DATA_SIZE,
 };
 
 struct mlx5_trap_ctx {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 383d8cfe4c0a..96c7217ac5a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
+#include <net/dcbnl.h>
+
 #include "nv_param.h"
 #include "mlx5_core.h"
 
 enum {
+	MLX5_CLASS_0_CTRL_ID_NV_INTERNAL_HAIRPIN_CONF         = 0x13,
+	MLX5_CLASS_0_CTRL_ID_NV_INTERNAL_HAIRPIN_CAP          = 0x14,
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
@@ -123,6 +127,19 @@ struct mlx5_ifc_nv_sw_offload_conf_bits {
 	u8         lro_log_timeout0[0x4];
 };
 
+struct mlx5_ifc_nv_internal_hairpin_cap_bits {
+	u8    log_max_hpin_total_num_descriptors[0x8];
+	u8    log_max_hpin_total_data_size[0x8];
+	u8    log_max_hpin_num_descriptor_per_prio[0x8];
+	u8    log_max_hpin_data_size_per_prio[0x8];
+};
+
+struct mlx5_ifc_nv_internal_hairpin_conf_bits {
+	u8    log_hpin_num_descriptor[8][0x8];
+
+	u8    log_hpin_data_size[8][0x8];
+};
+
 #define MNVDA_HDR_SZ \
 	(MLX5_ST_SZ_BYTES(mnvda_reg) - \
 	 MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
@@ -540,6 +557,258 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+mlx5_nv_param_read_internal_hairpin_conf(struct mlx5_core_dev *dev,
+					 void *mnvda, size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_INTERNAL_HAIRPIN_CONF);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_internal_hairpin_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int
+mlx5_nv_param_read_internal_hairpin_cap(struct mlx5_core_dev *dev,
+					void *mnvda, size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_INTERNAL_HAIRPIN_CAP);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int
+mlx5_nv_param_esw_hairpin_descriptors_get(struct devlink *devlink, u32 id,
+					  struct devlink_param_gset_ctx *ctx)
+
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err, i;
+
+	BUILD_BUG_ON(IEEE_8021QAZ_MAX_TCS > __DEVLINK_PARAM_MAX_ARRAY_SIZE);
+
+	err = mlx5_nv_param_read_internal_hairpin_conf(dev, mnvda,
+						       sizeof(mnvda));
+	if (err)
+		return err;
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	ctx->val.arr.size = IEEE_8021QAZ_MAX_TCS;
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		ctx->val.arr.vu32[i] = MLX5_GET(nv_internal_hairpin_conf, data,
+						log_hpin_num_descriptor[i]);
+	return 0;
+}
+
+static int
+mlx5_nv_param_esw_hairpin_descriptors_set(struct devlink *devlink, u32 id,
+					  struct devlink_param_gset_ctx *ctx,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err, i;
+
+	err = mlx5_nv_param_read_internal_hairpin_conf(dev, mnvda,
+						       sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to query internal hairpin conf");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		MLX5_SET(nv_internal_hairpin_conf, data,
+			 log_hpin_num_descriptor[i], ctx->val.arr.vu32[i]);
+
+	return mlx5_nv_param_write(dev, mnvda,  sizeof(mnvda));
+}
+
+static int
+mlx5_nv_param_esw_hairpin_descriptors_validate(struct devlink *devlink, u32 id,
+					       union devlink_param_value val,
+					       struct netlink_ext_ack *extack)
+{
+	u8 log_max_num_descriptors, log_max_total_descriptors;
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	u16 total = 0;
+	void *data;
+	int err, i;
+
+	if (val.arr.size != IEEE_8021QAZ_MAX_TCS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Array size must be %d",
+				       IEEE_8021QAZ_MAX_TCS);
+		return -EINVAL;
+	}
+	err = mlx5_nv_param_read_internal_hairpin_cap(devlink_priv(devlink),
+						      mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to query internal hairpin cap");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	log_max_total_descriptors =
+		MLX5_GET(nv_internal_hairpin_cap, data,
+			 log_max_hpin_total_num_descriptors);
+	log_max_num_descriptors =
+		MLX5_GET(nv_internal_hairpin_cap, data,
+			 log_max_hpin_num_descriptor_per_prio);
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (val.arr.vu32[i] <= log_max_num_descriptors)
+			continue;
+
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Max allowed value per prio is %d",
+				       log_max_num_descriptors);
+		return -ERANGE;
+	}
+
+	/* Validate total number of descriptors */
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_internal_hairpin_conf(devlink_priv(devlink),
+						       mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to query internal hairpin conf");
+		return err;
+	}
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		total += 1 << val.arr.vu32[i];
+
+	if (total > (1 << log_max_total_descriptors)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Log max total value allowed is %d",
+				       log_max_total_descriptors);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int
+mlx5_nv_param_esw_hairpin_data_size_get(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err, i;
+
+	err = mlx5_nv_param_read_internal_hairpin_conf(dev, mnvda,
+						       sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	ctx->val.arr.size = IEEE_8021QAZ_MAX_TCS;
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		ctx->val.arr.vu32[i] = MLX5_GET(nv_internal_hairpin_conf, data,
+						log_hpin_data_size[i]);
+	return 0;
+}
+
+static int
+mlx5_nv_param_esw_hairpin_data_size_set(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	int err, i;
+	void *data;
+
+	err = mlx5_nv_param_read_internal_hairpin_conf(dev, mnvda,
+						       sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		MLX5_SET(nv_internal_hairpin_conf, data, log_hpin_data_size[i],
+			 ctx->val.arr.vu32[i]);
+
+	return mlx5_nv_param_write(dev, mnvda,  sizeof(mnvda));
+}
+
+static int
+mlx5_nv_param_esw_hairpin_data_size_validate(struct devlink *devlink, u32 id,
+					     union devlink_param_value val,
+					     struct netlink_ext_ack *extack)
+{
+	u8 log_max_data_size, log_max_total_data_size;
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	unsigned long total = 0;
+	void *data;
+	int err, i;
+
+	if (val.arr.size != IEEE_8021QAZ_MAX_TCS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Array size must be %d",
+				       IEEE_8021QAZ_MAX_TCS);
+		return -EINVAL;
+	}
+
+	err = mlx5_nv_param_read_internal_hairpin_cap(devlink_priv(devlink),
+						      mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to query internal hairpin cap");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	log_max_data_size = MLX5_GET(nv_internal_hairpin_cap, data,
+				     log_max_hpin_data_size_per_prio);
+	log_max_total_data_size = MLX5_GET(nv_internal_hairpin_cap, data,
+					   log_max_hpin_total_data_size);
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (val.arr.vu32[i] <= log_max_data_size)
+			continue;
+
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Max allowed value per prio is %d",
+				       log_max_data_size);
+		return -ERANGE;
+	}
+
+	/* Validate total data size */
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_internal_hairpin_conf(devlink_priv(devlink),
+						       mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to query internal hairpin conf");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		total += 1 << val.arr.vu32[i];
+
+	if (total > (1 << log_max_total_data_size)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Log max total value allowed is %d",
+				       log_max_total_data_size);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      mlx5_devlink_enable_sriov_get,
@@ -554,6 +823,20 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			     mlx5_nv_param_devlink_cqe_compress_get,
 			     mlx5_nv_param_devlink_cqe_compress_set,
 			     mlx5_nv_param_devlink_cqe_compress_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_ESW_HAIRPIN_DESCRIPTORS,
+			     "esw_hairpin_per_prio_log_queue_size",
+			     DEVLINK_PARAM_TYPE_ARR_U32,
+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			     mlx5_nv_param_esw_hairpin_descriptors_get,
+			     mlx5_nv_param_esw_hairpin_descriptors_set,
+			     mlx5_nv_param_esw_hairpin_descriptors_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_ESW_HAIRPIN_DATA_SIZE,
+			     "esw_hairpin_per_prio_log_buf_size",
+			     DEVLINK_PARAM_TYPE_ARR_U32,
+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			     mlx5_nv_param_esw_hairpin_data_size_get,
+			     mlx5_nv_param_esw_hairpin_data_size_set,
+			     mlx5_nv_param_esw_hairpin_data_size_validate),
 };
 
 int mlx5_nv_param_register_dl_params(struct devlink *devlink)
-- 
2.51.0


