Return-Path: <netdev+bounces-175726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C7A6743B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A4617E9EE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5A20371E;
	Tue, 18 Mar 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UfYEMZtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0A3F9D5
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302048; cv=none; b=KW3s2HmfA5yGdoNRkrU2jfSxfgEOTZzjI1ohFTq15FAwdeiqatYDP1p+LjxeRGJlmxqB2nHGT3VHh/MTO/O2bphhzyDeJAG8W/Bex8xm1lkFMvmUDW6tgWH4bzFqn2pLmV56JKQ/71+m+g6SAjyY4I+aLxK2e0IahcnsXmDg7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302048; c=relaxed/simple;
	bh=0cqpnElSV22LUdepMjkOs87wAMn3hbYMoar/tqXoLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zd6KEXXxz7wOZr3tdSmGesK+/ixFdgCRRO4uLdWlSn69z+ER5AZlQsCVFOXyglmbbUXkEBuroC2ZYryQngdnqgse8Smf3Ayy+1xQWdjYs9xUjVWSNXDEdNI7XcA8EplsNTyr/RUxm3q96Xxa/L5bBZ27g0FV9sNfcnnCAS3kf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UfYEMZtI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso4456445f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742302044; x=1742906844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld4N8KJs+W7nuEw0yiCsi578Y5LVF8wq4N/IB5nYZak=;
        b=UfYEMZtIzXbB+BDCtM38yU3EXALWO2r0+tf7XjZs1TACnMOOeo5+UrDwsOLRiMXb5R
         abQNZpJkv/EVA+V2gNbUJK/6Mypgwpt3jhtGfNn0d2yatlmFZEStZ8rqhhdEqzEMNiFx
         +gz8aYpt8KFMq/nsh+w/Adg+pCm0M7zN/iMq6uRxwrxhaaEeLlNKZRvmX97zqLRJQF0D
         ulcBHrVrqfTDrQwB20G5Ve3+axAWB3RebEs8U1lMGzVp7pu+jbWrA/7gbJLwMjJkkwsx
         Bcnm3WzTXc4envtj0LuBv7pl6TleQW9mkiyj8wYX1tF4VhoiR1560bvUt9Kjz/TT+L0P
         Safg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302044; x=1742906844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld4N8KJs+W7nuEw0yiCsi578Y5LVF8wq4N/IB5nYZak=;
        b=X5Zy7DG/UZTrQOvpO3W9TeSFgaSFXgX/evhq8YVD8n6S7ihxKxLVVucztfNiPBFH93
         +JAvAPGj6HVboOEbepzDU3WjZSmefE0pleDdtkothBOlzkfPUQy+pdr2i05SYJe3ec9u
         vtgyNqGkPQxyAbXLhDeMrXFyE4GnGDysizff9rswrsRk8rU68cguH7WW7BXuy5JGdRHX
         c2V22Wd4vnvZn02LOHrwDbpH0gsx5TTUKukFZWhIDdsfJ2feYu5FGuzkzr0OMceBGp+T
         qC/UtZMsDC5+cFwEmckYBYiDYhACpWA9BOoUHyFChbs/GaYEIM+YCjD8e9bX5KJjgDNY
         k+MA==
X-Gm-Message-State: AOJu0YzvwrgeezACUITSQ1+fYat859b8zgG3TXfrJjmapk0gAteFprsO
	D2XsbsrEwetphVkT3LXuZbfM9g0sqhDSDi1oYjFvISqCagUeUrdoibw2rc0ybUL7Dp5AyTo34Un
	1
X-Gm-Gg: ASbGnct0IilsfcxmA3ZGa4qmSZimrQ0GAmP6u+GgB/Zippv3UFDMw43iSG4/Oj5D2kV
	mZZQHxIwiOsocXX8IVYrAXIHjnJS6+LTn4Fk6BcjxUDS9DXvL3RmYyHSFenm13AauAPwUT5uFFt
	Dxd2dcnrNm0dwiCWD2833fveyC/nwJ25rBy3lO9y/kMFBeITkn6r62JgSK8iShU6bjndWKMFcZ7
	x5rdVZnBQ5jlBWV1viSA9qEjwvm72EM+m6zZAsGWSIO9eJapMk0FVgJv8fw819m73ToHhb4+svs
	2J47OFrZnws2ZdlH50f+8Q0SN1gC3vZaroSubw==
