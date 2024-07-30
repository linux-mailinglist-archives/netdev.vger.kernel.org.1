Return-Path: <netdev+bounces-114202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12E941533
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911301C23112
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94D1A2C28;
	Tue, 30 Jul 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKxeQ5is"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171B147C86;
	Tue, 30 Jul 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352366; cv=none; b=qN0+a53l3nnatPgGqlgGMElb43kILy81u0r+9izzkK1SmOiOpSBwU60GBQg3unIA0SI8CgP3fbYkK0pKo+3sDNURtRLIYZngdkaO2QFEkSUjjHUF0/SGEu8eXvP1RhEApK/ubIrUFD8mhKQnOmKDpkJrQoNH1v/VWNTs4xRm8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352366; c=relaxed/simple;
	bh=M5btl9zhnmbfhJoLplSVhG526+SFLj2aZcgaFMUW9Ls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlcCX0OoYRr6KYIHP4MDnp/XN/xS06n4QEJLTGfmTyxeGdJMhVG5ot7gfoNpPlci4kZBirdDUwDhqJ6/UJ294EC7sIlBry27D01gK+ih7Hmty8c77FaNviYBwshPYJMKHOSGbjmmFg0n6tgBqBtPWCjBwge3JxYrrkkv5yINH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKxeQ5is; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso3171942b3a.1;
        Tue, 30 Jul 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352364; x=1722957164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GVugQl+eanMaRvw5CudOTZB+XSH5eb6DxiOKQnVK1ZE=;
        b=MKxeQ5isoF5NZK4yZ4s8oN2jaeo4bSqXb5QcTDDAHITnNeg4QEutKuWbof+mH9H3ts
         BURn8lEIGh5hO5cXfHrauCipuYT9HVE4W/DBL3jMnZmx/hbFOs4bF+doa0/5FirpvrFR
         Hr2d3kSsNsCYvHNVbS/0jNuKJL7FZ47wCyAXtQghagKvbEfioAf26Taf8V0TIazvFgnM
         G1z/j0oGuvatlx3A43OYL3qgBncpqcaZtjTuILo4EcMhebu5R0nz5xndT/o7hiX2Jt7w
         aeMhmPVFrdGcbgRdVBCn3CJKLeLYHcD0CagD0e0/9RJ2BFnmc2yissSXAFjQFpG9jy2+
         fUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352364; x=1722957164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVugQl+eanMaRvw5CudOTZB+XSH5eb6DxiOKQnVK1ZE=;
        b=ZOPn0cBCw+JIWkTMTks7T8pRO5fZSLP/+lLnjOGRLLw//c5+ziTrYYiU22wuhqH1yc
         FFiuPlfmDg1rTEBPBDHbvMVZggzDJKA4coCsw40Nmlh9bxdnvXN21Fus1S3Ai1WzIkWt
         SYvmoT2WAKN6B2Xdh713ktfRA029t+RDFqQwG88hkoSuNYiHw8Rm/8NR0i2utKxO3vuZ
         0nspnWf/Os4aD88Ji4HatSnvSRyFanxfMchA/WphpEcDbmARPoWPbPu7BgPf97T8CqId
         5a6O3KxcwU2HRC+cqCsHUu03mdTwPMrCSElANqzCvCfV0VVNuWBnMlxhOJknuKDm7s9M
         usOA==
X-Forwarded-Encrypted: i=1; AJvYcCWDmzg3ZUqLrC69XQ7TltzX8KOIDr3e8kB4wd4Jwp/sW6oDJBZFjak05dKqigtVKCAPmbupG8JjZF3py0UQhMFsJDCgbXngBMukv6WthSqy4LKpk9P8mEP6TfSONFJmnZhYPupr
X-Gm-Message-State: AOJu0YxSlpNtybojTYG9N6PE6YuSU8SGjOE5euhmh1jPLrk8nIaGag0r
	VrzI+Vz4j23HbFnC07hpPoxxlv/PJMtG/+AVzCerBRTCtDI6JsxF
X-Google-Smtp-Source: AGHT+IG6Wbc+HpZnPJAIkBLRjtEPwFwwp0fU1uZJ4MVK7qA9lP0PQrlK4lJvsis2L2DdAAjdHrrJGQ==
X-Received: by 2002:a05:6a00:9141:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-70ece9eba1emr9492005b3a.6.1722352364104;
        Tue, 30 Jul 2024 08:12:44 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70ead8748a1sm8568598b3a.150.2024.07.30.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:12:42 -0700 (PDT)
Message-ID: <ad691cb4a744cbdc7da283c5c068331801482b36.camel@gmail.com>
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 30 Jul 2024 08:12:42 -0700
In-Reply-To: <af06fc13-ae3f-41ca-9723-af1c8d9d051d@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-9-linyunsheng@huawei.com>
	 <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
	 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
	 <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
	 <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
	 <af06fc13-ae3f-41ca-9723-af1c8d9d051d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-30 at 21:20 +0800, Yunsheng Lin wrote:
> On 2024/7/23 21:19, Yunsheng Lin wrote:
> > >=20

...

