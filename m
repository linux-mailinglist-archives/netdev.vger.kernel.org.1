Return-Path: <netdev+bounces-177408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF7A701B9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926938435C2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E482561B8;
	Tue, 25 Mar 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTeY/fKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10E1B85FD
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906718; cv=none; b=it2Pq8sfNVf2Q4dSjl0e0pODrB0RaMYV12aVA/uyH+POk0rviWak018s73LKpvWBtTbiDIkvqrGWjD16VoI7rHXpJXlRJTLTJ77auY4CwIFqHh9zLQgQhv+jUTKkVjLFCbCTaVgSeJ20y2SmmrCYzHg1SA4hG8okrv94zDL0T/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906718; c=relaxed/simple;
	bh=NN02N6asQkYeBlkkksJ/Ia5m+BtavsC4k0b09j+gVvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF6vBHLZce96S1odqpQobmU5wDW6eMw7Ucb1IMeRk6LcGrBM4kwDEry3ByP0DO5jNA8EpEefgFGg7UDPoPE/C6otzKSgBign+TUwbtRYbGwL7DeeP+AXbhOudlNKcKR8+9iob7ZPJdbp51qMz12/7wF6iCX0ShHpHa5vqIyXEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTeY/fKP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2254e0b4b79so99625795ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742906716; x=1743511516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oq1KQxakHtw9QfxsNgkvYskaVtpW+r5EAspecU9bLk=;
        b=TTeY/fKPyJkTtPuzzLRLY3X5OpueqvEmBk2mVgjZKcJK1t2peyPBfJsddwuCVVwVIG
         Zombmz2wPIbbsTOjo7PWps6vfj0tQ0ijJRabB5fjyaNzGQ1ytCmIhx4mbXBzU8+3FkKf
         nYcOmNNKKU3VkZFnbmSB++3v0m9XQfa9V/6BjErtXVUdejxLLvD1shOz8YCqfQgRW2ZC
         Ixfxza77Suotc2xcKUYa+DAdZBzKJSq2NCT1jcxOj6cCicZCVofKbm7TdA0tOdIcxTSP
         ED9v1wFzCN6VazuHLX0p/NCAX+l4ifRn8CHpnOG/foM/bYVDCICwhf9AvegtS/UaZuhz
         PGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742906716; x=1743511516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oq1KQxakHtw9QfxsNgkvYskaVtpW+r5EAspecU9bLk=;
        b=faddDgOcl3mCgcSIRVTUZbGcLTB3IGZ1IkaHxLlYMI2e0LtCV09JrGVhThB9zUX6mY
         y+a4btP4wrc9On8xcURf+2fIAFCouRTX/J4jJMuUuXRCHKyEjBW88QjZIQ87Olwcx99w
         mgoVUpY/EdFfxnrZDGa2PSKA2MRWkLy+ibU+5GBCT0L4vZb8U/qZCv5Z9994R2WXjYVE
         qXxtg21N0uYbH5LiQWQyoiZjQxNQFtZoFghRNtAfVZYtXNHY5u8n8Gqdeihq3cFJL/PN
         vORfjHHMiCCI+fkM+sPlKak2oFfuxNr1YsRPqhjUzTRdtZg6ZkiUZP770AY6Vo1CFCbh
         aq3g==
X-Gm-Message-State: AOJu0YxlSLROcNK+d3fZxRmezo5It2f8ckXEBovE7YC74JRquBcMMELp
	4Uyz/vXW78HmIumx/Usw7+hJWITBI0Ua0Kfodu9hHsu96Ch88u4=
X-Gm-Gg: ASbGncstmFKmIzZw7j1IJ5FDG97vG7LbfQWrYRHOdZsDIZerQ7X3kt48uAeQPD5DFXo
	PCJc1K/yV/SkenTA+IlJ68wFtGCN4WpBs5yDD8zRw5RpSIMZYscg0mYBbLm9ybVZKsnb5O+/BCc
	+YpNcPNrbAvYlbnyOOLten9I37STBtW0w1wJy4eJ4JXyUt07G4jBl0W5nkWDIo9jHyayTDf95MF
	iVO+FdKMK2srNpTHqBfg7V9fJJt2QgnIXZ8v2VEoY3KF2r5TplAh8yz4wWbuda9GlBDUsR8Dyc2
	Aj/yV09xLqGUoXmUzk8Tx5JnZUiy4GKoroyDONK8vVMk
