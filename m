Return-Path: <netdev+bounces-153414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A719F7E10
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C831881BDB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895E22579E;
	Thu, 19 Dec 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqUd3wZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7F70809
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622119; cv=none; b=bvx+IeFG+v/woOz651FRmf6NQzNVXHfeUn7skJ4D0JLIZQPdJmhlOkcBd/fLT6kVN29CG39ZOV0mn8KXDrp5vVQHUVrAm5MVa8M0E/Qt/R7DfmUXKRv4D6KzcWs5zXWrJWU9jeellVhucKuNA1CnKxIe557V0q/qSSqaXvhic+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622119; c=relaxed/simple;
	bh=kf8lhn1/bkMG+kW3rVZox9a9SiYwr9kuB9krYZSoAZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFLI2Up7Y64lU/xthWVZmRR/bzscnTXbRDF3TVaKtM9BQLtFOezH7e9O6d3X/2p79iH12t0fWvcwNdOwU6dxzfoHsz7cgFF/O8sPYFmJAD8uzx1hqZ+I9acGCCqqcTRZzwaOjRENMMY9Z99tFe1wGWnXgAvzLbg7wIrCCTn33ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqUd3wZK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso205ab.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734622117; x=1735226917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h4o3tJU1GhJDcdArrBooGDS8sWwzdcbyjazjemt4p8=;
        b=MqUd3wZK3AJCdJNzkG445mtAugZm9eUDNyV/ofDLrbpDeNbUj1R5wPm3jwcyyu2MM4
         /TaAYLT2A3xVNjRL1Yjh4W2QTv09TT5xpSxYbK4xoV39Gr27PdS1uJjl2mt5zJXTcltf
         qNT3L6GxksBp2UomD2zynrj1xRITU0xXbigFoKljXVK/mrBa2qQFcooacXEeWxMSy+WZ
         cLOO+zmKbZertaMFCEAlcHGXRLsT6SdC34ToBog/FCjfB4zwXqQQOxilIbU5PWmJV4/O
         d7frfrb7V5jBl1Qoosm7eDt4btwAUikDCk69v6nBJ61PYWtBYlRyXQf0AhBNFvyR2bKw
         2pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622117; x=1735226917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h4o3tJU1GhJDcdArrBooGDS8sWwzdcbyjazjemt4p8=;
        b=ldIAOCkG4OoJDqn0iQi22yvPxOGCL4Ps+qHQFm00Zd5lyvnQvoH2YjOgqxOJ1jdzw/
         8JYW7K1matWurjzjkIm2dww5L4S47/klm8KR82zwbjocGY+rF5sxQ/IvKkdQvLqGOJwE
         iWZ86MiW99+MTzx2z5+yo+FSeuRwVaHPEOz5aMXUuK+G0EMEa/rULfsc1W+1zRSNCYSN
         aX0ciRXCgt6910ul8m2aX8ThEqLe8xrH2k/7RyZkpT1Onncd2hNCHgqUt2516c9Rxw/h
         ATA0CMRMA7TCab7gNkzJ4pi7ruANR3B9ppVA3fPm3zDR3w6E+DF40MOZVsJ0ZdGdJ0l7
         Js/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvQwvXAFoVUbI0Wx/tADD9kjFJDysrKGMtImb6t7Lt0vKp/AuC6upS7LV3MwaD3QSfMkMvqn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueDIn5DH+XRN20QmfTp8Laph71pX/GeKXmw70fZcp/hKKbFoN
	ki69827DF6WBE+G2vZ9WH3dNmGi7g9fwVSbVUZ9YGQ/LoAYRShWvLMyupoYxjzebRwER9ZFWVia
	lzxhlZOltnxela0VBVxgvj0gUswCgbT+z/+Ls
X-Gm-Gg: ASbGncuv/BlsZN2YLtOELJyV6GBcf+by+N7bjgOHn/1Ra1SvKra0MHwBvUT/lMMCLA1
	/i1AsIj19VR8GeSEkwBcreZzOkYWVAPUOgfakiqNxTQfdurmKpvTcv7MJAStRE1XjjD+kGpQ=
