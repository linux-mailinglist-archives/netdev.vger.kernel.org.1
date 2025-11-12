Return-Path: <netdev+bounces-237804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D5C50631
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235833B4073
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2D18A6B0;
	Wed, 12 Nov 2025 03:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk2xmFpM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510C1494DB
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916582; cv=none; b=IHfTgdoSyv7T/FPhUotBnV0dNlvl31EY6UzxgBSoW35bHkmFIqVXGGBW3qn9Ck7X7CWtpRyHZGiqqLAXZdK49m2DmuEGpDvnRuUtdeSof4mHJNH+je4ntckXrsGcWA1tXKHXdEAmNkUCg0fpUB/JSmPLcGmPeH+znnzlotHF5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916582; c=relaxed/simple;
	bh=ps4SMXBaB/v/EB/796y1FNHH4gdRS7Kkgz+CW9Myd7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQSuPnOryZgwL+VJrktdW0r1BH7R7fn/ct+UVu0/4eTJL/+kW6JOHJv5CExdX+BuqoEHiZE5c+PswdxewCEzh/rrvW/1lXutWOZAIE3rcofWfkitnbLd1eLgULpZIGQGJBN0d+uZ73lxI9jbzx7yoIs/RYHEN9qooY6nt5cGrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk2xmFpM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298287a26c3so4005745ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762916580; x=1763521380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pphIlSRzeWHvzKSDnbmrctlSw5y24lfwRwvEo72Ksb0=;
        b=Zk2xmFpMkoqeYCJwGLE5bE5nnD9WeMiglHEnp8sToZ664Uc+0eEmgMahYWskf9gsex
         fe+w+72DevUGOuxicqxJ1V59g3D6EpBVehYp9gr9fG0riKERl3lZggdxg/PzNvT3mWXc
         XjpzBSRfYIAZz2bkLCOBcEoaUthTMEX86xFc1e4mmxqKqpH+M9WiCw8YxBAKnaA0+07Z
         sWrKLs1WVnKGz+emfafTkGD+CpbzTFJmdNKMTpri+X3spRXO39BwoPnkBccVhrLGeK6Z
         FfrKb2oghVcZHrOeWwsKLtrjJ9TVdBs9JZY3ZEOY+wt5XpMj5j7q72B1pq65gQZjH3p0
         U7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762916580; x=1763521380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pphIlSRzeWHvzKSDnbmrctlSw5y24lfwRwvEo72Ksb0=;
        b=uhtOOS+KNcS9up9ChIgAK/PZmPSPOWDV8xuYy0Ji/LYX6EnDPWWgTTJGj2PBcfliEO
         mUWh+oz/KyW4nCwNF/kUwIDmnOhqAmsY43eO06+1T56BElDAdDbrsLzHtu/HEDZbq9oT
         8tvMiX4wBNhU9WWCH/deGGl6cZbPygYAw8THnHbip2sSweWxYvq+4OjcillgTUMmaCXO
         DmQ1J48mKA+r+ebTzbVMMbX/sCT+OnqDdwhHAqlgsWfSSKPE5PiqA3zvJNttZK0crhcG
         FKmMke5ROxegQTmRxp4Lkfw8S+HLoXkLWv46f4tXlmU1RU+d6FYcwYgJf85DLkFi59dC
         lAsg==
X-Forwarded-Encrypted: i=1; AJvYcCXvrMJHXd4Qx6kgqlWp0d74PVPUeLkpP8Fwq2KmKkIxrDbNeg0BatyJoPLGoPiXWmPJShJMUDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3RX3+724Xe2O6mSez3oZHuZWz9cd4fDE6YTLZkzMFpMpHdBq
	1wRlgtIWfjdXPHqXETmYA6Kuw0+BcmwLoOM2QjsFVTyoR5/qGUrbzHiUBU6uN0d7+SRgvhB/KAk
	L2B5myTSogkG9SnF2B5rA7H8LFc3kFedLa4/1d8Gc
