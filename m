Return-Path: <netdev+bounces-171759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48123A4E831
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5C84254F0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDF291F92;
	Tue,  4 Mar 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLg8z7vp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A22291F8F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106646; cv=none; b=iuppR6ohjYgF0QBrDRWmrK+RFl7CTBBbJhdjk+cKFhxJchiYm1owRbf+QdYiOIk1J58h6pWOL1xetv31YKaUxnIderLgUUslbJu88HBqr+3L036hwsUcDXsJ6q8JpmDYECcUEG48MEkezSr5MeygKX7fwWjd03pgWwg4Neb/Yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106646; c=relaxed/simple;
	bh=bA4EdvnwZTP+O15HyKcJrqnvbEFQefmW+gOJ9sGak3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX8UMA9/8wAiNUvbpBTsM1G01Skq8yFS+3YOZ2v7InARselqBNKsPOs+7y+AvITfwzEiHYucQKH5j95zY7WR8EpsZpv3MI01hVdDDszctwbp9lXwxN8qlQtfp/ovvTsI1sonf6P2SBW9h2fgiFm2/kUhmLC0lnRFJKQv80JJms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLg8z7vp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741106643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOdS/RqEtk/3xbEzr822u5f0OquQO8adueZap1j4ppM=;
	b=BLg8z7vpOR4uFzGS7A9CeWNv/M+AczolgQyWI9ERo+VODQybJL8O2q5uvHpUDMx45PfM+a
	CdAPBpsJuTfdz9GDj1ZWZ2HOx+WWfuIWm1Up5zb/J/S06j3GCsRdlDgN2uCfwiqctvykYN
	RVkdMxaidMMshgC6gdoXodN0MnGCezI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-eaAhZUoDN_u3Y4UhA71DRQ-1; Tue, 04 Mar 2025 11:43:50 -0500
X-MC-Unique: eaAhZUoDN_u3Y4UhA71DRQ-1
X-Mimecast-MFC-AGG-ID: eaAhZUoDN_u3Y4UhA71DRQ_1741106630
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-474f1ef0b7fso41619541cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106630; x=1741711430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOdS/RqEtk/3xbEzr822u5f0OquQO8adueZap1j4ppM=;
        b=JRH0lrnz9D5FphLHkAi4xucRoOp8CsNK9o5iIAE37fxaIHMPtO21eOMHql7yHmFZGp
         r+fIk6gydoStF+dME7424wESWw//ZyIlC1rsBEIbaGbQLO8dG2RaQKpfmI7nlxndIApw
         s/8b5nCeJ+jGXrGoeta/IpEtyPdSd7YFWbowAECoth7dgcz0oiM5l1VZoTy0N8w435xB
         MOfEFUF6VQFWgGNuWN5E7826l+1voUDL1qtVS/r9UbEeYRVyr5wlwciG/pVwRPMmcbyD
         acy3OQegT3OgupVZMpBVh0OVzjh+Juzw0tWWkhxk7EbPo2sV0Gxoeyh+i6TGgwC7qhaK
         JJUw==
X-Forwarded-Encrypted: i=1; AJvYcCXGZ2dkRLDuazhMmmQ//v+t5xIMb+5bpCMGwfonJ15znoOib9pJz0wMnoAFk7HYgZHMuRal0bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhc2lYfRkR+4s8+XpZdfEKTG/z6l7Q1bZZTiQt8DQq7ZOgjgyC
	sp/gGlrzLw6qNhQe353ldUitwPORuqxvm4JguS4LcVBa/qtVjfhtX8UOp/aTesYZKmY6GWcVMsd
	oy6opPhH+OQilQkGRwJsTapSUXKEdPryplyGwYNYU6U7HL6CG6CPY7w==
X-Gm-Gg: ASbGncvJleF1QE85z54lFpyJqEwZXD1jdSueci1gcWKYG/JUiKKqCj1Z8mvzLEg/H2f
	i06dsEnNXhZjSowdBf7/rjc/TO/Acy3idyq/EFER3WVl8WXk7Plb/tJEc9SVopMyjNTajCIdu7e
	zP84VtobqTDj/sYcrphNveGKhN+OFrc3obOP3PvTDsSn2EGoXxKEQlnWiSGd2mTOG6937TJCNBV
	rNPkzSjLPd1PHssXMD0yGiez7X4HzTnT/+/qCC1bemzUzkU7w3KlGcz4mixh6xvtt/fscSVHEwu
	xgFZIWZb
