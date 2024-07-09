Return-Path: <netdev+bounces-110360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5292C1D6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCE3B2F84F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B819F46C;
	Tue,  9 Jul 2024 16:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F921BA09C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542991; cv=none; b=Jr8O/TJKZisp8kh0dE1BCTn40DxDRaxlCOMBkYmgkoNUQQ7RELaGcg2O6G7x/tAbwv1rzwCY8XOWEeEkoHvulE5akW1FM8rQnnkXjjOq6fJ4f7NUAzdVtK/sGKOwol2ltoNuhfXeoygn9csAPcUoaR+FE3SK36zX6fnQ2kSd8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542991; c=relaxed/simple;
	bh=qqS5OvRaae29ac9kwES2jIKPAVwClTEX6cpHaftAANI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UCx86hRSRadpdGzV/CfZrteYptDYrdPPdbyptNpYR4HiYTyn4zVF8J/5AJ6PZM7QgHfbQknamTOl7lQdHjHuiNtMF664VklMQSdaWFhxcWutVAJQ9a7/fSzYhlgNnaej65hKhLZfCAOYKilYVv0LobxHD1mGTEe4zocjeR8DqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f99b5431b8so332838139f.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 09:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542988; x=1721147788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHYXkvODGj06lZewjFBN8RTbzQIryegM4cG55wvsH2o=;
        b=ipAE8y08yq2nCBhuNm5llfeWGNtrQwLOEOZ/C3xtcYzb/Gt46WcfFxDqUCt7l7B9Ea
         i9TWs7H7SKRMnCCWDSZLuQFeowzceE1WqrQ0SEcjgSpzy1ERe6Wxp/QJRluXNHkC6ooC
         ccqOjuHw6OgJ+4xv7jpaPYabUvI2rmaT5tSLANtWuqdmFeRONmhIP68t8n2tCrH8VPqw
         Fy7n4hQV+s3lXq4q4C824Hi7oTe2YR7g/1kpdLrtlCc09wvEL8kPLhm7zLIJWL6elcq4
         N55cpBNxXA0/D1XyKMHFu+c9NlulNnNFJ32ak9v7FMbmo0rozsDOgM/np1aSv9+Vyu3Y
         30+g==
X-Forwarded-Encrypted: i=1; AJvYcCV87Ma45JuWzUER3ZOntP0tHkprbURlXAocZaE8zM/XjQtR8iclXeR9pK6YAEXxMTRXdpQ2Aw6wT2iFo5sGnWxSkQ63+4tE
X-Gm-Message-State: AOJu0Yxz2McFV4F3TgL+FSxxlnzIRri1f02GegrgfuhpylPxOc7BT9+x
	INkoPMn9DeDUFPdtkpf9enbABIPqzi8X24ySRaWU4+dIuA/6oyUFkgMqbFUKEmREECKkGkjKl/o
	jhuxYNL27mcO0lFsR0nX/jhIFN9lntOehi9+na0eRvqhSFyUHK6G0s+4=
X-Google-Smtp-Source: AGHT+IFMU8GcrMmQ3QW8Xe1tnyFFJp414zoT1uBqwsUoOudRZPPKwYDupXmCWQ2xQJwJSMRtva9/+h3Lt1eaAgAqzwoCeBy90IOq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:610c:b0:7f9:abec:dcde with SMTP id
 ca18e2360f4ac-7ffffc367e3mr11809439f.1.1720542988454; Tue, 09 Jul 2024
 09:36:28 -0700 (PDT)
Date: Tue, 09 Jul 2024 09:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5de14061cd3215f@google.com>
Subject: [syzbot] [net?] [serial?] INFO: task hung in filemap_fault (6)
From: syzbot <syzbot+cbbcd52813dd10467cfe@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	ivecera@redhat.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4376e966ecb7 Merge tag 'perf-tools-fixes-for-v6.10-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ccb031980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=cbbcd52813dd10467cfe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/78d3fb79d8a7/disk-4376e966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ab2a3a6286f/vmlinux-4376e966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b25d95b9757e/bzImage-4376e966.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbbcd52813dd10467cfe@syzkaller.appspotmail.com

