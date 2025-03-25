Return-Path: <netdev+bounces-177283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851EBA6E8EA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235551888B6C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 04:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65D149DE8;
	Tue, 25 Mar 2025 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1qs+pJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84145273FD
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877424; cv=none; b=gXaeYKzFv3uKiSxw6OW4GelK34Cfz/gQEHicnFyzUTTlAEsh00113sdtKS33wqtW9H8AGgbLUeAOB6PnN7y/c+On6TGXw1LoenE3vTq4YbeNjLGNm6fDyqbNtLnmr4wNBiwgb7ciPVuIPRc6/2fVK59NR7XvwV9dSLDgQZtMPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877424; c=relaxed/simple;
	bh=Vqm5C1zp0NfPFYG+L1Fw4So9JHNGQliU+ys+952w5uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLr3AIcX2PEoL8DzloNqdLgTyATHhC4Njked8UZOoMcHDn2nY9epY7sB+IU8087eYjckxMQY0fzwBqV4OifFm2zCLw3XwFfM8appVy1n71bIcSfamqRkyvgJjJkMFTstU/WOnFvG14vyrPPeR52fFDAnmUBAuxpA767oYhrJMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1qs+pJi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so10053288a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742877421; x=1743482221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyB6vlXYRtiE35eBHCuui6PEV3LAta9KQcJ2rrviAt8=;
        b=I1qs+pJiEicj1esShNuiXZeqFSZiN5vpGjT9xQXmFCpLMdP12nuhg3HvX5t8CPIz35
         NmQoO9Me83VGSkwxVSWGGVUKsJGyQY+fZ6OZrZmrq/5WlMyaol4/S8iaig4ymwOiAy/2
         vf834D8+g/4tIzSILaQU+JqD/IwcpBPiT0A+d3rk/aYGBqw0sTJvtAfVaGxIkq1Gf5H9
         VChuKK9fTq84EH9fY9ql1SEHheQfqFVYKhY9mCsO1ZswpkSxFaHr2F4Bl2d0Pmz28Ypo
         UK6LU7ojwiWJK7cUOVIs40TQprR3v5rHe9lGVs4bvJGoerxOFviC41IwdFXzW/4R5RnV
         EcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742877421; x=1743482221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyB6vlXYRtiE35eBHCuui6PEV3LAta9KQcJ2rrviAt8=;
        b=HPm9f4XqVImERcXr9zUebUpLs0lqQyibj1aee3BZEfAsy033mw7J+NP0R6NdwNKaYJ
         MPDjOC8gtVTOSF/TmBwqr5JYB3/9PSrSvzw6OUpT1rm6reQUUtmNra5rr9lv0odgf1pe
         lNo+DIah25j1O7FuV9b+MHrSiWxh0wWqrU8zsh/bgZMso58NVR8Gm/ns3r+XUMKKBi5p
         RPaVphjnIqmZr0hXgdFWKtDC+7vyid5xVLJrvzVuvPiSApBiz/WzUbWE/GQk1uQlS6+s
         aMGXEDyIjtOwAzW39npvZNYY28tq79f7PiBsib65S5seXLI8hzc2TtzeU95xDKieR0Hd
         sU0Q==
X-Gm-Message-State: AOJu0YxFmxzrzY/RpIsK7aNkkXzvnc8/Lpi5tB07BOBJcl6YpyVNKth0
	jYLtV2y9q/PgCB+8CaDKXhiDTqjnTfOE+G7A+zLWxc/TC+kj1ycw0MtiqrZjm73lw4SCT+cThZi
	7llgH57f+xjCgtKpYT3Kpqh+H5L0=
X-Gm-Gg: ASbGncu7Ey5JpQr8RAUILbmC11zO1BPN1CgRUYR1H9M2Fp+Yxmd+m2vGDIYRo4++cB1
	eE2dMBOm5zB6Uz7toEOPUhyvN9tzWfHJR+QownaxyJPtu7zQ98XLLcGu0PhRVSJiQrdI9se1v+u
	JShLZU2p1AQR+rUWb95BFK9I3/uSw=
