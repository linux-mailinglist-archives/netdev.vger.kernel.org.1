Return-Path: <netdev+bounces-170688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88FA499B7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C37B173EEE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84C26B973;
	Fri, 28 Feb 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="x5wpEZSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8626B944
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746773; cv=none; b=vAm9ooXBTDWhGC7Ofk8gaWEpxdIgCbzl08cohHAo9UN61t3krxQypuYPoHj7I3W2sUZi63dYUyPLlQvRFk4olCc9npNAqeWT1tRL+Ck62HEalx5TUjXcUfdTOdwGvZSXeESP2L5MRs1OitFh6Hwr35QWHNYDR0E9D5oc56j14bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746773; c=relaxed/simple;
	bh=4UJlHsyIvkAhwmhgnakEFWgOEIhO/NNA0NYjItI3maE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0XFn8psrv7iWeCi1AajiD97P4yKkIB7vC0HmA7Vdm8Yk+D6hZsx0Ipei1mToPJPVkHctvbDIGk0FGeudB3W5OiUwFDJ9+7pvgqSGfXe8Ry9GtbX+JwjvHPwjDAD1CM7s6uuekk19Yfg2/gB54OTg5UP7dkqKLP1xZvJFEyuAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=x5wpEZSt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf45d8db04so14107666b.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740746769; x=1741351569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsd1lLUoNj+YCMOT2vjAPAGBBFhzAe8gvOJWlA1vtMw=;
        b=x5wpEZSt/wjlBQSvb6iz+5z24gLL7Tj1BReXV8E31fH2p9m7no+1hiGrtJLiY315JJ
         p8uMedO4boEpIUXiQkjj5yBUI2yPPgkFlRNJ+I08yr0S1Zj7BVyS9qRhL64Gm8cF3LYU
         xFUcSl3xBq1HXHGkvsjx2QTtwPmnKIJ+aQso+CKSw+/QuutCscwkEvsOzrZ3Kc9aV6kb
         IURIzqeU1PF2R21LaEAQGQjAHxrMQUAJ5XdOXBF9WkRVbMP8yXl4xYYsOXpHKuUrctPF
         SHl2ZX2Hn+39ed+K8XptfJEZzUDP7S4bUcOUrS9gSfJtQyj54aqzb7XGe7bkU03nqk3s
         0xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746769; x=1741351569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsd1lLUoNj+YCMOT2vjAPAGBBFhzAe8gvOJWlA1vtMw=;
        b=dCwHFCWvxAy4O+3HRs2UL81Nckndr7AP2pplcpL1aIN/m2HsFatlh0p9YFTLVQiwmD
         JPf/q2Qau7fTO7zu/m8qejyR6Uh+QtMibHpelrm9VmIn6p1uvncNMV6t13D5ilh8XtOF
         ENQJfU5Hj00MrIpMRc6OufzV/3hcDZBXYwe2PRVCPKTkvOCHJavULplioYytcVy11rYG
         pK1E0bwJ6iOBeGpbTGBOE2jQt+dfR0k8MyO1zUEQwc2CseQIJhUcenAbSoyAAYxrwX2e
         BhMGrXBVcQtyXYLEqxJm1ZYM91TtkLuokKB5yn8k2ljulTpfXRULCT5cfKUGGrHgIdmp
         c6AA==
X-Forwarded-Encrypted: i=1; AJvYcCW+N8jGu/CjtlhfCYcTNzpvmf/dsQrSICssY4Zqi0vbKvy0KDpInpfy9dgFArDfVmK/OT3WUzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxDfU9wJerRdYQLvO6KglaVT5+9tyuBiJ4jk2/cv4iXC21pWM
	9gH1H0mjMT8oEaZ0Js2q7G2DuEXOz1IPf2M2WivGWWuqWCtiU2s4AJIj0hDP5Y4=
X-Gm-Gg: ASbGncv7iPkPd8GNt/98awdPTATpeDRPJESAwfNebWhI/tVJtim1pwBj8vDXqmvdx9o
	rnOZo4SHOlkfbxy/kkjLTNWVzCcc5PvC0MwcQOXdiQrSTn3UDpPZdPYMspWCfmfGai3G8XaRDcE
	aORe5kyuX2+MjfvF3SLSTYtyQjFRkZCV4gN1S7do5AnSvjw0Hz+wgciWeZ552KoKhrPzTFEy0Jz
	52AKzQlSnU64f0SCrdwhTrorp7xPJ8y5CHp0lvMaP0IDuwGZ4pbiewEWb8yhszJoSi2f7VltyD6
	S7AZI5mYJu3qIuzv4XGUf9FKFwJpk1ci+4OY0kAXKiq8vUQRCRXt4Q==
