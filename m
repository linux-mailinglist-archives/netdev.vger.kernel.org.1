Return-Path: <netdev+bounces-102035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC990130A
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0761C20BBA
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE751757E;
	Sat,  8 Jun 2024 17:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595415EA2
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867765; cv=none; b=seaeWtjG4clM6/zP4TPc3EurlSrKuDkcZzVO9sFUn/Jmsih7+SLlRJh91AdAeVSrn9L9Z9pHtHVZ1J6jULLluH+dWyq/UMD0AaK0KzeBFMaSr8f7oGrk28utu4hdjYLDby8sLsXlag6XtBj/8QDXZaujoWJZARVJBWSPdozaM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867765; c=relaxed/simple;
	bh=hVgzENBXgy3CtZAC/Z4bvXJuq17lpWL8l9tcV0ib0Bc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ehWBRJyWzZIoEj3/1xYUS/n40TV6SfKhtIkVXGfRtqiYdsYDnW+imyNk0KqdmBgIFic2ir2jnW4CJZc+yr3I2/aOOJJRmLg7QcoolYMAE9hMXp54zl9IGFK6tOyx8hhSCV1YzpL0GqE7TEZf4Q0qcxVjnuH1i0HM+XLR+kz70RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so344837339f.1
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 10:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717867763; x=1718472563;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv4Kv7FOxxWBGOLizg6Qd++rwjklcoLoMQNcVBPKcBI=;
        b=M3cfxuJeRU4iT8OvcM+OGHfhtizt1vqoLCBC3zaX8wnwc8ce/WiZgd6z21RmT1Q94T
         Sq3OcbDVot2KuQlGp8PXcta3G3HwBZOH/LPwyZaxVl3pwhhKBLFf/E/n8O3zPdQRndj6
         dE4O4glk4pCXc3/1h/Sdg/ZpUwluLTTP1JJnwtjfUqPuZ8VwfxX7ueDRIrDmQRPW5WC6
         m4Q+1Ebj/vEnVxKB4lv354R5UGxcGy/kDnUkCZw9iY/alDWknSwXGEH4FG7m14qnhmz2
         AYG30SlwMKyl8e7IUNMUW8r/uz4UU74T/MmVjbSsKTfOHAJs5AJm8jwjoz0sVj1tdtip
         cwNA==
X-Forwarded-Encrypted: i=1; AJvYcCXp4Cae4cfONgUlqdtIdH0NG8RG3UO9BiZUM5qQMzAkYR79MS1KKLG+GGAeGr6QHKGlqx0cZNW+46nyozYd3oTTv9jX8XCq
X-Gm-Message-State: AOJu0YxXFB5EdF70GzGFaPmXkh4VkiDNoRNTLtorG0pJm4oUtY5Kc5Ti
	HiHN+dwzhv30tXGCQdVbgzS2ERnMZOIr/voXMyLnqnIyjhJy5c+i1bgeEU1VkpHI/3d6wplLPFe
	6pERV8ayLnjTBX13Anx43ft8+g9Kzq5wep5lcDPHP3FHHd9nXtvua234=
X-Google-Smtp-Source: AGHT+IF53ZgN2qLGJne+EPB4QPACQaqwrZuIq2HoPOd1vI/CfoOywSbZsjN1kCdAEOzmyFyvH3G4HVR+4VwQ935znx3lNFz0WG6U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:168b:b0:4b2:bd19:1719 with SMTP id
 8926c6da1cb9f-4b7b16a4df0mr124950173.5.1717867763441; Sat, 08 Jun 2024
 10:29:23 -0700 (PDT)
Date: Sat, 08 Jun 2024 10:29:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfb785061a64415a@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in br_mst_set_state (2)
From: syzbot <syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a92980606e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f9eaba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a6ac4277fffe3ea
dashboard link: https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e77750e429bf/disk-8a929806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/910e4410cf78/vmlinux-8a929806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85542820b0d5/bzImage-8a929806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0 Not tainted
-----------------------------
net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by syz-executor.1/5374:
 #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: __mm_populate+0x1b0/0x460 mm/gup.c:2111
 #1: ffffc90000a18c00 ((&p->forward_delay_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x650 kernel/time/timer.c:1789
 #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: br_forward_delay_timer_expired+0x50/0x440 net/bridge/br_stp_timer.c:86
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: br_mst_set_state+0x171/0x7a0 net/bridge/br_mst.c:105

