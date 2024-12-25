Return-Path: <netdev+bounces-154225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF59FC2EE
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 01:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D57F1882E93
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D25881E;
	Wed, 25 Dec 2024 00:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939636C
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735086149; cv=none; b=WbYSU9Kw1l4mmkKAHcAombhgbO3Thtyr2LCAxqi0pnKO67WmCt3Gb/va54g6ezfsJUt19V4x37VmEB6wg4xbUopIHGLiSN/P1GDjUaLBaNXvItT4y7cUObWu9TH2NpwIDk2AuXdG9PdtKQ8NQYoTTqrsKiYKtaPxtOrsU3Zb824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735086149; c=relaxed/simple;
	bh=7hAh1EbFzVveTFL3v+bsuBBBM7+4cLsYowGM6rJHLNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJC2evA4utGg8vvFmVADHjtXU6qus10JdC98bRlPd2M1wi9OCw/jfWRNoRpB6uJO0Ef9LjECeerUFsIgMN1v1eadP3TYraQlU2zVJ1jaoxwLvw5IPxXbrmPNqvOM4iDPfkl9MzzcPIa3acfYCmyv4L3LYJr6kZeoHMdjaUDV/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844cfac2578so887647539f.2
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 16:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735086145; x=1735690945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bC0nCDQWQYTQweymYbdOf43R00Mg6UnM8QfMQisIzg=;
        b=DhC8lZ2nBNHsIEAjQt+PkVDQFIklktoyKT2T3bt+OA4pgR2F6dB+mAE82NUPB9UlMH
         kAmdMupIwo0jHPmSSeG504wfhJc6XdH6BGbpMGGeue5kfUEWhBMgUZN6kyMCl5JTRgI4
         WAzlAFo1gfkcdd1Robg+xJJaRixfomg3Gp/RWCFzRKMFfPZmNXmYqhyi8Ktr1nFOi+jI
         4N3is8yNOogWHD7XGBc6d1vbqCEGJRrdgEKo7vFjmI8zpseHC32l4w9Q/2QEr62O1gQa
         iNiNbvFr0dQiqZv1VYYD14WuKWQzWB6Yr1HVGXmIjlIVIo2gEJDEMWdQaQRUC+7S06Cr
         q1ng==
X-Forwarded-Encrypted: i=1; AJvYcCW3K1HJNmUZTyJzPMgi9cNgfEw/VdSYBiJ0ui/FABERtCIlKbpKvMGPAecshWDFG5QXsUe75Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFboqGcdOrLO4BdyErFL8F6ywa3O9Vpbe1iy2+ZdWUU5vRZz6
	haPyU4DxAM/VqgcrP6H3l3H2XtJ8ESL0HNmlcC5HlAvSMla0vbATJQZ8SthnN+xNceYDLmdVjNH
	CEZv4EZmnYE4qbM6ODjO6hjjFv+pXJqxTWrYrcFv6fxXG6aZv64W0Vwk=
X-Google-Smtp-Source: AGHT+IHcZpWLglKQTRENKweskrNI3qXOKbmCPqR5/WJbEiOy3bgVg0rlof2lCrbNdDzK6KMFIR76XYSXtneB9bAr6pq5/WbVQUwi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:c60b:ad90 with SMTP id
 e9e14a558f8ab-3c2d1e7df4cmr204362455ab.3.1735086145276; Tue, 24 Dec 2024
 16:22:25 -0800 (PST)
Date: Tue, 24 Dec 2024 16:22:25 -0800
In-Reply-To: <6730d6bd.050a0220.1fb99c.0139.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676b5041.050a0220.226966.005e.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_pipe2 (2)
From: syzbot <syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12cbff30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=693a483dd6ac06c62b09
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7c2f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6064/1:b..l P5830/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=9625, q=129 ncpus=2)
task:syz-executor    state:R  running task     stack:19824 pid:5830  tgid:5830  ppid:5825   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 9a 23 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90003cef880 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200079df1c RCX: ffff888070cd8ad8
RDX: dffffc0000000000 RSI: ffffffff8c0aa960 RDI: ffffffff8c5faee0
RBP: ffffc90003cef9c8 R08: ffffffff942bc887 R09: 1ffffffff2857910
R10: dffffc0000000000 R11: fffffbfff2857911 R12: 1ffff9200079df18
R13: dffffc0000000000 R14: ffffc90003cef8e0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __reset_page_owner+0x30/0x430 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
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
 alloc_inode+0x87/0x1a0 fs/inode.c:338
 get_pipe_inode fs/pipe.c:882 [inline]
 create_pipe_files+0x50/0x700 fs/pipe.c:922
 __do_pipe_flags+0x48/0x2d0 fs/pipe.c:973
 do_pipe2+0xd4/0x310 fs/pipe.c:1024
 __do_sys_pipe2 fs/pipe.c:1042 [inline]
 __se_sys_pipe2 fs/pipe.c:1040 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1040
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7ba984a49
RSP: 002b:00007ffd7e9fe8a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000125
RAX: ffffffffffffffda RBX: 00005555802a2af0 RCX: 00007fa7ba984a49
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd7e9fe8c0
RBP: 00007ffd7e9fec70 R08: 00000000114dcd36 R09: 00005555802a44a8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd7e9fecd0
R13: 00005555802a4480 R14: 00007ffd7e9fe9f0 R15: 00005555802a0548
 </TASK>
