Return-Path: <netdev+bounces-116328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A294A111
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8314628B74E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DE1B86DF;
	Wed,  7 Aug 2024 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MwjAhATm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAE1B582B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013252; cv=none; b=Dwc1m0slm7dt2rwTHcfyzdUBZdFLihjxsLKj8TEnUtgLWBISRBG33+zXOKk1LLNFWUBnr3XorSLi9wv6g0voFeDFVD0Bhnal6nA/43wXH/Uxx6X2MwGTpaZcc67caBN0wbigKEUHFceTuDbUd30AR9K29Mr3vuhUcU9VsbaUoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013252; c=relaxed/simple;
	bh=3HZCjY40CUvd1snD1CUo6QsHf1YTqFGWydvONze4vtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/xTmmcfsMhA3lrGIyYdKJaqS9KL/k4Ej3ajvw41aL6zeiTSPVfyJ+1DsPRaHYkrfIsYvKigWTkhSARqAN7B/aVBF50TJvRtTsw9bE/9+xLm0kvbfJRpA6Oa98by2p1Kq77tr+rAtnVCOJMR/0t7pO7wZRp+nF6Qhv9PitaGlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MwjAhATm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efbc57456so1078191e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723013247; x=1723618047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6X9/1k9wcnpcXgfDW1ulBeB3dMg8qsgLXvNH2qc4Hek=;
        b=MwjAhATm9m6aIEv2OjyXl0Vwom4LG0zDjVG8eBtMtwrVHRhRJDqhjroM9xSWwvjbvx
         thMvKU9Klz4jMudsjzxewBk71vbx3z/1G4Q6fXLy6yzbzz8W7esUyq9k/0KerZ06epaU
         l2KOQYTHWN0Yc51ocLAVC/Fji35fZ9A/XEp135I4FD073+tQaRdLy7PKj0frVQiDkmSd
         TuaNdm/26PFHktdiQaJrfs/JGYQh/qR+WSJrQvbh6fSjMtmO8fSWrZqYLaovLQqfkVx5
         PlvmUHe6gdS3CZnZSL0VNmOe6kjKTIzzbXmzCi1yUFK2he53AY69RttO/OHYvP6+Jcot
         k1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013247; x=1723618047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X9/1k9wcnpcXgfDW1ulBeB3dMg8qsgLXvNH2qc4Hek=;
        b=rhoLL29Y94JOWKAUZDHOE01UlSSvB4HZqwxU7zr9zJbrbEAkkgO/bulrSpiqdiZ1c0
         qA2pXPdM07NiUlAES3h1UiTEvdn9YpWThhw/hCncP+FRGubwYCleMoQAwSnYdX9ZsBOr
         rBFmtaGq/6/NlZsNn8fFPpsmIWE8WbWGlcDc6XhstFYR72TygL/z6K2qj+HTA3EJhwC8
         ZRbIzrLIQWkXM8W1Iz1B2rR/xdqCsuhMsPhAufxQvySypCMJAhWRX56PXwTbLoSM+1B/
         FT7XzBOt43OKP+g8PoOzHA5OBKkPYMbuitlXIx8pQeeOvzyWSC8YTDTtStswQlHBj2Rb
         HE8Q==
X-Gm-Message-State: AOJu0Yy4JkXoAaadGgTbGucy7VrYXogDnoBvSia5uNNTw6tKRWzAs/7U
	CnMq7sD87vH2oYpKvCcPK3Ll6giAIaHgUXH1yUjwWJYnQn2tmwb7ZQXT6C5egFU=
X-Google-Smtp-Source: AGHT+IGD5GnV5Qxn5yCBotVSHunXHiENwIolrGTXJ2UjqYg5YYbfdL/OMnuzA9cWGTeFCR18/+U4wg==
X-Received: by 2002:a05:6512:3b11:b0:52e:987f:cfc6 with SMTP id 2adb3069b0e04-530bb39b674mr12164984e87.51.1723013246907;
        Tue, 06 Aug 2024 23:47:26 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm6677513a12.68.2024.08.06.23.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:47:26 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:47:24 +0200
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
Subject: Re: [PATCH net-next 5/5] mlxsw: spectrum_kvdl: combine devlink
 resource occupation getters
Message-ID: <ZrMYfIN7cKUpYb8u@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806143307.14839-6-przemyslaw.kitszel@intel.com>