X-Google-Smtp-Source: AGHT+IG26VYX/XgQh1fzoSUoTTU6Fr9EdBamssODQd9YZ5t0QMRqLRU0d3q13QnHCoNQd2O+OdbCZQ==
X-Received: by 2002:a17:907:60d0:b0:ab7:f245:fbc1 with SMTP id a640c23a62f3a-abf261f9dffmr299855066b.3.1740746768711;
        Fri, 28 Feb 2025 04:46:08 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6e96ecsm281702866b.114.2025.02.28.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:46:08 -0800 (PST)
Date: Fri, 28 Feb 2025 13:46:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov
 parameter
Message-ID: <uovifydwz7vbhbjzy4g4x4lkrq7htepoktekqidqxytkqi6ra6@2xfhgel6h7sz>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-5-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:17AM +0100, saeed@kernel.org wrote:
>From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>
>Example usage:
>  devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>  devlink dev reload pci/0000:01:00.0 action fw_activate
>  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>  echo 1 >/sys/bus/pci/rescan
>  grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
>
>Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>---
> Documentation/networking/devlink/mlx5.rst     |  14 +-
> .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
> .../mellanox/mlx5/core/lib/nv_param.c         | 184 ++++++++++++++++++
> 3 files changed, 196 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>index 417e5cdcd35d..587e0200c1cd 100644
>--- a/Documentation/networking/devlink/mlx5.rst
>+++ b/Documentation/networking/devlink/mlx5.rst
>@@ -15,23 +15,31 @@ Parameters
>    * - Name
>      - Mode
>      - Validation
>+     - Notes
>    * - ``enable_roce``
>      - driverinit
>-     - Type: Boolean
>-
>-       If the device supports RoCE disablement, RoCE enablement state controls
>+     - Boolean
>+     - If the device supports RoCE disablement, RoCE enablement state controls
>        device support for RoCE capability. Otherwise, the control occurs in the
>        driver stack. When RoCE is disabled at the driver level, only raw
>        ethernet QPs are supported.
>    * - ``io_eq_size``
>      - driverinit
>      - The range is between 64 and 4096.
>+     -
>    * - ``event_eq_size``
>      - driverinit
>      - The range is between 64 and 4096.
>+     -
>    * - ``max_macs``
>      - driverinit
>      - The range is between 1 and 2^31. Only power of 2 values are supported.
>+     -
>+   * - ``enable_sriov``
>+     - permanent
>+     - Boolean
>+     - Applies to each physical function (PF) independently, if the device
>+       supports it. Otherwise, it applies symmetrically to all PFs.
> 
> The ``mlx5`` driver also implements the following driver-specific
> parameters.
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>index 1f764ae4f4aa..7a702d84f19a 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>@@ -8,6 +8,7 @@
> #include "fs_core.h"
> #include "eswitch.h"
> #include "esw/qos.h"
>+#include "lib/nv_param.h"
> #include "sf/dev/dev.h"
> #include "sf/sf.h"
> #include "lib/nv_param.h"
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>index 5ab37a88c260..6b63fc110e2d 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>@@ -5,7 +5,11 @@
> #include "mlx5_core.h"
> 
> enum {
>+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
>+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
> 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
>+
>+	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
> };
> 
> struct mlx5_ifc_configuration_item_type_class_global_bits {
>@@ -13,9 +17,18 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
> 	u8         parameter_index[0x18];
> };
> 
>+struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
>+	u8         type_class[0x8];
>+	u8         pf_index[0x6];
>+	u8         pci_bus_index[0x8];
>+	u8         parameter_index[0xa];
>+};
>+
> union mlx5_ifc_config_item_type_auto_bits {
> 	struct mlx5_ifc_configuration_item_type_class_global_bits
> 				configuration_item_type_class_global;
>+	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
>+				configuration_item_type_class_per_host_pf;
> 	u8 reserved_at_0[0x20];
> };
> 
>@@ -45,6 +58,45 @@ struct mlx5_ifc_mnvda_reg_bits {
> 	u8         configuration_item_data[64][0x20];
> };
> 
>+struct mlx5_ifc_nv_global_pci_conf_bits {
>+	u8         sriov_valid[0x1];
>+	u8         reserved_at_1[0x10];
>+	u8         per_pf_total_vf[0x1];
>+	u8         reserved_at_12[0xe];
>+
>+	u8         sriov_en[0x1];
>+	u8         reserved_at_21[0xf];
>+	u8         total_vfs[0x10];
>+
>+	u8         reserved_at_40[0x20];
>+};
>+
>+struct mlx5_ifc_nv_global_pci_cap_bits {
>+	u8         max_vfs_per_pf_valid[0x1];
>+	u8         reserved_at_1[0x13];
>+	u8         per_pf_total_vf_supported[0x1];
>+	u8         reserved_at_15[0xb];
>+
>+	u8         sriov_support[0x1];
>+	u8         reserved_at_21[0xf];
>+	u8         max_vfs_per_pf[0x10];
>+
>+	u8         reserved_at_40[0x60];
>+};
>+
>+struct mlx5_ifc_nv_pf_pci_conf_bits {
>+	u8         reserved_at_0[0x9];
>+	u8         pf_total_vf_en[0x1];
>+	u8         reserved_at_a[0x16];
>+
>+	u8         reserved_at_20[0x20];
>+
>+	u8         reserved_at_40[0x10];
>+	u8         total_vf[0x10];
>+
>+	u8         reserved_at_60[0x20];
>+};
>+
> struct mlx5_ifc_nv_sw_offload_conf_bits {
> 	u8         ip_over_vxlan_port[0x10];
> 	u8         tunnel_ecn_copy_offload_disable[0x1];
>@@ -206,7 +258,139 @@ static int mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 i
> 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> }
> 
>+static int
>+mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>+{
>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_conf);
>+
>+	return mlx5_nv_param_read(dev, mnvda, len);
>+}
>+
>+static int
>+mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>+{
>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_cap);
>+
>+	return mlx5_nv_param_read(dev, mnvda, len);
>+}
>+
>+static int
>+mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>+{
>+	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, type_class, 3);
>+	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, parameter_index,
>+				  MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF);
>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_pf_pci_conf);
>+
>+	return mlx5_nv_param_read(dev, mnvda, len);
>+}
>+
>+static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
>+					 struct devlink_param_gset_ctx *ctx)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	void *data;
>+	int err;
>+
>+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>+	if (err)
>+		return err;
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
>+		ctx->val.vbool = false;
>+		return 0;
>+	}
>+
>+	memset(mnvda, 0, sizeof(mnvda));
>+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>+	if (err)
>+		return err;
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
>+		ctx->val.vbool = MLX5_GET(nv_global_pci_conf, data, sriov_en);
>+		return 0;
>+	}
>+
>+	/* SRIOV is per PF */
>+	memset(mnvda, 0, sizeof(mnvda));
>+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>+	if (err)
>+		return err;
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	ctx->val.vbool = MLX5_GET(nv_pf_pci_conf, data, pf_total_vf_en);
>+	return 0;
>+}
>+
>+static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
>+					 struct devlink_param_gset_ctx *ctx,
>+					 struct netlink_ext_ack *extack)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	bool per_pf_support;
>+	void *cap, *data;
>+	int err;
>+
>+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Failed to read global PCI capability");
>+		return err;
>+	}
>+
>+	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	per_pf_support = MLX5_GET(nv_global_pci_cap, cap, per_pf_total_vf_supported);
>+
>+	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	memset(mnvda, 0, sizeof(mnvda));
>+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to read global PCI configuration");
>+		return err;
>+	}
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
>+	MLX5_SET(nv_global_pci_conf, data, sriov_en, ctx->val.vbool);
>+	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
>+
>+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to write global PCI configuration");
>+		return err;
>+	}
>+
>+	if (!per_pf_support)


Hmm, given the discussion we have in parallel about some shared-PF
devlink instance, perhaps it would be good idea to allow only per-pf
configuration here for now and let the "global" per-device configuration
knob to be attached on the shared-PF devlink, when/if it lands. What do
you think?


>+		return 0;
>+
>+	/* SRIOV is per PF */
>+	memset(mnvda, 0, sizeof(mnvda));
>+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to read per host PF configuration");
>+		return err;
>+	}
>+	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, ctx->val.vbool);
>+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>+}
>+
> static const struct devlink_param mlx5_nv_param_devlink_params[] = {
>+	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>+			      mlx5_devlink_enable_sriov_get,
>+			      mlx5_devlink_enable_sriov_set, NULL),
> 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
> 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
> 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>-- 
>2.48.1
>
>

