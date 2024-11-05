Return-Path: <netdev+bounces-141923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B49BCA84
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433B01F22898
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F921CC881;
	Tue,  5 Nov 2024 10:34:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67D1D27AD
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802863; cv=none; b=CpSbOlxErWtxQJHRr5BOecjeKUriPzVKbh6gcbAi1aaQ8HM5uh6Ztev+i6udHZY9KdtsvtLHIhC2RwICMw+960qRZ8CE+0J+VHWkiM+JpTAOfnJ2GO12qQZfy08jNq2CuN2OjGry/Q/qUl4VK/73jJJ0NT/b6k7c/M/dpTIvaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802863; c=relaxed/simple;
	bh=8XqNPqbT8ywnn8m4vxST+T4LV2TsnZeadJ/TpyvTu94=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=loyBMMOW2IrneMOTmJ7bYrlWv+A+/H92rlsBsRyGQs4vJIElla/gQEOdd2ZNJ8CfJ5z5KFQJSgSWL5bQH1lpnjxLWnByY3MJ6EKMnD3gzxHPYM/h5wW7ubEPuoGWzRNo1rgYR1L5V1QAMQtQSU9zmWCyllWGO1X7s2yzrkfwNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bd5be0faso41204405ab.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802861; x=1731407661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZR86TsHfvHFsgEzYy2840HjD/SSTpPfsIpq/oyWK1zc=;
        b=M1klpbEPA5PYb0bV9QgJHwxI1EIi/r4qq2/EOPmsWKLQszMOID4raO/CfnzXzHia4m
         aD+Nm2yy+GxD3T9T1aoqxhrlAVbLMdGGiULRcveIQnN4LGKzoCiyZqBL5AaMagBAeuL2
         gutOhIFBl5/NRJxztWxWr00xGMQsN0i9dl6L6fmVa+8Gk4+yx63sBTYkXdxBUAqRzQ01
         22sHn5lpjfrJcXYVzH+0NkO81OXJl4PUILsh0WsmMH9dLhIC0zdUj8L7kNoPnu6K3IT8
         HeSd7e6sPNNoqdegpqj15Ha+zUrvz3hvK+WdkR1BVzds0oC4tdB8P4wJHRY/dUmSjQ/6
         4JLg==
X-Forwarded-Encrypted: i=1; AJvYcCUn87Xdi16BUwXdmIAf3Z44CUc2x2RFDXR4507CwD+b9GDqbTvpL+CjCWkmdF/x5SwxzjSKWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1vZ/WapXyyqLXvpy6RtdSpb3Z9zJ34ejV3MLnnEoS66cU0/g
	vAW8qVR8neRnI+R7qA+U0+zOOFMAD9ymiHYay8sciTbDbFPJcaVzJ5RLffJOwCDRLdJssRpneRK
	553iXWM+5TU3Nh7gKm+Hn7/e0OX1BVYSJCocqstpAdwcYBBb/s/JG6D0=
X-Google-Smtp-Source: AGHT+IE851aoyrRW8A1U6io0m2mRZRAKEvEcwEQFIeTYh8zKIloRGTj+9JgWUhU7fAWvoTGnt8MpZEAsCGU3r7/iVo+YDqncO6rf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:3a6:cb15:42d2 with SMTP id
 e9e14a558f8ab-3a6cb154862mr68886485ab.6.1730802861450; Tue, 05 Nov 2024
 02:34:21 -0800 (PST)
