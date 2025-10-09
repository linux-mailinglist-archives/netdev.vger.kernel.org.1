Return-Path: <netdev+bounces-228419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB2BCA393
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98B53B1B2F
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3D17555;
	Thu,  9 Oct 2025 16:45:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A834BA31
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028336; cv=none; b=T8VmXIKVfYS19O7b2GU8myHruDGWlXVWxC77eA3CVwuuaX/QjrhDbeIFygR2tfp69ePQ+1wfKO4gJkIPoaEIXdR74LXQQJ2rPLdOlE+dAtRUzPRtVULVzTKim2iYvk7DLunc1RAKJwa7rzz03cZICwH5X1Kbm8nQ0qbFkX2Soqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028336; c=relaxed/simple;
	bh=6sTCBb0tfqAnkgoAfBP2nadDE89F7mOLJSi6PhGRu7I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uhEbvbmhUF4tfL9hGlkjCGxhpcwmx/64tM9u4NvROzNxCGwxEZobUGGEdHYRiSFogHs9q6lRffx34nr4oijVevj9WVMmOVXRBsceUcTEUfEWoWSYQSAjObGkjWD4d6Kyluyy9wpiGEp/rGlF3h8tqrSYsXbWBOMfUwsBXUGefqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-930db3a16c9so221081739f.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 09:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028334; x=1760633134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiNwUDDoMfwdJsyYMQP6psFYTpEOok21Oh+8XMBPUxM=;
        b=BDlnjxJC73ZmZ4UeRM5j3LF9AVsJE/ooQ0tZiVvXYjD2sofPwJoCWSEl5J8LS7NjgH
         fyXgrWP5HOm7DlRuFjdrBpp/7598u9RsNqQF+7oeCTUwZiGHcpZM7jaryFSxRFY8u1Sn
         4m6EXkosPvs4ANiUGwgJdaJrZK/ABIw/CKSzvMEjdiW0GWTF5wG6iCFGsqb6qxVb8IAy
         FkHyU9atS5MdZuia0atlo+rIZQSfGdKP7D613stqrlo9mYPidJ7Egx41SDMAJNwNdlbq
         pC15eYzAEqkTB5j80VBM8XOhyce84jb/xTbkqasU85xlEfRCVWPfaUN9zYA+mVBmLyFd
         n32A==
X-Forwarded-Encrypted: i=1; AJvYcCW0XoN40ft2c9itumXr3eB99SI3MNJ/NA/tHsIXFrj6qeR2gc/mk8rC9+NyelJ7FnQPSGJuk4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJI2pg9n1+/UXTObAyinMRA30FN14LyRM4Vgohj3eAaF2f7yx
	JgMgIJhNMbmuQxgyuVKFlD5g0+Ob/aQgrx8JyftJNwTHdzP2/fCKdqgGYINBZxsHuoQDVrcLleR
	qt2+fA6ks4lKxNlWiwtk3Ieg49m0KwnuzNXltg5YdeK3XaIvhzfaszEDKJks=
X-Google-Smtp-Source: AGHT+IFZI4cxAjBhEJhONTTWvjD3FehjhIxuT18P1SrmSfFwWthmN+lwT/iPhS8NxundVjFEYSz3maCqT4UWuunRY0qEzCsRncP5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b87:b0:887:6854:b073 with SMTP id
 ca18e2360f4ac-93bd17815aemr920090739f.4.1760028333754; Thu, 09 Oct 2025
 09:45:33 -0700 (PDT)
Date: Thu, 09 Oct 2025 09:45:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7e6ad.a70a0220.126b66.0043.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: locking bug in __set_page_owner (2)
From: syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	netdev@vger.kernel.org, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c95a756e0cf net: pse-pd: tps23881: Fix current measuremen..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16e1852f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcbbf19237350b5
dashboard link: https://syzkaller.appspot.com/bug?extid=8259e1d0e3ae8ed0c490
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8272657e4298/disk-2c95a756.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e53ba690f28/vmlinux-2c95a756.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6112d620d6fc/bzImage-2c95a756.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Not tainted
-----------------------------
syz.3.7709/29103 is trying to lock:
ffffffff8e276d58 (stack_list_lock){-.-.}-{3:3}, at: add_stack_record_to_list mm/page_owner.c:182 [inline]
ffffffff8e276d58 (stack_list_lock){-.-.}-{3:3}, at: inc_stack_record_count mm/page_owner.c:214 [inline]
ffffffff8e276d58 (stack_list_lock){-.-.}-{3:3}, at: __set_page_owner+0x2c3/0x4a0 mm/page_owner.c:333
other info that might help us debug this:
context-{2:2}
6 locks held by syz.3.7709/29103:
 #0: ffffffff8e190068 (tracepoints_mutex){+.+.}-{4:4}, at: tracepoint_probe_register_prio_may_exist+0x43/0xa0 kernel/tracepoint.c:431
 #1: ffffffff8dfd2a70 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x12/0x20 kernel/jump_label.c:222
 #2: ffffffff8e1f5748 (jump_label_mutex){+.+.}-{4:4}, at: jump_label_lock kernel/jump_label.c:27 [inline]
 #2: ffffffff8e1f5748 (jump_label_mutex){+.+.}-{4:4}, at: static_key_enable_cpuslocked+0xcb/0x250 kernel/jump_label.c:207
 #3: ffffffff8dfe5e68 (text_mutex){+.+.}-{4:4}, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
 #4: ffffffff8e13a960 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e13a960 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e13a960 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
 #4: ffffffff8e13a960 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2116
 #5: ffff8880b8632780 ((stream_local_lock).llock){....}-{3:3}, at: local_trylock_acquire include/linux/local_lock_internal.h:45 [inline]
 #5: ffff8880b8632780 ((stream_local_lock).llock){....}-{3:3}, at: bpf_stream_page_local_lock kernel/bpf/stream.c:46 [inline]
 #5: ffff8880b8632780 ((stream_local_lock).llock){....}-{3:3}, at: bpf_stream_elem_alloc kernel/bpf/stream.c:175 [inline]
 #5: ffff8880b8632780 ((stream_local_lock).llock){....}-{3:3}, at: __bpf_stream_push_str+0x1db/0xc90 kernel/bpf/stream.c:190