X-Google-Smtp-Source: AGHT+IFWqqvvwMNFBI+DttC+bjK7ZJUcoJFxLdtCtuXWKvGE7UFgwAoUE4/zefRN5bZiK9V4i28/w2/RGzIXw4Kg4Hc=
X-Received: by 2002:a05:6402:2399:b0:5ec:c7e4:b6ee with SMTP id
 4fb4d7f45d1cf-5ecc7e4b72fmr3709979a12.27.1742877420316; Mon, 24 Mar 2025
 21:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTX2dEs=H586fumSEv_V8_p-pcAjyyPXkcLG9WkQM+c0cA@mail.gmail.com>
 <Z-GPFQou5GomWCOo@mini-arch>
In-Reply-To: <Z-GPFQou5GomWCOo@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 25 Mar 2025 13:36:48 +0900
X-Gm-Features: AQ5f1Jr7RSEzL4H5rimKZPMGlclDcUt22RXJOjNJxFJ8-lgvSmAEMnVIyWysMOo
Message-ID: <CAMArcTW+5Lk0EWCaHOsUhf+p31S8yAZyQvi3C8zeRF3TxnC9Fg@mail.gmail.com>
Subject: Re: Report deadlock in the latest net-next
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 1:57=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,
Thanks a lot for your reply.

