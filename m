Return-Path: <netdev+bounces-112347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA2938697
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E721C2031B
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368E10940;
	Sun, 21 Jul 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDrhmSW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC1322E;
	Sun, 21 Jul 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602750; cv=none; b=INX+hjGrMxjltlcedsA4xCzvLETR5vDudUy7Z4v6kvLRCDCS8grnIMDG3FplX314ena1RU4/56+2ulHAd3N3qrgmbS3N+nAPyBHxma0U6OqeGzJB6kMLdLDSDfxFcBc+FgEPzUShHzCqIg+K9OY63y38f2J3p93dTyiBs355Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602750; c=relaxed/simple;
	bh=a1WeC8aM9Swbz7tsfMjKn61j5N3QifxkJmVWliSQs5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uztfhMwPjEi2ycq34PbjNcF2C3MklVjMBNy+IY+QAUuAOdT/pHaN9IN9w6A31q3dY/1sdruG8+C9mdJ1c/2Ucha9j1jNr327KRSBJEnvW7VVzO88RvEY6CqktkoJ+TbK2pFxv13aLJucUp2dplrGC8Dpi94zQjkDixYUkZCUwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDrhmSW8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d18112b60so521727b3a.1;
        Sun, 21 Jul 2024 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721602748; x=1722207548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9428CJifiQUG6CjoPtx1iPjSURVsMzNyEj5V06bq3k=;
        b=hDrhmSW8DxBSXhfQWPrRQFIIRxqXoCa1z4/dIPqZ9bI+SQjMgXhhj/d/rYiYLx5uFJ
         2WP82U6FDReU3NZktSKvYv24giZWtpDRjT3oUcJbiUEVjW/sU1G3ng883bEUHL+QCj+/
         0GjdlRgcvGRgVcl9KBaFdcubm1WZEtNVJNbP5vT/fhY+bZbI+6eeeE82aIQK7tA7KTKo
         Qe7PFlTHTmFBPcCySw9Wc5ej85lXFWMWduISn/jIyGuwnd/btXJ9TDLU8jRBuSccWHc9
         b1xGCQph7HSefju7mfnRI/bIfQBuQqJJoBgOp6lznlKWEyIpJar9xJGE97SN8M2oYTL6
         Ff5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721602748; x=1722207548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9428CJifiQUG6CjoPtx1iPjSURVsMzNyEj5V06bq3k=;
        b=LFfKwhe4ef65NpMsGGeD7SGIEPLDq0XL0UaG7Kjo9XS4t175bHke0wAl+H97YCbZSw
         GTCu4PFIJ8uxvhhDxdAHy+BDMv8uFl6tRO1nGfgtU8DsIOc39TLLgzOqzJ1qgXlkBnhz
         EvSgemk/ybvLDnWfvjKaKuvBWLyKB1VEKq53ZYp2WshZPt89yIgCI/eNqx0TJlMMvq03
         mfG5iGyTKxBHAuU2vBFZgUz3emxRIzxUb4pLA1Q89htTprgaeu+vrSwUNftlT0TLeCW0
         +CBEML/VxLoFzsgvwGH1hfW+iWRdlsyqxUyDYogMD23hjaFh2+IbwntWkLxfZyNyogKn
         h92Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv2e9Qe3KOF1YxoJYdpex13Q6WNk/buUi05u3YdNvSiIA9Dl+RdhJxKz8/5K6j+eHyPTitbzmgan7nZJmCt6lSx4GK1n0r1Nrlpc7V
X-Gm-Message-State: AOJu0Yw6oTxi4WwSI2L7M9MBs1BGnghZvWyjK0RCcjoczbBfwvZHBoae
	lu1kSQ7/i527FVR6Q/QPBS4CBk46AEF3VPiZN5hwEf5f0EhimuOh
