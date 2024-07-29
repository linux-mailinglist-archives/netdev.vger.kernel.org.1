Return-Path: <netdev+bounces-113746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7993FB4B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB5D1F2219A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B15186E59;
	Mon, 29 Jul 2024 16:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607F15F301
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270512; cv=none; b=m/kJ2NCxHQTkBpxA550xDbwzDzN2G0TekhyNPMdESRhQ5X1MAf3Z09rzGMVQAWT4bf879T+0/2rREoQGjjFNYcqXMf00RxSocWYfjYb5E3u99rooZ7vyouja5mzBT8oH4dcucr9eLSIbKWRs8HUik9o1XtUfak2IKpQFTxqh0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270512; c=relaxed/simple;
	bh=dTQNpHRVJ2ak1aFJg/YkRVnRIXwzYF4no6e2/nG1f3c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vd7TP+s1Mefpcc+IRdi1cV9KJpo9hZch6urKOMzoWpCiqLrebYmCxEJA3girELxAwqiXIEOux/hlbHDpXrrjuS1JWiYXxKK6Lho4Vx6Y9hSaaGjpDVI18+k5ZYZo4FbQTo6VwbZSVbbiLtyBposdkNJdHuVVdTN28pqdbl2wRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so516947539f.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 09:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722270509; x=1722875309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYwzfCLYVAPwKlCSey3OuTXhjgiWSRtY/wIJsDeAetE=;
        b=EMLTBi20v7+p5q0evkS58/jAkuBOkR4gN7jviiPwofv9w49o4CLaQbYDDv690euKi4
         gldGQJpx+LvT7BLWEBXbFUa7DPHEYCl+ZdZGOVNTW4mKwtVEYH7abZ4ozrbgltOlkfp+
         daY9kRyWVyDMcfqKjEFAexJ42GS7ZdC2KYsQWspaDrfBTg6w4CBL7o8QCaKh4GbzUkcL
         wb9wiu2qgjD87j/0HBPbpApo5sncNBPTF5ztISYG7tpJVzqUOd+tHmyus58EoviKAAP2
         N3f3d3Q8oY+tBESC6Q0zdMemMLxihkhU4MC0f0yJfN8R6bheXKbT/N4rX7/C83e1D5MQ
         w7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUjz1HswSS5f+UvPdjateXqk1lQpdf3jX48IpizrVLagpIfI8WjnoRNdOa7SOnqSEDSeyz2iNH3QhUw4dVdAE+UI+2SPsh0
X-Gm-Message-State: AOJu0YwHoiJXHnxIvgcb6b0ojy4FL88yCrPpAYXAqhZHo8WPSsomqGSp
	iWabhA6lV491+7q8qlA2+OLKPl+0/XxnpKBwNC5y+n6b8snW9LtG0cGFzPoucEjImhBLRYpL7Ug
	qlo7zZ0JOn3pXMJmqfHzjh9OsSXqX/gk317ybfXXtb01EBimMGkU7b4o=
X-Google-Smtp-Source: AGHT+IGkz7HJkvORJwdEHiYIsc4m6V544J3mwBg5oVA+RWwjmExtfaiu0edZbZ6+uLqajzcTqCbemq2u4ich5JJb50PaFhWLw6uH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6415:b0:80f:81f5:b484 with SMTP id
 ca18e2360f4ac-81f95bca5cdmr45717739f.2.1722270509524; Mon, 29 Jul 2024
 09:28:29 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed7445061e65591f@google.com>
Subject: [syzbot] [net?] general protection fault in reuseport_add_sock (3)
From: syzbot <syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lucien.xin@gmail.com, netdev@vger.kernel.org, 
	nhorman@tuxdriver.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    301927d2d2eb Merge tag 'for-net-2024-07-26' of git://git.k..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17332fad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
dashboard link: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0a623980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1538ac55980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb9ce2729d35/disk-301927d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/644eaaef61a5/vmlinux-301927d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f92322485c3/bzImage-301927d2.xz

The issue was bisected to:

commit 6ba84574026792ce33a40c7da721dea36d0f3973
Author: Xin Long <lucien.xin@gmail.com>
Date:   Mon Nov 12 10:27:17 2018 +0000

    sctp: process sk_reuseport in sctp_get_port_local

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ad25bd980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ad25bd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ad25bd980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Fixes: 6ba845740267 ("sctp: process sk_reuseport in sctp_get_port_local")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 10230 Comm: syz-executor119 Not tainted 6.10.0-syzkaller-12585-g301927d2d2eb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __sctp_hash_endpoint net/sctp/input.c:762 [inline]
 sctp_hash_endpoint+0x52a/0x600 net/sctp/input.c:790
 sctp_listen_start net/sctp/socket.c:8570 [inline]
 sctp_inet_listen+0x767/0xa20 net/sctp/socket.c:8625
 __sys_listen_socket net/socket.c:1883 [inline]
 __sys_listen+0x1b7/0x230 net/socket.c:1894
 __do_sys_listen net/socket.c:1902 [inline]
 __se_sys_listen net/socket.c:1900 [inline]
 __x64_sys_listen+0x5a/0x70 net/socket.c:1900
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24e46039b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f24e45b9228 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007f24e468e428 RCX: 00007f24e46039b9
RDX: 00007f24e46039b9 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f24e468e420 R08: 00007f24e45b96c0 R09: 00007f24e45b96c0
R10: 00007f24e45b96c0 R11: 0000000000000246 R12: 00007f24e468e42c
R13: 00007f24e465a5dc R14: 0020000000000001 R15: 00007ffcced5f7d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	b7 5d                	mov    $0x5d,%bh
   4:	00 bf 01 00 00 00    	add    %bh,0x1(%rdi)
   a:	89 de                	mov    %ebx,%esi
   c:	e8 1b a4 ff f7       	call   0xf7ffa42c
  11:	83 fb 01             	cmp    $0x1,%ebx
  14:	0f 85 a3 01 00 00    	jne    0x1bd
  1a:	e8 6d a0 ff f7       	call   0xf7ffa08c
  1f:	49 8d 7e 12          	lea    0x12(%r14),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 4b 02 00 00    	jne    0x282
  37:	41 0f b7 5e 12       	movzwl 0x12(%r14),%ebx
  3c:	49 8d 7e 14          	lea    0x14(%r14),%rdi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