> On 03/17, Taehee Yoo wrote:
> > Hi Stanislav,
> > I found a deadlock in the latest net-next kernel.
> > The calltrace indicates your current
> > commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs opera=
tions").
> > The dev->lock was acquired in do_setlink.constprop.0+0x12a/0x3440,
> > which is net/core/rtnetlink.c:3025
> > And then dev->lock is acquired in dev_disable_lro+0x81/0x1f0,
> > which is /net/core/dev_api.c:255
> > dev_disable_lro() is called by netdev notification, but notification
> > seems to be called both outside and inside dev->lock context.
> > This case is that netdev notification is called inside dev->lock contex=
t.
> > So deadlock occurs.
> > Could you please look into this?
> >
> > Reproducer:
> > modprobe netdevsim
> > ip netns add ns_test
> > echo 1 > /sys/bus/netdevsim/new_device
> > ip link set $interface netns ns_test
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.14.0-rc6+ #56 Not tainted
> > --------------------------------------------
> > ip/1672 is trying to acquire lock:
> > ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at: dev_disable_lro+0x81/0x1=
f0
> >
> > but task is already holding lock:
> > ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> > do_setlink.constprop.0+0x12a/0x3440
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&dev->lock);
> >   lock(&dev->lock);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 3 locks held by ip/1672:
> >  #0: ffffffff943ba050 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/=
0x1c60
> >  #1: ffff88813abc6170 (&net->rtnl_mutex){+.+.}-{4:4}, at:
> > rtnl_newlink+0x6f6/0x1c60
> >  #2: ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> > do_setlink.constprop.0+0x12a/0x3440
> >
> > stack backtrace:
> > CPU: 2 UID: 0 PID: 1672 Comm: ip Not tainted 6.14.0-rc6+ #56
> > 66129e0c5b1b922fef38623168aea99c0593a519
> > Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/0=
1/2021
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x7e/0xc0
> >  print_deadlock_bug+0x4fd/0x8e0
> >  __lock_acquire+0x3082/0x4fd0
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? mark_lock.part.0+0xfa/0x2f60
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? check_chain_key+0x1c1/0x520
> >  lock_acquire+0x1b0/0x570
> >  ? dev_disable_lro+0x81/0x1f0
> >  ? __pfx_lock_acquire+0x10/0x10
> >  __mutex_lock+0x17c/0x17c0
> >  ? dev_disable_lro+0x81/0x1f0
> >  ? dev_disable_lro+0x81/0x1f0
> >  ? __pfx___mutex_lock+0x10/0x10
> >  ? mark_held_locks+0xa5/0xf0
> >  ? neigh_parms_alloc+0x36b/0x4f0
> >  ? __local_bh_enable_ip+0xa5/0x120
> >  ? lockdep_hardirqs_on+0xbe/0x140
> >  ? dev_disable_lro+0x81/0x1f0
> >  dev_disable_lro+0x81/0x1f0
> >  inetdev_init+0x2d1/0x4a0
> >  inetdev_event+0x9b3/0x1590
> >  ? __pfx_lock_release+0x10/0x10
> >  ? __pfx_inetdev_event+0x10/0x10
> >  ? notifier_call_chain+0x9b/0x300
> >  notifier_call_chain+0x9b/0x300
> >  netif_change_net_namespace+0xdfe/0x1390
> >  ? __pfx_netif_change_net_namespace+0x10/0x10
> >  ? __pfx_validate_linkmsg+0x10/0x10
> >  ? __pfx___lock_acquire+0x10/0x10
> >  do_setlink.constprop.0+0x241/0x3440
> >  ? lock_acquire+0x1b0/0x570
> >  ? __pfx_do_setlink.constprop.0+0x10/0x10
> >  ? rtnl_newlink+0x6f6/0x1c60
> >  ? __pfx_lock_acquired+0x10/0x10
> >  ? netlink_sendmsg+0x712/0xbc0
> >  ? rcu_is_watching+0x11/0xb0
> >  ? trace_contention_end+0xef/0x140
> >  ? __mutex_lock+0x935/0x17c0
> >  ? __create_object+0x36/0x90
> >  ? __pfx_lock_release+0x10/0x10
> >  ? rtnl_newlink+0x6f6/0x1c60
> >  ? __nla_validate_parse+0xb9/0x2830
> >  ? __pfx___mutex_lock+0x10/0x10
> >  ? lockdep_hardirqs_on+0xbe/0x140
> >  ? __pfx___nla_validate_parse+0x10/0x10
> >  ? rcu_is_watching+0x11/0xb0
> >  ? cap_capable+0x17d/0x360
> >  ? fdget+0x4e/0x1d0
> >  rtnl_newlink+0x108d/0x1c60
> >  ? __pfx_rtnl_newlink+0x10/0x10
> >  ? mark_lock.part.0+0xfa/0x2f60
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? __pfx_mark_lock.part.0+0x10/0x10
> >  ? __pfx_lock_release+0x10/0x10
> >  ? __pfx_rtnl_newlink+0x10/0x10
> >  rtnetlink_rcv_msg+0x71c/0xc10
> >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> >  ? check_chain_key+0x1c1/0x520
> >  ? __pfx___lock_acquire+0x10/0x10
> >  netlink_rcv_skb+0x12c/0x360
> >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> >  ? __pfx_netlink_rcv_skb+0x10/0x10
> >  ? netlink_deliver_tap+0xcb/0x9e0
> >  ? netlink_deliver_tap+0x14b/0x9e0
> >  netlink_unicast+0x447/0x710
> >  ? __pfx_netlink_unicast+0x10/0x10
> >  netlink_sendmsg+0x712/0xbc0
> >  ? __pfx_netlink_sendmsg+0x10/0x10
> >  ? _copy_from_user+0x3e/0xa0
> >  ____sys_sendmsg+0x7ab/0xa10
> >  ? __pfx_____sys_sendmsg+0x10/0x10
> >  ? __pfx_copy_msghdr_from_user+0x10/0x10
> >  ___sys_sendmsg+0xee/0x170
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? kasan_save_stack+0x20/0x40
> >  ? __pfx____sys_sendmsg+0x10/0x10
> >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  ? kasan_save_stack+0x30/0x40
> >  ? __pfx_lock_release+0x10/0x10
> >  ? __might_fault+0xbf/0x170
> >  __sys_sendmsg+0x105/0x190
> >  ? __pfx___sys_sendmsg+0x10/0x10
> >  ? rseq_syscall+0xc3/0x130
> >  do_syscall_64+0x64/0x140
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7fd20f92c004
> > Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00
> > 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d
> > 005
> > RSP: 002b:00007fff40636e68 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd20f92c004
> > RDX: 0000000000000000 RSI: 00007fff40636ee0 RDI: 0000000000000003
> > RBP: 00007fff40636f50 R08: 0000000067d7b7e9 R09: 0000000000000050
> > R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000003
> > R13: 0000000067d7b7ea R14: 000055d14b9e4040 R15: 0000000000000000
> >
> > Thanks a lot!
> > Taehee Yoo
>
> Sorry, I completely missed that, I think this is similar to:
>
> https://lore.kernel.org/netdev/Z-GDBlDsnPyc21RM@mini-arch/T/#u
>
> ?
>
> Can you give it a quick test with the patches from that link?

