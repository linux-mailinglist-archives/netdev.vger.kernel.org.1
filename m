Return-Path: <netdev+bounces-159171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C50A149CA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD016AF63
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF951F7070;
	Fri, 17 Jan 2025 06:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419831F5618
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096510; cv=none; b=pzrS0ZQjRDQT+H5zwhXcLGhDE2MxFvpczTl05r5CP+iqaCOUvWFUu8ExZCCgrj3u7WjcO4Im1FfobhbGn8thJTSvzTxxFvsHkfnXPcEqnkVZCDDY3BLhvfl6/1KAXIPBH2pUk3JOg0WVPpBpJoV5njOvd7CD3di4zs/dbfSHD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096510; c=relaxed/simple;
	bh=4CQkWiS/CANn+4bj/cPL/QVWX0V9N3/wL7BP3/DjJPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KgK5DynlbBHTOGVoyBKQU+IkM/IuE2exA+jYJyIt2OA3awPUNm2/2clVJfEuC+GYdb+58facPLEL0oodNBYvY5E9X3pchFQPNgLCxhsPD1mPNs0jbrtzOTG2mKenr2xg7eAS4cUJdHVacbZ8rz6sOhQoiYT6wT5NnNPdVeBtFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso24640975ab.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 22:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737096507; x=1737701307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpYVS7UuCTKuCnjW6qdQHHmhtvaWHWszJQpVE8IEN5c=;
        b=jswpOrP3h6SEf4RPh11E8NK1NQ/MxV1kYLL9TSludkfi2nGtENs7OC8khF9511tLZ3
         3uj2qNhzJbIDBOQfsOOiEdD7siB71V2/VVvKUDCygMbDrRaCrc3sKww060X3KkCN8asP
         hh7zYhjfV1W7mK32LQ1WwvmlU//i6lSOU/I4CtQDuVcNCNnofp/n6Q6F24K3pmvSRGxx
         GzeB+BtMvTZFFEXS1+QyGZz3QTCdpRlsGQOMyh2ssrzm1pFCOtB0mjKL1JqTZD97HlXz
         YS8lLjk2BmOh2TSmcMDi91hDTNSKe4C/LtOPmKaObNMuDCMqTuL9ra8Jn3k/wghvf7Hg
         MOhw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDenQrpz/zgCBLkWpzstohyYGYNkfILBZVt3xX/beCy9aFZ9v/rII3rteedXovXHxniEl09s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bnXYCbAThNG6hFWNJi09RryHAA7GpGqHJxXxfKUjn7t3zDf3
	AwLWP4JjPfyfYKstWUPYpPNuBDEVI9xCgKV+1vFFoPpXQiDaxS54kURo4D4b/TeRwdIITb1b/mn
	2/ETMRP5sipVh0Bug8hjPDKoE/+9uUTQ/rU4Nc61OzPsuaExwMqbnQak=
X-Google-Smtp-Source: AGHT+IE6BmU/+SxprQC2y+VleydHR+cwrlIltsaY74LfelQsnUkaHQzCZcG/pqbFs78oXZG/iS1Zg5zZusQYgB8KM3o15pWeLaKC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3ce:793e:2766 with SMTP id
 e9e14a558f8ab-3cf748a7c8emr7874715ab.8.1737096507355; Thu, 16 Jan 2025
 22:48:27 -0800 (PST)
