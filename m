Return-Path: <netdev+bounces-122551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0287961AF6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FC2825D3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376CD18D;
	Wed, 28 Aug 2024 00:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765032F4A
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803765; cv=none; b=Su+XlSFvJhwmt1V0inB8/d+jYpqFdQWUXBOgAYAGhocjmMneT5SQmWQW+6r7h6Ks33JfKf3xpjvvumQi21t0Q33fAzqOLhGJLD15jc7V0qQHwgHiyx36eUshfHkyzzZemsQgkV1rXfhCxQmol6xeg9+SA5HH66rkWeBN4eNxmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803765; c=relaxed/simple;
	bh=0ac49p/YwVZC2Ykmla05kPB1bydY7WVFX1mhQB87lIY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m+G7JyHCA9KjtX4eo6iR/q0u01E023ZH9wFM0Gw/8lHkytal3vmfyjRnwrbediKKRhRYDxjA6tClrZm7atgjFFPBnprE9sg+3ikh3fGrzwGzs+PBhtoRJizZhjsa5qFblD+PwfokziQtSWplL3KclFEpyIY9vaXQziM4nbkcEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so656143039f.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 17:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724803762; x=1725408562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5pQmfmWhO7uDBeiOxD+Vg5Xhuy+K2v6Bu9xsxzzAbU=;
        b=LmGqnVRq25UKx4BMJbdn1PFx1bEqjPklxgSpM6KngDXhlMQgNJFa04jybJ9A95Kq3g
         kaS08Ts782Nj4pYBnkv+QsvHnKwKLk0GmOG5CqLxHuRE9IUN0LcGuGH9qY8CPbfodJTV
         WVrARFfYD//vfQz2qIuC+knEgJ3FMq70SF1FoqUuOVzlij0fUuxiBouiPEeElBKiy2jU
         NkBoEJVf3ICLInLdwELp2/cqwIDJ3iNXezDUgFTpWScYaMJBWoda4Us92OEjkUBIk06k
         RFkJZOzn3CCL/SOWFBBwOslBpOAYcWGLk67EzQW+yvt1/TigB/Kq4O1YcN3DZSl0NSJV
         hejQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhUpzka1adBJNkYAy33HkAvPJi0kvdK7wMoPIaxeGvIDnDsCgaHfmkD2mNSWl2VvTZiBpuk/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Uj7JhUpCk7ZVmJ5m4GlIU/2bOtPlHJNXyB46C8kCbUqwO4wh
	5Q6svP2WYcXo2t/pGLh+gsVjpwozm/aypBw2LqlV7hjS1lXNEACELqTCGppnfbInrhziVyvGfWi
	k57xZKbqRW6oClB8MHqA9cK5ejgDPo6ua1ARAFQbUBpUoPjDpTcJnVZg=
X-Google-Smtp-Source: AGHT+IE3K3n0CCYLHpsfSIQX9kqPIl0U6pW/+iBrG5MFk6ZdO1ublZxnvg8uw2UnGH4ZcGb3FBaW4pfi2qVUkjgQ5yu47+bt3xZN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c1:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4cec4fab5a8mr4755173.5.1724803762644; Tue, 27 Aug 2024 17:09:22
 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094740b0620b32b4e@google.com>
Subject: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net, 
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1656cc7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1582047b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100af825980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/585e02f7fe7b/disk-f9db28bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9faf5d24900/vmlinux-f9db28bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9df5868ea4f/bzImage-f9db28bb.xz

The issue was bisected to:

commit 3688ff3077d3f334cee1d4b61d8bfb6a9508c2d2
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Wed Aug 21 15:10:05 2024 +0000

    net: ethtool: cable-test: Target the command to the requested PHY

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10163b05980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12163b05980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14163b05980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com
Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")

Oops: general protection fault, probably for non-canonical address 0xdffffc00000000f8: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000007c0-0x00000000000007c7]
CPU: 0 UID: 0 PID: 5234 Comm: syz-executor293 Not tainted 6.11.0-rc4-syzkaller-00565-gf9db28bb09f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:phy_start_cable_test_tdr+0x3a/0x5c0 drivers/net/phy/phy.c:885
Code: ec 38 48 89 54 24 18 49 89 f6 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 e4 24 2b fb 48 8d bb c0 07 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 9a 66 92 fb 48 8b 83 c0 07 00 00 48 89 44
RSP: 0018:ffffc90003c7f230 EFLAGS: 00010202
RAX: 00000000000000f8 RBX: 0000000000000000 RCX: ffff888029b23c00
RDX: 0000000000000000 RSI: ffffc90003c7f740 RDI: 00000000000007c0
RBP: ffffc90003c7f470 R08: ffffffff89cb116d R09: 1ffff1100452bc15
R10: dffffc0000000000 R11: ffffffff86686630 R12: ffffc90003c7f3f0
R13: dffffc0000000000 R14: ffffc90003c7f740 R15: 0000000000000000
FS:  000055555a907380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fce9c1f000 CR3: 000000001a7d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethnl_act_cable_test_tdr+0x607/0x10d0 net/ethtool/cabletest.c:350
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3311b2ef49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6e4b3118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3311b2ef49
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe6e4b3170
R13: 00007f3311b7c406 R14: 0000000000000003 R15: 00007ffe6e4b3150
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:phy_start_cable_test_tdr+0x3a/0x5c0 drivers/net/phy/phy.c:885
Code: ec 38 48 89 54 24 18 49 89 f6 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 e4 24 2b fb 48 8d bb c0 07 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 9a 66 92 fb 48 8b 83 c0 07 00 00 48 89 44
RSP: 0018:ffffc90003c7f230 EFLAGS: 00010202
RAX: 00000000000000f8 RBX: 0000000000000000 RCX: ffff888029b23c00
RDX: 0000000000000000 RSI: ffffc90003c7f740 RDI: 00000000000007c0
RBP: ffffc90003c7f470 R08: ffffffff89cb116d R09: 1ffff1100452bc15
R10: dffffc0000000000 R11: ffffffff86686630 R12: ffffc90003c7f3f0
R13: dffffc0000000000 R14: ffffc90003c7f740 R15: 0000000000000000
FS:  000055555a907380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3311b15a00 CR3: 000000001a7d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ec                   	in     (%dx),%al
   1:	38 48 89             	cmp    %cl,-0x77(%rax)
   4:	54                   	push   %rsp
   5:	24 18                	and    $0x18,%al
   7:	49 89 f6             	mov    %rsi,%r14
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  14:	fc ff df
  17:	e8 e4 24 2b fb       	call   0xfb2b2500
  1c:	48 8d bb c0 07 00 00 	lea    0x7c0(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 9a 66 92 fb       	call   0xfb9266d0
  36:	48 8b 83 c0 07 00 00 	mov    0x7c0(%rbx),%rax
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R


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

