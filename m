Return-Path: <netdev+bounces-137292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E476F9A54CF
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C46BB218FB
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E318193079;
	Sun, 20 Oct 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuJoFNE2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662C79F6;
	Sun, 20 Oct 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439171; cv=none; b=nyYm/TbrlnyDsvlO2WOo++DdRxeT0lmxmGAwphGw1/RrHePuyPb4VDS309iu0b0Qx+PVHH4LryBEOubF3CKZGMTBY18KZVxsPSOKgTRO75jCp/1pWUVmvsNnAjLPu8kB7157IxHEXdHx2MP6aVtgc1dJD4kcr3dzRRNh2B2KsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439171; c=relaxed/simple;
	bh=H3BmJbQvjx8bjRLo6TYpmkIaXhWGT/hkUaWS35dGXWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZejwuKXAVT/hfSE1qMYxtu25+HbNfwCw6KJVuS49+/44dIj4sVMUcRrr/mLMrIo/pUPzdF0gCuckIsBh0GsQFWDYUYA2Yve4QarlVdJiOOerdy/PweFlBgHYgzrFqyyAR8VEYnDd3PgId5NlLkG6qgFF6EOn/7eA6QmJyyhiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuJoFNE2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so2826140f8f.3;
        Sun, 20 Oct 2024 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729439167; x=1730043967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PjXYYMDpPm5X5EPWEKHoxPJTPqKzwTZG3+9F8SNHhM=;
        b=cuJoFNE2d9qNXULFDYcluB7U3bKd0phLdNTHEfQE8LRnR/wbtfK6zLbj4hFS7RYNIU
         OzWciB+c0YIA633K17CCy2dzJOL1eaBzMhzXGzMNV9zxBluWupJRHgLycNAzUUaMkIjw
         Hayn4cx//fZPhaCqRueHOWM5K6ztp/hv/fcfJDWNHz9JNCnpAbmXNskwc8dHQW0XafKU
         9aD29WrklHYmmdemP3qW5Oj6KmLwjw4Xc5TahSASZMEgBt2JR9VZR6Snv+jHTE+I5rvP
         mIZ400Z9ktombkQvaL3P8uSc9EW4pofcFsyPzmykYXYI8e/7PSlGugK3HeFiC+qn15Ai
         EWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729439167; x=1730043967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PjXYYMDpPm5X5EPWEKHoxPJTPqKzwTZG3+9F8SNHhM=;
        b=WTI52KefP0tNTGtX5IFRRjSn5/G7zmXo8dhSvz2faLm/1zDF65WL92Izh8WMe9amOt
         TvsIT/P9WTY0KON12ou0Hm9XEZyC2BX88Ff1ChJD+IsW1jqfLEMkeVQShRbSV7Txua7+
         THXi4YxDS/HK2ojhb9/+BsMb8i47Y6U5zneLB6nV3BZwnhqYN47QcM4xsn5t/OuwuT9q
         07zBzaHVR4SJ9J1/GHGZzvlevHXbhvWFvFEKlfxQnNJOJDDsib33Wr6lUClfhbDCj4MA
         j+lffo37FDQtd8ZLDd8kEo1OuVYz+9WzsIjUVTNH6fYVdeHLNCLaaLGqBP7gTPo4M36L
         5bjA==
X-Forwarded-Encrypted: i=1; AJvYcCUAhL1CC/thmR8YdzKwPZimo7FO0nf9vo5UIe4do3SVHPPfRPciEkPMNfJJOaK/Rf7mkX+O5K3Y8fQO+CE=@vger.kernel.org, AJvYcCURSp4rJRCifKg7JgSRQTUtUsJffM5ihV1wq44+ChdxI9HiBS1Kc8/BQcgAENo7T/+QrN/wbMNG@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYqnNVok3xVgPRg9MDlSbyfewqrTyCfSBDP26WxReOBhE4jqM
	G811zvw0H5giUDJ+Xs+/0tvRUU19L5zPzFl7vKhSriY/SpRXVvLmUicYrvz9OTHwPFtKYtJxCY6
	giQfd0CaHgbne60J69630g2AYXxM=
