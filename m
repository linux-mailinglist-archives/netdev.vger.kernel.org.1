Return-Path: <netdev+bounces-112742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A477193AF31
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5997C282D38
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87F14B973;
	Wed, 24 Jul 2024 09:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044360B8A
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814333; cv=none; b=KZNbWeZPTsLspaYxIjXHWeqRTG3HZ9b8fIk8AOot9e19+32vSB6HIyXLBn1+K/ZMsuzE6i6cNvduUM4o37+Svu9Oz0KDvH0imQkwWIeYppM9tynqCk5b0MRjr090ixwJA57x6uTHnpgyE31XmNr9CCDxn/oNoObz7DMrhVONqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814333; c=relaxed/simple;
	bh=uE63k7xGFyRjBlaat4CbHaydYDufIZu9gL4CRlWw6FA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BVyQdP5rnDGhkWvncYDidl01YdtGH6RZt8pmPMZWwVBY8ggyzDRVpUjPSjmjiBVylnNxkVGxtjU1n3m7SezPdgCnOZ8kGx+xZ6nVKAGY4aBkMUw1pLjIF271+TfQqBViTZGEpgm0VuxTsebZzESVeHD88KFYmh/Y6bhLd5TVutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f92912a614so1072611439f.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814331; x=1722419131;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGqRwjGhA6CqQCydFuXZbl1EfkTEI7M6qNM6wCnGrhM=;
        b=kdTJ55uIFyRxvqK+GTlUVM7zvvNLJFKzzIN4rQf5iHFzxGPmZaSeNkXTQs3qxylzY9
         fX9vxcM9CsGNAKgi7Zpe4aaVwvO2xuyHOJJobLEfwn9P9w77zL87+K55Ol2ohBoRuiV0
         yuLTMW0LuCOH2+6Yxy5IxM0ic8Vgm3QsIrQTvk+RFekmXF/yTi+BzhBVgl6WGv02uoUc
         uTRymtQN5BVrnzaaBl+DsjX5MkG65wDkeQXmpHnzhZTrK9JaxMljpTUNFHTwIr2Q+dqP
         YAWiDFDXULyEzUtCQAFlHPCSd0CoHF72g7YMTmDqkGznfK3AqQABJclngu1Zj+RLICtf
         UzTw==
X-Forwarded-Encrypted: i=1; AJvYcCWTXxgTDhHji8Pa+VOS9p4sP+CajbUKumqNtzeADlkAQECrl85F7WVKeKxUnVqXHc8FEwgKkKLKBnVk+Lwzm+vWkrkm71w6
X-Gm-Message-State: AOJu0YwXFfqN0M7WWhxaBZmXQoH8lUkU8P6UuoDsSKhkqVUsfvZrjsut
	yuoZFxly/Gn8JMO5bXicwTBbIg0ZFJ1UzGffQpStfPWDfHYR00RdtmCoHJFgfv2ma01bb/fZpl5
	KwXfUpC362I3LomFn2DVnO7lN+4lU9GWV0BWW9FOLNz7mwy7uEZvQlwk=
X-Google-Smtp-Source: AGHT+IEhlHz8fRhbS+6k1hSSPdkJNK07uxk+iI7yUbc5mqzzHhnb72uR8Bm1/JzAkRzV2LOL8p88cU6Qq5Ag0mx2qaUffR2H+rAg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408b:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4c28efc1d76mr120051173.4.1721814330762; Wed, 24 Jul 2024
 02:45:30 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008df61a061dfb2366@google.com>