X-Gm-Gg: ASbGncuRCU/vWffxjh0KHSWiesZUYqzDJrtXs56HL5W/ZHn58unnmXeSzDWW7L/7p1P
	oBqsea6fJ3Lq9SAPxs09TcIjB9ecDFVdTS5d/a8B6Y/HzivJWPGjyHWzjZpRrYMuKrjsU2bI20M
	PYCyHY/Xod439Nmc8VdQlhCfObAOszMaqvMSl9Z9vFnrpkQP8HXUCHfnMoNH6w90RHxKn/CuZQB
	8jwr53N5BpMHOsSATwDE0lF3U9Ee0kBEr4I6p5boSlrI5fz3AG847qDoK6dL0/W95MqSEYkUysW
	MVEO+qcodgB5/qSRPWSiEDDv4d8kXD0ni7yKMRk=
X-Google-Smtp-Source: AGHT+IGMmJ8ouhAIMZAJXRkjFRLZOITnIkEMsaUd5VVUnAP+UFwJfGOvukcYd8hm3/pqu4kIxKyFuvd5YlxymB2fu58=
X-Received: by 2002:a17:903:18b:b0:296:4d61:6cdb with SMTP id
 d9443c01a7336-2984eda429dmr20194155ad.27.1762916579092; Tue, 11 Nov 2025
 19:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230210.3115355-1-kuni1840@gmail.com> <20250702230210.3115355-8-kuni1840@gmail.com>
 <94edb069a793c63a455ef129658f2832460f104f.camel@siemens.com>
