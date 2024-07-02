Return-Path: <netdev+bounces-108300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73B91EBB2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CC2838B8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB0372;
	Tue,  2 Jul 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9YlDVI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C79ECC;
	Tue,  2 Jul 2024 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878912; cv=none; b=Q/pmE0gOOovShhmHDrpcE3y9d5xv8FbyZW8Ik4vhm1uPcQ0jYgGrjtJ3W599PJBjMir8l7ZIM6A8dBelXiNQqUII8sH6xzfjLIc+JNxdlzrbsRnP4CzkgL4019BIpmJ3PTTNAyCE3qcCgekV3sLt+ZTT+uVjWHmBlOtlif11zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878912; c=relaxed/simple;
	bh=FDVWcLmwNg13JppX8QDj1e6CIDHM2o7mhcfA8dmytKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ae8mAP4qZ+eyYkdbvRQs5R/r5NctCHVlmIU+vKOUzSqd56aqAXRVxmVmmmQW2g1yNmFvX3D+FNmY86gNAnNP6gGe2PZ4MmZDJH7Ke0UNVNxDUqjgJfPkAV7ioSXtlTuYF9wGjvntgHYkEdPRXFW5arjZQEZYoJ0wCrMyGrRoKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9YlDVI0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so2161153b3a.0;
        Mon, 01 Jul 2024 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719878910; x=1720483710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwXlu1WVqsnVJZ9utDU8T7rgXo210umX1xN+HtCfvHk=;
        b=H9YlDVI0z+Kxlg4pC7AWo4BDrAXGNywsbeoWDywis8cZWz3A0V4wP4SChSiMjfNr3+
         KbY1Dvv2UB1K0QHwrbKr/dXIw0PjR0C9GLitrANt2iKAxUIlWl7JdenDLe4ynkpbV1MQ
         tl9yykkW75PqI0GRo83zodVN3ezkRIyk1Na9J+2fAvJ0Ouf9lDJXIFkAlxgBu17RTvmz
         FeHf6JRftzSUivyh3BYQrEFxcwLDvZHNP85IPNt8+GuUaetUj1HvcwV71ILC62RUKIvv
         XY1QJXLH+Unpc9EdLxMcvApIVY3+gLmoQ5gxi0J6wC0KvSvzK/DJTys4csGjFH3R7GFT
         PmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719878910; x=1720483710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwXlu1WVqsnVJZ9utDU8T7rgXo210umX1xN+HtCfvHk=;
        b=niMe3ae3pLGatTXxTmh3Spd2gPE+mK2/wElXhNck1VCrA7T9tKui4hrT3k6Ia8cZlV
         HpjmP+ecg8rPS3DgvqyDKzNimXIUssI++sqD4Yysz5P5EUjLlGiZsTAb6AWoS//BoXom
         ZTMWBLSIG/mrk4NniwPQMzFTEI5sP4Rcntxn6ar70hnrXYsXGhzSpdQAiM+Saieouyp4
         utZyW8xTpHzh236uzmsTqs0p00OADXMtLKTOa1GYw7bnrjIHmkPFBVOE+al1MJOpY+EK
         KCG0HlDugc7T9JIo6tFo0GmgJQY1Jdlv6blhMF5QiRznGlrZOlEyMscmio2kaj8gWmrr
         5fuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVirNcs8t0qsRxsI9n9rlnvTLZG0RMIaOAOIbn27kBjtOeXqKGV2unDJfpChTyUhSb4NVEihZn2MN8qHLsiWBcq7leff8M1xefavI1l
X-Gm-Message-State: AOJu0YxnMDORecAfWaBN0M+ixH5Y9bd8VtMUz0d4t2gFPvuGgRETPAE6
	pjgQO3F+InG4/8/Xt1mJQ9vsN0sO48IfUjIiw9HCU5Kuqhj0q7Dm
X-Google-Smtp-Source: AGHT+IFL9tfJxnSiQ1ohuj80uEisjABTfCEmpgMn4bUaZduxfPeqy8o3YyadjSYRSeX9qvb5RNfDgg==
X-Received: by 2002:a05:6a21:6d96:b0:1be:ca24:964c with SMTP id adf61e73a8af0-1bef6109d5bmr11975347637.16.1719878909973;
        Mon, 01 Jul 2024 17:08:29 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fac1535b94sm70925405ad.155.2024.07.01.17.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 17:08:29 -0700 (PDT)
