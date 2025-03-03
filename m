Return-Path: <netdev+bounces-171202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105DEA4BEDE
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A8D161B92
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84121FDA6D;
	Mon,  3 Mar 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VjkIT1BI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E91FCFEF
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001769; cv=none; b=ZSYyJVphWJaty6w81yTOiQ2N/11BtBA21OSq0evNxxX/u2kPl7QOw/30FOMPvTWDyB70V3awuQzIhIQmyPH+Z/XbE9wYZZ6sZsRS6w91/RJMnA0QyHBt+7+GS2ZWKIb+NyhNatYbgYxKuDvLsVysVbtKK8xiGKv+9Mr3D3XRB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001769; c=relaxed/simple;
	bh=v/i/yAJZPSbkYheYcRkLCTkookUbJO9oGReVgLLmlxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/8wYkCfZafxXnlLULLOIsrHn56SMN7yYZq+o+LHM1WhkZMwZN/wClEr6fx837uOsyWUxnX8uaTf4LtRG62ne0co3oJJ3DVpyPmr6pk4Nl8WL3JEBtJvmG/78M+uEFPZ5WKnBdkNHrfbBve1ve1FpEc0nMaB6CjUxMG3fS96f/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VjkIT1BI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43995b907cfso27043205e9.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741001764; x=1741606564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYj+XMA2X0CCXrbw92wRouGeHLHtc5Wkez0sIulwOJw=;
        b=VjkIT1BIpP9qRt2ymyiHw4wbDPjD5ARj94cMXMEOA6oS4rEdznxlc3+67VEF6RnTwv
         NES1tEg00yGWydA8ZBIt8eeGzYlBK4XoywlFl27QLNKny3ik97Ws+MB+deitGKAN5Jfl
         kljBvtwnAQ1tvEcDVhqL/biT/UflZf/eNe0/xAM0HEx33yi69DK4i68zk90FTayzADsP
         cTaXtQgjhm/P6Zz66g1ITnLWOLgUaFnxFO7AUw1r3ADKM2rNzCLPw/RlT50/v5E1PCzg
         LURpXEN/MQByiHUz4UX0Au53/Teb8y5guw5Y0o6Aa6M+y+2tCHDyDPo1w0IHJraO8y0I
         esFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001764; x=1741606564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYj+XMA2X0CCXrbw92wRouGeHLHtc5Wkez0sIulwOJw=;
        b=sy1MOhxsXfeQhIX75Z+m2Q/1i+I5UlzNyAthk2grLUclWEIFYVgDqV2452ek14v1JJ
         D/OxGGFq8ze41xSD5ccTeETopEI1Qn1Mft6cOsoYkhgtlxit/pbYrwKiQOH6ZknID830
         zhalmkx3AHT2C0GFI4eYfR8z1LBWJ3v1nxI91LS46HsgYd0ynuuJvjjRtiSk8U+gLtB5
         SC1crxt/g6ug79ivPb07j2tFmWZV2HpBvP6Si8vACbRosYsJmsVYRgf9kH9aQ/XslRbp
         EMdgmap/lzI0LGpKLM30HK7IPXYR24Iw5x4PmhNVM/DyPvUhh+2Ouh4MfN67WKHgpFX9
         gtow==
X-Forwarded-Encrypted: i=1; AJvYcCUEeKmvf47Arnw3cb6lnRr3eHgWr9xn6cX9FcqYkFXWEDcB8u0nFhjLpqPbfZoq+f1GpnOwje0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AMdkjWHpwhmiPboq0mLZ4V1KXx2v7UU9hBozosiXz/E5ZFbK
	eAzj2ABxXVR2rUJrtlZdn4MA/Nc2fx8O7kXCTXWkdlpTPLKy5I1AnImj5014waI=
