Return-Path: <netdev+bounces-149084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6979E419B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEE428C9F1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1422229B30;
	Wed,  4 Dec 2024 17:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C146218ADF
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331810; cv=none; b=OLa9UaDUsJzIbYeHWbvn40KsJiSU2jKWV3P5e2biQuVtWcHLDf6QiuaxAY7hHXz37hKQ65Q99FID4J8UptIdnfNvbFkEh/nUBa6VDh4nSJFD9a3wgfkeYysELbcwImQhrChFLJZ9gz1JiN+6EXoimxb7UIp9Lrbf2hHFnvXuZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331810; c=relaxed/simple;
	bh=NBQIiV4p144RbimhQEF/GPip7J51pwG3nDufsHyPN/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QuI3tlEDw6LhdvyQlt/01FuRieYaU6XzGL1I+D1X0fsIL3MjyIcRn2bXiLH5V4rDe8GIU0lYX5swT5dxm/kGcQcEm0QoDu0SemKrtvRKg+UvfcVqiZb+fB4F+IdstjS7P5cPl0dVHn9wtl/hCtN9KLpVn30qYa8Mp+3Csnnlgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso96343039f.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331808; x=1733936608;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bER0hbP9nJUm8ccnWbqgJ29lpvoI9kCMKdaTSXtGFxA=;
        b=CuAEniPYHMA+Klh5rWD7Hgp5OL+4hiYgn3vxpcTvhZ1dnuaAaEwwiS4By8LGNz2+aA
         PblZ9kCskZK/KG7OWZfef6rBZXpnBcuZ+D4JQx7ofREZCZEG6W2gxe+y1UIjLQDQgus9
         x6U9cKKI+FWR1BjNhFJfKMESLqGNcYXu+NvoJuPzens6GS4QRZC8vQK1rcHvlOMVcTy0
         2k+h+zNin9KmhM0ptUymnmSLVmjWO03sTcHFzD7ZsCdV6m5zd60Ox/HOaHEV6ORVE7xG
         xOHI0umkjJ7+1CvITvA972ERTtCz2EoeYzjMLs+19HFvWUUpREu2b0ShUlaVM2l8SCXH
         yWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvgHBA9eLKZJRiTFMuo+5G2SlUKOnr+APwpWNNCAeP77fVNFrJ291A9ecS56pt7N3MFYzAGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCt4JqHGEXEeOWw1UY02M+X2jBkB5UxCXmSxbU+ZmMQ3TLjF3
	jX+o0NMqGIp1WGkUCUReUPx4o8kimOBoZ45fWH5wWBzh8i/p0tFuodtwbe+OI8Y6YxYr+8unBZx
	MlazGXLIB7DUMbElmVUFuW5WeP3vRkDWBlW1dqK9Cmtza2ejtD+YNx/4=
X-Google-Smtp-Source: AGHT+IH5cOD5AlXg5sgkPTJMBJAKYuAdFAI6biDl6aCiZ2fgyiuqWQfeouJqDuxWVZ/LJlMsATdWCsFnzIlD3lgtAedzW71tUN3G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3a7:e8df:3fcb with SMTP id
 e9e14a558f8ab-3a8075c50d9mr1175275ab.7.1733331807621; Wed, 04 Dec 2024
 09:03:27 -0800 (PST)
Date: Wed, 04 Dec 2024 09:03:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67508b5f.050a0220.17bd51.0070.GAE@google.com>
Subject: [syzbot] [tipc?] general protection fault in cleanup_bearer
From: syzbot <syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c245a7a79602 Add linux-next specific files for 20241203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109860f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af3fe1d01b9e7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=46aa5474f179dacd1a3b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152d8de8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8cc90a2ea120/disk-c245a7a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f6b1a1a0541/vmlinux-c245a7a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9fa3eac09ddc/bzImage-c245a7a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 5896 Comm: kworker/0:3 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events cleanup_bearer
RIP: 0010:read_pnet include/net/net_namespace.h:387 [inline]
RIP: 0010:sock_net include/net/sock.h:655 [inline]
RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 3c f7 99 f6 48 8b 1b 48 83 c3 30 e8 f0 e4 60 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 1a f7 99 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc9000410fb70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88802fe45a00
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000410f900
RBP: ffff88807e1f0908 R08: ffffc9000410f907 R09: 1ffff92000821f20
R10: dffffc0000000000 R11: fffff52000821f21 R12: ffff888031d19980
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88807e1f0918
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ca050b000 CR3: 0000000031c0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:read_pnet include/net/net_namespace.h:387 [inline]
RIP: 0010:sock_net include/net/sock.h:655 [inline]
RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 3c f7 99 f6 48 8b 1b 48 83 c3 30 e8 f0 e4 60 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 1a f7 99 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc9000410fb70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88802fe45a00
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000410f900
RBP: ffff88807e1f0908 R08: ffffc9000410f907 R09: 1ffff92000821f20
R10: dffffc0000000000 R11: fffff52000821f21 R12: ffff888031d19980
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88807e1f0918
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc220c9950 CR3: 000000007e778000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	18 48 89             	sbb    %cl,-0x77(%rax)
   3:	d8 48 c1             	fmuls  -0x3f(%rax)
   6:	e8 03 42 80 3c       	call   0x3c80420e
   b:	28 00                	sub    %al,(%rax)
   d:	74 08                	je     0x17
   f:	48 89 df             	mov    %rbx,%rdi
  12:	e8 3c f7 99 f6       	call   0xf699f753
  17:	48 8b 1b             	mov    (%rbx),%rbx
  1a:	48 83 c3 30          	add    $0x30,%rbx
  1e:	e8 f0 e4 60 00       	call   0x60e513
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 1a f7 99 f6       	call   0xf699f753
  39:	49 83 c7 e8          	add    $0xffffffffffffffe8,%r15
  3d:	48 8b 1b             	mov    (%rbx),%rbx


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

