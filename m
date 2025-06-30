Return-Path: <netdev+bounces-202419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90640AEDCC0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8139F1897EC2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942827054C;
	Mon, 30 Jun 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FUed8H3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93D21C186
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286482; cv=none; b=k4jb8oFY5M8gFc3jteREv5K1ZmKBIit9Oio4ZmDh4iDM1aDgQqTA+bnZMe0QCxX+bgi8JanxueG7IukjD5tvMKu6nyT+rdIvf1hJw3SdA34KV6N1HcKy1S/x1409/X1tfbqgY865xVN8oTV5FuJ9LUDGMy64278nCk0jW9o5tsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286482; c=relaxed/simple;
	bh=5QvGo34Idqd2mWIWC2d0V+D5mB9tW+t27GVhCDcaX7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMYjsPeSMXVuD/IeZBzwa8rCs3wABxPahwjl9igPqbG/DEkinOIejnXT0lwJqT5GLtVE7b5Zv+Uv4Owegbgl/TK+iAkJaVS6QKgSuaTA4/sR31g9HwqRseKD4DeInRu2nsPbym0uLAz35Rx3pJuysOcblPLZ4neuF+Jj09NGuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FUed8H3m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4536c6b2506so634155e9.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751286478; x=1751891278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kVr731C0q7TIEA3no49GLz+09hKnzzjg3o/ub9MKWhM=;
        b=FUed8H3mN9AfOh7sC0cBM3IJPPfbjtg09iHh0TaiKupEh/Yr/O2Qp7K11QO5jnToZl
         titkp5vqaLMIgexcpwMRuuCjRN6hj1T4Sl3j8o+NvavPZn74e6QNo6QFEresFHGMWwaC
         dz+lvlaToYw9x1nzlb2/TZaKtDX2kcRAv/yYRDdE75SD5/Z4AwgrLUqCYPIAysQ65fPs
         hMg7la6NTguENgTYo+Y4MCz52P6v/ozf66bSLHcts0rrNtYoylAtIDFkvYOVQsUAqOvf
         i5Lo49eV68wqx61KcDOZIKqQ6ZVgofuLLGoY19HWQPd30bdKghSHwAjS6FwmeOq26Y/W
         NeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286478; x=1751891278;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVr731C0q7TIEA3no49GLz+09hKnzzjg3o/ub9MKWhM=;
        b=gF3OhblMc4SnERGXqOjGxHgxLxTD9Hcl5kv04sW33rqXhT07hEV5x+rIOZBK2yUtQx
         E8ElZ1wbx6N4b1aibWlYaElY/OkdQUUaW0iwQ9Z51NylzdM5a82xGPXt+Jakl2TJw+Wq
         hhh+52UT0UQeY+3fSMSjmmxdiZw0c5BnYh49nSXM/7oCctvlz3DqYv3nCaztezhHhiB8
         N4OHqvQ0mT028PPZLVPBAuvy7NZm4oo7p4ghTFB5jk2vsw1p8eZqYNlV08dub/oC35gF
         PcnOU3lzIwqghoIerxEsd3XPXFpTP3XT16Xm+phJanmfUM+sgVqsMikswmpviA2LENmO
         qk7g==
X-Forwarded-Encrypted: i=1; AJvYcCW+FsJ2lGDj1ZucWS55ePyRVqjBHamzgT16m7nalCeskjr4GbEfem0WlSch2zzqvcu73qizSHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrttyL6CXjMAtvSezQ/qi43rnFCSDrGdnpGIl3hHwg/R5XaFKR
	3xONkN9xvNJ9j9pbfujGXYz7KZbTNTZVIB8+qwN09iK37nXI3csdfJ5HbPTTkJlkaEo=
X-Gm-Gg: ASbGncvlgT5FZ1TE4OoYPulOfkUmUVpZxZdZyHBjFIWQ9Mdi/gdu+i2TlCIvaWz71Gu
	Oqv1QYrHm8h4dvKfecdw/hK+kWo/khaPg61HDFJOGDLrCMOEy9pZtZ+FU3rRgF+nBhySWd2bPkF
	3sIcjJ8NNDXs9dsHemcAHmulxf5DOYwSaNTTmgNDOb91MunXgiwh1+lgoYCHg1QXrQI8IVskjiv
	oIuHT6lQv3h8knn69E3xHTe1c4M0UWYUJU0RZ1ltyyeznDw98uBwRjlL4Wrmb2l5E4IDcAXLsWT
	NV6WIaY2nFYjYfP4B2zvZzubwwR402nbLVOZt4M8+ACPVXSerEH1smXLATSUlJ2PmIJgcbED4b6
	la/oWwkvq3bcli1CADPdGRqdp8nXsgUdiN2sZ
