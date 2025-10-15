Return-Path: <netdev+bounces-229682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E44BDFB45
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE604E412F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB37338F21;
	Wed, 15 Oct 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjrJX9q5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3D2F3C31
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546361; cv=none; b=Mt/Fx6gvVjgKMLQxdUiC4+rnPZedU3oRnx13fT3x8SSWn4ayRZn2Wbr4nKEfxG7ojK4RuMBCVjaA/XYQhO9HH323pLbybk0zals5f7uR/avX9ukD1vHI6NRCgqcWILae7BmShHy7rDN7RFpv/XXUZ9rKUw1I1o5wRWmpwd4SCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546361; c=relaxed/simple;
	bh=XqB6na94/mJ0K/OgZi4TZF9h11JKDuGh6I2jheNoFF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9Gfcap5e1OrqlyvChBsGo0nXEO6xlh4PPLe0T/h9OOXEEpGggZ/f7/eZo6vsmhSJ0vGROdolf6al/wbnMfzJXz2S8OFyvDmtkmL1GPz854hKn3GaZtvKjFafKgafUP4WGVK4j31wqpYYXrxRhLQ11RYouQxPHDVwwOw48UKM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjrJX9q5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so235a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760546357; x=1761151157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzhM5CGB+RoDFW8y/0jUZz7oHPU/o/zMoGAuCJ5t4mg=;
        b=AjrJX9q56DrwDqINUhv9JXvl0DG4lhaE87MOvGDP3UBT4PWbbytMdKEVFxdHRMxzfX
         vwDiHPY/NS2QGIdAfl0jntd0bDacMId8coqk8o3jy4bS68VAGnEx9v//dNCAVtFL7YJG
         QJ4jOxGqnV84ZZa16IPB1n8mZNQwNDn9uilABWbrgxnUFKa6UOoOdvKh9bbW6dcNg+Q5
         FSOSx1X8ehgEDA12EsZ0DsHZQ7m7taIm9dxCkck1NHZFxIqhiq+CtPDoFKIEejTXvTvs
         tlkRRl1nBxys3Th9hWpiGKVauoMghPpOZybJ4Tl/sE1zlwUcgpU+VgXj095NEPS7T1gd
         mqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546357; x=1761151157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzhM5CGB+RoDFW8y/0jUZz7oHPU/o/zMoGAuCJ5t4mg=;
        b=Doohrlb1AFKbLE8Wxo3GAa+4d0V96NK+eHvhsbbgmhozel+MAb2nGkzuv08/Tqs5oH
         ycAkky/r2SUGVUyhgijrq247daJQVPv4u6uTO+wzPaAL4YEJ39cacShPVkLBtiaS1h6h
         01koAKQqAdG0phsSNEN9DA5A/yMtndXZrAN9gaJl1FkMlRfVCMlzuGDmOjIAa/r7uNyd
         3PlFGJHqUoYQOVzaB7dUEGHhTRvdyGDFHEaWm40eq8NSp+MECvEII0XK2e+T+xxPMZ9C
         f6tWL+fUOCyWgGooWElnFZmPMuqHiJ8I4lHabAPaQ0Y4lIve6vSEQDIsJdKQKHPoP3gp
         3Hjg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+u5QnTimi4XgK6t7+NXAfAQ8didSnfe3EMUSapZBMBjGYq5ABHNLLGctqRPN7CJsQHY2M08=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMwdr1FeZIYa2PX7G/g6Ij6RqgfDn8AaEaBuUvTLVAptHzHkY
	hOSGEHxqnLQhu9ptzN0uWB8VyxcckubgyBymJS3XdPrfyHICvkRnoU5awXlgE+A/sPa3juQyR6k
	DdpmHnOcCYsUkTfkJlpm31bIaNtLYLbBZW4fz1b5D