X-Gm-Gg: ASbGncs24NA+bOAdhQJJj4fwvXqBFpjCOCftriyIRJ0mKN9TkF3vmNnEB1nndLJr76d
	Vecqyg3pW77OvqurnAcF6aG+Ds4ihrVUtXj2qPNyYHmSXSrA58Qt+UByGdiOYeo/C2cCkE085Bg
	UdB69F9UsSaG1kFhlK/jOAbNisdH1tHEJLD3bOZWZ6rpgjX2TyDqLuvwN3oukLV9JT1rn3ubRH/
	xY89BKP0sC/4+4hSow8PIDU4e7gJA3+tKohqKnP/xUYp96y5yV4NEePhnh7vjtGTxnnce2LLiZU
	pX0t/CGJpPYsquItLTpX7JpAPHB2uPROK9R4uI4/z48o1uNue6uMjKCXmD71vzrDrFQQZkHW
X-Google-Smtp-Source: AGHT+IFbmonfp95mk0pK8BlmDWKQuBZywxV3tva2JKvY2LBz/7SePo0cYRULl1ywb/r3fuJF7yYosQ==
X-Received: by 2002:a05:600c:1d20:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-43baec9c2c1mr71347305e9.31.1741001763597;
        Mon, 03 Mar 2025 03:36:03 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b0dsm183952365e9.13.2025.03.03.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:36:03 -0800 (PST)
Date: Mon, 3 Mar 2025 12:35:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov
 parameter
Message-ID: <fnr2d2i7paakjime2mnqhz4u6pa5zfpmog4jiymuopctjhe6zk@cyn54xvkrtmr>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-5-saeed@kernel.org>
 <uovifydwz7vbhbjzy4g4x4lkrq7htepoktekqidqxytkqi6ra6@2xfhgel6h7sz>
 <Z8H-JyRRkknKj0Di@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H-JyRRkknKj0Di@x130>

