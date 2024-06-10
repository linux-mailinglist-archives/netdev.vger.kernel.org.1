Return-Path: <netdev+bounces-102382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF5902BDD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DF282E5A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C2145B09;
	Mon, 10 Jun 2024 22:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26A3BB48
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059836; cv=none; b=N5DdjosLCYtDfIAoKCTHtNErEYTWvqM9uqCop76ZvNpaWMUaceDpG0AfMKRC/J+7ZIE/b50B4F2OE/ao0ZKLmbp8B9Lxnp3ljiyAJcPFWPxQjqm0D+7YTuzNx2iH+/kAuL5sT6u2ynH8j/fJR3AlakZt8H4np9aXPF4bc9zrAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059836; c=relaxed/simple;
	bh=SdrMLM0X76Lz3eesK1AUMrCirYKnN2i925GAP7moYKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lL8W8I3f7kgDaRGUjPXIegXn8mPZ4qvv/kdwZLV7GyiPkoo5Wg7nHKD4H1BfSoVZ1pt4+yXxgM1F8sM0kr+QXlj0UnHPekVyCr+H9bdkEZhK9dxvdBNMIuV7BSIvweoyM7xcH3doVHwAlAxbGgjZfrNdAx4r7csqyyT4EUFriBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3747f77bafcso47073515ab.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718059834; x=1718664634;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHfWAAC/2TT/ld2cmM8MOk7yk+g+NdvIy+37TQNEWEo=;
        b=pgIUJfeoBtM34xjVlY4hrH+QavnIOEerIea0qdJS0rbdzdMANObGEbqBUXGs+aiJhr
         4Oexq/zN73X3aV57WOlhNACJZWnx4ILgdpIjnku0EDn3JbYUcPW1AVMQ4m2lyGXrmFB7
         XJSifh3ZDWKgsSqy/94j8n3/WIiC0XlZLg0DvrVr/m3VdSKw1uAQ9X+VVN8G7se8/eVP
         TjoqTYJ3JzrU+iDJ3KN3JpgDe2JAIBk1Bgr1GSIp+0Oi/faHqGdNPUY3T222206xMRh8
         q3/kbbuhMRUFti68M/Y0ZLSpaYqDi6DqvlLhmp4pOfMqv+15bd8K3Lj3/3S1Q6m7sIks
         eJvA==
X-Forwarded-Encrypted: i=1; AJvYcCXud28hAmqBcrhAqrxtdWL0YYX6X4M8VrgkyerPuUp0UzbZFrtJZyifyTpTjRv6ekt45u8sbY9vIwLAvTt4mIy9+KLkv9Fa
X-Gm-Message-State: AOJu0YxDQgG2Ti4ygGdUZnqzmN4r4xSxpSTceNosz3DNFkiLqMMaB144
	sSZRV5sHk9f69qNGfIwoVI59mfHG3NluEM5LaE4waULrdwPfvHd9ve2HG79m1nxOHaBoWAyp6Hr
	V/5TcLSu2NBn+k07vNHfV3LKUeim7q4g3C3D4iX6/0zHX0WdAamZfjYo=
X-Google-Smtp-Source: AGHT+IGBdo1Y+jSeVbk2HaCjJifKMFMnHJFmqqr+89LhBAeG3oBsouIVsYgIh9kUolkaT9GfWfoJQvUWPsOam5lkvtRdu3b34g9j
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:374:acd0:def1 with SMTP id
 e9e14a558f8ab-375803c6586mr5359485ab.5.1718059833995; Mon, 10 Jun 2024
 15:50:33 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:50:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bc420061a90fac5@google.com>
Subject: [syzbot] [net?] possible deadlock in kvfree_call_rcu (2)
From: syzbot <syzbot+e3daf47e87cd1583d197@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b0c9a2643541 net: wwan: iosm: Fix tainted pointer delete i..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b243fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=e3daf47e87cd1583d197
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c4d20a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa4362980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62df44056b9e/disk-b0c9a264.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6fbd552be98/vmlinux-b0c9a264.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aaed51bb11ba/bzImage-b0c9a264.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3daf47e87cd1583d197@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00199-gb0c9a2643541 #0 Not tainted
------------------------------------------------------
swapper/1/0 is trying to acquire lock:
ffff8880b9529430 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:3298 [inline]
ffff8880b9529430 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3697 [inline]
ffff8880b9529430 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3782

