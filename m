Return-Path: <netdev+bounces-115799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B77947CF2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C31281116
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D602313AA45;
	Mon,  5 Aug 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdhHm6rr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596A762D2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868593; cv=none; b=CG/vlMweIBVesCeLRc4WsMr7PVKyzy+4vCks2nVb+wxfQwtUjMVjlBI5SKC3vHByOkNdchHutB0sLpLE9X2XtzsE1hNJk3shCxbDG9zHLiuqLbMLd3R/fYvHpsJ6d9GfFAuX/+5ND6bGmNOOMtUemp5Wcct3aalLwwMvH/mQM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868593; c=relaxed/simple;
	bh=QbPN+VHk5miEBdKmS19c2tuDDaUNF0rJfI3MqfpwNT8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e/S5RFka75qfeLci+8/8R5pp0WbjivcaTE2iSkiRQB88/ZxWfNMoMAnuhf1WQt2BdCVHeCSorCdx6mi9N1xFFBGf6eoNd1YqyUBzrgLhUf6S/uEJOgJMSihOl9zehfuD1NbOS6HuKZwxFv1RsQvO68T3faASVMrNq8IOQq3UCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdhHm6rr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so30187495e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722868590; x=1723473390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkC6dpV3xYYRfuyLIwnQpX8ThFeeS8fkJYPGY6EQ4o0=;
        b=bdhHm6rr+fOyPS6SWL1zESWDs9YgFSgvOzOlLUBQ0+vj0mpcxyeZiyCUlVSqP507VU
         GeQlO1TbtD7Lr9OP4F+XOWZtw3GlB5QhmHw9tqg5h/92hF7Umt2IOmkZI0cS0z8h1lDD
         40ytuUuZn0FeuzWJiGRszudNDIyUiolzkVcSRhRUWIHJ6e/AvCQyN9N5mB7MfRHFIAMd
         f5Z8w4Z2c1+BiMu2vGoZrdaSwNXeOw3H632ZFrm977z414kZDsRuP8eXUaedJflabI3K
         lUixfCEYvDmmO07drcnu/vfIHpgy8L7ak2vThUcep0AzeAWuw6Yekxsi3b/qLijNlLDB
         90Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868590; x=1723473390;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkC6dpV3xYYRfuyLIwnQpX8ThFeeS8fkJYPGY6EQ4o0=;
        b=VHO0FY3nsvgWzl+OsJIhtKJuNRjMDdtFmc5P1o1QFwgaBkK3Dyw35Hmz0mACntuMsS
         ojVtQGXoFEgSGyAWYODXhz0cq4drRcOcSxxrXXY7B809lhNk4pKW1priZPT1dLxxORlL
         1uOhgh6hNhQ+KfiDdp5yq2kKpddafApsfTyRDtMpkf2n1mm6q+yyONzzZW1aqAN0oQEr
         JHPCCL32NNjvkQkyNfmQfzXpR/M3L0aPi1u7DAI7w53m7C72zHLOUE1JjSQVgBZpWRQx
         LummH6CM1+/kiji4zj6PztH3Rxw6+IDXZK0ByrxFrMFOBeue1SLqkMTwhfS4st8/DW2s
         OnKg==
X-Gm-Message-State: AOJu0Yz3hCdukuQZpWuSV5wktbQz4845aV3/vBXlV8nBNy2MwATCAIVV
	7xWJCfiqfm97P+DrCtWeVoT7fxXrMvItTsCXz6AJboEZ74tuLkxb
X-Google-Smtp-Source: AGHT+IHVZTyR9Z5qYQcJhqeJ7b6+uXUxYw6ZeXh66lh9lW3173GDeo8LznWSuOQQNiVESfuwVDbr1Q==
X-Received: by 2002:a05:600c:4f53:b0:426:5416:67d7 with SMTP id 5b1f17b1804b1-428e6b7f149mr80285915e9.27.1722868589990;
        Mon, 05 Aug 2024 07:36:29 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0295fasm9947680f8f.59.2024.08.05.07.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:36:29 -0700 (PDT)
Subject: Re: [PATCH net-next v2 06/12] ethtool: rss: don't report key if
 device doesn't support it
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-7-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <2af37636-de5d-913d-4ccf-9388f1cfbd26@gmail.com>
Date: Mon, 5 Aug 2024 15:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-7-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> marvell/otx2 and mvpp2 do not support setting different
> keys for different RSS contexts. Contexts have separate
> indirection tables but key is shared with all other contexts.
> This is likely fine, indirection table is the most important
> piece.

Since drivers that do not support this are the odd ones out,
 would it be better to invert the sense of the flag?  Or is
 this to make sure that driver authors who don't think/know
 about the distinction automatically get safe behaviour?

> Don't report the key-related parameters from such drivers.
> This prevents driver-errors, e.g. otx2 always writes
> the main key, even when user asks to change per-context key.
> The second reason is that without this change tracking
> the keys by the core gets complicated. Even if the driver
> correctly reject setting key with rss_context != 0,
> change of the main key would have to be reflected in
> the XArray for all additional contexts.
> 
> Since the additional contexts don't have their own keys
> not including the attributes (in Netlink speak) seems
> intuitive. ethtool CLI seems to deal with it just fine.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
> index 746b5314acb5..127b9d6ade6f 100644
> --- a/drivers/net/ethernet/sfc/ef100_ethtool.c
> +++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
> @@ -58,6 +58,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
>  
>  	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
> +	.rxfh_per_ctx_key	= 1,

I would prefer 'true' for the sfc drivers, I think that
 better fits the general style of our code.

>  	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
>  	.get_rxfh		= efx_ethtool_get_rxfh,
>  	.set_rxfh		= efx_ethtool_set_rxfh,
> diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> index 15245720c949..e4d86123b797 100644
> --- a/drivers/net/ethernet/sfc/ethtool.c
> +++ b/drivers/net/ethernet/sfc/ethtool.c
> @@ -267,6 +267,7 @@ const struct ethtool_ops efx_ethtool_ops = {
>  	.set_rxnfc		= efx_ethtool_set_rxnfc,
>  	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
> +	.rxfh_per_ctx_key	= 1,
>  	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
>  	.get_rxfh		= efx_ethtool_get_rxfh,
>  	.set_rxfh		= efx_ethtool_set_rxfh,
> diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
> index 4c182d4edfc2..6d4e5101433a 100644
> --- a/drivers/net/ethernet/sfc/siena/ethtool.c
> +++ b/drivers/net/ethernet/sfc/siena/ethtool.c
> @@ -241,6 +241,7 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
>  
>  const struct ethtool_ops efx_siena_ethtool_ops = {
>  	.cap_rss_ctx_supported	= true,
> +	.rxfh_per_ctx_key	= true,

For the record, Siena hardware doesn't actually support
 custom RSS contexts; the code is only present in the
 driver as a holdover from when Siena and EF10 used the
 same driver.  Trying to actually use them on Siena will
 fail -EOPNOTSUPP.[1]
I'll send a patch to rip it out.

>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_USECS_IRQ |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 55c9f613ab64..16f72a556fe9 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -731,6 +731,8 @@ struct kernel_ethtool_ts_info {
>   *	do not have to set this bit.
>   * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
>   *	RSS.
> + * @rxfh_per_ctx_key: device supports setting different RSS key for each
> + *	additional context.

This comment should really make clear that it covers hfunc and
 input_xfrm as well, not just the key itself.

-ed

[1]: https://elixir.bootlin.com/linux/v6.10.3/source/drivers/net/ethernet/sfc/siena/ethtool_common.c#L1234

