Return-Path: <netdev+bounces-133971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F110997953
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22831C20E83
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6D1E3785;
	Wed,  9 Oct 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBwPZS/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771F1E282B;
	Wed,  9 Oct 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517863; cv=none; b=Hcnw7eJtGX1VnIPixsNVRP8MwjAOtUPUpOcy1dws+qQmsNSMHAFIX1MmFFJSrApD4ksEm/cD3s14vKsz7XyYoxPfy5ZVM8zB4NEJsPgpCBtVfDK/0NceB6z/fvcDEkDGgTaqZefQ6Xa4W6WLL2iveG+WFfrtaxYA8V/J6mA3qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517863; c=relaxed/simple;
	bh=0kNu8+u6Dba/wR+xL4/Gs6ADgT9EeNPVy3bxJHRObkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7kqF2hZa0rd186cSIbkRLK6Y7IxxwF+Ct2yhNRJzSPqTXjNF8Scp5CjfGUvo6cKyAt44CLEJPEla+67SVg9XRnBriSyvH9/m+wS3/iMjxJiszrpQ2PCorPl4GZ62+pGvuknxKgQfjnYImrxL8ynbtG/5hrorn8HZaJaYNCUziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBwPZS/c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43115b31366so2355885e9.3;
        Wed, 09 Oct 2024 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517859; x=1729122659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C5EhyIJlH5dsKSUlSz9TFCvZCAMtETZs60RR+mrYOw=;
        b=YBwPZS/crDwwKBmomMXf5eVo452Vv6XKPE0L48K5hpsqBk2L9l307Z0LndgPw6/i8I
         HM7WN9cA479Aj+PferZYBF/ZJSnTfXIxlf7ygB5E+z8K0unMH4V2l0hOjgsrnhvkbVuq
         turILEx2WGQGcp6yNxrr4HlncD1GPHp9rqfyySo24Vyj5KzMr/fHkPqfvUipGf0Uandf
         FLtn6cAcnjjHIiuVzs77T7e8DrzR5OvJrhewtWWk1zQXyqV4taKqFnGKa9Nd9ClyJbkl
         YxmwSgRTETbFFxWv/DdIPqzTTCJSei5n8a/ttJJtqvPzkS0pFX3mqmkIh4qSKkmX3FRx
         g/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517859; x=1729122659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C5EhyIJlH5dsKSUlSz9TFCvZCAMtETZs60RR+mrYOw=;
        b=o0r3DHME+Y4T6ytp6jjBZCYH7RGhcWe8xPvGsjE4O+NezVKkjayZNu/IWzEll+a6u0
         YeH8RazzJur8DlKcuU6PE/RFAUsPPluEjAJxCaDdyg8cTuOCjyo3kI1RjOQcIqOGgusr
         RykrExsDI30iJgR0LgnCrIaMyOvjjSRaxUKAEWKzELlfd8sl73G17LKUWU4+HJv2FKqf
         VVXIzv06IQyRbrSWBDBqH6VhZe9wqOz89ktdoOe0JGhr4g5uKoOq04iInjdrfpcP11TV
         mphDZmzS35XRGxjDQ0M3rKbtmdJaeiGSYbMx6vbYa4fbk9e61VPORt6QK/Egn58lzU/W
         ZQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUfHuT2AbJO6gEm7sWPmFzG545LrjRiVM8uvQ+h1zTX5fBTQ4Mk1eFq6YuUaJ+GaeTwMTcxQfF0@vger.kernel.org, AJvYcCW6RZAn1kHCVnhkqibAeGHoDj6kMF+5J0xgNRNGAzVlfNy6k5/wSN6Qyr6+7np2vdpUAa5iSMI+8CS0ZOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhAQZwMGMqGpd0JymaFMR5if3bRq6KiUMekYiGi3DxdDRFNr8
	7ukc6+NJX9rGavhC355k6LDCpibo3xYVTZaUSOJeGC7SzxFTZe9kFJQSQnc6CHO9NsAsUSnUulf
	UmhllHOvqQxTp5SWKPC2bpEORcYU=
X-Google-Smtp-Source: AGHT+IErJ/vcpeSs9ve+RmX8+TdqD8teL/9J7kobSk8QuLKj8zecJijnF/1hEcJgqGiwP6YyQCNxzm9vAp1X5dK4CR0=
X-Received: by 2002:adf:e5c2:0:b0:37c:d2ac:dd7d with SMTP id
 ffacd0b85a97d-37d3aa34a10mr3072228f8f.30.1728517859170; Wed, 09 Oct 2024
 16:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112049.2279307-1-linyunsheng@huawei.com> <20241008112049.2279307-7-linyunsheng@huawei.com>
