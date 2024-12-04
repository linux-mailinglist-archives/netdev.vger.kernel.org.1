Return-Path: <netdev+bounces-148996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353E9E3C18
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D103E16A1CA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B61F7082;
	Wed,  4 Dec 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guytGOAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDD1F707A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321151; cv=none; b=leS4EO0Ae/0NqQDl0CPft3CS/rqVxFiPyzQxczzDq6RnBgTuqiqgkAoAkkoRlmq+E312QJKQyNA6iuXzHrBP1X4IVi5Z6kTueUMgjGwAVXtVO/y8MyWbkWztQLCcS/lM6tQNbKGSXenl6FhJevmZgLqZ8mSvjprCjpq/RNMOtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321151; c=relaxed/simple;
	bh=tki7XHcKFqOgzp9rosUkkTuXm8CLxaszaBf5O7gJpf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQiN05V5gdGzuKZbBfAiX7el1Hzg5HLTZcYI8JMVxxXvqT0B8CW4wxT8M0p2ahpxJpohztNYgUC40e4Rk8XnduifMcthrc1Bp4tTM2m8Ut0Itd4HtzKgRiSR0FT12/j3TGAGZpNlI4L8qJaA5N85zmhR8+LTtDi0s+peUBT3TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guytGOAZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53ddfc5901eso7e87.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733321148; x=1733925948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuJtspqLOkwmkVmX0MvsB/cYISuv0uBQVHGtS3SGQiw=;
        b=guytGOAZacvdesmO7XzfnldEY6jpH5DqiN0E1viL4W3glpMPhzdsGKXZQlfiDOOsc6
         zA7OTduu+RBJMsrP1c/KZua8FlMkb3fEMW1Q6SARHmDZYKuwYT1+wMyT6t8nRiYJDIW1
         d7jYrD133sSQt6jepJMnxUQfYgTshdOF8tok3zWiMxkoAk3palGYt0Cb4g5ZSfqDDwxw
         X3fIVogn6uP4bpqi6g+0U+Qjtx6o4s5QOIQldODdLdXcyu75BfznGOsRZ0+KNPpR2SKj
         NiTQRDwFnmmFsmK5nMFSqyGqYPzh61G3SD8f0jwkqFDG4a1Sy8rELi6nfF/f5mlMZhCa
         xdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321148; x=1733925948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuJtspqLOkwmkVmX0MvsB/cYISuv0uBQVHGtS3SGQiw=;
        b=NQvAdycXlDH2RXWf5f87XtBxYIOdCTslcccU9TUBrcDNJDjaWe/RTm9c3B4flukg32
         4nf6Y0P9vKvpn2k4lgASoxcfpswitaUX2uaY0Sm2Y2ksIA43DJg3SdGAqO5V8AD6IzsL
         /zS7tqdiDOMQJiDxn5Qm5hafdNhw0plGf0hXuaI9CQwPLsoE4/FKCj2HpR+gLxNvxPqC
         5DG3DAXG1l+b5+4waWbkuoezbqAQcUJJe9iik8ljsGHYTJYFPgDelrcLxkLRuF2TCRX8
         UVoN6WlYpVMnbOY1CvD+k52cV7KucFAtI00UwyfoWqW2c3m1U40g9Pa2HdQRsNdhOOQh
         LAVg==
X-Forwarded-Encrypted: i=1; AJvYcCWBYzbUlO9WTlYLfrdz6sxdvGA5ARwfqSvsqe4vXdZvS2wlkPE+WbE0BMCMCbkZtFpIXP4A5SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywik6/hmf81qREqSvOGia/qusNyXnvnWEmVDf8yDLkqyWL55FCu
	EpXz0oS4dngQg5eFTMWqHxsZhp81I/a28evIYdS3pcmm7tgVMH9dAnEY1JK3ml/pNs8+QNirvNU
	XiIytmAAgUjYGvCdGyoN2ekmrsBpidWrtPFaI
X-Gm-Gg: ASbGncu0fyvM9uofeVPh/cvZ8xd9YkhUIVIoleGYg/DqowABY0Hsc3n+zPupOdn+Vtd
	Qt8cV8SkOOU0mV0qMzV5ICUDpjZM87yxSZMrw4HSpAvnNRKF46rBiH0kK8oq4kM2u
X-Google-Smtp-Source: AGHT+IHQG0namdU9K5p6gxlQbAyfWU7iX/frllabvqGmOp28JzpNKVcRJaSY138me8ohorlLmC1z4ySpLLaIlAtf2Yk=
X-Received: by 2002:a19:7704:0:b0:53d:ff0a:249d with SMTP id
 2adb3069b0e04-53e20c75e2fmr64e87.2.1733321145117; Wed, 04 Dec 2024 06:05:45
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204134752.2691102-1-yuyanghuang@google.com> <6cb2b3e2-d3ce-427e-9809-5b81474b80e4@6wind.com>
In-Reply-To: <6cb2b3e2-d3ce-427e-9809-5b81474b80e4@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 4 Dec 2024 23:05:06 +0900
X-Gm-Features: AZHOrDmW3V8HdGmjrV_EE8QPglkUa6Yv0bGjozVCn2M3LZ49ycqkSI5cUaY9ERQ
Message-ID: <CADXeF1EfgSKcz-zF24rsHUZiF+vUkiPsTmdFw=rf3EWCtcSk-A@mail.gmail.com>
Subject: Re: [PATCH net-next, v4] netlink: add IGMP/MLD join/leave notifications
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Maybe WARN_ON_ONCE() is enough?

