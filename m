Return-Path: <netdev+bounces-119788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDA956F49
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058281C229A9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817713957B;
	Mon, 19 Aug 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3kwmFUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB002941B;
	Mon, 19 Aug 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082818; cv=none; b=mdm4yqwpAn/XCSF9ULT3vIpF5WmrdwDfplBA/PPkBYyZJRb1+NGS5HWXVapiRrIjoodDuZ0UwGMpNBnSImHpJIZUMO5myfALI0coJzEBaeQNexCSYE9z8l2CenOrRhanwiHXrSGl9sBvfhGKXHrK9brGSttLaK9TD+3zL7XFKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082818; c=relaxed/simple;
	bh=L5e6UEnKlHXBnCj8JRlPeRc1KwouxnXjwrgaNSrU/eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3uPSp0FybF/CiRwacnvD3gk64SGTRJJAasdP4ZzINn/ndNL6qjLuPa3ivfD7ZfHdptbhla39hohbAlwth+lDY81OPyh4fLK3aaHPLm2ZEisxEBT6KXww+cOa1EO9FavYuGe4sitxBIscW/QM0q6suleVuqk49gkuGgrCu10r00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3kwmFUL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bca3960so39328695e9.3;
        Mon, 19 Aug 2024 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724082815; x=1724687615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHjuzHLc6dVbH873UnnfxiBtXqzG2kypRsGylP+Qz8Q=;
        b=T3kwmFULTSMt0C1qhiQyZrFYAnE1HZ4nxHdrDacxhxo0pFf0eS03iJsLZQVzWRiCXE
         24KwyqUSQ+zYuUarzAKDAO1XQEcf+kS8vyYXSvRJvwpOfVius8qjhTro9bExUQKrgTsK
         VYrtkzlZr3u7eYwoICaXCBO4QBECNIK11blVYFi/XiLcjlyDRrRQo4IQRp2Pfr+zFyyW
         ndevL2uDZW/BylFqSEeusJulXC636KQi6aWEg56tJ4mMV8diU3jHBiNheuahElYq4GhC
         rICX2rQnf0CFww6HbTmh3UxiHq8DAfNHYoQkYCKSCSuoI/wBN6LNo/y5jJeDQKLbQF85
         HrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082815; x=1724687615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHjuzHLc6dVbH873UnnfxiBtXqzG2kypRsGylP+Qz8Q=;
        b=izZKJblbxCEzqdKOh/L0y3dH8mbCUE81NyTrywOTwnVzUQEJyJe45dpi8MKyM/wZl/
         jhEatWDBYpdzCm6X6ehdTkGxpl5lYZm5agWDM8QhoJptR1M9AEtDv33qOkuFyqHldHEY
         sns5HpDxIjQ5RJtCN5S5mQZWZmR78C2A5HpyP2yb9fdxc+i/mjlmgCMLRMe4J3ScnLo0
         mBhAO2CGnjGG4fF5HFiEkyO3NHCeGJpX7CWRGyzZnBG1R83BIslL6LtoUgieFEGt9WJb
         D4VTWJ/VuuLViIxC9mf4RqbY5F1L6EcbkvQdh5bOXMustnCXgsXoGxLxtCQ6fC7L1Vn2
         W1wA==
X-Forwarded-Encrypted: i=1; AJvYcCVRjVpCFalHhBss56u6xa8lAC0dCH5BMCPwjnKOkNtjmGqTgkyNhrUd5gqeiSDz+svvfH8T+jCXtzkAmNl5VPnEnwiSM0Azfc+NSOyeW7sOnpgImnLwPWK49tGq5pvS0NAypqMT
X-Gm-Message-State: AOJu0Yzc0P1g68L+JuZlwQScDqXEK98WTystsN+Y5wHU8bjvaV6OCi4G
	YdreIrRGOTj1RYyy/RKaEd09kXyLU1fybLy093kmTqTXkAg0SBF5DEufqm6PpdrpWokyQF7LSz6
	5j9rg9bKgInT9fw3I5YA6PMvLFe8=
