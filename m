Return-Path: <netdev+bounces-236171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51DC392AA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 06:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123AC3B4D46
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C52BE03E;
	Thu,  6 Nov 2025 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36zmygfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E712B94
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407199; cv=none; b=lQbRZgI6ZsKTzcQqoE7wg9MTtCLKkEvdv96D/ffA5zjhGQg5LR9C1ikELmfNL0O2LmL6e3GfHg0M7gDxqNxZgsXgy+RMNlhrG7tp552QoVypNVzJbZ6t527E3AIu4f+HCycPQs6m+1HfZMOC6HPZl75rjIUZartav9Uk6MWtI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407199; c=relaxed/simple;
	bh=obkFOa8dgGkXpHUeZk6Wy4ia63nPIz8uYDdRbOwEQPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dyGTEw6n/jgUmXwWgqpRcFHn31c/AZAYd61UAXzPr4Mk2b0h2hQhyUWzGbRQnD1bNwgRMwb45HtbkSecmno2tG8+LH9ChBF44pTyIScGYk2NuIvr9I6X+out4wkEnHlfvA547gyF6sVFYGFcyjquejrsWHO963A12Ey4gOjb/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36zmygfW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2698b5fbe5bso1077815ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 21:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762407197; x=1763011997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMIrj1SebodeB1BBs84km+twk80GbTA6VdPwtXHYsCY=;
        b=36zmygfWIOgWLX3UOwbXGKg96lSxHLOjDYVHoUz6by2oWJb8sOhL8N0r2426/luZl4
         kXkBQOcz4QYsYPJKnOBfLRu2fguXyYYq98ToCrVuZSb2cUKpYaCwiwA2bEbntOT/ZQ9Y
         Rw4OulKVtDDATDH55YkeISinJJPTWpG+pmx4VqXD8E3A/2Adso31x3H5qhNT3o3cYd5h
         nRqps7K5Q08drpTk3VeBZVF96wyYcdbCji4nmFF009PlaB9L7O5p9avG9VfAzdZVGcOF
         ODunRUVBEMfjWGenbVAuza6oWgcqiZZOjZI+4JtaE6jW0naMNTBblfma26OqY8OG60tL
         tHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762407197; x=1763011997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMIrj1SebodeB1BBs84km+twk80GbTA6VdPwtXHYsCY=;
        b=d8Ca9WwFpyiU5EJS20xkfgr4zjOIOgspoPYTb4sHaNBONMauEK/ryEn1lf9phwgiY6
         d+TY5pAGRm4yWd8kbyJgML9KfGkvHVb5vL6ufe7d/TwIoDg5gX4UcG/M33tOOJEHya+s
         k8iRHkjwfIdhWXuiNMJpcwQcMyRidknpxYbPxfa/329PfYMXw/drugDxhvzKRF8DrIm/
         s9J3zCPNJ1UjA9EgGa2+DqP3o/Kna1W2CxnG2ooLqGzndQsEzDljNa+j2JVCh9kUsgNm
         o36KE0fNgmy/YOIG8esmSZgCXEfVOuXP5k314mX1tCm5KFKohTmGf43wIjuhlXexEeIt
         pBtg==
X-Forwarded-Encrypted: i=1; AJvYcCV42P4gy/DwOocs8dyPKzpQpupL3W+iIvZJOdiSTW3dq7Y9nPD17OdVpqfw9KkBAaILLVcrxqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjXSkDwqgs09QO+angINrfmZskMz12DZNAaun47pi9iOvQlM1
	woq1dQ8RcFXUFASIxojaYb4JWhmGJyrz/pfzyYgvOZUwpMxasbpPuk9iZzt8KXIoNuzHuOrOEGB
	IVKHZrA==
