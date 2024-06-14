Return-Path: <netdev+bounces-103617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF2908CBD
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08E528ADBE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E1881E;
	Fri, 14 Jun 2024 13:49:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A59B67A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372960; cv=none; b=P2o1NwCdN/w1at/jWzYmm+OyW+fGrub3tj5lTrXeiufUrCe8t2CGolaBADf61wDu+1GFfVZ0dzSq+z2Q/u3wYPCc4fJ/n1KX3GPVs4d4JqZbogy/ViE/yUe4utNt/+wB3LELZr7fSDi/Dxu6CfRrcwRBcWEpWQatIAdQq8iW4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372960; c=relaxed/simple;
	bh=ZMZTADelmydgLbe5bhaNM4rTFN4WheJKgOouTeqO7Vk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=de6pvWvinjIfo6e6K4Als+Oxo0mRAkOqsogSIeRzMQPxIMDzT4maDniLOVMohBgvhJulHY6WWUz+Yt4STksmYmEuHaG6t0M4bnimpVwJHvqvlUW1zD3uBja77yR+nXP2jMO/nLpgTCpw96kFd1hX5HcIkbbMa5BqiQlOl17dxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso211895039f.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372958; x=1718977758;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBlbYhm7TAgZta9pO8+l+adV1ptzSfhU22SAdwmUGrs=;
        b=onHQ/2O1E9artJQh0JaKVf6AJS8jWNDO26PmBF6GfOHSHOcyD7v5nG/Vd8DrazjSyZ
         95BSA97dxKXKfI0ogHARCXmYrTpKllV7gOFvvU8xWnkt0lDzGBEPzkPcITQGMDH0Cij+
         DTDwzAU8CHutVIb5cnU3XmOzZhqzQMYAyjQ1rI243YKYivX0b/VwDBtXHCmAsjEnLfL6
         Lu3HciQUxKtB7DmLr8/ODwoqSEgH4g/NdLB3ty6yRJBY5bXrES5zqvUIAtnGiQLIl6GR
         oncZ1PWWwJCx5H6jt8M9+UQztde9yFoshCdyIf56KUschCivoCjlvbzjzouIO277qJAo
         Dtpg==
X-Forwarded-Encrypted: i=1; AJvYcCUGCWUQQ1s8MEevOQg8LOVukkP/CB8AR7EIRCpxvRXza9HkKQ+q8iWzDWPHzXHSV2E2Scr2+tIge0VGq17Ux/yRy30E5Zdi
X-Gm-Message-State: AOJu0YwsStlckT8IJbZgT9faclWx3YSIG+UkhXSEj417beS2w8Q83bjL
	1Fuv0+QgyNlmlvhl87OxM293/Wc0fvk9FWOxPPBTS03WkKOy8ihQPaJozMy7OkY1sfWprg+7+4K
	XjypDdWj3bdPs8Dt5WljrOFk/Obcgy2ygHVuqCF3PGg6RKb5/DmjJLuA=
X-Google-Smtp-Source: AGHT+IFN+PhwIlTEwUD985zjwp/sm6N+Zfzfuaxn2WwqJQmN1e1IgcwDSTaEaYwGa5B58OechSsDNRyDvqn+jdY3uSjpmkODf0PU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:375:a6cd:e005 with SMTP id
 e9e14a558f8ab-375e0ec95admr1387445ab.4.1718372958104; Fri, 14 Jun 2024
 06:49:18 -0700 (PDT)