Tue, Aug 06, 2024 at 04:33:07PM CEST, przemyslaw.kitszel@intel.com wrote:
>Combine spectrum1 kvdl devlink resource occupation getters into one.
>
>Thanks to previous commit of the series we could easily embed more than
>just a single pointer into devlink resource.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
> .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 ++
> .../net/ethernet/mellanox/mlxsw/spectrum.c    |  3 +-
> .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 ++++++++-----------
> 3 files changed, 41 insertions(+), 47 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>index 8d3c61287696..91fe5fffa675 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>@@ -836,6 +836,11 @@ int mlxsw_sp_kvdl_alloc_count_query(struct mlxsw_sp *mlxsw_sp,
> 				    unsigned int *p_alloc_count);
> 
> /* spectrum1_kvdl.c */
>+struct mlxsw_sp1_kvdl_occ_ctx {
>+	struct mlxsw_sp1_kvdl *kvdl;
>+	int first_part_id;
>+	bool count_all_parts;
>+};
> extern const struct mlxsw_sp_kvdl_ops mlxsw_sp1_kvdl_ops;
> int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core);
> 
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>index 2730ae3d8fe6..3bda2b2d16f9 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>@@ -3669,7 +3669,8 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
> 				     linear_size,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
> 				     MLXSW_SP_RESOURCE_KVD,
>-				     &linear_size_params, sizeof(void *));
>+				     &linear_size_params,
>+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
> 	if (err)
> 		return err;
> 
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>index ee5f12746371..a8bf052adf31 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>@@ -292,68 +292,53 @@ static u64 mlxsw_sp1_kvdl_part_occ(struct mlxsw_sp1_kvdl_part *part)
> 
> static u64 mlxsw_sp1_kvdl_occ_get(void *priv)
> {
>-	const struct mlxsw_sp1_kvdl *kvdl = priv;
>+	struct mlxsw_sp1_kvdl_occ_ctx *ctx = priv;
>+	bool cnt_all = ctx->count_all_parts;
>+	int beg, end;
> 	u64 occ = 0;
>-	int i;
> 
>-	for (i = 0; i < MLXSW_SP1_KVDL_PARTS_INFO_LEN; i++)
>-		occ += mlxsw_sp1_kvdl_part_occ(kvdl->parts[i]);
>+	beg = cnt_all ? 0 : ctx->first_part_id,
>+	end = cnt_all ? MLXSW_SP1_KVDL_PARTS_INFO_LEN : beg + 1;
>+	for (int i = beg; i < end; i++)
>+		occ += mlxsw_sp1_kvdl_part_occ(ctx->kvdl->parts[i]);
> 
> 	return occ;

I don't see the benefit, this just makes code harder to read.


> }
> 
>-static u64 mlxsw_sp1_kvdl_single_occ_get(void *priv)
>-{
>-	const struct mlxsw_sp1_kvdl *kvdl = priv;
>-	struct mlxsw_sp1_kvdl_part *part;
>-
>-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_SINGLE];
>-	return mlxsw_sp1_kvdl_part_occ(part);
>-}
>-
>-static u64 mlxsw_sp1_kvdl_chunks_occ_get(void *priv)
>-{
>-	const struct mlxsw_sp1_kvdl *kvdl = priv;
>-	struct mlxsw_sp1_kvdl_part *part;
>-
>-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_CHUNKS];
>-	return mlxsw_sp1_kvdl_part_occ(part);
>-}
>-
>-static u64 mlxsw_sp1_kvdl_large_chunks_occ_get(void *priv)
>-{
>-	const struct mlxsw_sp1_kvdl *kvdl = priv;
>-	struct mlxsw_sp1_kvdl_part *part;
>-
>-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS];
>-	return mlxsw_sp1_kvdl_part_occ(part);
>-}
>-
> static int mlxsw_sp1_kvdl_init(struct mlxsw_sp *mlxsw_sp, void *priv)
> {
> 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
>-	struct mlxsw_sp1_kvdl *kvdl = priv;
>+	struct mlxsw_sp1_kvdl_occ_ctx ctx = { priv };
> 	int err;
> 
>-	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, kvdl);
>+	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, ctx.kvdl);
> 	if (err)
> 		return err;
>-	devl_resource_occ_get_register(devlink,
>-				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				       mlxsw_sp1_kvdl_occ_get,
>-				       &kvdl, sizeof(kvdl));
>+
>+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_SINGLE;
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
>-				       mlxsw_sp1_kvdl_single_occ_get,
>-				       &kvdl, sizeof(kvdl));
>+				       mlxsw_sp1_kvdl_occ_get,
>+				       &ctx, sizeof(ctx));
>+
>+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_CHUNKS;
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
>-				       mlxsw_sp1_kvdl_chunks_occ_get,
>-				       &kvdl, sizeof(kvdl));
>+				       mlxsw_sp1_kvdl_occ_get,
>+				       &ctx, sizeof(ctx));
>+
>+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS;
> 	devl_resource_occ_get_register(devlink,
> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
>-				       mlxsw_sp1_kvdl_large_chunks_occ_get,
>-				       &kvdl, sizeof(kvdl));
>+				       mlxsw_sp1_kvdl_occ_get,
>+				       &ctx, sizeof(ctx));
>+
>+	ctx.count_all_parts = true;
>+	devl_resource_occ_get_register(devlink,
>+				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>+				       mlxsw_sp1_kvdl_occ_get,
>+				       &ctx, sizeof(ctx));
>+
> 	return 0;
> }
> 
>@@ -400,7 +385,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_SINGLE_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params, sizeof(void *));
>+				     &size_params,
>+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
> 	if (err)
> 		return err;
> 
>@@ -411,7 +397,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_CHUNKS_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params, sizeof(void *));
>+				     &size_params,
>+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
> 	if (err)
> 		return err;
> 
>@@ -422,6 +409,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
> 				     MLXSW_SP1_KVDL_LARGE_CHUNKS_SIZE,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>-				     &size_params, sizeof(void *));
>+				     &size_params,
>+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
> 	return err;
> }
>-- 
>2.39.3
>

