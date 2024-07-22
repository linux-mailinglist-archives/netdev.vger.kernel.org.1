Return-Path: <netdev+bounces-112449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA09391DF
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AE281AF4
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA016DECA;
	Mon, 22 Jul 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7dx4Z33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AAC2FD;
	Mon, 22 Jul 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662384; cv=none; b=FCosqWMWjSAiM4HacXcUEoTLFViKmPmiYhwoN/rKLVMjOV4ng9RdOJ4x2bvxPYA+CizhR1rJGQzsHY7R2tn1FVzobF+1jmoNqydsjHKYw6WdG96dQDWA7sAbq/lXPW1mvMRDfMwZmvDYF7+VhziyqdEL41/HrxojAlYMBm9CMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662384; c=relaxed/simple;
	bh=hd7KMdPfW+S/vgqmVMaOXvJkkj7Utztp8HNlnS5csbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2xaHZ9rNV1vVW4pSEFY98mnty/5lHrtIGxgQaTBkPa/Y+6GwwB9b7EZzpTs0dTpAs7a+x1ojreVRwXeg+Sf4/RAXJVpyjjX+TYDt+sGtEearQ6czdMTaWTZsGuPuKOgP438HKg8F5FTdgjMNc3O1JMfrKAIaKeWGoioFiPToSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7dx4Z33; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266f344091so32580165e9.0;
        Mon, 22 Jul 2024 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721662381; x=1722267181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw3MXdh1l+GSHgjHWnYdzfuWkMoYNmYb7vb1OJfAtBk=;
        b=Y7dx4Z33KY01s47acui7Dvzz8HK6WD1xFavsOXOCxGIu9lmljLdbqa/I2sq5ShTlI9
         bwUYMb7dt5uVO+Cb79H7vKrGDEygXopwFxfo9zQZGoZ6T36IRp8+QvLGpT8z8FWnuDFw
         Y8mvd1GwqBxl5z7fCnoxRysS4yoR/1P3DSL5g80T66ZtbModU+zVDr32qNRJlQRHWQ0I
         Ra2MqDK2PcvMKLS0L5AJlh/QwdtB7iqPgvD1DDaK4aTrt6LXpZ5MtBlqLxzExPgsZgs6
         9UJ/IWaT5GbgICez0kQuGfTslkbx98iE2+5KxPQIU9scZezVxiqmQ+93wQTJk0ZRjueu
         JMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662381; x=1722267181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw3MXdh1l+GSHgjHWnYdzfuWkMoYNmYb7vb1OJfAtBk=;
        b=AnTsCx3pVL2XYeuA1DGv6Dw0pK8hbJiBU/9ozDqxqwMmPFBXnDNsXFBSNHR4JD7kKy
         KFKURuaSDFw3+KUS/p0xzjARinN0NOL5xe5B2mDtL6y5MwzzG4SYwsEmTMv9YcS4QnFh
         +v4QIn7aD3/1CalpkNHa3ppLz5UfnY4rzulre9Z2JnU0EXvS04zK5JbTSoa8mtKDLEJ9
         H0tsEaf8DfZ67zv2a9ET7nhVmvnKtKJl/YfrZQzxctnTeAppTLe3DjEBg8xZ12OvEXNy
         5knLEk2pAwLMRu1PGLodct8qeGQX33ujL697zI+ptmhat30e6fOKeD/gbN5ix7xoBe6h
         iPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCunb9JywqOV04uCy/FiNSPa5y8bMluD73++q7L6uGks8cUlC9D04DnglEze+AzfO30f9+wxfbtg39Omp1DqgzAsSufOEeTLMRqfDqvUjoGqEu1YEJqoxI/K2RLA8y1jdnoB9b
X-Gm-Message-State: AOJu0YxK2UNiuoFKBYdwDZgCZyH9hxdHRgciD4PjqWOEVOFCTBB1P6fR
	cTaQWfTY95H8ILdSKpAqsFBBZ0nqxeZUdvwrf3vEUh3Q8oRHnvsS6BVDOZUMnqfC3gOcohL2Odm
	Ad03cO11J6ZABwWqbw5rXI3SZmp8=
