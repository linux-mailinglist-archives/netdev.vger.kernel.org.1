Return-Path: <netdev+bounces-106915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E5918141
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A770A1F236E7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53D186E4E;
	Wed, 26 Jun 2024 12:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312B187562
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405809; cv=none; b=mkJ0cG+4CVMguSKQ3MLj3HzR4p1BXG+BinGpoSYYgTJ6g3FpW0OkW4+ccJuTAuUDn9ZZOYHwEL0x23I/qy3cfk50hnJU1RWMif3O01oHDlHBPonGKyelSuTG3AJ5clwOEC0gdffpi/DgWDDhzJ2R1u4y0Uhqmk8CH7Myi8/GCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405809; c=relaxed/simple;
	bh=veFPeQvB+eT9/WWZWdtiP6bzu72/4WuXmI7tWj395mQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hbIKBoAaBKFfsBkFs8nd4Cx0KSBYQcwXnN7/mIUZq2+bKwykGvC/OZfmmDY82id7ys+u1e1wE0Rcm5Qar4bDKMJjNwPZAvbMteJfcFFLazx+usnDzNdbHxEKhwKlucpVqE1bR3qz8N3RvWaiMKAUPCJpaPRabnaeGKY+gpvocjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so593047939f.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719405807; x=1720010607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuLog7s7kYM0yUYIoopNQl3eHfuK5BKMtfcXlBKi4R0=;
        b=Iq3/Je6unXgoQ6uCQ4clCH83XTzWAl/Rr2+DwLtcsBnkFU6/LegCaEpEehmwclsjZm
         mlZ0y0PrQO/KOgyBYeYkQB3P0H3aPd97XfJNMtdJVqOxu+HLQwNecFAXq1+dwfo3R0h8
         tNfINSpWsPOZQqeww9dPS8t1dnbpUu6lpqae2eSZdxT9u02Xc0v2HgCyt+6dFfiVTmVh
         /FbSI4pBP51fnoNUhrHrtNUqdOTiYGBjW6SEiCI2X0w1DPAIBezQtfaxQX0arixBV+8v
         ahCAMal1y5ezzzLTkqIMqU8dkEYv1X1VgBKAZn0CH6PaBvf8z+0LQfekjq/61XOxNND9
         HtWw==
X-Forwarded-Encrypted: i=1; AJvYcCVrQyUOo+cL3eYg2WV02bc3Mv+E0LDvvLduYFi5T9YiyCkpwInQdrwt2vliseX7jPnVLD4titPzdVgpEy2pBaBIfdY5zBku
X-Gm-Message-State: AOJu0Yw8NVU/qeZ012/c37r4hwCw27bVrbeEJsTeLHnZmeRgzXNbJC4o
	Xa0zeQheKC1On2GPdlIkX7lCLwkAH4TJB6Hh6BslRTIHfNF8aZRey00QajvMhcQMz5nddNsrTH8
	Lpcwbr/i5S50116RRRcmgmzqClRAbPo9a+T/C4UaGPRgJRsWBPe/CXug=
X-Google-Smtp-Source: AGHT+IH21V2sGVXA83FIGq+ugSevsS85NYX5bUstUZIoUvESTI6z/BiMjQVr3ciJ73ERdRyOnH5BoQld7SF8vywGT6R3tu3x38Zj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4093:b0:4b9:e249:e917 with SMTP id
 8926c6da1cb9f-4b9efdb97f1mr353936173.6.1719405807565; Wed, 26 Jun 2024
 05:43:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006293f0061bca5cea@google.com>
Subject: [syzbot] [net?] general protection fault in coalesce_fill_reply
From: syzbot <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50b70845fc5c Merge branch 'add-ethernet-driver-for-tehuti-..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1780b3b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599901a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429e301980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c4a7dba390c/disk-50b70845.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62ea7d7c8bc6/vmlinux-50b70845.xz
kernel image: https://storage.googleapis.com/syzbot-assets/573c2ae03545/bzImage-50b70845.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000193: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000c98-0x0000000000000c9f]
CPU: 1 PID: 5093 Comm: syz-executor403 Not tainted 6.10.0-rc4-syzkaller-00936-g50b70845fc5c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
FS:  000055557bf45380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200f9018 CR3: 0000000066db0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethnl_default_dump_one net/ethtool/netlink.c:467 [inline]
 ethnl_default_dumpit+0x5ac/0xb30 net/ethtool/netlink.c:494
 genl_dumpit+0x107/0x1a0 net/netlink/genetlink.c:1027
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f99a46ff219
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff97ad8a78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff97ad8c48 RCX: 00007f99a46ff219
RDX: 0000000000000000 RSI: 0000000020000e80 RDI: 0000000000000003
RBP: 00007f99a4771610 R08: 0000000000000000 R09: 00007fff97ad8c48
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff97ad8c38 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:coalesce_fill_reply+0xcc/0x1b70 net/ethtool/coalesce.c:214
Code: e8 19 2c f9 f7 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 e3 f1 5e f8 bb 98 0c 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 c5 f1 5e f8 48 8b 03 48 89 44 24
RSP: 0018:ffffc90003526ee0 EFLAGS: 00010206
RAX: 0000000000000193 RBX: 0000000000000c98 RCX: ffff88802661da00
RDX: 0000000000000000 RSI: ffff88801b72e740 RDI: ffff88802dac6780
RBP: ffffc90003527118 R08: ffffffff899bb137 R09: 1ffff11003e8b805
R10: dffffc0000000000 R11: ffffffff899cf860 R12: ffffffff899cf860
R13: dffffc0000000000 R14: ffff88801b72e740 R15: ffff88802dac6780
FS:  000055557bf45380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a18cbf60a8 CR3: 0000000066db0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 19 2c f9 f7       	call   0xf7f92c1e
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 e3 f1 5e f8       	call   0xf85ef1fe
  1b:	bb 98 0c 00 00       	mov    $0xc98,%ebx
  20:	49 03 1e             	add    (%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 c5 f1 5e f8       	call   0xf85ef1fe
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


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

