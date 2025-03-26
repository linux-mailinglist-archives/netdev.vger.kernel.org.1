Return-Path: <netdev+bounces-177856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B713A722EB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C13D17BAF3
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D11F8AC8;
	Wed, 26 Mar 2025 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tY8jfhrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DED1F239B
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027019; cv=none; b=AWKaXAxzSz/oalwZE4dbDGaGQvzBewBjQ9JNl8hY4uDLGEzSig8a20oqM9jFwTbsLRF88knZqgDkOpYcAABTpGYwOweVmoM5zOj89q2uyOO+B0h0z0OGvuinaXPrSRrg7uIt50oea/kfmdmUVY1TWH/tn52c5hTH9stsxNdLEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027019; c=relaxed/simple;
	bh=k1DKDNu8QxbPHNkkKfoUWl9kShfTFotuPY7CDWQG/QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ24YK2nTDiC8/xipKLWZqzZ3Ycy5FVPLIyWUpE18ah6NhxgpX0hGNDxtb4e9URIeHfYc+hjvRklnSp4RjIQ0fEbuU2Lf1fovM7rnPU1fYr2VZD/RJXH7e4VHe4W9ssoGcNbny9VZ3Wzo08p7J4jplDoQcv8g3SpsRMJ+TQp8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tY8jfhrG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c597760323so34442285a.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743027016; x=1743631816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gToGL/6qFaQSChSFK/cFOPfjP1C7HNr1QQiDuWgZCpE=;
        b=tY8jfhrGQHuRFBjOgRm2P+OfcW952tivtbclMjZdqydgZ9fGJKfA/gnOPaXBPXsonC
         kkU+Bdo8F0XGASMgac3XQQLRG2yqOFFksMvIwtVtf6ewbycPf8dbmEMKANqc/AMsDNI0
         Vv6s3tCpCTE1g77AIRU+KhCT1CYrojnTQfpOXpn6IKbQXxbNVTP/mo57ReVfRg3M99+H
         fLDoXN29MDirYjOKmspyFpiR1ho0YohTNsUht8H6KvnJEJ2yYCrwHx1plx8gWqJCi9yo
         LRtR/iGD9XWAx3CTVx5wuTXrETRdZnppD7aW1zovyUT5tAeFOeTbwuxMqtIKt7QbAwWG
         F3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743027016; x=1743631816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gToGL/6qFaQSChSFK/cFOPfjP1C7HNr1QQiDuWgZCpE=;
        b=Kon0qMtEuOkqprc/myCT1J/pcQZgo2VGPDo8HFCXZj2RHHlI3J24iKou2fqX/8Id0n
         Cul2xScnvNG+HTbufY6x1rLsbbjc1bpBzn+q6sEhj0PciXsldWCULvF4WnXeS4BFzxuw
         QRZvn7187athme3vBUecgHBvQE+uwPJgEFX6SjIC4xGkdHGDF2uAebSnctzBMxdOIovX
         jmeKg6XgbQwyOz9IGZopxKgW3cTk1fkIpcErqzAWg0nom/R5ggoSGE+gWVno3dNB2ufs
         8evSIwoQnbU41W81nsiyzXdyva30+gB3OqmjPWSI3ISCK+kGBPzrBEt9woFgSMuYcgE6
         ZWmA==
X-Forwarded-Encrypted: i=1; AJvYcCWq5sOTZkAHBy2VOTHdGJ2pbq4abMEcGEKHaNpmj2y0LTnHi9ybK48uOJdkg4At9giKTg6t5aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqM374Ulm3MKDQV4GoSwM+xWD9ymj6Vk+StfqZN/ka1fa1PFZt
	vaNjJ+cbnkwhxxFDEIigllt36Xpzc0gQJJ+J65dSODLczVdbaU+M/e1yR4bx9Oq0bMx6QiicbYq
	ErOpxAwfAQh+iAKYwlGd1jYHRIn25yNZChg6n
