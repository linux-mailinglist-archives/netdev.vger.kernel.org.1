Return-Path: <netdev+bounces-135060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649A99C087
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67826B22701
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9314373F;
	Mon, 14 Oct 2024 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KqfUwbpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1733C9
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889201; cv=none; b=p1IZv0Ka/R6CXFn3D7K4PPE7DeiOpprANqi9IIiSx3ZQQB+qIzedeQ53ej9BuEQRtBYlHhPs5czk78kh0flX2EgCHpy90ITcBexLwGp03UtcdHTTtWSz5JsJSjHPu2c5Tf8fRVIr0y06HeR5A3LeFZ4SrN0qwG9M0lCPDqNCU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889201; c=relaxed/simple;
	bh=xKtOQZK5HutUaVl6kbbOU9Qu7Ar2joczRXup5ujyrgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itj1RpW8TU30dl5hGBSFXzPQKGGi0VNoDjlA4DJen7Ra0A37AdFrvJ2OmaeMHm4IXbm2kKj+TRXxcOpow1ivRmWQN/RDgE+wcbaSI4aLXEUv1bs9wnAqaKbeY5tEMcR4CcKMeDtLXOuGTTkPefJoM3/kcFXXxCib04jowUb4a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KqfUwbpq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99b1f43aceso525955266b.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728889197; x=1729493997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbvyoL9Luo/70/PTVBa7h557couwK2dRn3xz6x5mHho=;
        b=KqfUwbpqQ1gzt++iVRYbKYodeC5q6EqZM81NuUSPt94AA7DSrvMhhpTOvmCC6Omt7E
         eZ8uPiw6rmjA+UaqjWoOVrwEub0lgjTjv9KZx7ydj14aChqkaldxgu1/8qs8HPowIifu
         DcdFuCgwrAxzP++14QY6RJ/DMzzsOb5VcDqt9CslirzHEL3Gh72eKnQ6iWuUJoT2HDgx
         8tbJyi6X2CkkwEYriX1kMTWCjKk4Abfz5K52eXeHA86HIACWgBd8gwnht+Ky8pJroc2y
         TZdO4PKQnEpvAK9Z2eS/bWDKR3fsG1O31VPRau8Vvidxl7O3BR9vG5hVGqdES2AHdrn1
         UY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889197; x=1729493997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbvyoL9Luo/70/PTVBa7h557couwK2dRn3xz6x5mHho=;
        b=k5fDJC/qmw1wKltk0iSgQ06EDcRNo/fPQV4TMcT1YdTcZlnDfIhEROILr1n4Aq9qFj
         edYIEW8YbcfT7C9+8qSbvNI6GxgegGKtdjreTw1YWGwJeCXgJge714/16s/400EhlhKX
         mTtiaxDBFrKgTOFK0EqND36dTJKxlZDYBwmwjTLTZ9KJHWtsZRFBPjROibXGkzU2a9WC
         KD4EIMEiHPC5e368eEV/czGL2kDhHms4a5dKh+w7/poLPEXgstFHH144ROdPMs2pCH+B
         ZDTZX3SVZGsRfrUEnRe2MR2Qr/JCuHsJEFzKfJhZegut4pFe/Uamr2y4ls/iUpXT8/7L
         QMbA==
X-Gm-Message-State: AOJu0YxDNDj+ZLJjcXxFNuTb6huK5Slr73t2mznq9dbrgDg8TQuGzF+d
	V5HlauOoquxquocHYazvuaj3jcV70CcXx6+QmnhNMzdMl8GNsGO9hXNzIlOR4HM=
X-Google-Smtp-Source: AGHT+IGOUfK99ago/evOrlGj0pi4YFg7EEKNgJdbazY59vps+t6ylGtngYjJWYkKZ58+i22OdP1stg==
X-Received: by 2002:a17:906:eec7:b0:a77:ab9e:9202 with SMTP id a640c23a62f3a-a99a0eb9349mr1327215166b.4.1728889196586;
        Sun, 13 Oct 2024 23:59:56 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a13f42e8bsm62471966b.58.2024.10.13.23.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:59:56 -0700 (PDT)
