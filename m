Return-Path: <netdev+bounces-118885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F69536B3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB3E2897AA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB41A76A2;
	Thu, 15 Aug 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Wz1iBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6096FBF;
	Thu, 15 Aug 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734587; cv=none; b=noDsckaq8x5peNfUHTBl2IX+hgaPVQTicXVqM0ljPFk6aJsbB9TyOYGJqBTcOvZwuUh0sMj9O9jmI6NCYDLZ+sNDZrLxBc1V8Q8Pfj8IrF7hJkevjrKcFinyrYAMfrWAKbYn44BpuAXOy1hzvkkP0Mk9dBWp/KqhB6Maq+LkkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734587; c=relaxed/simple;
	bh=u2gzS6WrpZoB1WL4mbe26QGmAtPg+0CtfGwuXRkt3Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeyDTiiOVSp2c+LE5GKE+enN0Tmf++3SJ8jmdjzv0/P3lgx26+0W0hTZlmWhS7XSfCp1gIiPddzqwYw6Qx/8WXTApSUKVXGhj61PgFq/QA7Z1b4wEB9Tf2ZezJvZS5oC67qcIe/rEKkSQXpH8D98BkJljkPoNrf6A6YfMGFfHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Wz1iBt; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f860c6015so43822739f.0;
        Thu, 15 Aug 2024 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723734585; x=1724339385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCdtynPqS15YDojWatKzXgmkQ7ROjxWMgydcSzAG8WA=;
        b=Y6Wz1iBtndHkbWf9gjSbnJ5b69nNzaT83x56Lhl3DdydwGIxOgUS3YBL6t0g6dz+Q0
         8Tr1hibR6hzRhJFprTUREGag9W8RKVkjr4yFJPa9Z7tF21S8rVIdEYF0z5jgpn07LJ3H
         ZAfp9xty+DcNPRuF8gPZ7LIpZmlUngSOqXkXbYHt27A8oxp69OODdHKBvv3/zQupQaAW
         89CKBlEcVdI0yJ+rqcP51NSBdqCpY9ICLiTIUWmPqwWBiQ/j0Dp7ODCh88/BL917fS+D
         DDaVnQFXg4CkvK7YV/utN4AsJKConWyYIr9hWaDwm4hrQ+Ithr0/sbE5SPM0QDjvZu8X
         HucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734585; x=1724339385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCdtynPqS15YDojWatKzXgmkQ7ROjxWMgydcSzAG8WA=;
        b=rtmD7gB6CL3+nQuQ8huAb5ZDmQntK+TCwAfUN1Fb4HnH8MEGq3Q5WMjnraEg/lzdCM
         zstlJMvjX1FgqkA1fGG5dfJnFYum7iG8cUOve9ePgvF+oldLVhb/GM8g1xE3Qlur4j4f
         JjYWQXH8IHYZd31qUp1y1Q/MWCgmLunodjc/RzqHlng4YFQCaD9wysIH67lUWyvkHJlW
         2nlTBkFkj6ZNJOLMoJJ2D8B2RMlAX6yZE+nVZU5etht4T8UewwUFrvho+FW9aAZm+jbt
         brhu+QPqVoU1B7k+uQ6aSRQ8lbrhyQizOfZxwR7+fUwkUrQkAC+wXADTv3qb6pPeSvC7
         O1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWRtJ1mj40UCPue2I5g35fT1ilYpDjAVP7dUKWpAF4yN0kS839jupML8wsC9o5xNZcdYAvYIqSUT9HEXxYwA2gC/VpVRquzyxdmSqPczmNmp8Gbj8j2AxI0Yys026TQ2PsGd1+i
X-Gm-Message-State: AOJu0YxFljbvr0h6w9dIkMX46su3WcqiaGKzLErfR+Koi2Uk3ocwUlgF
	uVg/oAzwGhGsj6GTxYHLisgVtXLSxSC506HfOI6fmiMTvp4oBHdT/saO0fyhLKNArR5pJbhpfkj
	u0jCin8jr4I3udKgiHsluQNBFSrk=
X-Google-Smtp-Source: AGHT+IHKMQXyEkkZ2P64gIJGevKF2p/97W3HloBK6AItAD37coNDyNeE12leVgpi0M2lWJI5zOEtsRuM1ydMtYJgRMY=
X-Received: by 2002:a05:6602:2c0d:b0:806:31ee:13b with SMTP id
 ca18e2360f4ac-824f26719a6mr16832239f.4.1723734584525; Thu, 15 Aug 2024
 08:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-9-linyunsheng@huawei.com> <7d16ba784eb564f9d556f532d670b9bc4698d913.camel@gmail.com>
 <82cc55f0-35e9-4e54-8316-00312389de3f@huawei.com>
In-Reply-To: <82cc55f0-35e9-4e54-8316-00312389de3f@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2024 08:09:07 -0700
Message-ID: <CAKgT0Ud6EnT0ggwmVUEubX9TPkgGb9+5TTWK-_XnTBbqaec8Gw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 08/14] mm: page_frag: some minor refactoring
 before adding new API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 1:54, Alexander H Duyck wrote:
