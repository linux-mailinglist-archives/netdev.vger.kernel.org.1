Return-Path: <netdev+bounces-88780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC68A8878
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA81B23708
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660CD148FFA;
	Wed, 17 Apr 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwDOG6RJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECF14885E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370184; cv=none; b=rnFMKnjepzpzmlMTS2hDz9LLQccDiLee00cv+rRfNOMZd5Y5pApp6gWQNGwoFIbgxzdf0QR9QAY/50bJPu5yDDYCmIARlfoRibJwK0C22LB9+fVl3IP0ZyXZ0854Sagx/fSPuKYFevUXJqTGHY8jWSwYqURtV4cn8KV0U76Rc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370184; c=relaxed/simple;
	bh=SmaSs183cSYSKtrY51fdMoaJ7EJbT4EO+ix/XuOmA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoI/2SKkSj9KYgigQPbkOu+71aIhbcrk4unHmOfDnRrtcT9Bru7zWousBdOdGQYRUTv0Zh532nMERKSEzvTlD///G/R63jexzD0lwpzvv887KOP7G654laTpKhPnhN5h30IZipxtIXlTa5VUTgGzMKgN7DXLc9N/J/hAzrP0e6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwDOG6RJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-345522f7c32so2322273f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370180; x=1713974980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nC7WbprvVX0dY+Y8yPn/PsE3na7XnCdJQW0I06F+WA=;
        b=QwDOG6RJLe8au/GYFQY5kyyGYnISHFIRhtEWaJTUghOnycmu1pGcTuqQU+v6h7wOSx
         c21cTaMBx3goYWfxhQn8Gt2j0HDkaViGLKcub9CoVRPo3JDecaNcrU39xv0MyPzR8ZhL
         w8iQZuFaC3r+O7VDSIiYhKHITWgEl+UqQn/Qd6J8x8dY+a26FwX4W8X7RSMC3ccippeE
         4JnjguE19w++sN71tyJjB29pB+PsZIB0FcLq1g2XQnH3H43d6bdP9fA9p0JxCVeMqWgQ
         qMSarOqoPmZ9Kqe4ZUKTfnzuniDkcMcmMLMaeFqZqwOnqKHyfBjFdrzzEHbBuw+GDyrU
         +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370180; x=1713974980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nC7WbprvVX0dY+Y8yPn/PsE3na7XnCdJQW0I06F+WA=;
        b=gz0cxFDPIoe2ih1MNg7nthOYWyGNUXgTe/5PoekulPEUFOveq/2AzkS+/n5sdULAMe
         DXGv7kJKqeznCUS39kHXecRqqAuIOq9asGmW9gbO3N0TMHr1l/p87rZftedIprbBo5gH
         5dEIuIePz+8fPWJPwUafiMp7dgl7tlExW85CHwPdRpZWOOOYyMYnuYill19lAUgbGpxJ
         IrUsd9mSg+08VYjGvswUbw6xpXvyCfhD321V1geNsYccrvNjVAKmpvVhdU42//s0rfK6
         N1cwkm2Lisw1SJNgdjB0kBmDnDl2+k9C7D3CCma5D54TLM4j1Qi36ALsLPyuBvxYAxiT
         DJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXG1sBgdgmRNEsJIl1ynWjQH7k7wK0ugncDUocu24ORtg1aPg8QU1fJPIEsFS6Nlt/tFJTe6+L8zBWvcJewF6z4Soak8pwW
X-Gm-Message-State: AOJu0Yyoeyr8lw4N9xnLY/9CwsjuFfOPr2Y0iau6Jode2pYL094AikvR
	euLcO3wAPe9NoJGRTcnwYFdhJtkZRjTGfmLrsbJhp1vQzrlviDmuMAUAad1nkBfXkpnYIzMww5R
	8a1jT1oZNWAz02H2qEA9LlSD0gYQ=
X-Google-Smtp-Source: AGHT+IGLfKS/T28hbvBeiIOl3uhAALODoYo9725OVNHK5NNLqOO2iAjdxcQsl4E4sgnfA7kffNenvNg6ofMOTZALDqk=
X-Received: by 2002:adf:f542:0:b0:349:bd11:1bf1 with SMTP id
 j2-20020adff542000000b00349bd111bf1mr1861346wrp.46.1713370179688; Wed, 17 Apr
 2024 09:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com> <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org> <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com> <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
 <20240417081435.GD6832@unreal>