X-Google-Smtp-Source: AGHT+IEj9m4RflaxiV+GYMly5G1qIp3Qd3TRRIsl4lMoSEJkKSsDRRzvTMHWo0mf0MM8xeGkiYl/DFjyLYTsnsfObgA=
X-Received: by 2002:a05:600c:4f50:b0:426:616e:db8d with SMTP id
 5b1f17b1804b1-427dc52128fmr44639115e9.15.1721662380408; Mon, 22 Jul 2024
 08:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-9-linyunsheng@huawei.com> <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
In-Reply-To: <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Jul 2024 08:32:23 -0700
Message-ID: <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:55=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/7/22 7:40, Alexander H Duyck wrote:
> > On Fri, 2024-07-19 at 17:33 +0800, Yunsheng Lin wrote:
> >> Refactor common codes from __page_frag_alloc_va_align()
> >> to __page_frag_cache_refill(), so that the new API can
> >> make use of them.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/page_frag_cache.h |  2 +-
> >>  mm/page_frag_cache.c            | 93 +++++++++++++++++---------------=
-
> >>  2 files changed, 49 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag=
_cache.h
> >> index 12a16f8e8ad0..5aa45de7a9a5 100644
> >> --- a/include/linux/page_frag_cache.h
> >> +++ b/include/linux/page_frag_cache.h
> >> @@ -50,7 +50,7 @@ static inline void *encoded_page_address(unsigned lo=
ng encoded_va)
> >>
> >>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> >>  {
> >> -    nc->encoded_va =3D 0;
> >> +    memset(nc, 0, sizeof(*nc));
> >>  }
> >>
> >
> > I do not like requiring the entire structure to be reset as a part of
> > init. If encoded_va is 0 then we have reset the page and the flags.
> > There shouldn't be anything else we need to reset as remaining and bias
> > will be reset when we reallocate.
>
> The argument is about aoviding one checking for fast path by doing the
> memset in the slow path, which you might already know accroding to your
> comment in previous version.
>
> It is just sometimes hard to understand your preference for maintainabili=
ty
> over performance here as sometimes your comment seems to perfer performan=
ce
> over maintainability, like the LEA trick you mentioned and offset count-d=
own
> before this patchset. It would be good to be more consistent about this,
> otherwise it is sometimes confusing when doing the refactoring.

The use of a negative offset is arguably more maintainable in my mind
rather than being a performance trick. Essentially if you use the
negative value you can just mask off the upper bits and it is the
offset in the page. As such it is actually easier for me to read
versus "remaining" which is an offset from the end of the page.
Assuming you read the offset in hex anyway.

> >
> >>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cac=
he *nc)
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index 7928e5d50711..d9c9cad17af7 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -19,6 +19,28 @@
> >>  #include <linux/page_frag_cache.h>
> >>  #include "internal.h"
> >>
> >> +static struct page *__page_frag_cache_recharge(struct page_frag_cache=
 *nc)
