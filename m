Return-Path: <netdev+bounces-162593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30FAA274CC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C3161385
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229A2139CF;
	Tue,  4 Feb 2025 14:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC6211A24
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680509; cv=none; b=Dc5amgpE5kIC+moT9iJe5BjwMsH9T6BWrGhdU313xkEaZsu9WuYUtcVO2BtRPplk2BwJ2hqCGBLkLgU2fSNQ/qDBr5dZFLBu5xtB1bnm4/jPfDuNt6V9BOEbL+UB5smvCyRpwxSMV41GILEJmuKDD0LQRZZ7rIYNJIIehiGPRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680509; c=relaxed/simple;
	bh=/HtKUDs6iG0aMvQPHsOvoq2oFUkU1E7/5Sa0Y64kFh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FojQxAqtq6Pqg3SniXvonJpwp9hMYydcTn4nrh8WnLGHB/Tlc8f+8V0JBUfU2VgegcTf/UzWIA7LxXOMdWULuolAGMUYEUGW3Gxybsg6rILqMlI9iJMlZvoiGfgFmHcb9M+oC1U05bJve80XCz5z5Ml7Qx69GA02cNakP2Z9TRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844e619a122so381368639f.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680506; x=1739285306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J+QfVTHo3s13dpxy0P+U4UQznX8EvvHJpADa02S488=;
        b=uO80G1RoUamKmloY6L5PcHxSh1b2F4pnSCZCV4O4MQDmi2G82ZD15CgoOpad2NuxiE
         bzzePUvgGpsJ6CTpBJFZLu78wJxOxPMCyNR48oTO2uksxTGxnH5WuGMDTaNDvt8sEZ74
         VCmH0/E05dGFPktYXCvDBkO31JRtwPmh6fYHw9dwToapzW08LrW5QNtUgQyTWtL2CieG
         r1IW4N5cQSyYgVE5qB01e/C2A6L47ifuLxQ801x3E/Xo2oM/I0QC1caKv0T/h8IN+UkQ
         s4DYmb6zWBmiFj7ZNh8hNOpr6+Vd6rvU0yjPlMEZI6kOCvYx2yLefbtlpi1D8nwP7uO8
         CliA==
X-Forwarded-Encrypted: i=1; AJvYcCW3cxjQaKHuBI++z8xHh4C367n4Ap8bTkKItuHJQb27QWWU/LJF4+7qMQ+MTt73vK014LZTbTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0IyKDJ9qCUALGzR+8EwF/Fh9bGzdwyhmwNx9qGacxda1MJStX
	3VBIWtoibbVzbVnlQJTvsSJaRFATn90TgoIQst6hf0m7RAtYOL9yxh5Nrewpd7mgE3wSlKHKqve
	5pwdfppmyEbutk8/8dvE/38uWuhYGBqC3VbEfJt7gbM8dNkjFF0O31Wo=
X-Google-Smtp-Source: AGHT+IG7UBAGb6M7fqtMjN5gKkznC7Pbjp/hsRC67bjnpJIjv7aiYIaosw/Up9YHNAVwPYDJPmIXTlbD7SN1e5dHixbc7kbHy3Vx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:fc3:b0:3cf:bbb4:f1e with SMTP id
 e9e14a558f8ab-3d000913316mr153323925ab.7.1738680506432; Tue, 04 Feb 2025
 06:48:26 -0800 (PST)
Date: Tue, 04 Feb 2025 06:48:26 -0800
In-Reply-To: <000000000000cbc8670618a25b24@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a228ba.050a0220.d7c5a.00b9.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=113d5d18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccdfef06f59f/disk-40b8e93e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b339eaf8dcfd/vmlinux-40b8e93e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae1a0f1c3c80/bzImage-40b8e93e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5833 Comm: syz-executor346 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:skb_queue_empty_lockless include/linux/skbuff.h:1887 [inline]
RIP: 0010:skb_queue_purge_reason+0xaa/0x500 net/core/skbuff.c:3936
Code: 89 44 24 78 42 c6 44 30 13 f3 e8 81 76 05 f8 48 8d bc 24 b0 00 00 00 ba 48 00 00 00 31 f6 e8 0d f2 6b f8 4d 89 ef 49 c1 ef 03 <43> 80 3c 37 00 74 08 4c 89 ef e8 27 ef 6b f8 49 8b 45 00 4c 39 e8
RSP: 0018:ffffc90003d17880 EFLAGS: 00010202
RAX: ffffc90003d17930 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003d17978
RBP: ffffc90003d179f0 R08: ffffc90003d17977 R09: 0000000000000000
R10: ffffc90003d17930 R11: fffff520007a2f2f R12: dffffc0000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055867393d608 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_queue_purge include/linux/skbuff.h:3364 [inline]
 mrvl_close+0x8e/0x120 drivers/bluetooth/hci_mrvl.c:100
 hci_uart_tty_close+0x205/0x290 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1690
 tty_release+0xd06/0x12c0 drivers/tty/tty_io.c:1861
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2a/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f794f6cfc79
Code: Unable to access opcode bytes at 0x7f794f6cfc4f.
RSP: 002b:00007fff04322488 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f794f6cfc79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f794f74a270 R08: ffffffffffffffb8 R09: 00007fff043226a8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f794f74a270
R13: 0000000000000000 R14: 00007f794f74acc0 R15: 00007f794f6a1a60
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_queue_empty_lockless include/linux/skbuff.h:1887 [inline]
RIP: 0010:skb_queue_purge_reason+0xaa/0x500 net/core/skbuff.c:3936
Code: 89 44 24 78 42 c6 44 30 13 f3 e8 81 76 05 f8 48 8d bc 24 b0 00 00 00 ba 48 00 00 00 31 f6 e8 0d f2 6b f8 4d 89 ef 49 c1 ef 03 <43> 80 3c 37 00 74 08 4c 89 ef e8 27 ef 6b f8 49 8b 45 00 4c 39 e8
RSP: 0018:ffffc90003d17880 EFLAGS: 00010202
RAX: ffffc90003d17930 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003d17978
RBP: ffffc90003d179f0 R08: ffffc90003d17977 R09: 0000000000000000
R10: ffffc90003d17930 R11: fffff520007a2f2f R12: dffffc0000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055867393d608 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 44 24 78          	mov    %eax,0x78(%rsp)
   4:	42 c6 44 30 13 f3    	movb   $0xf3,0x13(%rax,%r14,1)
   a:	e8 81 76 05 f8       	call   0xf8057690
   f:	48 8d bc 24 b0 00 00 	lea    0xb0(%rsp),%rdi
  16:	00
  17:	ba 48 00 00 00       	mov    $0x48,%edx
  1c:	31 f6                	xor    %esi,%esi
  1e:	e8 0d f2 6b f8       	call   0xf86bf230
  23:	4d 89 ef             	mov    %r13,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	43 80 3c 37 00       	cmpb   $0x0,(%r15,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 27 ef 6b f8       	call   0xf86bef60
  39:	49 8b 45 00          	mov    0x0(%r13),%rax
  3d:	4c 39 e8             	cmp    %r13,%rax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

