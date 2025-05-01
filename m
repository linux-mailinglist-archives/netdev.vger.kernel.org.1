Return-Path: <netdev+bounces-187228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C2AA5DB4
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66A59C60FA
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44652236ED;
	Thu,  1 May 2025 11:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE362E401
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098253; cv=none; b=dyj9NHDwn7H80CisbqrSx25WpCrjeDptQKjrkvucMWxB8uCTMQl4Er/YwlFHiqmHoiLmMpz99RLm5gBzhX5bBUIc/jOfHWknns47yBxnqRhLfq8DJt23zpNR/jXReVkVP5u7I26e7czkb6TjUhM/er1lPOMisxm7sKn7m/v1k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098253; c=relaxed/simple;
	bh=FXohX/ArdMkzKso12PRdvYXeBoN6y1WPW9ycV+f68qw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uYE9ZhBWVSCueFlZw1C2szWxKHn8wArfgypvzu8ftZoQKDzISGB6FStAA1rWawfc5xpx5rn6x3Drhf0YOK6d53ZvdS6IBvhlzGcaJY0/jv2HF6GN9MdsCZOD4SVae+eYlfzrjfveaQ8Q8JMfdynnewN90WaBttg0XE3hTdXqXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85dad56a6cbso130519939f.3
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 04:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098250; x=1746703050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yic3hQCMhlizJGNLrVHXqVvz42qkVwajdriEOxWrJE0=;
        b=P9CAfEcXZY0XdiCjPn5qXdIIXLD4bq792NNMHmIfPpBHrHAbIL5QD+HxgaYQTYND/j
         NubCreXbQj1vhucVn6cSt93k6EElfCLaKIM7U25UJXR02BdfDuXyBiIPucggSJU8Tbu2
         yu73fQJcVR+hctmHADTlBUuHmp3fkCD7guLdTgR0meW4q4AFs/6cC/JBP7EV1sSihYJI
         Qml51seHYxAuGGPPL76wbH4N3CEkxRsQyG50PnvTamnxPC+cQ1+hrMMMUrmOPvyURKLv
         2q7/PmfgT3m8SHJHguumzSYPT+l6UXy9HIgRaUM3cC0lP2q+KXPiHibNOoJD3CxPpR/n
         z3ig==
X-Forwarded-Encrypted: i=1; AJvYcCUEqCcKhYPfmp2VzImS24GW5MUiQS2pwBGFhea5kSdmMwg91ehr5sJDSJYuX+QirDtBDp5ad3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDmaeH1jOQNakMA8oMeju45S9LYmE2Uw1SyaeJhM34nCjpKsU
	E0KSmBNYz9mRarBjBvBEmvrzYgmWBQ8ilrASlWrxDTkR4sqQbGsKvhUNXIf8h8ACz7EOOnjTAyj
	gpEOrYGY9E8fQf5taRjqmVEyGt8uT7iVzcQx/RROzE/9UA/XQjgpZIAY=
X-Google-Smtp-Source: AGHT+IEgYrWA2Wmm0e7UkfIW4S/pFnefYS9GNq29ptouwY7E9Y3068+zX6Z8SiyJRHanRO/Vzz3JW5evgDBgk9CCnlwgkgFlXm7q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c8:b0:3d9:34c7:7b76 with SMTP id
 e9e14a558f8ab-3d96771bbb3mr75945565ab.16.1746098250527; Thu, 01 May 2025
 04:17:30 -0700 (PDT)
Date: Thu, 01 May 2025 04:17:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813584a.050a0220.3a872c.0012.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in fib6_del (3)
From: syzbot <syzbot+2d1f030088fa84f9d163@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a13c14ee59d Merge tag 'for-6.15-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e871b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
dashboard link: https://syzkaller.appspot.com/bug?extid=2d1f030088fa84f9d163
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7a13c14e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db407f64de23/vmlinux-7a13c14e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a423a8694742/bzImage-7a13c14e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d1f030088fa84f9d163@syzkaller.appspotmail.com

bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:2023 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/u32:8/16847:
 #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
 #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 fib6_del+0xcf2/0x1770 net/ipv6/ip6_fib.c:2023
 fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 cleanup_net+0x596/0xb30 net/core/net_namespace.c:649
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:2035 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/u32:8/16847:
 #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
 #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 fib6_del+0x2ef/0x1770 net/ipv6/ip6_fib.c:2035
 fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 cleanup_net+0x596/0xb30 net/core/net_namespace.c:649
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:1921 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/u32:8/16847:
 #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
 #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 fib6_del_route net/ipv6/ip6_fib.c:1921 [inline]
 fib6_del+0x1084/0x1770 net/ipv6/ip6_fib.c:2040
 fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 cleanup_net+0x596/0xb30 net/core/net_namespace.c:649
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:1930 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/u32:8/16847:
 #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
 #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 fib6_del_route net/ipv6/ip6_fib.c:1930 [inline]
 fib6_del+0xfef/0x1770 net/ipv6/ip6_fib.c:2040
 fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 cleanup_net+0x596/0xb30 net/core/net_namespace.c:649
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:1975 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
7 locks held by kworker/u32:8/16847:
 #0: ffff88801c68d148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bd7d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9010e510 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xc9/0xb30 net/core/net_namespace.c:608
 #3: ffffffff901243a8 (rtnl_mutex){+.+.}-{4:4}, at: cleanup_net+0x50d/0xb30 net/core/net_namespace.c:644
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x3a/0x2d0 net/ipv6/ip6_fib.c:2263
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #5: ffff88802b926830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0xeb/0x2d0 net/ipv6/ip6_fib.c:2267
 #6: ffff888046504d38 (&net->ipv6.fib6_walker_lock){++..}-{3:3}, at: fib6_del_route net/ipv6/ip6_fib.c:1971 [inline]
 #6: ffff888046504d38 (&net->ipv6.fib6_walker_lock){++..}-{3:3}, at: fib6_del+0x880/0x1770 net/ipv6/ip6_fib.c:2040

stack backtrace:
CPU: 3 UID: 0 PID: 16847 Comm: kworker/u32:8 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 fib6_del_route net/ipv6/ip6_fib.c:1975 [inline]
 fib6_del+0x1281/0x1770 net/ipv6/ip6_fib.c:2040
 fib6_clean_node+0x424/0x5b0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 cleanup_net+0x596/0xb30 net/core/net_namespace.c:649
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
netdevsim netdevsim2 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim9 eth3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim9 eth2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim9 eth1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim9 eth0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond_slave_0: left allmulticast mode
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond_slave_1: left allmulticast mode
bond0 (unregistering): Released all slaves
bond1 (unregistering): Released all slaves
bond2 (unregistering): Released all slaves
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond0 (unregistering): left promiscuous mode
bond_slave_0: left promiscuous mode
bond_slave_1: left promiscuous mode
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond1 (unregistering): (slave veth3): Releasing active interface
bond1 (unregistering): Released all slaves
bond2 (unregistering): Released all slaves
IPVS: stopping master sync thread 17458 ...
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_1
batadv0: left promiscuous mode
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