In-Reply-To: <20240417081435.GD6832@unreal>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 17 Apr 2024 09:09:02 -0700
Message-ID: <CAKgT0UcssuWvqYoVP7rkcCVnFA3zHkDaqe6Tp7=izFx0BH=2Zw@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Leon Romanovsky <leon@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:14=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Apr 16, 2024 at 07:46:06AM -0700, Alexander Duyck wrote:
> > On Tue, Apr 16, 2024 at 7:05=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> > >
> > > From: Alexander Duyck <alexander.duyck@gmail.com>
> > > Date: Mon, 15 Apr 2024 11:03:13 -0700
> > >
> > > > On Mon, Apr 15, 2024 at 10:11=E2=80=AFAM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> > > >>
> > > >> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
> > > >>>>> The advantage of being a purpose built driver is that we aren't
> > > >>>>> running on any architectures where the PAGE_SIZE > 4K. If it ca=
me to
> > > >>>>
> > > >>>> I am not sure if 'being a purpose built driver' argument is stro=
ng enough
> > > >>>> here, at least the Kconfig does not seems to be suggesting it is=
 a purpose
> > > >>>> built driver, perhaps add a 'depend on' to suggest that?
> > > >>>
> > > >>> I'm not sure if you have been following the other threads. One of=
 the
> > > >>> general thoughts of pushback against this driver was that Meta is
> > > >>> currently the only company that will have possession of this NIC.=
 As
> > > >>> such Meta will be deciding what systems it goes into and as a res=
ult
> > > >>> of that we aren't likely to be running it on systems with 64K pag=
es.
> > > >>
> > > >> Didn't take long for this argument to float to the surface..
> > > >
> > > > This wasn't my full argument. You truncated the part where I
> > > > specifically called out that it is hard to justify us pushing a
> > > > proprietary API that is only used by our driver.
> > > >
> > > >> We tried to write some rules with Paolo but haven't published them=
, yet.
> > > >> Here is one that may be relevant:
> > > >>
> > > >>   3. External contributions
> > > >>   -------------------------
> > > >>
> > > >>   Owners of drivers for private devices must not exhibit a stronge=
r
> > > >>   sense of ownership or push back on accepting code changes from
> > > >>   members of the community. 3rd party contributions should be eval=
uated
> > > >>   and eventually accepted, or challenged only on technical argumen=
ts
> > > >>   based on the code itself. In particular, the argument that the o=
wner
> > > >>   is the only user and therefore knows best should not be used.
> > > >>
> > > >> Not exactly a contribution, but we predicted the "we know best"
> > > >> tone of the argument :(
> > > >
> > > > The "we know best" is more of an "I know best" as someone who has
> > > > worked with page pool and the page fragment API since well before i=
t
> > > > existed. My push back is based on the fact that we don't want to
> > >
> > > I still strongly believe Jesper-style arguments like "I've been worki=
ng
> > > with this for aeons", "I invented the Internet", "I was born 3 decade=
s
> > > before this API was introduced" are not valid arguments.
> >
> > Sorry that is a bit of my frustration with Yunsheng coming through. He
> > has another patch set that mostly just moves my code and made himself
> > the maintainer. Admittedly I am a bit annoyed with that. Especially
> > since the main drive seems to be to force everything to use that one
> > approach and then optimize for his use case for vhost net over all
> > others most likely at the expense of everything else.
> >
> > It seems like it is the very thing we were complaining about in patch
> > 0 with other drivers getting penalized at the cost of optimizing for
> > one specific driver.
> >
> > > > allocate fragments, we want to allocate pages and fragment them
> > > > ourselves after the fact. As such it doesn't make much sense to add=
 an
> > > > API that will have us trying to use the page fragment API which hol=
ds
> > > > onto the page when the expectation is that we will take the whole
> > > > thing and just fragment it ourselves.
> > >
> > > [...]
> > >
> > > Re "this HW works only on x86, why bother" -- I still believe there
> > > shouldn't be any hardcodes in any driver based on the fact that the H=
W
> > > is deployed only on particular systems. Page sizes, Endianness,
> > > 32/64-bit... It's not difficult to make a driver look like it's
> > > universal and could work anywhere, really.
> >
> > It isn't that this only works on x86. It is that we can only test it
> > on x86. The biggest issue right now is that I wouldn't have any
> > systems w/ 64K pages that I could test on.
>
> Didn't you write that you will provide QEMU emulation for this device?
>
> Thanks

Yes. I had already mentioned the possibility of testing it this way. I
am just not sure it adds much value to test the already limited
hardware and a limited platform setup in emulation. The issue is that
it will be hard to generate any stress in the QEMU environment since
it maxes out at only about 1 or 2 Gbps as the overhead for providing
TCAMs is software is not insignificant. To top it off, emulating a
non-native architecture will slow things down further. It would be
like asking someone to test a 100G nic on a system that only has PCIe
gen1.

I will probably just go the suggested route of enabling compile
testing on all platforms, and only support loading it on X86_64. As
time permits I can probably assign somebody the job of exploring the
page size larger than 4K issue, however it will be a matter of
weighing the trade-off for adding technical debt for a use case that
may not be applicable.

