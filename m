Return-Path: <netdev+bounces-156782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8447A07D07
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0EF18818A5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA22206A0;
	Thu,  9 Jan 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tflFybu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546421E08B
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439089; cv=none; b=emTL4YMbZbDRB7mYT6LS5BDh06YiJAAeCH2EZvpjtl2skiV/ObdxzGx/AYwALE2pgG3+HyevEAiPdsCVHee0PDUsUiwSmvUFt3djRg1nvb9n9TM2PxOCpKoHGab0zEOj/dPg/HuLDKXroY52d704aBK97jmlteVzHYz7pca0Buc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439089; c=relaxed/simple;
	bh=Ohkl8dMbFnzfzxQf6FXRUBkU23KNplgI7ZYX1GyhBso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koceOPXag57zghtk8CGqJ29jObeh0HDUx0i0GN3w2S4/Ni/xRmRXUnq81hVLDZM5HKKa8YW1zZr2zvTlw6JSEP19VpIbqV/vb/SJ+xQTPg0bB7CPQnfwJDiutKGzxflahq8Rc/IfIjOOx6aVt13xB/M0vGvFkQXlXtnYogt7T8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tflFybu+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so305ab.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736439085; x=1737043885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R1Ynk85ccZD/q4EBeIocxlaIGsff7uywhrj8nrytzE=;
        b=tflFybu+5A1GyXr6PWQ2xAqrYHg1eDwlQsFb+AlBg3p6DzoKinwkud7kKoYq36Y9Hv
         zVKQyLPdeim3uP4wSkVFFuEH7laK0ig36ErwK70XyIA1QCnj/emlIcjvC0zrydRDVF0D
         saCFalMVO+6V0lBN63LxfVDce/l8wIN5b76tHHjoEYfsR1EKFBEnlcbmZcbTQsGjeVMr
         ZZl3l93irr4h1oYG1t1L1ElgxzA+OAkUUxoaaWyJUmMXKaiBBmZnw4/9slziajP5OfA5
         qBWtUT+RdSY8CZEDn9OGO4EH95bRzhugprsiOy0LfuHswG/5EOiZqYLpqC1HFwFE0x5T
         Le3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736439085; x=1737043885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R1Ynk85ccZD/q4EBeIocxlaIGsff7uywhrj8nrytzE=;
        b=dXfbE3ZmPfasdbKjGAD6bsadir71Lp05V8bvGPJg6vW3fLD4YZDozmOsWHXJ8v0xo7
         fRV1IopILCJP+M48O4zlGHnocJiBVArOKS6SO9Y38FmqtX5ASnyON7zG7ddgA83EaDJV
         NY7GeKw0g4gz+NeFI+esk+Y7vu4VqBLdJH0SGfo8X4KRYq3/QSYh6L+gGvcsozqE8Mt1
         zNSgadwj87z/+OKQlD6R9toyGXxretXQCqPW7S9PLIvWJsqALquNEhsdkqb7zPRhixP/
         1dEtqO3zBTn5//CYRyJA3wK6uAPWZ8ZyPqB1mL4vv2jfaAo/55BOlrpoRRzEZoe3Fozm
         ZdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUi6rnLGQbaElCPKqJs5bEp0M68KTPwZnqtNbalQlm2+wUZzjgmkZMG8W7i7qMX1cuFrOjRdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOHfb6BsotIzNvyPSoU+XEe0D19+IQ8qs0dnRD+oczp0XsD5A
	ZiJSALHWbf6Cv92c9BLxx6RRHrUaXPwoihJhZFrHC0VkPe2ULKrLmlF7tJQqdd21C8/KozFMXrI
	pIx5lYP1uNlc7ObRUjTOjQ+B2Rgqq1KxGabBx
X-Gm-Gg: ASbGncvNSLcyqPw1Ibqp2HThN0HciTFbSGfU7Ai1vuWZl/ZscykOnP1hY3MKkoq+dtk
	q5jCPsX7vDmp9vOVrl78p7gpvvI1F/I/5v2v7Mg==
X-Google-Smtp-Source: AGHT+IH6BBoYfkmDsauTkNAX/sdYecDG6kGcbhvfb2h/LE9nZb0uJQ4Y/dlm6Oz0N5oChAG3xUnQzAFchB5TZdeWLS4=
X-Received: by 2002:a92:d0c4:0:b0:3ce:51bd:3b05 with SMTP id
 e9e14a558f8ab-3ce53f09bb3mr113225ab.2.1736439084999; Thu, 09 Jan 2025
 08:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109072245.2928832-1-yuyanghuang@google.com>
 <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org> <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
 <CADXeF1H6BHZU1OaQW6LKsJh2m7svWS8qfR+SCGNb8A3aoBGk8A@mail.gmail.com>
In-Reply-To: <CADXeF1H6BHZU1OaQW6LKsJh2m7svWS8qfR+SCGNb8A3aoBGk8A@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 10 Jan 2025 01:10:47 +0900
X-Gm-Features: AbW1kvZWPFRoHr6jSapJ4a6kTQ_lUn_Ib0gVPFDskXcxgZXl5iOzxfgpsrK7Tlk
Message-ID: <CADXeF1FQH-odRgvUg=uBVwKkVkZ2YP+uNYt6WwU0Q4cxLxW3rA@mail.gmail.com>
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

>You don't have to wait for iproute2 changes to be merged.
>Push them somewhere we can pull from, and when you post v5
>(with the self-test) just add a link to that iproute2 git repo
>to the cover letter.
>We'll pull your changes to the iproute2 used by the CI image.

Thanks for the suggestion, I will include the iproute2 based self-test
in v5 patch.

Thanks
Yuyang

On Fri, Jan 10, 2025 at 1:09=E2=80=AFAM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> >my comment meant that this `type` should be removed and the wrappers
> >below just call the intended function. No need for the extra layers.
>
> This patch was trying to follow the similar pattern in addrconf.c. We
> have a similar addr_type_t based dispatching mechanism to handle the
> dumping of ANYCAST, MULTICAST, and UNICAST addresses.
>
> inet6_dump_ifaddr()/inet6_dump_ifmcaddr()/inet6_dump_ifacaddr() ->
> inet6_dump_addr() -> in6_dump_addrs()
>
> The dispatching switch statement resides within in6_dump_addrs(), and
> those dump functions share the common code path in inet6_dump_addr().
>
> Thanks,
> Yuyang
>
>
> On Fri, Jan 10, 2025 at 12:52=E2=80=AFAM Yuyang Huang <yuyanghuang@google=
.com> wrote:
> >
> > >my comment meant that this `type` should be removed and the wrappers
> > >below just call the intended function. No need for the extra layers.
> >
> > Sorry, I still do not fully understand the suggestions.
> >
> > In the current inet_dump_ifaddr() function, there are two places where
> > in_dev_dump_addr() is called.
> >
> > For example, we have the following code snippet.
> >
> > >if (!in_dev)
> > >goto done;
> > >err =3D in_dev_dump_addr(in_dev, skb, cb, &ctx->ip_idx,
> > >       &fillargs);
> > >goto done;
> > >}
> >
> > Do you suggest we do the following way?
> >
> > > If (type =3D=3D UNICAST_ADDR)
> > >    err =3D in_dev_dump_ifaddr(in_dev, skb, cb, &ctx->ip_idx,
> > >                                             &fillargs);
> > > else if (type =3D=3D MULTICAST_ADDR)
> > >    in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
> > >                                         &fillargs);
> >
> > The current functional call stack is as follows:
> >
> > inet_dump_ifaddr()/inet_dump_ifmcaddr() -> inet_dump_addr() ->
> > in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr().
> >
> > The ifaddr and ifmcaddr dump code paths share common logic inside
> > inet_dump_addr(). If we don't do the dispatching in
> > in_dev_dump_addr(), we have to do the dispatching in inet_dump_addr()
> > instead, and the dispatching logic will be duplicated twice. I don't
> > think this will simplify the code.
> >
> > Or do you suggest I should pass a function pointer for
> > in_dev_dump_ifaddr()/in_dev_dump_ifmcaddr() into inet_dump_addr()?
> >
> > Thanks,
> >
> > Yuyang
> >
> > On Fri, Jan 10, 2025 at 12:33=E2=80=AFAM David Ahern <dsahern@kernel.or=
g> wrote:
> > >
> > > On 1/9/25 12:22 AM, Yuyang Huang wrote:
> > > > @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *=
net)
> > > >       return res;
> > > >  }
> > > >
> > > > -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_ca=
llback *cb)
> > > > +static int inet_dump_addr(struct sk_buff *skb, struct netlink_call=
back *cb,
> > > > +                       enum addr_type_t type)
> > > >  {
> > > >       const struct nlmsghdr *nlh =3D cb->nlh;
> > > >       struct inet_fill_args fillargs =3D {
> > > >               .portid =3D NETLINK_CB(cb->skb).portid,
> > > >               .seq =3D nlh->nlmsg_seq,
> > > > -             .event =3D RTM_NEWADDR,
> > > >               .flags =3D NLM_F_MULTI,
> > > >               .netnsid =3D -1,
> > > > +             .type =3D type,
> > >
> > > my comment meant that this `type` should be removed and the wrappers
> > > below just call the intended function. No need for the extra layers.
> > >
> > > >       };
> > > >       struct net *net =3D sock_net(skb->sk);
> > > >       struct net *tgt_net =3D net;
> > > > @@ -1949,6 +1996,20 @@ static int inet_dump_ifaddr(struct sk_buff *=
skb, struct netlink_callback *cb)
> > > >       return err;
> > > >  }
> > > >
> > > > +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_ca=
llback *cb)
> > > > +{
> > > > +     enum addr_type_t type =3D UNICAST_ADDR;
> > > > +
> > > > +     return inet_dump_addr(skb, cb, type);
> > > > +}
> > > > +
> > > > +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_=
callback *cb)
> > > > +{
> > > > +     enum addr_type_t type =3D MULTICAST_ADDR;
> > > > +
> > > > +     return inet_dump_addr(skb, cb, type);
> > > > +}
> > > > +
> > > >  static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlm=
sghdr *nlh,
> > > >                     u32 portid)
> > > >  {
> > >

