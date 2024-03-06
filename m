Return-Path: <netdev+bounces-77803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFA8730C6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C831F28573
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26D3A260;
	Wed,  6 Mar 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="picP4/69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFB29406
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713983; cv=none; b=thyM5Yrhejmj6v6gooN16iTlaBhaopyjo47Y3D0z9dj63WkcEurK+2c3R+wLc1R8aRhy44e8wi5DKtvuTZSzHTqWm6PxY2eKD0njdfhUEwCsux6VwUPms9FfMdcE42xk+rtFJn3kTCnaxRukU9Sh0furATtlI9OYe/ztzV2jy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713983; c=relaxed/simple;
	bh=lJR+MpXrLMMr2RuWqxj6iYllR3LAz7lMljd7VzW6MtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBdh/DcWmDq/LQOSWSOfq6Kv16mrm/NYEHBY0MK6FE3JSFc8VUb6vbNH6tpEWvGdmpXqKIiN+tYupt+SwSsmV2vvoEEU6uVL5c3yO+EtPabfZZYOT32dVZMfqVy0WjaLlZvoEeeuUTq71sTqWgwHqt2/ou5tI8TxsMycJPhZFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=picP4/69; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412e6ba32easo20024645e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709713978; x=1710318778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Tkyj8sbGLUcurKuxUwXPk3KTdbL7smGP+jSfDQWV4=;
        b=picP4/69yBBGKhA0B7lW0iDK8+HCyNlsgYD4iIY9J8r6mO/9/u+lxBr2KnJGrtclYS
         fv4z2Vm2rmwbHhyDvVphF299pPIKfFh81mVokeSp+JqEt5n14mDXuF73e0+pSs/n3ljn
         123sTK3HvhwOldfGFwZDgq8OhZd+EqF6WkLihoygeeb++MvtbeJ6CC4xRknn4XbA0I/m
         ClIqfFMxE4HboK4ZTjwvdN5uYWcmnXFfpu8aDTIB313xK3e7NDtoJVjmxDepi4cbwzRq
         r4Ps6Yi9JqWKXCEUTaesQEOX9rakOf2+7cXjdrp7KlHVTAt9Rz2TRog5r0aQEaV4Qe7c
         5qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713978; x=1710318778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Tkyj8sbGLUcurKuxUwXPk3KTdbL7smGP+jSfDQWV4=;
        b=jDZ3Rg26Y/RCMyKXLV1MB8XDwhXiIIAjx48Y6lbwt3G1/XGDhP0eSAFB7tRGTAXQuf
         4IjZhDH1QZIUC17RmXnRQQynBISBwl69oFG5eMujCvghQzZFLA4Et47QMoI10kQgP+va
         kZ9fBxxjRcY3EVrMHMn22t5oXTg6O40YiRFjCuGuBj68t4Tnuqca1weNN+cAbbIq4J5X
         4/z4zRRBamQVdg9/X+OXPZVGPwuORvO3gjHnzObEIXr4AiZMPvS61xkirzhZRTD/l0zY
         6UCjnZsnfsuwZj5Iby/sCJHkaaP68FoQQEBql7TnUwAOhROcopSRgWH6i2krbvUdrLxx
         6r/g==
X-Forwarded-Encrypted: i=1; AJvYcCX6s6KCPFb86KLCBpaIe4DYn3tqlPtGOkdw6FlLespVJRBfHU1FclTCZg2jf8hyYx6NGfsgjcR2TLwJdimB5WGDEu4sTgDb
X-Gm-Message-State: AOJu0YzbbDsO0CUmQkAuIHFCfyDgns55zQnjhAfYqGmYwOrZDcfvvaGN
	rNbdtmpGZBAQCgWMpux97qfTZFzj7ei3H6kSRyXfu1BZHNRN3X+lJWJ9CBcvbDw=
X-Google-Smtp-Source: AGHT+IFNIE3wnoy3lNujqk7nQtu4ySa2uEuDEUiUDDaGVNShXlyIw/uLJVnrjCGNCNp21zrpC2UGFg==
X-Received: by 2002:a05:600c:1d16:b0:412:b0cc:1c62 with SMTP id l22-20020a05600c1d1600b00412b0cc1c62mr10161383wms.32.1709713977677;
        Wed, 06 Mar 2024 00:32:57 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b00412b3bf811bsm20160373wmo.8.2024.03.06.00.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:32:56 -0800 (PST)
Date: Wed, 6 Mar 2024 09:32:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, kuba@kernel.org, horms@kernel.org,
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, victor.raj@intel.com,
	michal.wilczynski@intel.com, lukasz.czapnik@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 1/6] devlink: extend
 devlink_param *set pointer
