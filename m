Return-Path: <netdev+bounces-180745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A5A82534
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE611B63831
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB225F97B;
	Wed,  9 Apr 2025 12:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8E25DCE9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202910; cv=none; b=dt1w7lYMjq6THq46snb/8/7AeS5mu0NQ1rtkMAo/C3Y7oIETIXMn4LOkrMjOkLC1iXFb2Xz0zFdEHyp00P9bWtqDjULtsk6MUd71jFebSVz2PVnYsJ3x6FWarEp60S7LZRD69XvUcSK4cTFjhzQy3jjVuc+R/+QNxB+zg8reJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202910; c=relaxed/simple;
	bh=Hp1aMvB2P2HlCnLz/nFvNLwZgXBFJFItXCEwHjLm2LM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bk+a+3gfc1/ZiACFr7O95pACUvrgHkknTsSKPBVgL+943rU6rJwTHHjvjlcCH5lUnxybYyuK80IcxJ4fnqVj5LCHBRhIMyF6Z6d2Uuhcv41BAv9zFPUvuOuIHVfGYf/e+VkFtSOuU9RIuoE40/Reqpfr7LEuvAmLEJC8rEup8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5a9e7dd5aso69753935ab.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202908; x=1744807708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVbJDbW6DnvYqnD/sT2e+c92Ee4xPt8hlnH5eChnEWU=;
        b=vv+nAvrnZYJ1jF8aUea8Xcqat5wxH2530Yn33iGlH7D7FqQvAuM7yiauFDk3C0YUZA
         7r7Bqv/h9Nc8YaDYyxRbQQ3OhhHIC2OOrFmnOo5XTO+3YKJE7xBsDAQRP50xksWDi/pL
         kx1mUhr302+1bYpT328vsw57bCI9Cph7VE7TT17+o0CRtRNDfPVeA5thBtSV1zF5WIba
         1yJkkqLvhu/hwalI+so+1H369/7ihnZBhXynnaqRMTQrtIASBAJH00a1iwRVc8wlZElF
         +qVdecwmxjvz+FY3hqKDCczPPwK1RN00U1yB7gmg+GvajMZ4tLnr3fEZd2ZQSYc4XCpM
         ntsA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYbZTm597N2Pez5WUIducZwqqc7uzdxfVmZ9pcEREbiyeI+j/2n1JYsIhyymyMujrlZejv+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP69/mwAaRhUISBynueK0M2ofT/xITbNyZNk+NBOIuWjLvxej
	QLRIUFmWW2AJ2VEE8qDbs8DrENfDOv5FZse82jo93G07mfFAxvVxMbvxXpZbu3FqXt9D3BzLJi3
	I3AQ+Fk+6C/Kdw8RYlz/JcdbUL6QT+tioclc3AjB6oMeStM1aWl6uYP0=
X-Google-Smtp-Source: AGHT+IG1xOPYxQlgSNbRi4NE3ESwXRr35/x8vqwedb9O3tFKHkfPk17amflPw5DRDHccLTDf7AJukZgD/8UFcqGc7coCXOGiczin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3d3:dfb6:2203 with SMTP id
 e9e14a558f8ab-3d77c2b287emr27400545ab.19.1744202908146; Wed, 09 Apr 2025
 05:48:28 -0700 (PDT)
Date: Wed, 09 Apr 2025 05:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f66c9c.050a0220.25d1c8.0003.GAE@google.com>
Subject: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a52a3c18cdf3 Merge tag 'ntb-6.15' of https://github.com/jo..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15764be4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=695196aa2bd08d99
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/326c7eeab15a/disk-a52a3c18.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10c3ccb3546c/vmlinux-a52a3c18.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0bd8832c1d9c/bzImage-a52a3c18.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:326 [inline]
BUG: KASAN: null-ptr-deref in __rcuref_put include/linux/rcuref.h:89 [inline]
BUG: KASAN: null-ptr-deref in rcuref_put+0x1a1/0x240 include/linux/rcuref.h:153
Write of size 4 at addr 0000000000000041 by task udevd/6807

CPU: 1 UID: 0 PID: 6807 Comm: udevd Not tainted 6.14.0-syzkaller-13389-ga52a3c18cdf3 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe3/0x5b0 mm/kasan/report.c:524
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x28f/0x2a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:326 [inline]
 __rcuref_put include/linux/rcuref.h:89 [inline]
 rcuref_put+0x1a1/0x240 include/linux/rcuref.h:153
 dst_release+0x24/0x1b0 net/core/dst.c:167
 dst_cache_reset_now+0x1b0/0x220 net/core/dst_cache.c:183
 wg_socket_clear_peer_endpoint_src+0x40/0x50 drivers/net/wireguard/socket.c:312
 wg_expired_retransmit_handshake+0xd3/0x2d0 drivers/net/wireguard/timers.c:73
 call_timer_fn+0x189/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66e/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd9/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 2b 00 74 08 4c 89 f7 e8 3d bd ff f5 f6 44 24 21 02 75 55 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 32 58 65 f5 65 8b 05 0b 1e 3a 07 85 c0 74 46 48 c7 04 24 0e 36
RSP: 0018:ffffc90003f97280 EFLAGS: 00000206
RAX: ba8754475f048600 RBX: 1ffff920007f2e54 RCX: ffffffff81cb37bc
RDX: 0000000000000000 RSI: ffffffff8e687288 RDI: 0000000000000001
RBP: ffffc90003f97310 R08: ffffffff905eac77 R09: 1ffffffff20bd58e
R10: dffffc0000000000 R11: fffffbfff20bd58f R12: 1ffff920007f2e50
R13: dffffc0000000000 R14: ffffc90003f972a0 R15: 0000000000000246
 __debug_check_no_obj_freed lib/debugobjects.c:1108 [inline]
 debug_check_no_obj_freed+0x572/0x590 lib/debugobjects.c:1129
 free_pages_prepare mm/page_alloc.c:1269 [inline]
 free_unref_folios+0x576/0x17e0 mm/page_alloc.c:2737
 folios_put_refs+0x70a/0x800 mm/swap.c:992
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x595/0x1820 mm/shmem.c:1125
 shmem_truncate_range mm/shmem.c:1237 [inline]
 shmem_evict_inode+0x29d/0xa80 mm/shmem.c:1365
 evict+0x4f9/0x9b0 fs/inode.c:810
 __dentry_kill+0x20d/0x630 fs/dcache.c:660
 dput+0x19f/0x2b0 fs/dcache.c:902
 __fput+0x60b/0x9f0 fs/file_table.c:473
 task_work_run+0x251/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8f833170a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc3678eaf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f8f83761ae0 RCX: 00007f8f833170a8
RDX: 00005574fff315c8 RSI: 00007ffc3678e2f8 RDI: 0000000000000008
RBP: 00005571a8e7a620 R08: 0000000000000006 R09: cd47be37b8f960f8
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
R13: 00005571a8e8a890 R14: 0000000000000008 R15: 00005571a8e73910
 </TASK>
==================================================================
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 2b 00       	cmpb   $0x0,(%rbx,%r13,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 3d bd ff f5       	call   0xf5ffbd51
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 55                	jne    0x70
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 32 58 65 f5       	call   0xf5655861 <-- trapping instruction
  2f:	65 8b 05 0b 1e 3a 07 	mov    %gs:0x73a1e0b(%rip),%eax        # 0x73a1e41
  36:	85 c0                	test   %eax,%eax
  38:	74 46                	je     0x80
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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

