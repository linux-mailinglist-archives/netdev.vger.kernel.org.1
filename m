Return-Path: <netdev+bounces-144036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96D9C52D2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07C42831BF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617082038CF;
	Tue, 12 Nov 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVwFlm4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D6189B9F
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406251; cv=none; b=RgfVGvMLlXRikmX1552kL35hAlpzKl3tqcs4gELHQ5qhrVg7Dshr7LfuTGvQzIpVXg1AXm4SZt9WLx3DukRWxf8lkBfivfBOnoKiS1qDNNvAl8tvcEiy6r3D0ooj2lJKKzyxTuJ3bSgzPy7PX9qp9CZniRNfM6DhSv0rUT/sShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406251; c=relaxed/simple;
	bh=HP+balGFbVGwVaqj0CN2l8Br+XOBWTqlG0/ZQI6JrXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1CAWoAre7ADe044VGphWJLktZN0ymb7qJfD06H67kdZaEQ2HvK1KbNaMgfwH8J8waBD9Ltne/AHfmMnxNQ8f3ocWSRF2mLP0FjKyzI5Q0ta6CIgn9ugehMQmzILinm1n0VjrI+aIGGtnI2FxG/PqDV1rnbwJonRPzpBrqPjDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVwFlm4L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e044d4f7so3e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731406247; x=1732011047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD/M+SkRBlx+35MXDrQjDBxeMgoBg80dQdVLbzaMVeY=;
        b=QVwFlm4LKEaZeVQd+B90RRy4axu9OcL9gf5f6Qia6BQto7wCAnU8cQyEeR+LBPo1ua
         bh7W8UMR849od50pT9ZI3uWwryDaiCdjkbUhMz9w4HaPvLPftoMiwZzKkpbjaPxPFr+D
         aCt7zim/+UIQ874oyx9y+9h1X/D+B1pwMoJD0+Z5z8wwTZU6p9IIgNqr1D2BDWBWAF/m
         25HWIShXmgpyYQwetPCkSesekuBaXU2GSp8AWT+jWwyL6ITprQdkq2ay5YWB+3PTdhFc
         m651aKp0HjNKpf0axiWNoDCbkXH8wLi+wzXqEeKeBudqeeQofEwsaDgGIpuxp0GGXCVO
         DfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406247; x=1732011047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD/M+SkRBlx+35MXDrQjDBxeMgoBg80dQdVLbzaMVeY=;
        b=TkOuIgABq+KYfB3VAVZuz/VbV/jz+Q/aubSDzw6AuCteRo/nB234FdqNnwP1WYRExw
         En0j5zG7ZJtqdynqa8g8aev9gVk08cuXbInt9zh0eGlxVD3m21saGJGF772YwbLL5Ghd
         BzYOiXOI1jNskGQ+eMTfBrmBksCcNNg+0IdNUe4ul5HhyszOg2pqDC+LQsS7rZkhOywy
         PeFhXgfxEvwDz9YITh9rGSCJ755q/Uv2LyZUfGJX4JbkXE+ytTsvJkTMFNyLV0o/gV17
         y2de1pcqOVW0YebltwEEzKOA3GyLS3hKXiWbJMzlCvp5rLJpipLdUfpzEmlVGjlvWcg6
         51bw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTJL0I6FS8pBOeqvy4hwPgB5nOumJYR2I7SvwY/bQdAqfz86S/Qf0rI18UwM3lVFeXfCcPtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHp6pchnly/f09DDtMUsF/OfmFBXr5gyFpQDKlTJyc281RpXc
	on2el6UZbbi5WI+6WNxZcbYw7NnH2P7QW9LnBeiERKgs8QexnJFiOKSuS7E3ySS2eB5ZVOUWPw/
	1sy9jKU/94QKe3lNMluv70/ydNkcDcPHKB+HP
X-Gm-Gg: ASbGnctFiz3yhA0ZVrLtbr5biyOaRGS5aaeQ9/elQCiWsN2IydMY8SQ0Fj1YHFOtHjX
	kVMx/lPcWitTEOpTIFuVjulMtCG6detc=
X-Google-Smtp-Source: AGHT+IEz+pzcKPC5Uhh8ELzRmjUoQf/QSpsbPZtxRLnLjbViSlM/Kf5uj2NPUcO3jmt/h/sJed+HUn+scUU0RwhdyxY=
X-Received: by 2002:ac2:5f97:0:b0:539:e756:ebc1 with SMTP id
 2adb3069b0e04-53d9e2fbe94mr354e87.1.1731406246218; Tue, 12 Nov 2024 02:10:46
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110081953.121682-1-yuyanghuang@google.com> <ZzMlvCA4e3YhYTPn@fedora>
In-Reply-To: <ZzMlvCA4e3YhYTPn@fedora>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 12 Nov 2024 19:10:07 +0900
Message-ID: <CADXeF1GKMJgBQEgxnrOFOF=aSD2NqTBm_bQCKat4bmAEm2aK9A@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Would you mind also update iproute2 for testing?

Sure, besides updating the ip monitor command, are there any other
places that need to be updated?

Thanks,
Yuyang

