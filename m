Return-Path: <netdev+bounces-117750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6494F12E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B9D2833EC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0687175D3D;
	Mon, 12 Aug 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rgxlnVHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2016D4DF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474905; cv=none; b=ahjF7e3wr8iRYXIvJSW5zWnLH19PKV378R5SCUoHaWmd+hZVvsKw/R5CBRVIr7cdAUPRV4him7sY06T/1AaTeM9pQoIAoXK89xiheCCrcWyAnqSb6yhEAxsZXUt75Tepaa//cw3lM1VaHSbPC94uVAB39iNhLVd1li++ojQAAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474905; c=relaxed/simple;
	bh=3bepnvysu204aK9ZGHhuLhAf/MnkD0hvdXN7WMz6QyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz5pb+XLbhjnGyoc95IYYQkT1dgEM9/6TmaCoT9EMZg83ZYPlUC/6w98p5SNck55paVBepBCaAPQ/1rYodegzziqDl5yz8F0VzHlnNLIGOjFWw/C/YNVgavXhj4uaKmNEw4GQVjVhNBGdOKZXvlJNetNywhC8LwxlZ77Nq8l3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rgxlnVHf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42809d6e719so34072725e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723474902; x=1724079702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=USddIO133CvdcNk8XDy2lah0HZv7CbV4ebeJFlghaLY=;
        b=rgxlnVHfvS7zrWHYOlXvgwDJ0gUl+CHHcJDrMKS3br+WEtR1V7HMvO++zQvNFRazIz
         Ww5ZMB1sz7JqkmeHSG61KqH3dm9qt+ICaXUhG3+pkGSUUngkq+0gP3bCV1/DVtJ4wVCR
         3L73PShx7K+woOdFVfob/QIISHYRfvRHtNbKRoioQFGGbXXKUTcTt1XOCY4IoFEFm0i7
         L1o/YV0KlnX2NP4QcY+MWbx9VIbIm2TQL8oy8MB/HTLMHioEOOW7sMgB4o7Oi2PQJHgu
         1Qdij/Hx3quuhBbpt5NbVmQfTSkRou9N7KqhZ/T2575DOfPtMCl5W7Ab3LKj9HfYcR7L
         TisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474902; x=1724079702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USddIO133CvdcNk8XDy2lah0HZv7CbV4ebeJFlghaLY=;
        b=FEFQtjII9u0qwIZ6yaqd7KSev62/NxWvZgsrRRETuyM1vaO5F8AvsePC9wHN9WYx8y
         1kHgDxyKqqYUzSbj0O7q8qzgnQpVIkucQYRNL1W8GTvgX2r5ryq/Mx/Dn4m4b2KkknAh
         y4mIcM0SbE7JUKMmYhZhxZUuJ+HI+QJlmxZttL4trMjdi1YHxe83qnDFqPpB6IeVOETe
         J53qy6mGsfyDqTucmDpF8LFgzofgS1hV2+03NekRKWCXO+RMlL9VvjiUWGJN7g1MWG68
         3YCb3kMAqAi27zRTZ9SEo/JeCrdmZpdvmihLJxJ0LqmgVHEe+bcW08eDjPKO8YQ/Pw24
         9VBw==
X-Gm-Message-State: AOJu0YxFGQWXBFdJp+R4y40A5eAg3hP/adoGA0JUOo84flf2X+GdHesa
	aqHNxWqlbXlwjQfKlh/ZvA8cYbuiAbML7Csp501fBUHg8bMG8pgCg71LUSE7or8=
X-Google-Smtp-Source: AGHT+IHqtCQ2sPGHUVDwcSe+nlTtslv1sOHB4RInOG9sUGBWIkbS6X9L2HFWbfUc+s6Vn41nm+eAsA==
X-Received: by 2002:a5d:694f:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-3716cd1fe1amr354227f8f.48.1723474901677;
        Mon, 12 Aug 2024 08:01:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bb07sm7838777f8f.5.2024.08.12.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:01:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:01:37 +0200
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
Message-ID: <Zroj0cPAoH3vQf6k@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-6-przemyslaw.kitszel@intel.com>
 <ZrMYfIN7cKUpYb8u@nanopsycho.orion>
 <31a55447-60ef-4cfb-bfd9-cc613619e29c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a55447-60ef-4cfb-bfd9-cc613619e29c@intel.com>