X-Google-Smtp-Source: AGHT+IFukYllTn79g7HmCD3pbIn8jPYr4kpOVFL3v3pNSjOL2KUzfJHkSIw0KMsmkVnWlzSGWtr/jg==
X-Received: by 2002:a05:6a21:99a0:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-1fe434518a2mr31991993637.37.1742906715435;
        Tue, 25 Mar 2025 05:45:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390600bbdbsm9986719b3a.80.2025.03.25.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:45:14 -0700 (PDT)
Date: Tue, 25 Mar 2025 05:45:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Report deadlock in the latest net-next
Message-ID: <Z-KlWveR9lS-RZlE@mini-arch>
References: <CAMArcTX2dEs=H586fumSEv_V8_p-pcAjyyPXkcLG9WkQM+c0cA@mail.gmail.com>
 <Z-GPFQou5GomWCOo@mini-arch>
 <CAMArcTW+5Lk0EWCaHOsUhf+p31S8yAZyQvi3C8zeRF3TxnC9Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMArcTW+5Lk0EWCaHOsUhf+p31S8yAZyQvi3C8zeRF3TxnC9Fg@mail.gmail.com>

On 03/25, Taehee Yoo wrote:
> On Tue, Mar 25, 2025 at 1:57 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> 
> Hi Stanislav,
> Thanks a lot for your reply.
> 
> > On 03/17, Taehee Yoo wrote:
> > > Hi Stanislav,
> > > I found a deadlock in the latest net-next kernel.
> > > The calltrace indicates your current
> > > commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations").
> > > The dev->lock was acquired in do_setlink.constprop.0+0x12a/0x3440,
> > > which is net/core/rtnetlink.c:3025
> > > And then dev->lock is acquired in dev_disable_lro+0x81/0x1f0,
> > > which is /net/core/dev_api.c:255
> > > dev_disable_lro() is called by netdev notification, but notification
> > > seems to be called both outside and inside dev->lock context.
> > > This case is that netdev notification is called inside dev->lock context.
> > > So deadlock occurs.
> > > Could you please look into this?
> > >
> > > Reproducer:
> > > modprobe netdevsim
> > > ip netns add ns_test
> > > echo 1 > /sys/bus/netdevsim/new_device
> > > ip link set $interface netns ns_test
> > >
> > > ============================================
> > > WARNING: possible recursive locking detected
> > > 6.14.0-rc6+ #56 Not tainted
> > > --------------------------------------------
> > > ip/1672 is trying to acquire lock:
> > > ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at: dev_disable_lro+0x81/0x1f0
> > >
> > > but task is already holding lock:
> > > ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> > > do_setlink.constprop.0+0x12a/0x3440
> > >
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0
> > >        ----
> > >   lock(&dev->lock);
> > >   lock(&dev->lock);
> > >
> > >  *** DEADLOCK ***
> > >
> > >  May be due to missing lock nesting notation
> > >
> > > 3 locks held by ip/1672:
> > >  #0: ffffffff943ba050 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c60
> > >  #1: ffff88813abc6170 (&net->rtnl_mutex){+.+.}-{4:4}, at:
> > > rtnl_newlink+0x6f6/0x1c60
> > >  #2: ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
> > > do_setlink.constprop.0+0x12a/0x3440
> > >
> > > stack backtrace:
> > > CPU: 2 UID: 0 PID: 1672 Comm: ip Not tainted 6.14.0-rc6+ #56
> > > 66129e0c5b1b922fef38623168aea99c0593a519
> > > Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x7e/0xc0
> > >  print_deadlock_bug+0x4fd/0x8e0
> > >  __lock_acquire+0x3082/0x4fd0
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  ? mark_lock.part.0+0xfa/0x2f60
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  ? check_chain_key+0x1c1/0x520
> > >  lock_acquire+0x1b0/0x570
> > >  ? dev_disable_lro+0x81/0x1f0
> > >  ? __pfx_lock_acquire+0x10/0x10
> > >  __mutex_lock+0x17c/0x17c0
> > >  ? dev_disable_lro+0x81/0x1f0
> > >  ? dev_disable_lro+0x81/0x1f0
> > >  ? __pfx___mutex_lock+0x10/0x10
> > >  ? mark_held_locks+0xa5/0xf0
> > >  ? neigh_parms_alloc+0x36b/0x4f0
> > >  ? __local_bh_enable_ip+0xa5/0x120
> > >  ? lockdep_hardirqs_on+0xbe/0x140
> > >  ? dev_disable_lro+0x81/0x1f0
> > >  dev_disable_lro+0x81/0x1f0
> > >  inetdev_init+0x2d1/0x4a0
> > >  inetdev_event+0x9b3/0x1590
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? __pfx_inetdev_event+0x10/0x10
> > >  ? notifier_call_chain+0x9b/0x300
> > >  notifier_call_chain+0x9b/0x300
> > >  netif_change_net_namespace+0xdfe/0x1390
> > >  ? __pfx_netif_change_net_namespace+0x10/0x10
> > >  ? __pfx_validate_linkmsg+0x10/0x10
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  do_setlink.constprop.0+0x241/0x3440
> > >  ? lock_acquire+0x1b0/0x570
> > >  ? __pfx_do_setlink.constprop.0+0x10/0x10
> > >  ? rtnl_newlink+0x6f6/0x1c60
> > >  ? __pfx_lock_acquired+0x10/0x10
> > >  ? netlink_sendmsg+0x712/0xbc0
> > >  ? rcu_is_watching+0x11/0xb0
> > >  ? trace_contention_end+0xef/0x140
> > >  ? __mutex_lock+0x935/0x17c0
> > >  ? __create_object+0x36/0x90
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? rtnl_newlink+0x6f6/0x1c60
> > >  ? __nla_validate_parse+0xb9/0x2830
> > >  ? __pfx___mutex_lock+0x10/0x10
> > >  ? lockdep_hardirqs_on+0xbe/0x140
> > >  ? __pfx___nla_validate_parse+0x10/0x10
> > >  ? rcu_is_watching+0x11/0xb0
> > >  ? cap_capable+0x17d/0x360
> > >  ? fdget+0x4e/0x1d0
> > >  rtnl_newlink+0x108d/0x1c60
> > >  ? __pfx_rtnl_newlink+0x10/0x10
> > >  ? mark_lock.part.0+0xfa/0x2f60
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  ? __pfx_mark_lock.part.0+0x10/0x10
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? __pfx_rtnl_newlink+0x10/0x10
> > >  rtnetlink_rcv_msg+0x71c/0xc10
> > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > >  ? check_chain_key+0x1c1/0x520
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  netlink_rcv_skb+0x12c/0x360
> > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > >  ? __pfx_netlink_rcv_skb+0x10/0x10
> > >  ? netlink_deliver_tap+0xcb/0x9e0
> > >  ? netlink_deliver_tap+0x14b/0x9e0
> > >  netlink_unicast+0x447/0x710
> > >  ? __pfx_netlink_unicast+0x10/0x10
> > >  netlink_sendmsg+0x712/0xbc0
> > >  ? __pfx_netlink_sendmsg+0x10/0x10
> > >  ? _copy_from_user+0x3e/0xa0
> > >  ____sys_sendmsg+0x7ab/0xa10
> > >  ? __pfx_____sys_sendmsg+0x10/0x10
> > >  ? __pfx_copy_msghdr_from_user+0x10/0x10
> > >  ___sys_sendmsg+0xee/0x170
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  ? kasan_save_stack+0x20/0x40
> > >  ? __pfx____sys_sendmsg+0x10/0x10
> > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >  ? kasan_save_stack+0x30/0x40
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? __might_fault+0xbf/0x170
> > >  __sys_sendmsg+0x105/0x190
> > >  ? __pfx___sys_sendmsg+0x10/0x10
> > >  ? rseq_syscall+0xc3/0x130
> > >  do_syscall_64+0x64/0x140
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7fd20f92c004
> > > Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00
> > > 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d
> > > 005
> > > RSP: 002b:00007fff40636e68 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd20f92c004
> > > RDX: 0000000000000000 RSI: 00007fff40636ee0 RDI: 0000000000000003
> > > RBP: 00007fff40636f50 R08: 0000000067d7b7e9 R09: 0000000000000050
> > > R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000003
> > > R13: 0000000067d7b7ea R14: 000055d14b9e4040 R15: 0000000000000000
> > >
> > > Thanks a lot!
> > > Taehee Yoo
> >
> > Sorry, I completely missed that, I think this is similar to:
> >
> > https://lore.kernel.org/netdev/Z-GDBlDsnPyc21RM@mini-arch/T/#u
> >
> > ?
> >
> > Can you give it a quick test with the patches from that link?
> 
> I applied two changes [1] and [2].
> The aboje case seems to be fixed.
> But I found a new splat when netdevsim interface was created,
> which was already reported from that link.

