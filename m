Return-Path: <netdev+bounces-85960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF389D078
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD89B1C22362
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15654657;
	Tue,  9 Apr 2024 02:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FA3EA64
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630789; cv=none; b=DDDEppYEWM1s09Nd1k92Pw6E4eb3fF//p6kkbDjW94pkQU5r+ULoxbuHghEedNqS5qPGKsbdBfOOybMHDdMVUyeoDdxcZEpzQVNK60HO8yPobQMYsBoG8LgUaGZOmRgDqkneVbEGF3BrBtZK51rztBzL4PWO2N+LK9GAdNqjokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630789; c=relaxed/simple;
	bh=lo/giFIi6uXOlZ1TWwAvEc339hEUY1Oxg730cL1hCGY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PuGGwoxO9mjTPVUnQnnBc1t2wEu16N/+0f4VX9939LU555EK+FaD7ciS193l7GlpgDKuinEiUBADaDaAMofuKyDhRLyerTu2DwBUJ6+tPAZIHi9CA2wP5n5fI14ETOHy+6nHWfTCd/T/AdV9rdQ/q22dhEYAuB/mmN0X+YeIvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d096c4d663so673329839f.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 19:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712630787; x=1713235587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoTG/d19Q6BvrfLJpuL4RBDA52R9f+f2OOg1ohNz/Ns=;
        b=X8LKtuFj5oXJEfPJhY6r+2JCQucne+o6/99y3tqbRaoZD5U5GO+D3z0v/dNenlWUg2
         W8cC4dMY8FvosnmymMTmXsY44ZTMGR97m0cJcXxOV0BrADklDHBv/k6fcPYjUTrd1YEN
         jMu2BsJ8dXxXQ91SWekR4xykNhmmIcM/OCqdKrd43xOzv6oG/4LXgPdlMo832uo13yE7
         o2LBc8zgva8ihhZIPNFhWdrSa9l1SP5z09dXKvruaiohNCw/CIs0oDoL+Sf43GUdY+ha
         WxbBnN5lwsGZPbrftOecaZVhcKJLsKUTGhRtV1oz9hXELy2S/prL2vdFdJSTjjVLjTtx
         wprw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQmwzRW9EyYl72YQK3ny7R5q/zfe6SCrE9OYkjJWMVV82PsCjLoXLgpyQZTyLO1gfHGNPah5VLZFy7FUAFci4xR5g2AuN
X-Gm-Message-State: AOJu0YwdlIvnoIRBy06KC6IH0owBeu6ol+9irmLzErG6/GRDqsF+62Vk
	/Tg359Zdhuk8yIwkdmD3TZc6gislaab7VtJfSwlZAScj86ww3hQJhNAwb687GhUyEHprCvBcZ2E
	eXkts+NQzM65iCvjR35BCgMTq3GwwapyuPmYCSk/wiQPVMrnpL66b/yk=
X-Google-Smtp-Source: AGHT+IEBpFl8RUJwB85tABxSP3gCQh9BDn9UYdZojukKeOiQ3GP3a+gAD3qQcGknhpOY5x2fspu2Us2zQ6iyE47ceY+5s/TuJpOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2102:b0:47e:c4a2:f774 with SMTP id
 n2-20020a056638210200b0047ec4a2f774mr343612jaj.4.1712630787434; Mon, 08 Apr
 2024 19:46:27 -0700 (PDT)
Date: Mon, 08 Apr 2024 19:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b77a880615a0ed2a@google.com>
Subject: [syzbot] [kernel?] WARNING in hrtimer_forward (2)
From: syzbot <syzbot+d1ae9c954f73570e7b58@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1579f7b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=d1ae9c954f73570e7b58
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1ae9c954f73570e7b58@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11239 at kernel/time/hrtimer.c:1053 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
Modules linked in:
CPU: 1 PID: 11239 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
Code: 00 49 89 1e 48 8b 04 24 eb 07 e8 2b a4 12 00 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 11 a4 12 00 90 <0f> 0b 90 eb e0 4c 89 f0 31 d2 49 f7 f4 48 89 04 24 49 89 c6 4d 0f
RSP: 0018:ffffc90000a08bf8 EFLAGS: 00010246
RAX: ffffffff81824c5f RBX: 0000000000000001 RCX: ffff88805fe18000
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000003636b41721 R08: ffffffff81824af3 R09: 1ffffffff1f0d5cd
R10: dffffc0000000000 R11: ffffffff81353f80 R12: 00000000061a8000
R13: ffff88805e27ef38 R14: 00000000cb354006 R15: 1ffff1100bc4fde3
FS:  00007f4b92fa26c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7730ed5690 CR3: 0000000047bcc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
 mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2335
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bpf_prog_is_offloaded include/linux/bpf.h:2972 [inline]
RIP: 0010:do_check+0x7a14/0x10740 kernel/bpf/verifier.c:17669
Code: 00 00 00 00 00 fc ff df 48 8b 1b b8 fa 00 00 00 48 01 c3 48 89 d8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 da 4d 00 00 0f b6 1b <31> ff 89 de e8 a3 0a eb ff 85 db 74 5a 48 ba 00 00 00 00 00 fc ff
RSP: 0018:ffffc90005336dc0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000c2c8000 RSI: 000000000000a51a RDI: 000000000000a51b
RBP: ffffc90005337120 R08: ffffffff81a9e50d R09: 1ffff1100bfc3000
R10: dffffc0000000000 R11: ffffed100bfc3001 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90005337080 R15: ffff88805fe18000
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20508
 do_check_main kernel/bpf/verifier.c:20599 [inline]
 bpf_check+0x126eb/0x18fe0 kernel/bpf/verifier.c:21269
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4b9227de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4b92fa20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f4b923ac120 RCX: 00007f4b9227de69
RDX: 0000000000000048 RSI: 00000000200054c0 RDI: 0000000000000005
RBP: 00007f4b922ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f4b923ac120 R15: 00007ffdcb39eb48
 </TASK>
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 48 8b             	fisttps -0x75(%rax)
   3:	1b b8 fa 00 00 00    	sbb    0xfa(%rax),%edi
   9:	48 01 c3             	add    %rax,%rbx
   c:	48 89 d8             	mov    %rbx,%rax
   f:	48 c1 e8 03          	shr    $0x3,%rax
  13:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
  18:	84 c0                	test   %al,%al
  1a:	0f 85 da 4d 00 00    	jne    0x4dfa
  20:	0f b6 1b             	movzbl (%rbx),%ebx
* 23:	31 ff                	xor    %edi,%edi <-- trapping instruction
  25:	89 de                	mov    %ebx,%esi
  27:	e8 a3 0a eb ff       	call   0xffeb0acf
  2c:	85 db                	test   %ebx,%ebx
  2e:	74 5a                	je     0x8a
  30:	48                   	rex.W
  31:	ba 00 00 00 00       	mov    $0x0,%edx
  36:	00 fc                	add    %bh,%ah
  38:	ff                   	.byte 0xff


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

