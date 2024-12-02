Return-Path: <netdev+bounces-148028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E99DFE0A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2319CB20996
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB24C1FA146;
	Mon,  2 Dec 2024 10:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6715A8
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133807; cv=none; b=YLK0sjL8fN08gF6xrENURei/q5UJ4hc9DB+hefyIaBkxXh8dJcw7BR+nSV1GO+KIzpyQd9dHbuqVI41LSCmHjLatVuZfcK1Z9qWt715aD9eDK2taf2zHq1i5l7AGWhGwwdgrHX/XpoYQQBuGo3Rh5q/Rw4a31vHWQYS5s3l5w7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133807; c=relaxed/simple;
	bh=OfZYeeWsMt9z/s6MD8ZB6Gu24zYd5PSsK6U+IUwTR6I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fIJlDh8soB+hPc6V3fWzb4hwcQKpOp2pJyCjgomeIEYR75vOLVhu+KueapFOCPhfn4q8m82EA1CA3Kdt4KT3ncmJobMsrJlVLdztdWzXDkH6kf99qO7ewT63mLypRskozfhYhHR64UrSgKC4BvMfvH1HMtgTRzC7vbusnoUnMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a77a808c27so48244145ab.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 02:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133805; x=1733738605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSr0cTo+MXgmICdMWeai3k/PBKyjCFCIleLVLFMdi84=;
        b=iMZNEFbosBAkjsb+EKlq6/uid0bKKgCVSEMb+qBM1ftrLzn6QOfYw00OmdGL9ZSVqO
         G2mk7adJCyXywzF7lOFfcYBX+/m7/Jx8OiQw6rWypXTfoRXhREU703aOaA/QpGE8xNbR
         2SNfFUaI/FiFGDFB6wbnU8GKKl2i04p6Ww/zwIZ9n/Tntch2PXLQsZqko7EeagTT6XLN
         /AUEXK3LfqmYDGtxOf8ltCcwAiTnvEbIZ1ihshSPFEfBlGQlBT+KDONexq+63nZv+GJ9
         sHzYz4SopoXeBEwfLysAbDIAQX/OdjcggRr3o273955SHmsPFxhfZHtIcE3eX9RVpxpn
         g9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZZjpLH1icrmF4+AMk4QBMxWvuIRfd2k2bgzB0xplzmylWfgrxQogvyt9BUAAfTFOuJHq3yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdFDT1eYmptq1T9R/oYach8Cb9gxIy18sae2ugGfoeGOJOwFm2
	06PYM1vddlnzbsjOwt3BOxX6QPOOPIbGD4RmnZhu35guhsXcstXuFl7kIJUY7YCwRqMadxSgbaH
	uYbUe3ZmfKUsoYyPCE4EmpTOEnDAnD3ReGrDcgAdsgv18a9CuhafBnrk=
X-Google-Smtp-Source: AGHT+IFDfxzKT9K4zNKsiHYkE6ocVbT2wzU92HOS60bPlm+7TXWlOk3jfyvAmLaBRbnWONosmd7ASKHdfKUKrmE2aT1qAqkFhn/U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a7:6636:eb48 with SMTP id
 e9e14a558f8ab-3a7c55d4c48mr243338015ab.18.1733133805511; Mon, 02 Dec 2024
 02:03:25 -0800 (PST)
Date: Mon, 02 Dec 2024 02:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d85ed.050a0220.48a03.0023.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in send_hsr_supervision_frame
From: syzbot <syzbot+7f4643b267cc680bfa1c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43fb83c17ba2 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1324a75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58b000b917043826
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4643b267cc680bfa1c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-43fb83c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5678208ca6c/vmlinux-43fb83c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e25541cc1d8e/bzImage-43fb83c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f4643b267cc680bfa1c@syzkaller.appspotmail.com

skbuff: skb_over_panic: text:ffffffff8b01a76a len:34 put:6 head:ffff88806010f300 data:ffff88806010f422 tail:0x144 end:0x140 dev:gretap0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:206!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.12.0-syzkaller-03657-g43fb83c17ba2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_panic+0x157/0x1d0 net/core/skbuff.c:206
Code: b6 04 01 84 c0 74 04 3c 03 7e 21 8b 4b 70 41 56 45 89 e8 48 c7 c7 20 06 9c 8c 41 57 56 48 89 ee 52 4c 89 e2 e8 8a 69 75 f8 90 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 24 c9 f7 f8 4c
RSP: 0018:ffffc90000908ab0 EFLAGS: 00010286
RAX: 0000000000000087 RBX: ffff888035ec9400 RCX: ffffffff816d8479
RDX: 0000000000000000 RSI: ffffffff816e2e46 RDI: 0000000000000005
RBP: ffffffff8c9c1a40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000302 R11: 0000000000000003 R12: ffffffff8b01a76a
R13: 0000000000000006 R14: ffff88804c89a130 R15: 0000000000000140
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74751e7f98 CR3: 000000005b9f0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_over_panic net/core/skbuff.c:211 [inline]
 skb_put+0x174/0x1b0 net/core/skbuff.c:2617
 send_hsr_supervision_frame+0x6fa/0x9e0 net/hsr/hsr_device.c:342
 hsr_proxy_announce+0x1a3/0x4a0 net/hsr/hsr_device.c:436
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers+0x6e8/0x930 kernel/time/timer.c:2418
 __run_timer_base kernel/time/timer.c:2430 [inline]
 __run_timer_base kernel/time/timer.c:2422 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2439
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:655
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:671
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 83 69 3e 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc900001a7e08 EFLAGS: 00000202
RAX: 00000000000d2b19 RBX: 0000000000000003 RCX: ffffffff8b282479
RDX: 0000000000000000 RSI: ffffffff8b6cda40 RDI: ffffffff8bd1e340
RBP: ffffed1003b5c488 R08: 0000000000000001 R09: ffffed100d52702d
R10: ffff88806a93816b R11: 0000000000000000 R12: 0000000000000003
R13: ffff88801dae2440 R14: ffffffff90602ad0 R15: 0000000000000000
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x329/0x3f0 kernel/sched/idle.c:325
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
 start_secondary+0x222/0x2b0 arch/x86/kernel/smpboot.c:314
 common_startup_64+0x13e/0x148
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x1d0 net/core/skbuff.c:206
Code: b6 04 01 84 c0 74 04 3c 03 7e 21 8b 4b 70 41 56 45 89 e8 48 c7 c7 20 06 9c 8c 41 57 56 48 89 ee 52 4c 89 e2 e8 8a 69 75 f8 90 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 24 c9 f7 f8 4c
RSP: 0018:ffffc90000908ab0 EFLAGS: 00010286
RAX: 0000000000000087 RBX: ffff888035ec9400 RCX: ffffffff816d8479
RDX: 0000000000000000 RSI: ffffffff816e2e46 RDI: 0000000000000005
RBP: ffffffff8c9c1a40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000302 R11: 0000000000000003 R12: ffffffff8b01a76a
R13: 0000000000000006 R14: ffff88804c89a130 R15: 0000000000000140
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74751e7f98 CR3: 000000005b9f0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 01 c7             	add    %r8,%rdi
   3:	4c 29 c2             	sub    %r8,%rdx
   6:	e9 72 ff ff ff       	jmp    0xffffff7d
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
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
  1b:	f3 0f 1e fa          	endbr64
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d 83 69 3e 00 	verw   0x3e6983(%rip)        # 0x3e69ab
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  37:	00 00 00 00
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

