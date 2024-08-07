Return-Path: <netdev+bounces-116329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACB94A115
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F3B24D88
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FACE191491;
	Wed,  7 Aug 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pRHVjE/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBF1917F1
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013404; cv=none; b=WH9G5ah/5M8TUpOKbwImbewKCMegly/yATyWzT/U/n9xkrWU+6bltYbH68Dx/p/MiuvC4V9gyrFtxpW/M1Ko4RNtoQLvN+bRF68uLbX9HfG4ujGJDzcH++D7JvY6EGb84ECmAN6M5rWiC0o3M/M53eNQ8EDHR4jurz8BZ7NnZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013404; c=relaxed/simple;
	bh=5lmQcWteCMgjNQlMg2CBCU+7l5FYCBnyTmuxDPraC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJbTf5ugkz3fKnKPAKiA5o0yV52cVMOXJXTiUtFdnMWOEmykyR76T2xqi9u4ZU+L3gPGVtGkaUXOu/h6vAgWNXCD3JG/i3gB6uslVgwv+AEqsLPCDrk3hOQPviGGEvj4zQ6uFgG8U1GYx0je5j1W8v2PhjzTA6ksO7DWYh6bBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pRHVjE/Y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aac70e30dso157524666b.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723013400; x=1723618200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u3+U8VCfwIWrDy9fKK7ct6i5gkyDHdJVJEd7/7bzkA=;
        b=pRHVjE/YiILjH4ixYogBzxHqstGouPlM56/qV1Pu0f6Ftx9zU5U7Bic9UGnJryVW+p
         BU0kHSASGinLzzNpyyXtV29nId9PNazaflI8dAFLxOzWdKef3VamlMCQ2q4Rrjp0JE3n
         V3stnHlnJXzbB2GBHsWnxkkisZTxzvqZBM/o3V1oxzgw7hDOcKRcV3rgFVTQq4Esyy5h
         x2C/X9tv7HlItb6sEqMwYzjoTtrp94mqhq5GRS17c1NdcJTlj/K14vKWAoQNW8F9qhuZ
         OuK/1d7pYZ4Zw/UMfnEJbfx2XeO+OwnV6lDwNSfezKgqAOMR/W7oDV9IOA/glFS6YwtX
         GaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013400; x=1723618200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u3+U8VCfwIWrDy9fKK7ct6i5gkyDHdJVJEd7/7bzkA=;
        b=E8H/iLvcHFFLpCUEzswOm1PuOVi8g59FU0nBQubQIB9crF1sNNEHLLJPpuZ7BAVNL7
         eTMqNz5JegeQ+KRtkZIlxhRCKqFGJJ5Mv58EkhSfU/nEAQVnJcoQk3/SWP1GgBIp+Nf1
         aTUeGWr0EeUZ7Mam8qJxqMScGD/MNyunwDtwOuMtKeRk4Vu1fPlT4ixxMFqYrPD9yCAY
         ninNK1a128UWInR+VPVGJTSiNsDbkcA869fOluTGKaVVFgh9mWwEMJtmJG2YfsBO08JB
         JdHA8M0GumEJ1rqIl5bO9U5uP2aAhAkMJzOQWAmPzMAAIshHlUtVOwuRR7Ctb4/+0V+V
         rVyQ==
X-Gm-Message-State: AOJu0Yz6L6y2AeV4hLUc1U23gXgESmmZjkCLc5yQe6Yonsgv+TgJHgpW
	9DrcW0SGHNO58dM+2PmJOTLiqmN1D4OpuH2xDH9WmVVtPZmD6yzyxrBMhSNVFHY=
X-Google-Smtp-Source: AGHT+IFXdQa164ZMTbTytRtpuFmtP3MxZI7fgQm2hImb6WkytmUiYnuDOTWHKkWCMgwBhV6/6ggW7g==
X-Received: by 2002:a17:906:bc28:b0:a7a:a7b8:adae with SMTP id a640c23a62f3a-a7dc4fda099mr1232313866b.4.1723013399341;
        Tue, 06 Aug 2024 23:49:59 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b6casm610207966b.51.2024.08.06.23.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:49:58 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:49:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <ZrMZFWvo20hn49He@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806143307.14839-5-przemyslaw.kitszel@intel.com>