In-Reply-To: <94edb069a793c63a455ef129658f2832460f104f.camel@siemens.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Nov 2025 19:02:47 -0800
X-Gm-Features: AWmQ_bmQS3Kjs6mmWArK9Uk9JJyGOxamhsvoJ9kSy3BZ9pyTVfdyB2zc-7aWotg
Message-ID: <CAAVpQUDxNL7uQWmJLyy3FLJoTa53N3zam2CqxZc-5CGkVhxVbg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "edumazet@google.com" <edumazet@google.com>, "kuni1840@gmail.com" <kuni1840@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:44=E2=80=AFAM Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hello Kuniyuki,
>
> On Wed, 2025-07-02 at 16:01 -0700, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > In __ipv6_sock_mc_drop(), per-socket mld data is protected by lock_sock=
(),
> > and only __dev_get_by_index() and __in6_dev_get() require RTNL.
> >
> > Let's use dev_get_by_index() and in6_dev_get() and drop RTNL for
> > IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
> >
> > Note that __ipv6_sock_mc_drop() is factorised to reuse in the next patc=
h.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv6/ipv6_sockglue.c |  2 --
> >  net/ipv6/mcast.c         | 47 +++++++++++++++++++++++-----------------
> >  2 files changed, 27 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> > index cb0dc885cbe4..c8892d54821f 100644
> > --- a/net/ipv6/ipv6_sockglue.c
> > +++ b/net/ipv6/ipv6_sockglue.c
> > @@ -121,10 +121,8 @@ static bool setsockopt_needs_rtnl(int optname)
> >  {
> >       switch (optname) {
> >       case IPV6_ADDRFORM:
> > -     case IPV6_DROP_MEMBERSHIP:
> >       case IPV6_JOIN_ANYCAST:
> >       case IPV6_LEAVE_ANYCAST:
> > -     case MCAST_LEAVE_GROUP:
> >       case MCAST_JOIN_SOURCE_GROUP:
> >       case MCAST_LEAVE_SOURCE_GROUP:
> >       case MCAST_BLOCK_SOURCE:
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index d55c1cb4189a..ed40f5b132ae 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -253,14 +253,36 @@ int ipv6_sock_mc_join_ssm(struct sock *sk, int if=
index,
> >  /*
> >   *   socket leave on multicast group
> >   */
> > +static void __ipv6_sock_mc_drop(struct sock *sk, struct ipv6_mc_sockli=
st *mc_lst)
> > +{
> > +     struct net *net =3D sock_net(sk);
> > +     struct net_device *dev;
> > +
> > +     dev =3D dev_get_by_index(net, mc_lst->ifindex);
> > +     if (dev) {
> > +             struct inet6_dev *idev =3D in6_dev_get(dev);
> > +
> > +             ip6_mc_leave_src(sk, mc_lst, idev);
> > +
> > +             if (idev) {
> > +                     __ipv6_dev_mc_dec(idev, &mc_lst->addr);
> > +                     in6_dev_put(idev);
> > +             }
> > +
> > +             dev_put(dev);
> > +     } else {
> > +             ip6_mc_leave_src(sk, mc_lst, NULL);
> > +     }
> > +
> > +     atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
> > +     kfree_rcu(mc_lst, rcu);
> > +}
> > +
> >  int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_a=
ddr *addr)
> >  {
> >       struct ipv6_pinfo *np =3D inet6_sk(sk);
> > -     struct ipv6_mc_socklist *mc_lst;
> >       struct ipv6_mc_socklist __rcu **lnk;
> > -     struct net *net =3D sock_net(sk);
> > -
> > -     ASSERT_RTNL();
> > +     struct ipv6_mc_socklist *mc_lst;
> >
> >       if (!ipv6_addr_is_multicast(addr))
> >               return -EINVAL;
> > @@ -270,23 +292,8 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex=
, const struct in6_addr *addr)
> >             lnk =3D &mc_lst->next) {
> >               if ((ifindex =3D=3D 0 || mc_lst->ifindex =3D=3D ifindex) =
&&
> >                   ipv6_addr_equal(&mc_lst->addr, addr)) {
> > -                     struct net_device *dev;
> > -
> >                       *lnk =3D mc_lst->next;
> > -
> > -                     dev =3D __dev_get_by_index(net, mc_lst->ifindex);
> > -                     if (dev) {
> > -                             struct inet6_dev *idev =3D __in6_dev_get(=
dev);
> > -
> > -                             ip6_mc_leave_src(sk, mc_lst, idev);
> > -                             if (idev)
> > -                                     __ipv6_dev_mc_dec(idev, &mc_lst->=
addr);
> > -                     } else {
> > -                             ip6_mc_leave_src(sk, mc_lst, NULL);
> > -                     }
> > -
> > -                     atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
> > -                     kfree_rcu(mc_lst, rcu);
> > +                     __ipv6_sock_mc_drop(sk, mc_lst);
> >                       return 0;
> >               }
> >       }
>
> I'm getting the below stack, though unreliably, during
> kernel-selftest/drivers/net/dsa/local_termination.sh runs with different =
new-next
> revisions based on v6.18-rcX:
>
> RTNL: assertion failed at git/net/core/dev.c (9477)
> WARNING: CPU: 1 PID: 527 at git/net/core/dev.c:9477 __dev_set_promiscuity=
+0x1d0/0x1e0
> pc : __dev_set_promiscuity+0x1d0/0x1e0
> Call trace:
>  __dev_set_promiscuity+0x1d0/0x1e0 (P)
>  __dev_set_rx_mode+0xf8/0x118
>  igmp6_group_dropped+0x1e8/0x618
>  __ipv6_dev_mc_dec+0x164/0x1d0
>  ipv6_sock_mc_drop+0x1ac/0x1e0
>  do_ipv6_setsockopt+0x1990/0x1e58
>  ipv6_setsockopt+0x74/0x100
>  udpv6_setsockopt+0x28/0x58
>  sock_common_setsockopt+0x7c/0xa0
>  do_sock_setsockopt+0xf8/0x250
>  __sys_setsockopt+0xa8/0x130
>  __arm64_sys_setsockopt+0x70/0x98
>  invoke_syscall+0x68/0x190
>  el0_svc_common.constprop.0+0x11c/0x150
>  do_el0_svc+0x38/0x50
>  el0_svc+0x4c/0x1e8
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x198/0x1a0
> irq event stamp: 138641
> hardirqs last  enabled at (138640): [<ffff80008013da14>] __up_console_sem=
+0x74/0x90
> hardirqs last disabled at (138641): [<ffff800081823ee8>] el1_brk64+0x20/0=
x58
> softirqs last  enabled at (138610): [<ffff800081144814>] lock_sock_nested=
+0x8c/0xb8
>

Thanks for the report!

> Do you have an idea what could be forgotten in the Subject patch?
>
> Do we need to drop ASSERT_RTNL() from __dev_set_promiscuity() now, or am =
I
> too naive?

hmm.. ASSERT_RTNL() is still needed there given not all callers
hold netdev_lock() and ndo_change_rx_flags() could nest the call.

But let me think if we can do something better than reverting it.