X-Gm-Gg: ASbGncv4DX+e27EiZjBKuBEFTG9na4W5WadWfuNqOUCGYHrPp/Cqm/3EAz06mH2YRfv
	Kt8soOlH2mZVnOL8b0lLNsGg4aNQ7eOd2HGwZ7wGPOffZIJshtXdMI5BKOXbqapih0dVkSdg7HO
	zGABeh+8GaQxdJvUxPLub9i1RS
X-Google-Smtp-Source: AGHT+IERCWvs+ixzEhWoC4dc6/6qbWVuJp+351cRiiSiUKOfVrqtFs3tp3622hNdPJGs4ZtvDd4OavVLBsrGOCv28UQ=
X-Received: by 2002:a05:622a:4183:b0:476:ff0d:ed6c with SMTP id
 d75a77b69052e-4776e1f4e4fmr22961511cf.40.1743027015704; Wed, 26 Mar 2025
 15:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97a94886-1252-4004-9a88-13430da1d25d@nvidia.com> <20250326215524.70372-1-kuniyu@amazon.com>
In-Reply-To: <20250326215524.70372-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Mar 2025 23:10:04 +0100
X-Gm-Features: AQ5f1Jpx6ddIQedKS2KvJK2boo4zAqF-Kyw2M3Mu3T2WusHv6HM9QZjGCcF09pQ
Message-ID: <CANn89iJt72meYXVex-K4JyQ-tR+J4bgHFR5PbcN7EYRGfcL5Tw@mail.gmail.com>
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ychemla@nvidia.com, davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Yael Chemla <ychemla@nvidia.com>
> Date: Wed, 26 Mar 2025 15:46:40 +0200
> > On 17/02/2025 21:11, Kuniyuki Iwashima wrote:
> > > After the cited commit, dev_net(dev) is fetched before holding RTNL
> > > and passed to __unregister_netdevice_notifier_net().
> > >
> > > However, dev_net(dev) might be different after holding RTNL.
> > >
> > > In the reported case [0], while removing a VF device, its netns was
> > > being dismantled and the VF was moved to init_net.
> > >
> > > So the following sequence is basically illegal when dev was fetched
> > > without lookup:
> > >
> > >   net =3D dev_net(dev);
> > >   rtnl_net_lock(net);
> > >
> > > Let's use a new helper rtnl_net_dev_lock() to fix the race.
> > >
> > > It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> > > dev_net_rcu(dev) is changed after rtnl_net_lock().
> > >
> > > [0]:
> > > BUG: KASAN: slab-use-after-free in notifier_call_chain (kernel/notifi=
er.c:75 (discriminator 2))
> > > Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0=
-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl (lib/dump_stack.c:123)
> > >  print_report (mm/kasan/report.c:379 mm/kasan/report.c:489)
> > >  kasan_report (mm/kasan/report.c:604)
> > >  notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
> > >  call_netdevice_notifiers_info (net/core/dev.c:2011)
> > >  unregister_netdevice_many_notify (net/core/dev.c:11551)
> > >  unregister_netdevice_queue (net/core/dev.c:11487)
> > >  unregister_netdev (net/core/dev.c:11635)
> > >  mlx5e_remove (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552=
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) mlx5_core
> > >  auxiliary_bus_remove (drivers/base/auxiliary.c:230)
> > >  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/=
dd.c:1296)
> > >  bus_remove_device (./include/linux/kobject.h:193 drivers/base/base.h=
:73 drivers/base/bus.c:583)
> > >  device_del (drivers/base/power/power.h:142 drivers/base/core.c:3855)
> > >  mlx5_rescan_drivers_locked (./include/linux/auxiliary_bus.h:241 driv=
ers/net/ethernet/mellanox/mlx5/core/dev.c:333 drivers/net/ethernet/mellanox=
/mlx5/core/dev.c:535 drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx=
5_core
> > >  mlx5_unregister_device (drivers/net/ethernet/mellanox/mlx5/core/dev.=
c:468) mlx5_core
> > >  mlx5_uninit_one (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 drivers/net/ethernet/mellanox/mlx=
5/core/main.c:1563) mlx5_core
> > >  remove_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:965 drive=
rs/net/ethernet/mellanox/mlx5/core/main.c:2019) mlx5_core
> > >  pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-=
driver.c:475)
> > >  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/=
dd.c:1296)
> > >  unbind_store (drivers/base/bus.c:245)
> > >  kernfs_fop_write_iter (fs/kernfs/file.c:338)
> > >  vfs_write (fs/read_write.c:587 (discriminator 1) fs/read_write.c:679=
 (discriminator 1))
