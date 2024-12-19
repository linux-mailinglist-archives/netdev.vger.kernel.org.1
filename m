Return-Path: <netdev+bounces-153388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01119F7D36
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928E37A211C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0D86343;
	Thu, 19 Dec 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSIXaU0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B541C64
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618760; cv=none; b=LY7oduHXtm+GchfBTiFGjbGk9BBC6ProI/hA8bHqjmbJtg0mA/Newen3Fghgo98l0KnPr7nz7mAwObVw0AiIxDe2ysAQz15gXAc1SGQ+Gf57c5C5exhE3XUN5Gt2XSU0E7Zz8uHuRPIFM20JPWJpAysPvyUmsmGbxHXQZPLZW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618760; c=relaxed/simple;
	bh=MTbnqyG4WZvVLsNcy9dmC6pgwvjvEI9gto5CkG1Ww5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijBXX0q5z7bNFMTsXJ5bE+XpaSWP91NJGO0ISO5Wp2va9SiQYbVrafhTuE4TNfcx04O4amCitpzo7qc1xO4GelXJDb2IQp9HXWF6+8SQvHCVGslPoB2Y2AGwcs3dVBm5iEyGAEBUHKDL2+IHxs+6pTNFTOe/iTO1iytGdXZn2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSIXaU0R; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso45ab.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734618758; x=1735223558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmujAwmCAZQysRjd1v4nKgK5QNdCHH4iAdYF7vWiftI=;
        b=cSIXaU0Rbtj39JW6v3T6t/2gJ7lTwY0KFFTAdZuAMuBuXadYyq5L9AZqQ5E+sl0Tcy
         Kpgo/TplS7L3IccO68vmQMxqXoCtzKZ+c/9LRToPogWCysIPzo/fCkqn+47/Om2T4KsY
         wAqylwKaWy1Rmsy6qjkmfnDEyd+po3UEmP8si4Dv1+TddzhDgFa2KdxQMXQ30oiTx4bw
         c3Tv2ajW3JlJRkatweuyCOfbSgaDLU1Fu+sQ9nJswWabGxwF0Fq1tx5spzsMHgbbZxya
         hm3GO0R/TkvsOeeGuP07NBX746QIsmCif0dJf1Wi+7KRrbXeywfvZiJ2uHO8m2VUsHe+
         ZjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734618758; x=1735223558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmujAwmCAZQysRjd1v4nKgK5QNdCHH4iAdYF7vWiftI=;
        b=a15ZY568Wey9DvR0WPyU2SEhBsyLrhEmab/HLJaXk7G6dgOh7Qz+iZXru5Vclf4p/G
         hFJ8VlyTTzZBx+pvVZEa6T3NnPdvMSl0fspwt9xJtlFBplIavowb1B3SW2yDYKZ31OWy
         /NUHMrTunpCNa1oP+6WgjifwYg0ntueCqBsJ7ZDKyTmZJe2ikLMdqMZwdm+z4M9MkKJl
         B9a33WuhuaMstAUb0m/vb56l7ACPMVSx51YPm/UJutLIOfeAOFiEfSw0U0fi0eJ2uWRE
         gyJnVA1Z+3Q6j0Q6oUcHOrbH9xoR5uBI3rI9Qi6jio3IRK67doFs4Zt4tdKgieVENVR1
         wvAg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6ep4JWPjSEYgKTsa7xMRcxyTwBrjL1q8zOFNi4+TlwQiNaLKPbJZ8lAnTnOIbZdNtoP1Ddg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3gDYyZ4mYJAXSAbvRdbnGccXzpXrITbK3nDmOFgbDlAdGTJ0
	VyL9k5PjW3C3wzvgvY4iifLU5uiCa934d+sz+wKECGhhsK9N9wzZdDaPz34vb8ZKdOn8Pvp2x4F
	HxRmyONVmsOuIgJGnAHEJHoxRRxxtoBfILBpH