Date: Thu, 16 Jan 2025 22:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6789fd3b.050a0220.20d369.0055.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in netlink_release (5)
From: syzbot <syzbot+9a69946171ff3136f79f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47e55e4b410f openvswitch: fix lockup on tx to unregisterin..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1106ebc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=9a69946171ff3136f79f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ddbef8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17f83134d012/disk-47e55e4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba503c38dcef/vmlinux-47e55e4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc2734a7d207/bzImage-47e55e4b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a69946171ff3136f79f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5847/1:b..l P1324/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=20025, q=335 ncpus=2)
task:kworker/u8:6    state:R  running task     stack:22896 pid:1324  tgid:1324  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_stack_walk+0x123/0x150 arch/x86/kernel/stacktrace.c:24
Code: b3 ae 09 00 48 85 c0 74 23 4c 89 f7 48 89 c6 4d 89 eb 41 ff d3 66 90 84 c0 74 11 48 89 df e8 e4 af 09 00 83 bd 70 ff ff ff 00 <75> d0 65 48 8b 04 25 28 00 00 00 48 3b 45 d0 75 13 48 83 c4 68 5b
RSP: 0018:ffffc900047af200 EFLAGS: 00000202
RAX: 0000000080000001 RBX: ffffc900047af200 RCX: 0000000080000000
RDX: dffffc0000000000 RSI: ffffc900047a8000 RDI: 0000000000000001
RBP: ffffc900047af290 R08: ffffc900047af600 R09: 0000000000000000
R10: ffffc900047af250 R11: fffff520008f5e4c R12: ffff888027d73c00
R13: ffffffff818b4a10 R14: ffffc900047af2e0 R15: 0000000000000000
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ref_tracker_alloc+0x14b/0x490 lib/ref_tracker.c:203
 __netns_tracker_alloc include/net/net_namespace.h:341 [inline]
 netlink_release+0x16d3/0x1bf0 net/netlink/af_netlink.c:805
 __sock_release net/socket.c:640 [inline]
 sock_release+0x82/0x150 net/socket.c:668
 crypto_netlink_exit+0x40/0x60 crypto/crypto_user.c:498
 ops_exit_list net/core/net_namespace.c:172 [inline]
 cleanup_net+0x802/0xd50 net/core/net_namespace.c:648
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syz-executor    state:R  running task     stack:20528 pid:5847  tgid:5847  ppid:5841   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__reset_page_owner+0x5e/0x430 mm/page_owner.c:295
Code: 84 93 03 00 00 49 89 c7 49 bd 00 00 00 00 00 fc ff df 48 8b 05 13 78 97 0c 49 8d 5c 07 08 48 89 d8 48 c1 e8 03 42 0f b6 04 28 <84> c0 0f 85 8d 03 00 00 8b 03 89 44 24 20 bf 00 28 00 00 e8 ca 03
RSP: 0018:ffffc9000419f8e8 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: ffff88801d481d90 RCX: ffff88807ea18000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffea0001267e00 R08: ffffffff8211704a R09: 1ffffffff2854b10
R10: dffffc0000000000 R11: fffffbfff2854b11 R12: ffffea0001267e08
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801d481d80
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4187
 __d_alloc+0x31/0x700 fs/dcache.c:1646
 d_alloc_pseudo+0x1f/0xb0 fs/dcache.c:1778
 alloc_path_pseudo fs/file_table.c:356 [inline]
 alloc_file_pseudo+0x123/0x290 fs/file_table.c:372
 create_pipe_files+0x33e/0x700 fs/pipe.c:938
 __do_pipe_flags+0x48/0x2d0 fs/pipe.c:973
 do_pipe2+0xd4/0x310 fs/pipe.c:1024
 __do_sys_pipe2 fs/pipe.c:1042 [inline]
 __se_sys_pipe2 fs/pipe.c:1040 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1040
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6300184a49
RSP: 002b:00007ffe9b066098 EFLAGS: 00000246 ORIG_RAX: 0000000000000125
RAX: ffffffffffffffda RBX: 0000555574264af0 RCX: 00007f6300184a49
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 00007ffe9b0660a8
RBP: 00007ffe9b066460 R08: 0000000000000007 R09: 0000555574267560
R10: 0f1fa1570a3a0d66 R11: 0000000000000246 R12: 00007ffe9b0664c0
R13: 0000555574266480 R14: 00007ffe9b0661e0 R15: 00005555742621f8
 </TASK>
rcu: rcu_preempt kthread starved for 10562 jiffies! g20025 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25616 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc6-syzkaller-00133-g47e55e4b410f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:preempt_count_add+0x44/0x190 kernel/sched/core.c:5851
Code: 00 00 00 fc ff df 42 0f b6 04 38 84 c0 0f 85 ed 00 00 00 83 3d 8c 38 cd 18 00 75 07 65 8b 05 cb 44 96 7e 65 01 1d c4 44 96 7e <48> c7 c0 c0 c9 3a 9a 48 c1 e8 03 42 0f b6 04 38 84 c0 0f 85 e4 00
RSP: 0018:ffffc900001e7050 EFLAGS: 00000282
RAX: 0000000080000100 RBX: 0000000000000001 RCX: ffffffff9a3ac903
RDX: dffffc0000000000 RSI: ffffc900001e8000 RDI: 0000000000000001
RBP: ffffc900001e71d8 R08: ffffc900001e7101 R09: 0000000000000000
R10: ffffc900001e71a0 R11: fffff5200003ce40 R12: dffffc0000000000
R13: ffffc900001e71a0 R14: ffffffff814be168 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f62fee00218 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0xb0/0x22d0 arch/x86/kernel/unwind_orc.c:479
 __unwind_start+0x59a/0x740 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4715
 skb_kfree_head net/core/skbuff.c:1084 [inline]
 skb_free_head net/core/skbuff.c:1098 [inline]
 skb_release_data+0x677/0x8a0 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 consume_skb+0x9f/0xf0 net/core/skbuff.c:1436
 can_receive+0x3dc/0x480 net/can/af_can.c:669
 canfd_rcv+0x144/0x260 net/can/af_can.c:703
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x2e0/0x650 net/core/dev.c:5817
 process_backlog+0x662/0x15b0 net/core/dev.c:6149
 __napi_poll+0xcb/0x490 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7093
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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

