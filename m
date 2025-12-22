Return-Path: <netdev+bounces-245672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595DCD4B73
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 06:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F214300A565
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 05:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116513002BB;
	Mon, 22 Dec 2025 05:27:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683C20DD48
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766381254; cv=none; b=bqVong4j99cOaBNRpEqG0KPehitpsa71LWlogeCQwCrUkfU/bkQBC21sxnPBiaRt9V3sFh33ml5AB0HGtbCniRNi425HHtTqJN+6S9zCquaYK/Ptl6mEj5Ivn5jWkDGRpptTSnhqr/KlRC7c6ux1Kg2sK0PoNnEa9xG8oT+56qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766381254; c=relaxed/simple;
	bh=olYZ2QJhbLNSmZAb0alt5I/tBibMERu4ZcJefncBZM4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p+wkHc9e1sYaAJlFefpMFkEouzEfc82HoedLzBWYZgOq1sDsGIP3QNwSJWhjueaVc8sjXZDM5Tq1Coa88IjckCvSZLbiTmDrabsYsjtJSGnfu9WfVx6FtNmCS05rzJi8SzajDOA4KiV0uRNTRxPaHc4wvzlFKURO8y0wieZPdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656b2edce07so6188698eaf.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766381251; x=1766986051;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLNdxcCVCL/XjnGiW5sUArE7woaQiWfVTKp8d6MzjxA=;
        b=mBa9yMpvkWTcduppMiGi0bYKMcQnwNpBzHG3mZwQeg66NT2AeE55dAmjq6sdKtk65Y
         kSt2C2aG4c4T7Kj1kOQ3tze1nXEyRPWqhgT57/BPranKq8IW6HGJtX0Nahadom9FhBrK
         sZRML8R+SiAS3gdCytoKKgp3spxTUhuuoyhhJQIa8FE8y5ANxtnoEYHS9vy31Tcco0Sn
         8fCUxNc5K5ayb0r6i8u8LAzYpJttIJh6mjtZDm/IQ8gqjvc1HKqJ6WALv4I2naNeApR4
         GhSYK3EmIOUYkTxTu/gOjJJPGcyAyn0FA++B9Rl28/6xxTHOD9n66iHCLZB0SzNV2HOA
         F58Q==
X-Forwarded-Encrypted: i=1; AJvYcCVud8JWWKwGhcDdQTDpuF0M6LvWlFA93Hh6nP8vaK00dY3JRKldR00XVAE5Ad1KmJTu4H4YvlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8MYdLeBaGhhH09+ngA6loMCTG4ZHYU2ZPEYGJICUGI33eLhS
	Wc/ir0i3E9smJq6/9hL149/VmxmC19UCcEVHRWb8D3GgW/FSXAL96NSIiYdhae0rGDkKm5fvHQd
	pN0EJwmOcutaXLTRGU/iV3FjJYviFoAf+WPMqbI1kYnk/l9xqn0jbPP2zccI=
X-Google-Smtp-Source: AGHT+IHoqMcU2jPDdYKOABZYg9/Gss9VjYM10tpiWXlE35MC2i2lFveumAVUDZgC4sVN70jEBaYF7rQxWt/G1nPzrSiL8YbeD3zo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2288:b0:659:7c9a:942d with SMTP id
 006d021491bc7-65d0e6c390amr4406808eaf.0.1766381250987; Sun, 21 Dec 2025
 21:27:30 -0800 (PST)
Date: Sun, 21 Dec 2025 21:27:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6948d6c2.a70a0220.25eec0.0083.GAE@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in batadv_iv_send_outstanding_bat_ogm_packet
 (6)
From: syzbot <syzbot+62348313fb96b25955aa@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    516471569089 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ead77c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=62348313fb96b25955aa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f4d58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a94a2d04644/disk-51647156.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31d4eeac4086/vmlinux-51647156.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e58508861b69/bzImage-51647156.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62348313fb96b25955aa@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5953/1:b..l P3819/1:b..l P36/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=8897, q=377 ncpus=2)
task:kworker/u8:2    state:R  running task     stack:22840 pid:36    tgid:36    ppid:2      task_flags:0x24248060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7190
 irqentry_exit+0x1d8/0x8c0 kernel/entry/common.c:216
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:138 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:145 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:649 [inline]
RIP: 0010:cpu_online include/linux/cpumask.h:1231 [inline]
RIP: 0010:trace_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:lock_acquire+0x3b/0x330 kernel/locking/lockdep.c:5831
Code: 89 d5 41 54 45 89 c4 55 89 cd 53 48 89 fb 48 83 ec 38 65 48 8b 05 cd b4 18 12 48 89 44 24 30 31 c0 66 90 65 8b 05 e9 b4 18 12 <83> f8 07 0f 87 a2 02 00 00 89 c0 48 0f a3 05 72 b8 ee 0e 0f 82 74
RSP: 0018:ffffc90000ac66d0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8e3c9620 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e3c9620
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000008490 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xd1/0x20b0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x25e/0x770 mm/slub.c:5270
 mempool_alloc_noprof+0x1b4/0x2f0 mm/mempool.c:567
 bio_alloc_bioset+0x3de/0x8c0 block/bio.c:565
 bio_alloc_clone block/bio.c:873 [inline]
 bio_split+0x13b/0x440 block/bio.c:1711
 bio_submit_split_bioset+0x31/0xa40 block/blk-merge.c:122
 bio_submit_split+0xa8/0x160 block/blk-merge.c:152
 __bio_split_to_limits block/blk.h:402 [inline]
 blk_mq_submit_bio+0x67b/0x2c50 block/blk-mq.c:3184
 __submit_bio+0x3cc/0x690 block/blk-core.c:637
 __submit_bio_noacct_mq block/blk-core.c:724 [inline]
 submit_bio_noacct_nocheck+0x53d/0xbe0 block/blk-core.c:755
 submit_bio_noacct+0x5bd/0x1f40 block/blk-core.c:879
 ext4_io_submit+0xa6/0x140 fs/ext4/page-io.c:404
 ext4_do_writepages+0xe42/0x3c80 fs/ext4/inode.c:2952
 ext4_writepages+0x37a/0x7d0 fs/ext4/inode.c:3026
 do_writepages+0x27a/0x600 mm/page-writeback.c:2598
 __writeback_single_inode+0x168/0x14a0 fs/fs-writeback.c:1737
 writeback_sb_inodes+0x72e/0x1ce0 fs/fs-writeback.c:2030
 __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2107
 wb_writeback+0x799/0xae0 fs/fs-writeback.c:2218
 wb_check_old_data_flush fs/fs-writeback.c:2322 [inline]
 wb_do_writeback fs/fs-writeback.c:2375 [inline]
 wb_workfn+0x8a0/0xbb0 fs/fs-writeback.c:2403
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
task:kworker/u8:14   state:R  running task     stack:25480 pid:3819  tgid:3819  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7190
 irqentry_exit+0x1d8/0x8c0 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x79/0x330 kernel/locking/lockdep.c:5872
