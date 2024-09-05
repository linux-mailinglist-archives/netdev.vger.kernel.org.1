Return-Path: <netdev+bounces-125644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD496E081
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940F41C24804
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2D1A072C;
	Thu,  5 Sep 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Hom3zM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA519FA7B;
	Thu,  5 Sep 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555360; cv=none; b=kLpA1pZ/icBsQxQbSpxsI2gBNAKzFqIj0SS5Xl8taIT2yXXRgtLoozmvUqaJhmbvtBom29kI5d6sIQ8bFCcBFTQLXXVHX1RH8sqhitE9AY65HrYbyiKrgMSE4YsGzyfYazmYEejucml56qMxlU/6yAheGjW8OjMPPg+ZXAEeXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555360; c=relaxed/simple;
	bh=iiOt/gAOp6NhBFZtHj2bOFZrEz2s9Cf+Md4auFoPemQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I42CGb5doaQbq0G3SlMdAFNhf5fJzQh2/Rn96rYn44jp0aXeGQzxdX6wB18t5nf5rGIsGjbqriqdWYimZH1NCQpTbzrtxA3b7BHeMEHzCk6vfJf1/bMvi6o+A0AAPzK2VS99mWateNCIwbdRrEjooYJm03f/LV766KX1JALz1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Hom3zM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so10973695e9.0;
        Thu, 05 Sep 2024 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555357; x=1726160157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71wgFdMdO0+Jj9nre97VRx58TCNy/d1lEQrwnYTY1tU=;
        b=V5Hom3zMkfpy6Tx/ulHjvdKwx7JaDTldUE68dcoZV1YOTS+t9ncf6Ha8U4ACp49LyE
         jVoDlirctLLfsWWGATeehJAjfp/Xa3YB3kqusZZ8tbGO2LnSMwjsCTK5qdmEcaKcbWNn
         q7HxMYAPDKVb+8Tt7F7xqQmQZxXtyA7kyzU5K8hvz46aJ5cckQb6gvvMh7J8ytjvYNiy
         JDjnPM0qqeVfTUfW5RIEvLDjD1w4WFXycWPPkR/1CalX3H8FmAr4E/MuEpeIQD0/A49A
         vHGauMt0aqTShYqZKB+oKprTesInYzj9KRVZZKPRTp8z/ZWwatkAvUifkuQJbRVLwIUb
         v5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555357; x=1726160157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71wgFdMdO0+Jj9nre97VRx58TCNy/d1lEQrwnYTY1tU=;
        b=HaczHLR/9GvEY3OhOci1Q+HveHucfe0Ra/dr1QhQz8XVe3jgUOWsSxmSQ5sWgWDeFh
         BiAuOIuqdKR1vKmIMEOwW++NUCQXYORgrStegDUz8paerefwK1CDHJ0Eoi6YXJpQ5yP4
         KxcZxvkcpLXmRY20qLl9x47Vs40IaoMsi2uTH9dmy6Szx5AqoWSzGWucNiWgq1SW0UCh
         ZAntTDrb2chi6RT/Sqv6iEreuV4+T74xwDSynbfd3ssTPhydVxKUYiP1pQaPRrjfvDcg
         nPJ+Bvfdi44z+nyNWbT03ixEPPLYz6RGn4O1D1CedJu8qztYX4BOwWo+FXmxTY9DQIyG
         DA+A==
X-Forwarded-Encrypted: i=1; AJvYcCW2N6bzq7cCY5Zv3veHnY7hWubXs2q5Rl/gtF+AjyacwB2ewW6/3d7Hf2W3wFu9otHrYPkS1FO63Fdv7OM=@vger.kernel.org, AJvYcCWheNlYP8rj0dJSDEpI9H6Mz59QnqR2fBBTsCPWYQfqToerJXIke2oR2TML/Z27ESpoO5dTucLR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/z4VGWsRaEmv9cOxhg5dkJcxTEICUCvt4BAhiAV27ub7avkyI
	Kc97D8GH9oaWtIvFNVguJy8wXUMIf43dn0sGTbw9b/v76mSKBcU22smigHyPQjQCZyozkZjsV0f
	CjMcssKskzbmSFXCwpm66wDBfBoCw15MwGX8=
