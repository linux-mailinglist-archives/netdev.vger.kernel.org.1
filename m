Return-Path: <netdev+bounces-289074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO5xFOIVC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF356DBD6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A14203005D12
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51A481A80;
	Mon, 18 May 2026 13:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524740FD80
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111269; cv=none; b=jd+q4N4NwbiRZbAs+t7cAVAgCXWMHJCyRUVIGxQLwgik13lkyeFwKWqWDqIOUf2ezRsS5NEDJiiUzf8TZ4M7EXTm8Dn4kuQWzoXNOIa7YvR19AYfsercJ2c8LMBuvBAV2CBgT1reEyWKMd8CXkraxD+uxjWodY/IbgOdf5KBlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111269; c=relaxed/simple;
	bh=Pn2mFhL6CaBTMy3GCk0GmhF0mTYoLWDtdZGpW5U6iXA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hytyHfpBYG4E5Ks9iApQgTdBAM184QUZVxMBKErNJTjajUa64TkaqkBce5Yh0axUCMIGaY7I0Kp8/ydgOs7pNF+pbgI2/LVOHjRSLo1vBFuE8H1hRbPhgTQAuah0UyBqbK3mGmgNl7OwKZ2fjciCYvsLPtnHo3S/UuBMAPJI/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4398773e510so2145610fac.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111266; x=1779716066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ8tWaye7oXuGI3Og5Cutpuk+MQQBLH3Fypi3gFwBF8=;
        b=cFaC1q6O+l+TkYOx8gS0LUuHNP5efnZ/tVXaiSt1BcY6L2IgsdBzN7qbHO8PYu73CP
         QKr/3numnvFu5mIafi2CAE4cCLgtDXo6EDnjznuxHPspNjV0Rfn69KB2jgHee6DuhQ8A
         torxI1Ryxe6LW2w5F7644vqfDfdjyRjRsNkw1t/4ucJWzLmSdJby0ZXzuVIV5OVXIV1w
         oGTTORuMIx0olb6SoJCabsCEei0MUHhV+gOYipsBZtwLxcMuyv6qwhvvrtqDvEKkjvX1
         n0SqXhRG15+uDY2ZjjSeBpVueoFUBbb+3Oj5+5PJLaJHd58ZOk7Oifm/SOFx/EbtnaH3
         Yw6w==
X-Forwarded-Encrypted: i=1; AFNElJ9HOTxIRCubKKrZUZEHCcvEwo19R63VWPDuM2VsJeO0Q0Nah2QTF5zZhmyx0bMYr2As6Yyfubw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzrNiI7TbYc7ls5XaDGHNDZEirsT5GnfxyPW2ILTjeML96FYC
	GxqB0I2ylUG0z5HCZcCrRRCJefCsXJIKVxJep+ltpIEA7KYpD5O0mfUqv6UQV4+ACTnqmyecZa0
	ZYuWP0gdzyzbv+X5e973xENstvwmoh8LSbxfgpuiTdys2pvulrQwP6X8Q4H0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3103:b0:696:6440:9e2a with SMTP id
 006d021491bc7-69c9437a8fdmr8773023eaf.29.1779111266594; Mon, 18 May 2026
 06:34:26 -0700 (PDT)
Date: Mon, 18 May 2026 06:34:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0b1562.050a0220.67a24.012e.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in svc_listen (2)
From: syzbot <syzbot+3febffd6d2ea432770c6@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,lists.sourceforge.net,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-289074-lists,netdev=lfdr.de,3febffd6d2ea432770c6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.234.253.10:from];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A6DF356DBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    aaec7096f996 net: hsr: defer node table free until after R..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe2536580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=3febffd6d2ea432770c6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bdd02e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5e02e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e91c83cade4/disk-aaec7096.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ec0ff6fa021/vmlinux-aaec7096.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b593c2df20a5/bzImage-aaec7096.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3febffd6d2ea432770c6@syzkaller.appspotmail.com