Code: 82 74 02 00 00 8b 35 0a e9 ee 0e 85 f6 0f 85 8d 00 00 00 48 8b 44 24 30 65 48 2b 05 89 b4 18 12 0f 85 ad 02 00 00 48 83 c4 38 <5b> 5d 41 5c 41 5d 41 5e 41 5f e9 08 38 e1 09 65 8b 05 95 b4 18 12
RSP: 0018:ffffc9000d107a00 EFLAGS: 00000296
RAX: 0000000000000000 RBX: ffffffff8e3c9620 RCX: 0000000042e2d81e
RDX: 0000000000000000 RSI: ffffffff8daa7da3 RDI: ffffffff8bf2b380
RBP: 0000000000000002 R08: 000000007a5a0105 R09: 0000000057a5a010
R10: 0000000000000002 R11: ffff888033fc0b30 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 batadv_iv_ogm_slide_own_bcast_window net/batman-adv/bat_iv_ogm.c:761 [inline]
 batadv_iv_ogm_schedule_buff+0x5d0/0x14c0 net/batman-adv/bat_iv_ogm.c:833
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:873 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:866 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x329/0x920 net/batman-adv/bat_iv_ogm.c:1709
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
task:udevd           state:R  running task     stack:27112 pid:5953  tgid:5953  ppid:5190   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_notrace+0x62/0xe0 kernel/sched/core.c:7140
 preempt_schedule_notrace_thunk+0x16/0x30 arch/x86/entry/thunk.S:13
 rcu_is_watching+0x8e/0xc0 kernel/rcu/tree.c:752
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x201/0x2d0 kernel/locking/lockdep.c:5879
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0x3f9/0x20b0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x25e/0x770 mm/slub.c:5270
 lsm_file_alloc security/security.c:169 [inline]
 security_file_alloc+0x34/0x2b0 security/security.c:2380
 init_file+0x93/0x4c0 fs/file_table.c:159
 alloc_empty_file+0x73/0x1e0 fs/file_table.c:241
 path_openat+0xde/0x3140 fs/namei.c:4773
 do_filp_open+0x20b/0x470 fs/namei.c:4814
 do_sys_openat2+0x121/0x290 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d5b8a7407
RSP: 002b:00007ffee52231a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0d5c0b1880 RCX: 00007f0d5b8a7407
RDX: 0000000000080000 RSI: 0000559b925f46d0 RDI: ffffffffffffff9c
RBP: 0000559b925f46d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000009
 </TASK>
rcu: rcu_preempt kthread starved for 10623 jiffies! g8897 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28328 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xaf0 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x26d/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6101 Comm: syz.1.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__lock_acquire+0x58/0x2890 kernel/locking/lockdep.c:5098
Code: 18 12 48 89 44 24 68 31 c0 85 db 0f 84 54 04 00 00 48 8b 07 49 89 fd 48 3d 00 86 b9 93 0f 84 42 04 00 00 44 8b 1d c8 b5 92 0c <45> 89 c7 89 f5 89 d3 45 89 c8 45 85 db 74 5d 48 3d 10 86 b9 93 74
RSP: 0018:ffffc90002fe78f8 EFLAGS: 00000006
RAX: ffffffff9ac2cf60 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888079e8d510
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc90002fe7bd8 R11: 0000000000000001 R12: ffff88802db2c980
R13: ffff888079e8d510 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fa9d7eb66c0(0000) GS:ffff8881249f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa9d7eb5f98 CR3: 000000005b10e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x1aa/0x1ca0 kernel/locking/mutex.c:776
 seccomp_do_user_notification.constprop.0+0xaa/0xe80 kernel/seccomp.c:1173
 __seccomp_filter+0x8ea/0x11f0 kernel/seccomp.c:1338
 __secure_computing+0x287/0x3b0 kernel/seccomp.c:1404
 syscall_trace_enter+0x89/0x220 kernel/entry/syscall-common.c:44
 syscall_enter_from_user_mode_work include/linux/entry-common.h:78 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:109 [inline]
 do_syscall_64+0x42b/0xf80 arch/x86/entry/syscall_64.c:90
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa9d6f8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa9d7eb60e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fa9d71e5fa8 RCX: 00007fa9d6f8f749
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa9d71e5fa8
RBP: 00007fa9d71e5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa9d71e6038 R14: 00007ffd414eed50 R15: 00007ffd414eee38
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