Message-ID: <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Mon, 01 Jul 2024 17:08:28 -0700
In-Reply-To: <20240625135216.47007-7-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-7-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> Currently there is one 'struct page_frag' for every 'struct
> sock' and 'struct task_struct', we are about to replace the
> 'struct page_frag' with 'struct page_frag_cache' for them.
> Before begin the replacing, we need to ensure the size of
> 'struct page_frag_cache' is not bigger than the size of
> 'struct page_frag', as there may be tens of thousands of
> 'struct sock' and 'struct task_struct' instances in the
> system.
>=20
> By or'ing the page order & pfmemalloc with lower bits of
> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> And page address & pfmemalloc & order is unchanged for the
> same page in the same 'page_frag_cache' instance, it makes
> sense to fit them together.
>=20
> Also, it is better to replace 'offset' with 'remaining', which
> is the remaining size for the cache in a 'page_frag_cache'
> instance, we are able to do a single 'fragsz > remaining'
> checking for the case of cache not being enough, which should be
> the fast path if we ensure size is zoro when 'va' =3D=3D NULL by
> memset'ing 'struct page_frag_cache' in page_frag_cache_init()
> and page_frag_cache_drain().
>=20
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h | 76 +++++++++++++++++++++++-----
>  mm/page_frag_cache.c            | 90 ++++++++++++++++++++-------------
>  2 files changed, 118 insertions(+), 48 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 6ac3a25089d1..b33904d4494f 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -8,29 +8,81 @@
>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
> =20
> -struct page_frag_cache {
> -	void *va;
> +/*
> + * struct encoded_va - a nonexistent type marking this pointer
> + *
> + * An 'encoded_va' pointer is a pointer to a aligned virtual address, wh=
ich is
> + * at least aligned to PAGE_SIZE, that means there are at least 12 lower=
 bits
> + * space available for other purposes.
> + *
> + * Currently we use the lower 8 bits and bit 9 for the order and PFMEMAL=
LOC
> + * flag of the page this 'va' is corresponding to.
> + *
> + * Use the supplied helper functions to endcode/decode the pointer and b=
its.
> + */
> +struct encoded_va;
> +

Why did you create a struct for this? The way you use it below it is
just a pointer. No point in defining a struct that doesn't exist
anywhere.

> +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
> +
> +static inline struct encoded_va *encode_aligned_va(void *va,
> +						   unsigned int order,
> +						   bool pfmemalloc)
> +{
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	__u16 offset;
> -	__u16 size;
> +	return (struct encoded_va *)((unsigned long)va | order |
> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>  #else
> -	__u32 offset;
> +	return (struct encoded_va *)((unsigned long)va |
> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> +#endif
> +}
> +
> +static inline unsigned long encoded_page_order(struct encoded_va *encode=
d_va)
> +{
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline bool encoded_page_pfmemalloc(struct encoded_va *encoded_va=
)
> +{
> +	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_va;
> +}
> +

My advice is that if you just make encoded_va an unsigned long this
just becomes some FIELD_GET and bit operations.

> +static inline void *encoded_page_address(struct encoded_va *encoded_va)
> +{
> +	return (void *)((unsigned long)encoded_va & PAGE_MASK);
> +}
> +
> +struct page_frag_cache {
> +	struct encoded_va *encoded_va;

This should be an unsigned long, not a pointer since you are storing
data other than just a pointer in here. The pointer is just one of the
things you extract out of it.

> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> +	u16 pagecnt_bias;
> +	u16 remaining;
> +#else
> +	u32 pagecnt_bias;
> +	u32 remaining;
>  #endif
> -	/* we maintain a pagecount bias, so that we dont dirty cache line
> -	 * containing page->_refcount every time we allocate a fragment.
> -	 */
> -	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
>  };
> =20
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -	nc->va =3D NULL;
> +	memset(nc, 0, sizeof(*nc));

Shouldn't need to memset 0 the whole thing. Just setting page and order
to 0 should be enough to indicate that there isn't anything there.

>  }
> =20
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
> -	return !!nc->pfmemalloc;
> +	return encoded_page_pfmemalloc(nc->encoded_va);
> +}
> +
> +static inline unsigned int page_frag_cache_page_size(struct encoded_va *=
encoded_va)
> +{
> +	return PAGE_SIZE << encoded_page_order(encoded_va);
>  }
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc);
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index dd640af5607a..a3316dd50eff 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -18,34 +18,61 @@
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
> =20
> +static void *page_frag_cache_current_va(struct page_frag_cache *nc)
> +{
> +	struct encoded_va *encoded_va =3D nc->encoded_va;
> +
> +	return (void *)(((unsigned long)encoded_va & PAGE_MASK) |
> +		(page_frag_cache_page_size(encoded_va) - nc->remaining));
> +}
> +

Rather than an OR here I would rather see this just use addition.
Otherwise this logic becomes overly complicated.

>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  					     gfp_t gfp_mask)
>  {
>  	struct page *page =3D NULL;
>  	gfp_t gfp =3D gfp_mask;
> +	unsigned int order;
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>  	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>  				PAGE_FRAG_CACHE_MAX_ORDER);
> -	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>  #endif
> -	if (unlikely(!page))
> +	if (unlikely(!page)) {
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +		if (unlikely(!page)) {
> +			memset(nc, 0, sizeof(*nc));
> +			return NULL;
> +		}
> +
> +		order =3D 0;
> +		nc->remaining =3D PAGE_SIZE;
> +	} else {
> +		order =3D PAGE_FRAG_CACHE_MAX_ORDER;
> +		nc->remaining =3D PAGE_FRAG_CACHE_MAX_SIZE;
> +	}
> =20
> -	nc->va =3D page ? page_address(page) : NULL;
> +	/* Even if we own the page, we do not use atomic_set().
> +	 * This would break get_page_unless_zero() users.
> +	 */
> +	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> =20
> +	/* reset page count bias of new frag */
> +	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;

