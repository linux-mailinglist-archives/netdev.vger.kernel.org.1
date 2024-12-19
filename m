Return-Path: <netdev+bounces-153427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047D9F7E7F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE687A1E07
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E71226888;
	Thu, 19 Dec 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGBqMqaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECE5FDA7
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623470; cv=none; b=d9F70Kmmz7jp8It8xn/mfwLmBzQutiElFSQ1m3sNTc1sGEZwsME3H9nAjOVgZGjDovmCWN5Xa5cp0hpJ3gmO2ku8SRNY6nEDBV6OudJm8BOqHCQkGeHTbeMrgO6OUacwK0wWmOU8sSRxXsTJ4TBDmKp61rkQcybTrB5QriMyB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623470; c=relaxed/simple;
	bh=va/Sx5PwTeqYNTqkWi2fD9Q0rwmFYqub1SRehn1cSrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1xabZl9NXAEhdShgN4eT/SGYTqTWaIDmbTDuFua1iz+L362oAWWsvTJOMZFn+T1aRFnJTQ+YKBLkcO+0HNQ8KR2naOx7zab5mYmDdjAdqLgoawRDsJpkjsFGSWgPwSy8QnELXEI8t27S+9E+3dploIbwRBCDaxyfYClFBcSc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGBqMqaG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so1488138a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734623467; x=1735228267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zU2eYAsVB4PUSata4FdBtNwdB1gdUCpBcYbsVKRpg=;
        b=fGBqMqaGYZ3lCRMh6tsAJomPHv8Yvsvffhd2f7BAkqJxz1gwMRh/YKMXhY1yCeJIvT
         ohFyskATnE3F3h4L4Z7LDxFLVyuFV2y34MxEoS9jXoLc2WOOSB2C5ovbXy7mkkk2S/ep
         RNwUUlqMZZsvjCW6YObJF2IYoDgcDfCTfyGktjo9AseGXVvoY6GqaTvl6dfHVL/0VGtv
         qewsca7ChunsEhBm05bIt5f+JZueIgy7ioLYaZ1yfnEEIlIunkLetreoXr6QamphJm9i
         18Dz2HgMAx4WKV0Ob9LGe1gwF3pm6OR1yscqMVfjGJj1uRn6eIP8PU4DTcoic5wkR7XE
         cNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623467; x=1735228267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98zU2eYAsVB4PUSata4FdBtNwdB1gdUCpBcYbsVKRpg=;
        b=HmAFPrx8MVOvOBIh/NtbXQqglZTLT1N4KMupTbCjoktjL14DYE04hK2ijay+fgB8ZQ
         aubUOniX+2v8iyoSWn5rO6atzIK6eUGRxM6gSLd1tFGV0GZXLIDXvC1wFhc1WiDxfOll
         fnliYU5Sa2vALD6EXq6Gi/QTuZ8RXgObZwAnljns+FNh/VapNnwAGWMHgkv1Ur6tL1ND
         aSs4AAUNPkWOcKxhZzP5xO0pQ3d7OgjvbW8feX3JxFI4UkVt4MtEqV7KwIjOrdPPChPa
         +mpHFh0huy8u6/D7qvy8I7ZuTv5h+B+d/xBhc3VoO3gOmACmhx1GEXXzV1gzHkEjxVbA
         28Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWskPxEG+dpbLioi4Vh1blvUpF37iGW9qvhpkYUhEV1iV2UKWj31zS5ZtqMS2JFO/JH3E5FDZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcbwxHu7gkmgjJugNuVW1Fj2ZSzWEUEJvQIsbHCe90WXWGVir
	0hgS6wBBY7hV9PCgZbaDfPd2MGKzGmhhlwlCuDBuS6PIz7OeBYru0pO5Ekrl9ZzhRRPQTbMwsK4
	CxpLht0K+K3iPmjmFuppisGqbiAJ0ifV6dmF7h1TeetxksBwW00sVLsU=
X-Gm-Gg: ASbGnctwgJxSeJmO7N7JV1ACzUfoLXoOKgYFPAFWBUfIKZsKjUXfKA1YaJnLpBBzwVE
	+aNOdvo9055VPbbD3EF7NqXafoeTKVOjXdire9ZMDti8bjfA4/P9EkifYOSGsm4zuaAPG7Q6B
X-Google-Smtp-Source: AGHT+IE+7RbiG6hGwLYVALPDIITNFLkuTpfqnWQvAZ4JugQUV2ivRQ/YBpFpi2NZ7fSjvSnZwI90Y0B2XGvDtxlMBCA=
X-Received: by 2002:a05:6402:26d1:b0:5d3:ba42:e9fe with SMTP id
 4fb4d7f45d1cf-5d7ee3d6d4fmr6526339a12.12.1734623467000; Thu, 19 Dec 2024
 07:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
 <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
 <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
 <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com> <CADXeF1GvpMOyTHOYaE5v6w+4jpBKjnT=he3qNpehghRWY+hNHQ@mail.gmail.com>
