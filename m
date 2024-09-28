Return-Path: <netdev+bounces-130188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3406988FA3
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 16:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5BD1C20E51
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EEE188920;
	Sat, 28 Sep 2024 14:29:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2018873F
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533764; cv=none; b=JKpg2hE20nORwqhzafrT13cNiF8ZyAcTy1JxU4j9mtXmrOqYsALqLh4+hr5KRfWGw3s/jrv+FUlKtd6EcSpJl13YwWJLcSEKbZo6t6ULL5sbc3X1P8a9TIemXEYh5zzMwIayf+R0gUjCOFYirej7Jr9BMFvKYLUBAijb45g9g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533764; c=relaxed/simple;
	bh=5oNni+mSe09JH+bhmTUK3fHR/drg7MAOmsvZqHYuigo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=srNr7yjz4rBSEd5gKal0eF5beH6TCRrbMooOY34SOMEBhB1ohY9L6NBvPv+q2wiu6xEmPSVimYqHKNtnepjM/S5FP1ZcMRVJRKePe1KYfFrQEnzXWbhllJw+WNz4FdChaIhURQgxPx7OLL4jxyJnnFHvR03+Yrq55Onw+Syxv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so25990115ab.1
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 07:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727533762; x=1728138562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFZDIR1zH6xFqrLzHnV+4Ciyx/3Hq6RWaFFedJF75GI=;
        b=qLQSPe2pwIqGEzAD5oe+grKtF7Zu5eLdn/NrsLVA6dUic1g0stYz2ydTzkTcXQxxzD
         3u3H7VZzyNzBHY24CxPJZRQCXm1/AZGP2FGywJgnbrGxmGzsZUAl8D84Q9eVKOY5fblA
         H0kNGErcNn0LcvcKeZoY7XpA/I+/ORN/4EP/mA7l60OPj/rWw9h8aBORC16x2CfezSBi
         yPtid4sla30gdpEKm1i3pORX3S6qAOy/rFQgK21gXPSTL18DgoXXrFSd23HOBBzwRQ3s
         eTWvo6k2zfNqAoyxaawemxW6F9Bk10ElaKbHUzS2kwRn0arChlMNOiBBJrgFLD51B0yS
         zCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4HQp1w4+oH5x2uS4sa9a99OCcd9JIPEuzpFu/nhX1ESS6t/OSLH/q3QG1m9Wz4a67KDOm3ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV40CfBSql08ipNKZcpJeoGSjAx180bPMQ7TkP18FLqRHlZrTd
	bFCsOpWdxCU/NBuOIvhXqFLHSWNA/ss4F7EF+by0PtP75NelYdgTqJylz96W+MeKy/BtGg7xm+f
	6HyANh48cs2Qt5N8AgdTaqScvxfFicHMyVPaEi7F275//j/fgFXUAw98=
X-Google-Smtp-Source: AGHT+IHeFhhor4Gsk/fLVtp3IsnfVdVABoPmkMFfd9AL0mZgmpptM3JokBsur/3x+x9KJErwZ7Lq5sZ2qBIcpK6USeQVw3oJSfwR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1945:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a344638a4amr51949385ab.8.1727533761888; Sat, 28 Sep 2024
 07:29:21 -0700 (PDT)
Date: Sat, 28 Sep 2024 07:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f812c1.050a0220.4a974.0009.GAE@google.com>
Subject: [syzbot] [net?] [virt?] BUG: unable to handle kernel paging request
 in clear_page_erms (6)
