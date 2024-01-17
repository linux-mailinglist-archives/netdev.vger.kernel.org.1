Return-Path: <netdev+bounces-64041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2180830CC2
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 19:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFE9B20E60
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03322F0D;
	Wed, 17 Jan 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11awUl92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BB23748
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516458; cv=none; b=KljS+WRJKjxzjAVEBKxScAdZmo/p+J5Weh90rxeKXNp8V6P5nsLzZzCAyj95smq5tlUGzvQj10sBB7CPIj01B4JMfI3fHfE/lFAzmW226X0DTExTLdhPQHPzgqduMQ5v1ZNF4qSkH2GpgUSoGR0jW1419lIsLVBIcWKwhlDo4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516458; c=relaxed/simple;
	bh=c8I7hLlPxVU2IM8/g6DP0m0OB/IX+cD2ENTTl8RyhTk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MU2FcuMtH6QpI6rxAls6sX0EaNWT5T17VPWKczKI/39OXbtaMpFCZvTTiLVDdrzWJGeTyWJ17pTb1m8tKQl3hU7zxisAoWwxdS2FlXlYvryifxyrtGItCjEuRgs27PSo75hn31eRg/qDpTBaiwBhdYQTiG4glGiHBZsDFTRPC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11awUl92; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55969c01168so5096803a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 10:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705516455; x=1706121255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34+4xtu/2qC20G1bx3utIMpaFqGA2iDoy/irY93Em2U=;
        b=11awUl92BzFSIsSaqqw06UOkr+1n+IGmvuKENQQeUtocKz+2Tbd6ZKhJ0SVyTq3e7D
         kIHFlng2B40xxkNFbKl3BTaimX2dcml/nPMI/4XP7AY0WfUiTU7ZsR8LqVFKrVMop9rl
         h9arVRkdMrmsrXlMkGqYIgDehefArJ51Sl6oGOD2c/bgLVjyTH5Q89l8jMvb91G+3Uuq
         J9AdHT5/CvSHkpfMxGaGtt6Lk7G6t/j1zAKmjIe6phV1uAX9d55gC8L+U5O62TZENYBn
         lDn028w0XaPU/l2kHbsDeQ/rFrnTjXo4IFmkEbLpmD0tdoeVzxSKeamv9ut0tkQpzM+q
         tl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516455; x=1706121255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34+4xtu/2qC20G1bx3utIMpaFqGA2iDoy/irY93Em2U=;
        b=ghyhJoKJB0gblbLPpTnDk9tei5rA8vBfHr9dOU6UqcYd9mrPolroCkS2d+PS327qxM
         ZzZOqeNJOITySpvfSB1z4swY7/CIl9ujc+Uojmo1hqbkBtwhuBTI/3Od9MeNVvwJTafl
         D4Q7UV0cQ9NCcnUIfrmLZZxzgNFTauYu/InB8KGwNrQLCY/W9sDIuUihDOKUvFBvWjA0
         ycFR2ImHwcw7TGieNp+YDZ4uyugi9r61kRU82M0X3/VLxEjjXy1wBGXADNsVReZHlxvf
         qHYGpFVaiTJjDvEAti90Qwy9PjDlCDfdrC1W7cyj4vBjgwsZP3Lf2ODzbgDy7eDVes2X
         ztrA==
X-Gm-Message-State: AOJu0YwcVgs+3JHhZP9BVoenN3lO8rrIvVj/YjpZmUQbPJLW/xd4uaD6
	jVKxjy6Hoi7Twif6AEfNYLWiGrCPcnOScM4dQm49e8BWs+rS
X-Google-Smtp-Source: AGHT+IGKoOCccm7DaHUHwBB88Rt5iXeUxF1kAsQunFZU0vnFSUR+Edsx5gq8XaAWs3mn03O70WJLlErUMbi3uenj71I=
X-Received: by 2002:a17:906:e0e:b0:a2e:ac2a:9064 with SMTP id
 l14-20020a1709060e0e00b00a2eac2a9064mr1150919eji.36.1705516454884; Wed, 17
 Jan 2024 10:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com> <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com> <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com> <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com> <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
 <20240116121611.GY734935@nvidia.com> <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