INFO: task syz.4.342:7421 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.342       state:D stack:27032 pid:7421  tgid:7420  ppid:5800   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x1821/0x5740 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7283
 svc_listen+0x2c3/0x500 net/atm/svc.c:311
 __sys_listen_socket net/socket.c:1987 [inline]
 __sys_listen net/socket.c:2002 [inline]
 __do_sys_listen net/socket.c:2007 [inline]
 __se_sys_listen net/socket.c:2005 [inline]
 __x64_sys_listen+0x1c7/0x240 net/socket.c:2005
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa947d9ce59
RSP: 002b:00007fa948b90028 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007fa948015fa0 RCX: 00007fa947d9ce59
RDX: 0000000000000000 RSI: 0000000000000081 RDI: 0000000000000004
RBP: 00007fa947e32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa948016038 R14: 00007fa948015fa0 R15: 00007ffdf1c6c548
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
6 locks held by kworker/u8:3/48:
5 locks held by kworker/u8:7/153:
 #0: ffff8880b873aea0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:652
 #1: ffff8880b8724588 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
 #2: ffff8880b8726118 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x8ee/0xf30 kernel/time/timer.c:1117
 #3: ffffffff9a6b8cf0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x83/0x580 lib/debugobjects.c:835
 #4: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1181 [inline]
 #4: ffffffff8e95cda0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0xa6/0x2550 arch/x86/kernel/unwind_orc.c:495
8 locks held by kworker/u8:9/3273:
2 locks held by getty/5386:
 #0: ffff888032a2e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13a0 drivers/tty/n_tty.c:2211
1 lock held by syz.4.342/7421:
 #0: ffff8880349b6260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff8880349b6260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
1 lock held by syz.1.414/7744:
 #0: ffff8880222c7260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff8880222c7260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
1 lock held by syz.3.611/8709:
 #0: ffff88807cccf260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff88807cccf260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
1 lock held by syz.6.637/8830:
 #0: ffff88801bbae260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff88801bbae260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
1 lock held by syz.0.742/9319:
 #0: ffff88802a79a260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff88802a79a260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
1 lock held by syz.9.990/10528:
 #0: ffff8880352ba260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff8880352ba260 (sk_lock-AF_ATMSVC){+.+.}-{0:0}, at: svc_listen+0x13f/0x500 net/atm/svc.c:295
2 locks held by syz.2.1305/11970:
 #0: ffffffff8fdc1568 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4f7/0x730 net/core/net_namespace.c:575
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_exit_rtnl_list net/core/net_namespace.c:173 [inline]
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_undo_list+0x2a4/0x940 net/core/net_namespace.c:248
2 locks held by syz.7.1304/11974:
 #0: ffffffff8fdc1568 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4f7/0x730 net/core/net_namespace.c:575
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_exit_rtnl_list net/core/net_namespace.c:173 [inline]
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_undo_list+0x2a4/0x940 net/core/net_namespace.c:248
2 locks held by syz.8.1307/11978:
 #0: ffffffff8fdc1568 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4f7/0x730 net/core/net_namespace.c:575
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_exit_rtnl_list net/core/net_namespace.c:173 [inline]
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ops_undo_list+0x2a4/0x940 net/core/net_namespace.c:248
2 locks held by syz.5.1308/11983:
 #0: ffffffff8fdc1568 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4f7/0x730 net/core/net_namespace.c:575
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x2d7/0x840 net/ipv4/ip_tunnel.c:1146
2 locks held by syz.4.1309/11988:
 #0: ffffffff8fdc1568 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4f7/0x730 net/core/net_namespace.c:575
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #1: ffffffff8fdd0240 (rtnl_mutex){+.+.}-{4:4}, at: register_netdevice_notifier_net+0x1a/0xa0 net/core/dev.c:2102

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: 9b 7d 02 e9 93 f7 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 91 20 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffc90000197e20 EFLAGS: 00000246
RAX: 00000000001162af RBX: ffffffff819a958a RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8dfa6c27 RDI: ffffffff8c28af60
RBP: ffffc90000197f10 R08: ffff8880b87339db R09: 1ffff110170e673b
R10: dffffc0000000000 R11: ffffed10170e673c R12: 0000000000000001
R13: 1ffff11003b5b000 R14: 0000000000000001 R15: 1ffff11003b5b000
FS:  0000000000000000(0000) GS:ffff88812538a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b34a24224 CR3: 0000000078488000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x36a/0x5f0 kernel/sched/idle.c:352
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:451
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


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