X-Google-Smtp-Source: AGHT+IFxZl9zYv0EQPNJJTgG8Bd0GDrtwaOwV30EFXsbcM5DUY9tjzTh9JVFwul5GlsSWDnmj2psuVH4aiA3cRqqqo8=
X-Received: by 2002:a05:600c:358a:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-42c9a38b275mr30666255e9.30.1725555356878; Thu, 05 Sep 2024
 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com>
 <20240902120314.508180-7-linyunsheng@huawei.com> <CAKgT0UeYy_tpbRx9C1oDNY+G9fKzsh1eoHfVg6GmFD7z-LziBw@mail.gmail.com>
 <2cf46afa-9e80-4f34-a734-22009e277cc2@huawei.com>
In-Reply-To: <2cf46afa-9e80-4f34-a734-22009e277cc2@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 5 Sep 2024 09:55:20 -0700
Message-ID: <CAKgT0UedDh6e5-fy-UYFz-6+4oiBc0AZJDFhvNXFx5yy_rHgqA@mail.gmail.com>
Subject: Re: [PATCH net-next v17 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:13=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/9/5 0:14, Alexander Duyck wrote:
> > On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> Currently there is one 'struct page_frag' for every 'struct
> >> sock' and 'struct task_struct', we are about to replace the
> >> 'struct page_frag' with 'struct page_frag_cache' for them.
> >> Before begin the replacing, we need to ensure the size of
> >> 'struct page_frag_cache' is not bigger than the size of
> >> 'struct page_frag', as there may be tens of thousands of
> >> 'struct sock' and 'struct task_struct' instances in the
> >> system.
> >>
> >> By or'ing the page order & pfmemalloc with lower bits of
> >> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> >> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> >> And page address & pfmemalloc & order is unchanged for the
> >> same page in the same 'page_frag_cache' instance, it makes
> >> sense to fit them together.
> >>
> >> After this patch, the size of 'struct page_frag_cache' should be
> >> the same as the size of 'struct page_frag'.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/mm_types_task.h   | 19 +++++-----
> >>  include/linux/page_frag_cache.h | 47 ++++++++++++++++++++++--
> >>  mm/page_frag_cache.c            | 63 +++++++++++++++++++++-----------=
-
> >>  3 files changed, 96 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_ta=
sk.h
> >> index cdc1e3696439..73a574a0e8f9 100644
> >> --- a/include/linux/mm_types_task.h
> >> +++ b/include/linux/mm_types_task.h
> >> @@ -50,18 +50,21 @@ struct page_frag {
> >>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK=
)
> >>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_=
SIZE)
> >>  struct page_frag_cache {
> >> -       void *va;
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +       /* encoded_page consists of the virtual address, pfmemalloc bi=
t and
> >> +        * order of a page.
> >> +        */
> >> +       unsigned long encoded_page;
> >> +
> >> +       /* we maintain a pagecount bias, so that we dont dirty cache l=
ine
> >> +        * containing page->_refcount every time we allocate a fragmen=
t.
> >> +        */
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> >>         __u16 offset;
> >> -       __u16 size;
> >> +       __u16 pagecnt_bias;
> >>  #else
> >>         __u32 offset;
> >> +       __u32 pagecnt_bias;
> >>  #endif
> >> -       /* we maintain a pagecount bias, so that we dont dirty cache l=
ine
> >> -        * containing page->_refcount every time we allocate a fragmen=
t.
> >> -        */
> >> -       unsigned int            pagecnt_bias;
> >> -       bool pfmemalloc;
> >>  };
> >>
> >>  /* Track pages that require TLB flushes */
> >> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag=
_cache.h
> >> index 0a52f7a179c8..cb89cd792fcc 100644
> >> --- a/include/linux/page_frag_cache.h
> >> +++ b/include/linux/page_frag_cache.h
> >> @@ -3,18 +3,61 @@
> >>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
> >>  #define _LINUX_PAGE_FRAG_CACHE_H
> >>
> >> +#include <linux/bits.h>
> >>  #include <linux/log2.h>
> >> +#include <linux/mm.h>
> >>  #include <linux/mm_types_task.h>
> >>  #include <linux/types.h>
> >>
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +/* Use a full byte here to enable assembler optimization as the shift
> >> + * operation is usually expecting a byte.
> >> + */
> >> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PF=
MEMALLOC_SHIFT)
> >> +#else
> >> +/* Compiler should be able to figure out we don't read things as any =
value
> >> + * ANDed with 0 is 0.
> >> + */
> >> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
> >> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PF=
MEMALLOC_SHIFT)
> >> +#endif
> >> +
> >> +static inline unsigned long page_frag_encoded_page_order(unsigned lon=
g encoded_page)
> >> +{
> >> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> >> +}
> >> +
> >> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long en=
coded_page)
> >> +{
> >> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> >> +}
> >> +
> >> +static inline void *page_frag_encoded_page_address(unsigned long enco=
ded_page)
> >> +{
> >> +       return (void *)(encoded_page & PAGE_MASK);
> >> +}
> >> +
> >> +static inline struct page *page_frag_encoded_page_ptr(unsigned long e=
ncoded_page)
> >> +{
> >> +       return virt_to_page((void *)encoded_page);
> >> +}
> >> +
> >>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> >>  {
> >> -       nc->va =3D NULL;
> >> +       nc->encoded_page =3D 0;
> >>  }
> >>
> >>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cac=
he *nc)
> >>  {
> >> -       return !!nc->pfmemalloc;
> >> +       return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
> >> +}
> >> +
> >> +static inline unsigned int page_frag_cache_page_size(unsigned long en=
coded_page)
> >> +{
> >> +       return PAGE_SIZE << page_frag_encoded_page_order(encoded_page)=
;
> >>  }
> >>
> >>  void page_frag_cache_drain(struct page_frag_cache *nc);
> >
> > Still not a huge fan of adding all these functions that expose the
> > internals. It might be better to just place them in page_frag_cache.c
> > and pull them out to the .h file as needed.
>
> Are you suggesting to move the above to page_frag_cache.c, and move
> it back to page_frag_cache.h if needed in the following patch of the
> same patchset?