> > On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >> Refactor common codes from __page_frag_alloc_va_align()
> >> to __page_frag_cache_reload(), so that the new API can
> >> make use of them.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/page_frag_cache.h |   2 +-
> >>  mm/page_frag_cache.c            | 138 ++++++++++++++++++-------------=
-
> >>  2 files changed, 81 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag=
_cache.h
> >> index 4ce924eaf1b1..0abffdd10a1c 100644
> >> --- a/include/linux/page_frag_cache.h
> >> +++ b/include/linux/page_frag_cache.h
> >> @@ -52,7 +52,7 @@ static inline void *encoded_page_address(unsigned lo=
ng encoded_va)
> >>
> >>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> >>  {
> >> -    nc->encoded_va =3D 0;
> >> +    memset(nc, 0, sizeof(*nc));
> >>  }
> >>
> >
> > Still not a fan of this. Just setting encoded_va to 0 should be enough
> > as the other fields will automatically be overwritten when the new page
> > is allocated.
> >
> > Relying on memset is problematic at best since you then introduce the
> > potential for issues where remaining somehow gets corrupted but
> > encoded_va/page is 0. I would rather have both of these being checked
> > as a part of allocation than just just assuming it is valid if
> > remaining is set.
>
> Does adding something like VM_BUG_ON(!nc->encoded_va && nc->remaining) to
> catch the above problem address your above concern?

Not really. I would prefer to just retain the existing behavior.

> >
> > I would prefer to keep the check for a non-0 encoded_page value and
> > then check remaining rather than just rely on remaining as it creates a
> > single point of failure. With that we can safely tear away a page and
> > the next caller to try to allocate will populated a new page and the
> > associated fields.
>
> As mentioned before, the memset() is used mainly because of:
> 1. avoid a checking in the fast path.
> 2. avoid duplicating the checking pattern you mentioned above for the
>    new API.

I'm not a fan of the new code flow after getting rid of the checking
in the fast path. The code is becoming a tangled mess of spaghetti
code in my opinion. Arguably the patches don't help as you are taking
huge steps in many of these patches and it is making it hard to read.
In addition the code becomes more obfuscated with each patch which is
one of the reasons why I would have preferred to see this set broken
into a couple sets so we can give it some time for any of the kinks to
get worked out.

> >
> >>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cac=
he *nc)
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index 2544b292375a..4e6b1c4684f0 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -19,8 +19,27 @@
> >>  #include <linux/page_frag_cache.h>
> >>  #include "internal.h"
> >>
>
> ...
>
> >> +
> >> +/* Reload cache by reusing the old cache if it is possible, or
> >> + * refilling from the page allocator.
> >> + */
> >> +static bool __page_frag_cache_reload(struct page_frag_cache *nc,
> >> +                                 gfp_t gfp_mask)
> >> +{
> >> +    if (likely(nc->encoded_va)) {
> >> +            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_b=
ias))
> >> +                    goto out;
> >> +    }
> >> +
> >> +    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> >> +            return false;
> >> +
> >> +out:
> >> +    /* reset page count bias and remaining to start of new frag */
> >> +    nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> +    nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);
> >
> > One thought I am having is that it might be better to have the
> > pagecnt_bias get set at the same time as the page_ref_add or the
> > set_page_count call. In addition setting the remaining value at the
> > same time probably would make sense as in the refill case you can make
> > use of the "order" value directly instead of having to write/read it
> > out of the encoded va/page.
>
> Probably, there is always tradeoff to make regarding avoid code
> duplication and avoid reading the order, I am not sure it matters
> for both for case, I would rather keep the above pattern if there
> is not obvious benefit for the other pattern.

Part of it is more about keeping the functions contained to generating
self contained objects. I am not a fan of us splitting up the page
init into a few sections as it makes it much easier to mess up a page
by changing one spot and overlooking the fact that an additional page
is needed somewhere else.

> >
> > With that we could simplify this function and get something closer to
> > what we had for the original alloc_va_align code.
> >
> >> +    return true;
> >>  }
> >>
> >>  void page_frag_cache_drain(struct page_frag_cache *nc)
> >> @@ -55,7 +100,7 @@ void page_frag_cache_drain(struct page_frag_cache *=
nc)
> >>
> >>      __page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va)=
,
> >>                              nc->pagecnt_bias);
> >> -    nc->encoded_va =3D 0;
> >> +    memset(nc, 0, sizeof(*nc));
> >>  }
> >>  EXPORT_SYMBOL(page_frag_cache_drain);
> >>
> >> @@ -73,67 +118,44 @@ void *__page_frag_alloc_va_align(struct page_frag=
_cache *nc,
> >>                               unsigned int align_mask)
> >>  {
> >>      unsigned long encoded_va =3D nc->encoded_va;
> >> -    unsigned int size, remaining;
> >> -    struct page *page;
> >> -
> >> -    if (unlikely(!encoded_va)) {
> >
> > We should still be checking this before we even touch remaining.
> > Otherwise we greatly increase the risk of providing a bad virtual
> > address and have greatly decreased the likelihood of us catching
> > potential errors gracefully.
> >
> >> -refill:
> >> -            page =3D __page_frag_cache_refill(nc, gfp_mask);
> >> -            if (!page)
> >> -                    return NULL;
> >> -
> >> -            encoded_va =3D nc->encoded_va;
> >> -            size =3D page_frag_cache_page_size(encoded_va);
> >> -
> >> -            /* Even if we own the page, we do not use atomic_set().
> >> -             * This would break get_page_unless_zero() users.
> >> -             */
> >> -            page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> >> -
> >> -            /* reset page count bias and remaining to start of new fr=
ag */
> >> -            nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> -            nc->remaining =3D size;
> >
> > With my suggested change above you could essentially just drop the
> > block starting from the comment and this function wouldn't need to
> > change as much as it is.
>
> It seems you are still suggesting that new API also duplicates the old
> checking pattern in __page_frag_alloc_va_align()?
>
> I would rather avoid the above if something like VM_BUG_ON() can address
> your above concern.

Yes, that is what I am suggesting. It makes the code much less prone
to any sort of possible races as resetting encoded_va would make it so
that reads for all the other fields would be skipped versus having to
use a memset which differs in implementation depending on the
architecture.

