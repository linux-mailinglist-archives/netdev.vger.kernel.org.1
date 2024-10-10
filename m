Return-Path: <netdev+bounces-134207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79353998662
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEA1B21A55
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F241C579A;
	Thu, 10 Oct 2024 12:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B81BD008
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564329; cv=none; b=KzTwwiC6fxD23x0e/t/KVsraeIcxiylMjOgxeDmWgP+CWCHDDbkBvCsdmHFvW3Q4yH1DZiU56+2AO/UDIifpSsV5YiVYjXuDNc/UZnHwUrGX8rkAKL8A5K9WZxmxSVAet2PwQEdzNSTOpWHH35cwbA1NJxHi0TXMI+uryDr5K7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564329; c=relaxed/simple;
	bh=s75/LzypK/YZU8QedN6sJI7rR+1yDoQDBfrhUCuNxVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r8HuXmF5AegI4ssB5xiP7KX3juqBfAZzzEEkfpUOq/fEsvVZFlFqRv4pj/Vq4fUXvF4ce8rbxqeEWbIaE7dBSPDFDMNjlkfzyap+oyJZhTe27Ex/bgxiM9GytNALewAbikaegyxQmR4dUKD1mY7p2EZcNFlDVA/egoiW1YkRFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so14601785ab.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564325; x=1729169125;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ6zfjpppkpdBHbmD/yZ4wKd0FjZAtqsX30rNqGFp7I=;
        b=KNtYmremCvU/MCtqdsOl3yUIaHzsYiOwQV5sCA5KDmndjLDa8vukzepWvb6ge+mdnm
         7DC9oU87SegFafjE/t+fT7undzf+RN0gC05lNC8cHK3AnB2jkCbDWRqUIE+FI+TuO7rR
         lPT97ksLdVtl9/kyUxRMD5+OjCAMdHq4gZE+iTNQvsRwcYuhHKMDXWjA82v4uBDFanV1
         MdI1wQFgYHpYUR2cvIKAftrKIfs6UpQC+t7YWWuvInB6/R34P/dLof/ELKe3UaWu3Tan
         qYxi1iz5xdGVC2czgADBGGGivdojvefK1mBXgxHo2GoT3lteoUvFyYZIxb9RcViNnHRS
         uWXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7KeUhH6Vq1V5ypCYeNjQF8YgJhAERG8xV9DLmkUZU06lQ1SF/LTNYz6GLFfh41kc4o5Glxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvruEekVseW15oudy1gRguNoIy/kLvR6bQEWgKEYofybBp2wmV
	/i70vjiUeFiQ6Sl/9aeLDpcTKygLa778PVXMDBUD2aFzQkKu0+Q7nXdCrcYGs9At+4SEt7+ug88
	LRDbptBqR1fAp/pZxouzcO06KdW9TaV7C25YNifngNQ6UQ88KNiz0OHY=
X-Google-Smtp-Source: AGHT+IEwoSxi2HMpOY2kklPtG3bIBitqFVpwfpWZ8g6W4ves/Rc6ChMH6LrQRPw2Gg7rw61H/oqmSk/KtfO9QnAziSc9iOA69mqZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a397d0a9eamr47472605ab.12.1728564325637; Thu, 10 Oct 2024
 05:45:25 -0700 (PDT)
Date: Thu, 10 Oct 2024 05:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707cc65.050a0220.8109b.0008.GAE@google.com>
Subject: [syzbot] [netfilter?] INFO: rcu detected stall in NF_HOOK (2)
From: syzbot <syzbot+34c2df040c6cfa15fdfe@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d521db38f339 Merge branch 'net-switch-back-to-struct-platf..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12957307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140b47d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16957307980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efb9dff46aab/disk-d521db38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a60086d5c863/vmlinux-d521db38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d923665276/bzImage-d521db38.xz

Bisection is inconclusive: the first bad commit could be any of:

781773e3b680 sched/fair: Implement ENQUEUE_DELAYED
a1c446611e31 sched,freezer: Mark TASK_FROZEN special
e1459a50ba31 sched: Teach dequeue_task() about special task states
f12e148892ed sched/fair: Prepare pick_next_task() for delayed dequeue
152e11f6df29 sched/fair: Implement delayed dequeue
2e0199df252a sched/fair: Prepare exit/cleanup paths for delayed_dequeue
54a58a787791 sched/fair: Implement DELAY_ZERO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114327d0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34c2df040c6cfa15fdfe@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=6461, q=2714666 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10503 (4294972492-4294961989), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10504 jiffies! g6461 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26144 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-rc1-syzkaller-00229-gd521db38f339 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hrtimer_interrupt+0x533/0x990 kernel/time/hrtimer.c:1827
Code: 00 48 8b 5c 24 70 74 08 48 89 df e8 47 65 7c 00 4c 89 23 48 8b 44 24 08 42 0f b6 04 30 84 c0 0f 85 c0 01 00 00 41 80 65 4c fd <4c> 89 ef 48 8b 74 24 20 e8 20 ea 4c 0a 4c 89 e7 31 f6 e8 36 ce 03
RSP: 0018:ffffc90000a18eb8 EFLAGS: 00000006
RAX: 0000000000000000 RBX: ffff8880b872c8e0 RCX: ffff88801d2f0000
RDX: 0000000000010100 RSI: 7fffffffffffffff RDI: 000000527594bc00
RBP: ffff8880b872ca68 R08: ffffffff81822830 R09: 0000000000000000
R10: ffff8880b872d1a0 R11: ffffed10170e5a36 R12: 000000527594bc00
R13: ffff8880b872c880 R14: dffffc0000000000 R15: ffff8880b872cc68
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005578d972b578 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1026 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1043
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:stack_trace_consume_entry+0x59/0x280 kernel/stacktrace.c:89
Code: 84 c0 0f 85 06 01 00 00 44 8b 43 10 48 8d 6b 08 49 89 ec 49 c1 ec 03 41 0f b6 04 14 84 c0 0f 85 1a 01 00 00 44 3b 45 00 73 3c <48> 8d 7b 0c 49 89 fd 49 c1 ed 03 41 0f b6 44 15 00 84 c0 0f 85 36
RSP: 0018:ffffc900001e6e30 EFLAGS: 00000287
RAX: 0000000000000000 RBX: ffffc900001e6f60 RCX: ffffffff917b9000
RDX: dffffc0000000000 RSI: ffffffff81808e88 RDI: ffffc900001e6f60
RBP: ffffc900001e6f68 R08: 0000000000000000 R09: ffffc900001e6f70
R10: ffffc900001e6ed0 R11: ffffffff81808f50 R12: 1ffff9200003cded
R13: ffffffff81808f50 R14: ffffc900001e6f60 R15: 1ffff9200003cdee
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4296
 kmalloc_noprof include/linux/slab.h:878 [inline]
 slab_free_hook mm/slub.c:2295 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x177/0x420 mm/slub.c:4682
 nf_conntrack_free+0x2fd/0x390 net/netfilter/nf_conntrack_core.c:1735
 nf_ct_put include/net/netfilter/nf_conntrack.h:186 [inline]
 nf_conntrack_in+0xb51/0x1890 net/netfilter/nf_conntrack_core.c:2061
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.341 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

