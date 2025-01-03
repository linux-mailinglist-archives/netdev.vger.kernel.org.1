Return-Path: <netdev+bounces-154951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58654A00765
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657261881302
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC01CBE96;
	Fri,  3 Jan 2025 10:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A0186A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898665; cv=none; b=Y0olCIZ4kkQczZeef2MUCN6HxUvFr+ycHqB2n4D3S23fvnRPkU1A+HIsYLHbg7xRZTs6ceoczVJL9IWmtZaxjplwj/N9vppCIka5+3DPVf2qhqC/aOJ7j0+bfB7J/VsZLgFRB9VMEd2s3glpYN4ysUFYcRchFrBwz4+n4QJyRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898665; c=relaxed/simple;
	bh=hVjJPMKUa+aroXASiRGLgEiuF028Vvwelee4h1DCUVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nJQSXVfMo6p6Og0okrYSMvqpweD8KyM4K4YBRvDMOe5C36B4NNLkFD9d7a1UAK+pNFEwYICoEK6a7e0Qjgijvg5NrhUkufogW1cDcaQdbMmE/E7VMudZrseS4nAfknwLCQc3oJ2r8SEUuvg68pUOzvzJVP1VnQIEloA8MieI5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-845dee0425cso960737839f.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 02:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898663; x=1736503463;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cleEppcRZasO+HdmpfiCaBTOZ+XcxGpv2EM2m4YaFI=;
        b=R6OL/tP18pXu/BLb96iqtUfl0Mg7MKxSb5jzhCaa6B3Mhf6uTP6RMfDF845JfGjMBO
         EfkMIVRiO6J5B3/duvAnD6TmBlaAYhmFSNhzdHVdYakknnPhRACeX/zxING+jY401ztd
         ukdYqOmmyU/k9kAzxULqZsfiXB6uuuMrZd2zsmHWDQVTU/PQ4yQDor3msesgn5DdZWlo
         +LznkpYZq1cQu/dXakL1aGCQP+eXPRAL+d/RNhicUspJg0B6JEitlLjZM1Dq4+fG5QTi
         gbttoZyH1JsxCBT1oVewi3aJMSlVCUwWdlki2KSGJHuDx5hKoc0BVOa6Bg5UncFbZ67g
         5HIw==
X-Forwarded-Encrypted: i=1; AJvYcCXbz1FbRuVVTZJqr2j9g+Mqbsb2KTvAt78KFUkZtryt9kf51eSAWWfv1j3lEiXYgZFwtoJdnf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAg/21H7TpC7swgloZdFMN75J6nQvKFoadRCT3DzTzzfxRhfQv
	G/5kvjm4PbwquKA4QQe1YajrdjSD8+IVlSxLCeH59WvVW+lqU08YdlA0YzCztS5FIycubAjFVkc
	T2MWpytHXk+qhjSQBvH1S7qmncEsC1cBJY/oLuwG2KkpII3phPKUlBH0=
X-Google-Smtp-Source: AGHT+IHVH/kmayW64IAR1ytwtO7hq0rbFEhiIq/JME4FE6JPXU4ujLcfPmM0kDGnzZFlvMrW0QI4rmTrNjl7SwgciSHitBGDdV9o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2384:b0:3a7:fe8c:b014 with SMTP id
 e9e14a558f8ab-3c2d5917533mr418574765ab.21.1735898663346; Fri, 03 Jan 2025
 02:04:23 -0800 (PST)
Date: Fri, 03 Jan 2025 02:04:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6777b627.050a0220.11076.0005.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in tipc_udp_nl_dump_remoteip (3)
From: syzbot <syzbot+a9a9a6bca76550defd42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a024e377efed net: llc: reset skb->transport_header
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15f06af8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a9a6bca76550defd42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2ea524d69fe/disk-a024e377.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b39d227b097d/vmlinux-a024e377.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ee66636253f/bzImage-a024e377.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9a9a6bca76550defd42@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 14612 Comm: syz.3.2265 Not tainted 6.13.0-rc3-syzkaller-00174-ga024e377efed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tipc_udp_nl_dump_remoteip+0x5d0/0xd40
Code: 89 44 24 40 49 8d 84 24 d0 00 00 00 48 89 44 24 60 49 8d 84 24 c8 00 00 00 48 89 44 24 68 31 db 4c 89 e8 48 c1 e8 03 4d 89 f7 <42> 80 3c 30 00 74 08 4c 89 ef e8 b1 90 9e f6 4d 8b 75 00 89 df 89
RSP: 0018:ffffc90003416fa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90003417082
RDX: ffffc900034170a2 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003417190 R08: ffffffff899a5576 R09: 1ffffffff2032f86
R10: dffffc0000000000 R11: fffffbfff2032f87 R12: ffff8880216a2a00
R13: 0000000000000000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f418dbce6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f418dbedfb8 CR3: 000000007b6ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2317
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2432
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f418cd85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f418dbce038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f418cf76080 RCX: 00007f418cd85d29
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f418ce01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f418cf76080 R15: 00007ffecc482698
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_udp_nl_dump_remoteip+0x5d0/0xd40
Code: 89 44 24 40 49 8d 84 24 d0 00 00 00 48 89 44 24 60 49 8d 84 24 c8 00 00 00 48 89 44 24 68 31 db 4c 89 e8 48 c1 e8 03 4d 89 f7 <42> 80 3c 30 00 74 08 4c 89 ef e8 b1 90 9e f6 4d 8b 75 00 89 df 89
RSP: 0018:ffffc90003416fa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90003417082
RDX: ffffc900034170a2 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003417190 R08: ffffffff899a5576 R09: 1ffffffff2032f86
R10: dffffc0000000000 R11: fffffbfff2032f87 R12: ffff8880216a2a00
R13: 0000000000000000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f418dbce6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007b6ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 44 24 40          	mov    %eax,0x40(%rsp)
   4:	49 8d 84 24 d0 00 00 	lea    0xd0(%r12),%rax
   b:	00
   c:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  11:	49 8d 84 24 c8 00 00 	lea    0xc8(%r12),%rax
  18:	00
  19:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  1e:	31 db                	xor    %ebx,%ebx
  20:	4c 89 e8             	mov    %r13,%rax
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	4d 89 f7             	mov    %r14,%r15
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 b1 90 9e f6       	call   0xf69e90ea
  39:	4d 8b 75 00          	mov    0x0(%r13),%r14
  3d:	89 df                	mov    %ebx,%edi
  3f:	89                   	.byte 0x89


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