X-Gm-Gg: ASbGnctrqhLuiy1o8FoBG0LqMd0WH/yI+6d2o0RsPoKtIBV5JlInHcCOlNO+e6sHCU0
	MDpvZvFOc5/+tF/pUSOZ/dPX92ejT2bGDKYvrinYubjGy40dacQpJqVaFmSyVEKj1kP9RVg==
X-Google-Smtp-Source: AGHT+IEv+T0+wt1o7UOgakJ+fKLERO51YH5P4NEr+eHPIc29GwytSBwV1ob4X0auBhBZKVsKsev42ZibbZcEudj8Hvk=
X-Received: by 2002:a92:c26d:0:b0:3a7:d682:36f6 with SMTP id
 e9e14a558f8ab-3c24cbd5995mr36625ab.0.1734618756853; Thu, 19 Dec 2024 06:32:36
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
 <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com> <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
In-Reply-To: <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 19 Dec 2024 23:31:59 +0900
X-Gm-Features: AbW1kvYgYXcm6Z7erGEJFkoh6tnWim70urlT5EFmt3_dne5hXBkvfwk8CfVXBFs
Message-ID: <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com>
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

Hi Eric

Thanks for the prompt review feedback. I will adjust all the comments
in the v2 patch.

>inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
please remove it.

I  made the same mistake in Link:
https://lore.kernel.org/netdev/20241218090057.76899-1-yuyanghuang@google.co=
m/T/

I will fix that patch as well.

Thanks,
Yuyang

Thanks,
Yuyang


On Thu, Dec 19, 2024 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Dec 19, 2024 at 2:42=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Dec 19, 2024 at 2:27=E2=80=AFPM Yuyang Huang <yuyanghuang@googl=
e.com> wrote:
> > >
> > > Corrected the netlink message size calculation for multicast group
> > > join/leave notifications. The previous calculation did not account fo=
r
> > > the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
> > > payload. This fix ensures that the allocated message size is
> > > sufficient to hold all necessary information.
> > >
> > > Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notifications"=
)
> > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > Cc: Lorenzo Colitti <lorenzo@google.com>
> > > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > > ---
> > >  net/ipv4/igmp.c  | 4 +++-
> > >  net/ipv6/mcast.c | 4 +++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > > index 8a370ef37d3f..4e2f1497f320 100644
> > > --- a/net/ipv4/igmp.c
> > > +++ b/net/ipv4/igmp.c
> > > @@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_dev=
ice *dev,
> > >         int err =3D -ENOMEM;
> > >
> > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > -                       nla_total_size(sizeof(__be32)), GFP_ATOMIC);
> > > +                       nla_total_size(sizeof(__be32)) +
> > > +                       nla_total_size(sizeof(struct ifa_cacheinfo)),
> > > +                       GFP_ATOMIC);
> > >         if (!skb)
> > >                 goto error;
> > >
> > > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > > index 587831c148de..b7430f15d1fc 100644
> > > --- a/net/ipv6/mcast.c
> > > +++ b/net/ipv6/mcast.c
> > > @@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_devi=
ce *dev,
> > >         int err =3D -ENOMEM;
> > >
> > >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > > -                       nla_total_size(16), GFP_ATOMIC);
> > > +                       nla_total_size(16) +
> >
> > While we are at it , can you use nla_total_size(sizeof(struct in6_addr)=
)
> >
> > inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> > please remove it.
> > Squash the following in v2, thanks !
> >
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 2e2684886953d55140cd3d4a1e024b5218331a49..4da409bc45777f60fd37bde=
e541c61165a51d22c
> > 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
> >         nlmsg_end(skb, nlh);
> >         return 0;
> >  }
> > -EXPORT_SYMBOL(inet6_fill_ifmcaddr);
> >
> >  static int inet6_fill_ifacaddr(struct sk_buff *skb,
> >                                const struct ifacaddr6 *ifaca,
>
> Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.
>
> All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
> thus can sleep under memory pressure.
>
> Same remark for inet_ifmcaddr_notify()