Date: Fri, 14 Jun 2024 06:49:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c27da9061ad9e101@google.com>
Subject: [syzbot] [mm?] inconsistent lock state in valid_state (3)
From: syzbot <syzbot+40905bca570ae6784745@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1618ee02980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d8cf1c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111059ce980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e648f638b5f/disk-36534d3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbe0d41240f1/vmlinux-36534d3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17eb17ecd214/bzImage-36534d3c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40905bca570ae6784745@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.10.0-rc2-syzkaller-00242-g36534d3c5453 #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor289/5091 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff8880b9438828 (lock#9){?.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9438828 (lock#9){?.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243
{HARDIRQ-ON-W} state was registered at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
  __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243
  __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
  mmap_read_unlock include/linux/mmap_lock.h:170 [inline]
  process_vm_rw_single_vec mm/process_vm_access.c:110 [inline]
  process_vm_rw_core mm/process_vm_access.c:216 [inline]
  process_vm_rw+0xa60/0xcf0 mm/process_vm_access.c:284
  __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
  __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
  __x64_sys_process_vm_readv+0xe0/0x100 mm/process_vm_access.c:292
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 2570
hardirqs last  enabled at (2569): [<ffffffff8135203f>] __text_poke+0x9bf/0xd30 arch/x86/kernel/alternative.c:1943
hardirqs last disabled at (2570): [<ffffffff8b86527e>] sysvec_irq_work+0xe/0xc0 arch/x86/kernel/irq_work.c:17
softirqs last  enabled at (2532): [<ffffffff81a66bba>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2532): [<ffffffff81a66bba>] bpf_link_alloc_id kernel/bpf/syscall.c:3170 [inline]
softirqs last  enabled at (2532): [<ffffffff81a66bba>] bpf_link_prime+0x7a/0x1e0 kernel/bpf/syscall.c:3199
softirqs last disabled at (2522): [<ffffffff81a66b8c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2522): [<ffffffff81a66b8c>] bpf_link_alloc_id kernel/bpf/syscall.c:3168 [inline]
softirqs last disabled at (2522): [<ffffffff81a66b8c>] bpf_link_prime+0x4c/0x1e0 kernel/bpf/syscall.c:3199

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#9);
  <Interrupt>
    lock(lock#9);

 *** DEADLOCK ***

6 locks held by syz-executor289/5091:
 #0: ffffffff8e3809e8 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_register_prio_may_exist+0xbb/0x190 kernel/tracepoint.c:478
 #1: ffffffff8e1ce5b0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x12/0x20 kernel/jump_label.c:217
 #2: ffffffff8e3e1a48 (jump_label_mutex){+.+.}-{3:3}, at: jump_label_lock kernel/jump_label.c:27 [inline]
 #2: ffffffff8e3e1a48 (jump_label_mutex){+.+.}-{3:3}, at: static_key_enable_cpuslocked+0xd7/0x260 kernel/jump_label.c:202
 #3: ffffffff8e1e3688 (text_mutex){+.+.}-{3:3}, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
 #4: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __pte_offset_map+0x82/0x380 mm/pgtable-generic.c:287
 #5: ffff88801507b078 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #5: ffff88801507b078 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: __pte_offset_map_lock+0x1ba/0x300 mm/pgtable-generic.c:375

stack backtrace:
CPU: 0 PID: 5091 Comm: syz-executor289 Not tainted 6.10.0-rc2-syzkaller-00242-g36534d3c5453 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 valid_state+0x13a/0x1c0 kernel/locking/lockdep.c:4013
 mark_lock_irq+0xbb/0xc20 kernel/locking/lockdep.c:4216
 mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4564 [inline]
 __lock_acquire+0xb8e/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243
 __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
 mmap_read_unlock_non_owner include/linux/mmap_lock.h:176 [inline]
 do_mmap_read_unlock+0x5d/0x60 kernel/bpf/task_iter.c:1049
 irq_work_single+0xe2/0x240 kernel/irq_work.c:221
 irq_work_run_list kernel/irq_work.c:252 [inline]
 irq_work_run+0x18b/0x350 kernel/irq_work.c:261
 __sysvec_irq_work+0xb8/0x430 arch/x86/kernel/irq_work.c:22
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:__text_poke+0xa4a/0xd30 arch/x86/kernel/alternative.c:1944
Code: 7c 24 50 00 75 19 e8 d5 05 61 00 eb 18 e8 ce 05 61 00 e8 09 67 51 0a 48 83 7c 24 50 00 74 e7 e8 bc 05 61 00 fb 48 8b 44 24 78 <42> 80 3c 28 00 74 0d 48 8d bc 24 60 01 00 00 e8 12 c8 c6 00 48 8b
RSP: 0018:ffffc900033f76a0 EFLAGS: 00000293
RAX: 1ffff9200067ef00 RBX: 0000000000000000 RCX: ffff8880429c5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900033f7870 R08: ffffffff81352094 R09: 1ffffffff25f56b0
R10: dffffc0000000000 R11: fffffbfff25f56b1 R12: 1ffff9200067eee4
R13: dffffc0000000000 R14: 0000000000000046 R15: ffffffff814262a6
 text_poke arch/x86/kernel/alternative.c:1968 [inline]
 text_poke_bp_batch+0x265/0xb30 arch/x86/kernel/alternative.c:2276
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 tracepoint_add_func+0x953/0x9e0 kernel/tracepoint.c:361
 tracepoint_probe_register_prio_may_exist+0x122/0x190 kernel/tracepoint.c:482
 bpf_raw_tp_link_attach+0x48b/0x6e0 kernel/bpf/syscall.c:3875
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3906
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5730
 __do_sys_bpf kernel/bpf/syscall.c:5795 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5793 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5793
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd578b74e39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff287d14f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd578b74e39
RDX: 0000000000000010 RSI: 0000000020000080 RDI: 0000000000000011
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	7c 24                	jl     0x26
   2:	50                   	push   %rax
   3:	00 75 19             	add    %dh,0x19(%rbp)
   6:	e8 d5 05 61 00       	call   0x6105e0
   b:	eb 18                	jmp    0x25
   d:	e8 ce 05 61 00       	call   0x6105e0
  12:	e8 09 67 51 0a       	call   0xa516720
  17:	48 83 7c 24 50 00    	cmpq   $0x0,0x50(%rsp)
  1d:	74 e7                	je     0x6
  1f:	e8 bc 05 61 00       	call   0x6105e0
  24:	fb                   	sti
  25:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 0d                	je     0x3e
  31:	48 8d bc 24 60 01 00 	lea    0x160(%rsp),%rdi
  38:	00
  39:	e8 12 c8 c6 00       	call   0xc6c850
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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