> >> +{
> >> +    unsigned long encoded_va =3D nc->encoded_va;
> >> +    struct page *page;
> >> +
> >> +    page =3D virt_to_page((void *)encoded_va);
> >> +    if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> >> +            return NULL;
> >> +
> >> +    if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> >> +            VM_BUG_ON(compound_order(page) !=3D
> >> +                      encoded_page_order(encoded_va));
> >> +            free_unref_page(page, encoded_page_order(encoded_va));
> >> +            return NULL;
> >> +    }
> >> +
> >> +    /* OK, page count is 0, we can safely set it */
> >> +    set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> >> +
> >> +    return page;
> >> +}
> >> +
> >>  static struct page *__page_frag_cache_refill(struct page_frag_cache *=
nc,
> >>                                           gfp_t gfp_mask)
> >>  {
> >> @@ -26,6 +48,14 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
> >>      struct page *page =3D NULL;
> >>      gfp_t gfp =3D gfp_mask;
> >>
> >> +    if (likely(nc->encoded_va)) {
> >> +            page =3D __page_frag_cache_recharge(nc);
> >> +            if (page) {
> >> +                    order =3D encoded_page_order(nc->encoded_va);
> >> +                    goto out;
> >> +            }
> >> +    }
> >> +
> >
> > This code has no business here. This is refill, you just dropped
> > recharge in here which will make a complete mess of the ordering and be
> > confusing to say the least.
> >
> > The expectation was that if we are calling this function it is going to
> > overwrite the virtual address to NULL on failure so we discard the old
> > page if there is one present. This changes that behaviour. What you
> > effectively did is made __page_frag_cache_refill into the recharge
> > function.
>
> The idea is to reuse the below for both __page_frag_cache_refill() and
> __page_frag_cache_recharge(), which seems to be about maintainability
> to not having duplicated code. If there is a better idea to avoid that
> duplicated code while keeping the old behaviour, I am happy to change
> it.
>
>         /* reset page count bias and remaining to start of new frag */
>         nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>         nc->remaining =3D PAGE_SIZE << order;
>

The only piece that is really reused here is the pagecnt_bias
assignment. What is obfuscated away is that the order is gotten
through one of two paths. Really order isn't order here it is size.
Which should have been fetched already. What you end up doing with
this change is duplicating a bunch of code throughout the function.
You end up having to fetch size multiple times multiple ways. here you
are generating it with order. Then you have to turn around and get it
again at the start of the function, and again after calling this
function in order to pull it back out.

> >
> >>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>      gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> >>                 __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >> @@ -35,7 +65,7 @@ static struct page *__page_frag_cache_refill(struct =
page_frag_cache *nc,
> >>      if (unlikely(!page)) {
> >>              page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> >>              if (unlikely(!page)) {
> >> -                    nc->encoded_va =3D 0;
> >> +                    memset(nc, 0, sizeof(*nc));
> >>                      return NULL;
> >>              }
> >>
> >
> > The memset will take a few more instructions than the existing code
> > did. I would prefer to keep this as is if at all possible.
>
> It will not take more instructions for arm64 as it has 'stp' instruction =
for
> __HAVE_ARCH_MEMSET is set.
> There is something similar for x64?

The x64 does not last I knew without getting into the SSE/AVX type
stuff. This becomes two seperate 8B store instructions.

> >
> >> @@ -45,6 +75,16 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
> >>      nc->encoded_va =3D encode_aligned_va(page_address(page), order,
> >>                                         page_is_pfmemalloc(page));
> >>
> >> +    /* Even if we own the page, we do not use atomic_set().
> >> +     * This would break get_page_unless_zero() users.
> >> +     */
> >> +    page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> >> +
> >> +out:
> >> +    /* reset page count bias and remaining to start of new frag */
> >> +    nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> +    nc->remaining =3D PAGE_SIZE << order;
> >> +
> >>      return page;
> >>  }
> >>
> >
> > Why bother returning a page at all? It doesn't seem like you don't use
> > it anymore. It looks like the use cases you have for it in patch 11/12
> > all appear to be broken from what I can tell as you are adding page as
> > a variable when we don't need to be passing internal details to the
> > callers of the function when just a simple error return code would do.
>
> It would be good to be more specific about the 'broken' part here.

We are passing internals to the caller. Basically this is generally
frowned upon for many implementations of things as the general idea is
that the internal page we are using should be a pseudo-private value.
I understand that you have one or two callers that need it for the use
cases you have in patches 11/12, but it also seems like you are just
passing it regardless. For example I noticed in a few cases you added
the page pointer in 12 to handle the return value, but then just used
it to check for NULL. My thought would be that rather than returning
the page here you would be better off just returning 0 or an error and
then doing the virt_to_page translation for all the cases where the
page is actually needed since you have to go that route for a cached
page anyway.

