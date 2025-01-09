Return-Path: <netdev+bounces-156689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A479DA076FB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD1E188B57D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F92185BD;
	Thu,  9 Jan 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFvdpRPD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B97207A06
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428591; cv=none; b=rjvCxhDDmc7WUFp5X7oFKS8vYvR9h3U3qLoG1MXHl+rzdCmbmlvH8w221tQnkIXyyw/BQvoC3N3QC2SDnY+dSOwKNMJlvtRJQbf0zkEiYQPRLPBsV7UvD+GR/zQNdCoPc+ESb3GSvtSGuujvQJOxktOmmSpbkqqmCAUJg5ZGxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428591; c=relaxed/simple;
	bh=O+HYHamx1p3+ILoEPBjBK7OiUlhjeWsSzJqP7OSIwPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZeZDhdo4X5PxcnYLXfnvuj0rgdKGgBTFcqhR+q7Xs5XqhXjy/ezBYOcni+C6xLDd2tnSAW2fRA5dwivhMTjHOnr/Kq4adpJ7kTWPOiYxvOgIBDA4YM4uyVYD/NFm4fOh/e9BXXDzPRGR9Jx17ernsFfytmQYXrUvKNKykpInKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFvdpRPD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736428588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0ZpSa6ZeYEhoz4+5kQn2kH6v7v1MM7x+pBBhTzOknk=;
	b=WFvdpRPDw/YDgI1gsKv17mhHz9RfTCIbDDx0gMuvUZmmf2dlgGk11H1b2Q8VG7ip8qMrub
	HH/9O/9mgE+4NJocOj9aUm+n5JOkeO+QovlfhXgNmMQBNGiP+RkrQH/ljIlwqkr7hTk58a
	Zdli7y68c92v5DuCfm93jG+97sslNvU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-x4VzmoHeMAWiCmXCUk3WVw-1; Thu, 09 Jan 2025 08:16:27 -0500
X-MC-Unique: x4VzmoHeMAWiCmXCUk3WVw-1
X-Mimecast-MFC-AGG-ID: x4VzmoHeMAWiCmXCUk3WVw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87d6c09baso12425296d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 05:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428586; x=1737033386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0ZpSa6ZeYEhoz4+5kQn2kH6v7v1MM7x+pBBhTzOknk=;
        b=fk7XyhFn1Q+z8EwiKycA3x1/fwcMFXn2BMFGl6EEwO6ZcbPWy02tj26P6PmPl4UpvA
         sHjaCBNxtOSjUuGjXU52orZrA8nDyqQXW/j9tgUpo/yt2jMPybO+enbcSQYdKoeQtcVd
         7pft6iVJjietQOlefypmQccLRuGNPK7G3LsLAdWJ9N35MAFwmeF962WHSZ6/gfrhvyi6
         ifgl2uAMAdNt72NUukSIgfR5X4ENMTdAzGLxjKB7k27J1tWgma3OZ7h1t+DGb0b42aOU
         /qZ1+BebopRN+Tagzfi/vm/xxrMtt1rfrKYRF9gQdCjVFJ+su5SuLCuP/nj278rM9YAU
         Jgjw==
X-Forwarded-Encrypted: i=1; AJvYcCVeNNN1WFq0zHWQxKTH+b5QbSuWuaUnxF+Im8+wuSEGiCoYi08Xv/HMIVlsEJs108Lf7429D40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8ljasKpwLUIU3EFBKHTw/SfMTcyDT662rs39dkmQYjLt7IXA
	bkor9k9fNgwEKF63BkfpKl9QyJIXdGp3PXzIVkZVU4Y+6EnhuOkG1s276SXfJWQSuPdbnnsJdik
	Rfj1/8nzrcBiZ2QE/o6edLdlhLlK9AHVarLGlLyroaEHQSAN2ErQS8Q==
X-Gm-Gg: ASbGncunUoY/AijP9VdBHr9/aRY/0g407wXC8ikcUOaQQusYple4Q11NYiI/9gEYe8v
	WVWQ3gGbET+f6RGJnQX9vKDbWjm6KomUY81D4c7F+dDHTkcYpOOFyo4c8y31TCcX77XE6O/YY+s
	4+s0RnbnHVcc0qzqDIFCZ6G67+npTvw6+b5Daf0uag1VHVHcvCrqZ0Mbyzx25f66eEW75/2l6y/
	qfPNZ3OlD9mHpZJfJF2AOm8JI/0B0dyBXsMj8+7co7/h+/RffwXI22hfmoa/6T9YTiI5orFUMAu
	Bz/Yozuo