Subject: [syzbot] [net?] WARNING in cake_dequeue (2)
From: syzbot <syzbot+3880fb06c3b7f5ec1878@syzkaller.appspotmail.com>
To: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7846b618e0a4 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b09fe9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=3880fb06c3b7f5ec1878
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1367075cbd79/disk-7846b618.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f252a22f2003/vmlinux-7846b618.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23bea0ad3ab6/bzImage-7846b618.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3880fb06c3b7f5ec1878@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 22566 at net/sched/sch_cake.c:2094 cake_dequeue+0x2af1/0x4690 net/sched/sch_cake.c:2094
Modules linked in:
CPU: 0 PID: 22566 Comm: syz.3.4579 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:cake_dequeue+0x2af1/0x4690 net/sched/sch_cake.c:2094
Code: 74 08 4c 89 f7 e8 af d7 6b f8 4d 89 26 eb 05 e8 75 e1 08 f8 45 31 f6 4c 8b a4 24 08 01 00 00 e9 d4 de ff ff e8 60 e1 08 f8 90 <0f> 0b 90 48 8b 94 24 f0 00 00 00 48 89 d0 48 c1 e8 03 42 0f b6 04
RSP: 0018:ffffc900000079c0 EFLAGS: 00010246
RAX: ffffffff898a6160 RBX: 000000000000ffff RCX: ffff888067efda00
RDX: 0000000080000101 RSI: 000000000000ffff RDI: 0000000000000400
RBP: ffffc90000007c28 R08: ffffffff898a5f7c R09: ffffffff898a69e5
R10: 0000000000000003 R11: ffff888067efda00 R12: ffff88805a900010
R13: dffffc0000000000 R14: 000000000000ffff R15: ffff88805a900000
FS:  00007f3db68136c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3141fffc CR3: 0000000073d06000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 dequeue_skb net/sched/sch_generic.c:293 [inline]
 qdisc_restart net/sched/sch_generic.c:398 [inline]
 __qdisc_run+0x272/0x2170 net/sched/sch_generic.c:416
 qdisc_run+0xda/0x270 include/net/pkt_sched.h:127
 net_tx_action+0x89c/0xa50 net/core/dev.c:5322
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
RIP: 0010:stack_trace_save+0x0/0x1d0 kernel/stacktrace.c:114
Code: 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 45 31 e4 eb e1 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48
RSP: 0018:ffffc9000a016db8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888067efdf80 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000010 RDI: ffffc9000a016e00
RBP: ffffc9000a016ef0 R08: ffffffff82005562 R09: 0000000000000000
R10: ffffc9000a016e00 R11: fffff52001402dd0 R12: dffffc0000000000
R13: 1ffff92001402dbc R14: ffffc9000a016e00 R15: 1ffff1100cfdfbf0
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x92/0x800 mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vma_alloc_folio_noprof+0xf3/0x1f0 mm/mempolicy.c:2304
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4397 [inline]
 do_anonymous_page mm/memory.c:4455 [inline]
 do_pte_missing mm/memory.c:3895 [inline]
 handle_pte_fault+0x257b/0x7090 mm/memory.c:5381
 __handle_mm_fault mm/memory.c:5524 [inline]
 handle_mm_fault+0xfb0/0x19d0 mm/memory.c:5689
 faultin_page mm/gup.c:1305 [inline]
 __get_user_pages+0x6ec/0x16a0 mm/gup.c:1604
 populate_vma_page_range+0x264/0x330 mm/gup.c:2043
 __mm_populate+0x27a/0x460 mm/gup.c:2146
 mm_populate include/linux/mm.h:3469 [inline]
 vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:593
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3db5975b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3db6813048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f3db5b05f60 RCX: 00007f3db5975b59
RDX: 000000000000000f RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f3db59e4e5d R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000004008032 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f3db5b05f60 R15: 00007ffc8713fc48
 </TASK>
----------------
Code disassembly (best guess):
   0:	5d                   	pop    %rbp
   1:	41 5e                	pop    %r14
   3:	41 5f                	pop    %r15
   5:	5d                   	pop    %rbp
   6:	c3                   	ret
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	90                   	nop
   c:	0f 0b                	ud2
   e:	90                   	nop
   f:	45 31 e4             	xor    %r12d,%r12d
  12:	eb e1                	jmp    0xfffffff5
  14:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
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
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	55                   	push   %rbp
  2f:	48 89 e5             	mov    %rsp,%rbp
  32:	41 57                	push   %r15
  34:	41 56                	push   %r14
  36:	41 55                	push   %r13
  38:	41 54                	push   %r12
  3a:	53                   	push   %rbx
  3b:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  3f:	48                   	rex.W


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

