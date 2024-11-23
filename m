Return-Path: <netdev+bounces-146919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DE9D6C0C
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03C916175C
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CD17E8E2;
	Sat, 23 Nov 2024 23:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614012CD88
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403062; cv=none; b=dqnmCG/3/eqUXlMwFmWPDUydbgRZ58wnAbCAHyGZDFjkAoNIyZgz91E/sVtNfhB/P6GiFfyKpb0YUUrwZL4khm7TCOxDoDQeYtF0EcRsdeWlIzYwVCJzuIV+8HMZTipOv8FjhWTp8c2WbH6BbNPmq3wedWIR8jFC/tHH27jF7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403062; c=relaxed/simple;
	bh=OQKZmpprJjQHka1KGQ4qJxF4PFh5GjqDvlCcIhHf3vA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iN+w+Nw722H6CqjJIV+yYEo/ab3Y6jcmx2vAWmFMq7Mjuhft945+oxmrHQ3krSp17ACX2RpAK8twdNJx/q75hCik8BOcIPrOZJstshs6BXuQVsMAx/aD7O4EfkWcHLNDMghledKvzVnCpP9IAQUFAlSx9GcfezABIbNiB97kPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so34034755ab.3
        for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 15:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732403060; x=1733007860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lIP8oYWN3Z6Cs7pp04JkPOHTRMRU6LhyBV5nJ0zgC0=;
        b=QknvTUvXVL545aD3balT4E6Dl4gUmsc1apkpaf80UqoX9LMRelGWoveSEtXq9aHwlD
         A2j17uVkVaUDOv1mQD/Mt49aOdSGFgUZwyxVT32vhUi6bKOjAIlxfHgewDorLnuluZQr
         fLDHTd6fIifl1jeJ5qz+iOzSkW3yGMSk6hSmdI1L3gDjFw57RtE5ozkWOS1ZhFZmCmHa
         yPbORhuV3z+sf4KcmrxsFYPD4TTspm9cKOBbfpFzpkTvoZ8Onzwuvd14i2ajPZobUyHE
         /5TGGg3RHSZcd/buu4wShADdwAoKnyrKZ2baPVzzWEAgfIrUrPZok7nwaFLusHlAQSJ3
         zicg==
X-Forwarded-Encrypted: i=1; AJvYcCUyfc1woJMqWTcaZaG//LNHTbTKIQdBZQUsK9K69KqIMGXPtxoawOedfGbGidX8RqO8QDFXMoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvTgxQ5Si4AhILi/AR4SpxBYhHLMcOLFK4u3L0EZLew3Olpj7
	XAYUtvZE7N/4kMdXetCuz6PQYfM7gSbfDVWVDulyAor+go9fmnWbpiMmYMGRg0BlMlx4oIE8t3z
	3yOVsn93azOr4P0Mc8cHTqiD4rLKMmum0elKb8iaAZjF8zAgJUjpPDRc=
X-Google-Smtp-Source: AGHT+IGxkh3DEa0BhCIDsDviPWHgC1r0aWEbqIrtW/I0wirAFEWL5dwOSKSvh5z4GPGBdb7dGC8pXBM8WXjlgMLRmW68xepJ6riq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4418:10b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3a7a5530ef7mr33273105ab.18.1732403060102; Sat, 23 Nov 2024
 15:04:20 -0800 (PST)
Date: Sat, 23 Nov 2024 15:04:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67425f74.050a0220.1cc393.0020.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in bnep_session
From: syzbot <syzbot+6df45dd3d03e1a9aca96@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=135bbb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=6df45dd3d03e1a9aca96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1539da626e54/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d44dbcc68df2/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76fdad1309ae/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6df45dd3d03e1a9aca96@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 8179 Comm: kbnepd bnep0 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del+0x49/0x110 lib/klist.c:230
Code: f5 4d 89 f5 49 c1 ed 03 43 80 7c 25 00 00 74 08 4c 89 f7 e8 f9 77 3d f6 49 8b 1e 48 83 e3 fe 48 8d 7b 58 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 db 77 3d f6 4c 8b 7b 58 48 89 df e8 2f 99
RSP: 0000:ffffc9000b91f828 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000000 RCX: ffff88807e749e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000058
RBP: ffffc9000b91f950 R08: ffffffff823dd8ba R09: 1ffff11005dda786
R10: dffffc0000000000 R11: ffffed1005dda787 R12: dffffc0000000000
R13: 1ffff1100b406f8c R14: ffff88805a037c60 R15: ffff88805dc14b88
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e57cfc57c CR3: 000000005ded8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 device_del+0x2c9/0x9b0 drivers/base/core.c:3838
 unregister_netdevice_many_notify+0x1859/0x1da0 net/core/dev.c:11556
 unregister_netdevice_many net/core/dev.c:11584 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11456
 unregister_netdevice include/linux/netdevice.h:3192 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11602
 bnep_session+0x2e3c/0x3030 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del+0x49/0x110 lib/klist.c:230
Code: f5 4d 89 f5 49 c1 ed 03 43 80 7c 25 00 00 74 08 4c 89 f7 e8 f9 77 3d f6 49 8b 1e 48 83 e3 fe 48 8d 7b 58 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 db 77 3d f6 4c 8b 7b 58 48 89 df e8 2f 99
RSP: 0000:ffffc9000b91f828 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000000 RCX: ffff88807e749e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000058
RBP: ffffc9000b91f950 R08: ffffffff823dd8ba R09: 1ffff11005dda786
R10: dffffc0000000000 R11: ffffed1005dda787 R12: dffffc0000000000
R13: 1ffff1100b406f8c R14: ffff88805a037c60 R15: ffff88805dc14b88
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e57cfc57c CR3: 0000000033700000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	4d 89 f5             	mov    %r14,%r13
   4:	49 c1 ed 03          	shr    $0x3,%r13
   8:	43 80 7c 25 00 00    	cmpb   $0x0,0x0(%r13,%r12,1)
   e:	74 08                	je     0x18
  10:	4c 89 f7             	mov    %r14,%rdi
  13:	e8 f9 77 3d f6       	call   0xf63d7811
  18:	49 8b 1e             	mov    (%r14),%rbx
  1b:	48 83 e3 fe          	and    $0xfffffffffffffffe,%rbx
  1f:	48 8d 7b 58          	lea    0x58(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 db 77 3d f6       	call   0xf63d7811
  36:	4c 8b 7b 58          	mov    0x58(%rbx),%r15
  3a:	48 89 df             	mov    %rbx,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	2f                   	(bad)
  3f:	99                   	cltd


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

