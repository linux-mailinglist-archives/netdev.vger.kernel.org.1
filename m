Return-Path: <netdev+bounces-112336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD229385CC
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A70F1C20866
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D61CAA9;
	Sun, 21 Jul 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBWWkQrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C141CD25;
	Sun, 21 Jul 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721586895; cv=none; b=aT6P/QZ2KGV1faELSfg3OZRsxCIRr5C5utDg6pwfgWN3wz9Ou6eOvmpzlCgD3/+i/yRTE6NYHfrE56gGXo26RaslP1N5YxS9D95vsD7+UttuD+cvmOm2j7pksuxLOq+awr6cc2fWEXoN+NuJlYlcb4OzJFOKNr8CzMYgO+dZ2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721586895; c=relaxed/simple;
	bh=fE7WKwoI6GWG9CpahW6v9xclHmb3fAHGQny4SgKDw9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZAjXL40Npogx4mNpEbuzqD0JTRNqA5ys02HehMqqiH+5cRMHKKOIcJmgMvvLpEsMULPp3bEjOlccHnvD+z6mLvsrO0/HTfJx6cM/YXT+R1z7+urP5flc8slr59GCXO2p1k2Q4cxpFXo8QiwSJh+MMAgDFV60bCpLB/YItWqZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBWWkQrk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3685b9c8998so1312217f8f.0;
        Sun, 21 Jul 2024 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721586892; x=1722191692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVcm7MOlgwmbqBevnTZqkSl3NS98662fLyAF4DaHdRs=;
        b=XBWWkQrkhBRddJPbtX6raH1XblxpXYB2+F3eTARB8q+Aj+x6lPIjj8P0jMgi8KbFi7
         pTzvqqUXoFFkaCdbwDBAafdu6EdRir8NJGJpSXb/tev2KNDURgsSrjjRQW3Jo6dFHNOo
         jtZqzz3xhkxOSy/s56uAu3FE+ThJmE/G63byaNGeogk8jKV1SpUy52wThOs/b2NK7+dq
         ccUVwcht3SJ9VMNE5Xq596/V9QRLFON4pzCigdfMlP6E6qjBnCsEKT2KTCXnHCfan52N
         DAHxgm3kzbp5Ce49872wXtdhAkmXDGMmWYQGvnbCTyt8HwyKEY8quQ+Znt0V1snI1FNR
         6OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721586892; x=1722191692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVcm7MOlgwmbqBevnTZqkSl3NS98662fLyAF4DaHdRs=;
        b=DfrHKtKp7cP+b/sh4O6HToMwO1n4xeon0rxyNAatY6vG03ovJUaQNEhdfjhit9McQs
         K+XIJL5x8IMXtuHl8W0RJEF146IujVblf3+6LjDEeES9BWt/k2HbDZrKzztNyBgK/grx
         7h6a3zFoRxXbRIFWghadS5A0CPJrGb30takZjjHhh3bBdX/9SKyfK4DtI+rJdYhZAVVO
         78T3gKMonNdCdTthcRryQELHaH4Fmxmipk+oTlpKRevnNAnTor/M++7ehAszWMQpmSOP
         DhsoKoPZM/v+cXXDt3Q0cMm+HPHGmEV6aXBY0C9yr1Pf3BM3JTo18LR5TF6vk3oPVT0a
         EN4w==
X-Forwarded-Encrypted: i=1; AJvYcCVbzZIqXMY6y6Ikzdez0YGuPBnI8uTPGAtjatuTAIu0EbI4g+cte9zuT4tZ3+KswwXQ4Fy9l0w36V+lN1VNb+mgb8mXyHPcQMSrvMIlwnkPw8ih3vyGaey8vmu1FBsQ9Xf+e1pj
X-Gm-Message-State: AOJu0Yx6Gm8Ehf5EJUMFSkDfqAFycvkrpJnc7r42EWtF51gZZuYNkIz9
	l10n5clDa3XE/+MBhq5suiPEUsW9NF9gqdWU+/7NdV7TG4a1nt8QP0RdfPXh1IU7g4K6BhBOOD9
	Bt0J7KvDpNcML6PcQ860lD2NroBY=
X-Google-Smtp-Source: AGHT+IEin7bTBSAPIHhzoLfJZGwv/eoxM/axrGVQkbpWmkKK8tg0w9IF2VTu7EV4UlY+LLhQQK6h+SxAwZJs6VnkgQI=
X-Received: by 2002:a05:6000:144a:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-369bba4f072mr3121270f8f.0.1721586891893; Sun, 21 Jul 2024
 11:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com> <20240719093338.55117-4-linyunsheng@huawei.com>
In-Reply-To: <20240719093338.55117-4-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Jul 2024 11:34:15 -0700
Message-ID: <CAKgT0UfMBo2K7c1UZgJOJt23hO+44Er7JwabrGT6ymGjLps+Gg@mail.gmail.com>
Subject: Re: [RFC v11 03/14] mm: page_frag: use initial zero offset for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:37=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> We are about to use page_frag_alloc_*() API to not just
> allocate memory for skb->data, but also use them to do
> the memory allocation for skb frag too. Currently the
> implementation of page_frag in mm subsystem is running
> the offset as a countdown rather than count-up value,
> there may have several advantages to that as mentioned
> in [1], but it may have some disadvantages, for example,
> it may disable skb frag coaleasing and more correct cache
> prefetching