but task is already holding lock:
ffff8880b952a718 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&base->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
       __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
       queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2572
       kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3810
       rtnl_register_internal+0x482/0x590 net/core/rtnetlink.c:265
       rtnl_register+0x36/0x80 net/core/rtnetlink.c:315
       ip_rt_init+0x2f6/0x3a0 net/ipv4/route.c:3696
       ip_init+0xe/0x20 net/ipv4/ip_output.c:1663
       inet_init+0x3d8/0x580 net/ipv4/af_inet.c:1983
       do_one_initcall+0x248/0x880 init/main.c:1267
       do_initcall_level+0x157/0x210 init/main.c:1329
       do_initcalls+0x3f/0x80 init/main.c:1345
       kernel_init_freeable+0x435/0x5d0 init/main.c:1578
       kernel_init+0x1d/0x2b0 init/main.c:1467
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (krc.lock){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       krc_this_cpu_lock kernel/rcu/tree.c:3298 [inline]
       add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3697 [inline]
       kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3782
       trie_delete_elem+0x546/0x6a0 kernel/bpf/lpm_trie.c:540
       bpf_prog_2c29ac5cdc6b1842+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
       trace_timer_start include/trace/events/timer.h:52 [inline]
       enqueue_timer+0x3ce/0x570 kernel/time/timer.c:663
       internal_add_timer kernel/time/timer.c:688 [inline]
       __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
       dsp_cmx_send+0x21bf/0x2240 drivers/isdn/mISDN/dsp_cmx.c:1839
       call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
       expire_timers kernel/time/timer.c:1843 [inline]
       __run_timers kernel/time/timer.c:2417 [inline]
       __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
       run_timer_base kernel/time/timer.c:2437 [inline]
       run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
       handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
       __do_softirq kernel/softirq.c:588 [inline]
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
       irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
       sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
       acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
       cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
       call_cpuidle kernel/sched/idle.c:155 [inline]
       cpuidle_idle_call kernel/sched/idle.c:236 [inline]
       do_idle+0x375/0x5d0 kernel/sched/idle.c:332
       cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
       __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
       common_startup_64+0x13e/0x147

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(krc.lock);
                               lock(&base->lock);
  lock(krc.lock);

 *** DEADLOCK ***

4 locks held by swapper/1/0:
 #0: ffffc90000a18c00 ((&dsp_spl_tl)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x650 kernel/time/timer.c:1789
 #1: ffffffff8f339f98 (dsp_lock){..-.}-{2:2}, at: dsp_cmx_send+0x26/0x2240 drivers/isdn/mISDN/dsp_cmx.c:1632
 #2: ffff8880b952a718 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2444

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0-rc1-syzkaller-00199-gb0c9a2643541 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 krc_this_cpu_lock kernel/rcu/tree.c:3298 [inline]
 add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3697 [inline]
 kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3782
 trie_delete_elem+0x546/0x6a0 kernel/bpf/lpm_trie.c:540
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
 trace_timer_start include/trace/events/timer.h:52 [inline]
 enqueue_timer+0x3ce/0x570 kernel/time/timer.c:663
 internal_add_timer kernel/time/timer.c:688 [inline]
 __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
 dsp_cmx_send+0x21bf/0x2240 drivers/isdn/mISDN/dsp_cmx.c:1839
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d5 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d b5 f4 a2 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff888017ae8000 RBX: ffff88801b6f9864 RCX: 000000000001bdc9
RDX: 0000000000000001 RSI: ffff88801b6f9800 RDI: ffff88801b6f9864
RBP: 000000000003a5b8 R08: ffff8880b9537d0b R09: 1ffff110172a6fa1
R10: dffffc0000000000 R11: ffffffff8b868960 R12: ffff88801c718800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8eace380
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 00 d5 	mov    %gs:0x3d500,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d b5 f4 a2 00 	verw   0xa2f4b5(%rip)        # 0xa2f4d9
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

