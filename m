Return-Path: <netdev+bounces-125201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703696C3BD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7491C21E42
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD301E0B76;
	Wed,  4 Sep 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jmzkRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8511E1312;
	Wed,  4 Sep 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466536; cv=none; b=Cq0LRsAGi2ftc6fv139JdZ6QRJNFZfFjCWRjWEGpEb5TiEuXMOsGVlM9xULaVtM4elFEmC/OoBsGJ/R89NfsWOFv103AFDYcMW8G51ZATsIyNAZP3HYeCcRnr+6YzYm46KqhYqjcPHiDO0aoe2+7swiEkTVE8aR+l5IyosaX6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466536; c=relaxed/simple;
	bh=LruGEAfBUGSwsF9A5W+gx6fXwYaRtEu9XoMDjY1ymh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtChz1Tp7wfTuFdhSNBtJrvg/O24i6zKBZLhtbew7qWgH1LHoiPn3mlTrgIh2+weG9BrUSqGIeL6iLWuSNPKyw3TVXgyZYMkdv2osXRGx4AXiv7qWaxid2N8Cdls3onsuXLDuAxtdlv5sh3oSDSkbzhMAcwvgZrP4pbuECWvJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8jmzkRB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c4d4f219so2564868f8f.1;
        Wed, 04 Sep 2024 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725466533; x=1726071333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2PynwD3abVbxCbe/0Pq2Wq8DiRMu8mGh4sTgPawR0s=;
        b=l8jmzkRB61oVpSFyLVyT+EsqoH1FPrRZ603bM4k56uum6y/+00HAgDzhXEsGe/ZHQ9
         xc+s475LDOoX2yF3cymlN1v4P7gqNQvquHl/iO6/kvDfWQNGvRr5U14lXGbAOX9Pg4UH
         oMA5knd0OXXpfAlAdRGYiduPjhy7hA/whMwFORooMP4Wkl64d84ssAC5xJeNWG8Ebiw5
         79G+t2v3V0VoOOuZqntBhLtL0L4woCfipTahsi2VK5bS5X7YuQO0XsfjFG/55j1QJdQI
         0SYIE8JP3DOKGk+zIgdd3Gy/mdshstjMi5svjPC/RssQBYeZ9Z7A9h/zIKqAnsz6xE0B
         4w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466533; x=1726071333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2PynwD3abVbxCbe/0Pq2Wq8DiRMu8mGh4sTgPawR0s=;
        b=FyNAcg36yko8AsBBN9lDOaoGHK8HUqpmE3FcntdPRTWbqrWvzbDZo0YWL28jotvS6B
         5ZYeRaoeu0zA0QmJvZsX0Ldqkxp8yUpBZhvXwBeTY2/7B8OlG6R84YIu7BjIR3rUdmpJ
         j0x1Tjzs8X8QWnWKkEkrt1F0/ocI9fBW3gweiguiZdO+C19RYjFX2F33Wa353B7Mz7bS
         O+biw+FEoHruqUKA2gxK7iSxxJeIn9iCUd4o33BJ5tN6+W5sXdQT75PGyjMIXhATZ+6+
         HbCrLbg04XXb+BPVCa07Ji7MYqX82tNnZWcGc3tfa/+tSV5xQBZSyXzqrKM03ny5BkQP
         Zojw==
X-Forwarded-Encrypted: i=1; AJvYcCX6MZDJ04Mkqg7MSpLnEFOpbWZvKjexIe4z8aF2R84kP9h0ks1PqTS9l9jYDOZ/24mDGLLcurBCU59eeHw=@vger.kernel.org, AJvYcCX8Y3Ttg5dv76e39QGg0mwHr3vRZ18JEJ3U72IW+R8UK7zXFeeW7BHxHZzmJIIvadc+Rgti1zM2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfa8M/59j7HmXoJKwYo3ybIDDGTpSfqw6DkIC7Pa/ZVKijSjSu
	f1urfaRJF4jRVD8WbjyUPr2QBchH8KusnT31I+v0hD6pJKVnUmGOTpR7wKV6Ya1Y5dsjcZBqFD3
	+TXyxtpQFJATph9K+A2Dvuh61pbfiSBZu+UU=
