Return-Path: <netdev+bounces-153416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E19F7E28
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80269163970
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCBD86349;
	Thu, 19 Dec 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcxbO9+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118F2AD16
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622531; cv=none; b=Sn1MnsQmOLTjjwoFpoQUUb8Sphv7C0X8NGwRv3aiPAU3s3RhWDc8bdVQwm0m/2+DyBkmzt3fRKlxQvoxfWrGq34v4PqWrfx8r5K+KHUdzC3DtLflC1EV3NDaqXFTG+c5jKVXXJsTuCMR3+Qdxez633uJsomsSUbSp4m8ZTaYAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622531; c=relaxed/simple;
	bh=q507edAOrzjvbtfOCMZqrK7Ht2jbpXLEfdH30O81D/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o146l+pyJA00VN1gylJi9z51v7O2+gyr+3QT97vRShCLT+KVMxepgQAg77g6mz4dCd6ctmVg8HTRQX13PikZVQCsfnIgTiPusbILkhUh0lDQOUR3oEvzio1ItZ0i0ogux8eFEyT165aIop8fig1XOTL3CFJE/14vuv1FdS8FOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcxbO9+x; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so155ab.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734622529; x=1735227329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsC+SK+jJ6Ei+8rIQQAVO9T0AKmWTQBAXVt9AsSSbxA=;
        b=GcxbO9+xn5Kbk2HNydRTDBgLKHPq9tkqweJ5jFol93pQKhvrm4EfmjYCvOVJZWZXnG
         GkGrtM1IqdfAt9LZ9Gt86UY4dEnHKvJnoR1c2yPjyLPopyWvUprKt0iYtfDCmoWfbY0E
         2zM2t3fKUN3On7YJ6NlD3kuy9uN45oSGMNS1RjZMgaQNGEuU5qY1ql7iS4abmkcKG/vt
         4FW23YaVe3nux/JkAjZgiwi9a9Xzuh21FE2Sy0HzouHHe/VuaCTynAODDAyi55Y1IWFn
         EjOXlTMKUVImGUt4d9U/p4FOrksNAKuBCxUiVbQpSJLJMzt1QXJgNguQ35lysrl1e71q
         1DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622529; x=1735227329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsC+SK+jJ6Ei+8rIQQAVO9T0AKmWTQBAXVt9AsSSbxA=;
        b=AODZxy3Juz8VBi9E4qPQ9FvxcayVRDZkTlhvWBuJPP6RPE3TnLJy6ysWprPOLBimdq
         YehzPJxI8jdcfRK3Y6pCiw+npCChaov+RGlGR5/ureeVXKwv/r0Iv1zHz+EZSUbkSfwk
         bC67Fy+dDwZDWfDg5xU0kxeUwm6HrkrdamGTvi6aDyptApJTS9tF5UPZ4GoWnDfA/Q6G
         duoWJjM/4vOIde6g8imypJhoS+pM9fwVoaVupLqp29tBs0Vudw9LgiRqCvEEGOzVqCg+
         L+hPFrNHCm1AqpGdJWPZT89nJBC+HBNlpkob2EX+lFy+hWqqnojN7+nL20nmx4ntW+m1
         GQIA==
X-Forwarded-Encrypted: i=1; AJvYcCWrPJSxdwDyfXf5MmPy2kSllo8goCzVKYDuCanf4y10E5imPR8RkYrcWm+7Bvai57pfVKdQpcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cuHxhwnEi6VmVXGoTYxMGG+dQJFP4ZaavyYrFVNZ60npMsWO
	Jx5rxnFejDuv3KuxK2Mg6y486y3yrg96rKYfxMj3H3MklbbswQdLtPW8DrooTR2Lxq5MfcEjaU0
	Gf0b3NY0Da82Xm1ZVh7A1wDPHkFR7DNn+nfzD
X-Gm-Gg: ASbGncuDBSfV60a9kb4UWwjDbG0hLB6wn1sRFHX7ErOnanO7kH4uJrLp72Ygb79mbOd
	aJZGNJSeWKJpgvF8+yhmwxXShY9IMzS/a/MS2WOlMWnhukqZ54/6ey1tK1prg9r7Xqb+xgms=
X-Google-Smtp-Source: AGHT+IHwGkimoZGCoY0Lk82BIuiWQgn9prPNa2BqDrk9WB1HSTsEkenP1Mabx5R0H8AYu8uqDIMybbw6dQCPZYjfcPQ=
X-Received: by 2002:a05:6e02:8ea:b0:3b4:1cef:4f97 with SMTP id
 e9e14a558f8ab-3c2530c5b49mr73575ab.2.1734622528613; Thu, 19 Dec 2024 07:35:28
 -0800 (PST)
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
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 20 Dec 2024 00:34:51 +0900
X-Gm-Features: AbW1kva37AK9kkBC9Le4fVtl6jduZeDUNmhjRVCL2CpuJYst_SlMoKwnL7-dkEg
Message-ID: <CADXeF1E16ffcJ2tsYDHWr5OX=9B9u0_t3QoKus=RnuQw_e_0EQ@mail.gmail.com>
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

>Same remark for inet_ifmcaddr_notify()

Moreover, for both IPv4 and IPv6, when a device is up, the kernel
joins the all-hosts multicast addresses (224.0.0.1/ff02::1). I guess
this logic also does not run in process context?

Thanks,
Yuyang

On Fri, Dec 20, 2024 at 12:27=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> >Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.
>
> >All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
> >thus can sleep under memory pressure.
>
> I might not have enough background knowledge here, but why does
> holding RTNL imply that the callers are in process context?
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git=
/tree/net/ipv6/addrconf.c#n2241
>
> In addrconf.c, the logic joins the solicited-node multicast group and
> calls into mcast.c logic, which eventually triggers the notification.
> I guess this code path is not in process context when the kernel does
> SLAAC?
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

