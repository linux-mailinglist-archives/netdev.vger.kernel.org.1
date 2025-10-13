Return-Path: <netdev+bounces-228714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE7BD2F29
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FA43A71B9
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AABC156CA;
	Mon, 13 Oct 2025 12:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928126CE2C
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358037; cv=none; b=Gm4L7g9q69v7zDwEN5+YCOZKkqMAN1EzE985rktTVq2WG56As/QUaH53RRP7EWWvb1BOUCnyRSOcWUzcBodzyBEt88IshQtgMaeE1QDnuSwEi5jj4GC88fkaJnBzNg2K7UDH/K+P2T+s67UXUU22c1sOtmt9vbZfzR74MuqMrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358037; c=relaxed/simple;
	bh=Mcd0vcD030NOjng8iqcg0RcUisEQAsTbwRH7DTXDrUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l3hmszfRBHpUqb6OfwhowDSTj6qH/i1l9ue5ppwkijB/nCuuOu1JAwi4rCiayLKR+6Y1G0Bm16N05oqIwdTJ+iNtH/JU3o3KbDhFsquWtBBFRFT23evwxWEzwTReKO7cfpQ+1ETTP8r3CHjQNbnphJ0iwyFE2Nycy0rUhJw6hGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so2558054639f.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 05:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358034; x=1760962834;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmpNmCOoGD1QIQYtnfLyVQX3dIg3P5MBvYOCubZGiXo=;
        b=JAQlg8gesl1/s3700lv/FcyxDCM3nLLG7DRqRnaNGsPAP8N9hP8HurrOALmF8+r8dR
         1Dw2NL+s/WnBCFD05KpzqzoQCSH3M393+UheJJKJQOWJAGNjJ7EMFn5LVoi3rLXpVwua
         PKEVyYqZyf4+qoQUgmWs3Q+8fbJMlVoQalIjQkYkcWGy2MQ/DFFmEpLpC1DJ+xLZ/JeC
         xltoR+zRgJDzjH+5Nwxh3gS4LzsVlA/egVjWPnSTtaSEKwXHSvOtcM0CpBx96vSv1mSV
         tRrgZS8CIXsG2mS+yhCCYCug0Wl2BPgYr6b2vzjCV/BBl0Yzik8pC+g5ScIonkmFNGEg
         9HMg==
X-Forwarded-Encrypted: i=1; AJvYcCXelxVNYlLDrvMhx4xrLejH8KnlEb9SaJp3vQfp4XW9O0ZodA+IR/ZxSVYtce7FJRuUn99ROWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTTy13Q8QY/EMNDT+i4Lk6y0PrsoYRfRZnSAPVtpxH/9ug1dR
	g3lHOhzCPGHpCkzhnAsHAKE4AhhlxvZTrWUzcCUeAHeS3wirrWzg6zjbmulBG7RFRtmIobD3MkZ
	wHOAcEhI43pe3MmQVzRNdQmf/u/qkq3rM6iSY0A95kT7U7Pv/LrZ4Omk9XQI=
X-Google-Smtp-Source: AGHT+IEq/ovLrn3gZIQntS6SuFQ7oq3kk00LPLwL4GEHnkgqNgf+75qTQ8H6vpIEeTxld+Tk2yQi9FeFAhJJx+0jJ+0EniIQWNG+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:424:a3e:d79 with SMTP id
 e9e14a558f8ab-42f873d1affmr198940645ab.21.1760358034538; Mon, 13 Oct 2025
 05:20:34 -0700 (PDT)
Date: Mon, 13 Oct 2025 05:20:34 -0700
In-Reply-To: <000000000000f9be320619be1c0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecee92.a70a0220.b3ac9.001a.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in nsim_destroy (4)
From: syzbot <syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3a8660878839 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5867c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133e2dcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd8d149698dd/disk-3a866087.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3821c26bbc7b/vmlinux-3a866087.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c9814247a19/bzImage-3a866087.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com

INFO: task kworker/u8:17:6162 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:17   state:D stack:23272 pid:6162  tgid:6162  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 nsim_destroy+0xe5/0x670 drivers/net/netdevsim/netdev.c:1166
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1473
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1485 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1707
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:983
 devlink_reload+0x1b6/0x8d0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1d9/0x3d0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x990 net/core/net_namespace.c:234
 cleanup_net+0x4de/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:6187 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22296 pid:6187  tgid:6187  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3c7/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c4ff50d5c
RSP: 002b:00007ffd595a73c0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0c50cd4620 RCX: 00007f0c4ff50d5c
RDX: 0000000000000028 RSI: 00007f0c50cd4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd595a7414 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f0c50cd4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:6193 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23880 pid:6193  tgid:6193  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3c7/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b815f0d5c
RSP: 002b:00007ffe5d47dc20 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f3b82374620 RCX: 00007f3b815f0d5c
RDX: 0000000000000028 RSI: 00007f3b82374670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffe5d47dc74 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f3b82374670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by init/1:
2 locks held by kworker/0:0/9:
4 locks held by kworker/0:1/10:
 #0: ffff88813fe1a138 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe1a138 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900000f7ba0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900000f7ba0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0xa1/0xf40 net/wireless/reg.c:2453
 #3: ffff8880592a08b8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6358 [inline]
 #3: ffff8880592a08b8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_leave_invalid_chans net/wireless/reg.c:2441 [inline]
 #3: ffff8880592a08b8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_check_chans_work+0x170/0xf40 net/wireless/reg.c:2456
