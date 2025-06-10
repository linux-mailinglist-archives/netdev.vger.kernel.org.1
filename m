Return-Path: <netdev+bounces-195971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DDAD2F64
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BEC17047B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBD280034;
	Tue, 10 Jun 2025 08:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166127AC4C
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542500; cv=none; b=HrccANOz9O9RSsLJuU8luQVxcNPHeqhC6rWCsBlGNQCofL6BhkfIrUE4IP3Xa30ivX7Y4n0AED5z0a9EbgoWXEAlW/YGx/5mebzvm3FbeQxWJ8Y2UcjZ8/xk7+Lk6RLf+z3ViERIxKVq8qq4Oajvus23ZPTxscc0AXsuXH/x0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542500; c=relaxed/simple;
	bh=77q/AQ+W3cm2lZCUu0B9tW0u4Q50RVOOnGn1rg1VWYI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DKWu5JCYcDf9zWyJiRPBSBziEYne1leMgjmlt4+tIiz5rsIaOBJOamHlsg1K1tKkRId9P/rPxuihnDIQn2jYvlE3pLaRqyQunyXt6ieJv+JivVOGMs/FVbAuwXu1HbTigfXZXpJ/LeR3rLFNk4MagNrTi80o6OaOUAuMmpjJIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddb4a92e80so68932265ab.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 01:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542497; x=1750147297;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaddzINNAk+UVTk393W6HaZMCswTV8O7lMJ2pdMZqho=;
        b=MDecX/nmelz3N4dxdXhjsy62uLWcWBSYTDroZ1F2TY0PXjVP+3m8uItKNXagPhW+Ry
         Fl+N9Ccv/Lx0E6E57vZVf7ZnuWo8/4ypsH0X35+gdo7D3KaIvrU2F4frSBw5evTD9pmr
         f/PYgBo+pGJpk4lAfhrOfzoIOb0pAK3Ks3UW6Mptag7PNgi7hDoS4Nma+CahVKcxxFDT
         ZgINDlxcW7AzoVhzDVxlaidd9o+cSUMQVZVOdSGL/cgR/Dm0pEZJVlekgZCOfugm9Au6
         ZTiFm2avWGSv+5i53BJjqpQHaKTZtV5W8JdKSZo+QGtO3q6jRdhLaHi+N6d+B42Q4RQB
         17Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVUyFLtulow6wVeGvkQ2IIrwY/0XNrQZRyJvkx5tMhE5oW64ATh4r4N2LmiBmS7Ngf087v6wkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz+SomqMswvoRjjMkaWbUZYZLJPeysiNoUdlRgizkR5tm2lu/
	Gif+uzWfwD/YhDBkbfFciQ6hB9djvPMHlqMFD4D1NxLrqBiBHZLzCSCvuzaoREssIzMtA1iAR4R
	zHGVBccWRNra6fJExD8mBSmTcgIaWQ3datenOSvxsV4OX+pyTIyMd5ZiTaBo=
X-Google-Smtp-Source: AGHT+IH0l/b3zgJCyBy0/2/WNEnDRCKF8wOa17mZfSCyH0M+RiEFzmd1MUik/bT27JSPh2KdIDPxlhbdZYyZK0oQj8ED7+eTrxNh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:3dd:babf:9b00 with SMTP id
 e9e14a558f8ab-3ddedd4cf76mr15861555ab.1.1749542497339; Tue, 10 Jun 2025
 01:01:37 -0700 (PDT)
Date: Tue, 10 Jun 2025 01:01:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6847e661.a70a0220.27c366.005c.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in add_grec (2)
From: syzbot <syzbot+2d29aae505225ce697ee@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    64980441d269 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169cf40c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26abb92f9ef9d1d0
dashboard link: https://syzkaller.appspot.com/bug?extid=2d29aae505225ce697ee
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f87fde80a0d/disk-64980441.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f721fc8ffe8/vmlinux-64980441.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50b2b318eca4/bzImage-64980441.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d29aae505225ce697ee@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc001fffe000: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x00000000ffff0000-0x00000000ffff0007]
CPU: 1 UID: 0 PID: 5815 Comm: kworker/1:3 Not tainted 6.15.0-syzkaller-12058-g64980441d269 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: mld mld_ifc_work
RIP: 0010:add_grec+0x764/0x1670 net/ipv6/mcast.c:1967
Code: 40 01 41 89 c7 31 ff 89 c6 e8 08 b3 a2 f7 45 85 ff 0f 84 b0 00 00 00 e8 ba ae a2 f7 eb 05 e8 b3 ae a2 f7 49 89 ee 49 c1 ee 03 <43> 80 3c 26 00 74 08 48 89 ef e8 9d f5 03 f8 48 8b 45 00 48 89 84
RSP: 0018:ffffc9000425f8f8 EFLAGS: 00010206
RAX: ffffffff8a1d9c16 RBX: 0000000000000000 RCX: ffff888027a33c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffff0000 R08: ffff888027a33c00 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000005 R14: 000000001fffe000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d89000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84328dc0d1 CR3: 000000006bf3c000 CR4: 00000000003526f0
DR0: 0000000000000007 DR1: 000000000000000b DR2: 0000000000000002
DR3: 0000000000000009 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mld_send_cr net/ipv6/mcast.c:2155 [inline]
 mld_ifc_work+0x671/0xde0 net/ipv6/mcast.c:2702
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:add_grec+0x764/0x1670 net/ipv6/mcast.c:1967
Code: 40 01 41 89 c7 31 ff 89 c6 e8 08 b3 a2 f7 45 85 ff 0f 84 b0 00 00 00 e8 ba ae a2 f7 eb 05 e8 b3 ae a2 f7 49 89 ee 49 c1 ee 03 <43> 80 3c 26 00 74 08 48 89 ef e8 9d f5 03 f8 48 8b 45 00 48 89 84
RSP: 0018:ffffc9000425f8f8 EFLAGS: 00010206
RAX: ffffffff8a1d9c16 RBX: 0000000000000000 RCX: ffff888027a33c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffff0000 R08: ffff888027a33c00 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000005 R14: 000000001fffe000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d89000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84328dc0d1 CR3: 00000000736c2000 CR4: 00000000003526f0
DR0: 0000000000000007 DR1: 000000000000000b DR2: 0000000000000002
DR3: 0000000000000009 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	41 89 c7             	mov    %eax,%r15d
   3:	31 ff                	xor    %edi,%edi
   5:	89 c6                	mov    %eax,%esi
   7:	e8 08 b3 a2 f7       	call   0xf7a2b314
   c:	45 85 ff             	test   %r15d,%r15d
   f:	0f 84 b0 00 00 00    	je     0xc5
  15:	e8 ba ae a2 f7       	call   0xf7a2aed4
  1a:	eb 05                	jmp    0x21
  1c:	e8 b3 ae a2 f7       	call   0xf7a2aed4
  21:	49 89 ee             	mov    %rbp,%r14
  24:	49 c1 ee 03          	shr    $0x3,%r14
* 28:	43 80 3c 26 00       	cmpb   $0x0,(%r14,%r12,1) <-- trapping instruction
  2d:	74 08                	je     0x37
  2f:	48 89 ef             	mov    %rbp,%rdi
  32:	e8 9d f5 03 f8       	call   0xf803f5d4
  37:	48 8b 45 00          	mov    0x0(%rbp),%rax
  3b:	48                   	rex.W
  3c:	89                   	.byte 0x89
  3d:	84                   	.byte 0x84


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