X-Google-Smtp-Source: AGHT+IGQebnGsoVvedM2mMyp/EghK9PoeWJVkJxA7xPAhuM5bYFyaz+0IQN7NgeQJW5stT9jK19xelNtf1qrHeubrms=
X-Received: by 2002:a05:600c:1c8f:b0:428:23c8:1e54 with SMTP id
 5b1f17b1804b1-429ed7b8360mr89105815e9.18.1724082814573; Mon, 19 Aug 2024
 08:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-12-linyunsheng@huawei.com> <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
 <7f06fa30-fa7c-4cf2-bd8e-52ea1c78f8aa@huawei.com> <CAKgT0Uetu1HA4hCGvBLwRgsgX6Y95FDw0epVf5S+XSnezScQ_w@mail.gmail.com>
 <5905bad4-8a98-4f9d-9bd6-b9764e299ac7@huawei.com>
In-Reply-To: <5905bad4-8a98-4f9d-9bd6-b9764e299ac7@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 19 Aug 2024 08:52:58 -0700
Message-ID: <CAKgT0Ucz4R=xOCWgauDO_i6PX7=hgiohXngo2Mea5R8GC_s2qQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 11/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:01=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 23:25, Alexander Duyck wrote:
> > On Wed, Aug 14, 2024 at 8:05=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/8/15 5:00, Alexander H Duyck wrote:
> >
> > ...
> >
> >>>> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc=
,
> >>>> +                                     unsigned int fragsz)
> >>>> +{
> >>>> +    nc->pagecnt_bias++;
> >>>> +    nc->remaining +=3D fragsz;
> >>>> +}
> >>>> +
> >>>
> >>> This doesn't add up. Why would you need abort if you have commit? Isn=
't
> >>> this more of a revert? I wouldn't think that would be valid as it is
> >>> possible you took some sort of action that might have resulted in thi=
s
> >>> memory already being shared. We shouldn't allow rewinding the offset
> >>> pointer without knowing that there are no other entities sharing the
> >>> page.
> >>
> >> This is used for __tun_build_skb() in drivers/net/tun.c as below, main=
ly
> >> used to avoid performance penalty for XDP drop case:
> >
> > Yeah, I reviewed that patch. As I said there, rewinding the offset
> > should be avoided unless you can verify you are the only owner of the
> > page as you have no guarantees that somebody else didn't take an
> > access to the page/data to send it off somewhere else. Once you expose
> > the page to any other entity it should be written off or committed in
> > your case and you should move on to the next block.
>
> Yes, the expectation is that somebody else didn't take an access to the
> page/data to send it off somewhere else between page_frag_alloc_va()
> and page_frag_alloc_abort(), did you see expectation was broken in that
> patch? If yes, we should fix that by using page_frag_free_va() related
> API instead of using page_frag_alloc_abort().

The problem is when you expose it to XDP there are a number of
different paths it can take. As such you shouldn't be expecting XDP to
not do something like that. Basically you have to check the reference
count before you can rewind the page.

> >
> >
> >>
> >>>> +static struct page *__page_frag_cache_reload(struct page_frag_cache=
 *nc,
> >>>> +                                         gfp_t gfp_mask)
> >>>>  {
> >>>> +    struct page *page;
> >>>> +
> >>>>      if (likely(nc->encoded_va)) {
> >>>> -            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt=
_bias))
> >>>> +            page =3D __page_frag_cache_reuse(nc->encoded_va, nc->pa=
gecnt_bias);
> >>>> +            if (page)
> >>>>                      goto out;
> >>>>      }
> >>>>
> >>>> -    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> >>>> -            return false;
> >>>> +    page =3D __page_frag_cache_refill(nc, gfp_mask);
> >>>> +    if (unlikely(!page))
> >>>> +            return NULL;
> >>>>
> >>>>  out:
> >>>>      /* reset page count bias and remaining to start of new frag */
> >>>>      nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >>>>      nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);
> >>>> -    return true;
> >>>> +    return page;
> >>>> +}
> >>>> +
> >>>
> >>> None of the functions above need to be returning page.
> >>
> >> Are you still suggesting to always use virt_to_page() even when it is
> >> not really necessary? why not return the page here to avoid the
> >> virt_to_page()?
> >
> > Yes. The likelihood of you needing to pass this out as a page should
> > be low as most cases will just be you using the virtual address
> > anyway. You are essentially trading off branching for not having to
> > use virt_to_page. It is unnecessary optimization.
>
> As my understanding, I am not trading off branching for not having to
> use virt_to_page, the branching is already needed no matter we utilize
> it to avoid calling virt_to_page() or not, please be more specific about
> which branching is traded off for not having to use virt_to_page() here.

