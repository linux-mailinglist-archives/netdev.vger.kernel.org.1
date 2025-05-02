Return-Path: <netdev+bounces-187354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2EAA6818
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5088C4C27F3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FEA288CC;
	Fri,  2 May 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MJOb83ju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BF8467;
	Fri,  2 May 2025 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147727; cv=none; b=YP8PSA3hWiDUXn+rSz7uB0NXltM8S7hsR+pgWD6Ng6tGD56V6dnppJp5o/FZb5d2esUaB6W1YMO/4HC3Oag0amqTmnc5DG9qqaD+hTZjmelmb13cO6uev74xu+jqlLHdCe8TdQ/QQRvUS6rq5Ev3mWqma6fuQs6fBP85G7vL6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147727; c=relaxed/simple;
	bh=ji+k25G5jd3SIK23i3pWtipkhk/OpeHQA1MKviK/Aek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg0WbheoJtCivTA0CdwqtENMeUmaHz/N/Dp476+SgPjvl+Xutl/gyRWKKXEvAT1QlanQ1TEz8bviD1yz1u0qLI/Iu5sgzLB1fQzG6OCBDqdm55SbibUik5LuKfI2c59XQCYXF69Wuzubr4R4+QuUA7hkoUfzUvFfZMLVvNtjLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MJOb83ju; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746147724; x=1777683724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TaUVVUO95nyPtOBLbyJdHhSqaf+rpL+F2ytJ5JvGvc=;
  b=MJOb83jubmDPGD1wjCKKfd8fT12lrkVG7lWST1Xu81EKUBwjL7nvc1ma
   nat2kkXCPN6eAf7DTMoYOpvV8LUOK0mXytFaw7zPr3PAThe25XZYmLcFo
   GoY6SYjaXQGq5jLLCl4JyDiSD3MOEzSkkCAoRVXeNoj5okQK5MWt9D+gU
   k=;
X-IronPort-AV: E=Sophos;i="6.15,255,1739836800"; 
   d="scan'208";a="89043623"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 01:02:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:50410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id be1308c9-07de-41b3-9b5c-1ef7f3a6ce98; Fri, 2 May 2025 01:01:59 +0000 (UTC)
X-Farcaster-Flow-ID: be1308c9-07de-41b3-9b5c-1ef7f3a6ce98
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 01:01:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 01:01:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+2d1f030088fa84f9d163@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in fib6_del (3)
Date: Thu, 1 May 2025 18:01:38 -0700
Message-ID: <20250502010147.64767-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6813584a.050a0220.3a872c.0012.GAE@google.com>
References: <6813584a.050a0220.3a872c.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+2d1f030088fa84f9d163@syzkaller.appspotmail.com>
Date: Thu, 01 May 2025 04:17:30 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7a13c14ee59d Merge tag 'for-6.15-rc4-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e871b3980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d1f030088fa84f9d163
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7a13c14e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/db407f64de23/vmlinux-7a13c14e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a423a8694742/bzImage-7a13c14e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2d1f030088fa84f9d163@syzkaller.appspotmail.com
> 
> bridge_slave_0: left allmulticast mode
> bridge_slave_0: left promiscuous mode
> bridge0: port 1(bridge_slave_0) entered disabled state
> =============================
> WARNING: suspicious RCU usage
> 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
> -----------------------------
> net/ipv6/ip6_fib.c:2023 suspicious rcu_dereference_protected() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 6 locks held by kworker/u32:8/16847:
>  #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
>  #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
>  #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
>  #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
>  #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
>  #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
>  #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
>  fib6_del+0xcf2/0x1770 net/ipv6/ip6_fib.c:2023
>  fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
>  fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
>  fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
>  fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
>  __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268

#syz dup: [syzbot] [net?] WARNING: suspicious RCU usage in __fib6_update_sernum_upto_root

