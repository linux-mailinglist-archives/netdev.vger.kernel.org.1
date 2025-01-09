Return-Path: <netdev+bounces-156691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13654A07743
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49D13A83F8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB021884B;
	Thu,  9 Jan 2025 13:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CC214A6D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429009; cv=none; b=TDgGj1aeL3wpmcNa0hxTLwPt135g5kJDZFIyT15laYBR6jcWWlo6PTMM8BUO1Xu6BN3/DGxG/pMbnZe4nIPAzeAa9jK1xcfQyaX7j57iHLhI6SkqUTjFC5UM/xtmr7BNzNBOtK3/GAH75VzyzS+W97YCUzxT/X10+t6KGVkSUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429009; c=relaxed/simple;
	bh=/6Xk7n3ZwI/rIRcaVeBFIFklIWkCzxsHYBq276bKjZI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f1+kZO/zhtSeDkY2u/phnvohEfdR74A9H1b/O/hjSjrWvlEVWIRNcg420ewJ93Xp1xGAmMgwGKSBTeSuONvNNOZBpZaEGukZqnFdSTdwmo1/l+y7ICq3z8HJVp5mQmxPQzboQ0j3RNOno9ggHYtbZfc1AazrEtu0Cc+4VGeesTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so7374955ab.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 05:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429006; x=1737033806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiumSprKWM10ICN7wHe1Grl8cQgkz0V/kqVp31ytsyg=;
        b=ghJE72m1xs3eelLT5D8n8q+xUhMmc4lJDGio4oxxDzdih2sV6dS1zoi22BnCCXc0j/
         09fKSYYb6KLA9Mj2SSQTqjcwbkRgxcY4EFTJGTFMW5AXH4JCuySe/XzOymy+mhAs4S67
         iPVMON3fUJRg62EeQUUjwxT/Q5ho/RjjzR1okFSbf/ZhURAco014BPpn6DhNI+hnc16S
         Q4IHTkIzO2GQlrY1JKQ/qmH5tfF+Csz1hJdezczymn8ioi3jFAfQTQqNuk0XxfjdtNEq
         Cp6pKQr4hE+YjHouOgFICqWcapzruRHSS9wUtogbdWP/fblaDXRRSisbw2bOfb6PU6rH
         CMPA==
X-Forwarded-Encrypted: i=1; AJvYcCVRFotOS7PP4SSxXgiWvK4i+8/vso3dFQUP7ntu+RtHq+/Dak2NpzzhmtBSP7p6cfLhzIIsNvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjxn6/qxZ5bu2PAyYCFwDJWvrdxMe7c3q8+h+F5IZIesB9Ooff
	CEPtj/WgGJptWpGrJ+LGQCF3wpeEd+KcfOYH17WxSk53JrZF1YLhLFsVolIbomrLvYlLTYu6Ure
	lK8Rpmm3eCvYp23zWPKH575x0OfFqmy4Mr5mCvsngRWKuWOA+on2+vhs=
X-Google-Smtp-Source: AGHT+IHd/QsVH8bGMiQAFa6zInEtQa57uuqPGZz4LswGaNC8zzzdAINam4wpIdvnWrfWs58uLLe2LQy0UskqOQmGLSA3yn1vppia
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3cd:da4e:2a90 with SMTP id
 e9e14a558f8ab-3ce3a9c7d64mr41589315ab.11.1736429005729; Thu, 09 Jan 2025
 05:23:25 -0800 (PST)
