Return-Path: <netdev+bounces-118575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80D952192
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5EC28408B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E661BCA15;
	Wed, 14 Aug 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxM056+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C21BC082;
	Wed, 14 Aug 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658074; cv=none; b=DZOMxmVTIhm+OlaNjGau6QgBVyO3geUvaGs7z01YaQMY/BxfdoGQckha7Qdh+U8m0+fQtLqSrRtw/WLDFavmN48H27X6DxatSXXWDDLQmCfxQqWuk/akkeeuqTh74gOlTh2cLTwW5Hb4yEFQT5vUkWdyT+vUrTXhkvYmxncmgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658074; c=relaxed/simple;
	bh=FOgTWZMVUyVRMXGidaCgtKAQ81y5ZnyA2c4uYArs4qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/y2C+Tr1/XFaA30c5c18kK5l4IHdEDJ4icwukpK7UuSS3sQ7gj2WpB6AFAJe4J/e/90U+wgfCmxRCabATxLbOY1gACuCnPAtP4wUXxp9IC4LG4CR5GNWq033KX8pm82Hca2FfvvAWRlcomQYUxzX7f05YxNVhtSvRdB8FCWoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxM056+C; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso609896d6.2;
        Wed, 14 Aug 2024 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723658071; x=1724262871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EIqNiHrHgtDnjEyOTrZtcTK6ZU4Eeh3i5xeMQgHzr90=;
        b=HxM056+CMX/B7e1uHgEn3ulnpUoLyLDiMqPB7M95DDH1ecQ4qXVFa80Z3lqxhKGD4n
         +cVpvoBNdMAvRZAHZeIvOUKS5n3iunPZAiyOSCNHDd+nTwlMT9sOeBmwsb6Cyp53lLEv
         NslHE8c1qjJK9PoiYAVHFNTX6Bsa06jgU++j9y9DCYHO9iRZS+Gs7pUFusoPZi6QEAgG
         rKIPMPoj28Ce0x69zcZrqEY70QCZnGsNylWOHHi3QTYHKrdniiOVS010BRdQeWPiIC9i
         phdsMQwHXDgGbjqyWQhAsE3sgCgoO3uBLW9ftJTJTK+MtjSLUnA9o29VJnsgwu3jpE41
         xJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658071; x=1724262871;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIqNiHrHgtDnjEyOTrZtcTK6ZU4Eeh3i5xeMQgHzr90=;
        b=OMLi2iFPwHPF/2ZERuQBnDZQLn/4gXDR/GPrr/2k474yQuG1oFZX4vH8cD3mJkLEB8
         Yd/N52F54Oeja00PcEhe0h6eh4kqYEYJSl4Un0gTCzi7xtCkmESCPJFUdqVI98jl2sIH
         UI+9SK30RfMeFzBJyGM6iThCvmjQTNcGDw0b91ZYo9XRoCyNNZnwWIH9Owe8kBzl33hV
         H0z3+wY4+DP93JAg4xBWSgxQSUQutB7XpS8ofYkfcbbLDUVSTRxyPxSwFxy79qwJCFKm
         cuI5YAYi75UZZeXVOhUsQb7fB2VDnHLUJUOtXbHz0BrQzP9Jj4wlKRbo0ZAzcDz8lN6E
         gHug==
X-Forwarded-Encrypted: i=1; AJvYcCVHjotSD/w5qhxagQFooarwNmmeYQ10sReMk5bpKN2HaCO+WAhEKvxP2f7MmL8Hdf2JYd7P/nCdKcx4ZuPGs01JR+3BKmIMvc8m3OGE
X-Gm-Message-State: AOJu0YzFHHIfDsXgWc4FxYM0cUtLIxOBrN4QOX4sjj+HyqZGrq1SPmDh
	DD3FNMO1jzxLLB8h64/jEbENgDX4vMylDWcIxezh7DtxTwb6fD3X
X-Google-Smtp-Source: AGHT+IFUHdLi9kBifztRIcc2wlKCf5t/o+yS31u3ikobz6dsiPyWLh7iQQHN5b1mOEqnzRUCvIaqHA==
X-Received: by 2002:a05:6214:2b9e:b0:6bb:9b66:f263 with SMTP id 6a1803df08f44-6bf5d163f3cmr38184196d6.9.1723658070507;
        Wed, 14 Aug 2024 10:54:30 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bd82c82f31sm46216566d6.57.2024.08.14.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:54:30 -0700 (PDT)
