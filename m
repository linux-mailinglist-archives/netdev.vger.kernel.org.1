Return-Path: <netdev+bounces-223759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2FB7D8BB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73FD52739A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF12E03EF;
	Tue, 16 Sep 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qj0CYl71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D912E2DF2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061283; cv=none; b=hXNQpuuKifToqtJ2JFiy6ia2k1yCfXziBnKcA+4b3gYZbVL4avyOLgEw6+B2K2JGIfz2+203PLc9jwD6TsL/Teh9F5m2dr0wgvZWPlJAhELP4xN/e5MzIQi2pkbZnX/FdA4gF0Bd6TpvCLEQJCsKA/VOMYK5BqLvnwurubKlzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061283; c=relaxed/simple;
	bh=+iD5+4+0qV0RZp5lNqZac3Yap4texCIIDj49z8ZUf5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq6rs+Aix04wW4/+XScOFFuA1djbIvkR7LYx4U6jWPx6MDJACtOz5szIOzSJMxCa98F1jnmwEoOfZ7LqBiZGeeKxFaGWQgVcP3SlJQx/frx0lkSpzB64VdnNwplrDEqqVjQjqq6eb5bCc98hd7Nn9XeRtml/pMC0bldJrflYodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qj0CYl71; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-560885b40e2so3430e87.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758061280; x=1758666080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVdLglpxhRso4AWsi+Qr5Xu9puyLriieQDhQNzvchd4=;
        b=Qj0CYl71jGdasQHS+GlwO5f5zmsVK3M5GSdmhUqZLvLz1nXUWvhGagf/VfEi+rj4by
         lKEYBeC4c1ypnhW3P3tLHdrpc1JL+RfFTDp0zRB76BJ5L0kAAM1Qf46AMUTMAmkpPPfG
         18nhZf970+okuqxuIheVHtdjF5acmYiNkWmoiD6uHqS5ViDmRVgwID8fyTaK/qv0x7yX
         8jGW+eE5q1ye9BVudOK9KRV5SzmdXfcuTZb9m6nJIUX9HcTJxG7QFmWnFFJLEmeYzHVe
         TKwqPQaBI3Qr49lwzD4v3+UBFmrrVM/ojkDbTGyHvHd99kSDLtxHTyvUP1gFwlHu74sG
         MBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061280; x=1758666080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVdLglpxhRso4AWsi+Qr5Xu9puyLriieQDhQNzvchd4=;
        b=uHvFPX/ikYZqUPEEzeDptlglGLjquv/PbtTpdaVqY/ZJACwy+x2TmHMUjxbgQUIuUP
         ucC1G/Zaxc8o+kC/Gi7EuqBgHWEGQMRCQ5AOb/2tE7gVnInMjMwdj5bIwDEvp00MnZNi
         K+m++1eDQ+dea/VA0fomiwbiTJqy46aDXWF2ws05hg3u8U47Avtpl5qHUH71Vxdi1dvq
         qT4ELYFCQTPevst3QNJI3jfy3BHwssZT1GtZOSxoBFTPpTHTigjebyCMbb+8EiCezXio
         wRFVMEerB/GT4uvVcsMxF2bbJwOXqwt7RFEQmIhcy5GHcvzI7e6AgT5qtkIe5qo/mUs1
         biTg==
X-Forwarded-Encrypted: i=1; AJvYcCUz16AKWjiFsxnqcG2t305Jzw+vdc3JFimsGYhUVg0AtfuwRsWMzYw8hoiq37Vz04H+0S1xzRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmR/S4Nl1ebIPr62/U7GTY7m317xeiy5BB/qWnkuoBRzD9z9n
	4LmVH5oo9Bt2+P/f4eAYI30HTE3e0knApXoZJzqmzQrKqhO+H+uzu5dQsGVovXQJbIfFhW9qYwM
	myL8LtDuQ/xRBTgmyirVVL8HPV53xpl3Zte2h8ult
X-Gm-Gg: ASbGncsbcHyYtghpDOv/+R54o5PfuomhyA1+0N1ssM24N30eanSsAzPnH3pgxkPDLoc
	WYUwAVIaVRTmEk0/c2ZBXsqFjUDGy/QyTL77Xxk0hnYT+/3VAoON1vpNJ9pRGQmPDX2ZObcjNSh
	fQu2yuXZeDvKmOIZpRxT+AmlB8YOozT0s7mVTxt6DsSKTGA1h2jpDb5t1WIhITkwXaNWRsMeWIe
	MpjbLAt/iBnRnvcbgT+/dOj+LQIA5deLdAMjHPRmRmkbA8zuHrDniQ=