In-Reply-To: <20241008112049.2279307-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 9 Oct 2024 16:50:22 -0700
Message-ID: <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
Subject: Re: [PATCH net-next v20 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:27=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
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
>  include/linux/mm_types_task.h   | 19 +++++----
>  include/linux/page_frag_cache.h | 24 ++++++++++-
>  mm/page_frag_cache.c            | 75 +++++++++++++++++++++++----------
>  3 files changed, 86 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index 0ac6daebdd5c..a82aa80c0ba4 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -47,18 +47,21 @@ struct page_frag {
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
> index 0a52f7a179c8..dba2268e451a 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -3,18 +3,38 @@
>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>  #define _LINUX_PAGE_FRAG_CACHE_H
>
> +#include <linux/bits.h>
>  #include <linux/log2.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/types.h>
>
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +/* Use a full byte here to enable assembler optimization as the shift
> + * operation is usually expecting a byte.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
> +#else
> +/* Compiler should be able to figure out we don't read things as any val=
ue
> + * ANDed with 0 is 0.
> + */
> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
> +#endif
> +
> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         (PAGE_FRAG_CACHE_ORDER_MA=
SK + 1)
> +
> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encod=
ed_page)
> +{
> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> +}
> +

Rather than calling this encoded_page_pfmemalloc you might just go
with decode_pfmemalloc. Also rather than passing the unsigned long we
might just want to pass the page_frag_cache pointer.

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
>  }
>
>  void page_frag_cache_drain(struct page_frag_cache *nc);
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 4c8e04379cb3..4bff4de58808 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -12,6 +12,7 @@
>   * be used in the "frags" portion of skb_shared_info.
>   */
>
> +#include <linux/build_bug.h>
>  #include <linux/export.h>
>  #include <linux/gfp_types.h>
>  #include <linux/init.h>
> @@ -19,9 +20,41 @@
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
> +               ((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLOC_B=
IT);
> +}
> +
> +static unsigned long page_frag_encoded_page_order(unsigned long encoded_=
page)
> +{
> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> +}
> +
> +static void *page_frag_encoded_page_address(unsigned long encoded_page)
> +{
> +       return (void *)(encoded_page & PAGE_MASK);
> +}
> +
> +static struct page *page_frag_encoded_page_ptr(unsigned long encoded_pag=
e)
> +{
> +       return virt_to_page((void *)encoded_page);
> +}
> +

Same with these. Instead of calling it encoded_page_XXX we could
probably just go with decode_page, decode_order, and decode_address.
Also instead of passing an unsigned long it would make more sense to
be passing the page_frag_cache pointer, especially once you start
pulling these out of this block.

If you are wanting to just work with the raw unsigned long value in
the file it might make more sense to drop the "page_frag_" prefix from
it and just have functions for handling your "encoded_page_" value. In
that case you might rename page_frag_encode_page to
"encoded_page_encode" or something like that.


> +static unsigned int page_frag_cache_page_size(unsigned long encoded_page=
)
> +{
> +       return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
> +}
> +
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
>  {
> +       unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>         struct page *page =3D NULL;
>         gfp_t gfp =3D gfp_mask;
>
> @@ -30,23 +63,26 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>                                 PAGE_FRAG_CACHE_MAX_ORDER);
> -       nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>  #endif
> -       if (unlikely(!page))
> +       if (unlikely(!page)) {
>                 page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +               order =3D 0;
> +       }
>
> -       nc->va =3D page ? page_address(page) : NULL;
> +       nc->encoded_page =3D page ?
> +               page_frag_encode_page(page, order, page_is_pfmemalloc(pag=
e)) : 0;
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
> @@ -63,35 +99,29 @@ void *__page_frag_alloc_align(struct page_frag_cache =
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
>
> +       size =3D page_frag_cache_page_size(encoded_page);
>         offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>         if (unlikely(offset + fragsz > size)) {
>                 if (unlikely(fragsz > PAGE_SIZE)) {
> @@ -107,13 +137,14 @@ void *__page_frag_alloc_align(struct page_frag_cach=
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
> @@ -128,7 +159,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
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

