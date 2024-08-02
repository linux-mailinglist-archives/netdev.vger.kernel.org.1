Return-Path: <netdev+bounces-115338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A8945E84
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91C91F21702
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C781DF68B;
	Fri,  2 Aug 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FV81JJ5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918C1BE87A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604709; cv=none; b=WyDzfCVYpC276O7FCgo8Wwpj0qXtscTqbUILgz4exLV3X6aHN/NZ3rNHXCDNamSSYSUD9hmgszQ7snpnxs0I+MpmGvidoJLmdMkPArJFsS+fQ56/icQ1lxqXH78XvsI2c7kUvGQDSHhtTpTXRGPqXLIDgarS8GGyWZCHIZw3DIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604709; c=relaxed/simple;
	bh=yyfYHr25eEIIas0aJF9lF5/PtPAOd0Z6L9WWS4Y5r90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBEcqImK51bcSRQz50ysDy7tJ4+TF/VUopL3pi2tSliWZ6+kmiD4JhYIn0OIiMud0En53uisfM7y16SVNRnpIP0Wgnx7CuMwGMcnygGvmpYS/z6wR8xsZK7CbMAuy0+69x700bqxQk/Hbeff/O1GiU2g8MXQmleDRrOs3W2vHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FV81JJ5I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso55193845e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722604706; x=1723209506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W1wpJ2WayLHZIf/7RUyGa6iS+BBdMBPC3C9vkGu7/Q=;
        b=FV81JJ5Ik1Z0nXPEkfHydhYgf0fOw2J1J2kf+V2qmFhDGOd3BEWAwuH1GT0oattOZs
         VeDOVQcIc9+JfqDkTAjch7KLuRegGlepSyjyqUEXU3M+LHBrjfGIBE7yola1WWjaGmti
         XLiVCCPllnOONCeivFnTaGt4HGKPAZC9dT/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604706; x=1723209506;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W1wpJ2WayLHZIf/7RUyGa6iS+BBdMBPC3C9vkGu7/Q=;
        b=cAdJiyEDYVET3aGlYCdZut3naE2SuJJEe1xgdWgfGQs42B0vHTBR18mWQIKP2WEWy8
         59KoBhPAXpnSG/l7+1RyuLQMqWSsZa9EAMoaS90LHMMboPUCrfOdwACJNfB6ejDXOMow
         hGEEVkhp5qmqLD+4cBqnazmAQldyzj3VyDW0cHgpkzScuOaLgk9f6aCnWv53d5Or/+zy
         H3qeATdhkpyRdA0+T86naPQ1FbKAHkHvpf7kc27WYEYV3tsDlCTwGdCEcefY66uScyKc
         pMhLPm3e1iREv2e6+RvLpOwBpegw80Vg9VXTiT0mt6N/9iNQOwB2rj6KPI6PNanuQFyS
         vQag==
X-Forwarded-Encrypted: i=1; AJvYcCUlO9Ol4wcwFgTziGVxm6bBtWuR2caNNpj4jWWnpaw8405bnX/zqEuRHDXcF3z2Gh4zPFDKpd+AGSn1z90LX1wYHmdzbpyr
X-Gm-Message-State: AOJu0YzZLaF6mHfbNTMiqOx99MDGwljprlgr/Q4y3cf7cXpR6tQz8++d
	NZBe3ikyUYHnBR7zXX8mygxijjnvYk39ErecYvlSqU21LOfcFondmeXrYGh1VNo=
X-Google-Smtp-Source: AGHT+IHXRxlmw6PNPliulPCBFy5AFQ/TsqqipUZGKTSrqzGAy5KJepIHj1VvZkz9En+ppTCoflo3Ig==
X-Received: by 2002:a05:600c:4ed1:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-428e6af1d48mr21783325e9.4.1722604705430;
        Fri, 02 Aug 2024 06:18:25 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bab9f7esm91436015e9.21.2024.08.02.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:18:25 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:18:22 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 08/12] ethtool: rss: report info about
 additional contexts from XArray
Message-ID: <ZqzcnuLphqIROwQ7@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-9-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:57PM -0700, Jakub Kicinski wrote:
> IOCTL already uses the XArray when reporting info about additional
> contexts. Do the same thing in netlink code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/rss.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index 5c477cc36251..023782ca1230 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -82,7 +82,6 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
>  	rxfh.indir = data->indir_table;
>  	rxfh.key_size = data->hkey_size;
>  	rxfh.key = data->hkey;
> -	rxfh.rss_context = request->rss_context;
>  
>  	ret = ops->get_rxfh(dev, &rxfh);
>  	if (ret)
> @@ -95,6 +94,41 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
>  	return ret;
>  }
>  
> +static int
> +rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
> +		struct rss_reply_data *data, const struct genl_info *info)
> +{
> +	struct ethtool_rxfh_context *ctx;
> +	u32 total_size, indir_bytes;
> +	u8 *rss_config;
> +
> +	ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
> +	if (!ctx)
> +		return -ENOENT;
> +
> +	data->indir_size = ctx->indir_size;
> +	data->hkey_size = ctx->key_size;
> +	data->hfunc = ctx->hfunc;
> +	data->input_xfrm = ctx->input_xfrm;
> +
> +	indir_bytes = data->indir_size * sizeof(u32);
> +	total_size = indir_bytes + data->hkey_size;
> +	rss_config = kzalloc(total_size, GFP_KERNEL);
> +	if (!rss_config)
> +		return -ENOMEM;
> +
> +	data->indir_table = (u32 *)rss_config;
> +	memcpy(data->indir_table, ethtool_rxfh_context_indir(ctx), indir_bytes);
> +
> +	if (data->hkey_size) {
> +		data->hkey = rss_config + indir_bytes;
> +		memcpy(data->hkey, ethtool_rxfh_context_key(ctx),
> +		       data->hkey_size);
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  rss_prepare_data(const struct ethnl_req_info *req_base,
>  		 struct ethnl_reply_data *reply_base,
> @@ -115,6 +149,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
>  			return -EOPNOTSUPP;
>  
>  		data->no_key_fields = !ops->rxfh_per_ctx_key;
> +		return rss_prepare_ctx(request, dev, data, info);
>  	}
>  
>  	return rss_prepare_get(request, dev, data, info);
> -- 
> 2.45.2
> 
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