Thank you very much for the prompt review feedback. Will update in patch v5=
.

Thanks,
Yuyang


On Wed, Dec 4, 2024 at 10:54=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 04/12/2024 =C3=A0 14:47, Yuyang Huang a =C3=A9crit :
> > This change introduces netlink notifications for multicast address
> > changes. The following features are included:
> > * Addition and deletion of multicast addresses are reported using
> >   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
> >   AF_INET6.
> > * Two new notification groups: RTNLGRP_IPV4_MCADDR and
> >   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> >
> > This change allows user space applications (e.g., ip monitor) to
> > efficiently track multicast group memberships by listening for netlink
> > events. Previously, applications relied on inefficient polling of
> > procfs, introducing delays. With netlink notifications, applications
> > receive realtime updates on multicast group membership changes,
> > enabling more precise metrics collection and system monitoring.
> >
> > This change also unlocks the potential for implementing a wide range
> > of sophisticated multicast related features in user space by allowing
> > applications to combine kernel provided multicast address information
> > with user space data and communicate decisions back to the kernel for
> > more fine grained control. This mechanism can be used for various
> > purposes, including multicast filtering, IGMP/MLD offload, and
> > IGMP/MLD snooping.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.at=
t-mail.com
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>
> A minor comment below and then:
> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>
> > ---
> >
> > Changelog since v3:
> > - Remove unused variable 'scope' declaration.
> > - Align RTM_NEWMULTICAST and RTM_GETMULTICAST enum definitions with
> >   existing code style.
> >
> > Changelog since v2:
> > - Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
> >   consistency.
> >
> > Changelog since v1:
> > - Implement MLD join/leave notifications.
> > - Revise the comment message to make it generic.
> > - Fix netdev/source_inline error.
> > - Reorder local variables according to "reverse xmas tree=E2=80=9D styl=
e.
> >
> >  include/uapi/linux/rtnetlink.h | 10 +++++-
> >  net/ipv4/igmp.c                | 53 +++++++++++++++++++++++++++++++
> >  net/ipv6/mcast.c               | 57 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 119 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetl=
ink.h
> > index db7254d52d93..eccc0e7dcb7d 100644
> > --- a/include/uapi/linux/rtnetlink.h
> > +++ b/include/uapi/linux/rtnetlink.h
> > @@ -93,7 +93,11 @@ enum {
> >       RTM_NEWPREFIX   =3D 52,
> >  #define RTM_NEWPREFIX        RTM_NEWPREFIX
> >
> > -     RTM_GETMULTICAST =3D 58,
> > +     RTM_NEWMULTICAST =3D 56,
> > +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> > +     RTM_DELMULTICAST,
> > +#define RTM_DELMULTICAST RTM_DELMULTICAST
> > +     RTM_GETMULTICAST,
> >  #define RTM_GETMULTICAST RTM_GETMULTICAST
> >
> >       RTM_GETANYCAST  =3D 62,
> > @@ -774,6 +778,10 @@ enum rtnetlink_groups {
> >  #define RTNLGRP_TUNNEL               RTNLGRP_TUNNEL
> >       RTNLGRP_STATS,
> >  #define RTNLGRP_STATS                RTNLGRP_STATS
> > +     RTNLGRP_IPV4_MCADDR,
> > +#define RTNLGRP_IPV4_MCADDR  RTNLGRP_IPV4_MCADDR
> > +     RTNLGRP_IPV6_MCADDR,
> > +#define RTNLGRP_IPV6_MCADDR  RTNLGRP_IPV6_MCADDR
> >       __RTNLGRP_MAX
> >  };
> >  #define RTNLGRP_MAX  (__RTNLGRP_MAX - 1)
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index 6a238398acc9..8d6ee19864c6 100644
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
> > @@ -1430,6 +1431,55 @@ static void ip_mc_hash_remove(struct in_device *=
in_dev,
> >       *mc_hash =3D im->next_hash;
> >  }
> >
> > +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *=
dev,
> > +                           __be32 addr, int event)
> > +{
> > +     struct ifaddrmsg *ifm;
> > +     struct nlmsghdr *nlh;
> > +
> > +     nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> > +     if (!nlh)
> > +             return -EMSGSIZE;
> > +
> > +     ifm =3D nlmsg_data(nlh);
> > +     ifm->ifa_family =3D AF_INET;
> > +     ifm->ifa_prefixlen =3D 32;
> > +     ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +     ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
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
> > +static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, =
int event)
> > +{
> > +     struct net *net =3D dev_net(dev);
> > +     struct sk_buff *skb;
> > +     int err =3D -ENOBUFS;
> > +
> > +     skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> > +                     + nla_total_size(sizeof(__be32)), GFP_ATOMIC);
> > +     if (!skb)
> > +             goto error;
> > +
> > +     err =3D inet_fill_ifmcaddr(skb, dev, addr, event);
> > +     if (err < 0) {
> > +             WARN_ON(err =3D=3D -EMSGSIZE);
> Maybe WARN_ON_ONCE() is enough?
>
>
> Regards,
> Nicolas