In-Reply-To: <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Jan 2024 10:34:03 -0800
Message-ID: <CAHS8izO1-+MczzFw_R80uv=aK5A9bUNcKroY=H9Euk+ZPnnGPw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:00=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Tue, Jan 16, 2024 at 4:16=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
> > > On 2024/1/16 8:01, Jason Gunthorpe wrote:
> > > > On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> > > >>>> You did not answer my question that I asked here, and ignoring t=
his
> > > >>>> question is preventing us from making any forward progress on th=
is
> > > >>>> discussion. What do you expect or want skb_frag_page() to do whe=
n
> > > >>>> there is no page in the frag?
> > > >>>
> > > >>> I would expect it to do nothing.
> > > >>
> > > >> I don't understand. skb_frag_page() with an empty implementation j=
ust
> > > >> results in a compiler error as the function needs to return a page
> > > >> pointer. Do you actually expect skb_frag_page() to unconditionally
> > > >> cast frag->netmem to a page pointer? That was explained as
> > > >> unacceptable over and over again by Jason and Christian as it risk=
s
> > > >> casting devmem to page; completely unacceptable and will get nacke=
d.
> > > >> Do you have a suggestion of what skb_frag_page() should do that wi=
ll
> > > >> not get nacked by mm?
> > > >
> > > > WARN_ON and return NULL seems reasonable?
> > >
>
> That's more or less what I'm thinking.
>
> > > While I am agreed that it may be a nightmare to debug the case of pas=
sing
> > > a false page into the mm system, but I am not sure what's the point o=
f
> > > returning NULL to caller if the caller is not expecting or handling
> > > the
> >
> > You have to return something and NULL will largely reliably crash the
> > thread. The WARN_ON explains in detail why your thread just crashed.
> >
>
> Agreed.
>
> > > NULL returning[for example, most of mm API called by the networking d=
oes not
> > > seems to handling NULL as input page], isn't the NULL returning will =
make
> > > the kernel panic anyway? Doesn't it make more sense to just add a BUG=
_ON()
> > > depending on some configuration like CONFIG_DEBUG_NET or CONFIG_DEVME=
M?
> > > As returning NULL seems to be causing a confusion for the caller of
> > > skb_frag_page() as whether to or how to handle the NULL returning cas=
e.
> >
> > Possibly, though Linus doesn't like BUG_ON on principle..
> >
> > I think the bigger challenge is convincing people that this devmem
> > stuff doesn't just open a bunch of holes in the kernel where userspace
> > can crash it.
> >
>
> It does not, and as of right now there are no pending concerns from
> any netdev maintainers regarding mishandled devmem checks at least.
> This is because the devmem series comes with a full audit of
> skb_frag_page() callers [1] and all areas in the net stack attempting
> to access the skb [2].
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.3=
516870-10-almasrymina@google.com/
> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.3=
516870-11-almasrymina@google.com/
>
> > The fact you all are debating what to do with skb_frag_page() suggests
> > to me there isn't confidence...
> >
>
> The debate raging on is related to the performance of skb_frag_page(),
> not correctness (and even then, I don't think it's related to
> perf...). Yunsheng would like us to optimize skb_frag_page() using an
> unconditional cast from netmem to page. This in Yunsheng's mind is a
> performance optimization as we don't need to add an if statement
> checking if the netmem is a page. I'm resistant to implement that
> change so far because:
>
> (a) unconditionally casting from netmem to page negates the compiler
> type safety that you and Christian are laying out as a requirement for
> the devmem stuff.
> (b) With likely/unlikely or static branches the check to make sure
> netmem is page is a no-op for existing use cases anyway, so AFAIU,
> there is no perf gain from optimizing it out anyway.
>

Another thought, if anyone else is concerned about the devmem checks
performance,  potentially we could introduce CONFIG_NET_DEVMEM which
when disabled prevents the user from using devmem at all (disables the
netlink API).

When that is disabled, skb_frag_page(), netmem_to_page() & friends can
assume netmem is always a page and do a straight cast between netmem &
page. When it's enabled, it will check that netmem =3D=3D page before
doing a cast, and return NULL if it is not a page.

I think this is technically viable and I think preserves the compiler
type safety requirements set by mm folks. From my POV though, bloating
the kernel with a a new CONFIG just to optimize out no-op checks seems
unnecessary, but if there is agreement that the checks are a concern,
adding CONFIG_NET_DEVMEM should address it while being acceptable to
mm maintainers.

> But none of this is related to correctness. Code calling
> skb_frag_page() will fail or crash if it's not handled correctly
> regardless of the implementation details of skb_frag_page(). In the
> devmem series we add support to handle it correctly via [1] & [2].
>
> --
> Thanks,
> Mina



--=20
Thanks,
Mina

