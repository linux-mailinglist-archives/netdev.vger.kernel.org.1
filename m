Return-Path: <netdev+bounces-231651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD6ABFC005
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268D91893841
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0934A791;
	Wed, 22 Oct 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KMxgWjg4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77834A780
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137559; cv=none; b=m6/p3AJXwOSVk+5ACAHhM+KeJ+m54b1+tF0AsJWv57CEG/cQPIu0RWsmYz+IxvRh0/p2RW2As6Vmnwka1FV4tmum6Sc0opzAt4JyMrzeDVdwQHkHGWHXOu1G5zFVbAt47EQdMTHCPOjb3QwwkXnt4sGXQhoS73pUuoEBQcD4+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137559; c=relaxed/simple;
	bh=VZVgC1YwZPF1ZLzGTbrJlddJZQAeaUXbPPpVfaOy9UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+bAxvGAqsfYNolzaGxtx7zuWlPfseVeOwgYkpdwXWwOaML+4CzVWoJ3FtTuv/zdJEdbOAvrXX8R2QeC02efJL88TWBB38Bg6hidqGKswnCt8/JI4a7OQ744MiysIkpE9LtxeK80LvGHjiAOV0Q+0sxEkA/sXohnvgL3HCm0GiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KMxgWjg4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1538534866b.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137554; x=1761742354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYtjFjyDSGPyQgAsiMBskSF57u8HRlpgh4uJI8sR664=;
        b=KMxgWjg4WNDjVE9XUxQ0yF54uDZslDDvlkcXgkbcy4fFDdFX0JKjzQgXxBNdV/qBr9
         CnjfnhJVbkTTouUy20LZ0+t4FARQ/6cRz5awgKB3efrATKQRBFGk2STigyJwrf/SyM9D
         KwNhIk8hfOiV5n7kVXPhvvMOSmc9ihswngmLaDwEwGC+j5E2BGNo1eY8for0xGwEVFcp
         J76R4ZPFMOn4EgGAquqxnexwRjGmt4eJ0CY/mQOdu4RLWklk9iYEGCTD68gNveTLatv8
         mbPM5oSpuRPVbam/RMU77ULjU9j3i7VLuYUDRkMcxyZ4GlgR7lqC5XBZV/73pCwU7g4T
         N6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137554; x=1761742354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYtjFjyDSGPyQgAsiMBskSF57u8HRlpgh4uJI8sR664=;
        b=wjV7icOqNzYZJ17dG20ffTrlnvJecFgVHtSsNZBuk2d2GHpQKQnxfbLJwyL4/7RKAZ
         5X+Po80eHQ02icjRevgJul86gOVkOoZxe+EoU9dx1RfM0KTg/Wj+9g6KTLgEMsdej8+K
         NJx5gD5U8znDGBbPMLPAW9Qupc3MW238KEFWdVoP37QWeSk9zgBxusAZxWlEJy/RCM4i
         I4Pvp90OTjjNClNz+lneYhTk7rDa+lBxEfGE2VxWmr/6pKk78+FtWFBXHRf3x5YrC6yL
         UJhEAUhdkwvHBEJVRLhSMNnA8qBqZuQwQZ5/DDISELfznlICux65tIYYUEYw8UsFpYnb
         P++w==
X-Forwarded-Encrypted: i=1; AJvYcCUwdXVw7bz8X26ljoVnwpv7y+5Bl2jwtJErGBz90hA2xr/pXBS7+1bf6FlI94LRgk5HUYDoHDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkPs+RRIBYrf7YC2gL1i9OmJhrNEXOoQHvcBPkAt4Apkl56Nu
	Jqr4cyGFq7bD/q2NjA44Xc3UBMgvfNI/xFANqnsJQuIG69ds3ZVrOvwVhZjh3aTFR4Y=
X-Gm-Gg: ASbGnct1YkwMMXijo1djdCMtX5QQYNyyIx9ojwIyBmCloNGyqZJaLIHVBvSMWcTW360
	RsA8GYpe/MjMxeGpudkxaQ+vm1Np5RcPejCLWZD/DGGECxXnOZXKe6SaaSrT7KsfHK4u2WZCHGB
	3pRFDQmciZbgzN1QoZwVBmO1ayeqdr0VNibpvFLv9nBdjBLiC8dzg3AXzWudjJQRYHQGDscLdvq
	MM5S+dB3uBeypz3bkjjkLEcWdN7asxg/EuYN5woHkuBuuWt0uHRy0S3Kjx4mgQ8T0gYXXNs8mVj
	orRHWjYPxj85fALPl9WwP1fR/CYXZwbN5QcFUJHAb46SWiVEETYfgmBPsWxTjf6RkQQxUX8nvyO
	0XUOoFajObUI0Wn+SHnUsIfXxWsxVAhbrudx4V0yIlqXASux4ZJjgiDNqBYz78X7jsbM+j/Z+eY
	ixSAEDsVWyAymys4vqmrN2lOwBtOFkNo46yVRFAu5x6d1FmdRPnnMkPQ==
X-Google-Smtp-Source: AGHT+IHlE41iokHBpJyEUCj+aXxvQXK11Z67SspY9zznVrz/3HXGFHcj+KaHBOjAU60lWsLeWCydGw==
X-Received: by 2002:a17:906:9c82:b0:b38:6689:b9fe with SMTP id a640c23a62f3a-b6471d45a01mr2396441966b.7.1761137553282;
        Wed, 22 Oct 2025 05:52:33 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1317990966b.74.2025.10.22.05.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:52:32 -0700 (PDT)
Message-ID: <330d315e-53c0-453e-9b5d-a432c2bbf7d5@blackwall.org>
Date: Wed, 22 Oct 2025 15:52:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/15] xsk: Add small helper xp_pool_bindable
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-9-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-9-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Add another small helper called xp_pool_bindable and move the current
> dev_get_min_mp_channel_count test into this helper. Pass in the pool
> object, such that we derive the netdev from the prior registered pool.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk_buff_pool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 62a176996f02..701be6a5b074 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -54,6 +54,11 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  	return 0;
>  }
>  
> +static bool xp_pool_bindable(struct xsk_buff_pool *pool)
> +{
> +	return dev_get_min_mp_channel_count(pool->netdev) == 0;
> +}
> +
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  						struct xdp_umem *umem)
>  {
> @@ -204,7 +209,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
>  
> -	if (dev_get_min_mp_channel_count(netdev)) {
> +	if (!xp_pool_bindable(pool)) {
>  		err = -EBUSY;
>  		goto err_unreg_pool;
>  	}

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