X-Google-Smtp-Source: AGHT+IFpTTK4xiZI+sQVonpSTpHD6MhBxh/2WcsJso7oJEHFdD5WDxTb3wuuPVyGYl3gdXTbACogsrG9ax0OKJcikNs=
X-Received: by 2002:a05:6000:4013:b0:374:b5fc:d31a with SMTP id
 ffacd0b85a97d-37eab7260ebmr7395445f8f.25.1729439166886; Sun, 20 Oct 2024
 08:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-8-linyunsheng@huawei.com> <CAKgT0UcBveXG3D9aHHADHn3yAwA6mLeQeSqoyP+UwyQ3FDEKGw@mail.gmail.com>
 <e38cc22e-afbc-445e-b986-9ab31c799a09@gmail.com>
In-Reply-To: <e38cc22e-afbc-445e-b986-9ab31c799a09@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 20 Oct 2024 08:45:29 -0700
Message-ID: <CAKgT0UeM15+HZor5_woJ4Fd_YrHVgrMM86wD4o5xGczQXC2aOg@mail.gmail.com>
Subject: Re: [PATCH net-next v22 07/14] mm: page_frag: some minor refactoring
 before adding new API
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 1:30=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 10/19/2024 1:26 AM, Alexander Duyck wrote:
>
> ...
>
> >> +static inline void *__page_frag_alloc_align(struct page_frag_cache *n=
c,
> >> +                                           unsigned int fragsz, gfp_t=
 gfp_mask,
> >> +                                           unsigned int align_mask)
> >> +{
> >> +       struct page_frag page_frag;
> >> +       void *va;
> >> +
> >> +       va =3D __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_m=
ask,
> >> +                                      align_mask);
> >> +       if (unlikely(!va))
> >> +               return NULL;
> >> +
> >> +       __page_frag_cache_commit(nc, &page_frag, fragsz);
> >
> > Minor nit here. Rather than if (!va) return I think it might be better
> > to just go with if (likely(va)) __page_frag_cache_commit.
>
> Ack.
>
> >
> >> +
> >> +       return va;
> >> +}
> >>
> >>   static inline void *page_frag_alloc_align(struct page_frag_cache *nc=
,
> >>                                            unsigned int fragsz, gfp_t =
gfp_mask,
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index a36fd09bf275..a852523bc8ca 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -90,9 +90,31 @@ void __page_frag_cache_drain(struct page *page, uns=
igned int count)
> >>   }
> >>   EXPORT_SYMBOL(__page_frag_cache_drain);
> >>
> >> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
> >> -                             unsigned int fragsz, gfp_t gfp_mask,
> >> -                             unsigned int align_mask)
> >> +unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *n=
c,
> >> +                                           struct page_frag *pfrag,
> >> +                                           unsigned int used_sz)
> >> +{
> >> +       unsigned int orig_offset;
> >> +
> >> +       VM_BUG_ON(used_sz > pfrag->size);
> >> +       VM_BUG_ON(pfrag->page !=3D encoded_page_decode_page(nc->encode=
d_page));
> >> +       VM_BUG_ON(pfrag->offset + pfrag->size >
> >> +                 (PAGE_SIZE << encoded_page_decode_order(nc->encoded_=
page)));
> >> +
> >> +       /* pfrag->offset might be bigger than the nc->offset due to al=
ignment */
> >> +       VM_BUG_ON(nc->offset > pfrag->offset);
> >> +
> >> +       orig_offset =3D nc->offset;
> >> +       nc->offset =3D pfrag->offset + used_sz;
> >> +
> >> +       /* Return true size back to caller considering the offset alig=
nment */
> >> +       return nc->offset - orig_offset;
> >> +}
> >> +EXPORT_SYMBOL(__page_frag_cache_commit_noref);
> >> +
> >
> > I have a question. How often is it that we are committing versus just
> > dropping the fragment? It seems like this approach is designed around
> > optimizing for not commiting the page as we are having to take an
> > extra function call to commit the change every time. Would it make
> > more sense to have an abort versus a commit?
>
> Before this patch, page_frag_alloc() related API seems to be mostly used
> for skb data or frag for rx part, see napi_alloc_skb() or some drivers
> like e1000, but with more drivers using the page_pool for skb rx frag,
> it seems skb data for tx is the main usecase.
>
> And the prepare and commit API added in the patchset seems to be mainly
> used for skb frag for tx part except af_packet.
>
> It seems it is not very clear which is mostly used one, mostly likely
> the prepare and commit API might be the mostly used one if I have to
> guess as there might be more memory needed for skb frag than skb data.