> > >  ksys_write (fs/read_write.c:732)
> > >  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86=
/entry/common.c:83 (discriminator 1))
> > >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > RIP: 0033:0x7f6a4d5018b7
> > >
> > > Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netd=
evice_notifier_dev_net().")
> > > Reported-by: Yael Chemla <ychemla@nvidia.com>
> > > Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4=
c09bc3@nvidia.com/
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > > v5:
> > >   * Use do-while loop
> > >
> > > v4:
> > >   * Fix build failure when !CONFIG_NET_NS
> > >   * Use net_passive_dec()
> > >
> > > v3:
> > >   * Bump net->passive instead of maybe_get_net()
> > >   * Remove msleep(1) loop
> > >   * Use rcu_access_pointer() instead of rcu_read_lock().
> > >
> > > v2:
> > >   * Use dev_net_rcu().
> > >   * Use msleep(1) instead of cond_resched() after maybe_get_net()
> > >   * Remove cond_resched() after net_eq() check
> > >
> > > v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amaz=
on.com/
> > > ---
> > >  net/core/dev.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 44 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index b91658e8aedb..19e268568282 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -2070,6 +2070,42 @@ static void __move_netdevice_notifier_net(stru=
ct net *src_net,
> > >     __register_netdevice_notifier_net(dst_net, nb, true);
> > >  }
> > >
> > > +static void rtnl_net_dev_lock(struct net_device *dev)
> > > +{
> > > +   bool again;
> > > +
> > > +   do {
> > > +           struct net *net;
> > > +
> > > +           again =3D false;
> > > +
> > > +           /* netns might be being dismantled. */
> > > +           rcu_read_lock();
> > > +           net =3D dev_net_rcu(dev);
> > > +           net_passive_inc(net);
> >
> > Hi Kuniyuki,
> > It seems we are still encountering the previously reorted issue,
> > even when running with your latest fix. However, the problem has become
> > less frequent, now requiring multiple test iterations to reproduce.
>
> Thanks for reporting!
>
>
> >
> > 1) we identified the following warnings (each accompanied by a call
> > trace; only one is detailed below, though others are similar):
> >
> > refcount_t: addition on 0; use-after-free.
> > WARNING: CPU: 6 PID: 1105 at lib/refcount.c:25 refcount_warn_saturate
> > (/usr/work/linux/lib/refcount.c:25 (discriminator 1))
> >
> > and also
> >
> > refcount_t: underflow; use-after-free.
> > WARNING: CPU: 6 PID: 1105 at lib/refcount.c:28 refcount_warn_saturate
> > (/usr/work/linux/lib/refcount.c:28 (discriminator 1))
> >
> >
> > 2) test scenario:
> > sets up a network topology of two VFs on different eSwitch, performs
> > ping tests between them, verifies traffic rules offloading, and cleans
> > up the environment afterward.
> >
> > 3) the warning is triggered upon reaching the
> > unregister_netdevice_notifier_dev_net when both net->ns.count and
> > net->passive reference counts are zero.
>
> It looks unlikely but I missed there is still a race window.
>
> If dev_net_rcu() is called between synchronize_net() and dev_net_set()
> in netif_change_net_namespace(), there might be no synchronize_rcu()
> called after that and net_passive_dec() could be called in cleanup_net()
> earlier than net_passive_inc() ... ?
>
> Could you test this ?
>
> ---8<---
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index bd57d8fb54f1..c275e95c83ab 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -337,9 +337,9 @@ static inline void net_passive_dec(struct net *net)
>  }
>  #endif
>
> -static inline void net_passive_inc(struct net *net)
> +static inline bool net_passive_inc(struct net *net)
>  {
> -       refcount_inc(&net->passive);
> +       return refcount_inc_not_zero(&net->passive);

Hmm

We want the two oher net_passive_inc() callers to have refcount safety.

Please add a new net_passive_inc_not_zero()

