Return-Path: <netdev+bounces-118631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A395245F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314EA1F25369
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75471C68AC;
	Wed, 14 Aug 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBYUkfiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAB1B9B59;
	Wed, 14 Aug 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669228; cv=none; b=KMM8+GFdjYfLggorFTOTbGErXmHwCd0guPOlvCmdYOCyNviez4w7+Nau5WuGDNarJ7j2VymFOLlKH4yhgWVK0uBMvqQouzIaztwczq1RaN9CMqPlzb5dqP0RocA7TuqfCx8D8pnJ8aCqykryk3x7YpmWgvbfLJZ+geceXCxmQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669228; c=relaxed/simple;
	bh=DzDTsvmObquPyGzIFTK7wf7BeEVUJOGrq0ajpa/zX08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcG8iRNabzs0trywc45U2bSNGfygwVPgD7QoUrqnqoSs2jqZQolfXHjNa3+6QCbnJZAYL1wEgvcI3h6Ubi9pM5nwcXVveuzwrZIMWVBRFRWy/0RSwKrsrg51ny9DsH7mghqUeFcfN3c8jueAGzHVzzcgOSoPszFadb2Wd3h47pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBYUkfiI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2689f749702so187247fac.3;
        Wed, 14 Aug 2024 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669224; x=1724274024; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1NygBbcJ8x72qP+tM/Wp1YkzJ5Lw47jE4xYaVvdbwc=;
        b=TBYUkfiICBbWPeIT/Yu/ISzhWChMqIbSKOS0KYgWLrU6drwvAG455hZ4R4pBOcf6RS
         ViFqlfM6VNOyu0FlKyrC9okIVnbNvWb2pdS+uhJYNloIEQMONNAyJ7Rsvk22zqcCEtfV
         pWLoxXJhpb9dk7nbe3pEvnPAf/IriONlLmzduAIdmKNzYKKz6XZ+GTpIFlJxNteXD4D+
         /DlNTxQ4Hr4a5Z4SEC0iWFqgNtCexX+A3aKwKdpDzgfV1d8eT12EQOlNlQTnEe24wRCh
         Kc83O+lfdeufEgKI6h8+ObCZYReKvZqKNCHSXTTW0tUX1CnqzAqQHxY1Ba/9/91f3ZvA
         jpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669224; x=1724274024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1NygBbcJ8x72qP+tM/Wp1YkzJ5Lw47jE4xYaVvdbwc=;
        b=Ym1WeMS+7jEesEzXcfhpmE5H9Em4hD5/AIMhLIs9v2rnCQTdKn3Y3Al33qmQVldl9O
         nBqJEX9M795zGUernEYAXJozbfRXI6+kz96y5sNewWgztN7/ovanr77lxjYaACVzOnAU
         QFnesvjYWhUO0pc0Cghh7srpxGz29+CNsqy6+NEalaCsYIHieD4W/t0t6QINaoenGMJ2
         +lPDx0Kl7hJ4CTf6SBM792Ac8b3dfjV45VvRdnjWDTY0RUNyaYFz1Jl/75iK9zbV3nvG
         zNfDD9SkOdHewf/ByBLz4smh3wAUqXX4wt7kz1VAlwiScvNzmC4GmDnFDRlHQfrxp6mW
         zJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhvZ6LXsM+XJVYqvOs01ONcEGDSUJZeYbdtAH7+lFQ7meDTvj19HbH6Fe7gY6yPkcSwKDT4mnU+bBIvY8LMLOUe2iqsfNUEajhsmh4
X-Gm-Message-State: AOJu0Yxd0y7bAA9Q4i5nYuCNT/QLF9offY9ASSgjfH7rkoHTcTK3UIMT
	3NI2KXXB6SBaalQspjs3eJLihSQncU3yI1fyLo6AIh445ma815Kr