Message-ID: <7d16ba784eb564f9d556f532d670b9bc4698d913.camel@gmail.com>
Subject: Re: [PATCH net-next v13 08/14] mm: page_frag: some minor
 refactoring before adding new API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 14 Aug 2024 10:54:27 -0700
In-Reply-To: <20240808123714.462740-9-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-9-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Refactor common codes from __page_frag_alloc_va_align()
> to __page_frag_cache_reload(), so that the new API can
> make use of them.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h |   2 +-
>  mm/page_frag_cache.c            | 138 ++++++++++++++++++--------------
>  2 files changed, 81 insertions(+), 59 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 4ce924eaf1b1..0abffdd10a1c 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -52,7 +52,7 @@ static inline void *encoded_page_address(unsigned long =
encoded_va)
> =20
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -	nc->encoded_va =3D 0;
> +	memset(nc, 0, sizeof(*nc));
>  }
> =20

Still not a fan of this. Just setting encoded_va to 0 should be enough
as the other fields will automatically be overwritten when the new page
is allocated.

Relying on memset is problematic at best since you then introduce the
potential for issues where remaining somehow gets corrupted but
encoded_va/page is 0. I would rather have both of these being checked
as a part of allocation than just just assuming it is valid if
remaining is set.

I would prefer to keep the check for a non-0 encoded_page value and
then check remaining rather than just rely on remaining as it creates a
single point of failure. With that we can safely tear away a page and
the next caller to try to allocate will populated a new page and the
associated fields.

>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 2544b292375a..4e6b1c4684f0 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -19,8 +19,27 @@
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
> =20
> -static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> -					     gfp_t gfp_mask)
> +static bool __page_frag_cache_reuse(unsigned long encoded_va,
> +				    unsigned int pagecnt_bias)
> +{
> +	struct page *page;
> +
> +	page =3D virt_to_page((void *)encoded_va);
> +	if (!page_ref_sub_and_test(page, pagecnt_bias))
> +		return false;
> +
> +	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> +		free_unref_page(page, encoded_page_order(encoded_va));
> +		return false;
> +	}
> +
> +	/* OK, page count is 0, we can safely set it */
> +	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +	return true;
> +}
> +
> +static bool __page_frag_cache_refill(struct page_frag_cache *nc,
> +				     gfp_t gfp_mask)
>  {
>  	unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>  	struct page *page =3D NULL;
> @@ -35,8 +54,8 @@ static struct page *__page_frag_cache_refill(struct pag=
e_frag_cache *nc,
>  	if (unlikely(!page)) {
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>  		if (unlikely(!page)) {
> -			nc->encoded_va =3D 0;
> -			return NULL;
> +			memset(nc, 0, sizeof(*nc));
> +			return false;
>  		}
> =20
>  		order =3D 0;
> @@ -45,7 +64,33 @@ static struct page *__page_frag_cache_refill(struct pa=
ge_frag_cache *nc,
>  	nc->encoded_va =3D encode_aligned_va(page_address(page), order,
>  					   page_is_pfmemalloc(page));
> =20
> -	return page;
> +	/* Even if we own the page, we do not use atomic_set().
> +	 * This would break get_page_unless_zero() users.
> +	 */
> +	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> +
> +	return true;
> +}
> +
> +/* Reload cache by reusing the old cache if it is possible, or
> + * refilling from the page allocator.
> + */
> +static bool __page_frag_cache_reload(struct page_frag_cache *nc,
> +				     gfp_t gfp_mask)
> +{
> +	if (likely(nc->encoded_va)) {
> +		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
> +			goto out;
> +	}
> +
> +	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> +		return false;
> +
> +out:
> +	/* reset page count bias and remaining to start of new frag */
> +	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +	nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);

One thought I am having is that it might be better to have the
pagecnt_bias get set at the same time as the page_ref_add or the
set_page_count call. In addition setting the remaining value at the
same time probably would make sense as in the refill case you can make
use of the "order" value directly instead of having to write/read it
out of the encoded va/page.

With that we could simplify this function and get something closer to
what we had for the original alloc_va_align code.

> +	return true;
>  }
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc)
> @@ -55,7 +100,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
> =20
>  	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
>  				nc->pagecnt_bias);
> -	nc->encoded_va =3D 0;
> +	memset(nc, 0, sizeof(*nc));
>  }
>  EXPORT_SYMBOL(page_frag_cache_drain);
> =20
> @@ -73,67 +118,44 @@ void *__page_frag_alloc_va_align(struct page_frag_ca=
che *nc,
>  				 unsigned int align_mask)
>  {
>  	unsigned long encoded_va =3D nc->encoded_va;
> -	unsigned int size, remaining;
> -	struct page *page;
> -
> -	if (unlikely(!encoded_va)) {

We should still be checking this before we even touch remaining.
Otherwise we greatly increase the risk of providing a bad virtual
address and have greatly decreased the likelihood of us catching
potential errors gracefully.

> -refill:
> -		page =3D __page_frag_cache_refill(nc, gfp_mask);
> -		if (!page)
> -			return NULL;
> -
> -		encoded_va =3D nc->encoded_va;
> -		size =3D page_frag_cache_page_size(encoded_va);
> -
> -		/* Even if we own the page, we do not use atomic_set().
> -		 * This would break get_page_unless_zero() users.
> -		 */
> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> -
> -		/* reset page count bias and remaining to start of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->remaining =3D size;

With my suggested change above you could essentially just drop the
block starting from the comment and this function wouldn't need to
change as much as it is.

> -	} else {
> -		size =3D page_frag_cache_page_size(encoded_va);
> -	}
> +	unsigned int remaining;
> =20
>  	remaining =3D nc->remaining & align_mask;
> -	if (unlikely(remaining < fragsz)) {
> -		if (unlikely(fragsz > PAGE_SIZE)) {
> -			/*
> -			 * The caller is trying to allocate a fragment
> -			 * with fragsz > PAGE_SIZE but the cache isn't big
> -			 * enough to satisfy the request, this may
> -			 * happen in low memory conditions.
> -			 * We don't release the cache page because
> -			 * it could make memory pressure worse
> -			 * so we simply return NULL here.
> -			 */
> -			return NULL;
> -		}
> -
> -		page =3D virt_to_page((void *)encoded_va);
> =20
> -		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> -			goto refill;
> -
> -		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> -			free_unref_page(page, encoded_page_order(encoded_va));
> -			goto refill;
> -		}

