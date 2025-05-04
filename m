Return-Path: <netdev+bounces-187658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AADAA8919
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7C6189466B
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113F21CFFF;
	Sun,  4 May 2025 19:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99F1A724C
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385892; cv=none; b=meNAIkRcZZVFI9KfcLK31yW1+TmaZ6Fvu/gw415DtSb8BLKHLfs+TkAe/Yyr7cpvUFJHbrDK565TSOahh8/DGl3v/79UJ60/JGxXCsIHjwh8cfZ1VhbEOJNDaBnbFGOvUlspKEP9DSBQNqGtSjwPNOPrYigiEiaJQGkLG2b7opI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385892; c=relaxed/simple;
	bh=3E+YcWVP/9Nw+NEOvQE81FIYWhkMuzP3jH3LvVgslkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mIwkLgZT26aEQLz8Ckdn3KBh5I+R1Rdn729xdtGBVJsTwuVrYLwppWzbWipBveQBI7nJajGGcED72kJI3/zPSXJBW7YwjUznZdiOCTsfzhvPWclwRpCK7en2iPC/Z0lhdvdsIgAUjXqXBI33+7hZhglJn6DkpRyA+SKM0Be0lCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d94fe1037cso48103025ab.0
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 12:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746385890; x=1746990690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNqpiq+dOjeuBGQVYN+njW6zX8JKNgfatRSjmR2W8PU=;
        b=KZl0jcuvXhaSmQp84x/iCRKYIPf12NwIRvmbNQKuvXKjllidpJxFbnOFQyabH0VlQJ
         6vu86MDREdIJGr5415U0nu9nLh7x6DcAfQBPF2RgpdEQaAtYDVqjJLIgn/smjBuizWVg
         2FOPvLgIzpOG5CaONbqyE00BAkiB7qXlgEuluK7CypBfjD78mtOTjdsXUYABcIe5pbyW
         M/zY4JGMm05RXI+LOz+GPlW+SP/ImD42quDtwIfq1n2jioA9jasZm7JdCXN8C/U8blpA
         gVDIF0Y8xxiW9Cp68yiIxRWNUN+oj9Lmq6jT+z6Y7C9anKyjvILmH611uKgBvZtckgqq
         blVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa6jAICjywNyXHvR8SP2vS74uk6MyPKpWrj452rvqWYDUQgtGYFFZ1uet9WzQzBGVekm8OF1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCW11B3b6EmveAmdT23tz3vtVbOq6nmFPQUm+nxhv5y4jKUt5R
	86IGdodHmH8/i436rCvCPD3c1hAtfJTmh+dPbsAfZceOMuZWwe3naMIx9FJbAjEsWC+CPbVasUS
	W9aEUUoJMvgNfIQ49qbOJZMfrEC4hDX+yfeT/wsDgPpeWcLDKh3EI9as=
X-Google-Smtp-Source: AGHT+IGNrJAhf1VY6/aP3MUEnlLIgKnCaIa6WPIt+GnFR14l4liRkh6Lue6L6uCdSAaPl0L1qot4ztVhA7Hwrgnw++udAc4L58IO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2510:b0:3d6:cd54:ba53 with SMTP id
 e9e14a558f8ab-3da5b3422cdmr49602205ab.22.1746385890123; Sun, 04 May 2025
 12:11:30 -0700 (PDT)