X-Google-Smtp-Source: AGHT+IETuMnvpwfVigTN61m6CycwMEcPdpn0JfGM8MkTwo9jHq/f412owy6e2+xnogamcc5EfMS02Pn2xCx3TgBeTYc=
X-Received: by 2002:a05:6512:3ba6:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-57778c48d17mr57515e87.3.1758061279366; Tue, 16 Sep 2025
 15:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk>
 <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de> <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
 <87y0qerbld.fsf@toke.dk>
In-Reply-To: <87y0qerbld.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 16 Sep 2025 15:21:07 -0700
X-Gm-Features: AS18NWB-7AWKLsrqIUr07vEaC8LUK6IRwvPrOQdWgLCThpwa-rYMqW2OhB3IAn8
Message-ID: <CAHS8izOY3aSe96aUQBV76ZRpqj5mXwkPenNvmN6yN0cJmceLUA@mail.gmail.com>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate page_pool_page_is_pp()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org, 
	Linux parisc List <linux-parisc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de> wr=
ote:
> >>
> >> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> > Helge Deller <deller@kernel.org> writes:
> >> >
> >> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap t=
hem when
> >> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc0=
00007c on
> >> >> 32-bit platforms.
> >> >>
> >> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify =
page pool
> >> >> pages, but the remaining bits are not sufficient to unambiguously i=
dentify
> >> >> such pages any longer.
> >> >
> >> > Why not? What values end up in pp_magic that are mistaken for the
> >> > pp_signature?
> >>
> >> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
> >> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA is z=
ero on 32-bit platforms).
> >> That means, that before page_pool_page_is_pp() could clearly identify =
such pages,
> >> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
> >> So, basically only the 0x40 value indicated a PP page.
> >>
> >> Now with the mask a whole bunch of pointers suddenly qualify as being =
a pp page,
> >> just showing a few examples:
> >> 0x01111040
> >> 0x082330C0
> >> 0x03264040
> >> 0x0ad686c0 ....
> >>
> >> For me it crashes immediately at bootup when memblocked pages are hand=
ed
> >> over to become normal pages.
> >>
> >
> > I tried to take a look to double check here and AFAICT Helge is correct=
.
> >
> > Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basically
> > 0x40 is the only pointer that may be mistaken as a valid pp_magic.
> > AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
> > significant bits), doubles the number of pointers that can be mistaken
> > for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
> > mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values can
> > be mistaken as pp_magic?
> >
> > I don't know that there is any bits we can take away from
> > PP_MAGIC_MASK I think? As each bit doubles the probablity :(
> >
> > I would usually say we can check the 3 least significant bits to tell
> > if pp_magic is a pointer or not, but pp_magic is unioned with
> > page->lru I believe which will use those bits.
>
> So if the pointers stored in the same field can be any arbitrary value,
> you are quite right, there is no safe value. The critical assumption in
> the bit stuffing scheme is that the pointers stored in the field will
> always be above PAGE_OFFSET, and that PAGE_OFFSET has one (or both) of
> the two top-most bits set (that is what the VMSPLIT reference in the
> comment above the PP_DMA_INDEX_SHIFT definition is alluding to).
>

I see... but where does the 'PAGE_OFFSET has one (or both) of the two
top-most bits set)' assumption come from? Is it from this code?

/*
 * PAGE_OFFSET -- the first address of the first page of memory.
 * When not using MMU this corresponds to the first free page in
 * physical memory (aligned on a page boundary).
 */
#ifdef CONFIG_MMU
#ifdef CONFIG_64BIT
....
#else
#define PAGE_OFFSET _AC(0xc0000000, UL)
#endif /* CONFIG_64BIT */
#else
#define PAGE_OFFSET ((unsigned long)phys_ram_base)
#endif /* CONFIG_MMU */

It looks like with !CONFIG_MMU we use phys_ram_base and I'm unable to
confirm that all the values of this have the first 2 bits set. I
wonder if his setup is !CONFIG_MMU indeed.

It also looks like pp_magic is also union'd with __folio_index in
struct page, and it looks like the data there is sometimes used as a
pointer and sometimes not.

--=20
Thanks,
Mina