Likewise for this block here. We can essentially just make use of the
__page_frag_cache_reuse function without the need to do a complete
rework of the code.

> +	/* As we have ensured remaining is zero when initializing and draining =
old
> +	 * cache, 'remaining >=3D fragsz' checking is enough to indicate there =
is
> +	 * enough available space for the new fragment allocation.
> +	 */
> +	if (likely(remaining >=3D fragsz)) {
> +		nc->pagecnt_bias--;
> +		nc->remaining =3D remaining - fragsz;
> =20
> -		/* OK, page count is 0, we can safely set it */
> -		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +		return encoded_page_address(encoded_va) +
> +			(page_frag_cache_page_size(encoded_va) - remaining);
> +	}
> =20
> -		/* reset page count bias and remaining to start of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		remaining =3D size;
> +	if (unlikely(fragsz > PAGE_SIZE)) {
> +		/*
> +		 * The caller is trying to allocate a fragment with
> +		 * fragsz > PAGE_SIZE but the cache isn't big enough to satisfy
> +		 * the request, this may happen in low memory conditions. We don't
> +		 * release the cache page because it could make memory pressure
> +		 * worse so we simply return NULL here.
> +		 */
> +		return NULL;
>  	}
> =20
> +	if (unlikely(!__page_frag_cache_reload(nc, gfp_mask)))
> +		return NULL;
> +
> +	/* As the we are allocating fragment from cache by count-up way, the of=
fset
> +	 * of allocated fragment from the just reloaded cache is zero, so remai=
ning
> +	 * aligning and offset calculation are not needed.
> +	 */
>  	nc->pagecnt_bias--;
> -	nc->remaining =3D remaining - fragsz;
> +	nc->remaining -=3D fragsz;
> =20
> -	return encoded_page_address(encoded_va) + (size - remaining);
> +	return encoded_page_address(nc->encoded_va);
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_va_align);
> =20