stack backtrace:
CPU: 0 UID: 0 PID: 29103 Comm: syz.3.7709 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4830 [inline]
 check_wait_context kernel/locking/lockdep.c:4902 [inline]
 __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5187
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 add_stack_record_to_list mm/page_owner.c:182 [inline]
 inc_stack_record_count mm/page_owner.c:214 [inline]
 __set_page_owner+0x2c3/0x4a0 mm/page_owner.c:333
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 alloc_pages_nolock_noprof+0x94/0x120 mm/page_alloc.c:7554
 bpf_stream_page_replace+0x17/0x1e0 kernel/bpf/stream.c:86
 bpf_stream_page_reserve_elem kernel/bpf/stream.c:148 [inline]
 bpf_stream_elem_alloc kernel/bpf/stream.c:177 [inline]
 __bpf_stream_push_str+0x3db/0xc90 kernel/bpf/stream.c:190
 bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:448
 dump_stack_cb+0x2b6/0x350 kernel/bpf/stream.c:505
 arch_bpf_stack_walk+0xe2/0x170 arch/x86/net/bpf_jit_comp.c:3945
 bpf_stream_stage_dump_stack+0x167/0x220 kernel/bpf/stream.c:522
 bpf_prog_report_may_goto_violation+0xcc/0x190 kernel/bpf/core.c:3181
 bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3199
 arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
 bpf_prog_6fd842a53d323cc5+0x53/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2116
 __bpf_trace_hrtimer_expire_entry+0x102/0x160 include/trace/events/timer.h:259
 __do_trace_hrtimer_expire_entry include/trace/events/timer.h:259 [inline]
 trace_hrtimer_expire_entry include/trace/events/timer.h:259 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1774 [inline]
 __hrtimer_run_queues+0xa03/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xd33/0x12d0 kernel/smp.c:877
Code: 45 8b 2c 24 44 89 ee 83 e6 01 31 ff e8 a6 73 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 51 6f 0b 00 eb 38 f3 90 <42> 0f b6 04 2b 84 c0 75 11 41 f7 04 24 01 00 00 00 74 1e e8 35 6f
RSP: 0018:ffffc90010c17760 EFLAGS: 00000287
RAX: ffffffff81b3ac3b RBX: 1ffff110170e7f69 RCX: 0000000000080000
RDX: ffffc9001b9a2000 RSI: 00000000000060c8 RDI: 00000000000060c9
RBP: ffffc90010c178e0 R08: ffffffff8f9d4c37 R09: 1ffffffff1f3a986
R10: dffffc0000000000 R11: fffffbfff1f3a987 R12: ffff8880b873fb48
R13: dffffc0000000000 R14: ffff8880b863b200 R15: 0000000000000001
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1043
 on_each_cpu include/linux/smp.h:71 [inline]
 smp_text_poke_sync_each_cpu arch/x86/kernel/alternative.c:2653 [inline]
 smp_text_poke_batch_finish+0x5f9/0x1130 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 tracepoint_add_func+0x994/0xa10 kernel/tracepoint.c:315
 tracepoint_probe_register_prio_may_exist+0x5f/0xa0 kernel/tracepoint.c:435
 bpf_raw_tp_link_attach+0x4f0/0x6c0 kernel/bpf/syscall.c:4235
 bpf_raw_tracepoint_open+0x1b2/0x220 kernel/bpf/syscall.c:4266
 __sys_bpf+0x73e/0x860 kernel/bpf/syscall.c:6176
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe963b8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe964a02038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe963de6090 RCX: 00007fe963b8eec9
RDX: 0000000000000018 RSI: 00002000000000c0 RDI: 0000000000000011
RBP: 00007fe963c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe963de6128 R14: 00007fe963de6090 R15: 00007ffc809e0088
 </TASK>
----------------
Code disassembly (best guess):
   0:	45 8b 2c 24          	mov    (%r12),%r13d
   4:	44 89 ee             	mov    %r13d,%esi
   7:	83 e6 01             	and    $0x1,%esi
   a:	31 ff                	xor    %edi,%edi
   c:	e8 a6 73 0b 00       	call   0xb73b7
  11:	41 83 e5 01          	and    $0x1,%r13d
  15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1c:	fc ff df
  1f:	75 07                	jne    0x28
  21:	e8 51 6f 0b 00       	call   0xb6f77
  26:	eb 38                	jmp    0x60
  28:	f3 90                	pause
* 2a:	42 0f b6 04 2b       	movzbl (%rbx,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 11                	jne    0x44
  33:	41 f7 04 24 01 00 00 	testl  $0x1,(%r12)
  3a:	00
  3b:	74 1e                	je     0x5b
  3d:	e8                   	.byte 0xe8
  3e:	35                   	.byte 0x35
  3f:	6f                   	outsl  %ds:(%rsi),(%dx)


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