X-Google-Smtp-Source: AGHT+IEbDApUm3u6kTx7a8fl5rBd8PVSi4e07BfRjymtRtdEfyt0+OSdM0OSxvAHqQ19sIV9Fy6CPA==
X-Received: by 2002:aa7:88c2:0:b0:706:5daf:efa5 with SMTP id d2e1a72fcca58-70cfd51f315mr15550240b3a.9.1721602748084;
        Sun, 21 Jul 2024 15:59:08 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70d1c99ce43sm1504409b3a.205.2024.07.21.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 15:59:07 -0700 (PDT)
Message-ID: <c65be456dad30d7184dc96926104b85afc4c4fd2.camel@gmail.com>
Subject: Re: [RFC v11 07/14] mm: page_frag: reuse existing space for 'size'
 and 'pfmemalloc'
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Sun, 21 Jul 2024 15:59:06 -0700
In-Reply-To: <20240719093338.55117-8-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-8-linyunsheng@huawei.com>
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
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h   | 16 +++++------
>  include/linux/page_frag_cache.h | 49 +++++++++++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 49 +++++++++++++++------------------
>  3 files changed, 77 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index b1c54b2b9308..f2610112a642 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -50,18 +50,18 @@ struct page_frag {
>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>  struct page_frag_cache {
> -	void *va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	/* encoded_va consists of the virtual address, pfmemalloc bit and order
> +	 * of a page.
> +	 */
> +	unsigned long encoded_va;
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>  	__u16 remaining;
> -	__u16 size;
> +	__u16 pagecnt_bias;
>  #else
>  	__u32 remaining;
> +	__u32 pagecnt_bias;
>  #endif
> -	/* we maintain a pagecount bias, so that we dont dirty cache line
> -	 * containing page->_refcount every time we allocate a fragment.
> -	 */
> -	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
>  };
> =20
>  /* Track pages that require TLB flushes */
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index ef1572f11248..12a16f8e8ad0 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,19 +3,64 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
> =20
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/mm_types_task.h>
>  #include <asm/page.h>
> =20
> +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)

I would pull the PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE check from below
and use it to wrap this mask definition. If we don't need order you
could define the mask as 0. With that you get the benefit of the
compiler being able to figure out we don't read things as any value
ANDed with 0 is 0.

Also a comment explaining why you want it to be a full byte here would
be useful. I am assuming this is for assembler optimization as the
shift operation is usually expecting a byte.

> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
> +
> +static inline unsigned long encode_aligned_va(void *va, unsigned int ord=
er,
> +					      bool pfmemalloc)
> +{
> +	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
> +	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT >=3D PAGE_SHIFT);
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	return (unsigned long)va | order |
> +		(pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> +#else
> +	return (unsigned long)va |
> +		(pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> +#endif

So with the mask trick I called out above you could just have (order &
PAGE_FRAG_CACHE_ORDER_MASK) be one of your inputs. If ORDER_MASK is 0
it should just strip the compiler will know it will turn out 0.

Also doing a shift on a bool is a risky action. What you might look at
doing instead would be something like a multiplication of a unsigned
long bit by a bool, or at least you need to recast pfmemalloc to
something other than a bool.

> +}
> +
> +static inline unsigned long encoded_page_order(unsigned long encoded_va)
> +{
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	return encoded_va & PAGE_FRAG_CACHE_ORDER_MASK;
> +#else
> +	return 0;
> +#endif
> +}
> +

As mentioned above, if the mask takes care of it for us it should just
return 0 automatically and cut out this code without the #if/else
logic.

> +static inline bool encoded_page_pfmemalloc(unsigned long encoded_va)
> +{
> +	return encoded_va & PAGE_FRAG_CACHE_PFMEMALLOC_BIT;
> +}
> +

Technically you aren't returning a bool here, you are returning an
unsigned long. It would be best to wrap this in "!!()".

> +static inline void *encoded_page_address(unsigned long encoded_va)
> +{
> +	return (void *)(encoded_va & PAGE_MASK);
> +}
> +
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -	nc->va =3D NULL;
> +	nc->encoded_va =3D 0;
>  }
> =20
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
> -	return !!nc->pfmemalloc;
> +	return encoded_page_pfmemalloc(nc->encoded_va);
> +}
> +
> +static inline unsigned int page_frag_cache_page_size(unsigned long encod=
ed_va)
> +{
> +	return PAGE_SIZE << encoded_page_order(encoded_va);
>  }
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc);
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index b12496f05c4a..7928e5d50711 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -22,7 +22,7 @@
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  					     gfp_t gfp_mask)
>  {
> -	unsigned int page_size =3D PAGE_FRAG_CACHE_MAX_SIZE;
> +	unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>  	struct page *page =3D NULL;
>  	gfp_t gfp =3D gfp_mask;
> =20
> @@ -35,28 +35,27 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>  	if (unlikely(!page)) {
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>  		if (unlikely(!page)) {
> -			nc->va =3D NULL;
> +			nc->encoded_va =3D 0;
>  			return NULL;
>  		}
> =20
> -		page_size =3D PAGE_SIZE;
> +		order =3D 0;
>  	}
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	nc->size =3D page_size;
> -#endif
> -	nc->va =3D page_address(page);
> +	nc->encoded_va =3D encode_aligned_va(page_address(page), order,
> +					   page_is_pfmemalloc(page));
> =20
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
> +	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
> +				nc->pagecnt_bias);
> +	nc->encoded_va =3D 0;
>  }
>  EXPORT_SYMBOL(page_frag_cache_drain);
> =20
> @@ -73,36 +72,30 @@ void *__page_frag_alloc_va_align(struct page_frag_cac=
he *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask)
>  {
> -	unsigned int size =3D PAGE_SIZE;
> -	unsigned int remaining;
> +	unsigned long encoded_va =3D nc->encoded_va;
> +	unsigned int size, remaining;
>  	struct page *page;
> =20
> -	if (unlikely(!nc->va)) {
> +	if (unlikely(!encoded_va)) {
>  refill:
>  		page =3D __page_frag_cache_refill(nc, gfp_mask);
>  		if (!page)
>  			return NULL;
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size =3D nc->size;
> -#endif
> +		encoded_va =3D nc->encoded_va;
> +		size =3D page_frag_cache_page_size(encoded_va);
> +
>  		/* Even if we own the page, we do not use atomic_set().
>  		 * This would break get_page_unless_zero() users.
>  		 */
>  		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> =20
>  		/* reset page count bias and remaining to start of new frag */
> -		nc->pfmemalloc =3D page_is_pfmemalloc(page);
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>  		nc->remaining =3D size;
>  	}
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	/* if size can vary use size else just use PAGE_SIZE */
> -	size =3D nc->size;
> -#endif
> -
> +	size =3D page_frag_cache_page_size(encoded_va);

As I think I mentioned in an earlier patch it would probably be better
to do this before the if statement above. That way you avoid
recomputing size when you allocate a new page. With any luck the
compiler will realize that this is essentially an "else" for the if
statement above. Either that or just make this an else for the
allocation block above.

>  	remaining =3D nc->remaining & align_mask;
>  	if (unlikely(remaining < fragsz)) {
>  		if (unlikely(fragsz > PAGE_SIZE)) {
> @@ -118,13 +111,15 @@ void *__page_frag_alloc_va_align(struct page_frag_c=
ache *nc,
>  			return NULL;
>  		}
> =20
> -		page =3D virt_to_page(nc->va);
> +		page =3D virt_to_page((void *)encoded_va);
> =20
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
> @@ -141,7 +136,7 @@ void *__page_frag_alloc_va_align(struct page_frag_cac=
he *nc,
>  	nc->pagecnt_bias--;
>  	nc->remaining =3D remaining - fragsz;
> =20
> -	return nc->va + (size - remaining);
> +	return encoded_page_address(encoded_va) + (size - remaining);
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_va_align);
> =20