I applied two changes [1] and [2].
The above case seems to be fixed.
But I found a new splat when netdevsim interface was created,
which was already reported from that link.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1448 at ./include/net/netdev_lock.h:54
__netdev_update_features+0x894/0x1550
Modules linked in: netdevsim veth xt_nat xt_tcpudp xt_conntrack
nft_chain_nat xt_MASQUERADE nf_cos
CPU: 1 UID: 0 PID: 1448 Comm: bash Not tainted 6.14.0-rc7+ #74
0e3a9c04b78c7bd4fd13f140e1c89a83e53
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603
11/01/2021
RIP: 0010:__netdev_update_features+0x894/0x1550
Code: ff 0f 1f 44 00 00 48 f7 d0 49 21 c4 e9 4d fa ff ff 48 8d bd 90
0d 00 00 be ff ff ff ff e8 e0
RSP: 0018:ffff88825cc3f230 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881e1f72000 RCX: 0000000000000001
RDX: 0000000000000006 RSI: ffffffff90ac4960 RDI: ffffffff90d73280
RBP: ffff8881e1f72000 R08: 0000000000000000 R09: fffffbfff327743c
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88815ad84000
R13: ffff88815ad84168 R14: 0000000000000005 R15: 1ffff1104b987e6c
FS:  00007f64f7c8a740(0000) GS:ffff88881b200000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdaa5c07c8 CR3: 00000001e1af0000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0xcd/0x2f0
 ? __netdev_update_features+0x894/0x1550
 ? report_bug+0x326/0x3c0
 ? handle_bug+0x53/0xa0
 ? exc_invalid_op+0x14/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __netdev_update_features+0x894/0x1550
 ? check_chain_key+0x1c1/0x520
 ? __pfx___netdev_update_features+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 netif_disable_lro+0x90/0x520
 ? __pfx_netif_disable_lro+0x10/0x10
 ? lockdep_hardirqs_on+0xbe/0x140
 ? neigh_parms_alloc+0x36b/0x4f0
 ? __local_bh_enable_ip+0xa5/0x120
 ? neigh_parms_alloc+0x36b/0x4f0
 inetdev_init+0x2d1/0x4a0
 inetdev_event+0x9b3/0x1590
 ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
 ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
 ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
 ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
 ? __module_address.part.0+0x6a/0x220
 ? __pfx_inetdev_event+0x10/0x10
 ? notifier_call_chain+0x9b/0x300

But I found a new deadlock.
Reproducer:
   modprobe netdevsim
   ip netns add ns_test
   echo 1 > /sys/bus/netdevsim/new_device
   ip link add bond0 type bond
   ip link set $interface master bond0
   ip link set $interface netns ns_test

Splat:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: possible recursive locking detected
6.14.0-rc7+ #74 Tainted: G        W
--------------------------------------------
ip/1876 is trying to acquire lock:
ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at: dev_close+0x81/0x1f0

but task is already holding lock:
ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3410

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by ip/1876:
 #0: ffffffff993ba250 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c=
60
 #1: ffff88816736e230 (&net->rtnl_mutex){+.+.}-{4:4}, at:
rtnl_newlink+0x6f6/0x1c60
 #2: ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3410