My thought for now is to look at moving it back and forth if we need to.

> Or are you really preferring not to expose any internals over the
> performance here and thinking the moving them back to .h file is
> unneeded?

I'm debating it. My main concern is that if we expose too much of the
internals it makes it likely for people to start abusing it like what
happened with people trying to allocate higher order pages from the
page frag just because we were already using them as a part of the
internal implementation when the intention was supposed to be for 2K
or less fragment size.

> >
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index 4c8e04379cb3..a5c5373cb70e 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -12,16 +12,28 @@
> >>   * be used in the "frags" portion of skb_shared_info.
> >>   */
> >>
> >> +#include <linux/build_bug.h>
> >>  #include <linux/export.h>
> >>  #include <linux/gfp_types.h>
> >>  #include <linux/init.h>
> >> -#include <linux/mm.h>
> >>  #include <linux/page_frag_cache.h>
> >>  #include "internal.h"
> >>
> >> +static unsigned long page_frag_encode_page(struct page *page, unsigne=
d int order,
> >> +                                          bool pfmemalloc)
> >> +{
> >> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER=
_MASK);
> >> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >=3D PAGE_SIZE);
> >> +
> >> +       return (unsigned long)page_address(page) |
> >> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
> >> +               ((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALL=
OC_SHIFT);
> >> +}
> >> +
> >>  static struct page *__page_frag_cache_refill(struct page_frag_cache *=
nc,
> >>                                              gfp_t gfp_mask)
> >>  {
> >> +       unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
> >>         struct page *page =3D NULL;
> >>         gfp_t gfp =3D gfp_mask;
> >>
> >> @@ -30,23 +42,31 @@ static struct page *__page_frag_cache_refill(struc=
t page_frag_cache *nc,
> >>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> >>                                 PAGE_FRAG_CACHE_MAX_ORDER);
> >> -       nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> >>  #endif
> >> -       if (unlikely(!page))
> >> +       if (unlikely(!page)) {
> >>                 page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> >> +               if (unlikely(!page)) {
> >> +                       nc->encoded_page =3D 0;
> >> +                       return NULL;
> >> +               }
> >
> > I would recommend just skipping the conditional here. No need to do
> > that. You can basically just not encode the page below if you failed
> > to allocate it.
> >
> >> +
> >> +               order =3D 0;
> >> +       }
> >>
> >> -       nc->va =3D page ? page_address(page) : NULL;
> >> +       nc->encoded_page =3D page_frag_encode_page(page, order,
> >> +                                                page_is_pfmemalloc(pa=
ge));
> >
> > I would just follow the same logic with the ternary operator here. If
> > page is set then encode the page, else just set it to 0.
>
> I am assuming you meant something like below, right?

Yes, basically what we did in the function below.

> static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
> {
>         unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>         struct page *page =3D NULL;
>         gfp_t gfp =3D gfp_mask;
>
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>                     __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>         page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
>                              numa_mem_id(), NULL);
> #endif
>         if (unlikely(!page)) {
>                 page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>                 order =3D 0;
>         }
>
>         nc->encoded_page =3D page ?
>                 page_frag_encode_page(page, order, page_is_pfmemalloc(pag=
e)) : 0;
>
>         return page;
> }
>