X-Google-Smtp-Source: AGHT+IG/yiWqO0H6ViVm+AspkVWf1BH2fpLRIW708oGGkUvZsXz90qpoJMlLGLVWQDSIDUzQX0eRsg==
X-Received: by 2002:a05:6870:b6a0:b0:260:e453:5368 with SMTP id 586e51a60fabf-26fe5c2f603mr4785472fac.46.1723669224438;
        Wed, 14 Aug 2024 14:00:24 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-270044811ddsm34789fac.13.2024.08.14.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:00:24 -0700 (PDT)
Message-ID: <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
Subject: Re: [PATCH net-next v13 11/14] mm: page_frag: introduce
 prepare/probe/commit API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 14 Aug 2024 14:00:21 -0700
In-Reply-To: <20240808123714.462740-12-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-12-linyunsheng@huawei.com>
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
> There are many use cases that need minimum memory in order
> for forward progress, but more performant if more memory is
> available or need to probe the cache info to use any memory
> available for frag caoleasing reason.
>=20
> Currently skb_page_frag_refill() API is used to solve the
> above use cases, but caller needs to know about the internal
> detail and access the data field of 'struct page_frag' to
> meet the requirement of the above use cases and its
> implementation is similar to the one in mm subsystem.
>=20
> To unify those two page_frag implementations, introduce a
> prepare API to ensure minimum memory is satisfied and return
> how much the actual memory is available to the caller and a
> probe API to report the current available memory to caller
> without doing cache refilling. The caller needs to either call
> the commit API to report how much memory it actually uses, or
> not do so if deciding to not use any memory.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h |  75 ++++++++++++++++
>  mm/page_frag_cache.c            | 152 ++++++++++++++++++++++++++++----
>  2 files changed, 212 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 0abffdd10a1c..ba5d7f8a03cd 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -7,6 +7,8 @@
>  #include <linux/build_bug.h>
>  #include <linux/log2.h>
>  #include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/mmdebug.h>
>  #include <linux/mm_types_task.h>
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> @@ -67,6 +69,9 @@ static inline unsigned int page_frag_cache_page_size(un=
signed long encoded_va)
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc);
>  void __page_frag_cache_drain(struct page *page, unsigned int count);
> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> +				unsigned int *offset, unsigned int fragsz,
> +				gfp_t gfp);
>  void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask);
> @@ -79,12 +84,82 @@ static inline void *page_frag_alloc_va_align(struct p=
age_frag_cache *nc,
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
>  }
> =20
> +static inline unsigned int page_frag_cache_page_offset(const struct page=
_frag_cache *nc)
> +{
> +	return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
> +}
> +
>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>  				       unsigned int fragsz, gfp_t gfp_mask)
>  {
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
>  }
> =20
> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned in=
t *fragsz,
> +				 gfp_t gfp);
> +
> +static inline void *page_frag_alloc_va_prepare_align(struct page_frag_ca=
che *nc,
> +						     unsigned int *fragsz,
> +						     gfp_t gfp,
> +						     unsigned int align)
> +{
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
> +	nc->remaining =3D nc->remaining & -align;
> +	return page_frag_alloc_va_prepare(nc, fragsz, gfp);
> +}
> +
> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> +					unsigned int *offset,
> +					unsigned int *fragsz, gfp_t gfp);
> +
> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> +				     unsigned int *offset,
> +				     unsigned int *fragsz,
> +				     void **va, gfp_t gfp);
> +
> +static inline struct page *page_frag_alloc_probe(struct page_frag_cache =
*nc,
> +						 unsigned int *offset,
> +						 unsigned int *fragsz,
> +						 void **va)
> +{
> +	unsigned long encoded_va =3D nc->encoded_va;
> +	struct page *page;
> +
> +	VM_BUG_ON(!*fragsz);
> +	if (unlikely(nc->remaining < *fragsz))
> +		return NULL;
> +
> +	*va =3D encoded_page_address(encoded_va);
> +	page =3D virt_to_page(*va);
> +	*fragsz =3D nc->remaining;
> +	*offset =3D page_frag_cache_page_size(encoded_va) - *fragsz;
> +	*va +=3D *offset;
> +
> +	return page;
> +}
> +

I still think this should be populating a bio_vec instead of passing
multiple arguments by pointer. With that you would be able to get all
the fields without as many arguments having to be passed.