Fri, Feb 28, 2025 at 07:19:19PM +0100, saeedm@nvidia.com wrote:
>On 28 Feb 13:46, Jiri Pirko wrote:
>> Fri, Feb 28, 2025 at 03:12:17AM +0100, saeed@kernel.org wrote:
>> > From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>> > 
>> > Example usage:
>> >  devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>> >  devlink dev reload pci/0000:01:00.0 action fw_activate
>> >  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>> >  echo 1 >/sys/bus/pci/rescan
>> >  grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
>> > 
>> > Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> > ---
>> > Documentation/networking/devlink/mlx5.rst     |  14 +-
>> > .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
>> > .../mellanox/mlx5/core/lib/nv_param.c         | 184 ++++++++++++++++++
>> > 3 files changed, 196 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>> > index 417e5cdcd35d..587e0200c1cd 100644
>> > --- a/Documentation/networking/devlink/mlx5.rst
>> > +++ b/Documentation/networking/devlink/mlx5.rst
>> > @@ -15,23 +15,31 @@ Parameters
>> >    * - Name
>> >      - Mode
>> >      - Validation
>> > +     - Notes
>> >    * - ``enable_roce``
>> >      - driverinit
>> > -     - Type: Boolean
>> > -
>> > -       If the device supports RoCE disablement, RoCE enablement state controls
>> > +     - Boolean
>> > +     - If the device supports RoCE disablement, RoCE enablement state controls
>> >        device support for RoCE capability. Otherwise, the control occurs in the
>> >        driver stack. When RoCE is disabled at the driver level, only raw
>> >        ethernet QPs are supported.
>> >    * - ``io_eq_size``
>> >      - driverinit
>> >      - The range is between 64 and 4096.
>> > +     -
>> >    * - ``event_eq_size``
>> >      - driverinit
>> >      - The range is between 64 and 4096.
>> > +     -
>> >    * - ``max_macs``
>> >      - driverinit
>> >      - The range is between 1 and 2^31. Only power of 2 values are supported.
>> > +     -
>> > +   * - ``enable_sriov``
>> > +     - permanent
>> > +     - Boolean
>> > +     - Applies to each physical function (PF) independently, if the device
>> > +       supports it. Otherwise, it applies symmetrically to all PFs.
>> > 
>> > The ``mlx5`` driver also implements the following driver-specific
>> > parameters.
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> > index 1f764ae4f4aa..7a702d84f19a 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> > @@ -8,6 +8,7 @@
>> > #include "fs_core.h"
>> > #include "eswitch.h"
>> > #include "esw/qos.h"
>> > +#include "lib/nv_param.h"
>> > #include "sf/dev/dev.h"
>> > #include "sf/sf.h"
>> > #include "lib/nv_param.h"
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> > index 5ab37a88c260..6b63fc110e2d 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> > @@ -5,7 +5,11 @@
>> > #include "mlx5_core.h"
>> > 
>> > enum {
>> > +	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
>> > +	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
>> > 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
>> > +
>> > +	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
>> > };
>> > 
>> > struct mlx5_ifc_configuration_item_type_class_global_bits {
>> > @@ -13,9 +17,18 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
>> > 	u8         parameter_index[0x18];
>> > };
>> > 
>> > +struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
>> > +	u8         type_class[0x8];
>> > +	u8         pf_index[0x6];
>> > +	u8         pci_bus_index[0x8];
>> > +	u8         parameter_index[0xa];
>> > +};
>> > +
>> > union mlx5_ifc_config_item_type_auto_bits {
>> > 	struct mlx5_ifc_configuration_item_type_class_global_bits
>> > 				configuration_item_type_class_global;
>> > +	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
>> > +				configuration_item_type_class_per_host_pf;
>> > 	u8 reserved_at_0[0x20];
>> > };
>> > 
>> > @@ -45,6 +58,45 @@ struct mlx5_ifc_mnvda_reg_bits {
>> > 	u8         configuration_item_data[64][0x20];
>> > };
>> > 
>> > +struct mlx5_ifc_nv_global_pci_conf_bits {
>> > +	u8         sriov_valid[0x1];
>> > +	u8         reserved_at_1[0x10];
>> > +	u8         per_pf_total_vf[0x1];
>> > +	u8         reserved_at_12[0xe];
>> > +
>> > +	u8         sriov_en[0x1];
>> > +	u8         reserved_at_21[0xf];
>> > +	u8         total_vfs[0x10];
>> > +
>> > +	u8         reserved_at_40[0x20];
>> > +};
>> > +
>> > +struct mlx5_ifc_nv_global_pci_cap_bits {
>> > +	u8         max_vfs_per_pf_valid[0x1];
>> > +	u8         reserved_at_1[0x13];
>> > +	u8         per_pf_total_vf_supported[0x1];
>> > +	u8         reserved_at_15[0xb];
>> > +
>> > +	u8         sriov_support[0x1];
>> > +	u8         reserved_at_21[0xf];
>> > +	u8         max_vfs_per_pf[0x10];
>> > +
>> > +	u8         reserved_at_40[0x60];
>> > +};
>> > +
>> > +struct mlx5_ifc_nv_pf_pci_conf_bits {
>> > +	u8         reserved_at_0[0x9];
>> > +	u8         pf_total_vf_en[0x1];
>> > +	u8         reserved_at_a[0x16];
>> > +
>> > +	u8         reserved_at_20[0x20];
>> > +
>> > +	u8         reserved_at_40[0x10];
>> > +	u8         total_vf[0x10];
>> > +
>> > +	u8         reserved_at_60[0x20];
>> > +};
>> > +
>> > struct mlx5_ifc_nv_sw_offload_conf_bits {
>> > 	u8         ip_over_vxlan_port[0x10];
>> > 	u8         tunnel_ecn_copy_offload_disable[0x1];
>> > @@ -206,7 +258,139 @@ static int mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 i
>> > 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> > }
>> > 
>> > +static int
>> > +mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>> > +{
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>> > +				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
>> > +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_conf);
>> > +
>> > +	return mlx5_nv_param_read(dev, mnvda, len);
>> > +}
>> > +
>> > +static int
>> > +mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>> > +{
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>> > +				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
>> > +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_cap);
>> > +
>> > +	return mlx5_nv_param_read(dev, mnvda, len);
>> > +}
>> > +
>> > +static int
>> > +mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>> > +{
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, type_class, 3);
>> > +	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, parameter_index,
>> > +				  MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF);
>> > +	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_pf_pci_conf);
>> > +
>> > +	return mlx5_nv_param_read(dev, mnvda, len);
>> > +}
>> > +
>> > +static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
>> > +					 struct devlink_param_gset_ctx *ctx)
>> > +{
>> > +	struct mlx5_core_dev *dev = devlink_priv(devlink);
>> > +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>> > +	void *data;
>> > +	int err;
>> > +
>> > +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> > +	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
>> > +		ctx->val.vbool = false;
>> > +		return 0;
>> > +	}
>> > +
>> > +	memset(mnvda, 0, sizeof(mnvda));
>> > +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> > +	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
>> > +		ctx->val.vbool = MLX5_GET(nv_global_pci_conf, data, sriov_en);
>> > +		return 0;
>> > +	}
>> > +
>> > +	/* SRIOV is per PF */
>> > +	memset(mnvda, 0, sizeof(mnvda));
>> > +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> > +	ctx->val.vbool = MLX5_GET(nv_pf_pci_conf, data, pf_total_vf_en);
>> > +	return 0;
>> > +}
>> > +
>> > +static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
>> > +					 struct devlink_param_gset_ctx *ctx,
>> > +					 struct netlink_ext_ack *extack)
>> > +{
>> > +	struct mlx5_core_dev *dev = devlink_priv(devlink);
>> > +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>> > +	bool per_pf_support;
>> > +	void *cap, *data;
>> > +	int err;
>> > +
>> > +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>> > +	if (err) {
>> > +		NL_SET_ERR_MSG_MOD(extack, "Failed to read global PCI capability");
>> > +		return err;
>> > +	}
>> > +
>> > +	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> > +	per_pf_support = MLX5_GET(nv_global_pci_cap, cap, per_pf_total_vf_supported);
>> > +
>> > +	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
>> > +		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
>> > +		return -EOPNOTSUPP;
>> > +	}
>> > +
>> > +	memset(mnvda, 0, sizeof(mnvda));
>> > +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>> > +	if (err) {
>> > +		NL_SET_ERR_MSG_MOD(extack, "Unable to read global PCI configuration");
>> > +		return err;
>> > +	}
>> > +
>> > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> > +	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
>> > +	MLX5_SET(nv_global_pci_conf, data, sriov_en, ctx->val.vbool);
>> > +	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
>> > +
>> > +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> > +	if (err) {
>> > +		NL_SET_ERR_MSG_MOD(extack, "Unable to write global PCI configuration");
>> > +		return err;
>> > +	}
>> > +
>> > +	if (!per_pf_support)
>> 
>> 
>> Hmm, given the discussion we have in parallel about some shared-PF
>> devlink instance, perhaps it would be good idea to allow only per-pf
>> configuration here for now and let the "global" per-device configuration
>> knob to be attached on the shared-PF devlink, when/if it lands. What do
>> you think?
>
>Do we have an RFC? can you point me to it?