task:syz-executor    state:R  running task     stack:24736 pid:6064  tgid:6064  ppid:5830   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6935
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6959
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x18f8/0x22d0 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 __slab_free+0x2c2/0x380 mm/slub.c:4524
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 vma_lock_alloc kernel/fork.c:446 [inline]
 vm_area_alloc+0x10e/0x1d0 kernel/fork.c:477
 __mmap_new_vma mm/vma.c:2340 [inline]
 __mmap_region+0x196e/0x2cd0 mm/vma.c:2456
 mmap_region+0x1d0/0x2c0 mm/mmap.c:1348
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 elf_map fs/binfmt_elf.c:391 [inline]
 elf_load+0x25a/0x700 fs/binfmt_elf.c:414
 load_elf_binary+0x100c/0x2770 fs/binfmt_elf.c:1173
 search_binary_handler fs/exec.c:1748 [inline]
 exec_binprm fs/exec.c:1790 [inline]
 bprm_execve+0xaf5/0x17a0 fs/exec.c:1842
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1949
 do_execve fs/exec.c:2023 [inline]
 __do_sys_execve fs/exec.c:2099 [inline]
 __se_sys_execve fs/exec.c:2094 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2094
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7ba9b93f7
RSP: 002b:00007fa7bb6dbdf8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00007ffd7ea00ef5 RCX: 00007fa7ba9b93f7
RDX: 00007ffd7e9fe6b0 RSI: 00007ffd7e9fe8f0 RDI: 00007ffd7ea00ef5
RBP: 00007fa7bb6dbe70 R08: 00007fa7bb6dbf20 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000206 R12: 00007ffd7e9fe8f0
R13: 00007ffd7e9fe6b0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10494 jiffies! g9625 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25328 pid:17    tgid:17    ppid:2      flags:0x00004000
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
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:deref_stack_reg+0x7/0x210 arch/x86/kernel/unwind_orc.c:402
Code: 00 e9 9d fe ff ff e8 58 ab 7f 0a 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 41 55 <41> 54 53 48 83 ec 20 48 89 54 24 18 49 89 f0 49 89 fe 48 ba 00 00
RSP: 0018:ffffc900001e62c8 EFLAGS: 00000283
RAX: fffffffffffffff0 RBX: ffffffff90a2d262 RCX: 0000000000000000
RDX: ffffc900001e6460 RSI: ffffc900001e64b0 RDI: ffffc900001e6420
RBP: dffffc0000000000 R08: ffffc900001e647f R09: 0000000000000000
R10: ffffc900001e6470 R11: fffff5200003cc90 R12: ffffc900001e8000
R13: ffffc900001e6420 R14: ffffffff818b3918 R15: ffffc900001e6470
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe448899de8 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 unwind_next_frame+0x1799/0x22d0
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
 skb_release_all net/core/skbuff.c:1188 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x194/0x380 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1271 [inline]
 kfree_skb include/linux/skbuff.h:1280 [inline]
 ip6_mc_input+0xa1f/0xc30 net/ipv6/ip6_input.c:587
 ip_sabotage_in+0x203/0x290 net/bridge/br_netfilter_hooks.c:1021
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 __netif_receive_skb_one_core net/core/dev.c:5672 [inline]
 __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
 NF_HOOK+0x9e/0x400 include/linux/netfilter.h:314
 br_handle_frame_finish+0x1905/0x2000
 br_nf_hook_thresh+0x472/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:282 [inline]
 br_handle_frame+0x9f3/0x1530 net/bridge/br_input.c:433
 __netif_receive_skb_core+0x14eb/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcb/0x490 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7074
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 11535 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
net_ratelimit: 17751 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