X-Google-Smtp-Source: AGHT+IHw4lvnMg9tOw9SWPpY8LNK4ymzOGV/1CUO4kGZ8s/KnSFHPrdH9ddQZjTrgpiLmzqfRpSBbke4je9chDLoWSQ=
X-Received: by 2002:adf:a451:0:b0:374:c57b:a909 with SMTP id
 ffacd0b85a97d-374f9e476aemr5437589f8f.48.1725466532534; Wed, 04 Sep 2024
 09:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com> <20240902120314.508180-7-linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Sep 2024 09:14:55 -0700
Message-ID: <CAKgT0UeYy_tpbRx9C1oDNY+G9fKzsh1eoHfVg6GmFD7z-LziBw@mail.gmail.com>
Subject: Re: [PATCH net-next v17 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> Currently there is one 'struct page_frag' for every 'struct
> sock' and 'struct task_struct', we are about to replace the
> 'struct page_frag' with 'struct page_frag_cache' for them.
> Before begin the replacing, we need to ensure the size of
> 'struct page_frag_cache' is not bigger than the size of
> 'struct page_frag', as there may be tens of thousands of
> 'struct sock' and 'struct task_struct' instances in the
> system.
>
> By or'ing the page order & pfmemalloc with lower bits of
> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> And page address & pfmemalloc & order is unchanged for the
> same page in the same 'page_frag_cache' instance, it makes
> sense to fit them together.
>
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h   | 19 +++++-----
>  include/linux/page_frag_cache.h | 47 ++++++++++++++++++++++--
>  mm/page_frag_cache.c            | 63 +++++++++++++++++++++------------
>  3 files changed, 96 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index cdc1e3696439..73a574a0e8f9 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -50,18 +50,21 @@ struct page_frag {
>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
>  struct page_frag_cache {
> -       void *va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +       /* encoded_page consists of the virtual address, pfmemalloc bit a=
nd
> +        * order of a page.
> +        */
> +       unsigned long encoded_page;
> +
> +       /* we maintain a pagecount bias, so that we dont dirty cache line
> +        * containing page->_refcount every time we allocate a fragment.
> +        */
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>         __u16 offset;
> -       __u16 size;
> +       __u16 pagecnt_bias;
>  #else
>         __u32 offset;
> +       __u32 pagecnt_bias;
>  #endif
> -       /* we maintain a pagecount bias, so that we dont dirty cache line
> -        * containing page->_refcount every time we allocate a fragment.
> -        */
> -       unsigned int            pagecnt_bias;
> -       bool pfmemalloc;
>  };
>
>  /* Track pages that require TLB flushes */
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 0a52f7a179c8..cb89cd792fcc 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,18 +3,61 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
>
> +#include <linux/bits.h>
>  #include <linux/log2.h>
> +#include <linux/mm.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/types.h>
>
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +/* Use a full byte here to enable assembler optimization as the shift
> + * operation is usually expecting a byte.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEM=
ALLOC_SHIFT)
> +#else
> +/* Compiler should be able to figure out we don't read things as any val=
ue
> + * ANDed with 0 is 0.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEM=
ALLOC_SHIFT)
> +#endif
> +
> +static inline unsigned long page_frag_encoded_page_order(unsigned long e=
ncoded_page)
> +{
> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> +}
> +
> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encod=
ed_page)
> +{
> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> +}
> +
> +static inline void *page_frag_encoded_page_address(unsigned long encoded=
_page)
> +{
> +       return (void *)(encoded_page & PAGE_MASK);
> +}
> +
> +static inline struct page *page_frag_encoded_page_ptr(unsigned long enco=
ded_page)
> +{
> +       return virt_to_page((void *)encoded_page);
> +}
> +
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
> -       nc->va =3D NULL;
> +       nc->encoded_page =3D 0;
>  }
>
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
> -       return !!nc->pfmemalloc;
> +       return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
> +}
> +
> +static inline unsigned int page_frag_cache_page_size(unsigned long encod=
ed_page)
> +{
> +       return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
>  }
>
>  void page_frag_cache_drain(struct page_frag_cache *nc);

Still not a huge fan of adding all these functions that expose the
internals. It might be better to just place them in page_frag_cache.c
and pull them out to the .h file as needed.

> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 4c8e04379cb3..a5c5373cb70e 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -12,16 +12,28 @@
>   * be used in the "frags" portion of skb_shared_info.
>   */
>
> +#include <linux/build_bug.h>
>  #include <linux/export.h>
>  #include <linux/gfp_types.h>
>  #include <linux/init.h>
> -#include <linux/mm.h>
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
>
> +static unsigned long page_frag_encode_page(struct page *page, unsigned i=
nt order,
> +                                          bool pfmemalloc)
> +{
> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MA=
SK);
> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >=3D PAGE_SIZE);
> +
> +       return (unsigned long)page_address(page) |
> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
> +               ((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_=
SHIFT);
> +}
> +
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
>  {
> +       unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>         struct page *page =3D NULL;
>         gfp_t gfp =3D gfp_mask;
>
> @@ -30,23 +42,31 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>                                 PAGE_FRAG_CACHE_MAX_ORDER);
> -       nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>  #endif
> -       if (unlikely(!page))
> +       if (unlikely(!page)) {
>                 page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +               if (unlikely(!page)) {
> +                       nc->encoded_page =3D 0;
> +                       return NULL;
> +               }

I would recommend just skipping the conditional here. No need to do
that. You can basically just not encode the page below if you failed
to allocate it.

> +
> +               order =3D 0;
> +       }
>
> -       nc->va =3D page ? page_address(page) : NULL;
> +       nc->encoded_page =3D page_frag_encode_page(page, order,
> +                                                page_is_pfmemalloc(page)=
);

I would just follow the same logic with the ternary operator here. If
page is set then encode the page, else just set it to 0.

>
>         return page;
>  }
>
>  void page_frag_cache_drain(struct page_frag_cache *nc)
>  {
> -       if (!nc->va)
> +       if (!nc->encoded_page)
>                 return;
>
> -       __page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bi=
as);
> -       nc->va =3D NULL;
> +       __page_frag_cache_drain(page_frag_encoded_page_ptr(nc->encoded_pa=
ge),
> +                               nc->pagecnt_bias);
> +       nc->encoded_page =3D 0;
>  }
>  EXPORT_SYMBOL(page_frag_cache_drain);
>
> @@ -63,31 +83,27 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>                               unsigned int fragsz, gfp_t gfp_mask,
>                               unsigned int align_mask)
>  {
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -       unsigned int size =3D nc->size;
> -#else
> -       unsigned int size =3D PAGE_SIZE;
> -#endif
> -       unsigned int offset;
> +       unsigned long encoded_page =3D nc->encoded_page;
> +       unsigned int size, offset;
>         struct page *page;
>
> -       if (unlikely(!nc->va)) {
> +       size =3D page_frag_cache_page_size(encoded_page);
> +
> +       if (unlikely(!encoded_page)) {
>  refill:
>                 page =3D __page_frag_cache_refill(nc, gfp_mask);
>                 if (!page)
>                         return NULL;
>
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -               /* if size can vary use size else just use PAGE_SIZE */
> -               size =3D nc->size;
> -#endif
> +               encoded_page =3D nc->encoded_page;
> +               size =3D page_frag_cache_page_size(encoded_page);
> +
>                 /* Even if we own the page, we do not use atomic_set().
>                  * This would break get_page_unless_zero() users.
>                  */
>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>
>                 /* reset page count bias and offset to start of new frag =
*/
> -               nc->pfmemalloc =3D page_is_pfmemalloc(page);
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 nc->offset =3D 0;
>         }

It would probably make sense to move the getting of the size to just
after this if statement since you are doing it in two different paths
and I don't think you use size at all in the
"if(unlikely(!encoded_page))" path otherwise.

> @@ -107,13 +123,14 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
>                         return NULL;
>                 }
>
> -               page =3D virt_to_page(nc->va);
> +               page =3D page_frag_encoded_page_ptr(encoded_page);
>
>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>                         goto refill;
>
> -               if (unlikely(nc->pfmemalloc)) {
> -                       free_unref_page(page, compound_order(page));
> +               if (unlikely(page_frag_encoded_page_pfmemalloc(encoded_pa=
ge))) {
> +                       free_unref_page(page,
> +                                       page_frag_encoded_page_order(enco=
ded_page));
>                         goto refill;
>                 }
>
> @@ -128,7 +145,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>         nc->pagecnt_bias--;
>         nc->offset =3D offset + fragsz;
>
> -       return nc->va + offset;
> +       return page_frag_encoded_page_address(encoded_page) + offset;
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_align);
>
> --
> 2.33.0
>