I would rather keep the pagecnt_bias, page reference addition, and
resetting of remaining outside of this. The only fields we should be
setting are order, the virtual address, and pfmemalloc since those are
what is encoded in your unsigned long variable.

> +	nc->encoded_va =3D encode_aligned_va(page_address(page), order,
> +					   page_is_pfmemalloc(page));
>  	return page;
>  }
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc)
>  {
> -	if (!nc->va)
> +	if (!nc->encoded_va)
>  		return;
> =20
> -	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
> -	nc->va =3D NULL;
> +	__page_frag_cache_drain(virt_to_head_page(nc->encoded_va),
> +				nc->pagecnt_bias);
> +	memset(nc, 0, sizeof(*nc));

Again, no need for memset when "nv->encoded_va =3D 0" will do.

>  }
>  EXPORT_SYMBOL(page_frag_cache_drain);
> =20
> @@ -62,51 +89,41 @@ void *__page_frag_alloc_va_align(struct page_frag_cac=
he *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask)
>  {
> -	unsigned int size =3D PAGE_SIZE;
> +	struct encoded_va *encoded_va =3D nc->encoded_va;
>  	struct page *page;
> -	int offset;
> +	int remaining;
> +	void *va;
> =20
> -	if (unlikely(!nc->va)) {
> +	if (unlikely(!encoded_va)) {
>  refill:
> -		page =3D __page_frag_cache_refill(nc, gfp_mask);
> -		if (!page)
> +		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>  			return NULL;
> =20
> -		/* Even if we own the page, we do not use atomic_set().
> -		 * This would break get_page_unless_zero() users.
> -		 */
> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> -
> -		/* reset page count bias and offset to start of new frag */
> -		nc->pfmemalloc =3D page_is_pfmemalloc(page);
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->offset =3D 0;
> +		encoded_va =3D nc->encoded_va;
>  	}
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	/* if size can vary use size else just use PAGE_SIZE */
> -	size =3D nc->size;
> -#endif
> -
> -	offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> -	if (unlikely(offset + fragsz > size)) {
> -		page =3D virt_to_page(nc->va);
> -
> +	remaining =3D nc->remaining & align_mask;
> +	remaining -=3D fragsz;
> +	if (unlikely(remaining < 0)) {

Now this is just getting confusing. You essentially just added an
additional addition step and went back to the countdown approach I was
using before except for the fact that you are starting at 0 whereas I
was actually moving down through the page.

What I would suggest doing since "remaining" is a negative offset
anyway would be to look at just storing it as a signed negative number.
At least with that you can keep to your original approach and would
only have to change your check to be for "remaining + fragsz <=3D 0".
With that you can still do your math but it becomes an addition instead
of a subtraction.

> +		page =3D virt_to_page(encoded_va);
>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>  			goto refill;
> =20
> -		if (unlikely(nc->pfmemalloc)) {
> -			free_unref_page(page, compound_order(page));
> +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> +			VM_BUG_ON(compound_order(page) !=3D
> +				  encoded_page_order(encoded_va));
> +			free_unref_page(page, encoded_page_order(encoded_va));
>  			goto refill;
>  		}
> =20
>  		/* OK, page count is 0, we can safely set it */
>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> =20
> -		/* reset page count bias and offset to start of new frag */
> +		/* reset page count bias and remaining of new frag */
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		offset =3D 0;
> -		if (unlikely(fragsz > PAGE_SIZE)) {
> +		nc->remaining =3D remaining =3D page_frag_cache_page_size(encoded_va);
> +		remaining -=3D fragsz;
> +		if (unlikely(remaining < 0)) {
>  			/*
>  			 * The caller is trying to allocate a fragment
>  			 * with fragsz > PAGE_SIZE but the cache isn't big

I find it really amusing that you went to all the trouble of flipping
the logic just to flip it back to being a countdown setup. If you were
going to bother with all that then why not just make the remaining
negative instead? You could save yourself a ton of trouble that way and
all you would need to do is flip a few signs.

> @@ -120,10 +137,11 @@ void *__page_frag_alloc_va_align(struct page_frag_c=
ache *nc,
>  		}
>  	}
> =20
> +	va =3D page_frag_cache_current_va(nc);
>  	nc->pagecnt_bias--;
> -	nc->offset =3D offset + fragsz;
> +	nc->remaining =3D remaining;
> =20
> -	return nc->va + offset;
> +	return va;
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_va_align);
> =20

Not sure I am huge fan of the way the order of operations has to get so
creative for this to work.  Not that I see a better way to do it, but
my concern is that this is going to add technical debt as I can easily
see somebody messing up the order of things at some point in the future
and generating a bad pointer.

