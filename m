Return-Path: <netdev+bounces-129233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F597E638
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DECCB20AFD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E75286A3;
	Mon, 23 Sep 2024 06:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F6219FF
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074530; cv=none; b=VooEMOfAenNZ6FWGkWtawCJ0sVv8lpW9UV8DZTKL34QGT7/eNhXp53kRsL5g1awQF60C3gnyzYQnYP1kKrmd6UVFfepww9nP7+oJnMlxBrjJAKBree0uuYf1J5BnmoauT0VMatpb1ed/Qs6QzwKy37CD7Ga8W1LEWrOOQHAaS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074530; c=relaxed/simple;
	bh=yiWRBDMbZP3+Ew4611AJT1CCHm4Yfq+j6+8WtkEecCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oIIXwKmTHv1eCW9YQvCoJVh1qecTT7ozG8JcjM8E6+/5jtqkFhPiDUGJ+IpIo9bhPs2gJVuN43Oa/SavPx69mE9mqs4TE65PrgPmVpq4Lt44fyEReYpBH6dnBNeqKiBhcixNl2NGooKT3Z9HGIRvs8dGv5WdbWzkEnuD9VS/eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so30676245ab.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 23:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727074527; x=1727679327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD2K1JyiO0whuy0905nu922ujMgxbkurwc3120l24cY=;
        b=N0gQXfoCxsGSu9vM+8HEfcNLroh57kIFAQA+p8HxHA9wk4LEZIsaP8vqzetOW5XYRZ
         FwI9pVjA7Wd1eBa2nqE+tO3ZoHuHyzfpn7myDvWDGpyIRpgJudglevEEybAxhgxDEr3j
         eyf6WCbt/EdDSFzM6Fut+dXoqbJX1AlRpN5ADsaIQ0ti3t39ukXyrwUwgoXy7SxjsQCX
         30uIdqcTuM/pfM/7EyVBonpWRKLpIrTqX8cOZTBCefbJg/AmA1h7BdPNfPVTBGT4wgu6
         sfd+FtNv+yAUDBttv8dN+h8rxQ/w1yUSUx9R9GBAS1fGF1hkIYWOY7LVrMcUBjRrQRhO
         k+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVZtiZkb8vF5J7UQll3TZifAchcCrujtm0fPcOX0WaSxpQDCBxbRlel5Z3+FvnukzNIekYJN24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBh0WMXygByVeyiGK+nYHeqEg0QKb7xjd/7CZTlW5ss9kbrem
	3jEmKi6NFimpQ8MLzErAH8zntphDVomQFqDCS2ZqtckIZi7PSbDeHJ/Aa6gorGze4FEvRnH+Hfc
	xJI4ItKFk/fthlbQFuw/0bkLO5X1u7X9i18+1LEQk2nqNlDpd2QVqnss=
X-Google-Smtp-Source: AGHT+IHHHN+fa10FoNMzJtZAT3CrRagrvldHVUcaGSzKVEmw3oChfr5CCGqfbWQDup2sJ7DitiDozoXy4Es9GxSkPTReYcci2949
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:3a0:8f20:36e7 with SMTP id
 e9e14a558f8ab-3a0c8d16258mr100995175ab.19.1727074527596; Sun, 22 Sep 2024
 23:55:27 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:55:27 -0700
In-Reply-To: <00000000000020c8d0061e647124@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f110df.050a0220.c23dd.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_dad_work (5)
From: syzbot <syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    af9c191ac2a0 Merge tag 'trace-ring-buffer-v6.12' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148aa19f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162e9c27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123c107980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3f6f73cc34a/disk-af9c191a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5895312beb3/vmlinux-af9c191a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c737e741d8d8/bzImage-af9c191a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com

INFO: task kworker/R-ipv6_:2724 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-08829-gaf9c191ac2a0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-ipv6_ state:D stack:28560 pid:2724  tgid:2724  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6674
 __schedule_loop kernel/sched/core.c:6751 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6766
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 rescuer_thread+0x63f/0x10a0 kernel/workqueue.c:3487
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor183:5220 blocked for more than 150 seconds.
      Not tainted 6.11.0-syzkaller-08829-gaf9c191ac2a0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor183 state:D stack:20192 pid:5220  tgid:5220  ppid:5219   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6674
 __schedule_loop kernel/sched/core.c:6751 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6766
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x398/0x4f0 net/socket.c:2210
 __do_sys_sendto net/socket.c:2222 [inline]
 __se_sys_sendto net/socket.c:2218 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4abeb91463
RSP: 002b:00007fff6c3ace18 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4abec14560 RCX: 00007f4abeb91463
RDX: 0000000000000040 RSI: 00007f4abec145b0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fff6c3ace34 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f4abec145b0 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900001f7d00 (reg_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900001f7d00 (reg_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: reg_todo+0x1c/0x8d0 net/wireless/reg.c:3218
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
3 locks held by kworker/u8:2/35:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
4 locks held by kworker/u8:3/52:
7 locks held by kworker/u8:5/74:
3 locks held by kworker/R-ipv6_/2724:
 #0: ffff88814bba0948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814bba0948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009497c80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009497c80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
4 locks held by kworker/1:2/3197:
1 lock held by syslogd/4651:
1 lock held by klogd/4658:
5 locks held by udevd/4669:
3 locks held by dhcpcd/4883:
2 locks held by getty/4972:
 #0: ffff888032e120a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor183/5213:
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
4 locks held by syz-executor183/5216:
1 lock held by syz-executor183/5217:
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor183/5220:
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcb97c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
4 locks held by syz-executor183/5221:
2 locks held by dhcpcd/5267:
 #0: ffff888067190258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1609 [inline]
 #0: ffff888067190258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3266
 #1: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #1: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