> +static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
> +					  unsigned int fragsz)
> +{
> +	VM_BUG_ON(fragsz > nc->remaining || !nc->pagecnt_bias);
> +	nc->pagecnt_bias--;
> +	nc->remaining -=3D fragsz;
> +}
> +

I would really like to see this accept a bio_vec as well. With that you
could verify the page and offset matches the expected value before
applying fragsz.

> +static inline void page_frag_alloc_commit_noref(struct page_frag_cache *=
nc,
> +						unsigned int fragsz)
> +{
> +	VM_BUG_ON(fragsz > nc->remaining);
> +	nc->remaining -=3D fragsz;
> +}
> +

Same here.

> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
> +					 unsigned int fragsz)
> +{
> +	nc->pagecnt_bias++;
> +	nc->remaining +=3D fragsz;
> +}
> +

This doesn't add up. Why would you need abort if you have commit? Isn't
this more of a revert? I wouldn't think that would be valid as it is
possible you took some sort of action that might have resulted in this
memory already being shared. We shouldn't allow rewinding the offset
pointer without knowing that there are no other entities sharing the
page.

>  void page_frag_free_va(void *addr);
> =20
>  #endif
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 27596b84b452..f8fad7d2cca8 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -19,27 +19,27 @@
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
> =20
> -static bool __page_frag_cache_reuse(unsigned long encoded_va,
> -				    unsigned int pagecnt_bias)
> +static struct page *__page_frag_cache_reuse(unsigned long encoded_va,
> +					    unsigned int pagecnt_bias)
>  {
>  	struct page *page;
> =20
>  	page =3D virt_to_page((void *)encoded_va);
>  	if (!page_ref_sub_and_test(page, pagecnt_bias))
> -		return false;
> +		return NULL;
> =20
>  	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>  		free_unref_page(page, encoded_page_order(encoded_va));
> -		return false;
> +		return NULL;
>  	}
> =20
>  	/* OK, page count is 0, we can safely set it */
>  	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> -	return true;
> +	return page;
>  }
> =20
> -static bool __page_frag_cache_refill(struct page_frag_cache *nc,
> -				     gfp_t gfp_mask)
> +static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> +					     gfp_t gfp_mask)
>  {
>  	unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>  	struct page *page =3D NULL;
> @@ -55,7 +55,7 @@ static bool __page_frag_cache_refill(struct page_frag_c=
ache *nc,
>  		page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>  		if (unlikely(!page)) {
>  			memset(nc, 0, sizeof(*nc));
> -			return false;
> +			return NULL;
>  		}
> =20
>  		order =3D 0;
> @@ -69,29 +69,151 @@ static bool __page_frag_cache_refill(struct page_fra=
g_cache *nc,
>  	 */
>  	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> =20
> -	return true;
> +	return page;
>  }
> =20
>  /* Reload cache by reusing the old cache if it is possible, or
>   * refilling from the page allocator.
>   */
> -static bool __page_frag_cache_reload(struct page_frag_cache *nc,
> -				     gfp_t gfp_mask)
> +static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
> +					     gfp_t gfp_mask)
>  {
> +	struct page *page;
> +
>  	if (likely(nc->encoded_va)) {
> -		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
> +		page =3D __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
> +		if (page)
>  			goto out;
>  	}
> =20
> -	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> -		return false;
> +	page =3D __page_frag_cache_refill(nc, gfp_mask);
> +	if (unlikely(!page))
> +		return NULL;
> =20
>  out:
>  	/* reset page count bias and remaining to start of new frag */
>  	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>  	nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);
> -	return true;
> +	return page;
> +}
> +

None of the functions above need to be returning page.

> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
> +				 unsigned int *fragsz, gfp_t gfp)
> +{
> +	unsigned int remaining =3D nc->remaining;
> +
> +	VM_BUG_ON(!*fragsz);
> +	if (likely(remaining >=3D *fragsz)) {
> +		unsigned long encoded_va =3D nc->encoded_va;
> +
> +		*fragsz =3D remaining;
> +
> +		return encoded_page_address(encoded_va) +
> +			(page_frag_cache_page_size(encoded_va) - remaining);
> +	}
> +
> +	if (unlikely(*fragsz > PAGE_SIZE))
> +		return NULL;
> +
> +	/* When reload fails, nc->encoded_va and nc->remaining are both reset
> +	 * to zero, so there is no need to check the return value here.
> +	 */
> +	__page_frag_cache_reload(nc, gfp);
> +
> +	*fragsz =3D nc->remaining;
> +	return encoded_page_address(nc->encoded_va);
> +}
> +EXPORT_SYMBOL(page_frag_alloc_va_prepare);
> +
> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> +					unsigned int *offset,
> +					unsigned int *fragsz, gfp_t gfp)
> +{
> +	unsigned int remaining =3D nc->remaining;
> +	struct page *page;
> +
> +	VM_BUG_ON(!*fragsz);
> +	if (likely(remaining >=3D *fragsz)) {
> +		unsigned long encoded_va =3D nc->encoded_va;
> +
> +		*offset =3D page_frag_cache_page_size(encoded_va) - remaining;
> +		*fragsz =3D remaining;
> +
> +		return virt_to_page((void *)encoded_va);
> +	}
> +
> +	if (unlikely(*fragsz > PAGE_SIZE))
> +		return NULL;
> +
> +	page =3D __page_frag_cache_reload(nc, gfp);
> +	*offset =3D 0;
> +	*fragsz =3D nc->remaining;
> +	return page;
> +}
> +EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
> +
> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> +				     unsigned int *offset,
> +				     unsigned int *fragsz,
> +				     void **va, gfp_t gfp)
> +{
> +	unsigned int remaining =3D nc->remaining;
> +	struct page *page;
> +
> +	VM_BUG_ON(!*fragsz);
> +	if (likely(remaining >=3D *fragsz)) {
> +		unsigned long encoded_va =3D nc->encoded_va;
> +
> +		*offset =3D page_frag_cache_page_size(encoded_va) - remaining;
> +		*va =3D encoded_page_address(encoded_va) + *offset;
> +		*fragsz =3D remaining;
> +
> +		return virt_to_page((void *)encoded_va);
> +	}
> +
> +	if (unlikely(*fragsz > PAGE_SIZE))
> +		return NULL;
> +
> +	page =3D __page_frag_cache_reload(nc, gfp);
> +	*offset =3D 0;
> +	*fragsz =3D nc->remaining;
> +	*va =3D encoded_page_address(nc->encoded_va);
> +
> +	return page;
> +}
> +EXPORT_SYMBOL(page_frag_alloc_prepare);
> +
> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> +				unsigned int *offset, unsigned int fragsz,
> +				gfp_t gfp)
> +{
> +	unsigned int remaining =3D nc->remaining;
> +	struct page *page;
> +
> +	VM_BUG_ON(!fragsz);
> +	if (likely(remaining >=3D fragsz)) {
> +		unsigned long encoded_va =3D nc->encoded_va;
> +
> +		*offset =3D page_frag_cache_page_size(encoded_va) -
> +				remaining;
> +
> +		return virt_to_page((void *)encoded_va);
> +	}
> +
> +	if (unlikely(fragsz > PAGE_SIZE))
> +		return NULL;
> +
> +	page =3D __page_frag_cache_reload(nc, gfp);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	*offset =3D 0;
> +	nc->remaining =3D remaining - fragsz;
> +	nc->pagecnt_bias--;
> +
> +	return page;
>  }
> +EXPORT_SYMBOL(page_frag_alloc_pg);

Again, this isn't returning a page. It is essentially returning a
bio_vec without calling it as such. You might as well pass the bio_vec
pointer as an argument and just have it populate it directly.

It would be identical to the existing page_frag for all intents and
purposes. In addition you could use that as an intermediate value
between the page_frag_cache for your prepare/commit call setup as you
could limit the size/bv_len to being the only item that can be
adjusted, specifically reduced between the prepare and commit calls.