X-Google-Smtp-Source: AGHT+IHZFyyjmkWTRfi7EmlgEfwlvwGMIo6lUfvAl/RX9x3W+BT8rtqE7tg1YuWW4+r59bUFKxPymw==
X-Received: by 2002:a05:6000:2aa:b0:391:b93:c971 with SMTP id ffacd0b85a97d-3996bb774b6mr2518746f8f.20.1742302044005;
        Tue, 18 Mar 2025 05:47:24 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm17945072f8f.87.2025.03.18.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:47:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	dakr@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	cratiu@nvidia.com,
	jacob.e.keller@intel.com,
	konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: [PATCH net-next RFC 3/3] net/mlx5: Introduce enable_sriov param for shared devlink
Date: Tue, 18 Mar 2025 13:47:06 +0100
Message-ID: <20250318124706.94156-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318124706.94156-1-jiri@resnulli.us>
References: <20250318124706.94156-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As some of the mlx5 devices only support enabling/disabling SR-IOV
per-chip and not per-PF, introduce this param attached to shared
devlink instance.

Example:
$ devlink dev param show faux/mlx5_core_83013c12b77faa1a30000c82a1045c91
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  name enable_sriov type generic
    values:
      cmode permanent value false
$ devlink dev param set faux/mlx5_core_83013c12b77faa1a30000c82a1045c91 name enable_sriov cmode permanent value true

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 236 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  14 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  16 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |   1 +
 include/linux/mlx5/driver.h                   |   1 +
 6 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 510850b6e6e2..238c212ad0fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,8 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
