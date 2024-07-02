Return-Path: <netdev+bounces-108552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D8924308
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF31F22672
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B991B4C4B;
	Tue,  2 Jul 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/vantZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A615218A;
	Tue,  2 Jul 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936089; cv=none; b=smSZnVtpwaz8SUORFYLypclGbb8zTlSsDV2uJmRCoJ4eushTEI5sIDUX6PwZjFrAe8DmqC+kCcUmPNTQx0t7nhCkVXrC2XZ9YHMdo2tvMcaJrjNu5ugglMSZZJP6FCA7AWNCbp7NnMIpnYtK5Fz6yAhs45gw2UyDEPOKq2HA/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936089; c=relaxed/simple;
	bh=y0asDZ6AOiQDi9OqpPJGUWAlYWwe9TVX/IzWJ84yMWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDQvrrvGuUyyCw66mD9m7S7/uBn9MW2w0pwL7ceHGVpLbhJPO9mAVlsBhd2dX5JWe0obBCwywTU5oe/pVWjr9sODfH/GewBZ8sXscAyliwhuOfokN8CQjXyJ+fIxeZuB4WWVUW1s9fyGwEA+SMzuA1qYgyvu3/GFfJUm4NV2XwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/vantZK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so22510595e9.3;
        Tue, 02 Jul 2024 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719936086; x=1720540886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKrebsbYn4wTrPIAqK35IeD8+1XjetsIa1WTSDDePoc=;
        b=G/vantZK/b9pTz4YkA1B+JV7SGmC1eWPZ8lr+NUd8DsxDO91O1u6HTQH2eK1fXc8ee
         6JGOlik/Xj/oiOxzV4NNzaqMzXOJrrzB3nqvHurYfS6ADjNNijzld8m+y1ADsSYY5o4+
         YiPjGafExZQwkpwwdemik4hGUviGM11lpf3MVU7l5LrQJjEBCewewvUT1DtLLz5M5N+l
         WTIvBueoLG3S/xERbXhaUpx0i++tKOIGTQfJRDMRyNe3phw/KPfWR86OZztHSuoTooWx
         JcVnkv1J9fvsEM3jiQfvpXjb0ua8vDMfa6HoJ035J/MDwH53/Kbw5ofj5exnzl3H74Ry
         7azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936086; x=1720540886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKrebsbYn4wTrPIAqK35IeD8+1XjetsIa1WTSDDePoc=;
        b=dQKrXlAyOZ8yuO4K8vX2kNG3g+7QFpMaqWXDUj5ekY5PVrJGR8X+jF6EFTq4WPVO5Y
         Gu4N0JfDa06XJ9MU5c0kxBRhNTy0IWz5mGr19Q2144JPHtWeN3vaBuHaqHjzc4iIPF/U
         48UQEYvuNTysKkaeHkpNMI9eoHtGQA8vzD4Cy/LdBFlE07oXs/G9uLEEc5T/6PJhknCs
         tDi4rbk7L4q7va9lJNXrDwcHl0qcxfzCOwLzExSxieiA4h9sMZNCpnO7H5jCWIWRGnCt
         as91u7eYCDh37iXwsbfMKKBr6fnpmf06VJ+1oWJ2r6J1pqj/oICkY/VoXWCG32Qdj3dp
         rPsA==
X-Forwarded-Encrypted: i=1; AJvYcCUUdkVLSgFEsIRSD1QK8T48JaWNowZT8F0mvgrU6M695nWrMROuKtCzQvqpd8Y4c/MfxAsZnFtx5y+xQ5eVCOXBlLfohbk+//evwqTVLneH+rPoh+hfQHtGgAf9K2QziH+j5B9S
X-Gm-Message-State: AOJu0Yz/2HJsafDnGvq4heBc/xPIV162uC1mTRMawfhIgAGDT5yBlQ6n
	jg/fz14SDXew/8JKr7PUVB/H/BIVpW2KMG9LlYaG9ujoMk0nPVL0fYKT06UybpHRciXYjYuO69N
	6K4IKGISJ+u7uZAVpaEKpxAIN1HU=
