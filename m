Return-Path: <netdev+bounces-130131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DD9887C6
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CB71F2449D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713761C0DFA;
	Fri, 27 Sep 2024 14:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A41C0DEC
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449166; cv=none; b=kJTK6vDPiQPs4EZ+Fe1cy8Ue+uS9EDugEnOI5BVJAkzTFhdlbp0nv/qnHpKL2fLGvOxCTARTanwxTllAb3/0pxTvKdgBfyPn5OFpe7+mJ/o92FoNpsVPhxifpWsDDPjkytrtMKbm8FZZZJhOdr/oy2Hj0+ibohe4qFChG7zQqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449166; c=relaxed/simple;
	bh=0FlycYg4IdJXKbVwGcsBSui8gIOJIm4+AqXhGlS1clE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uHZ5tAEJVnVbxqyC6rkU0k2wYU7vdUDeU21t5l/GZS6r0Th+lgqHPHEEeSE7ti2K1ZiJeFTKBh/tF8arte1jqbr0irIjN4pFe7zfBRrXLNL+6LoVR7YjW1+aCMLMZTinviN+ZE4wwxXUTLtGqmBBnFSNiLWwwJ2DyJ6TvSZbWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso29341435ab.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449164; x=1728053964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glOOEePefGVdhLLktKvPlDXpMV6DRu5bQVGp5XI+cKQ=;
        b=RkUkd5BaeRpVQB8oQtiGVVp6TC5SslBEvdJrykzcQq8kxE9lcfp9jcjoxb+vmPCm+V
         8MO9OU+oduMIFMdr7zYozwaBiTvbBaXqXLrqnBQXxwnln/POJgG9/8F2drptamsStD8v
         Ibr4qUZ2WyEtS09zcTrCww/RcmUS983VHEiAO00SD5MuApuP2S1bDIYUnUqe3jsap/yP
         1aquxBsSeLEbpimIO0EvSSmaxeD39CVLe2LNVZl1Q3OXsPxnYgSUxQYlLKS7I+mruJZ9
         nGKMrXLjX+Xa2CmqPRF30NFYt3sCIrq1KAO+UDBEafilta56gTYkNKy1+6LS4PV4+TYd
         ZgAg==
X-Forwarded-Encrypted: i=1; AJvYcCVkzsCr2sF3pjYuPXNsBNHkjzi9ryrHYDcgfu7KKLHHUxMPHR9crR4JsT9/0h4fCf7PaPK4VyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQf/lUq0XP5y6bkEssA2PizzPma68+LfeLnvZECMxIo/OtH84
	/DsbniIH/Q752+VQpZn8gS48KPaAOLRcp7/svrGOUdhRZMcx9xXRRro9X8rJo4KZYt/4utL+kk8
	DgxdbywNpjPReEt4UrixB4Ya9QB91K1idu155azODokKDPjBm1FpOBP0=
X-Google-Smtp-Source: AGHT+IEb2J8L25Tnzd6/7dhGUbldLaSb8Z/8Uq3A1krBNR2ux+IvIkUG69kSLBDCT3f3U+9dW+M5yB65qSSCZI/Hga6K1epVVTU6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1945:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a344638a4amr29377575ab.8.1727449164147; Fri, 27 Sep 2024
 07:59:24 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c84c.050a0220.38ace9.0027.GAE@google.com>
Subject: [syzbot] [sctp?] general protection fault in sctp_inet_listen
From: syzbot <syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f8549f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f4e0f821e3a3b7cee51d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/629d679a6d66/disk-196145c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aec0dd4a04f3/vmlinux-196145c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68e515733997/bzImage-196145c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 10078 Comm: syz.4.940 Not tainted 6.11.0-rc7-syzkaller-00097-g196145c606d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
Code: 8d 98 00 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 6e 4e 05 f7 48 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 8e 01 00 00 c6 03 01 31 db e9 d6 f9 ff
RSP: 0018:ffffc90002eafd20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88802e973c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002eafe78 R08: ffffffff8af5839c R09: 1ffffffff283c920
R10: dffffc0000000000 R11: fffffbfff283c921 R12: 1ffff1100fc7e242
R13: dffffc0000000000 R14: ffff88807e3f1212 R15: 1ffff1100fc7e2ff
FS:  0000000000000000(0000) GS:ffff8880b8900000(0063) knlGS:00000000f5735b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007fadae30cff8 CR3: 0000000050d9a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __sys_listen_socket net/socket.c:1883 [inline]
 __sys_listen+0x1b7/0x230 net/socket.c:1894
 __do_sys_listen net/socket.c:1902 [inline]
 __se_sys_listen net/socket.c:1900 [inline]
 __ia32_sys_listen+0x5a/0x70 net/socket.c:1900
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fd6579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f573556c EFLAGS: 00000206 ORIG_RAX: 000000000000016b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
Code: 8d 98 00 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 6e 4e 05 f7 48 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 8e 01 00 00 c6 03 01 31 db e9 d6 f9 ff
RSP: 0018:ffffc90002eafd20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88802e973c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002eafe78 R08: ffffffff8af5839c R09: 1ffffffff283c920
R10: dffffc0000000000 R11: fffffbfff283c921 R12: 1ffff1100fc7e242
R13: dffffc0000000000 R14: ffff88807e3f1212 R15: 1ffff1100fc7e2ff
FS:  0000000000000000(0000) GS:ffff8880b8900000(0063) knlGS:00000000f5735b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055f65cf85950 CR3: 0000000050d9a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 98 00 06 00 00    	lea    0x600(%rax),%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 6e 4e 05 f7       	call   0xf7054e8a
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 02          	add    $0x2,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 8e 01 00 00    	jne    0x1c5
  37:	c6 03 01             	movb   $0x1,(%rbx)
  3a:	31 db                	xor    %ebx,%ebx
  3c:	e9                   	.byte 0xe9
  3d:	d6                   	(bad)
  3e:	f9                   	stc
  3f:	ff                   	.byte 0xff


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