From: syzbot <syzbot+0a31340d42a1d572f904@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a03107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=0a31340d42a1d572f904
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9800778169d6/disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32a789de3883/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24e5e7200094/bzImage-abf2050f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a31340d42a1d572f904@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880603bc000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1a801067 P4D 1a801067 PUD 6c591063 PMD 30259063 PTE 800fffff9fc43060
Oops: Oops: 0002 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 14210 Comm: syz.2.2649 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:clear_page_erms+0xb/0x20 arch/x86/lib/clear_page_64.S:50
Code: 48 8d 7f 40 75 d9 90 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
RSP: 0018:ffffc90000007310 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000001000
RDX: ffff8880603bc000 RSI: 0000000000000001 RDI: ffff8880603bc000
RBP: dffffc0000000000 R08: ffffea000180ef37 R09: 0000000000000000
R10: ffffed100c077800 R11: fffff94000301de7 R12: 0000000000000001
R13: 0000000000000001 R14: ffffea000180ef00 R15: 0000000000000000
FS:  00007fa3b27206c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880603bc000 CR3: 000000003ec82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 clear_page arch/x86/include/asm/page_64.h:54 [inline]
 clear_highpage_kasan_tagged include/linux/highmem.h:248 [inline]
 kernel_init_pages mm/page_alloc.c:1036 [inline]
 post_alloc_hook+0xf8/0x230 mm/page_alloc.c:1535
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 page_frag_alloc_1k net/core/skbuff.c:249 [inline]
 napi_alloc_skb+0x641/0xa00 net/core/skbuff.c:847
 page_to_skb+0x276/0x9b0 drivers/net/virtio_net.c:800
 receive_mergeable drivers/net/virtio_net.c:2253 [inline]
 receive_buf+0x3bc/0x17b0 drivers/net/virtio_net.c:2391
 virtnet_receive_packets drivers/net/virtio_net.c:2698 [inline]
 virtnet_receive drivers/net/virtio_net.c:2722 [inline]
 virtnet_poll+0x26b2/0x3980 drivers/net/virtio_net.c:2817
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xb9/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5189
Code: c9 50 e8 79 fa 0b 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 e0 70 60 0a e8 db 58 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000caa7228 EFLAGS: 00000282
RAX: 0b99d481b6833300 RBX: ffff888050f50000 RCX: ffffffff817088da
RDX: dffffc0000000000 RSI: ffffffff8c0aca40 RDI: ffffffff8c601bc0
RBP: ffffc9000caa7270 R08: ffffffff9422a907 R09: 1ffffffff2845520
R10: dffffc0000000000 R11: fffffbfff2845521 R12: 1ffff110170c7f0c
R13: dffffc0000000000 R14: ffff8880b863ea40 R15: ffff8880b863f860
 context_switch kernel/sched/core.c:5318 [inline]
 __schedule+0x184b/0x4ae0 kernel/sched/core.c:6674
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6853
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6877
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 free_unref_page+0x6b5/0xf00 mm/page_alloc.c:2662
 __folio_put+0x2c7/0x440 mm/swap.c:126
 secretmem_fault+0x1f9/0x430 mm/secretmem.c:87
 __do_fault+0x135/0x460 mm/memory.c:4876
 do_shared_fault mm/memory.c:5346 [inline]
 do_fault mm/memory.c:5420 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault+0x1105/0x6800 mm/memory.c:5751
 __handle_mm_fault mm/memory.c:5894 [inline]
 handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6062
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc9000caa7df0 EFLAGS: 00050246
RAX: 0000000600000005 RBX: 0000000020000088 RCX: 0000000000000008
RDX: 0000000000000000 RSI: ffffc9000caa7e80 RDI: 0000000020000080
RBP: ffffc9000caa7ef0 R08: ffffc9000caa7e87 R09: 1ffff92001954fd0
R10: dffffc0000000000 R11: fffff52001954fd1 R12: 0000000000000008
R13: ffffc9000caa7e80 R14: 0000000020000080 R15: ffffc9000caa7e80
 copy_user_generic arch/x86/include/asm/uaccess_64.h:121 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:142 [inline]
 _inline_copy_to_user include/linux/uaccess.h:188 [inline]
 _copy_to_user+0x86/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 do_pipe2+0x109/0x310 fs/pipe.c:1026
 __do_sys_pipe fs/pipe.c:1047 [inline]
 __se_sys_pipe fs/pipe.c:1045 [inline]
 __x64_sys_pipe+0x3a/0x50 fs/pipe.c:1045
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3b197def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3b2720038 EFLAGS: 00000246 ORIG_RAX: 0000000000000016
RAX: ffffffffffffffda RBX: 00007fa3b1b36058 RCX: 00007fa3b197def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007fa3b19f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa3b1b36058 R15: 00007ffd07c8ed88
 </TASK>
Modules linked in:
CR2: ffff8880603bc000
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_page_erms+0xb/0x20 arch/x86/lib/clear_page_64.S:50
Code: 48 8d 7f 40 75 d9 90 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
RSP: 0018:ffffc90000007310 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000001000
RDX: ffff8880603bc000 RSI: 0000000000000001 RDI: ffff8880603bc000
RBP: dffffc0000000000 R08: ffffea000180ef37 R09: 0000000000000000
R10: ffffed100c077800 R11: fffff94000301de7 R12: 0000000000000001
R13: 0000000000000001 R14: ffffea000180ef00 R15: 0000000000000000
FS:  00007fa3b27206c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880603bc000 CR3: 000000003ec82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8d 7f 40          	lea    0x40(%rdi),%rdi
   4:	75 d9                	jne    0xffffffdf
   6:	90                   	nop
   7:	c3                   	ret
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	0f 1f 00             	nopl   (%rax)
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64
  23:	b9 00 10 00 00       	mov    $0x1000,%ecx
  28:	31 c0                	xor    %eax,%eax
* 2a:	f3 aa                	rep stos %al,%es:(%rdi) <-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  38:	00 00 00
  3b:	0f 1f 40 00          	nopl   0x0(%rax)
  3f:	90                   	nop


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