Message-ID: <c3678626-7f5c-4446-9b4d-2650ddf5d5a6@blackwall.org>
Date: Mon, 14 Oct 2024 09:59:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 06/12] net: core: dev: Add
 dev_fill_bridge_path()
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-7-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013185509.4430-7-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 21:55, Eric Woudstra wrote:
> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
> It handles starting from a bridge port instead of the bridge master.
> The structures ctx and nft_forward_info need to be already filled in with
> the (vlan) encaps.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/linux/netdevice.h |  2 +
>  net/core/dev.c            | 77 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e87b5e488325..9d80f650345e 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3069,6 +3069,8 @@ void dev_remove_offload(struct packet_offload *po);
>  
>  int dev_get_iflink(const struct net_device *dev);
>  int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
> +			 struct net_device_path_stack *stack);
>  int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>  			  struct net_device_path_stack *stack);
>  struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd479f5f22f6..49959c4904fc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -713,44 +713,95 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
>  	return &stack->path[k];
>  }
>  
> -int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
> -			  struct net_device_path_stack *stack)
> +static int dev_fill_forward_path_common(struct net_device_path_ctx *ctx,
> +					struct net_device_path_stack *stack)
>  {
>  	const struct net_device *last_dev;
> -	struct net_device_path_ctx ctx = {
> -		.dev	= dev,
> -	};
>  	struct net_device_path *path;
>  	int ret = 0;
>  
> -	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
> -	stack->num_paths = 0;
> -	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
> -		last_dev = ctx.dev;
> +	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
> +		last_dev = ctx->dev;
>  		path = dev_fwd_path(stack);
>  		if (!path)
>  			return -1;
>  
>  		memset(path, 0, sizeof(struct net_device_path));
> -		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
> +		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>  		if (ret < 0)
>  			return -1;
>  
> -		if (WARN_ON_ONCE(last_dev == ctx.dev))
> +		if (WARN_ON_ONCE(last_dev == ctx->dev))
>  			return -1;
>  	}
>  
> -	if (!ctx.dev)
> +	if (!ctx->dev)
>  		return ret;
>  
>  	path = dev_fwd_path(stack);
>  	if (!path)
>  		return -1;
>  	path->type = DEV_PATH_ETHERNET;
> -	path->dev = ctx.dev;
> +	path->dev = ctx->dev;
> +
> +	return ret;
> +}
> +
> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
> +			 struct net_device_path_stack *stack)
> +{
> +	const struct net_device *last_dev, *br_dev;
> +	struct net_device_path *path;
> +	int ret = 0;
> +
> +	stack->num_paths = 0;
> +
> +	if (!ctx->dev || !netif_is_bridge_port(ctx->dev))
> +		return -1;
> +
> +	br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
> +	if (!br_dev || !br_dev->netdev_ops->ndo_fill_forward_path)
> +		return -1;
> +
> +	last_dev = ctx->dev;
> +	path = dev_fwd_path(stack);
> +	if (!path)
> +		return -1;
> +
> +	memset(path, 0, sizeof(struct net_device_path));
> +	ret = br_dev->netdev_ops->ndo_fill_forward_path(ctx, path);
> +	if (ret < 0)
> +		return -1;
> +
> +	if (!ctx->dev || WARN_ON_ONCE(last_dev == ctx->dev))
> +		return -1;
> +
> +	if (!netif_is_bridge_master(ctx->dev))

hmm, do we expect ctx->dev to be a bridge master? Looking at
br_fill_forward_path, it seems to be == fdb->dst->dev which
should be the target port

> +		return dev_fill_forward_path_common(ctx, stack);
> +
> +	path = dev_fwd_path(stack);
> +	if (!path)
> +		return -1;
> +	path->type = DEV_PATH_ETHERNET;
> +	path->dev = ctx->dev;
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(dev_fill_bridge_path);
> +
> +int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
> +			  struct net_device_path_stack *stack)
> +{
> +	struct net_device_path_ctx ctx = {
> +		.dev	= dev,
> +	};
> +
> +	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
> +
> +	stack->num_paths = 0;
> +
> +	return dev_fill_forward_path_common(&ctx, stack);
> +}
>  EXPORT_SYMBOL_GPL(dev_fill_forward_path);
>  
>  /**