Message-ID: <ZegqNZULwmHjC9oA@nanopsycho>
References: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
 <20240305143942.23757-2-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305143942.23757-2-mateusz.polchlopek@intel.com>

Tue, Mar 05, 2024 at 03:39:37PM CET, mateusz.polchlopek@intel.com wrote:
>Extend devlink_param *set function pointer to take extack as a param.
>Sometimes it is needed to pass information to the end user from set
>function. It is more proper to use for that netlink instead of passing
>message to dmesg.
>
>Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>---
> .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  6 ++--
> drivers/net/ethernet/intel/ice/ice_devlink.c  | 36 +++++++++----------
> drivers/net/ethernet/mellanox/mlx4/main.c     |  6 ++--
> .../net/ethernet/mellanox/mlx5/core/eswitch.c |  3 +-
> .../mellanox/mlx5/core/eswitch_offloads.c     |  3 +-
> .../net/ethernet/mellanox/mlx5/core/fs_core.c |  3 +-
> .../ethernet/mellanox/mlx5/core/fw_reset.c    |  3 +-
> .../mellanox/mlxsw/spectrum_acl_tcam.c        |  3 +-
> .../ethernet/netronome/nfp/devlink_param.c    |  3 +-
> drivers/net/ethernet/qlogic/qed/qed_devlink.c |  3 +-
> drivers/net/wwan/iosm/iosm_ipc_devlink.c      |  3 +-
> include/net/devlink.h                         |  3 +-
> include/net/dsa.h                             |  3 +-
> net/devlink/param.c                           |  7 ++--
> net/dsa/devlink.c                             |  3 +-
> 15 files changed, 50 insertions(+), 38 deletions(-)
>
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>index ae4529c043f0..d9ea6fa23923 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>@@ -1096,7 +1096,8 @@ static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
> }
> 
> static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
>-				 struct devlink_param_gset_ctx *ctx)
>+				 struct devlink_param_gset_ctx *ctx,
>+				 struct netlink_ext_ack *extack)
> {
> 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
> 	struct hwrm_nvm_set_variable_input *req;
>@@ -1145,7 +1146,8 @@ static int bnxt_remote_dev_reset_get(struct devlink *dl, u32 id,
> }
> 
> static int bnxt_remote_dev_reset_set(struct devlink *dl, u32 id,
>-				     struct devlink_param_gset_ctx *ctx)
>+				     struct devlink_param_gset_ctx *ctx,
>+				     struct netlink_ext_ack *extack)
> {
> 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
> 	int rc;
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index b516e42b41f0..c0a89a1b4e88 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1380,9 +1380,8 @@ static const struct devlink_ops ice_devlink_ops = {
> 	.rate_node_parent_set = ice_devlink_set_parent,
> };
> 
>-static int
>-ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
>-			    struct devlink_param_gset_ctx *ctx)
>+static int ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
>+				       struct devlink_param_gset_ctx *ctx)

Hmm. This hunk does not seem related to the rest of the patch. Please
remove.

Feel free to add my:
Suggested-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

after that.

pw-bot: cr



> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 
>@@ -1391,9 +1390,9 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>-static int
>-ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
>-			    struct devlink_param_gset_ctx *ctx)
>+static int ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
>+				       struct devlink_param_gset_ctx *ctx,
>+				       struct netlink_ext_ack *extack)
> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 	bool roce_ena = ctx->val.vbool;
>@@ -1413,10 +1412,9 @@ ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
> 	return ret;
> }
> 
>-static int
>-ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
>-				 union devlink_param_value val,
>-				 struct netlink_ext_ack *extack)
>+static int ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
>+					    union devlink_param_value val,
>+					    struct netlink_ext_ack *extack)
> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 
>@@ -1431,9 +1429,8 @@ ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>-static int
>-ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
>-			  struct devlink_param_gset_ctx *ctx)
>+static int ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
>+				     struct devlink_param_gset_ctx *ctx)
> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 
>@@ -1442,9 +1439,9 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>-static int
>-ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
>-			  struct devlink_param_gset_ctx *ctx)
>+static int ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
>+				     struct devlink_param_gset_ctx *ctx,
>+				     struct netlink_ext_ack *extack)
> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 	bool iw_ena = ctx->val.vbool;
>@@ -1464,10 +1461,9 @@ ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
> 	return ret;
> }
> 
>-static int
>-ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
>-			       union devlink_param_value val,
>-			       struct netlink_ext_ack *extack)
>+static int ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
>+					  union devlink_param_value val,
>+					  struct netlink_ext_ack *extack)
> {
> 	struct ice_pf *pf = devlink_priv(devlink);
> 
>diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
>index 7b02ff61126d..98688e4dbec5 100644
>--- a/drivers/net/ethernet/mellanox/mlx4/main.c
>+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
>@@ -185,7 +185,8 @@ static int mlx4_devlink_ierr_reset_get(struct devlink *devlink, u32 id,
> }
> 
> static int mlx4_devlink_ierr_reset_set(struct devlink *devlink, u32 id,
>-				       struct devlink_param_gset_ctx *ctx)
>+				       struct devlink_param_gset_ctx *ctx,
>+				       struct netlink_ext_ack *extack)
> {
> 	mlx4_internal_err_reset = ctx->val.vbool;
> 	return 0;
>@@ -202,7 +203,8 @@ static int mlx4_devlink_crdump_snapshot_get(struct devlink *devlink, u32 id,
> }
> 
> static int mlx4_devlink_crdump_snapshot_set(struct devlink *devlink, u32 id,
>-					    struct devlink_param_gset_ctx *ctx)
>+					    struct devlink_param_gset_ctx *ctx,
>+					    struct netlink_ext_ack *extack)
> {
> 	struct mlx4_priv *priv = devlink_priv(devlink);
> 	struct mlx4_dev *dev = &priv->dev;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>index 3047d7015c52..a86f9c335b6b 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>@@ -1805,7 +1805,8 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
> }
> 
> static int mlx5_devlink_esw_multiport_set(struct devlink *devlink, u32 id,
>-					  struct devlink_param_gset_ctx *ctx)
>+					  struct devlink_param_gset_ctx *ctx,
>+					  struct netlink_ext_ack *extack)
> {
> 	struct mlx5_core_dev *dev = devlink_priv(devlink);
> 
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>index b0455134c98e..3d8b3ca681d0 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>@@ -2405,7 +2405,8 @@ static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
> }
> 
> static int esw_port_metadata_set(struct devlink *devlink, u32 id,
>-				 struct devlink_param_gset_ctx *ctx)
>+				 struct devlink_param_gset_ctx *ctx,
>+				 struct netlink_ext_ack *extack)
> {
> 	struct mlx5_core_dev *dev = devlink_priv(devlink);
> 	struct mlx5_eswitch *esw = dev->priv.eswitch;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>index e6bfa7e4f146..8a941c0b4497 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
>@@ -3321,7 +3321,8 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
> }
> 
> static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
>-			    struct devlink_param_gset_ctx *ctx)
>+			    struct devlink_param_gset_ctx *ctx,
>+			    struct netlink_ext_ack *extack)
> {
> 	struct mlx5_core_dev *dev = devlink_priv(devlink);
> 	enum mlx5_flow_steering_mode mode;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>index f27eab6e4929..1237b7fb5cef 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>@@ -52,7 +52,8 @@ static void mlx5_set_fw_rst_ack(struct mlx5_core_dev *dev)
> }
> 
> static int mlx5_fw_reset_enable_remote_dev_reset_set(struct devlink *devlink, u32 id,
>-						     struct devlink_param_gset_ctx *ctx)
>+						     struct devlink_param_gset_ctx *ctx,
>+						     struct netlink_ext_ack *extack)
> {
> 	struct mlx5_core_dev *dev = devlink_priv(devlink);
> 	struct mlx5_fw_reset *fw_reset;
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
>index f20052776b3f..baedf0d45e85 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
>@@ -1465,7 +1465,8 @@ mlxsw_sp_acl_tcam_region_rehash_intrvl_get(struct devlink *devlink, u32 id,
> 
> static int
> mlxsw_sp_acl_tcam_region_rehash_intrvl_set(struct devlink *devlink, u32 id,
>-					   struct devlink_param_gset_ctx *ctx)
>+					   struct devlink_param_gset_ctx *ctx,
>+					   struct netlink_ext_ack *extack)
> {
> 	struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
> 	struct mlxsw_sp_acl_tcam_vregion *vregion;
>diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
>index a655f9e69a7b..0e1a3800f371 100644
>--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
>+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
>@@ -132,7 +132,8 @@ nfp_devlink_param_u8_get(struct devlink *devlink, u32 id,
> 
> static int
> nfp_devlink_param_u8_set(struct devlink *devlink, u32 id,
>-			 struct devlink_param_gset_ctx *ctx)
>+			 struct devlink_param_gset_ctx *ctx,
>+			 struct netlink_ext_ack *extack)
> {
> 	const struct nfp_devlink_param_u8_arg *arg;
> 	struct nfp_pf *pf = devlink_priv(devlink);
>diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
>index dad8e617c393..1adc7fbb3f2f 100644
>--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
>+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
>@@ -132,7 +132,8 @@ static int qed_dl_param_get(struct devlink *dl, u32 id,
> }
> 
> static int qed_dl_param_set(struct devlink *dl, u32 id,
>-			    struct devlink_param_gset_ctx *ctx)
>+			    struct devlink_param_gset_ctx *ctx,
>+			    struct netlink_ext_ack *extack)
> {
> 	struct qed_devlink *qed_dl = devlink_priv(dl);
> 	struct qed_dev *cdev;
>diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
>index 2fe724d623c0..bef6819986e9 100644
>--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
>+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
>@@ -33,7 +33,8 @@ static int ipc_devlink_get_param(struct devlink *dl, u32 id,
> 
> /* Set the param values for the specific param ID's */
> static int ipc_devlink_set_param(struct devlink *dl, u32 id,
>-				 struct devlink_param_gset_ctx *ctx)
>+				 struct devlink_param_gset_ctx *ctx,
>+				 struct netlink_ext_ack *extack)
> {
> 	struct iosm_devlink *ipc_devlink = devlink_priv(dl);
> 
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index 9ac394bdfbe4..12f14be44e53 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -483,7 +483,8 @@ struct devlink_param {
> 	int (*get)(struct devlink *devlink, u32 id,
> 		   struct devlink_param_gset_ctx *ctx);
> 	int (*set)(struct devlink *devlink, u32 id,
>-		   struct devlink_param_gset_ctx *ctx);
>+		   struct devlink_param_gset_ctx *ctx,
>+		   struct netlink_ext_ack *extack);
> 	int (*validate)(struct devlink *devlink, u32 id,
> 			union devlink_param_value val,
> 			struct netlink_ext_ack *extack);
>diff --git a/include/net/dsa.h b/include/net/dsa.h
>index 7c0da9effe4e..140b80e1a88c 100644
>--- a/include/net/dsa.h
>+++ b/include/net/dsa.h
>@@ -1247,7 +1247,8 @@ struct dsa_switch_ops {
> int dsa_devlink_param_get(struct devlink *dl, u32 id,
> 			  struct devlink_param_gset_ctx *ctx);
> int dsa_devlink_param_set(struct devlink *dl, u32 id,
>-			  struct devlink_param_gset_ctx *ctx);
>+			  struct devlink_param_gset_ctx *ctx,
>+			  struct netlink_ext_ack *extack);
> int dsa_devlink_params_register(struct dsa_switch *ds,
> 				const struct devlink_param *params,
> 				size_t params_count);
>diff --git a/net/devlink/param.c b/net/devlink/param.c
>index 22bc3b500518..dcf0d1ccebba 100644
>--- a/net/devlink/param.c
>+++ b/net/devlink/param.c
>@@ -158,11 +158,12 @@ static int devlink_param_get(struct devlink *devlink,
> 
> static int devlink_param_set(struct devlink *devlink,
> 			     const struct devlink_param *param,
>-			     struct devlink_param_gset_ctx *ctx)
>+			     struct devlink_param_gset_ctx *ctx,
>+			     struct netlink_ext_ack *extack)
> {
> 	if (!param->set)
> 		return -EOPNOTSUPP;
>-	return param->set(devlink, param->id, ctx);
>+	return param->set(devlink, param->id, ctx, extack);
> }
> 
> static int
>@@ -571,7 +572,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
> 			return -EOPNOTSUPP;
> 		ctx.val = value;
> 		ctx.cmode = cmode;
>-		err = devlink_param_set(devlink, param, &ctx);
>+		err = devlink_param_set(devlink, param, &ctx, info->extack);
> 		if (err)
> 			return err;
> 	}
>diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
>index 431bf52290a1..0aac887d0098 100644
>--- a/net/dsa/devlink.c
>+++ b/net/dsa/devlink.c
>@@ -194,7 +194,8 @@ int dsa_devlink_param_get(struct devlink *dl, u32 id,
> EXPORT_SYMBOL_GPL(dsa_devlink_param_get);
> 
> int dsa_devlink_param_set(struct devlink *dl, u32 id,
>-			  struct devlink_param_gset_ctx *ctx)
>+			  struct devlink_param_gset_ctx *ctx,
>+			  struct netlink_ext_ack *extack)
> {
> 	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
> 
>-- 
>2.38.1
>

