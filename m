Return-Path: <netdev+bounces-156779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D490A07CFF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42BC3A76F9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432A220699;
	Thu,  9 Jan 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQNHAnTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227B21C193
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438997; cv=none; b=Q4PmV+7hNYnn9D9AONBcglnXrCDRGCpm7g4rBfpnC577bgXb218tmCs2ZjYVQ+XPnPhhgrNZlDz+GpCfTF/98eowPRkQ/YO/EIKa3BMTlZGRgqd5MOSILhAoMKwmWn3avjRdVw00YCSM15S9NTjNqgHOEoeqhcKM0z9/QadAw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438997; c=relaxed/simple;
	bh=cL0qWFt4CzBLO6RKFa6X4lfYiiCo26zXYOZQzPjnXqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5c/FWpz6G+dIhovG0EDhYB1Apsu9DAkQSSRMayep0rEXkURR1I27nJ/9U5b7zjn3wkAGo9ctBGBJtPHKTkqFk7q3KUdc11jdpYHqvfjYAS6FCrcupgynTuo4OaeyB/o4pCFIPyZ8YBHgqi7/lACr0UG6HnRihVPwanpLPQ6gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQNHAnTT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so245ab.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736438995; x=1737043795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJyed5D+vSc/Bvcwy3EuHfoP46E5ldRsN6t8SxTfZxQ=;
        b=nQNHAnTT0itRsXQ7jHSEc2PXuIKnnzYajlFOE3xszOFcQdJoe1LzzVuSCIO13bEjBr
         O7gCoKItcmljLcnjk8BzH9CkIkDQEpsWK5s7g0eY3e/pA9MVcex6O0mSE3sDskgl2tzp
         GX/k9aH+NxuZOvXYKFR4+UcmSoq7oJLkvfvbiswhJI29bOSslQxkl3zlZlx8xK5R1Cak
         spuTycqodEhOQmfTTxVrPI/JqrXCfxqR+ievnuytmutTZg0UucZDwCyfXSUMR9/RQkNF
         71ofEnkelJylIIyS9jXQBbANv9hOLPaXC+UOlYmFvcRANI8Jc0JugejO+TkwkjDXtQPy
         BU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736438995; x=1737043795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJyed5D+vSc/Bvcwy3EuHfoP46E5ldRsN6t8SxTfZxQ=;
        b=TWpq78Uqgkt1Q4QWK6yiACEeJocWeFrtNi2E/vr+50cm+qbbbfnxh0gBGVSvUQuIDV
         fftmb29OhvD7r7W1NzaEIf2LRTrQIvLRzxvFsjDzOHjVvg0ipRV1KocOa/ptLSaQeW9z
         RAv6nX9LEnNC4gRtbQmHDxWzWXdSwcgMZAuRxv+JdUD8mu9qWU59UESUfrzCYLEto3Fz
         A2x+V+0dpICkVqTyq4ITwF4zS7xwaTvJqasldaOk0yIlNceulSg3mhGxkKNC1UettUQo
         xUv7f0dO+05Fa9cUIMfMnj/0hpgDwbxXHGJ0KxeZfPqJ83tcHwpS5GP2CDxRKR7qiFf6
         StTA==
X-Forwarded-Encrypted: i=1; AJvYcCUSVRf//vSnnAOwrA9cskTBXW5aylzf6JLo7OMWg/McOAoslLRDie/JNSyKfNr6yXxOpkNSLTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j/SYChD/xJ8Ms234ViFfOttJaP3r7H7b4XIvGdNQwnQdokGc
	Ic+lgEaZAnGQsmGb3oAcCWgGzJJa2nn6nrwsI/9aDLdOE1Kmx1xjRmbSW7GNF0NhrEy8H9K8Sv6
	KfRDgtawd860NFTC0W50cucmtJigYLAss0N0m
X-Gm-Gg: ASbGncs4OlkFZJ/yWYNOz4p+z6Gl/wOsoPdktE/cbU9JrXqTv1lYU34vuFQ9kRdFGmk
	SaWiz1vcjs0idVqLbN6vitpXtpSUKwwK4+Jjxsw==
X-Google-Smtp-Source: AGHT+IEPzrrkfO9z/jARG8fHOFA9EXi7CZzolUeClZc1DxMbawMb3YzSNlR8qPV2Y/LFep56Ge6kHTxzkr8810LKepw=
X-Received: by 2002:a92:d0c4:0:b0:3ce:51bd:3b05 with SMTP id
 e9e14a558f8ab-3ce53f09bb3mr110565ab.2.1736438994207; Thu, 09 Jan 2025
 08:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109072245.2928832-1-yuyanghuang@google.com>
 <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org> <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