X-Received: by 2002:a05:622a:c6:b0:473:8698:de12 with SMTP id d75a77b69052e-474bc0554eamr266896081cf.4.1741106629817;
        Tue, 04 Mar 2025 08:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9VYCk2b0dfup0R32zsvuKPuv0g9sSplnaqugoOXMThWAdZvyyBnWor8/NeiLT++/IOfFlog==
X-Received: by 2002:a05:622a:c6:b0:473:8698:de12 with SMTP id d75a77b69052e-474bc0554eamr266895561cf.4.1741106629384;
        Tue, 04 Mar 2025 08:43:49 -0800 (PST)
Received: from fedora-x1 ([142.126.89.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474febab252sm10911011cf.3.2025.03.04.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:43:49 -0800 (PST)
Date: Tue, 4 Mar 2025 11:43:38 -0500
From: Kamal Heib <kheib@redhat.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov
 parameter
Message-ID: <Z8ctuhBNsAcK_ZRH@fedora-x1>
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

On Thu, Feb 27, 2025 at 06:12:17PM -0800, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> Example usage:
>   devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>   devlink dev reload pci/0000:01:00.0 action fw_activate
>   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>   echo 1 >/sys/bus/pci/rescan
>   grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Tested-by: Kamal Heib <kheib@redhat.com>

> ---
>  Documentation/networking/devlink/mlx5.rst     |  14 +-
>  .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
>  .../mellanox/mlx5/core/lib/nv_param.c         | 184 ++++++++++++++++++
>  3 files changed, 196 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> index 417e5cdcd35d..587e0200c1cd 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -15,23 +15,31 @@ Parameters
>     * - Name
>       - Mode
>       - Validation
> +     - Notes
>     * - ``enable_roce``
>       - driverinit
> -     - Type: Boolean
> -
> -       If the device supports RoCE disablement, RoCE enablement state controls
> +     - Boolean
> +     - If the device supports RoCE disablement, RoCE enablement state controls
>         device support for RoCE capability. Otherwise, the control occurs in the
>         driver stack. When RoCE is disabled at the driver level, only raw
>         ethernet QPs are supported.
>     * - ``io_eq_size``
>       - driverinit
>       - The range is between 64 and 4096.
> +     -
>     * - ``event_eq_size``
>       - driverinit
>       - The range is between 64 and 4096.
> +     -
>     * - ``max_macs``
>       - driverinit
>       - The range is between 1 and 2^31. Only power of 2 values are supported.
> +     -
> +   * - ``enable_sriov``
> +     - permanent
> +     - Boolean
> +     - Applies to each physical function (PF) independently, if the device
> +       supports it. Otherwise, it applies symmetrically to all PFs.
>  
>  The ``mlx5`` driver also implements the following driver-specific
>  parameters.
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index 1f764ae4f4aa..7a702d84f19a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -8,6 +8,7 @@
>  #include "fs_core.h"
>  #include "eswitch.h"
>  #include "esw/qos.h"
> +#include "lib/nv_param.h"
>  #include "sf/dev/dev.h"
>  #include "sf/sf.h"
>  #include "lib/nv_param.h"
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> index 5ab37a88c260..6b63fc110e2d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> @@ -5,7 +5,11 @@
>  #include "mlx5_core.h"
>  
>  enum {
> +	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
> +	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
>  	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
> +
> +	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
>  };
>  
>  struct mlx5_ifc_configuration_item_type_class_global_bits {
> @@ -13,9 +17,18 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
>  	u8         parameter_index[0x18];
>  };
>  
> +struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
> +	u8         type_class[0x8];
> +	u8         pf_index[0x6];
> +	u8         pci_bus_index[0x8];
> +	u8         parameter_index[0xa];
> +};
> +
>  union mlx5_ifc_config_item_type_auto_bits {
>  	struct mlx5_ifc_configuration_item_type_class_global_bits
>  				configuration_item_type_class_global;
> +	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
> +				configuration_item_type_class_per_host_pf;
>  	u8 reserved_at_0[0x20];
>  };
>  
> @@ -45,6 +58,45 @@ struct mlx5_ifc_mnvda_reg_bits {
>  	u8         configuration_item_data[64][0x20];
>  };
>  
> +struct mlx5_ifc_nv_global_pci_conf_bits {
> +	u8         sriov_valid[0x1];
> +	u8         reserved_at_1[0x10];
> +	u8         per_pf_total_vf[0x1];
> +	u8         reserved_at_12[0xe];
> +
> +	u8         sriov_en[0x1];
> +	u8         reserved_at_21[0xf];
> +	u8         total_vfs[0x10];
> +
> +	u8         reserved_at_40[0x20];
> +};
> +
> +struct mlx5_ifc_nv_global_pci_cap_bits {
> +	u8         max_vfs_per_pf_valid[0x1];
> +	u8         reserved_at_1[0x13];
> +	u8         per_pf_total_vf_supported[0x1];
> +	u8         reserved_at_15[0xb];
> +
> +	u8         sriov_support[0x1];
> +	u8         reserved_at_21[0xf];
> +	u8         max_vfs_per_pf[0x10];
> +
> +	u8         reserved_at_40[0x60];
> +};
> +
> +struct mlx5_ifc_nv_pf_pci_conf_bits {
> +	u8         reserved_at_0[0x9];
> +	u8         pf_total_vf_en[0x1];
> +	u8         reserved_at_a[0x16];
> +
> +	u8         reserved_at_20[0x20];
> +
> +	u8         reserved_at_40[0x10];
> +	u8         total_vf[0x10];
> +
> +	u8         reserved_at_60[0x20];
> +};
> +
>  struct mlx5_ifc_nv_sw_offload_conf_bits {
>  	u8         ip_over_vxlan_port[0x10];
>  	u8         tunnel_ecn_copy_offload_disable[0x1];
> @@ -206,7 +258,139 @@ static int mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 i
>  	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>  }
>  
> +static int
> +mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
> +{
> +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
> +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
> +				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
> +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_conf);
> +
> +	return mlx5_nv_param_read(dev, mnvda, len);
> +}
> +
> +static int
> +mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev, void *mnvda, size_t len)
> +{
> +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
> +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
> +				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
> +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_cap);
> +
> +	return mlx5_nv_param_read(dev, mnvda, len);
> +}
> +
> +static int
> +mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
> +{
> +	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, type_class, 3);
> +	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, parameter_index,
> +				  MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF);
> +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_pf_pci_conf);
> +
> +	return mlx5_nv_param_read(dev, mnvda, len);
> +}
> +
> +static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
> +					 struct devlink_param_gset_ctx *ctx)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> +	void *data;
> +	int err;
> +
> +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
> +		ctx->val.vbool = false;
> +		return 0;
> +	}
> +
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
> +		ctx->val.vbool = MLX5_GET(nv_global_pci_conf, data, sriov_en);
> +		return 0;
> +	}
> +
> +	/* SRIOV is per PF */
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	ctx->val.vbool = MLX5_GET(nv_pf_pci_conf, data, pf_total_vf_en);
> +	return 0;
> +}
> +
> +static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
> +					 struct devlink_param_gset_ctx *ctx,
> +					 struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> +	bool per_pf_support;
> +	void *cap, *data;
> +	int err;
> +
> +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read global PCI capability");
> +		return err;
> +	}
> +
> +	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	per_pf_support = MLX5_GET(nv_global_pci_cap, cap, per_pf_total_vf_supported);
> +
> +	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to read global PCI configuration");
> +		return err;
> +	}
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
> +	MLX5_SET(nv_global_pci_conf, data, sriov_en, ctx->val.vbool);
> +	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
> +
> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to write global PCI configuration");
> +		return err;
> +	}
> +
> +	if (!per_pf_support)
> +		return 0;
> +
> +	/* SRIOV is per PF */
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to read per host PF configuration");
> +		return err;
> +	}
> +	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, ctx->val.vbool);
> +	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +}
> +
>  static const struct devlink_param mlx5_nv_param_devlink_params[] = {
> +	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> +			      mlx5_devlink_enable_sriov_get,
> +			      mlx5_devlink_enable_sriov_set, NULL),
>  	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
>  			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
>  			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> -- 
> 2.48.1
> 
> 