X-Google-Smtp-Source: AGHT+IGri7ZDMOpc+I9eO5PsvKTnxsgN0HqwOKuJA663eOETV8Mo2RP6symg17wkpDeRhzzYQuzD1zB71fA=
X-Received: from plbjf5.prod.google.com ([2002:a17:903:2685:b0:294:fdb9:5c0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:295:5da6:600c
 with SMTP id d9443c01a7336-2962ad82c96mr89528135ad.2.1762407196668; Wed, 05
 Nov 2025 21:33:16 -0800 (PST)
Date: Thu,  6 Nov 2025 05:32:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106053309.401275-1-kuniyu@google.com>
Subject: [PATCH v1 net] tipc: Fix use-after-free in tipc_mon_reinit_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Hoang Le <hoang.h.le@dektech.com.au>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, 
	syzbot+d7dad7fd4b3921104957@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free of tipc_net(net)->monitors[]
in tipc_mon_reinit_self().

The array is protected by RTNL, but tipc_mon_reinit_self()
iterates over it without RTNL.

Let's hold RTNL in tipc_mon_reinit_self().

[0]:
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
Read of size 1 at addr ffff88805eae1030 by task kworker/0:7/5989
CPU: 0 UID: 0 PID: 5989 Comm: kworker/0:7 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events tipc_net_finalize_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:568
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 rtlock_slowlock kernel/locking/rtmutex.c:1894 [inline]
 rwbase_rtmutex_lock_state kernel/locking/spinlock_rt.c:160 [inline]
 rwbase_write_lock+0xd3/0x7e0 kernel/locking/rwbase_rt.c:244
 rt_write_lock+0x76/0x110 kernel/locking/spinlock_rt.c:243
 write_lock_bh include/linux/rwlock_rt.h:99 [inline]
 tipc_mon_reinit_self+0x79/0x430 net/tipc/monitor.c:718
 tipc_net_finalize+0x115/0x190 net/tipc/net.c:140
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6089:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x1a8/0x320 mm/slub.c:4407
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tipc_mon_create+0xc3/0x4d0 net/tipc/monitor.c:657
 tipc_enable_bearer net/tipc/bearer.c:357 [inline]
 __tipc_nl_bearer_enable+0xe16/0x13f0 net/tipc/bearer.c:1047
 __tipc_nl_compat_doit net/tipc/netlink_compat.c:371 [inline]
 tipc_nl_compat_doit+0x3bc/0x5f0 net/tipc/netlink_compat.c:393
 tipc_nl_compat_handle net/tipc/netlink_compat.c:-1 [inline]
 tipc_nl_compat_recv+0x83c/0xbe0 net/tipc/netlink_compat.c:1321
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x508/0x820 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6088:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x195/0x550 mm/slub.c:4894
 tipc_l2_device_event+0x380/0x650 net/tipc/bearer.c:-1
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 unregister_netdevice_many_notify+0x14d7/0x1fe0 net/core/dev.c:12166
 unregister_netdevice_many net/core/dev.c:12229 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12073
 unregister_netdevice include/linux/netdevice.h:3385 [inline]
 __tun_detach+0xe4d/0x1620 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x10d/0x1c0 drivers/net/tun.c:3433
 __fput+0x458/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 46cb01eeeb86 ("tipc: update mon's self addr when node addr generated")
Reported-by: syzbot+d7dad7fd4b3921104957@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/690c323a.050a0220.baf87.007f.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/tipc/monitor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 572b79bf76ce..46c8814c3ee6 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -711,6 +711,8 @@ void tipc_mon_reinit_self(struct net *net)
 	struct tipc_monitor *mon;
 	int bearer_id;
 
+	rtnl_lock();
+
 	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
 		mon = tipc_monitor(net, bearer_id);
 		if (!mon)
@@ -720,6 +722,8 @@ void tipc_mon_reinit_self(struct net *net)
 			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
+
+	rtnl_unlock();
 }
 
 int tipc_nl_monitor_set_threshold(struct net *net, u32 cluster_size)
-- 
2.51.2.1026.g39e6a42477-goog