X-Google-Smtp-Source: AGHT+IFDMjotfmZMNXNo0rphhG+Eq5zowZbnss+IgOKermgiUGNR3yONIm6CrrrgvL9jw6dU2EQB8KZbWt4rsN7QJZo=
X-Received: by 2002:a05:600c:4792:b0:425:6207:12b4 with SMTP id
 5b1f17b1804b1-4257a03c80emr72337475e9.24.1719936085688; Tue, 02 Jul 2024
 09:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-4-linyunsheng@huawei.com> <8e80507c685be94256e0e457ee97622c4487716c.camel@gmail.com>
 <01dc5b5a-bddf-bd2d-220c-478be6b62924@huawei.com>
In-Reply-To: <01dc5b5a-bddf-bd2d-220c-478be6b62924@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 2 Jul 2024 09:00:48 -0700
Message-ID: <CAKgT0Ud-q-Z-ri0FQxdsHQegf1daVATEg3bKhs0cavQBcxwieg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 03/13] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:28=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/7/2 7:27, Alexander H Duyck wrote:
> > On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> >> We are above to use page_frag_alloc_*() API to not just
> > "about to use", not "above to use"
>
> Ack.
>
> >
> >> allocate memory for skb->data, but also use them to do
> >> the memory allocation for skb frag too. Currently the
> >> implementation of page_frag in mm subsystem is running
> >> the offset as a countdown rather than count-up value,
> >> there may have several advantages to that as mentioned
> >> in [1], but it may have some disadvantages, for example,
> >> it may disable skb frag coaleasing and more correct cache
> >> prefetching
> >>
>
> ...
>
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index 88f567ef0e29..da244851b8a4 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -72,10 +72,6 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
> >>              if (!page)
> >>                      return NULL;
> >>
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> -            /* if size can vary use size else just use PAGE_SIZE */
> >> -            size =3D nc->size;
> >> -#endif
> >>              /* Even if we own the page, we do not use atomic_set().
> >>               * This would break get_page_unless_zero() users.
> >>               */
> >> @@ -84,11 +80,16 @@ void *__page_frag_alloc_align(struct page_frag_cac=
he *nc,
> >>              /* reset page count bias and offset to start of new frag =
*/
> >>              nc->pfmemalloc =3D page_is_pfmemalloc(page);
> >>              nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> -            nc->offset =3D size;
> >> +            nc->offset =3D 0;
> >>      }
> >>
> >> -    offset =3D nc->offset - fragsz;
> >> -    if (unlikely(offset < 0)) {
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +    /* if size can vary use size else just use PAGE_SIZE */
> >> +    size =3D nc->size;
> >> +#endif
> >> +
> >> +    offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> >> +    if (unlikely(offset + fragsz > size)) {
> >
> > The fragsz check below could be moved to here.
> >
> >>              page =3D virt_to_page(nc->va);
> >>
> >>              if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> >> @@ -99,17 +100,13 @@ void *__page_frag_alloc_align(struct page_frag_ca=
che *nc,
> >>                      goto refill;
> >>              }
> >>
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> -            /* if size can vary use size else just use PAGE_SIZE */
> >> -            size =3D nc->size;
> >> -#endif
> >>              /* OK, page count is 0, we can safely set it */
> >>              set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> >>
> >>              /* reset page count bias and offset to start of new frag =
*/
> >>              nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> -            offset =3D size - fragsz;
> >> -            if (unlikely(offset < 0)) {
> >> +            offset =3D 0;
> >> +            if (unlikely(fragsz > PAGE_SIZE)) {
> >
> > Since we aren't taking advantage of the flag that is left after the
> > subtraction we might just want to look at moving this piece up to just
> > after the offset + fragsz check. That should prevent us from trying to
> > refill if we have a request that is larger than a single page. In
> > addition we could probably just drop the 3 PAGE_SIZE checks above as
> > they would be redundant.
>
> I am not sure I understand the 'drop the 3 PAGE_SIZE checks' part and
> the 'redundant' part, where is the '3 PAGE_SIZE checks'? And why they
> are redundant?

I was referring to the addition of the checks for align > PAGE_SIZE in
the alloc functions at the start of this diff. I guess I had dropped
them from the first half of it with the "...". Also looking back
through the patch you misspelled "avoid" as "aovid".

The issue is there is a ton of pulling things forward that don't
necessarily make sense into these diffs. Now that I have finished
looking through the set I have a better idea of why those are there
and they might make sense. It is just difficult to review since code
is being added for things that aren't applicable to the patch being
reviewed.