You misspelled "coalescing".

> We have a trade-off to make in order to have a unified
> implementation and API for page_frag, so use a initial zero
> offset in this patch, and the following patch will try to
> make some optimization to avoid the disadvantages as much
> as possible.
>
> Rename 'offset' to 'remaining' to retain the 'countdown'
> behavior as 'remaining countdown' instead of 'offset
> countdown'. Also, Renaming enable us to do a single
> 'fragsz > remaining' checking for the case of cache not
> being enough, which should be the fast path if we ensure
> 'remaining' is zero when 'va' =3D=3D NULL by memset'ing
> 'struct page_frag_cache' in page_frag_cache_init() and
> page_frag_cache_drain().
>
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.c=
amel@gmail.com/
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h |  4 +-
>  mm/page_frag_cache.c          | 71 +++++++++++++++++++++--------------
>  2 files changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
> index cdc1e3696439..b1c54b2b9308 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -52,10 +52,10 @@ struct page_frag {
>  struct page_frag_cache {
>         void *va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -       __u16 offset;
> +       __u16 remaining;
>         __u16 size;
>  #else
> -       __u32 offset;
> +       __u32 remaining;
>  #endif
>         /* we maintain a pagecount bias, so that we dont dirty cache line
>          * containing page->_refcount every time we allocate a fragment.
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 609a485cd02a..2958fe006fe7 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -22,6 +22,7 @@
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
>  {
> +       unsigned int page_size =3D PAGE_FRAG_CACHE_MAX_SIZE;
>         struct page *page =3D NULL;
>         gfp_t gfp =3D gfp_mask;
>
> @@ -30,12 +31,21 @@ static struct page *__page_frag_cache_refill(struct p=
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
> +                       nc->va =3D NULL;
> +                       return NULL;
> +               }
>
> -       nc->va =3D page ? page_address(page) : NULL;
> +               page_size =3D PAGE_SIZE;
> +       }
> +
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +       nc->size =3D page_size;
> +#endif
> +       nc->va =3D page_address(page);
>
>         return page;
>  }

Not a huge fan of the changes here. If we are changing the direction
then just do that. I don't see the point of these changes. As far as I
can tell it is just adding noise to the diff and has no effect on the
final code as the outcome is mostly the same except for you don't
update size in the event that you overwrite nc->va to NULL.

> @@ -64,8 +74,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *n=
c,
>                               unsigned int align_mask)
>  {
>         unsigned int size =3D PAGE_SIZE;
> +       unsigned int remaining;
>         struct page *page;
> -       int offset;
>
>         if (unlikely(!nc->va)) {
>  refill:
> @@ -82,35 +92,20 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>                  */
>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>
> -               /* reset page count bias and offset to start of new frag =
*/
> +               /* reset page count bias and remaining to start of new fr=
ag */
>                 nc->pfmemalloc =3D page_is_pfmemalloc(page);
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -               nc->offset =3D size;
> +               nc->remaining =3D size;
>         }
>
> -       offset =3D nc->offset - fragsz;
> -       if (unlikely(offset < 0)) {
> -               page =3D virt_to_page(nc->va);
> -
> -               if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> -                       goto refill;
> -
> -               if (unlikely(nc->pfmemalloc)) {
> -                       free_unref_page(page, compound_order(page));
> -                       goto refill;
> -               }
> -
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -               /* if size can vary use size else just use PAGE_SIZE */
> -               size =3D nc->size;
> +       /* if size can vary use size else just use PAGE_SIZE */
> +       size =3D nc->size;
>  #endif

Rather than pulling this out and placing it here it might make more
sense at the start of the function. Basically just overwrite size w/
either PAGE_SIZE or nc->size right at the start. Then if we have to
reallocate we overwrite it. That way we can avoid some redundancy and
this will be easier to read.

> -               /* OK, page count is 0, we can safely set it */
> -               set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>
> -               /* reset page count bias and offset to start of new frag =
*/
> -               nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -               offset =3D size - fragsz;
> -               if (unlikely(offset < 0)) {
> +       remaining =3D nc->remaining & align_mask;
> +       if (unlikely(remaining < fragsz)) {
> +               if (unlikely(fragsz > PAGE_SIZE)) {
>                         /*
>                          * The caller is trying to allocate a fragment
>                          * with fragsz > PAGE_SIZE but the cache isn't bi=
g
> @@ -122,13 +117,31 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
>                          */
>                         return NULL;
>                 }
> +
> +               page =3D virt_to_page(nc->va);
> +
> +               if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> +                       goto refill;
> +
> +               if (unlikely(nc->pfmemalloc)) {
> +                       free_unref_page(page, compound_order(page));
> +                       goto refill;
> +               }
> +
> +               /* OK, page count is 0, we can safely set it */
> +               set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +
> +               /* reset page count bias and remaining to start of new fr=
ag */
> +               nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +               nc->remaining =3D size;

Why are you setting nc->remaining here? You set it a few lines below.
This is redundant.

> +
> +               remaining =3D size;
>         }
>
>         nc->pagecnt_bias--;
> -       offset &=3D align_mask;
> -       nc->offset =3D offset;
> +       nc->remaining =3D remaining - fragsz;
>
> -       return nc->va + offset;
> +       return nc->va + (size - remaining);
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_align);