Thanks for testing! Yeah, I'm still looking into it. I ended up
adding ops lock around NETDEV_REGISTER and NETDEV_UP, but I
think something is still not right.

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1448 at ./include/net/netdev_lock.h:54
> __netdev_update_features+0x894/0x1550
> Modules linked in: netdevsim veth xt_nat xt_tcpudp xt_conntrack
> nft_chain_nat xt_MASQUERADE nf_cos
> CPU: 1 UID: 0 PID: 1448 Comm: bash Not tainted 6.14.0-rc7+ #74
> 0e3a9c04b78c7bd4fd13f140e1c89a83e53
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603
> 11/01/2021
> RIP: 0010:__netdev_update_features+0x894/0x1550
> Code: ff 0f 1f 44 00 00 48 f7 d0 49 21 c4 e9 4d fa ff ff 48 8d bd 90
> 0d 00 00 be ff ff ff ff e8 e0
> RSP: 0018:ffff88825cc3f230 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8881e1f72000 RCX: 0000000000000001
> RDX: 0000000000000006 RSI: ffffffff90ac4960 RDI: ffffffff90d73280
> RBP: ffff8881e1f72000 R08: 0000000000000000 R09: fffffbfff327743c
> R10: 0000000000000001 R11: 0000000000000001 R12: ffff88815ad84000
> R13: ffff88815ad84168 R14: 0000000000000005 R15: 1ffff1104b987e6c
> FS:  00007f64f7c8a740(0000) GS:ffff88881b200000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffdaa5c07c8 CR3: 00000001e1af0000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __warn+0xcd/0x2f0
>  ? __netdev_update_features+0x894/0x1550
>  ? report_bug+0x326/0x3c0
>  ? handle_bug+0x53/0xa0
>  ? exc_invalid_op+0x14/0x50
>  ? asm_exc_invalid_op+0x16/0x20
>  ? __netdev_update_features+0x894/0x1550
>  ? check_chain_key+0x1c1/0x520
>  ? __pfx___netdev_update_features+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  netif_disable_lro+0x90/0x520
>  ? __pfx_netif_disable_lro+0x10/0x10
>  ? lockdep_hardirqs_on+0xbe/0x140
>  ? neigh_parms_alloc+0x36b/0x4f0
>  ? __local_bh_enable_ip+0xa5/0x120
>  ? neigh_parms_alloc+0x36b/0x4f0
>  inetdev_init+0x2d1/0x4a0
>  inetdev_event+0x9b3/0x1590
>  ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
> 56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
>  ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
> 56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
>  ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
> 56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
>  ? __pfx_nsim_dev_netdevice_event+0x10/0x10 [netdevsim
> 56c6fb92f9ab7ad97a5f7886b4a8c456dda09181]
>  ? __module_address.part.0+0x6a/0x220
>  ? __pfx_inetdev_event+0x10/0x10
>  ? notifier_call_chain+0x9b/0x300
> 
> But I found a new deadlock.
> Reproducer:
>    modprobe netdevsim
>    ip netns add ns_test
>    echo 1 > /sys/bus/netdevsim/new_device
>    ip link add bond0 type bond
>    ip link set $interface master bond0
>    ip link set $interface netns ns_test
> 
> Splat:
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-rc7+ #74 Tainted: G        W
> --------------------------------------------
> ip/1876 is trying to acquire lock:
> ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at: dev_close+0x81/0x1f0
> 
> but task is already holding lock:
> ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at:
> do_setlink.constprop.0+0x12a/0x3410
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock);
>   lock(&dev->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by ip/1876:
>  #0: ffffffff993ba250 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c60
>  #1: ffff88816736e230 (&net->rtnl_mutex){+.+.}-{4:4}, at:
> rtnl_newlink+0x6f6/0x1c60
>  #2: ffff8881e1f72d90 (&dev->lock){+.+.}-{4:4}, at:
> do_setlink.constprop.0+0x12a/0x3410
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 1876 Comm: ip Tainted: G        W
> 6.14.0-rc7+ #74 0e3a9c04b78c7bd4fd13
> Tainted: [W]=WARN
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7e/0xc0
>  print_deadlock_bug+0x4fd/0x8e0
>  __lock_acquire+0x3082/0x4fd0
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  lock_acquire+0x1b0/0x570
>  ? dev_close+0x81/0x1f0
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __pfx_lock_acquire+0x10/0x10
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  __mutex_lock+0x17c/0x17c0
>  ? dev_close+0x81/0x1f0
>  ? dev_close+0x81/0x1f0
>  ? __pfx_netdev_change_features+0x10/0x10
>  ? __pfx___mutex_lock+0x10/0x10
>  ? __module_text_address+0x36/0x170
>  ? preempt_count_add+0x7d/0x150
>  ? ip6_route_dev_notify+0x37/0x670
>  ? notifier_call_chain+0x9b/0x300
>  ? dev_close+0x81/0x1f0
>  dev_close+0x81/0x1f0
>  __bond_release_one+0x888/0x1610 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __mutex_lock+0x935/0x17c0
>  ? nf_tables_flowtable_event+0x97/0x480 [nf_tables
> 1445783a301bcd3ec7ca4a0703efdcd50d4aca3a]
>  ? __pfx___bond_release_one+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? nft_offload_netdev_event+0xce/0x3a0 [nf_tables
> 1445783a301bcd3ec7ca4a0703efdcd50d4aca3a]
>  ? __mutex_unlock_slowpath+0x15d/0x650
>  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __pfx_bond_netdev_event+0x10/0x10 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  ? __module_address.part.0+0x6a/0x220
>  bond_netdev_event+0x91b/0xab0 [bonding
> b66920a8cbfc9c0d4b32a75d6048c0ac5533c0d4]
>  notifier_call_chain+0x9b/0x300
>  netif_change_net_namespace+0x43f/0x1390
>  ? __pfx_netif_change_net_namespace+0x10/0x10
>  ? __pfx_validate_linkmsg+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  do_setlink.constprop.0+0x241/0x3410
> 
> Reproducer2:
>    modprobe netdevsim
>    ip netns add ns_test
>    echo 1 > /sys/bus/netdevsim/new_device
>    ip link add team0 type team
>    ip link set $interface master team0
>    ip link set $interface netns ns_test
> 
> Splat:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.14.0-rc7+ #74 Tainted: G        W
> ------------------------------------------------------
> ip/2036 is trying to acquire lock:
> ffff88812fccae88 (team->team_lock_key){+.+.}-{4:4}, at:
> team_device_event+0x101/0x690 [team]
> 
> but task is already holding lock:
> ffff8881947a2d90 (&dev->lock){+.+.}-{4:4}, at:
> do_setlink.constprop.0+0x12a/0x3410
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&dev->lock){+.+.}-{4:4}:
>        lock_acquire+0x1b0/0x570
>        __mutex_lock+0x17c/0x17c0
>        dev_set_mtu+0x86/0x210
>        team_add_slave+0x802/0x1e00 [team]
>        do_set_master+0x363/0x6d0
>        do_setlink.constprop.0+0x86f/0x3410
>        rtnl_newlink+0x108d/0x1c60
>        rtnetlink_rcv_msg+0x71c/0xc10
>        netlink_rcv_skb+0x12c/0x360
>        netlink_unicast+0x447/0x710
>        netlink_sendmsg+0x712/0xbc0
>        ____sys_sendmsg+0x7ab/0xa10
>        ___sys_sendmsg+0xee/0x170
>        __sys_sendmsg+0x105/0x190
>        do_syscall_64+0x64/0x140
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> -> #0 (team->team_lock_key){+.+.}-{4:4}:
>        check_prev_add+0x1b7/0x2360
>        __lock_acquire+0x32ab/0x4fd0
>        lock_acquire+0x1b0/0x570
>        __mutex_lock+0x17c/0x17c0
>        team_device_event+0x101/0x690 [team]
>        notifier_call_chain+0x9b/0x300
>        dev_close_many+0x2c4/0x5a0
>        netif_close+0x147/0x1e0
>        netif_change_net_namespace+0x3a9/0x1390
>        do_setlink.constprop.0+0x241/0x3410
>        rtnl_newlink+0x108d/0x1c60
>        rtnetlink_rcv_msg+0x71c/0xc10
>        netlink_rcv_skb+0x12c/0x360
>        netlink_unicast+0x447/0x710
>        netlink_sendmsg+0x712/0xbc0
>        ____sys_sendmsg+0x7ab/0xa10
>        ___sys_sendmsg+0xee/0x170
>        __sys_sendmsg+0x105/0x190
>        do_syscall_64+0x64/0x140
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is interesting, haven't seen this one. Looks lie team_device_event
NETDEV_DOWN which grabs team->lock.

