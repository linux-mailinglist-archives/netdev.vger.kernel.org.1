Return-Path: <netdev+bounces-245963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7ECDC216
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 12:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E3F304DA37
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B9329E5C;
	Wed, 24 Dec 2025 11:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB82153D4
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766575584; cv=none; b=tusrCYwZb1/gUTUpgJUz7qBMckuZoXcDHx9NzigchZyEl0g8JDOGpMbDBsuKpKjJBcCXgQQNtgTv7bOLUtZoEn4HEWVnRWyCDQGUe1fjoj28S6U39aBhztdsmwowS0/CBLVrVFXtnpYjmG82+uBuEutYkQ+O/pMaPiAsaSTYf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766575584; c=relaxed/simple;
	bh=IaQBJ05qmtJ281ETg3IynFRG+qzyX9aBxbhbOREqdU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KMALOWuhcvDw6ruVJMfFUmaRMnpcnutstXM7pdx/rpANd7jyvs0ig2qlbaMqYYUGFqJcFjctVhHFElXgL/RVztys/knMRsoEJg54aYsEc4WcaiqoyRCkoZKg82CN5k9jpax81hqLZ5GFnQ7BMaVdoEgFKhaP038U1veoCV9vQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c7595cde21so12081751a34.2
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 03:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766575582; x=1767180382;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hbV8wPjusvHvwdrxWRBREEzkHQlFtKm2cv7V17viZA=;
        b=q7tqdlK8tWXjD33Kb3YdxzVsGc3/E0bAaCZJa4PVhF4URZdGQBj1gLFrLQkbYtZEVj
         KJr6dBf4/3AKwbUoaoBRf1YIXRMqswsgcghMXCgP110591eWJB36zDnqGCy68Txf28Ns
         jnykUyIkrMFDWgkjGa8QZgSu6wYt3wfY5j12XkppsUAsNMfKKr8GC4ZkD+h+e5Lvb4+b
         Ld0HY8v/nCt8GuNqeMJiN+HDNub9nPwGZjsew6qGFFLQVgWkGlrM++ttnOcTvM9+omfG
         AH46O6gcvA53wfOhMk5V4iRNH41EqntY+WiBxoihOD3CKc72BEUh/Mob2DNasOAWHbUY
         2B2A==
X-Forwarded-Encrypted: i=1; AJvYcCWLhmHKXSioM7WuCHA+tivwdbIdhlks0FIX06eaWMHaw3WQZlAOTwYRBQyw7M9TkRhYrajaToQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzXPLXufTZdlpOncuDKr6PljqCb8YFK6zlxcLRczoq/epcne8
	8AtqiKW0Ig8i/kW2tzDGNser/Oq3YX6ygDyrdKOOrkBnR/wkSL1RK2egg2Lkig5MOQ78WD+FQ5p
	g7+FyLtDW6snU8PtSNBbOWd5uzTMQBQFed4oiaUDezFl+ta2YdFyZVxGlaZs=
X-Google-Smtp-Source: AGHT+IGjed8fAn9pFaNGrDkIGQ04215WCTQtN4hdNAxJDdgDQ5seGJHOnaEv4Du4fgGtnvglEYNWX0SrFy5rh88lEdoWzxUhP/dn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4401:b0:659:9a49:8ffa with SMTP id
 006d021491bc7-65d0ea78479mr5930937eaf.39.1766575581901; Wed, 24 Dec 2025
 03:26:21 -0800 (PST)
Date: Wed, 24 Dec 2025 03:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694bcddd.050a0220.35954c.001c.GAE@google.com>
Subject: [syzbot] [tls?] general protection fault in handshake_complete
From: syzbot <syzbot+dfffb6c26ee592ff9e83@syzkaller.appspotmail.com>
To: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kernel-tls-handshake@lists.linux.dev, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1416c57c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8705ffbbff9235f
dashboard link: https://syzkaller.appspot.com/bug?extid=dfffb6c26ee592ff9e83
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17df4f42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1418a612580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/504ec57bbfb4/disk-92fd6e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90731c1057eb/vmlinux-92fd6e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7066fa5b18b8/bzImage-92fd6e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfffb6c26ee592ff9e83@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 UID: 0 PID: 6046 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:handshake_complete+0x36/0x350 net/handshake/request.c:288
Code: 54 53 48 83 ec 10 48 89 54 24 08 89 f5 49 89 ff 49 bd 00 00 00 00 00 fc ff df e8 05 5b 6e f6 49 8d 5f 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ab ab d4 f6 48 8b 1b 4c 8d 63 30
RSP: 0018:ffffc90003447300 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888025ee9e80
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: 00000000fffffffb R08: ffff888027a57103 R09: 1ffff11004f4ae20
R10: dffffc0000000000 R11: ffffed1004f4ae21 R12: ffff88807867a150
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555565002500(0000) GS:ffff888125b41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000075f40000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 handshake_nl_accept_doit+0x3c9/0x7f0 net/handshake/netlink.c:128
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:728
 __sock_sendmsg net/socket.c:743 [inline]
 ____sys_sendmsg+0x577/0x880 net/socket.c:2626
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2680
 __sys_sendmsg net/socket.c:2712 [inline]
 __do_sys_sendmsg net/socket.c:2717 [inline]
 __se_sys_sendmsg net/socket.c:2715 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd1638f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd38a9ef8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdd165e5fa0 RCX: 00007fdd1638f749
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fdd16413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdd165e5fa0 R14: 00007fdd165e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:handshake_complete+0x36/0x350 net/handshake/request.c:288
Code: 54 53 48 83 ec 10 48 89 54 24 08 89 f5 49 89 ff 49 bd 00 00 00 00 00 fc ff df e8 05 5b 6e f6 49 8d 5f 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ab ab d4 f6 48 8b 1b 4c 8d 63 30
RSP: 0018:ffffc90003447300 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888025ee9e80
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: 00000000fffffffb R08: ffff888027a57103 R09: 1ffff11004f4ae20
R10: dffffc0000000000 R11: ffffed1004f4ae21 R12: ffff88807867a150
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555565002500(0000) GS:ffff888125b41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f52cc6e8286 CR3: 0000000075f40000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	54                   	push   %rsp
   1:	53                   	push   %rbx
   2:	48 83 ec 10          	sub    $0x10,%rsp
   6:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
   b:	89 f5                	mov    %esi,%ebp
   d:	49 89 ff             	mov    %rdi,%r15
  10:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  17:	fc ff df
  1a:	e8 05 5b 6e f6       	call   0xf66e5b24
  1f:	49 8d 5f 28          	lea    0x28(%r15),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ab ab d4 f6       	call   0xf6d4abe4
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	4c 8d 63 30          	lea    0x30(%rbx),%r12


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