X-Google-Smtp-Source: AGHT+IHUGmjkKVWMQcIySVdeQPoJAHsZ0YI4t0XUOUDmBgsNCarAIs0o/N3zyqjaF9yEow7Rnvy1NA==
X-Received: by 2002:a05:600c:1f94:b0:43d:fa5e:50e6 with SMTP id 5b1f17b1804b1-453953e9e9emr32734865e9.9.1751286478124;
        Mon, 30 Jun 2025 05:27:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:cc64:16a4:75d:d7e2? ([2a01:e0a:b41:c160:cc64:16a4:75d:d7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5aesm10177622f8f.44.2025.06.30.05.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 05:27:57 -0700 (PDT)
Message-ID: <11958ea7-8f4b-4ac3-8e6a-7ce4e1c13441@6wind.com>
Date: Mon, 30 Jun 2025 14:27:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] xfrm: Duplicate SPI Handling
To: Aakash Kumar S <saakashkumar@marvell.com>, netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com,
 antony@phenome.org
References: <20250624181054.1502835-1-saakashkumar@marvell.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250624181054.1502835-1-saakashkumar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/06/2025 à 20:10, Aakash Kumar S a écrit :
> The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
> Netlink message, which triggers the kernel function xfrm_alloc_spi().
> This function is expected to ensure uniqueness of the Security Parameter
> Index (SPI) for inbound Security Associations (SAs). However, it can
> return success even when the requested SPI is already in use, leading
> to duplicate SPIs assigned to multiple inbound SAs, differentiated
> only by their destination addresses.
> 
> This behavior causes inconsistencies during SPI lookups for inbound packets.
> Since the lookup may return an arbitrary SA among those with the same SPI,
> packet processing can fail, resulting in packet drops.
> 
> According to RFC 4301 section 4.4.2 , for inbound processing a unicast SA
> is uniquely identified by the SPI and optionally protocol.
> 
> Reproducing the Issue Reliably:
> To consistently reproduce the problem, restrict the available SPI range in
> charon.conf : spi_min = 0x10000000 spi_max = 0x10000002
> This limits the system to only 2 usable SPI values.
> Next, create more than 2 Child SA. each using unique pair of src/dst address.
> As soon as the 3rd Child SA is initiated, it will be assigned a duplicate
> SPI, since the SPI pool is already exhausted.
> With a narrow SPI range, the issue is consistently reproducible.
> With a broader/default range, it becomes rare and unpredictable.
> 
> Current implementation:
> xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
> So if two SAs have the same SPI but different destination addresses, then
> they will:
> a. Hash into different buckets
> b. Be stored in different linked lists (byspi + h)
> c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
> As a result, the lookup will result in NULL and kernel allows that Duplicate SPI
> 
> Proposed Change:
> xfrm_state_lookup_spi_proto() does a truly global search - across all states,
> regardless of hash bucket and matches SPI and proto.
> 
> Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
> ---
>  net/xfrm/xfrm_state.c | 78 ++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 341d79ecb5c2..74855af27d15 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1714,6 +1714,28 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
>  }
>  EXPORT_SYMBOL(xfrm_state_lookup_byspi);
>  
> +static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
> +{
> +    struct xfrm_state *x;
> +    unsigned int i;
> +
> +    rcu_read_lock();
> +
> +    for (i = 0; i <= net->xfrm.state_hmask; i++) {
> +        hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
> +            if (x->id.spi == spi && x->id.proto == proto) {
> +                if (!xfrm_state_hold_rcu(x))
> +                    continue;
> +                rcu_read_unlock();
> +                return x;
> +            }
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return NULL;
> +}
The whole function is indented with spaces.

> +
>  static void __xfrm_state_insert(struct xfrm_state *x)
>  {
>  	struct net *net = xs_net(x);
> @@ -2547,10 +2569,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	unsigned int h;
>  	struct xfrm_state *x0;
>  	int err = -ENOENT;
> -	__be32 minspi = htonl(low);
> -	__be32 maxspi = htonl(high);
> +	u32 range = high - low + 1;
>  	__be32 newspi = 0;
> -	u32 mark = x->mark.v & x->mark.m;
>  
>  	spin_lock_bh(&x->lock);
>  	if (x->km.state == XFRM_STATE_DEAD) {
> @@ -2564,39 +2584,35 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  
>  	err = -ENOENT;
>  
> -	if (minspi == maxspi) {
> -		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
> -		if (x0) {
> -			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
> -			xfrm_state_put(x0);
> -			goto unlock;
> -		}
> -		newspi = minspi;
> -	} else {
> -		u32 spi = 0;
> -		for (h = 0; h < high-low+1; h++) {
> -			spi = get_random_u32_inclusive(low, high);
> -			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
> -			if (x0 == NULL) {
> -				newspi = htonl(spi);
> -				break;
> -			}
> -			xfrm_state_put(x0);
> -		}
> -	}
> -	if (newspi) {
> +	for (h = 0; h < range; h++) {
> +		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
> +		newspi = htonl(spi);
> +
>  		spin_lock_bh(&net->xfrm.xfrm_state_lock);
> -		x->id.spi = newspi;
> -		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
> -		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
> -				  x->xso.type);
> +		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
> +		if (!x0) {
> +			x->id.spi = newspi;
> +			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
> +			XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h, x->xso.type);
> +			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> +			err = 0;
> +			goto unlock;
> +                }
The above line also.

> +		xfrm_state_put(x0);
>  		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  
> -		err = 0;
> -	} else {
> -		NL_SET_ERR_MSG(extack, "No SPI available in the requested range");
> +		if (signal_pending(current)) {
> +			err = -ERESTARTSYS;
> +			goto unlock;
> +                }
And this one ^

> +
> +		if (low == high)
> +			break;
>  	}
>  
> +	if (err)
> +		NL_SET_ERR_MSG(extack, "No SPI available in the requested range");
> +
>  unlock:
>  	spin_unlock_bh(&x->lock);
>  