stack backtrace:
CPU: 1 UID: 0 PID: 1876 Comm: ip Tainted: G        W
6.14.0-rc7+ #74 0e3a9c04b78c7bd4fd13
Tainted: [W]=3DWARN
Call Trace:
 <TASK>
 dump_stack_lvl+0x7e/0xc0
 print_deadlock_bug+0x4fd/0x8e0
 __lock_acquire+0x3082/0x4fd0
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 lock_acquire+0x1b0/0x570
 ? dev_close+0x81/0x1f0
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 __mutex_lock+0x17c/0x17c0
 ? dev_close+0x81/0x1f0
 ? dev_close+0x81/0x1f0
 ? __pfx_netdev_change_features+0x10/0x10
 ? __pfx___mutex_lock+0x10/0x10
 ? __module_text_address+0x36/0x170
 ? preempt_count_add+0x7d/0x150
 ? ip6_route_dev_notify+0x37/0x670
 ? notifier_call_chain+0x9b/0x300
 ? dev_close+0x81/0x1f0
 dev_close+0x81/0x1f0
 __bond_release_one+0x888/0x1610 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __mutex_lock+0x935/0x17c0
 ? nf_tables_flowtable_event+0x97/0x480 [nf_tables
1445783a301bcd3ec7ca4a0703efdcd50d4aca3a]
 ? __pfx___bond_release_one+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? nft_offload_netdev_event+0xce/0x3a0 [nf_tables
1445783a301bcd3ec7ca4a0703efdcd50d4aca3a]
 ? __mutex_unlock_slowpath+0x15d/0x650
 ? __pfx___mutex_unlock_slowpath+0x10/0x10
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __pfx_bond_netdev_event+0x10/0x10 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 ? __module_address.part.0+0x6a/0x220
 bond_netdev_event+0x91b/0xab0 [bonding
b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
 notifier_call_chain+0x9b/0x300
 netif_change_net_namespace+0x43f/0x1390
 ? __pfx_netif_change_net_namespace+0x10/0x10
 ? __pfx_validate_linkmsg+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 do_setlink.constprop.0+0x241/0x3410

Reproducer2:
   modprobe netdevsim
   ip netns add ns_test
   echo 1 > /sys/bus/netdevsim/new_device
   ip link add team0 type team
   ip link set $interface master team0
   ip link set $interface netns ns_test

Splat:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.14.0-rc7+ #74 Tainted: G        W
------------------------------------------------------
ip/2036 is trying to acquire lock:
ffff88812fccae88 (team->team_lock_key){+.+.}-{4:4}, at:
team_device_event+0x101/0x690 [team]

but task is already holding lock:
ffff8881947a2d90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3410

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->lock){+.+.}-{4:4}:
       lock_acquire+0x1b0/0x570
       __mutex_lock+0x17c/0x17c0
       dev_set_mtu+0x86/0x210
       team_add_slave+0x802/0x1e00 [team]
       do_set_master+0x363/0x6d0
       do_setlink.constprop.0+0x86f/0x3410
       rtnl_newlink+0x108d/0x1c60
       rtnetlink_rcv_msg+0x71c/0xc10
       netlink_rcv_skb+0x12c/0x360
       netlink_unicast+0x447/0x710
       netlink_sendmsg+0x712/0xbc0
       ____sys_sendmsg+0x7ab/0xa10
       ___sys_sendmsg+0xee/0x170
       __sys_sendmsg+0x105/0x190
       do_syscall_64+0x64/0x140
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #0 (team->team_lock_key){+.+.}-{4:4}:
       check_prev_add+0x1b7/0x2360
       __lock_acquire+0x32ab/0x4fd0
       lock_acquire+0x1b0/0x570
       __mutex_lock+0x17c/0x17c0
       team_device_event+0x101/0x690 [team]
       notifier_call_chain+0x9b/0x300
       dev_close_many+0x2c4/0x5a0
       netif_close+0x147/0x1e0
       netif_change_net_namespace+0x3a9/0x1390
       do_setlink.constprop.0+0x241/0x3410
       rtnl_newlink+0x108d/0x1c60
       rtnetlink_rcv_msg+0x71c/0xc10
       netlink_rcv_skb+0x12c/0x360
       netlink_unicast+0x447/0x710
       netlink_sendmsg+0x712/0xbc0
       ____sys_sendmsg+0x7ab/0xa10
       ___sys_sendmsg+0xee/0x170
       __sys_sendmsg+0x105/0x190
       do_syscall_64+0x64/0x140
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev->lock);
                               lock(team->team_lock_key);
                               lock(&dev->lock);
  lock(team->team_lock_key);

 *** DEADLOCK ***