Tue, Aug 06, 2024 at 04:33:06PM CEST, przemyslaw.kitszel@intel.com wrote:
>Extend devlink resource by flex array to store drivers priv data, in
>current usages it just replaces occupation getter's priv callback pointer.
>Coupling lifetime of the resource and its getters metadata (don't confuse
>with simple pointer to PF) is generally a good idea, and makes driver code
>nicer.
>
>Next commit will show how to makes use of it to combine related occ
>getters into one - "mlxsw: spectrum_kvdl: combine devlink resource
>occupation getters".
>
>Note that we pass resource size at both resource register and occupation
>getter register times, to avoid situation when developer forgets to
>extend the former call when changing the latter one.
>
>Note that it's compile tested only, I will exercise new interface also by
>Intel's ice driver later.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
> include/net/devlink.h                         |  5 ++--
> .../ethernet/mellanox/mlx5/core/sf/hw_table.c |  5 ++--
> drivers/net/ethernet/mellanox/mlxsw/core.c    |  5 ++--
> .../net/ethernet/mellanox/mlxsw/spectrum.c    | 18 ++++++-------
> .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 14 +++++------
> .../ethernet/mellanox/mlxsw/spectrum_cnt.c    |  9 ++++---
> .../mellanox/mlxsw/spectrum_policer.c         |  6 ++---
> .../mellanox/mlxsw/spectrum_port_range.c      |  2 +-
> .../ethernet/mellanox/mlxsw/spectrum_router.c |  4 +--
> .../ethernet/mellanox/mlxsw/spectrum_span.c   |  3 ++-
> drivers/net/netdevsim/dev.c                   | 14 +++++------
> drivers/net/netdevsim/fib.c                   | 10 ++++----
> net/devlink/resource.c                        | 25 ++++++++++++-------
> net/dsa/devlink.c                             |  4 +--
> 14 files changed, 68 insertions(+), 56 deletions(-)
>
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index fbb9a2668e24..48e009c7b90c 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -1778,7 +1778,8 @@ int devl_resource_register(struct devlink *devlink,
> 			   u64 resource_size,
> 			   u64 resource_id,
> 			   u64 parent_resource_id,
>-			   const struct devlink_resource_size_params *size_params);
>+			   const struct devlink_resource_size_params *size_params,
>+			   size_t priv_data_size);
> void devl_resources_unregister(struct devlink *devlink);
> void devlink_resources_unregister(struct devlink *devlink);
> int devl_resource_size_get(struct devlink *devlink,
>@@ -1790,7 +1791,7 @@ int devl_dpipe_table_resource_set(struct devlink *devlink,
> void devl_resource_occ_get_register(struct devlink *devlink,
> 				    u64 resource_id,
> 				    devlink_resource_occ_get_t *occ_get,
>-				    void *occ_get_priv);
>+				    void *occ_get_priv, size_t occ_priv_size);
> void devl_resource_occ_get_unregister(struct devlink *devlink,
> 				      u64 resource_id);
> int devl_params_register(struct devlink *devlink,
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
>index 1f613320fe07..f8b574687a41 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
>@@ -259,15 +259,16 @@ static int mlx5_sf_hw_table_res_register(struct mlx5_core_dev *dev, u16 max_fn,
> 	devlink_resource_size_params_init(&size_params, max_fn, max_fn, 1,
> 					  DEVLINK_RESOURCE_UNIT_ENTRY);
> 	err = devl_resource_register(devlink, "max_local_SFs", max_fn, MLX5_DL_RES_MAX_LOCAL_SFS,
>-				     DEVLINK_RESOURCE_ID_PARENT_TOP, &size_params);
>+				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
> 	devlink_resource_size_params_init(&size_params, max_ext_fn, max_ext_fn, 1,
> 					  DEVLINK_RESOURCE_UNIT_ENTRY);
> 	return devl_resource_register(devlink, "max_external_SFs", max_ext_fn,
> 				      MLX5_DL_RES_MAX_EXTERNAL_SFS, DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &size_params);
>+				      &size_params, sizeof(void *));
> }
> 
> int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
>index 4a79c0d7e7ad..81d14ccfb949 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
>@@ -134,7 +134,7 @@ static int mlxsw_core_resources_ports_register(struct mlxsw_core *mlxsw_core)
> 				      DEVLINK_RESOURCE_GENERIC_NAME_PORTS,
> 				      max_ports, MLXSW_CORE_RESOURCE_PORTS,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &ports_num_params);
>+				      &ports_num_params, sizeof(void *));
> }
> 
> static int mlxsw_ports_init(struct mlxsw_core *mlxsw_core, bool reload)
>@@ -161,7 +161,8 @@ static int mlxsw_ports_init(struct mlxsw_core *mlxsw_core, bool reload)
> 	}
> 	atomic_set(&mlxsw_core->active_ports_count, 0);
> 	devl_resource_occ_get_register(devlink, MLXSW_CORE_RESOURCE_PORTS,
>-				       mlxsw_ports_occ_get, mlxsw_core);
>+				       mlxsw_ports_occ_get, &mlxsw_core,
>+				       sizeof(mlxsw_core));
> 
> 	return 0;
> 
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>index f064789f3240..2730ae3d8fe6 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>@@ -3660,16 +3660,16 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
> 	err = devl_resource_register(devlink, MLXSW_SP_RESOURCE_NAME_KVD,
> 				     kvd_size, MLXSW_SP_RESOURCE_KVD,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &kvd_size_params);
>+				     &kvd_size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
> 	linear_size = profile->kvd_linear_size;
> 	err = devl_resource_register(devlink, MLXSW_SP_RESOURCE_NAME_KVD_LINEAR,
> 				     linear_size,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
> 				     MLXSW_SP_RESOURCE_KVD,
>-				     &linear_size_params);
>+				     &linear_size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -3686,16 +3686,16 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
> 				     double_size,
> 				     MLXSW_SP_RESOURCE_KVD_HASH_DOUBLE,
> 				     MLXSW_SP_RESOURCE_KVD,
>-				     &hash_double_size_params);
>+				     &hash_double_size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
> 	single_size = kvd_size - double_size - linear_size;
> 	err = devl_resource_register(devlink, MLXSW_SP_RESOURCE_NAME_KVD_HASH_SINGLE,
> 				     single_size,
> 				     MLXSW_SP_RESOURCE_KVD_HASH_SINGLE,
> 				     MLXSW_SP_RESOURCE_KVD,
>-				     &hash_single_size_params);
>+				     &hash_single_size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -3719,7 +3719,7 @@ static int mlxsw_sp2_resources_kvd_register(struct mlxsw_core *mlxsw_core)
> 	return devl_resource_register(devlink, MLXSW_SP_RESOURCE_NAME_KVD,
> 				      kvd_size, MLXSW_SP_RESOURCE_KVD,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &kvd_size_params);
>+				      &kvd_size_params, sizeof(void *));
> }
> 
> static int mlxsw_sp_resources_span_register(struct mlxsw_core *mlxsw_core)
>@@ -3738,7 +3738,7 @@ static int mlxsw_sp_resources_span_register(struct mlxsw_core *mlxsw_core)
> 	return devl_resource_register(devlink, MLXSW_SP_RESOURCE_NAME_SPAN,
> 				      max_span, MLXSW_SP_RESOURCE_SPAN,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &span_size_params);
>+				      &span_size_params, sizeof(void *));
> }
> 
> static int
>@@ -3762,7 +3762,7 @@ mlxsw_sp_resources_rif_mac_profile_register(struct mlxsw_core *mlxsw_core)
> 				      max_rif_mac_profiles,
> 				      MLXSW_SP_RESOURCE_RIF_MAC_PROFILES,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &size_params);
>+				      &size_params, sizeof(void *));
> }
> 
> static int mlxsw_sp_resources_rifs_register(struct mlxsw_core *mlxsw_core)
>@@ -3781,7 +3781,7 @@ static int mlxsw_sp_resources_rifs_register(struct mlxsw_core *mlxsw_core)
> 	return devl_resource_register(devlink, "rifs", max_rifs,
> 				      MLXSW_SP_RESOURCE_RIFS,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &size_params);
>+				      &size_params, sizeof(void *));
> }
> 
> static int
>@@ -3801,7 +3801,7 @@ mlxsw_sp_resources_port_range_register(struct mlxsw_core *mlxsw_core)
> 	return devl_resource_register(devlink, "port_range_registers", max,
> 				      MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS,
> 				      DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				      &size_params);
>+				      &size_params, sizeof(void *));
> }
> 
> static int mlxsw_sp1_resources_register(struct mlxsw_core *mlxsw_core)
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>index 1e3fc989393c..ee5f12746371 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>@@ -341,19 +341,19 @@ static int mlxsw_sp1_kvdl_init(struct mlxsw_sp *mlxsw_sp, void *priv)
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR,
> 				       mlxsw_sp1_kvdl_occ_get,
>-				       kvdl);
>+				       &kvdl, sizeof(kvdl));
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
> 				       mlxsw_sp1_kvdl_single_occ_get,
>-				       kvdl);
>+				       &kvdl, sizeof(kvdl));
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
> 				       mlxsw_sp1_kvdl_chunks_occ_get,
>-				       kvdl);
>+				       &kvdl, sizeof(kvdl));
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
> 				       mlxsw_sp1_kvdl_large_chunks_occ_get,
>-				       kvdl);
>+				       &kvdl, sizeof(kvdl));
> 	return 0;
> }
> 
>@@ -400,7 +400,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_SINGLE_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -411,7 +411,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_CHUNKS_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -422,6 +422,6 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_LARGE_CHUNKS_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	return err;
> }
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
>index 50e591420bd9..bf6a9623bccb 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
>@@ -76,7 +76,7 @@ static int mlxsw_sp_counter_sub_pools_init(struct mlxsw_sp *mlxsw_sp)
> 		devl_resource_occ_get_register(devlink,
> 					       sub_pool->resource_id,
> 					       mlxsw_sp_counter_sub_pool_occ_get,
>-					       sub_pool);
>+					       &sub_pool, sizeof(sub_pool));
> 
> 		sub_pool->base_index = base_index;
> 		base_index += sub_pool->size;
>@@ -140,7 +140,8 @@ int mlxsw_sp_counter_pool_init(struct mlxsw_sp *mlxsw_sp)
> 	if (err)
> 		goto err_pool_resource_size_get;
> 	devl_resource_occ_get_register(devlink, MLXSW_SP_RESOURCE_COUNTERS,
>-				       mlxsw_sp_counter_pool_occ_get, pool);
>+				       mlxsw_sp_counter_pool_occ_get, &pool,
>+				       sizeof(pool));
> 
> 	pool->usage = bitmap_zalloc(pool->pool_size, GFP_KERNEL);
> 	if (!pool->usage) {
>@@ -267,7 +268,7 @@ int mlxsw_sp_counter_resources_register(struct mlxsw_core *mlxsw_core)
> 				     pool_size,
> 				     MLXSW_SP_RESOURCE_COUNTERS,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -292,7 +293,7 @@ int mlxsw_sp_counter_resources_register(struct mlxsw_core *mlxsw_core)
> 					     sub_pool_size,
> 					     sub_pool->resource_id,
> 					     MLXSW_SP_RESOURCE_COUNTERS,
>-					     &size_params);
>+					     &size_params, sizeof(void *));
> 		if (err)
> 			return err;
> 		total_bank_config += sub_pool->bank_count;
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
>index 22ebb207ce4d..e3b3d998d60f 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
>@@ -97,7 +97,7 @@ mlxsw_sp_policer_single_rate_family_init(struct mlxsw_sp_policer_family *family)
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_SINGLE_RATE_POLICERS,
> 				       mlxsw_sp_policer_single_rate_occ_get,
>-				       family);
>+				       &family, sizeof(family));
> 
> 	return 0;
> }
>@@ -423,7 +423,7 @@ int mlxsw_sp_policer_resources_register(struct mlxsw_core *mlxsw_core)
> 				     global_policers,
> 				     MLXSW_SP_RESOURCE_GLOBAL_POLICERS,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>@@ -434,7 +434,7 @@ int mlxsw_sp_policer_resources_register(struct mlxsw_core *mlxsw_core)
> 				     single_rate_policers,
> 				     MLXSW_SP_RESOURCE_SINGLE_RATE_POLICERS,
> 				     MLXSW_SP_RESOURCE_GLOBAL_POLICERS,
>-				     &size_params);
>+				     &size_params, sizeof(void *));
> 	if (err)
> 		return err;
> 
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
>index 2d193de12be6..52271eb93797 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
>@@ -183,7 +183,7 @@ int mlxsw_sp_port_range_init(struct mlxsw_sp *mlxsw_sp)
> 	devl_resource_occ_get_register(priv_to_devlink(core),
> 				       MLXSW_SP_RESOURCE_PORT_RANGE_REGISTERS,
> 				       mlxsw_sp_port_range_reg_occ_get,
>-				       pr_core);
>+				       &pr_core, sizeof(pr_core));
> 
> 	return 0;
> }
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>index 800dfb64ec83..52eeea33a00f 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>@@ -11132,11 +11132,11 @@ static int mlxsw_sp_rifs_init(struct mlxsw_sp *mlxsw_sp)
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_RIF_MAC_PROFILES,
> 				       mlxsw_sp_rif_mac_profiles_occ_get,
>-				       mlxsw_sp);
>+				       &mlxsw_sp, sizeof(mlxsw_sp));
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_RIFS,
> 				       mlxsw_sp_rifs_occ_get,
>-				       mlxsw_sp);
>+				       &mlxsw_sp, sizeof(mlxsw_sp));
> 
> 	return 0;
> 
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>index 4b5fd71c897d..2d6a0ad06f19 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
>@@ -107,7 +107,8 @@ int mlxsw_sp_span_init(struct mlxsw_sp *mlxsw_sp)
> 		goto err_init;
> 
> 	devl_resource_occ_get_register(devlink, MLXSW_SP_RESOURCE_SPAN,
>-				       mlxsw_sp_span_occ_get, mlxsw_sp);
>+				       mlxsw_sp_span_occ_get, &mlxsw_sp,
>+				       sizeof(mlxsw_sp));
> 	INIT_WORK(&span->work, mlxsw_sp_span_respin_work);
> 
> 	return 0;
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index 92a7a36b93ac..707be92dbc65 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -439,59 +439,59 @@ static int nsim_dev_resources_register(struct devlink *devlink)
> 	err = devl_resource_register(devlink, "IPv4", (u64)-1,
> 				     NSIM_RESOURCE_IPV4,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &params);
>+				     &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv4 top resource\n");
> 		goto err_out;
> 	}
> 
> 	err = devl_resource_register(devlink, "fib", (u64)-1,
> 				     NSIM_RESOURCE_IPV4_FIB,
>-				     NSIM_RESOURCE_IPV4, &params);
>+				     NSIM_RESOURCE_IPV4, &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv4 FIB resource\n");
> 		goto err_out;
> 	}
> 
> 	err = devl_resource_register(devlink, "fib-rules", (u64)-1,
> 				     NSIM_RESOURCE_IPV4_FIB_RULES,
>-				     NSIM_RESOURCE_IPV4, &params);
>+				     NSIM_RESOURCE_IPV4, &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv4 FIB rules resource\n");
> 		goto err_out;
> 	}
> 
> 	/* Resources for IPv6 */
> 	err = devl_resource_register(devlink, "IPv6", (u64)-1,
> 				     NSIM_RESOURCE_IPV6,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &params);
>+				     &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv6 top resource\n");
> 		goto err_out;
> 	}
> 
> 	err = devl_resource_register(devlink, "fib", (u64)-1,
> 				     NSIM_RESOURCE_IPV6_FIB,
>-				     NSIM_RESOURCE_IPV6, &params);
>+				     NSIM_RESOURCE_IPV6, &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv6 FIB resource\n");
> 		goto err_out;
> 	}
> 
> 	err = devl_resource_register(devlink, "fib-rules", (u64)-1,
> 				     NSIM_RESOURCE_IPV6_FIB_RULES,
>-				     NSIM_RESOURCE_IPV6, &params);
>+				     NSIM_RESOURCE_IPV6, &params, 0);
> 	if (err) {
> 		pr_err("Failed to register IPv6 FIB rules resource\n");
> 		goto err_out;
> 	}
> 
> 	/* Resources for nexthops */
> 	err = devl_resource_register(devlink, "nexthops", (u64)-1,
> 				     NSIM_RESOURCE_NEXTHOPS,
> 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
>-				     &params);
>+				     &params, 0);
> 	if (err) {
> 		pr_err("Failed to register NEXTHOPS resource\n");
> 		goto err_out;
>diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
>index a1f91ff8ec56..799e75cef13a 100644
>--- a/drivers/net/netdevsim/fib.c
>+++ b/drivers/net/netdevsim/fib.c
>@@ -1602,23 +1602,23 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
> 	devl_resource_occ_get_register(devlink,
> 				       NSIM_RESOURCE_IPV4_FIB,
> 				       nsim_fib_ipv4_resource_occ_get,
>-				       data);
>+				       &data, sizeof(data));
> 	devl_resource_occ_get_register(devlink,
> 				       NSIM_RESOURCE_IPV4_FIB_RULES,
> 				       nsim_fib_ipv4_rules_res_occ_get,
>-				       data);
>+				       &data, sizeof(data));
> 	devl_resource_occ_get_register(devlink,
> 				       NSIM_RESOURCE_IPV6_FIB,
> 				       nsim_fib_ipv6_resource_occ_get,
>-				       data);
>+				       &data, sizeof(data));
> 	devl_resource_occ_get_register(devlink,
> 				       NSIM_RESOURCE_IPV6_FIB_RULES,
> 				       nsim_fib_ipv6_rules_res_occ_get,
>-				       data);
>+				       &data, sizeof(data));
> 	devl_resource_occ_get_register(devlink,
> 				       NSIM_RESOURCE_NEXTHOPS,
> 				       nsim_fib_nexthops_res_occ_get,
>-				       data);
>+				       &data, sizeof(data));
> 	return data;
> 
> err_nexthop_nb_unregister:
>diff --git a/net/devlink/resource.c b/net/devlink/resource.c
>index 15efa9f49461..71feaa963ebe 100644
>--- a/net/devlink/resource.c
>+++ b/net/devlink/resource.c
>@@ -19,7 +19,8 @@
>  * @list: parent list
>  * @resource_list: list of child resources
>  * @occ_get: occupancy getter callback
>- * @occ_get_priv: occupancy getter callback priv
>+ * @priv_size: @priv data size
>+ * @priv: priv data allocated for the driver, passed to occupancy callbacks
>  */
> struct devlink_resource {
> 	const char *name;
>@@ -32,7 +33,8 @@ struct devlink_resource {
> 	struct list_head list;
> 	struct list_head resource_list;
> 	devlink_resource_occ_get_t *occ_get;
>-	void *occ_get_priv;
>+	size_t priv_size;
>+	u8 priv[] __counted_by(priv_size);
> };
> 
> static struct devlink_resource *
>@@ -158,7 +160,7 @@ static int devlink_resource_occ_put(struct devlink_resource *resource,
> 	if (!resource->occ_get)
> 		return 0;
> 	return nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_OCC,
>-				 resource->occ_get(resource->occ_get_priv),
>+				 resource->occ_get(resource->priv),
> 				 DEVLINK_ATTR_PAD);
> }
> 
>@@ -326,6 +328,7 @@ int devlink_resources_validate(struct devlink *devlink,
>  * @resource_id: resource's id
>  * @parent_resource_id: resource's parent id
>  * @size_params: size parameters
>+ * @priv_data_size: sizeof of priv data member of the resource
>  *
>  * Generic resources should reuse the same names across drivers.
>  * Please see the generic resources list at:
>@@ -336,7 +339,8 @@ int devl_resource_register(struct devlink *devlink,
> 			   u64 resource_size,
> 			   u64 resource_id,
> 			   u64 parent_resource_id,
>-			   const struct devlink_resource_size_params *size_params)
>+			   const struct devlink_resource_size_params *size_params,
>+			   size_t priv_data_size)
> {
> 	struct devlink_resource *resource;
> 	struct list_head *resource_list;
>@@ -350,9 +354,11 @@ int devl_resource_register(struct devlink *devlink,
> 	if (resource)
> 		return -EINVAL;
> 
>-	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>+	resource = kzalloc(struct_size(resource, priv, priv_data_size),
>+			   GFP_KERNEL);
> 	if (!resource)
> 		return -ENOMEM;
>+	resource->priv_size = priv_data_size;
> 
> 	if (top_hierarchy) {
> 		resource_list = &devlink->resource_list;
>@@ -463,23 +469,25 @@ EXPORT_SYMBOL_GPL(devl_resource_size_get);
>  * @resource_id: resource id
>  * @occ_get: occupancy getter callback
>  * @occ_get_priv: occupancy getter callback priv
>+ * @occ_priv_size: 
>  */
> void devl_resource_occ_get_register(struct devlink *devlink,
> 				    u64 resource_id,
> 				    devlink_resource_occ_get_t *occ_get,
>-				    void *occ_get_priv)
>+				    void *occ_get_priv, size_t occ_priv_size)
> {
> 	struct devlink_resource *resource;
> 
> 	lockdep_assert_held(&devlink->lock);
> 
> 	resource = devlink_resource_find(devlink, NULL, resource_id);
>-	if (WARN_ON(!resource))
>+	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))

Very odd. You allocate a mem in devl_resource_register() and here you
copy data to it. Why the void pointer is not enough for you? You can
easily alloc struct in the driver and pass a pointer to it.

This is quite weird. Please don't.


> 		return;
> 	WARN_ON(resource->occ_get);
> 
> 	resource->occ_get = occ_get;
>-	resource->occ_get_priv = occ_get_priv;
>+	/* put driver provided data into resource priv memory */
>+	memcpy(resource->priv, occ_get_priv, occ_priv_size);
> }
> EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
> 
>@@ -502,6 +510,5 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
> 	WARN_ON(!resource->occ_get);
> 
> 	resource->occ_get = NULL;
>-	resource->occ_get_priv = NULL;
> }
> EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
>diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
>index f41f9fc2194e..29adf2d47540 100644
>--- a/net/dsa/devlink.c
>+++ b/net/dsa/devlink.c
>@@ -234,7 +234,7 @@ int dsa_devlink_resource_register(struct dsa_switch *ds,
> 	devl_lock(ds->devlink);
> 	ret = devl_resource_register(ds->devlink, resource_name, resource_size,
> 				     resource_id, parent_resource_id,
>-				     size_params);
>+				     size_params, sizeof(void *));
> 	devl_unlock(ds->devlink);
> 
> 	return ret;
>@@ -254,7 +254,7 @@ void dsa_devlink_resource_occ_get_register(struct dsa_switch *ds,
> {
> 	devl_lock(ds->devlink);
> 	devl_resource_occ_get_register(ds->devlink, resource_id, occ_get,
>-				       occ_get_priv);
>+				       &occ_get_priv, sizeof(occ_get_priv));
> 	devl_unlock(ds->devlink);
> }
> EXPORT_SYMBOL_GPL(dsa_devlink_resource_occ_get_register);
>-- 
>2.39.3
>

