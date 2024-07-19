Return-Path: <netdev+bounces-112164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70D93732D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 07:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC152282491
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 05:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A7376E6;
	Fri, 19 Jul 2024 05:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CE17BA1
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365945; cv=none; b=p3mNEe1rO5kSeUXUwnTg7R+rsPUhbdE5fh5yAqQ/6m6ifZnOTVUM1xE4g+mduCmYQV91cDfLXxLf9bmDKh4PaD+6mx4fGoJ5zWMcfsrv/LIwSBoLx/pLS1qWFVIiZxwN+lfU64EHR3mx5+9Xy7/9UNOhBzMEZL96np95CrUWWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365945; c=relaxed/simple;
	bh=rzu2dXFAGxZihx9hsnAkMTT9JUHI7FYK+Z27tFdi/6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=laEvWEJMPuiZBy7GWLTv77iIOfWK94P8OC4qg47H4m/pdtFBJ/QF1tnMseUrIIezmsz0ieufb/uXVVOyi8A9jaTkLvLj0FAtrWoNXwXcacNZN/HkbAtRAv+1Xzlf9xgyReBuXa0syNN6tagZuwC7mqpHHLjRarQ3rEo2uIN5aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso253325639f.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 22:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721365943; x=1721970743;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQm6CkqhlGN7Er6MHfpxutsEimneH/Rdq4u/3gPfltg=;
        b=kxApAv6PIHiyNd5dtgjaYrfSCLM+JvKQVqNRDt4CkkhqeP8lRomHdt3ivdyLKOWr7M
         0nJvlxF+3C6w3WTF4UWhYvBcoy69mOBYdFakz7SCXiW8xWqvFEU+uDESOkvXl3bdhSTg
         34QnDzpmT7FXqceEcxKKJi6aUnQlXK76vEcwqUJRbFWYLrz2ev8U3CwkgOXS8adgOw2P
         wK6lZP9mTuGjm8K2VghB6E6VPZY8TgOLOn0UeEbzw0io0xnaeZwcNKcEkIl3A/s0RsLT
         GdMhoz3AGfST2AXVoOaQhBuWBXQv+AXjZ8M1pJw4fGoal1/8HpAJdV0+fSgW7IkCKE+V
         NkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHBli5jrBEAG4gHoGeFjfq7yqeEGYOmxiHlDM75rDxH4oU/m4xzEFMNEbZ6a8BoyeQG1+N0ca6tHfRxBxCCfKm9nH8yAR6
X-Gm-Message-State: AOJu0YxiPgfDTsIZANVCZvmUnnE689SqX7v65nVrsJZRfx8XCyjqE2UJ
	Up8z8TbaePffQyWjKaMcYoEzAUrqAXUAFSqpKSxfYVa0xF/deqSXnBA3E05852//WkXxTgUNxyc
	WuOwsixsNUZXgoF6z5B6tkRWsgHg6saBy+bhRZvcWSOJXJ+UfAxAL+yk=
X-Google-Smtp-Source: AGHT+IFrU1x7qZiHaRS56a1WwAgFxNAvf21p2Sqw5cit1k9WfEoa6ZSM6funIRenq0ZA3Ck4My77TDdGR/hwG3+u/st97hlGq8eq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8403:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4c2158c7954mr439994173.1.1721365943299; Thu, 18 Jul 2024
 22:12:23 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:12:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000943e1c061d92bdd6@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    73399b58e5e5 Add linux-next specific files for 20240718
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f2195980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e443ddc2b981c8
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602cf31980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fde5e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fbab059c854f/disk-73399b58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/874a209f4c3f/vmlinux-73399b58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f34e5c7be278/bzImage-73399b58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in ./kernel/bpf/devmap.c:385:28
index 16 is out of range for type 'struct xdp_frame *[16]'
CPU: 1 UID: 0 PID: 5101 Comm: syz-executor232 Not tainted 6.10.0-next-20240718-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 bq_xmit_all+0x157/0x11d0 kernel/bpf/devmap.c:385
 __dev_flush+0x81/0x160 kernel/bpf/devmap.c:425
 xdp_do_check_flushed+0x129/0x240 net/core/filter.c:4300
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ce cf 5c f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 69 c4 f5 65 8b 05 04 5f 65 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000369fb60 EFLAGS: 00000206
RAX: 3e45100d05912800 RBX: 1ffff920006d3f70 RCX: ffffffff817023ea
RDX: dffffc0000000000 RSI: ffffffff8bcad5c0 RDI: 0000000000000001
RBP: ffffc9000369fbf0 R08: ffffffff9300f817 R09: 1ffffffff2601f02
R10: dffffc0000000000 R11: fffffbfff2601f03 R12: dffffc0000000000
R13: 1ffff920006d3f6c R14: ffffc9000369fb80 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 do_notify_parent_cldstop+0x9ab/0xb50 kernel/signal.c:2216
 ptrace_stop+0x465/0x940 kernel/signal.c:2319
 ptrace_do_notify kernel/signal.c:2393 [inline]
 ptrace_notify+0x255/0x380 kernel/signal.c:2405
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_entry include/linux/ptrace.h:452 [inline]
 syscall_trace_enter+0x5d/0x150 kernel/entry/common.c:45
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f708ebe0e20
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d 81 e2 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffd97b2a878 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000015 RCX: 00007f708ebe0e20
RDX: ffffffffffffffb8 RSI: 0000000020000240 RDI: 0000000000000014
RBP: 0000000000000000 R08: 00007ffd97b2a9a8 R09: 00007ffd97b2a9a8
R10: 00007ffd97b2a9a8 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffd97b2a8b0 R15: 00007ffd97b2a8a0
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 ce cf 5c f6       	call   0xf65ccfe2
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 c3 69 c4 f5       	call   0xf5c469f2 <-- trapping instruction
  2f:	65 8b 05 04 5f 65 74 	mov    %gs:0x74655f04(%rip),%eax        # 0x74655f3a
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
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

