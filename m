Return-Path: <netdev+bounces-129534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEB9845B6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE43284173
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC781A7065;
	Tue, 24 Sep 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFdtaymv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491201A7244
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180086; cv=none; b=YFgR77MiutuHQWK+DyrJUcWwuOSHfnTcR7d644bCVEA6ZyogiuqBz4dfBkWiP7ZAKpThof5Yc7+1THHxLaT7l0zxJUJEImMTOTiQvhGIPbHBfweC831SjA3lidjAqdTxGow/7mToRr3ZMtaAuWDIg51yGyYcZJnu3O1tYUqFEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180086; c=relaxed/simple;
	bh=6zR/UvrF1UYm1gePH/CzeYZ0Rct3LUoPYofYf76p/Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZzGf1fINf6MO2HH374n4ECxfJVmrJ8hhD3SVqSm+uH3awvYieqx3mhsJsVRgaMFzdT2vZjLAHVIKLSz28HlHjBwo5S6ClV8YhszuqcJfZs9tJp3XOfvMpQ7aIX8/1e7KjN56vDUx7+tUrJg6Z0NeLiQK1E+yNt3bXo6ssY2BVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFdtaymv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cc8782869so52220315e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727180082; x=1727784882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8UoKdao20kK8GemWzlCdeExcggmpa6CuMrJz5OPm5E=;
        b=WFdtaymvSbN6I85+aYQ/8l5k48dsqz9n/dL06JlgkeFccnwezsdknNabV/4Fs5bX0h
         XT+26yXEdVOB4jQKvLN05I4fiJFMI1StEMb5QIaVZp+ElMx+/j/icmjCuofPPx7KMkqV
         xWTqncow86AJ5Xoe4DcJYFoKPh+qQTTKbRUPJyzwxLpzGjGp7vURa6vUTPtqXxIayDWt
         z8pKCJhIyV5EMDRsG2kgEkBdfMcga60Hek6d+F0VLuhRxSbeWvr83r2+jxojGH1KfYun
         x8PX1DPgcEuZqnuIBbtI3CSRuS20kxxQ335KxawIk/trVY/M7pjs53Bkl8sj4f/TEJZc
         5Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727180082; x=1727784882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8UoKdao20kK8GemWzlCdeExcggmpa6CuMrJz5OPm5E=;
        b=M/CPwcFyQNxd+q4IHpAK8fkTkAqja7bWLM+lCjJNin87YV5FfNYIlOkdvmYVwOlR45
         0E9O3EgBylFIUdPZogkI/8JOeT4ELlA70xJjd6TVUbTTKsqfH6GKDb3ckHi7e663Df4Z
         aPWJXUj/yxd4PvrM6HZqSL3kT9rN9J7PSE9XM3/oN3J9MyQ3reu+WyCV5Hx/dXWRv+m7
         9ee8WYzIusn2M+wa2V7zXs/B6LeurRRwrVxEbSbrmHyEOVg476J7lThNZ97CR63w+Dw+
         7AepuVLP6u8A6KiCpTTFyCYJ6QHMVuBBBhBvj7X+NphFvuULu7B4hvm8rGvj0J8AsSVL
         A8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWML5PdxqhLrFVXQ1Cmyx/+MzvR0Rk0FaHLkWf/btnHhaUQQLYUC0OJ4TOystpo7CAWcQd/FX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Fi2mAus9/X0PQEm3PR2DB2tnM5N1qDR0gglqV3SCsMpQw1MO
	rSPRo3LTq6BKtFGI67HVdOqRLDEEnpMJDhycVva/V+bUrCVdVCm1
X-Google-Smtp-Source: AGHT+IHzyPD/QfTDkwgR0etqMzNtLLm5y6Ywww2p6/4Kzb6RUcc7CQ1NGIGTQirBPYuMuRc/vh7y1A==
X-Received: by 2002:a05:600c:1c04:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42e7ada4c7cmr104079085e9.23.1727180082263;
        Tue, 24 Sep 2024 05:14:42 -0700 (PDT)
Received: from [10.0.0.4] ([37.171.120.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1d15sm1431686f8f.41.2024.09.24.05.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 05:14:41 -0700 (PDT)
Message-ID: <78ae85b7-39e4-46ca-9903-3beb07edf3ac@gmail.com>
Date: Tue, 24 Sep 2024 14:14:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: Add netif_get_gro_max_size helper for GRO
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
References: <20240923212242.15669-1-daniel@iogearbox.net>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20240923212242.15669-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/23/24 11:22 PM, Daniel Borkmann wrote:
> Add a small netif_get_gro_max_size() helper which returns the maximum IPv4
> or IPv6 GRO size of the netdevice.
>
> We later add a netif_get_gso_max_size() equivalent as well for GSO, so that
> these helpers can be used consistently instead of open-coded checks.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>   include/linux/netdevice.h | 9 +++++++++
>   net/core/gro.c            | 9 ++-------
>   2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e87b5e488325..d571451638de 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5029,6 +5029,15 @@ void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
>   void netif_inherit_tso_max(struct net_device *to,
>   			   const struct net_device *from);
>   
> +static inline unsigned int
> +netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
> +{
> +	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
> +	return skb->protocol == htons(ETH_P_IPV6) ?
> +	       READ_ONCE(dev->gro_max_size) :
> +	       READ_ONCE(dev->gro_ipv4_max_size);
> +}
> +
>   static inline bool netif_is_macsec(const struct net_device *dev)
>   {
>   	return dev->priv_flags & IFF_MACSEC;
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 802b4a062400..d1f44084e978 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -98,7 +98,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	unsigned int headlen = skb_headlen(skb);
>   	unsigned int len = skb_gro_len(skb);
>   	unsigned int delta_truesize;
> -	unsigned int gro_max_size;
>   	unsigned int new_truesize;
>   	struct sk_buff *lp;
>   	int segs;
> @@ -112,12 +111,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	if (p->pp_recycle != skb->pp_recycle)
>   		return -ETOOMANYREFS;
>   
> -	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
> -	gro_max_size = p->protocol == htons(ETH_P_IPV6) ?
> -			READ_ONCE(p->dev->gro_max_size) :
> -			READ_ONCE(p->dev->gro_ipv4_max_size);
> -
> -	if (unlikely(p->len + len >= gro_max_size || NAPI_GRO_CB(skb)->flush))
> +	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
> +		     NAPI_GRO_CB(skb)->flush))
>   		return -E2BIG;
>   
>   	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {

