Return-Path: <netdev+bounces-150513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC039EA732
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 05:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C606918825CD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B62248B5;
	Tue, 10 Dec 2024 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p60GyNbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143A23312A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733805196; cv=none; b=H79EXdp0nkD2WyZOezM+S+widyiVvr4i/teKOHgNPg6B3upVYBf2VmoxzafBxYsPJwdP9f9Mr8gSOkdoAjfryyeTykaeWoBvu3WJaKAalmsN3NaZ5I2ShX1G76eAbS8182Sp5Ak27k+Ms+jbxF4Gb8B98pQMbXO2IyRuuU7xsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733805196; c=relaxed/simple;
	bh=SmCmW9BxeAcCl7Ei/BUCMIk2EU8BrEHPt+/MhnKKGc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h63OrGy2nQAvbtYrtlwXcACPhPrxCYt5dKjluas7YAzf0AfOWmDp0wEwET0umX0YWI9l0lnWU805FnQDkb0BHy1go7QFD/S4ERWwuDEeSG3TUKIxMmz3YFfrx3+bjpg17fRBsGXnhqJTkgSC02Dj/amh5YS25k5MfjZ+aFg4S08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p60GyNbb; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso55ab.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 20:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733805194; x=1734409994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZszKNiMm/SV3up1prQQSqqcDrhQmyS1Mq1wrq8XOMJE=;
        b=p60GyNbbNGsh2xj/gELXPSrb+fWxM8cIIpUV3IeD8WQ9ALFjdfkIzSluY2wTcxxu6p
         U5guRXa5PNAoDXkEqSMb23GFwJzMLTqyo9iXXK09Se5NHy7dabn3bz8ZdLDay1jx7ylT
         +opFbik/oauDf9/YKw1nJMEzC4KbFhIxCpiJPvXNM5DC5ZJYmnkThaoFDbT09gEWbw7l
         zfdi+ugKtdCO9L7iq7x7z80ehkKirruEAXF3KC4Ta7QlFrsO6bn06Qyg6FSW18pQWp0F
         qzf2UO+JOAlwCidQrg2aXKAmWhQtY6SVEb9S//Zw/kdNEFE3a80UWO0KyZx6dp9HLKq/
         +L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733805194; x=1734409994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZszKNiMm/SV3up1prQQSqqcDrhQmyS1Mq1wrq8XOMJE=;
        b=MhYnx2KX4v8r1/x6woWsHQtTS5kVQzidGsrhTuPusBSSjvYuY5dgFc9iSSg7YeWV/N
         k8kh1FH3eJwNddyHIsxaa4TQkfEMcYkVVJw8rJQfn9XFEFoEK1jjOyTQuXI5m9L0vhPB
         qLrPwS0MhtN2dkf8muPGXAGXImnA6cIt8XjSbHSR6LNFXYtZmQhF7l8dWbnLpAFwFc6l
         MV7iAmNf5Cu5HvN0+aNf6n4WykJuBNDUKMNRdjrkBhxeg3kqYmVAQJdcqNj47Uo35hMN
         iiTPEjxrWdZsHaSkqb+7k9WfbCafJheC2CqMJnPBYjD6hRonttjHWauQe+u2tkyxqY3O
         kNYA==
X-Forwarded-Encrypted: i=1; AJvYcCVn27oh7YwQzt4nD5fMclEvoHbQtMPe+jOSJzz4zo/F/4H1P1xHkxOycgbc53jkUXiDfb6VAlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZuvjDOFvR4vIXK2f0v40uUVbPpUPGuv2Zujtqq2rT7jUqbv5
	ItkkKSr69lyIMOpwywoJsZagHiuInqk4XjTmjaN7p6R4OX1rmO5o6Y9+4HKB58ouaXLANHy1Etm
	DHtCORHA+XHIbtacmgHU5cXkyaJbTvsjo6vzK
X-Gm-Gg: ASbGncsBeu+jYwt0PH1Ui4+6PaeNPxGqm9KUIKudmKM0IA2gUxkaX5MTDOzn2drMNbk
	yODIZ27z6OKbFMs5Frp6BNFBm3y9ZwZFcR0iHfnt9MfhoJk+qVTW3TW8MOll3GiV4qg==
X-Google-Smtp-Source: AGHT+IHWThUEJvPWCRhVMtRWAbCdEPZPRXp2GqM+yw+P+eJM0BqsKbIc3MuoM6Jr5TpBl/1MyTK4iQG5ZZF2GyOIIDU=
X-Received: by 2002:a05:6e02:1c82:b0:3a7:cde7:1f5f with SMTP id
 e9e14a558f8ab-3a9e0d53723mr140545ab.2.1733805192887; Mon, 09 Dec 2024
 20:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206041025.37231-1-yuyanghuang@google.com>
 <20241209182549.271ede3a@kernel.org> <CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
In-Reply-To: <CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 10 Dec 2024 13:32:35 +0900
X-Gm-Features: AbW1kvZu_PrJcnsoqZveryWWs3eNIq7ccD43fknvuldbndFUVa-6Slzd3Km15Rc
Message-ID: <CADXeF1Ekn1cH01GjYmnN64NaGOhY0yLz30HB720u_TFabwm33A@mail.gmail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>In order to reuse the `inet6_fill_ifmcaddr()` logic, we need  move the
>function and `struct inet6_fill_args` definition into
>`net/core/rtnetlink.c` and `include/net/rtnetlink.h`. Is this approach
>acceptable?

Instead of touching rtnetlink.{h.c}, I realized it might be more
suitable to move `inet6_fill_ifmcaddr()` and `struct inet6_fill_args`
into addrconf.h.

Thanks,
Yuyang

On Tue, Dec 10, 2024 at 12:19=E2=80=AFPM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> Thanks for the review feedback.
>
> >Is there a strong reason you reimplement this instead of trying to reuse
> >inet6_fill_ifmcaddr() ? Keeping notifications and get responses in sync
> >used to be a thing in rtnetlink, this code already diverged but maybe
> >we can bring it back.
>
> In order to reuse the `inet6_fill_ifmcaddr()` logic, we need  move the
> function and `struct inet6_fill_args` definition into
> `net/core/rtnetlink.c` and `include/net/rtnetlink.h`. Is this approach
> acceptable?
>
> In this patch, we will always set `ifa_scope` to `RT_SCOPE_UNIVERSE`
> for both IPv4 and IPv6 multicast addresses for consistency. Reusing
> `inet6_fill_ifmcaddr()` will revert to the following logic:
>
> >u8 scope =3D RT_SCOPE_UNIVERSE;
> >struct nlmsghdr *nlh;
> >if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
> scope =3D RT_SCOPE_SITE;
>
> Is it acceptable, or should I update the old logic to always set
> =E2=80=98RT_SCOPE_UNIVERSE=E2=80=99?
>
> >ENOMEM ? I could be wrong but in atomic context the memory pressure
> >can well be transient, it's not like the socket queue filled up.
>
> Will update in the next patch version.
>
> >nit: + goes to the end of previous line
>
> Will update in the next patch version.
>
> >nit: nlmsg_free(), since it exists
>
> Will update in the next patch version.
>
> Thanks,
> Yuyang
>
>
> On Tue, Dec 10, 2024 at 11:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri,  6 Dec 2024 13:10:25 +0900 Yuyang Huang wrote:
> > > +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_devic=
e *dev,
> > > +                            const struct in6_addr *addr, int event)
> > > +{
> > > +     struct ifaddrmsg *ifm;
> > > +     struct nlmsghdr *nlh;
> > > +
> > > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0=
);
> > > +     if (!nlh)
> > > +             return -EMSGSIZE;
> > > +
> > > +     ifm =3D nlmsg_data(nlh);
> > > +     ifm->ifa_family =3D AF_INET6;
> > > +     ifm->ifa_prefixlen =3D 128;
> > > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > > +     ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
> > > +     ifm->ifa_index =3D dev->ifindex;
> > > +
> > > +     if (nla_put_in6_addr(skb, IFA_MULTICAST, addr) < 0) {
> > > +             nlmsg_cancel(skb, nlh);
> > > +             return -EMSGSIZE;
> > > +     }
> > > +
> > > +     nlmsg_end(skb, nlh);
> > > +     return 0;
> > > +}
> >
> > Is there a strong reason you reimplement this instead of trying to reus=
e
> > inet6_fill_ifmcaddr() ? Keeping notifications and get responses in sync
> > used to be a thing in rtnetlink, this code already diverged but maybe
> > we can bring it back.
> >
> > > +static void inet6_ifmcaddr_notify(struct net_device *dev,
> > > +                               const struct in6_addr *addr, int even=
t)
> > > +{
> > > +     struct net *net =3D dev_net(dev);
> > > +     struct sk_buff *skb;
> > > +     int err =3D -ENOBUFS;
> >
> > ENOMEM ? I could be wrong but in atomic context the memory pressure
> > can well be transient, it's not like the socket queue filled up.
> >
> > > +     skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> > > +                     + nla_total_size(16), GFP_ATOMIC);
> >
> > nit: + goes to the end of previous line
> >
> > > +     if (!skb)
> > > +             goto error;
> > > +
> > > +     err =3D inet6_fill_ifmcaddr(skb, dev, addr, event);
> > > +     if (err < 0) {
> > > +             WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
> > > +             kfree_skb(skb);
> >
> > nit: nlmsg_free(), since it exists
> >
> > > +             goto error;
> > > +     }
> > > +
> > > +     rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_ATOMIC)=
;
> > > +     return;
> > > +error:
> > > +     rtnl_set_sk_err(net, RTNLGRP_IPV6_MCADDR, err);
> > > +}
> > > +
> > --
> > pw-bot: cr