5 locks held by kworker/u8:0/12:
3 locks held by kworker/u8:1/13:
4 locks held by pr/legacy/17:
2 locks held by ktimers/1/29:
 #0: ffff8880b893add8 (&rq->__lock){-...}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
 #1: ffff8880b8924148 (psi_seq){-...}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
1 lock held by khungtaskd/38:
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
8 locks held by kworker/u8:2/43:
5 locks held by kworker/u8:3/58:
4 locks held by kworker/u8:5/150:
5 locks held by kworker/u8:6/186:
3 locks held by kworker/0:2/994:
3 locks held by kworker/u8:7/1018:
 #0: ffff88802f988938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88802f988938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc9000483fba0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc9000483fba0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x119/0x15a0 net/ipv6/addrconf.c:4194
8 locks held by kworker/u8:8/1120:
4 locks held by kworker/u8:9/1171:
3 locks held by kworker/u8:10/1308:
5 locks held by kworker/u8:11/1356:
1 lock held by klogd/5157:
4 locks held by udevd/5168:
1 lock held by dhcpcd/5464:
2 locks held by getty/5562:
 #0: ffff88823bf860a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1400 drivers/tty/n_tty.c:2222
4 locks held by syz-execprog/5828:
1 lock held by syz-executor/5835:
1 lock held by syz-executor/5942:
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:634 [inline]
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x41/0x1c0 drivers/net/tun.c:3436
1 lock held by syz-executor/5944:
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:634 [inline]
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x41/0x1c0 drivers/net/tun.c:3436
2 locks held by kworker/u8:13/6140:
6 locks held by kworker/u8:14/6150:
4 locks held by kworker/u8:15/6157:
3 locks held by kworker/u8:16/6158:
6 locks held by kworker/u8:17/6162:
 #0: ffff88801a294938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88801a294938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc90003ab7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc90003ab7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffffffff8ea6a9e0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x820 net/core/net_namespace.c:669
 #3: 
ffff8880352f40d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:914 [inline]
ffff8880352f40d8 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
ffff8880352f40d8 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x10a/0x3d0 net/devlink/core.c:506
 #4: ffff888033c70300 (&devlink->lock_key#5){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff888033c70300 (&devlink->lock_key#5){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff888033c70300 (&devlink->lock_key#5){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0x11c/0x3d0 net/devlink/core.c:506
 #5: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: nsim_destroy+0xe5/0x670 drivers/net/netdevsim/netdev.c:1166
1 lock held by syz-executor/6187:
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
1 lock held by syz-executor/6193:
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
3 locks held by kworker/u8:20/6204:
1 lock held by syz.4.53/6206:
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:634 [inline]
 #0: ffffffff8ea778f8 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x41/0x1c0 drivers/net/tun.c:3436
4 locks held by kworker/u8:21/6212:
5 locks held by kworker/u8:22/6215:
4 locks held by syz-executor/6243:
 #0: ffff88805ac08e88 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:499 [inline]
 #0: ffff88805ac08e88 (&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev+0x212/0x510 net/bluetooth/hci_core.c:2715
 #1: ffff88805ac080a8 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x66a/0x1330 net/bluetooth/hci_sync.c:5291
 #2: ffffffff8ebdee38 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:2118 [inline]
 #2: ffffffff8ebdee38 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xa1/0x230 net/bluetooth/hci_conn.c:2602
 #3: ffff888024033358 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x70/0x680 net/bluetooth/l2cap_core.c:1762
2 locks held by syz-executor/6246:
 #0: ffff888038751d08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0x1a3/0x450 mm/mmap_lock.c:238
 #1: ffff88813fffc5d8 (&zone->lock){+.+.}-{3:3}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
2 locks held by syz-executor/6249:
1 lock held by syz-executor/6253:
2 locks held by dhcpcd/6252:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:trace_hardirqs_on+0x18/0x40 kernel/trace/trace_preemptirq.c:75
Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 8b 05 e5 cf ff 0f 85 c0 74 14 48 8b 3c 24 e8 c8 fe ff ff <65> c7 05 cd cf ff 0f 00 00 00 00 e8 d8 56 d5 ff 48 8b 3c 24 e9 8f
RSP: 0000:ffffc90000a3fc38 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffff88801c2e294c RCX: cebf1c97ee368100
RDX: 0000000000000000 RSI: ffffffff8b3f4d40 RDI: ffffffff8b3f4d00
RBP: ffffc90000a3fcd0 R08: ffffffff8ef76677 R09: 1ffffffff1deecce
R10: dffffc0000000000 R11: fffffbfff1deeccf R12: 0000000000000000
R13: ffff88801c2e3560 R14: 1ffff92000147f88 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126cc9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b12462600 CR3: 000000003c378000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ksoftirqd_run_end kernel/softirq.c:327 [inline]
 run_ktimerd+0x131/0x190 kernel/softirq.c:1140
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