Mon, Aug 12, 2024 at 01:23:20PM CEST, przemyslaw.kitszel@intel.com wrote:
>On 8/7/24 08:47, Jiri Pirko wrote:
>> Tue, Aug 06, 2024 at 04:33:07PM CEST, przemyslaw.kitszel@intel.com wrote:
>> > Combine spectrum1 kvdl devlink resource occupation getters into one.
>> > 
>> > Thanks to previous commit of the series we could easily embed more than
>> > just a single pointer into devlink resource.
>> > 
>> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > ---
>> > .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 ++
>> > .../net/ethernet/mellanox/mlxsw/spectrum.c    |  3 +-
>> > .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 ++++++++-----------
>> > 3 files changed, 41 insertions(+), 47 deletions(-)
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> > index 8d3c61287696..91fe5fffa675 100644
>> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> > @@ -836,6 +836,11 @@ int mlxsw_sp_kvdl_alloc_count_query(struct mlxsw_sp *mlxsw_sp,
>> > 				    unsigned int *p_alloc_count);
>> > 
>> > /* spectrum1_kvdl.c */
>> > +struct mlxsw_sp1_kvdl_occ_ctx {
>> > +	struct mlxsw_sp1_kvdl *kvdl;
>> > +	int first_part_id;
>> > +	bool count_all_parts;
>> > +};
>> > extern const struct mlxsw_sp_kvdl_ops mlxsw_sp1_kvdl_ops;
>> > int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core);
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> > index 2730ae3d8fe6..3bda2b2d16f9 100644
>> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> > @@ -3669,7 +3669,8 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
>> > 				     linear_size,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > 				     MLXSW_SP_RESOURCE_KVD,
>> > -				     &linear_size_params, sizeof(void *));
>> > +				     &linear_size_params,
>> > +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> > 	if (err)
>> > 		return err;
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> > index ee5f12746371..a8bf052adf31 100644
>> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> > @@ -292,68 +292,53 @@ static u64 mlxsw_sp1_kvdl_part_occ(struct mlxsw_sp1_kvdl_part *part)
>> > 
>> > static u64 mlxsw_sp1_kvdl_occ_get(void *priv)
>> > {
>> > -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> > +	struct mlxsw_sp1_kvdl_occ_ctx *ctx = priv;
>> > +	bool cnt_all = ctx->count_all_parts;
>> > +	int beg, end;
>> > 	u64 occ = 0;
>> > -	int i;
>> > 
>> > -	for (i = 0; i < MLXSW_SP1_KVDL_PARTS_INFO_LEN; i++)
>> > -		occ += mlxsw_sp1_kvdl_part_occ(kvdl->parts[i]);
>> > +	beg = cnt_all ? 0 : ctx->first_part_id,
>> > +	end = cnt_all ? MLXSW_SP1_KVDL_PARTS_INFO_LEN : beg + 1;
>> > +	for (int i = beg; i < end; i++)
>> > +		occ += mlxsw_sp1_kvdl_part_occ(ctx->kvdl->parts[i]);
>> > 
>> > 	return occ;
>> 
>> I don't see the benefit, this just makes code harder to read.
>
>You mean in general or this particular function?

In general.

>
>Anyway, a part of motivation is to avoid dumb (even if easy to read in
>isolation) getters and replace it with a one that exposes the logic.
>(Now you have 2+ functions that reader needs to manually compare).

I don't follow. Are you not able to implement what you need using the
existing api, or you just don't like it?


>
>Re general oddities:
>sizeof(void *) stuff just follows from the main idea, and is a temporary
>solution (see this patch, it removes such).
>
>> 
>> 
>> > }
>> > 
>> > -static u64 mlxsw_sp1_kvdl_single_occ_get(void *priv)
>> > -{
>> > -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> > -	struct mlxsw_sp1_kvdl_part *part;
>> > -
>> > -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_SINGLE];
>> > -	return mlxsw_sp1_kvdl_part_occ(part);
>> > -}
>> > -
>> > -static u64 mlxsw_sp1_kvdl_chunks_occ_get(void *priv)
>> > -{
>> > -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> > -	struct mlxsw_sp1_kvdl_part *part;
>> > -
>> > -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_CHUNKS];
>> > -	return mlxsw_sp1_kvdl_part_occ(part);
>> > -}
>> > -
>> > -static u64 mlxsw_sp1_kvdl_large_chunks_occ_get(void *priv)
>> > -{
>> > -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> > -	struct mlxsw_sp1_kvdl_part *part;
>> > -
>> > -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS];
>> > -	return mlxsw_sp1_kvdl_part_occ(part);
>> > -}
>> > -
>> > static int mlxsw_sp1_kvdl_init(struct mlxsw_sp *mlxsw_sp, void *priv)
>> > {
>> > 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
>> > -	struct mlxsw_sp1_kvdl *kvdl = priv;
>> > +	struct mlxsw_sp1_kvdl_occ_ctx ctx = { priv };
>> > 	int err;
>> > 
>> > -	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, kvdl);
>> > +	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, ctx.kvdl);
>> > 	if (err)
>> > 		return err;
>> > -	devl_resource_occ_get_register(devlink,
>> > -				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > -				       mlxsw_sp1_kvdl_occ_get,
>> > -				       &kvdl, sizeof(kvdl));
>> > +
>> > +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_SINGLE;
>> > 	devl_resource_occ_get_register(devlink,
>> > 				       MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
>> > -				       mlxsw_sp1_kvdl_single_occ_get,
>> > -				       &kvdl, sizeof(kvdl));
>> > +				       mlxsw_sp1_kvdl_occ_get,
>> > +				       &ctx, sizeof(ctx));
>> > +
>> > +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_CHUNKS;
>> > 	devl_resource_occ_get_register(devlink,
>> > 				       MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
>> > -				       mlxsw_sp1_kvdl_chunks_occ_get,
>> > -				       &kvdl, sizeof(kvdl));
>> > +				       mlxsw_sp1_kvdl_occ_get,
>> > +				       &ctx, sizeof(ctx));
>> > +
>> > +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS;
>> > 	devl_resource_occ_get_register(devlink,
>> > 				       MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
>> > -				       mlxsw_sp1_kvdl_large_chunks_occ_get,
>> > -				       &kvdl, sizeof(kvdl));
>> > +				       mlxsw_sp1_kvdl_occ_get,
>> > +				       &ctx, sizeof(ctx));
>> > +
>> > +	ctx.count_all_parts = true;
>> > +	devl_resource_occ_get_register(devlink,
>> > +				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > +				       mlxsw_sp1_kvdl_occ_get,
>> > +				       &ctx, sizeof(ctx));
>> > +
>> > 	return 0;
>> > }
>> > 
>> > @@ -400,7 +385,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> > 				     MLXSW_SP1_KVDL_SINGLE_SIZE,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > -				     &size_params, sizeof(void *));
>> > +				     &size_params,
>> > +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> > 	if (err)
>> > 		return err;
>> > 
>> > @@ -411,7 +397,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> > 				     MLXSW_SP1_KVDL_CHUNKS_SIZE,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > -				     &size_params, sizeof(void *));
>> > +				     &size_params,
>> > +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> > 	if (err)
>> > 		return err;
>> > 
>> > @@ -422,6 +409,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> > 				     MLXSW_SP1_KVDL_LARGE_CHUNKS_SIZE,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
>> > 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> > -				     &size_params, sizeof(void *));
>> > +				     &size_params,
>> > +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> > 	return err;
>> > }
>> > -- 
>> > 2.39.3
>> > 
>