X-Gm-Gg: ASbGnctktUvbjU3fDVeuBaH5ncSdC0oRMzYskTD+VIo8LLv+WHimrCZyqxB9yjld6p6
	TnA5mbyMORSmif0i0a0R2BCIKk08eKOU6+mRTc6FRAklOrvXP9ZPohoE2zoT72u2SF2Idpg29KX
	jlUy0JkwQ5UE7OUhnDMtvAK1dcE/z1qEhQCTQleM+8hcPPAXRUwFyLo2fRraidcdhhC+/hKkKBc
	xb89WLnpUeBkN2oWi215KKLmIDJPVU3mi/FStCoXfeD5seBHNRXCOUMRYn4H8Q=
X-Google-Smtp-Source: AGHT+IFiVuLYivP034AwNyXAkpK0U9cc8NbdifZyjw09pfdEvHJuVDozucJsWtjEL9bmQH3yJFcdpbpk6wFGjPz12kI=
X-Received: by 2002:a05:6402:3246:20b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-63bebfa2921mr142406a12.2.1760546357234; Wed, 15 Oct 2025
 09:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
 <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
 <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com>
 <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com> <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 09:39:03 -0700
X-Gm-Features: AS18NWDCakq1h-mH7wphh8y1dVf2NhsytSCg4Cqtn1Pb9vJqQi_9SQu-IJteMNE
Message-ID: <CAJuCfpGf8Hj1QAgNtbRwsBwTOZTidt9sGLwX8PYhiHWYyE9Z1A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:35=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Oct 15, 2025 at 2:39=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>
> > > >
> > > > Tell them they are wrong.
> > >
> > > Well, we checked Qualcomm and MTK, and it seems both set these values
> > > relatively high. In other words, all the AOSP products we examined al=
so
> > > use high values for these settings. Nobody is using tcp_wmem[0]=3D409=
6.
> > >
> >
> > The (fine and safe) default should be PAGE_SIZE.
> >
> > Perhaps they are dealing with systems with PAGE_SIZE=3D65536, but then
> > the skb_page_frag_refill() would be a non issue there, because it would
> > only allocate order-0 pages.
>
> I am 100% sure that all of them handle PAGE_SIZE=3D4096. Google is workin=
g on
> 16KB page size for Android, but it is not ready yet(Please correct me
> if 16KB has been
> ready, Suren).

It is ready but it is new, so it will take some time before we see it
in production devices.

>
> >
> > > We=E2=80=99ll need some time to understand why these are configured t=
his way in
> > > AOSP hardware.
> > >
> > > >
> > > > >
> > > > > It might be worth exploring these settings further, but I can=E2=
=80=99t quite see
> > > > > their connection to high-order allocations, since high-order allo=
cations are
> > > > > kernel macros.
> > > > >
> > > > > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > > > > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE=
_MASK)
> > > > > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE=
_MAX_SIZE)
> > > > >
> > > > > Is there anything I=E2=80=99m missing?
> > > >
> > > > What is your question exactly ? You read these macros just fine. Wh=
at
> > > > is your point ?
> > >
> > > My question is whether these settings influence how often high-order
> > > allocations occur. In other words, would lowering these values make
> > > high-order allocations less frequent? If so, why?
> >
> > Because almost all of the buffers stored in TCP write queues are using
> > order-3 pages
> > on arches with 4K pages.
> >
> > I am a bit confused because you posted a patch changing skb_page_frag_r=
efill()
> > without realizing its first user is TCP.
> >
> > Look for sk_page_frag_refill() in tcp_sendmsg_locked()
>
> Sure. Let me review the code further. The problem was observed on the MM
> side, causing over-reclamation and phone heating, while the source of the
> allocations lies in network activity. I am not a network expert and may b=
e
> missing many network details, so I am raising this RFC to both lists to s=
ee
> if the network and MM folks can discuss together to find a solution.
>
> As you can see, the discussion has absolutely forked into two branches. :=
-)
>
> Thanks
> Barry