-		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
new file mode 100644
index 000000000000..04682bec8fa5
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "nv_param.h"
+#include "sh_devlink.h"
+#include "mlx5_core.h"
+
+enum {
+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF	       = 0x80,
+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP		= 0x81,
+};
+
+struct mlx5_ifc_configuration_item_type_class_global_bits {
+	u8	 type_class[0x8];
+	u8	 parameter_index[0x18];
+};
+
+union mlx5_ifc_config_item_type_auto_bits {
+	struct mlx5_ifc_configuration_item_type_class_global_bits
+				configuration_item_type_class_global;
+	u8 reserved_at_0[0x40];
+};
+
+struct mlx5_ifc_config_item_bits {
+	u8	 valid[0x2];
+	u8	 priority[0x2];
+	u8	 header_type[0x2];
+	u8	 ovr_en[0x1];
+	u8	 rd_en[0x1];
+	u8	 access_mode[0x2];
+	u8	 reserved_at_a[0x1];
+	u8	 writer_id[0x5];
+	u8	 version[0x4];
+	u8	 reserved_at_14[0x2];
+	u8	 host_id_valid[0x1];
+	u8	 length[0x9];
+
+	union mlx5_ifc_config_item_type_auto_bits type;
+
+	u8	 reserved_at_40[0x10];
+	u8	 crc16[0x10];
+};
+
+struct mlx5_ifc_mnvda_reg_bits {
+	struct mlx5_ifc_config_item_bits configuration_item_header;
+
+	u8	 configuration_item_data[64][0x20];
+};
+
+struct mlx5_ifc_nv_global_pci_conf_bits {
+	u8	 sriov_valid[0x1];
+	u8	 reserved_at_1[0x10];
+	u8	 per_pf_total_vf[0x1];
+	u8	 reserved_at_12[0xe];
+
+	u8	 sriov_en[0x1];
+	u8	 reserved_at_21[0xf];
+	u8	 total_vfs[0x10];
+
+	u8	 reserved_at_40[0x20];
+};
+
+struct mlx5_ifc_nv_global_pci_cap_bits {
+	u8	 max_vfs_per_pf_valid[0x1];
+	u8	 reserved_at_1[0x13];
+	u8	 per_pf_total_vf_supported[0x1];
+	u8	 reserved_at_15[0xb];
+
+	u8	 sriov_support[0x1];
+	u8	 reserved_at_21[0xf];
+	u8	 max_vfs_per_pf[0x10];
+
+	u8	 reserved_at_40[0x60];
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
+mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int
+mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev, void *mnvda, size_t len)
+{
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_cap);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int mlx5_shd_enable_sriov_get(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = mlx5_shd_dev(devlink_priv(devlink));
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *cap, *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support))
+		return -EOPNOTSUPP;
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	ctx->val.vbool = MLX5_GET(nv_global_pci_conf, data, sriov_en);
+	return 0;
+}
+
+static int mlx5_shd_enable_sriov_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = mlx5_shd_dev(devlink_priv(devlink));
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *cap, *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read global PCI capability");
+		return err;
+	}
+
+	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+
+	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
+		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
+		return -EOPNOTSUPP;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
+	MLX5_SET(nv_global_pci_conf, data, sriov_en, ctx->val.vbool);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to write global PCI configuration");
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct devlink_param mlx5_shd_nv_param_devlink_params[] = {
+	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_shd_enable_sriov_get,
+			      mlx5_shd_enable_sriov_set, NULL),
+};
+
+int mlx5_shd_nv_param_register_dl_params(struct devlink *devlink)
+{
+	return devl_params_register(devlink, mlx5_shd_nv_param_devlink_params,
+				    ARRAY_SIZE(mlx5_shd_nv_param_devlink_params));
+}
+
+void mlx5_shd_nv_param_unregister_dl_params(struct devlink *devlink)
+{
+	devl_params_unregister(devlink, mlx5_shd_nv_param_devlink_params,
+			       ARRAY_SIZE(mlx5_shd_nv_param_devlink_params));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
new file mode 100644
index 000000000000..785edfe9bf15
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_NV_PARAM_H
+#define __MLX5_NV_PARAM_H
+
+#include <linux/mlx5/driver.h>
+#include "devlink.h"
+
+int mlx5_shd_nv_param_register_dl_params(struct devlink *devlink);
+void mlx5_shd_nv_param_unregister_dl_params(struct devlink *devlink);
+
+#endif
+
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index 671a3442525b..1c730071f00f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -2,9 +2,10 @@
 /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include <linux/device/faux.h>
+#include <linux/mlx5/device.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/vport.h>
-
+#include "lib/nv_param.h"
 #include "sh_devlink.h"
 
 static LIST_HEAD(shd_list);
@@ -24,6 +25,12 @@ struct mlx5_shd {
 	struct faux_device *faux_dev;
 };
 
+struct mlx5_core_dev *mlx5_shd_dev(struct mlx5_shd *shd)
+{
+	return list_first_entry(&shd->dev_list,
+				struct mlx5_core_dev, shd_list);
+}
+
 static const struct devlink_ops mlx5_shd_ops = {
 };
 
@@ -31,6 +38,7 @@ static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
 {
 	struct devlink *devlink;
 	struct mlx5_shd *shd;
+	int err;
 
 	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd), &faux_dev->dev);
 	if (!devlink)
@@ -39,6 +47,11 @@ static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
 	faux_device_set_drvdata(faux_dev, shd);
 
 	devl_lock(devlink);
+	err = mlx5_shd_nv_param_register_dl_params(devlink);
+	if (err) {
+		devl_unlock(devlink);
+		return err;
+	}
 	devl_register(devlink);
 	devl_unlock(devlink);
 	return 0;
@@ -51,6 +64,7 @@ static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
 
 	devl_lock(devlink);
 	devl_unregister(devlink);
+	mlx5_shd_nv_param_unregister_dl_params(devlink);
 	devl_unlock(devlink);
 	devlink_free(devlink);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
index 67df03e3c72e..837b8a3ca54e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -4,6 +4,7 @@
 #ifndef __MLX5_SH_DEVLINK_H__
 #define __MLX5_SH_DEVLINK_H__
 
+struct mlx5_core_dev *mlx5_shd_dev(struct mlx5_shd *shd);
 int mlx5_shd_init(struct mlx5_core_dev *dev);
 void mlx5_shd_uninit(struct mlx5_core_dev *dev);
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 78f1f034568f..044a45abe614 100644
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
2.48.1