Date: Thu, 09 Jan 2025 05:23:25 -0800
In-Reply-To: <6708ce33.050a0220.3e960.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677fcdcd.050a0220.25a300.01c1.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_mprotect (8)
From: syzbot <syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    31eae6d99587 selftests: drv-net: test drivers sleeping in ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170e81df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=289acde585746aad
dashboard link: https://syzkaller.appspot.com/bug?extid=6f7c31cf5ae4944ad6f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d7270f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4718c6cc0087/disk-31eae6d9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ad3425b5ce9/vmlinux-31eae6d9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9da77adda42e/bzImage-31eae6d9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (3 ticks this GP) idle=5abc/1/0x4000000000000000 softirq=13965/13965 fqs=0
rcu: 	(detected by 0, t=13596 jiffies, g=9241, q=718 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6085 Comm: modprobe Not tainted 6.13.0-rc5-syzkaller-00873-g31eae6d99587 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__kasan_check_read+0xa/0x20 mm/kasan/shadow.c:31
Code: db eb d0 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 89 f6 48 8b 0c 24 <31> d2 e9 6f e6 ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
RSP: 0018:ffffc90000a189c0 EFLAGS: 00000007
RAX: 0000000000000024 RBX: 000000000000092d RCX: ffffffff817b274a
RDX: 0000000000000008 RSI: 0000000000000008 RDI: ffffffff942bd9a0
RBP: 0000000000000008 R08: ffffffff942bd9a7 R09: 1ffffffff2857b34
R10: dffffc0000000000 R11: fffffbfff2857b35 R12: ffff88802c2d28c4
R13: dffffc0000000000 R14: 0000000000000100 R15: ffff88802c2d2908
FS:  00007f1458250380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14583bafe4 CR3: 0000000033060000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class kernel/locking/lockdep.c:228 [inline]
 mark_lock+0x9a/0x360 kernel/locking/lockdep.c:4727
 mark_usage kernel/locking/lockdep.c:4670 [inline]
 __lock_acquire+0xc3e/0x2100 kernel/locking/lockdep.c:5180
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xab/0xca0 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59b/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:stack_trace_consume_entry+0xf5/0x280 kernel/stacktrace.c:93
Code: 00 fc ff df 48 8b 1b 45 8d 70 01 41 0f b6 04 17 84 c0 0f 85 31 01 00 00 45 89 31 4a 8d 1c c3 48 89 d8 48 c1 e8 03 80 3c 10 00 <74> 1a 4d 89 cf 48 89 df 49 89 d6 49 89 f5 e8 68 a2 7a 00 4d 89 f9
RSP: 0018:ffffc900030c7230 EFLAGS: 00000246
RAX: 1ffff92000618e8c RBX: ffffc900030c7460 RCX: ffffffff917a4000
RDX: dffffc0000000000 RSI: ffffffff8be00130 RDI: ffffc900030c736c
RBP: ffffc900030c7368 R08: 000000000000000c R09: ffffc900030c7370
R10: ffffc900030c72d0 R11: ffffffff818b39d0 R12: 1ffff92000618e6d
R13: 1ffff92000618e6d R14: 000000000000000d R15: 1ffff92000618e6e
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 kmem_cache_alloc_bulk_noprof+0x4fa/0x7c0 mm/slub.c:5129
 mt_alloc_bulk lib/maple_tree.c:181 [inline]
 mas_alloc_nodes+0x38e/0x7e0 lib/maple_tree.c:1275
 mas_node_count_gfp lib/maple_tree.c:1335 [inline]
 mas_preallocate+0x575/0x8d0 lib/maple_tree.c:5545
 vma_iter_prealloc mm/vma.h:349 [inline]
 __split_vma+0x302/0xc50 mm/vma.c:447
 split_vma mm/vma.c:510 [inline]
 vma_modify+0x244/0x330 mm/vma.c:1528
 vma_modify_flags+0x3a5/0x430 mm/vma.c:1546
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:666
 do_mprotect_pkey+0x8d7/0xd70 mm/mprotect.c:840
 __do_sys_mprotect mm/mprotect.c:861 [inline]
 __se_sys_mprotect mm/mprotect.c:858 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:858
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1458574bb7
Code: 00 00 00 b8 0b 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d b9 46 01 00 f7 d8 89 01 48 83 c8 ff c3 b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 99 46 01 00 f7 d8 89 01 48 83
RSP: 002b:00007fffaf755208 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f1458551fc0 RCX: 00007f1458574bb7
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00007f14582c9000
RBP: 00007fffaf755320 R08: 00007fffaf755198 R09: 00007f14585515c0
R10: 00007f14582a8168 R11: 0000000000000206 R12: 00007f1458551fc0
R13: 00007f145857ceda R14: 00007f14582c9f40 R15: 00007f14582c9740
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 13595 jiffies! g9241 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3487
rcu: rcu_preempt kthread starved for 13596 jiffies! g9241 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:25976 pid:17    tgid:17    ppid:2      flags:0x00004000
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


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