On Tue, Nov 12, 2024 at 6:54=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
>
> Hi Yuyang,
>
> Would you mind also update iproute2 for testing?
> On Sun, Nov 10, 2024 at 05:19:53PM +0900, Yuyang Huang wrote:
> > This change introduces netlink notifications for multicast address
> > changes, enabling components like the Android Packet Filter to implemen=
t
> > IGMP offload solutions.
> >
> > The following features are included:
> > * Addition and deletion of multicast addresses are reported using
> >   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET.
> > * A new notification group, RTNLGRP_IPV4_MCADDR, is introduced for
> >   receiving these events.
> >
> > This enhancement allows user-space components to efficiently track
> > multicast group memberships and program hardware offload filters
> > accordingly.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.at=
t-mail.com
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >  include/uapi/linux/rtnetlink.h |  6 ++++
> >  net/ipv4/igmp.c                | 58 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetl=
ink.h
> > index 3b687d20c9ed..354a923f129d 100644
> > --- a/include/uapi/linux/rtnetlink.h
> > +++ b/include/uapi/linux/rtnetlink.h
> > @@ -93,6 +93,10 @@ enum {
> >       RTM_NEWPREFIX   =3D 52,
> >  #define RTM_NEWPREFIX        RTM_NEWPREFIX
> >
> > +     RTM_NEWMULTICAST,
> > +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> > +     RTM_DELMULTICAST,
> > +#define RTM_DELMULTICAST RTM_DELMULTICAST
> >       RTM_GETMULTICAST =3D 58,
> >  #define RTM_GETMULTICAST RTM_GETMULTICAST
> >
> > @@ -774,6 +778,8 @@ enum rtnetlink_groups {
> >  #define RTNLGRP_TUNNEL               RTNLGRP_TUNNEL
> >       RTNLGRP_STATS,
> >  #define RTNLGRP_STATS                RTNLGRP_STATS
> > +     RTNLGRP_IPV4_MCADDR,
> > +#define RTNLGRP_IPV4_MCADDR  RTNLGRP_IPV4_MCADDR
> >       __RTNLGRP_MAX
> >  };
> >  #define RTNLGRP_MAX  (__RTNLGRP_MAX - 1)
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index 9bf09de6a2e7..34575f5392a8 100644
> > --- a/net/ipv4/igmp.c
> > +++ b/net/ipv4/igmp.c
> > @@ -88,6 +88,7 @@
> >  #include <linux/byteorder/generic.h>
> >
> >  #include <net/net_namespace.h>
> > +#include <net/netlink.h>
> >  #include <net/arp.h>
> >  #include <net/ip.h>
> >  #include <net/protocol.h>
> > @@ -1430,6 +1431,60 @@ static void ip_mc_hash_remove(struct in_device *=
in_dev,
> >       *mc_hash =3D im->next_hash;
> >  }
> >
> > +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *=
dev,
> > +                           __be32 addr, int event)
> > +{
> > +     struct nlmsghdr *nlh;
> > +     struct ifaddrmsg *ifm;
> > +
> > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> > +     if (!nlh)
> > +             return -EMSGSIZE;
> > +
> > +     ifm =3D nlmsg_data(nlh);
> > +     ifm->ifa_family =3D AF_INET;
> > +     ifm->ifa_prefixlen =3D 32;
> > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +     ifm->ifa_scope =3D RT_SCOPE_LINK;
> > +     ifm->ifa_index =3D dev->ifindex;
> > +
> > +     if (nla_put_in_addr(skb, IFA_MULTICAST, addr) < 0) {
> > +             nlmsg_cancel(skb, nlh);
> > +             return -EMSGSIZE;
> > +     }
> > +
> > +     nlmsg_end(skb, nlh);
> > +     return 0;
> > +}
> > +
> > +static inline int inet_ifmcaddr_msgsize(void)
> > +{
> > +     return NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> > +                     + nla_total_size(sizeof(__be32));
> > +}
> > +
> > +static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, =
int event)
> > +{
> > +     struct net *net =3D dev_net(dev);
> > +     struct sk_buff *skb;
> > +     int err =3D -ENOBUFS;
> > +
> > +     skb =3D nlmsg_new(inet_ifmcaddr_msgsize(), GFP_ATOMIC);
> > +     if (!skb)
> > +             goto error;
> > +
> > +     err =3D inet_fill_ifmcaddr(skb, dev, addr, event);
> > +     if (err < 0) {
> > +             WARN_ON(err =3D=3D -EMSGSIZE);
> > +             kfree_skb(skb);
> > +             goto error;
> > +     }
> > +
> > +     rtnl_notify(skb, net, 0, RTNLGRP_IPV4_MCADDR, NULL, GFP_ATOMIC);
> > +     return;
> > +error:
> > +     rtnl_set_sk_err(net, RTNLGRP_IPV4_MCADDR, err);
> > +}
> >
> >  /*
> >   *   A socket has joined a multicast group on device dev.
> > @@ -1476,6 +1531,7 @@ static void ____ip_mc_inc_group(struct in_device =
*in_dev, __be32 addr,
> >       igmpv3_del_delrec(in_dev, im);
> >  #endif
> >       igmp_group_added(im);
> > +     inet_ifmcaddr_notify(in_dev->dev, addr, RTM_NEWMULTICAST);
> >       if (!in_dev->dead)
> >               ip_rt_multicast_event(in_dev);
> >  out:
> > @@ -1689,6 +1745,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, =
__be32 addr, gfp_t gfp)
> >                               *ip =3D i->next_rcu;
> >                               in_dev->mc_count--;
> >                               __igmp_group_dropped(i, gfp);
> > +                             inet_ifmcaddr_notify(in_dev->dev, addr,
> > +                                                  RTM_DELMULTICAST);
> >                               ip_mc_clear_src(i);
> >
> >                               if (!in_dev->dead)
> > --
> > 2.47.0.277.g8800431eea-goog
> >