> > > The only piece that is really reused here is the pagecnt_bias
> > > assignment. What is obfuscated away is that the order is gotten
> > > through one of two paths. Really order isn't order here it is size.
> > > Which should have been fetched already. What you end up doing with
> > > this change is duplicating a bunch of code throughout the function.
> > > You end up having to fetch size multiple times multiple ways. here yo=
u
> > > are generating it with order. Then you have to turn around and get it
> > > again at the start of the function, and again after calling this
> > > function in order to pull it back out.
> >=20
> > I am assuming you would like to reserve old behavior as below?
> >=20
> > 	if(!encoded_va) {
> > refill:
> > 		__page_frag_cache_refill()
> > 	}
> >=20
> >=20
> > 	if(remaining < fragsz) {
> > 		if(!__page_frag_cache_recharge())
> > 			goto refill;
> > 	}
> >=20
> > As we are adding new APIs, are we expecting new APIs also duplicate
> > the above pattern?
> >=20
> > >=20
>=20
> How about something like below? __page_frag_cache_refill() and
> __page_frag_cache_reuse() does what their function name suggests
> as much as possible, __page_frag_cache_reload() is added to avoid
> new APIs duplicating similar pattern as much as possible, also
> avoid fetching size multiple times multiple ways as much as possible.

This is better. Still though with the code getting so spread out we
probably need to start adding more comments to explain things.

> static struct page *__page_frag_cache_reuse(unsigned long encoded_va,
>                                             unsigned int pagecnt_bias)
> {
>         struct page *page;
>=20
>         page =3D virt_to_page((void *)encoded_va);
>         if (!page_ref_sub_and_test(page, pagecnt_bias))
>                 return NULL;
>=20
>         if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>                 VM_BUG_ON(compound_order(page) !=3D
>                           encoded_page_order(encoded_va));

This VM_BUG_ON here makes no sense. If we are going to have this
anywhere it might make more sense in the cache_refill case below to
verify we are setting the order to match when we are generating the
encoded_va.

>                 free_unref_page(page, encoded_page_order(encoded_va));
>                 return NULL;
>         }
>=20
>         /* OK, page count is 0, we can safely set it */
>         set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>         return page;

Why are you returning page here? It isn't used by any of the callers.
We are refilling the page here anyway so any caller should already have
access to the page since it wasn't changed.

> }
>=20
> static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
> {
>         unsigned long order =3D PAGE_FRAG_CACHE_MAX_ORDER;
>         struct page *page =3D NULL;
>         gfp_t gfp =3D gfp_mask;
>=20
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>                                 PAGE_FRAG_CACHE_MAX_ORDER);

I suspect the compliler is probably already doing this, but we should
probably not be updating gfp_mask but instead gfp since that is our
local variable.

> #endif
>         if (unlikely(!page)) {
>                 page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>                 if (unlikely(!page)) {
>                         memset(nc, 0, sizeof(*nc));
>                         return NULL;
>                 }
>=20
>                 order =3D 0;
>         }
>=20
>         nc->encoded_va =3D encode_aligned_va(page_address(page), order,
>                                            page_is_pfmemalloc(page));
>=20
>         /* Even if we own the page, we do not use atomic_set().
>          * This would break get_page_unless_zero() users.
>          */
>         page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>=20
>         return page;

Again, returning page here doesn't make much sense. You are better off
not exposing internals as you have essentially locked the page down for
use by the frag API so you shouldn't be handing out the page directly
to callers.

> }
>=20
> static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
>                                              gfp_t gfp_mask)
> {
>         struct page *page;
>=20
>         if (likely(nc->encoded_va)) {
>                 page =3D __page_frag_cache_reuse(nc->encoded_va, nc->page=
cnt_bias);
>                 if (page)
>                         goto out;
>         }
>=20
>         page =3D __page_frag_cache_refill(nc, gfp_mask);
>         if (unlikely(!page))
>                 return NULL;
>=20
> out:
>         nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);
>         nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>         return page;

Your one current caller doesn't use the page value provided here. I
would recommend just not bothering with the page variable until you
actually need it.

> }
>=20
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>                                  unsigned int fragsz, gfp_t gfp_mask,
>                                  unsigned int align_mask)
> {
>         unsigned long encoded_va =3D nc->encoded_va;
>         unsigned int remaining;
>=20
>         remaining =3D nc->remaining & align_mask;
>         if (unlikely(remaining < fragsz)) {

You might as well swap the code paths. It would likely be much easier
to read the case where you are handling remaining >=3D fragsz in here
rather than having more if statements buried within the if statement.
With that you will have more room for the comment and such below.

>                 if (unlikely(fragsz > PAGE_SIZE)) {
>                         /*
>                          * The caller is trying to allocate a fragment
>                          * with fragsz > PAGE_SIZE but the cache isn't bi=
g
>                          * enough to satisfy the request, this may
>                          * happen in low memory conditions.
>                          * We don't release the cache page because
>                          * it could make memory pressure worse
>                          * so we simply return NULL here.
>                          */
>                         return NULL;
>                 }
>=20
>                 if (unlikely(!__page_frag_cache_reload(nc, gfp_mask)))
>                         return NULL;

This is what I am talking about in the earlier comments. You go to the
trouble of returning page through all the callers just to not use it
here. So there isn't any point in passing it through the functions.

>=20
>                 nc->pagecnt_bias--;
>                 nc->remaining -=3D fragsz;
>=20
>                 return encoded_page_address(nc->encoded_va);
>         }
>=20
>         nc->pagecnt_bias--;
>         nc->remaining =3D remaining - fragsz;
>=20
>         return encoded_page_address(encoded_va) +
>                 (page_frag_cache_page_size(encoded_va) - remaining);

Parenthesis here shouldn't be needed, addition and subtractions
operations can happen in any order with the result coming out the same.