X-Received: by 2002:a05:6214:19c8:b0:6df:97a3:5e5a with SMTP id 6a1803df08f44-6df9b255d62mr124444696d6.28.1736428586656;
        Thu, 09 Jan 2025 05:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH1xjlf7wVC26WFyHvsKl4IwBJwUPL5AZsOoFJQiN794kJePTIbyPTvBRQQ4UaX2vXG51oZA==
X-Received: by 2002:a05:6214:19c8:b0:6df:97a3:5e5a with SMTP id 6a1803df08f44-6df9b255d62mr124444316d6.28.1736428586323;
        Thu, 09 Jan 2025 05:16:26 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaa0csm201636846d6.5.2025.01.09.05.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:16:25 -0800 (PST)
Message-ID: <d97b6ec6-59fb-4123-9d96-27b9b32dc5cc@redhat.com>
Date: Thu, 9 Jan 2025 14:16:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/8] net: skbuff: introduce
 napi_skb_cache_get_bulk()
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <20250107152940.26530-6-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107152940.26530-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 4:29 PM, Alexander Lobakin wrote:
> Add a function to get an array of skbs from the NAPI percpu cache.
> It's supposed to be a drop-in replacement for
> kmem_cache_alloc_bulk(skbuff_head_cache, GFP_ATOMIC) and
> xdp_alloc_skb_bulk(GFP_ATOMIC). The difference (apart from the
> requirement to call it only from the BH) is that it tries to use
> as many NAPI cache entries for skbs as possible, and allocate new
> ones only if needed.
> 
> The logic is as follows:
> 
> * there is enough skbs in the cache: decache them and return to the
>   caller;
> * not enough: try refilling the cache first. If there is now enough
>   skbs, return;
> * still not enough: try allocating skbs directly to the output array
>   with %GFP_ZERO, maybe we'll be able to get some. If there's now
>   enough, return;
> * still not enough: return as many as we were able to obtain.
> 
> Most of times, if called from the NAPI polling loop, the first one will
> be true, sometimes (rarely) the second one. The third and the fourth --
> only under heavy memory pressure.
> It can save significant amounts of CPU cycles if there are GRO cycles
> and/or Tx completion cycles (anything that descends to
> napi_skb_cache_put()) happening on this CPU.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/skbuff.h |  1 +
>  net/core/skbuff.c      | 62 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..1c089c7c14e1 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1315,6 +1315,7 @@ struct sk_buff *build_skb_around(struct sk_buff *skb,
>  				 void *data, unsigned int frag_size);
>  void skb_attempt_defer_free(struct sk_buff *skb);
>  
> +u32 napi_skb_cache_get_bulk(void **skbs, u32 n);
>  struct sk_buff *napi_build_skb(void *data, unsigned int frag_size);
>  struct sk_buff *slab_build_skb(void *data);
>  
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a441613a1e6c..42eb31dcc9ce 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -367,6 +367,68 @@ static struct sk_buff *napi_skb_cache_get(void)
>  	return skb;
>  }
>  
> +/**
> + * napi_skb_cache_get_bulk - obtain a number of zeroed skb heads from the cache
> + * @skbs: pointer to an at least @n-sized array to fill with skb pointers
> + * @n: number of entries to provide
> + *
> + * Tries to obtain @n &sk_buff entries from the NAPI percpu cache and writes
> + * the pointers into the provided array @skbs. If there are less entries
> + * available, tries to replenish the cache and bulk-allocates the diff from
> + * the MM layer if needed.
> + * The heads are being zeroed with either memset() or %__GFP_ZERO, so they are
> + * ready for {,__}build_skb_around() and don't have any data buffers attached.
> + * Must be called *only* from the BH context.
> + *
> + * Return: number of successfully allocated skbs (@n if no actual allocation
> + *	   needed or kmem_cache_alloc_bulk() didn't fail).
> + */
> +u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
> +{
> +	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
> +	u32 bulk, total = n;
> +
> +	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> +
> +	if (nc->skb_count >= n)
> +		goto get;

I (mis?)understood from the commit message this condition should be
likely, too?!?

> +	/* No enough cached skbs. Try refilling the cache first */
> +	bulk = min(NAPI_SKB_CACHE_SIZE - nc->skb_count, NAPI_SKB_CACHE_BULK);
> +	nc->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +					       GFP_ATOMIC | __GFP_NOWARN, bulk,
> +					       &nc->skb_cache[nc->skb_count]);
> +	if (likely(nc->skb_count >= n))
> +		goto get;
> +
> +	/* Still not enough. Bulk-allocate the missing part directly, zeroed */
> +	n -= kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +				   GFP_ATOMIC | __GFP_ZERO | __GFP_NOWARN,
> +				   n - nc->skb_count, &skbs[nc->skb_count]);

You should probably cap 'n' to NAPI_SKB_CACHE_SIZE. Also what about
latency spikes when n == 48 (should be the maximum possible with such
limit) here?

/P