https://lore.kernel.org/all/20250219164410.35665-2-przemyslaw.kitszel@intel.com/


>
>I am just worried about the conflicts between per-pf and global configs
>this will introduce, currently it is driver best effort, after that we
>might want to pick one direction, global vs per-pf if it will be separate
>knobs, and we probably will go with per-pf. Most CX devices support both
>modes and it is up to the driver to chose. So why do both global and
>per-pf when you can almost always do per-pf?

I was thinking that is device supports per-pf, only per-pf knob will be
present. And if not, only "global" know will be present on the shared
devlink instance.

Okay. So let's implement per-pf only now. And if the global is needed in
the future for older devices and we'll have a devlink instance to hang
in on, let's add it later. Makes sense?

>
>> 
>> 
>> > +		return 0;
>> > +
>> > +	/* SRIOV is per PF */
>> > +	memset(mnvda, 0, sizeof(mnvda));
>> > +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>> > +	if (err) {
>> > +		NL_SET_ERR_MSG_MOD(extack, "Unable to read per host PF configuration");
>> > +		return err;
>> > +	}
>> > +	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, ctx->val.vbool);
>> > +	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> > +}
>> > +
>> > static const struct devlink_param mlx5_nv_param_devlink_params[] = {
>> > +	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>> > +			      mlx5_devlink_enable_sriov_get,
>> > +			      mlx5_devlink_enable_sriov_set, NULL),
>> > 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
>> > 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
>> > 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>> > --
>> > 2.48.1
>> > 
>> > 