Well one of the things I am noticing is that you have essentially two
API setups in the later patches.

In one you are calling the page_frag_alloc_align and then later
calling an abort function that is added later. In the other you have
the probe/commit approach. In my mind it might make sense to think
about breaking those up to be handled as two seperate APIs rather than
trying to replace everything all at once.

> >
> >> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned =
int fragsz,
> >> +                               struct page_frag *pfrag, gfp_t gfp_mas=
k,
> >> +                               unsigned int align_mask)
> >>   {
> >>          unsigned long encoded_page =3D nc->encoded_page;
> >>          unsigned int size, offset;
> >> @@ -114,6 +136,8 @@ void *__page_frag_alloc_align(struct page_frag_cac=
he *nc,
> >>                  /* reset page count bias and offset to start of new f=
rag */
> >>                  nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >>                  nc->offset =3D 0;
> >> +       } else {
> >> +               page =3D encoded_page_decode_page(encoded_page);
> >>          }
> >>
> >>          size =3D PAGE_SIZE << encoded_page_decode_order(encoded_page)=
;
> >
> > This makes no sense to me. Seems like there are scenarios where you
> > are grabbing the page even if you aren't going to use it? Why?
> >
> > I think you would be better off just waiting to the end and then
> > fetching it instead of trying to grab it and potentially throw it away
> > if there is no space left in the page. Otherwise what you might do is
> > something along the lines of:
> > pfrag->page =3D page ? : encoded_page_decode_page(encoded_page);
>
> But doesn't that mean an additional checking is needed to decide if we
> need to grab the page?
>
> But the './scripts/bloat-o-meter' does show some binary size shrink
> using the above.

You are probably correct on this one. I think your approach may be
better. I think the only case my approach would be optimizing for
would probably be the size > 4K which isn't appropriate anyway.

> >
> >
> >> @@ -132,8 +156,6 @@ void *__page_frag_alloc_align(struct page_frag_cac=
he *nc,
> >>                          return NULL;
> >>                  }
> >>
> >> -               page =3D encoded_page_decode_page(encoded_page);
> >> -
> >>                  if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> >>                          goto refill;
> >>
> >> @@ -148,15 +170,17 @@ void *__page_frag_alloc_align(struct page_frag_c=
ache *nc,
> >>
> >>                  /* reset page count bias and offset to start of new f=
rag */
> >>                  nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> +               nc->offset =3D 0;
> >>                  offset =3D 0;
> >>          }
> >>
> >> -       nc->pagecnt_bias--;
> >> -       nc->offset =3D offset + fragsz;
> >> +       pfrag->page =3D page;
> >> +       pfrag->offset =3D offset;
> >> +       pfrag->size =3D size - offset;
> >
> > I really think we should still be moving the nc->offset forward at
> > least with each allocation. It seems like you end up doing two flavors
> > of commit, one with and one without the decrement of the bias. So I
> > would be okay with that being pulled out into some separate logic to
> > avoid the extra increment in the case of merging the pages. However in
> > both cases you need to move the offset, so I would recommend keeping
> > that bit there as it would allow us to essentially call this multiple
> > times without having to do a commit in between to keep the offset
> > correct. With that your commit logic only has to verify nothing
> > changes out from underneath us and then update the pagecnt_bias if
> > needed.
>
> The problem is that we don't really know how much the nc->offset
> need to be moved forward to and the caller needs the original offset
> for skb_fill_page_desc() related calling when prepare API is used as
> an example in 'Preparation & committing API' section of patch 13:

The thing is you really have 2 different APIs. You have one you were
doing which was a alloc/abort approach and another that is a
probe/commit approach. I think for the probe/commit you could probably
get away with using an "alloc" type approach with a size of 0 which
would correctly set the start of your offset and then you would need
to update it later once you know the total size for your commit. For
the probe/commit we could use the nc->offset as a kind of cookie to
verify we are working with the expected page and offset.

For the alloc/abort it would be something similar but more the
reverse. With that one we would need to have the size + offset and
then verify the current offset is equal to that before we allow
reverting the previous nc->offset update. The current patch set is a
bit too permissive on the abort in my opinion and should be verifying
that we are updating the correct offset.

