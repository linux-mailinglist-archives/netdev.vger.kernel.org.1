Return-Path: <netdev+bounces-258606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NOlFOwVj2lfIQEAu9opvQ
	(envelope-from <netdev+bounces-258606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:15:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B890A135FB2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB00F3047BE9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AF1DFF0;
	Fri, 13 Feb 2026 12:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637234D4CB
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984937; cv=none; b=ju2kMxa4X7UTzpVpt/8gEZ7R7G+kblyR7wNNGA7dIV1AzKHnS5UWhOZYTW1SQyKayKH7d6OMVeWhGa9kZLa5GsFgF1ZAAAqE63aiM0uUsWawObjm76R8uX6vBwl8rjnqw4GJiPFW3RHuWfAW1ZB0+unDyH1ZJ9z81jECIQ6IwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984937; c=relaxed/simple;
	bh=DHdfr0BXQDEIQi8gw2sWQVIOAivRg/hru3hG+ibuvNI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ucqcrDpathq8nMb+99fvEL+l+ugMD2llCawF2jPscXX6P/RaoPdnQ9VCsA9wDRAkHeb1oQ7G0jXfaEd4PsR74mQNTN+xk/ui9hchwTI0vm0zw0gHChY4eu1nH3Xa7EBJQNIwKn43iA8BL6J4EUph878OvGY7euFn0LYApkkhHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66b8c7f0debso6579380eaf.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 04:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984935; x=1771589735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EZAsO95odiGPLEAXxVidVb4wDTQ16NU9mu9kPQTh0I=;
        b=a9fz4KRt2D2NKixkvIrrLDa4u4vtKmUCMk3twxl8WJ+KvyjB4Ng8yS0Ur54bYSKseY
         trr3GiVBWJRYwm4yQH49SOqYH2HKlFIYWPoNjYxgPBdnK2np3WDyB65xVm3J/1NzyZ95
         su9VK/J9uo2pVQXwJEHBxH47TyjbsDEYSGb0okvTkxzjt0kVK7ZMRYfMtMBMeH4duzhJ
         VHKPPZRB54BuDkqx2v+M54O/9ZnFQT0JoNF2KwJaAjn1wG1KxHpDsS/X0Jkzv9JLRaJ+
         Ehv29P7GXvLnl7aexz57dxya61DxmKC4JOmQAPymRLk2npFAiZbIftMbyZk6ZmhCX0Wu
         wN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeOktUkXhPRz504h8+8xJWI8QQLieNYoM2lZ5rxxs9R0HQ0SxYJTzf6zdKVi5Y7PCm6t6zyMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqAr6uWluKBv6FCsGlM4W0VctNbCk2ytQCYE52tq+KbZJ2mkq
	i0YRqYzlPKDe8jdT17ArEDBuYx131MRPxumJpvJ4vG/DooKbeRNwvKxTVXDSlRE6+T+26csPVPJ
	Ry3MTyMn5Bzng8ILp9mpvgrsMBmUb1bf1Lqfcpipi9Vc3HuLUifi1htcRtcI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee84:0:b0:663:d21:9f0 with SMTP id 006d021491bc7-6776757ba74mr623905eaf.34.1770984934340;
 Fri, 13 Feb 2026 04:15:34 -0800 (PST)
Date: Fri, 13 Feb 2026 04:15:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in inet6_getname
From: syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258606-lists,netdev=lfdr.de,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B890A135FB2
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    57be33f85e36 nfc: nxp-nci: remove interrupt trigger type
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f2165a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1584065a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f2165a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77aaa9b6c846/disk-57be33f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2617a56e7118/vmlinux-57be33f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fd173f33f5f/bzImage-57be33f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/u8:6/2985 is trying to acquire lock:
ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533

but task is already holding lock:
ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(k-sk_lock-AF_INET6);
  lock(k-sk_lock-AF_INET6);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/u8:6/2985:
 #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: process_scheduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
 #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa0f/0x17a0 kernel/workqueue.c:3340
 #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
 #3: ffff88807a07abc8 (k-clock-AF_INET6){++.-}-{3:3}, at: rds_tcp_data_ready+0x113/0x950 net/rds/tcp_recv.c:320

stack backtrace:
CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: krds_cp_wq#1/0 rds_send_worker
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 lock_sock_nested+0x48/0x100 net/core/sock.c:3780
 lock_sock include/net/sock.h:1709 [inline]
 inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
 rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
 rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
 rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
 rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
 rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
 __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
 rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
 rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
 tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
 tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
 sk_backlog_rcv include/net/sock.h:1185 [inline]
 __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
 release_sock+0x5f/0x1f0 net/core/sock.c:3795
 rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
 rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3782
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2985, name: kworker/u8:6
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: krds_cp_wq#1/0 rds_send_worker
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:8829
 lock_sock_nested+0x5d/0x100 net/core/sock.c:3782
 lock_sock include/net/sock.h:1709 [inline]
 inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
 rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
 rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
 rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
 rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
 rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
 __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
 rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
 rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
 tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
 tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
 sk_backlog_rcv include/net/sock.h:1185 [inline]
 __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
 release_sock+0x5f/0x1f0 net/core/sock.c:3795
 rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
 rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
BUG: scheduling while atomic: kworker/u8:6/2985/0x00000202
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