stack backtrace:
CPU: 1 PID: 5374 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 nbp_vlan_group net/bridge/br_private.h:1599 [inline]
 br_mst_set_state+0x29e/0x7a0 net/bridge/br_mst.c:106
 br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
 br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
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
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x86/0x290 mm/kasan/generic.c:189
Code: 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd 41 80 3b 00 <0f> 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00 00 45 89 dc
RSP: 0018:ffffc90004beec90 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 1ffff9200097dd9c RCX: ffffffff8173cb88
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90004beece0
RBP: ffffffffffffffff R08: ffffc90004beece3 R09: 1ffff9200097dd9c
R10: dffffc0000000000 R11: fffff5200097dd9c R12: 1ffff9200097dd98
R13: ffff8880b9544700 R14: dffffc0000000001 R15: fffff5200097dd9d
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
 queued_spin_trylock include/asm-generic/qspinlock.h:97 [inline]
 do_raw_spin_trylock+0xc8/0x1f0 kernel/locking/spinlock_debug.c:123
 __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
 _raw_spin_trylock+0x20/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 rmqueue_pcplist mm/page_alloc.c:2940 [inline]
 rmqueue mm/page_alloc.c:2990 [inline]
 get_page_from_freelist+0x79f/0x2ee0 mm/page_alloc.c:3399
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 shmem_alloc_folio mm/shmem.c:1628 [inline]
 shmem_alloc_and_add_folio+0x24d/0xdb0 mm/shmem.c:1668
 shmem_get_folio_gfp+0x82d/0x1f50 mm/shmem.c:2055
 shmem_fault+0x252/0x6f0 mm/shmem.c:2255
 __do_fault+0x135/0x460 mm/memory.c:4562
 do_read_fault mm/memory.c:4926 [inline]
 do_fault mm/memory.c:5056 [inline]
 do_pte_missing mm/memory.c:3903 [inline]
 handle_pte_fault+0x3d8d/0x7130 mm/memory.c:5380
 __handle_mm_fault mm/memory.c:5523 [inline]
 handle_mm_fault+0xfb0/0x19d0 mm/memory.c:5688
 faultin_page mm/gup.c:1290 [inline]
 __get_user_pages+0x6ef/0x1590 mm/gup.c:1589
 populate_vma_page_range+0x264/0x330 mm/gup.c:2029
 __mm_populate+0x27a/0x460 mm/gup.c:2132
 mm_populate include/linux/mm.h:3464 [inline]
 vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:578
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1686c7cf69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f168799f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f1686db3f80 RCX: 00007f1686c7cf69
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f1686cda6fe R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1686db3f80 R15: 00007ffd6eb2ca48
 </TASK>
bridge0: port 2(bridge_slave_1) entered learning state
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 4f 8d             	fisttps -0x73(%rdi)
   3:	3c 31                	cmp    $0x31,%al
   5:	4c 89 fd             	mov    %r15,%rbp
   8:	4c 29 dd             	sub    %r11,%rbp
   b:	48 83 fd 10          	cmp    $0x10,%rbp
   f:	7f 29                	jg     0x3a
  11:	48 85 ed             	test   %rbp,%rbp
  14:	0f 84 3e 01 00 00    	je     0x158
  1a:	4c 89 cd             	mov    %r9,%rbp
  1d:	48 f7 d5             	not    %rbp
  20:	48 01 dd             	add    %rbx,%rbp
  23:	41 80 3b 00          	cmpb   $0x0,(%r11)
* 27:	0f 85 c9 01 00 00    	jne    0x1f6 <-- trapping instruction
  2d:	49 ff c3             	inc    %r11
  30:	48 ff c5             	inc    %rbp
  33:	75 ee                	jne    0x23
  35:	e9 1e 01 00 00       	jmp    0x158
  3a:	45 89 dc             	mov    %r11d,%r12d


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