INFO: task syz.1.4917:19167 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.4917      state:D stack:24672 pid:19167 tgid:19167 ppid:18074  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
 filemap_fault+0xb5b/0x1760 mm/filemap.c:3320
 __do_fault+0x135/0x460 mm/memory.c:4556
 do_shared_fault mm/memory.c:4981 [inline]
 do_fault mm/memory.c:5055 [inline]
 do_pte_missing mm/memory.c:3897 [inline]
 handle_pte_fault+0x119b/0x7090 mm/memory.c:5381
 __handle_mm_fault mm/memory.c:5524 [inline]
 handle_mm_fault+0xfb0/0x19d0 mm/memory.c:5689
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fa837e4a10e
RSP: 002b:00007ffd63127370 EFLAGS: 00010246
RAX: 0000000000008400 RBX: 0000000000000001 RCX: fffffffffffffcff
RDX: a9ff1748001aba72 RSI: 0000000020000300 RDI: 000055557cdd93c8
RBP: fffffffffffffffe R08: 00007fa837e00000 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000001 R12: 00007fa838103f6c
R13: 0000000000000032 R14: 00007fa838105a60 R15: 00007fa838103f60
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900001f7d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900001f7d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
5 locks held by kworker/u8:5/80:
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000231fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000231fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5c80d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:630
 #4: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #4: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
2 locks held by kworker/u8:6/962:
2 locks held by getty/4840:
 #0: ffff88802b2b60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by kworker/u8:18/9185:
 #0: ffff88802a6c4948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88802a6c4948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000ffb7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000ffb7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4193
2 locks held by kworker/u8:22/9194:
 #0: ffff8880b943e758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9428948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
1 lock held by syz.2.1532/9540:
1 lock held by syz.0.1583/9698:
1 lock held by syz.4.4498/17805:
3 locks held by kworker/1:6/18520:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900032ffd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900032ffd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by syz.1.4917/19167:
 #0: ffff8880498a0070 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:683 [inline]
 #0: ffff8880498a0070 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:5845
 #1: ffff88801d55e548 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
 #1: ffff88801d55e548 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_fault+0xb5b/0x1760 mm/filemap.c:3320
1 lock held by syz-executor/19271:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x1b0 drivers/net/tun.c:3500
1 lock held by syz.1.5136/19866:
 #0: ffff88801d55e548 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
 #0: ffff88801d55e548 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz-executor/19951:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
3 locks held by syz-executor/19971:
 #0: ffffffff8f63ad70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f63ac28 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f63ac28 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f63ac28 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: wg_set_device+0x102/0x2160 drivers/net/wireguard/netlink.c:504
1 lock held by syz-executor/20338:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
1 lock held by syz.3.5348/20433:
 #0: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #0: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:939

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5190 Comm: kworker/0:6 Not tainted 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events drain_vmap_area_work
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:206
Code: 8b 3d 0c 3c 44 0c 48 89 de 5b e9 c3 f6 56 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 80 d4 03 00 65 8b 15 b0 ad 6d 7e f7 c2 00 01 ff 00
RSP: 0018:ffffc90004867450 EFLAGS: 00000202
RAX: ffffffff8140eea1 RBX: ffffc900048674c8 RCX: ffffffff91018000
RDX: ffff888021093c00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8140ee98 R09: ffffffff8141095f
R10: 0000000000000003 R11: ffff888021093c00 R12: ffff888021093c00
R13: ffffffff8181dca0 R14: dffffc0000000000 R15: 1ffff9200090ce99
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7b6037d60 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_get_return_address+0x71/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x75/0x3f0 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2746 [inline]
 apply_to_pmd_range mm/memory.c:2790 [inline]
 apply_to_pud_range mm/memory.c:2826 [inline]
 apply_to_p4d_range mm/memory.c:2862 [inline]
 __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2896
 kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
 purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2207
 __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2289
 drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2323
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