In-Reply-To: <CADXeF1GvpMOyTHOYaE5v6w+4jpBKjnT=he3qNpehghRWY+hNHQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 16:50:55 +0100
Message-ID: <CANn89iL683FgvkacTgi2DtSJe40-AE=7XExygp3ZntpQS_CSnw@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:28=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> >Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.
>
> >All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
> >thus can sleep under memory pressure.
>
> I might not have enough background knowledge here, but why does
> holding RTNL imply that the callers are in process context?

RTNL is a mutex. Acquiring a mutex might sleep.

By looking at the code flow, you can see we do not hold a spinlock, or
block interrupts at this point,
or are in rcu_read_lock() section.

>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git=
/tree/net/ipv6/addrconf.c#n2241
>
> In addrconf.c, the logic joins the solicited-node multicast group and
> calls into mcast.c logic, which eventually triggers the notification.
> I guess this code path is not in process context when the kernel does
> SLAAC?

All these paths must be from process context.

Note that debug kernels have CONFIG_DEBUG_ATOMIC_SLEEP=3Dy and would compla=
in.



>
> Thanks,
> Yuyang
>
> On Thu, Dec 19, 2024 at 11:31=E2=80=AFPM Yuyang Huang <yuyanghuang@google=
.com> wrote:
> >
> > Hi Eric
> >
> > Thanks for the prompt review feedback. I will adjust all the comments
> > in the v2 patch.
> >
> > >inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> > please remove it.
> >
> > I  made the same mistake in Link:
> > https://lore.kernel.org/netdev/20241218090057.76899-1-yuyanghuang@googl=
e.com/T/
> >
> > I will fix that patch as well.
> >
> > Thanks,
> > Yuyang
> >
> > Thanks,
> > Yuyang
> >
> >
> > On Thu, Dec 19, 2024 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 2:42=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Dec 19, 2024 at 2:27=E2=80=AFPM Yuyang Huang <yuyanghuang@g=
oogle.com> wrote:
> > > > >
> > > > > Corrected the netlink message size calculation for multicast grou=
p
> > > > > join/leave notifications. The previous calculation did not accoun=
t for
> > > > > the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in th=
e
> > > > > payload. This fix ensures that the allocated message size is
> > > > > sufficient to hold all necessary information.
> > > > >
> > > > > Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notificati=
ons")
> > > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > Cc: Lorenzo Colitti <lorenzo@google.com>
> > > > > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > > > > ---
> > > > >  net/ipv4/igmp.c  | 4 +++-
> > > > >  net/ipv6/mcast.c | 4 +++-
> > > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > > > > index 8a370ef37d3f..4e2f1497f320 100644
> > > > > --- a/net/ipv4/igmp.c
> > > > > +++ b/net/ipv4/igmp.c
> > > > > @@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net=
_device *dev,
> > > > >         int err =3D -ENOMEM;
> > > > >
> > > > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > > > -                       nla_total_size(sizeof(__be32)), GFP_ATOMI=
C);
> > > > > +                       nla_total_size(sizeof(__be32)) +
> > > > > +                       nla_total_size(sizeof(struct ifa_cacheinf=
o)),
> > > > > +                       GFP_ATOMIC);
> > > > >         if (!skb)
> > > > >                 goto error;
> > > > >
> > > > > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > > > > index 587831c148de..b7430f15d1fc 100644
> > > > > --- a/net/ipv6/mcast.c
> > > > > +++ b/net/ipv6/mcast.c
> > > > > @@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_=
device *dev,
> > > > >         int err =3D -ENOMEM;
> > > > >
> > > > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > > > -                       nla_total_size(16), GFP_ATOMIC);
> > > > > +                       nla_total_size(16) +
> > > >
> > > > While we are at it , can you use nla_total_size(sizeof(struct in6_a=
ddr))
> > > >
> > > > inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> > > > please remove it.
> > > > Squash the following in v2, thanks !
> > > >
> > > > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > > > index 2e2684886953d55140cd3d4a1e024b5218331a49..4da409bc45777f60fd3=
7bdee541c61165a51d22c
> > > > 100644
> > > > --- a/net/ipv6/addrconf.c
> > > > +++ b/net/ipv6/addrconf.c
> > > > @@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
> > > >         nlmsg_end(skb, nlh);
> > > >         return 0;
> > > >  }
> > > > -EXPORT_SYMBOL(inet6_fill_ifmcaddr);
> > > >
> > > >  static int inet6_fill_ifacaddr(struct sk_buff *skb,
> > > >                                const struct ifacaddr6 *ifaca,
> > >
> > > Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.
> > >
> > > All inet6_ifmcaddr_notify() callers are in process context, hold RTNL=
,
> > > thus can sleep under memory pressure.
> > >
> > > Same remark for inet_ifmcaddr_notify()

