Return-Path: <netdev+bounces-187351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A7AA6811
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966591BC0FDA
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7717555;
	Fri,  2 May 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s2iCQGZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D13433CB;
	Fri,  2 May 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147590; cv=none; b=jO6lCYqPbRAu0vDN+RTVuGQcLdrep9e2XtxI/juLgaPQOjaMzJTscxE4YxqlzZvI1Le2tXWScYosZCf/zGt0NybzeIhF83/7ur5M664CLpIMZcwWc2hyz5/l9nu+G7GxYfPM5cJqYJy9XSzQhP/yvZuEvqYn9FXp2Dp30tZ/2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147590; c=relaxed/simple;
	bh=PVesPbYkqOP+9Z+LGxE1J8BQGqxPkdwWHQylE1/O1P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEgqlqM7/unb+15rmgik+OzlS8bMpTfrNSqkHYfJZl6CmMM8wunueXuZBy/9DBEUwnctbVdIuYdrFzNG5ELgBwnKc9FmpZ8V2SwKigxlB+VHvFFI7K4YM17huNqAwnO8R/68pL77npMjfvazIFJjKAVH706afJoBIoZ433tYM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s2iCQGZc; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746147589; x=1777683589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbLsOfDNvR5xLvwrQ+Nl+SRY2k86rF/xQk20R+fkGJc=;
  b=s2iCQGZctmfSOT8ruC+rn1Nr649T3wmx1POlQZhZd+yElqg2XLvjrb1S
   VvAHBtBFYcwtg2w5rYMz2+wpzzqJZaxtME/kNXAMwfGriehUlLPwuZwUl
   6+sJTuFeG9SaxX3PAFOZJhj9a5098TejAAVlNi4u3fy1Gi6sOC+AwEayP
   E=;
X-IronPort-AV: E=Sophos;i="6.15,255,1739836800"; 
   d="scan'208";a="293667840"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 00:59:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id 177bb22e-7fb3-49be-ae3a-09e546e7697f; Fri, 2 May 2025 00:59:44 +0000 (UTC)
X-Farcaster-Flow-ID: 177bb22e-7fb3-49be-ae3a-09e546e7697f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 00:59:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 00:59:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+8dd1a8ebe4c3793f5aca@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in __fib6_update_sernum_upto_root
Date: Thu, 1 May 2025 17:53:22 -0700
Message-ID: <20250502005933.64039-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6813584a.050a0220.3a872c.0011.GAE@google.com>
References: <6813584a.050a0220.3a872c.0011.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+8dd1a8ebe4c3793f5aca@syzkaller.appspotmail.com>
Date: Thu, 01 May 2025 04:17:30 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b6ea1680d0ac Merge tag 'v6.15-p6' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1457502f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a42a9d552788177b
> dashboard link: https://syzkaller.appspot.com/bug?extid=8dd1a8ebe4c3793f5aca
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8b0865e8a7ea/disk-b6ea1680.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fab387b8c42a/vmlinux-b6ea1680.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bfb50db06aa1/bzImage-b6ea1680.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8dd1a8ebe4c3793f5aca@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 Not tainted
> -----------------------------
> net/ipv6/ip6_fib.c:1351 suspicious rcu_dereference_protected() usage!

This is

	struct fib6_node *fn = rcu_dereference_protected(rt->fib6_node,
				lockdep_is_held(&rt->fib6_table->tb6_lock));

and ...

> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 3 locks held by syz.0.6334/23457:
>  #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
>  #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x9b/0x380 net/ipv6/ip6_fib.c:2263
>  #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
>  #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0x1ce/0x380 net/ipv6/ip6_fib.c:2267
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 23457 Comm: syz.0.6334 Not tainted 6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6865
>  __fib6_update_sernum_upto_root+0x223/0x230 net/ipv6/ip6_fib.c:1350
>  fib6_update_sernum_upto_root+0x125/0x190 net/ipv6/ip6_fib.c:1364
>  fib6_ifup+0x142/0x180 net/ipv6/route.c:4818
>  fib6_clean_node+0x24a/0x590 net/ipv6/ip6_fib.c:2199
>  fib6_walk_continue+0x678/0x910 net/ipv6/ip6_fib.c:2124
>  fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2172
>  fib6_clean_tree net/ipv6/ip6_fib.c:2252 [inline]
>  __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2268

here we hold rcu_read_lock() and spin_lock_bh(&table->tb6_lock)..

so rt->fib6_table->tb6_lock is different from table->tb6_lock ??

fib6_link_table() is called without lock in fib6_tables_init(),
but it should be fine unless someone asynchronously triggeres a
thread that tries to access the main/local route table during
__net_init and races with fib6_tables_init() ?

In such a case, the possible fix would be

---8<---
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 1f860340690c..a26b8e9896f5 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -304,8 +304,10 @@ EXPORT_SYMBOL_GPL(fib6_get_table);
 
 static void __net_init fib6_tables_init(struct net *net)
 {
+	spin_lock_bh(&net->ipv6.fib_table_hash_lock);
 	fib6_link_table(net, net->ipv6.fib6_main_tbl);
 	fib6_link_table(net, net->ipv6.fib6_local_tbl);
+	spin_unlock_bh(&net->ipv6.fib_table_hash_lock);
 }
 #else
 
---8<---

but I'd like to wait for a repro.


>  rt6_sync_up+0x128/0x160 net/ipv6/route.c:4837
>  addrconf_notify+0xd55/0x1010 net/ipv6/addrconf.c:3729
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  netif_state_change+0x284/0x3a0 net/core/dev.c:1530
>  do_setlink+0x2eb6/0x40d0 net/core/rtnetlink.c:3399
>  rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
>  rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

