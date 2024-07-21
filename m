Return-Path: <netdev+bounces-112349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9099386AD
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A19281061
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993112E5D;
	Sun, 21 Jul 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8PO1Pao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C1078F;
	Sun, 21 Jul 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605233; cv=none; b=OkRE+VHK3lHeRM0vJa9RKdktlx9az5+pCWePEfxTbwo3ZJ0tLIng6Sx9CVdieqIgCBgIWO9L1KtcqbCRArL7OCftIjXGNYcCjiCtM8D/qFF40t2OrAOWkh9x8Yq4NT7Ckamt8pZfQryh4qthNBh/0tHB+bK8e6qMzXdbw7LJgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605233; c=relaxed/simple;
	bh=HdHJNUpQOmnRbk15fzzfe4MbfNKHkUL7EDbJWAx+Moo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2wdhwR2SHb7IHDm3ZGUQdtBxM3ATsyGxoPCxc+K1HhrutKEDC/HcCGF2luiRC/QKugXZf+uDH0yHmvlb3MSantQugqkME9zbppP5PLGIbx6ZOcMEnHWBHmwsG4lu5Lj15hAb1hEvIu9C9/CzjsPB3Qv5mUIcZKobtIYmyxZhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8PO1Pao; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso37535b3a.0;
        Sun, 21 Jul 2024 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721605230; x=1722210030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9TPH+yub+2uMZPFyaF5DryQZTfPrAnPa0K8uakroCBg=;
        b=L8PO1PaoTz7XDa2/YAiE+mAtIWFzSEXO5TNCuUH5/EXf8VCok2zOXiWGRw/vWvS4fM
         lLT6wTnL65UrNhUXmtzRc9rCGEajh9YeXWnqGOwFgM1Woc6SHi/b4Lf7SYA5CkCG9NlK
         B/g9R2a2uDFkNbEeluznr0FbQLLCDwCtF99XKjXqfJ95xyFmN4K3/kprt9Yr2PNWzQEn
         13yo7FPSAAx2shYnEFbMWg6N8P96V1qkB9Czr8DbcaR+hklqL9eeb+Sah8DrQT7CjmMV
         LS7sUt0gf09vxUCbsS3bv8EqOofWowjprk1nG56nNNlXridigUYwrsVDiKxeoitvQvOM
         a4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721605230; x=1722210030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TPH+yub+2uMZPFyaF5DryQZTfPrAnPa0K8uakroCBg=;
        b=p4SxGzBfBCZYKxkgnlNNNvxSsOnBc09wyaORzpGxiAORW02bvTt7iEG3SIb/T5x+Jh
         fy8C0psQtEDTK3G/ZCTk4mSjurcbxIvfFC8x6GSfN85PDbDl5u45lbnJelxUObJst3iQ
         0AKabg9nbVJjejbhd+b2bzDRAJltaUMSOrYX6ANdC6cSP0Uj/fiySg61Qnv8UVHtYrkJ
         RKzX7Sw6FtlCXdrtUBx7UYdK1NZS88+6UEhNRhtNWdwRkZhSUDGV01uZQRXiPZJ+OlkO
         KfPTwWNbhNn0uk8Bkg2aHRxzKhW+fxy8GrivA2ueRS1RYwQal2L7S8AjExcsp7X25D2K
         7b2w==
X-Forwarded-Encrypted: i=1; AJvYcCWLYCGzV05RBueS0iAWYZFk42vLMax9p3akOvi37oM2QgPR5sa2ukZhHAMpuoC71WPjS1oAzDRs30sNXZQuekSujNR+rewBErdP5L9I
X-Gm-Message-State: AOJu0YwQ3CcajtzVnuP8CtTmRSrAK9g2KmCcwCn9QRQks4ogD6A05zBV
	lKjRKrxM8snndHqtNZjcSmMgC7wdl6FXBnJ8zSMkmXM7VXGs8dY4
X-Google-Smtp-Source: AGHT+IEF2CF28gw2Bl73BjJI5bksUNp+zlVFz5xnj7AwHNfsCMOxNLVOB1nZG7dZeZpYsi7MqRbQJw==
X-Received: by 2002:a05:6a00:3cc4:b0:70d:2c8d:bed0 with SMTP id d2e1a72fcca58-70d2c8dc54cmr361287b3a.24.1721605229831;
        Sun, 21 Jul 2024 16:40:29 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70d15c36135sm2154095b3a.60.2024.07.21.16.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 16:40:29 -0700 (PDT)
Message-ID: <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Sun, 21 Jul 2024 16:40:28 -0700
In-Reply-To: <20240719093338.55117-9-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-9-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 17:33 +0800, Yunsheng Lin wrote:
> Refactor common codes from __page_frag_alloc_va_align()
> to __page_frag_cache_refill(), so that the new API can
> make use of them.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h |  2 +-
>  mm/page_frag_cache.c            | 93 +++++++++++++++++----------------
>  2 files changed, 49 insertions(+), 46 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 12a16f8e8ad0..5aa45de7a9a5 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -50,7 +50,7 @@ static inline void *encoded_page_address(unsigned long =
encoded_va)
> =20
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -	nc->encoded_va =3D 0;
> +	memset(nc, 0, sizeof(*nc));
>  }
> =20

I do not like requiring the entire structure to be reset as a part of
init. If encoded_va is 0 then we have reset the page and the flags.
There shouldn't be anything else we need to reset as remaining and bias
will be reset when we reallocate.