3 locks held by ip/2036:
 #0: ffffffffa33ba250 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c=
60
 #1: ffff888148db1fb0 (&net->rtnl_mutex){+.+.}-{4:4}, at:
rtnl_newlink+0x6f6/0x1c60
 #2: ffff8881947a2d90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3410

stack backtrace:
CPU: 3 UID: 0 PID: 2036 Comm: ip Tainted: G        W
6.14.0-rc7+ #74 0e3a9c04b78c7bd4fd13
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
 <TASK>
 dump_stack_lvl+0x7e/0xc0
 print_circular_bug+0x5bd/0x9b0
 check_noncircular+0x31b/0x400
 ? mark_lock.part.0+0xfa/0x2f60
 ? __pfx_check_noncircular+0x10/0x10
 ? __pfx_mark_lock.part.0+0x10/0x10
 ? __lock_acquire+0x16fa/0x4fd0
 check_prev_add+0x1b7/0x2360
 __lock_acquire+0x32ab/0x4fd0
 ? __pfx___lock_acquire+0x10/0x10
 ? try_to_wake_up+0xb9/0x1600
 ? __pfx_lock_release+0x10/0x10
 lock_acquire+0x1b0/0x570
 ? team_device_event+0x101/0x690 [team 101c85bbc03feb292be26fbaaf9cee585e69=
24fa]
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_mark_lock.part.0+0x10/0x10
 __mutex_lock+0x17c/0x17c0
 ? team_device_event+0x101/0x690 [team 101c85bbc03feb292be26fbaaf9cee585e69=
24fa]
 ? team_device_event+0x101/0x690 [team 101c85bbc03feb292be26fbaaf9cee585e69=
24fa]
 ? mark_held_locks+0xa5/0xf0
 ? __pfx___mutex_lock+0x10/0x10
 ? queue_work_on+0x63/0x90
 ? lockdep_hardirqs_on+0xbe/0x140
 ? __pfx_team_device_event+0x10/0x10 [team
101c85bbc03feb292be26fbaaf9cee585e6924fa]
 ? __pfx_team_device_event+0x10/0x10 [team
101c85bbc03feb292be26fbaaf9cee585e6924fa]
 ? __pfx_team_device_event+0x10/0x10 [team
101c85bbc03feb292be26fbaaf9cee585e6924fa]
 ? __pfx_team_device_event+0x10/0x10 [team
101c85bbc03feb292be26fbaaf9cee585e6924fa]
 ? team_device_event+0x101/0x690 [team 101c85bbc03feb292be26fbaaf9cee585e69=
24fa]
 team_device_event+0x101/0x690 [team 101c85bbc03feb292be26fbaaf9cee585e6924=
fa]
 notifier_call_chain+0x9b/0x300
 dev_close_many+0x2c4/0x5a0
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_dev_close_many+0x10/0x10
 netif_close+0x147/0x1e0
 ? __pfx_netif_close+0x10/0x10
 ? rcu_is_watching+0x11/0xb0
 netif_change_net_namespace+0x3a9/0x1390


[1] https://lore.kernel.org/netdev/Z-IrMQQ-mnQJzGyL@mini-arch/T/#t
[2]
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 754f60fb6e25..77e5705ac799 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct
net_device *dev)
        if (!in_dev->arp_parms)
                goto out_kfree;
        if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-               dev_disable_lro(dev);
+               netif_disable_lro(dev);
        /* Reference in_dev->dev */
        netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
        /* Account for reference dev->ip_ptr (below) */