Date: Tue, 05 Nov 2024 02:34:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729f4ad.050a0220.2edce.1508.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in macvlan_handle_frame
From: syzbot <syzbot+16fa103a3c4b0913b72c@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c40dd8c47325 bpf, test_run: Fix LIVE_FRAME frame update af..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=105e9340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=16fa103a3c4b0913b72c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f38e93d395b4/disk-c40dd8c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49f7c6b95b00/vmlinux-c40dd8c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d58882140682/bzImage-c40dd8c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16fa103a3c4b0913b72c@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 143s! [syz.2.47:6050]
Modules linked in:
irq event stamp: 11006527
hardirqs last  enabled at (11006526): [<ffffffff8bc6e753>] irqentry_exit+0x63/0x90 kernel/entry/common.c:357
hardirqs last disabled at (11006527): [<ffffffff8bc6c2fe>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (10907692): [<ffffffff81578ce4>] __do_softirq kernel/softirq.c:588 [inline]
softirqs last  enabled at (10907692): [<ffffffff81578ce4>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last  enabled at (10907692): [<ffffffff81578ce4>] __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
softirqs last disabled at (10907695): [<ffffffff81578ce4>] __do_softirq kernel/softirq.c:588 [inline]
softirqs last disabled at (10907695): [<ffffffff81578ce4>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (10907695): [<ffffffff81578ce4>] __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
CPU: 1 UID: 0 PID: 6050 Comm: syz.2.47 Not tainted 6.12.0-rc4-syzkaller-00175-gc40dd8c47325 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 aa 4d 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90000a183c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000143084 RCX: ca3e8243d6909100
RDX: dffffc0000000000 RSI: ffffffff8c0adcc0 RDI: ffffffff8c610360
RBP: ffffc90000a18518 R08: ffffffff942ca8f7 R09: 1ffffffff285951e
R10: dffffc0000000000 R11: fffffbfff285951f R12: 1ffff92000143080
R13: dffffc0000000000 R14: ffffc90000a18420 R15: 0000000000000246
FS:  00007f9fbd1246c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020090000 CR3: 0000000028d92000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 macvlan_broadcast_enqueue drivers/net/macvlan.c:362 [inline]
 macvlan_handle_frame+0x8e0/0x1450 drivers/net/macvlan.c:487
 __netif_receive_skb_core+0x13e8/0x4570 net/core/dev.c:5560
 __netif_receive_skb_one_core net/core/dev.c:5664 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:smp_call_function_many_cond+0x18a4/0x2ca0 kernel/smp.c:879
Code: 72 f0 0b 00 4c 8b 7c 24 20 4d 85 f6 75 11 e8 63 f0 0b 00 83 7c 24 18 00 75 16 e9 c6 0b 00 00 e8 52 f0 0b 00 fb 83 7c 24 18 00 <0f> 84 b5 0b 00 00 44 3b 7c 24 78 0f 83 aa 0b 00 00 4d 8d 75 08 4c
RSP: 0018:ffffc9000b1bf580 EFLAGS: 00000202
RAX: ffffffff8188e76e RBX: 0000000000000000 RCX: ffff88802e4a9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000b1bf780 R08: ffffffff8188e740 R09: 1ffffffff2859500
R10: dffffc0000000000 R11: fffffbfff2859501 R12: dffffc0000000000
R13: ffff8880b873fc80 R14: 0000000000000200 R15: 0000000000000000
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1051
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2085 [inline]
 text_poke_bp_batch+0x352/0xb30 arch/x86/kernel/alternative.c:2295
 text_poke_flush arch/x86/kernel/alternative.c:2486 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2493
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 tracepoint_add_func+0x953/0x9e0 kernel/tracepoint.c:361
 tracepoint_probe_register_prio kernel/tracepoint.c:511 [inline]
 tracepoint_probe_register+0x105/0x160 kernel/tracepoint.c:531
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x478/0x930 kernel/trace/trace_event_perf.c:202
 perf_trace_init+0x243/0x2e0 kernel/trace/trace_event_perf.c:226
 perf_tp_event_init+0x8d/0x110 kernel/events/core.c:10357
 perf_try_init_event+0x146/0x810 kernel/events/core.c:11891
 perf_init_event kernel/events/core.c:11977 [inline]
 perf_event_alloc+0x135f/0x2310 kernel/events/core.c:12259
 __do_sys_perf_event_open kernel/events/core.c:12766 [inline]
 __se_sys_perf_event_open+0xb1f/0x3870 kernel/events/core.c:12657
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9fbc37e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9fbd124038 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f9fbc535f80 RCX: 00007f9fbc37e719
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007f9fbc3f132e R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9fbc535f80 R15: 00007ffd56eb9978
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5065 Comm: kworker/u8:7 Not tainted 6.12.0-rc4-syzkaller-00175-gc40dd8c47325 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0x19f3/0x2ca0 kernel/smp.c:884
Code: 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 56 f3 0b 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 01 ef 0b 00 eb 38 f3 90 <42> 0f b6 04 23 84 c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 e5 ee
RSP: 0018:ffffc9000f30e300 EFLAGS: 00000293
RAX: ffffffff8188e8db RBX: 1ffff110170e8919 RCX: ffff888034589e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000f30e500 R08: ffffffff8188e8aa R09: 1ffff92001e61c50
R10: dffffc0000000000 R11: ffffffff81431160 R12: dffffc0000000000
R13: ffff8880b87448c8 R14: ffff8880b863fc80 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005573c7fcdb10 CR3: 000000007a1b6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1051
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:938 [inline]
 flush_tlb_mm_range+0x329/0x5c0 arch/x86/mm/tlb.c:1024
 flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
 ptep_clear_flush+0x11a/0x170 mm/pgtable-generic.c:101
 page_vma_mkclean_one+0x58a/0x9a0 mm/rmap.c:1044
 page_mkclean_one+0x280/0x420 mm/rmap.c:1085
 rmap_walk_file+0x52f/0x9f0 mm/rmap.c:2700
 rmap_walk mm/rmap.c:2718 [inline]
 folio_mkclean+0x262/0x440 mm/rmap.c:1117
 folio_clear_dirty_for_io+0x22b/0xd00 mm/page-writeback.c:3024
 mpage_submit_folio+0x88/0x230 fs/ext4/inode.c:1902
 mpage_map_and_submit_buffers fs/ext4/inode.c:2167 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2299 [inline]
 ext4_do_writepages+0x1d1d/0x3d20 fs/ext4/inode.c:2724
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2813
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1954
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2025
 wb_writeback+0x42f/0xbd0 fs/fs-writeback.c:2136
 wb_check_old_data_flush fs/fs-writeback.c:2240 [inline]
 wb_do_writeback fs/fs-writeback.c:2293 [inline]
 wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