>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 7928e5d50711..d9c9cad17af7 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -19,6 +19,28 @@
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
> =20
> +static struct page *__page_frag_cache_recharge(struct page_frag_cache *n=
c)
> +{
> +	unsigned long encoded_va =3D nc->encoded_va;
> +	struct page *page;
> +
> +	page =3D virt_to_page((void *)encoded_va);
> +	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> +		return NULL;
> +
> +	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> +		VM_BUG_ON(compound_order(page) !=3D
> +			  encoded_page_order(encoded_va));
> +		free_unref_page(page, encoded_page_order(encoded_va));
> +		return NULL;
> +	}
> +
> +	/* OK, page count is 0, we can safely set it */
> +	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +
> +	return page;
> +}
> +
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  					     gfp_t gfp_mask)
>  {
> @@ -26,6 +48,14 @@ static struct page *__page_frag_cache_refill(struct pa=
ge_frag_cache *nc,
>  	struct page *page =3D NULL;
>  	gfp_t gfp =3D gfp_mask;
> =20
> +	if (likely(nc->encoded_va)) {
> +		page =3D __page_frag_cache_recharge(nc);
> +		if (page) {
> +			order =3D encoded_page_order(nc->encoded_va);
> +			goto out;
> +		}
> +	}
> +

This code has no business here. This is refill, you just dropped
recharge in here which will make a complete mess of the ordering and be
confusing to say the least.

The expectation was that if we are calling this function it is going to
overwrite the virtual address to NULL on failure so we discard the old
page if there is one present. This changes that behaviour. What you
effectively did is made __page_frag_cache_refill into the recharge
function.

>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> @@ -35,7 +65,7 @@ static struct page *__page_frag_cache_refill(struct pag=
e_frag_cache *nc,
>  	if (unlikely(!page)) {
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>  		if (unlikely(!page)) {
> -			nc->encoded_va =3D 0;
> +			memset(nc, 0, sizeof(*nc));
>  			return NULL;
>  		}
> =20

The memset will take a few more instructions than the existing code
did. I would prefer to keep this as is if at all possible.

> @@ -45,6 +75,16 @@ static struct page *__page_frag_cache_refill(struct pa=
ge_frag_cache *nc,
>  	nc->encoded_va =3D encode_aligned_va(page_address(page), order,
>  					   page_is_pfmemalloc(page));
> =20
> +	/* Even if we own the page, we do not use atomic_set().
> +	 * This would break get_page_unless_zero() users.
> +	 */
> +	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> +
> +out:
> +	/* reset page count bias and remaining to start of new frag */
> +	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +	nc->remaining =3D PAGE_SIZE << order;
> +
>  	return page;
>  }
> =20

Why bother returning a page at all? It doesn't seem like you don't use
it anymore. It looks like the use cases you have for it in patch 11/12
all appear to be broken from what I can tell as you are adding page as
a variable when we don't need to be passing internal details to the
callers of the function when just a simple error return code would do.

> @@ -55,7 +95,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
> =20
>  	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
>  				nc->pagecnt_bias);
> -	nc->encoded_va =3D 0;
> +	memset(nc, 0, sizeof(*nc));
>  }
>  EXPORT_SYMBOL(page_frag_cache_drain);
> =20
> @@ -72,31 +112,9 @@ void *__page_frag_alloc_va_align(struct page_frag_cac=
he *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask)
>  {
> -	unsigned long encoded_va =3D nc->encoded_va;
> -	unsigned int size, remaining;
> -	struct page *page;
> -
> -	if (unlikely(!encoded_va)) {
> -refill:
> -		page =3D __page_frag_cache_refill(nc, gfp_mask);
> -		if (!page)
> -			return NULL;
> -
> -		encoded_va =3D nc->encoded_va;
> -		size =3D page_frag_cache_page_size(encoded_va);
> +	unsigned int size =3D page_frag_cache_page_size(nc->encoded_va);
> +	unsigned int remaining =3D nc->remaining & align_mask;
> =20
> -		/* Even if we own the page, we do not use atomic_set().
> -		 * This would break get_page_unless_zero() users.
> -		 */
> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> -
> -		/* reset page count bias and remaining to start of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->remaining =3D size;
> -	}
> -
> -	size =3D page_frag_cache_page_size(encoded_va);
> -	remaining =3D nc->remaining & align_mask;
>  	if (unlikely(remaining < fragsz)) {

I am not a fan of adding a dependency on remaining being set *before*
encoded_va. The fact is it relies on the size to set it. In addition
this is creating a big blob of code for the conditional paths to have
to jump over.

I think it is much better to first validate encoded_va, and then
validate remaining. Otherwise just checking remaining seems problematic
and like a recipe for NULL pointer accesses.

>  		if (unlikely(fragsz > PAGE_SIZE)) {
>  			/*
> @@ -111,32 +129,17 @@ void *__page_frag_alloc_va_align(struct page_frag_c=
ache *nc,
>  			return NULL;
>  		}
> =20
> -		page =3D virt_to_page((void *)encoded_va);
> -
> -		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> -			goto refill;
> -
> -		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> -			VM_BUG_ON(compound_order(page) !=3D
> -				  encoded_page_order(encoded_va));
> -			free_unref_page(page, encoded_page_order(encoded_va));
> -			goto refill;
> -		}
> -
> -		/* OK, page count is 0, we can safely set it */
> -		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> -
> -		/* reset page count bias and remaining to start of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->remaining =3D size;
> +		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> +			return NULL;
> =20
> +		size =3D page_frag_cache_page_size(nc->encoded_va);

So this is adding yet another setting/reading of size to the recharge
path now. Previously the recharge path could just reuse the existing
size.

>  		remaining =3D size;
>  	}
> =20
>  	nc->pagecnt_bias--;
>  	nc->remaining =3D remaining - fragsz;
> =20
> -	return encoded_page_address(encoded_va) + (size - remaining);
> +	return encoded_page_address(nc->encoded_va) + (size - remaining);
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_va_align);
> =20