Date: Sun, 04 May 2025 12:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6817bbe2.050a0220.37980e.0009.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in in_dev_free_rcu
From: syzbot <syzbot+c018003aac1ce42c201c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8ab83e34bdc Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161070f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=c018003aac1ce42c201c
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/302be2947fe2/disk-e8ab83e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e46c6c2a8126/vmlinux-e8ab83e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15cd5b87eeda/bzImage-e8ab83e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c018003aac1ce42c201c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 9997 Comm: syz.4.1044 Not tainted 6.15.0-rc4-syzkaller-00296-ge8ab83e34bdc #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:__phys_addr+0x15b/0x170 arch/x86/mm/physaddr.c:28
Code: 98 ae 00 e9 3c ff ff ff e8 22 a4 4c 00 48 c7 c7 30 9f da 8d 48 89 de 4c 89 f2 e8 b0 9b 7a 03 e9 44 ff ff ff e8 06 a4 4c 00 90 <0f> 0b e8 fe a3 4c 00 90 0f 0b e8 f6 a3 4c 00 90 0f 0b 0f 1f 00 90
RSP: 0018:ffffc90000a08b58 EFLAGS: 00010246
RAX: ffffffff81731c4a RBX: 00007780ffff0000 RCX: ffff88802ecc9e00
RDX: 0000000000000100 RSI: 000000017fff0000 RDI: 00007780ffff0000
RBP: ffffc90000a08e30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff89deb440 R12: ffffffff89deb440
R13: ffffffff81a87dc4 R14: 000000017fff0000 R15: ffff8880243dd1f8
FS:  00007f41051dc6c0(0000) GS:ffff8881261cb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa1fffc CR3: 0000000053213000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 virt_to_folio include/linux/mm.h:1402 [inline]
 kfree+0x70/0x440 mm/slub.c:4833
 in_dev_free_rcu+0x49/0x60 net/ipv4/devinet.c:245
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2824
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:next_uptodate_folio+0x1/0x5d0 mm/filemap.c:3552
Code: 6a c8 ff e8 01 2f 3c ff eb bb 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 30 48 89 d3 48 89 34 24 49 89
RSP: 0018:ffffc90004d0f610 EFLAGS: 00000287
RAX: ffffffff81f7404c RBX: 00000000000000e0 RCX: 0000000000080000
RDX: 00000000000000ef RSI: ffff888057126c20 RDI: ffffc90004d0f740
RBP: ffffc90004d0f7f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff81f73ffb R12: ffffc90004d0f900
R13: dffffc0000000000 R14: 0000000000000001 R15: 1ffff920009a1f20
 filemap_map_pages+0x21f/0x1740 mm/filemap.c:3705
 do_fault_around mm/memory.c:5476 [inline]
 do_read_fault mm/memory.c:5509 [inline]
 do_fault mm/memory.c:5652 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:5997 [inline]
 __handle_mm_fault+0x34db/0x5380 mm/memory.c:6140
 handle_mm_fault+0x3f6/0x8c0 mm/memory.c:6309
 faultin_page mm/gup.c:1193 [inline]
 __get_user_pages+0x16f0/0x2a40 mm/gup.c:1491
 populate_vma_page_range+0x26b/0x340 mm/gup.c:1929
 __mm_populate+0x24c/0x380 mm/gup.c:2032
 mm_populate include/linux/mm.h:3487 [inline]
 vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f410438e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f41051dc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f41045b5fa0 RCX: 00007f410438e969
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007f4104410ab1 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f41045b5fa0 R15: 00007ffded4fe268
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x15b/0x170 arch/x86/mm/physaddr.c:28
Code: 98 ae 00 e9 3c ff ff ff e8 22 a4 4c 00 48 c7 c7 30 9f da 8d 48 89 de 4c 89 f2 e8 b0 9b 7a 03 e9 44 ff ff ff e8 06 a4 4c 00 90 <0f> 0b e8 fe a3 4c 00 90 0f 0b e8 f6 a3 4c 00 90 0f 0b 0f 1f 00 90
RSP: 0018:ffffc90000a08b58 EFLAGS: 00010246
RAX: ffffffff81731c4a RBX: 00007780ffff0000 RCX: ffff88802ecc9e00
RDX: 0000000000000100 RSI: 000000017fff0000 RDI: 00007780ffff0000
RBP: ffffc90000a08e30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff89deb440 R12: ffffffff89deb440
R13: ffffffff81a87dc4 R14: 000000017fff0000 R15: ffff8880243dd1f8
FS:  00007f41051dc6c0(0000) GS:ffff8881261cb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa1fffc CR3: 0000000053213000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	e8 01 2f 3c ff       	call   0xff3c2f06
   5:	eb bb                	jmp    0xffffffc2
   7:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   e:	0f 1f 84 00 00 00 00
  15:	00
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	55                   	push   %rbp
* 27:	41 57                	push   %r15 <-- trapping instruction
  29:	41 56                	push   %r14
  2b:	41 55                	push   %r13
  2d:	41 54                	push   %r12
  2f:	53                   	push   %rbx
  30:	48 83 ec 30          	sub    $0x30,%rsp
  34:	48 89 d3             	mov    %rdx,%rbx
  37:	48 89 34 24          	mov    %rsi,(%rsp)
  3b:	49                   	rex.WB
  3c:	89                   	.byte 0x89


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