X-Google-Smtp-Source: AGHT+IHtFAnVUJuneCq8+KB2M+9gZnViuQrvU8S4jUG5es9vctjoiaFr6PJYEEuG/x48ju4iQhfKFOqK/0UnH18ByzM=
X-Received: by 2002:a05:6e02:58b:b0:3a7:c82d:e64b with SMTP id
 e9e14a558f8ab-3c252354bacmr61785ab.1.1734622115039; Thu, 19 Dec 2024 07:28:35
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
 <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
 <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com> <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com>
In-Reply-To: <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 20 Dec 2024 00:27:57 +0900
X-Gm-Features: AbW1kvbEBv344i-fUYF1T_ujoRazMi4Y7zJITrhJxmaC-P0oj3zzrVwyOqX1jOg
Message-ID: <CADXeF1GvpMOyTHOYaE5v6w+4jpBKjnT=he3qNpehghRWY+hNHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.

>All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
>thus can sleep under memory pressure.

I might not have enough background knowledge here, but why does
holding RTNL imply that the callers are in process context?

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/t=
ree/net/ipv6/addrconf.c#n2241

In addrconf.c, the logic joins the solicited-node multicast group and
calls into mcast.c logic, which eventually triggers the notification.
I guess this code path is not in process context when the kernel does
SLAAC?

Thanks,
Yuyang

On Thu, Dec 19, 2024 at 11:31=E2=80=AFPM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> Hi Eric
>
> Thanks for the prompt review feedback. I will adjust all the comments
> in the v2 patch.
>
> >inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> please remove it.
>
> I  made the same mistake in Link:
> https://lore.kernel.org/netdev/20241218090057.76899-1-yuyanghuang@google.=
com/T/
>
> I will fix that patch as well.
>
> Thanks,
> Yuyang
>
> Thanks,
> Yuyang
>
>
> On Thu, Dec 19, 2024 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Dec 19, 2024 at 2:42=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 2:27=E2=80=AFPM Yuyang Huang <yuyanghuang@goo=
gle.com> wrote:
> > > >
> > > > Corrected the netlink message size calculation for multicast group
> > > > join/leave notifications. The previous calculation did not account =
for
> > > > the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
> > > > payload. This fix ensures that the allocated message size is
> > > > sufficient to hold all necessary information.
> > > >
> > > > Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notification=
s")
> > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > Cc: Lorenzo Colitti <lorenzo@google.com>
> > > > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > > > ---
> > > >  net/ipv4/igmp.c  | 4 +++-
> > > >  net/ipv6/mcast.c | 4 +++-
> > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > > > index 8a370ef37d3f..4e2f1497f320 100644
> > > > --- a/net/ipv4/igmp.c
> > > > +++ b/net/ipv4/igmp.c
> > > > @@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_d=
evice *dev,
> > > >         int err =3D -ENOMEM;
> > > >
> > > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > > -                       nla_total_size(sizeof(__be32)), GFP_ATOMIC)=
;
> > > > +                       nla_total_size(sizeof(__be32)) +
> > > > +                       nla_total_size(sizeof(struct ifa_cacheinfo)=
),
> > > > +                       GFP_ATOMIC);
> > > >         if (!skb)
> > > >                 goto error;
> > > >
> > > > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > > > index 587831c148de..b7430f15d1fc 100644
> > > > --- a/net/ipv6/mcast.c
> > > > +++ b/net/ipv6/mcast.c
> > > > @@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_de=
vice *dev,
> > > >         int err =3D -ENOMEM;
> > > >
> > > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > > -                       nla_total_size(16), GFP_ATOMIC);
> > > > +                       nla_total_size(16) +
> > >
> > > While we are at it , can you use nla_total_size(sizeof(struct in6_add=
r))
> > >
> > > inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> > > please remove it.
> > > Squash the following in v2, thanks !
> > >
> > > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > > index 2e2684886953d55140cd3d4a1e024b5218331a49..4da409bc45777f60fd37b=
dee541c61165a51d22c
> > > 100644
> > > --- a/net/ipv6/addrconf.c
> > > +++ b/net/ipv6/addrconf.c
> > > @@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
> > >         nlmsg_end(skb, nlh);
> > >         return 0;
> > >  }
> > > -EXPORT_SYMBOL(inet6_fill_ifmcaddr);
> > >
> > >  static int inet6_fill_ifacaddr(struct sk_buff *skb,
> > >                                const struct ifacaddr6 *ifaca,
> >
> > Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.
> >
> > All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
> > thus can sleep under memory pressure.
> >
> > Same remark for inet_ifmcaddr_notify()