In-Reply-To: <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 10 Jan 2025 01:09:16 +0900
X-Gm-Features: AbW1kvbL_H5w1zhFPfls19XDRhioNQHuITN3goEDzWcy4EB8EMK_5ayyxrlXr9w
Message-ID: <CADXeF1H6BHZU1OaQW6LKsJh2m7svWS8qfR+SCGNb8A3aoBGk8A@mail.gmail.com>
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast addresses
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>my comment meant that this `type` should be removed and the wrappers
>below just call the intended function. No need for the extra layers.

This patch was trying to follow the similar pattern in addrconf.c. We
have a similar addr_type_t based dispatching mechanism to handle the
dumping of ANYCAST, MULTICAST, and UNICAST addresses.

inet6_dump_ifaddr()/inet6_dump_ifmcaddr()/inet6_dump_ifacaddr() ->
inet6_dump_addr() -> in6_dump_addrs()

The dispatching switch statement resides within in6_dump_addrs(), and
those dump functions share the common code path in inet6_dump_addr().

Thanks,
Yuyang


On Fri, Jan 10, 2025 at 12:52=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> >my comment meant that this `type` should be removed and the wrappers
> >below just call the intended function. No need for the extra layers.
>
> Sorry, I still do not fully understand the suggestions.
>
> In the current inet_dump_ifaddr() function, there are two places where
> in_dev_dump_addr() is called.
>
> For example, we have the following code snippet.
>
> >if (!in_dev)
> >goto done;
> >err =3D in_dev_dump_addr(in_dev, skb, cb, &ctx->ip_idx,
> >       &fillargs);
> >goto done;
> >}
>
> Do you suggest we do the following way?
>
> > If (type =3D=3D UNICAST_ADDR)
> >    err =3D in_dev_dump_ifaddr(in_dev, skb, cb, &ctx->ip_idx,
> >                                             &fillargs);
> > else if (type =3D=3D MULTICAST_ADDR)
> >    in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
> >                                         &fillargs);
>
> The current functional call stack is as follows:
>
> inet_dump_ifaddr()/inet_dump_ifmcaddr() -> inet_dump_addr() ->
> in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr().
>
> The ifaddr and ifmcaddr dump code paths share common logic inside
> inet_dump_addr(). If we don't do the dispatching in
> in_dev_dump_addr(), we have to do the dispatching in inet_dump_addr()
> instead, and the dispatching logic will be duplicated twice. I don't
> think this will simplify the code.
>
> Or do you suggest I should pass a function pointer for
> in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr() into inet_dump_addr()?
>
> Thanks,
>
> Yuyang
>
> On Fri, Jan 10, 2025 at 12:33=E2=80=AFAM David Ahern <dsahern@kernel.org>=
 wrote:
> >
> > On 1/9/25 12:22 AM, Yuyang Huang wrote:
> > > @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *ne=
t)
> > >       return res;
> > >  }
> > >
> > > -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_call=
back *cb)
> > > +static int inet_dump_addr(struct sk_buff *skb, struct netlink_callba=
ck *cb,
> > > +                       enum addr_type_t type)
> > >  {
> > >       const struct nlmsghdr *nlh =3D cb->nlh;
> > >       struct inet_fill_args fillargs =3D {
> > >               .portid =3D NETLINK_CB(cb->skb).portid,
> > >               .seq =3D nlh->nlmsg_seq,
> > > -             .event =3D RTM_NEWADDR,
> > >               .flags =3D NLM_F_MULTI,
> > >               .netnsid =3D -1,
> > > +             .type =3D type,
> >
> > my comment meant that this `type` should be removed and the wrappers
> > below just call the intended function. No need for the extra layers.
> >
> > >       };
> > >       struct net *net =3D sock_net(skb->sk);
> > >       struct net *tgt_net =3D net;
> > > @@ -1949,6 +1996,20 @@ static int inet_dump_ifaddr(struct sk_buff *sk=
b, struct netlink_callback *cb)
> > >       return err;
> > >  }
> > >
> > > +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_call=
back *cb)
> > > +{
> > > +     enum addr_type_t type =3D UNICAST_ADDR;
> > > +
> > > +     return inet_dump_addr(skb, cb, type);
> > > +}
> > > +
> > > +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_ca=
llback *cb)
> > > +{
> > > +     enum addr_type_t type =3D MULTICAST_ADDR;
> > > +
> > > +     return inet_dump_addr(skb, cb, type);
> > > +}
> > > +
> > >  static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsg=
hdr *nlh,
> > >                     u32 portid)
> > >  {
> >