The virt_to_page overhead isn't that high. It would be better to just
use a consistent path rather than try to optimize for an unlikely
branch in your datapath.

> >
> >
> >>
> >>>> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> >>>> +                            unsigned int *offset, unsigned int frag=
sz,
> >>>> +                            gfp_t gfp)
> >>>> +{
> >>>> +    unsigned int remaining =3D nc->remaining;
> >>>> +    struct page *page;
> >>>> +
> >>>> +    VM_BUG_ON(!fragsz);
> >>>> +    if (likely(remaining >=3D fragsz)) {
> >>>> +            unsigned long encoded_va =3D nc->encoded_va;
> >>>> +
> >>>> +            *offset =3D page_frag_cache_page_size(encoded_va) -
> >>>> +                            remaining;
> >>>> +
> >>>> +            return virt_to_page((void *)encoded_va);
> >>>> +    }
> >>>> +
> >>>> +    if (unlikely(fragsz > PAGE_SIZE))
> >>>> +            return NULL;
> >>>> +
> >>>> +    page =3D __page_frag_cache_reload(nc, gfp);
> >>>> +    if (unlikely(!page))
> >>>> +            return NULL;
> >>>> +
> >>>> +    *offset =3D 0;
> >>>> +    nc->remaining =3D remaining - fragsz;
> >>>> +    nc->pagecnt_bias--;
> >>>> +
> >>>> +    return page;
> >>>>  }
> >>>> +EXPORT_SYMBOL(page_frag_alloc_pg);
> >>>
> >>> Again, this isn't returning a page. It is essentially returning a
> >>> bio_vec without calling it as such. You might as well pass the bio_ve=
c
> >>> pointer as an argument and just have it populate it directly.
> >>
> >> I really don't think your bio_vec suggestion make much sense  for now =
as
> >> the reason mentioned in below:
> >>
> >> "Through a quick look, there seems to be at least three structs which =
have
> >> similar values: struct bio_vec & struct skb_frag & struct page_frag.
> >>
> >> As your above agrument about using bio_vec, it seems it is ok to use a=
ny
> >> one of them as each one of them seems to have almost all the values we
> >> are using?
> >>
> >> Personally, my preference over them: 'struct page_frag' > 'struct skb_=
frag'
> >>> 'struct bio_vec', as the naming of 'struct page_frag' seems to best m=
atch
> >> the page_frag API, 'struct skb_frag' is the second preference because =
we
> >> mostly need to fill skb frag anyway, and 'struct bio_vec' is the last
> >> preference because it just happen to have almost all the values needed=
.
> >
> > That is why I said I would be okay with us passing page_frag in patch
> > 12 after looking closer at the code. The fact is it should make the
> > review of that patch set much easier if you essentially just pass the
> > page_frag back out of the call. Then it could be used in exactly the
> > same way it was before and should reduce the total number of lines of
> > code that need to be changed.
>
> So the your suggestion changed to something like below?
>
> int page_frag_alloc_pfrag(struct page_frag_cache *nc, struct page_frag *p=
frag);
>
> The API naming of 'page_frag_alloc_pfrag' seems a little odd to me, any b=
etter
> one in your mind?

Well at this point we are populating/getting/pulling a page frag from
the page frag cache. Maybe look for a word other than alloc such as
populate. Essentially what you are doing is populating the pfrag from
the frag cache, although I thought there was a size value you passed
for that isn't there?

