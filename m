Return-Path: <netdev+bounces-262447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAmBvSGpGlsjQUAu9opvQ
	(envelope-from <netdev+bounces-262447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:35:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BD1D11B8
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A5F300DDF1
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE4308F07;
	Sun,  1 Mar 2026 18:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD048175A6A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390129; cv=none; b=RTdY1AFMoVq6l/u/1N6amZO74c5chJ3uI02r5xrJERsvHfVfIgNGphS/HSRyuAmiv/dP1ye/hjEyFW5rn8wi6uqRILFgn5cskwaqEgK3z6esEtDsdB+OhqgOsfS+oS/laQu57lRaoOEtv6Uw3Mhz3cd97I/LEQ13VrlVHTk5n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390129; c=relaxed/simple;
	bh=Sx2qiZCmvyZr1+x0tQ30Z1GMVAY2u8hJ+Oun+qEC7oQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AA7U1JqUQtRz/ON08TTMVlSVhxIZGHBT7ldrxUp9ZAaI+4zW8/xH4xpwHLPifC8d1gJak8JcPZm0DGgCLrstcaF4Eo+J1y3x9C5E5URfuFyUPjGZgPjvfd+80g2WvmXqAiIcMGix45lyA7SY7j0YVODgeEQy3dNHQpvVGMdUu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c6ef1538so78153370eaf.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772390127; x=1772994927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1UYv/jtRxH/t46qvbmQtlpVvuiG18i64ydB7qEvuG8=;
        b=Pi6ecfZGb54q7Sh8hDqrutW8SF/0bByvvyWZF3l8g2iCtA+zitJl0ZfeLwILuBZQiz
         yF2r+nuu50JLPBlSTEzufaBEdpX1bWKkrDdzk8+piCU3FOs40WEX1ECAf/HLQQhBLMW7
         g1Ua2BjYSFhO3FMSUQawtLBkIDVXP/m2bs9hfpA9M4O1fNJtopgYdTfsaUMOmpuMQPS/
         thfgY2FRj2S9bxmloxD+vjEL9INFIYNeBZ51I6GD4+2N+NyMt4Tsv+VXYkQ18A1wCelB
         H+wkq5E/LJBFeLGzA5dKkcFEegnrDMIH5jOfysYDWjuk1wJhve5YJMhTlBh12zZCuDyi
         pTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq3lHQIYVa4vzuwZaadiawdZN6O4NVqVvtzGVUivwpCWmqeIE8JJoYPNF1JxKhwDzwf+O5C4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqOJYnS/fJYMI/YzdZzuTeC5cFtIWXgUksKnfsqDv/9EKZXY6
	DarefMsyK2i13x8UH4bVWrmG5cHlFxIKW3jZT+y9qiLDpeIte35SAkea5n5A5l9CHSCNFIJmSbA
	/NbMU5pGuTW8BhmuhwBpgK1A3mf/6X0hpC4hxiNelNmsv3k2ue9iGP3L9oec=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2503:b0:67a:422:d24 with SMTP id
 006d021491bc7-67a04221235mr2401092eaf.70.1772390126842; Sun, 01 Mar 2026
 10:35:26 -0800 (PST)
Date: Sun, 01 Mar 2026 10:35:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a486ee.050a0220.3a55be.0067.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in ret_from_fork (4)
From: syzbot <syzbot+7c11975a7e4a2735d529@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262447-lists,netdev=lfdr.de,7c11975a7e4a2735d529];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 6C4BD1D11B8
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2f61f38a2174 net: stmmac: fix timestamping configuration a..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16824d5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=7c11975a7e4a2735d529
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e9955a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b928d6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3c4b4ab812f/disk-2f61f38a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a662c736eab0/vmlinux-2f61f38a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/345dc74120a7/bzImage-2f61f38a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c11975a7e4a2735d529@syzkaller.appspotmail.com

INFO: task kworker/1:8:5970 blocked for more than 159 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:8     state:D stack:30744 pid:5970  tgid:5970  ppid:2      task_flags:0x4208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7061
 kthread+0x260/0x470 kernel/kthread.c:451
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:0/9:
1 lock held by kworker/0:1/10:
 #0: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: worker_attach_to_pool+0x2e/0x3a0 kernel/workqueue.c:2691
2 locks held by kworker/u8:0/12:
2 locks held by kworker/u8:1/13:
1 lock held by kworker/R-mm_pe/14:
 #0: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: worker_detach_from_pool kernel/workqueue.c:2749 [inline]
 #0: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: rescuer_thread+0xc4a/0x1120 kernel/workqueue.c:3610
3 locks held by kworker/1:0/24:
 #0: ffff88813fe0f548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88813fe0f548 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc900001e7c40 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc900001e7c40 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffff88807c222240 (&data->fib_lock){+.+.}-{4:4}, at: nsim_fib_event_work+0x202/0x3d0 drivers/net/netdevsim/fib.c:1490
1 lock held by khungtaskd/30:
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
8 locks held by kworker/u8:2/35:
3 locks held by kworker/1:1/42:
3 locks held by kworker/u8:3/49:
 #0: ffff88813fe4c148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88813fe4c148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90000b97c40 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90000b97c40 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: idle_cull_fn+0xd2/0x740 kernel/workqueue.c:2973
2 locks held by kworker/u8:4/77:
3 locks held by kworker/u8:5/86:
 #0: ffff88813fe4c148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88813fe4c148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc900025dfc40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc900025dfc40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:313
2 locks held by kworker/u8:6/146:
2 locks held by kworker/0:2/796:
2 locks held by kworker/u8:7/1116:
1 lock held by kworker/u8:8/1147:
 #0: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: worker_attach_to_pool+0x2e/0x3a0 kernel/workqueue.c:2691
2 locks held by kworker/u8:9/1168:
1 lock held by kworker/1:2/1997:
 #0: ffffffff8e5fec68 (wq_pool_attach_mutex){+.+.}-{4:4}, at: worker_attach_to_pool+0x2e/0x3a0 kernel/workqueue.c:2691
3 locks held by kworker/u8:10/2990:
2 locks held by getty/5581:
 #0: ffff888036c110a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:3/5810:
2 locks held by syz-executor210/5855:
 #0: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8a1/0x1be0 net/core/rtnetlink.c:4071
 #1: ffff88806d1a5528 (&wg->device_update_lock){+.+.}-{4:4}, at: wg_open+0x227/0x420 drivers/net/wireguard/device.c:50
1 lock held by syz-executor210/5856:
 #0: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fbcb888 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x722/0xbe0 net/core/rtnetlink.c:6964
3 locks held by kworker/1:4/5865:
7 locks held by kworker/u9:3/5869:
 #0: ffff88807a26f948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88807a26f948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90003ba7c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90003ba7c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffff888076408ec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d3/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff8880764080c0 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0xa6f/0x1190 net/bluetooth/hci_sync.c:5734
 #4: ffffffff8fd57f28 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2136 [inline]
 #4: ffffffff8fd57f28 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x340 net/bluetooth/hci_conn.c:1342
 #5: ffff888057b3caf8 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x7b/0x5c0 net/bluetooth/l2cap_core.c:1755
 #6: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #6: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x38d/0x770 kernel/rcu/tree_exp.h:961
5 locks held by kworker/u9:4/5870:
 #0: ffff88807c3fa148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88807c3fa148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358


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

