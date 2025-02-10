Return-Path: <netdev+bounces-164659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AEA2E9F1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C033A3A71B1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AC1CEEBE;
	Mon, 10 Feb 2025 10:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE671C9B97
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184567; cv=none; b=IReSIR1J65mSQu3lZ7W6uKxlk6/oGaq4T0R0q6dHxMBLlgGDZoFRE6Nl5MsaVFRiQO0S/K+oVX04eVqfWZgDOKc+MKCJxbvV0Rfex0yyGO5rO7wbqFFe5ZTKy7DxP8gRqxjQQoGM6QqXW6PgHxsqOeH14XPXrAPtquemI2fpl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184567; c=relaxed/simple;
	bh=IVKj2r27O+WG8GrGI4AhKVmooWlcMfAIv1M4IG04wS0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MpHLlThP/R0ULq+JGpWgA+bpA+qHdct5/eOS3HfT3YVcdJcz9EJ7xE1/Z7vIgQsbs3lFVUqlPK4Jf6FrDj4VkX+zpB+dVG6zSVVs23JpZOx0nP5PS+OElUD5nI7KBfihqcb3MjfBcR7ssRCH+QnVMqE6FmTagiBgeriADE9GLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-855292b5160so162551339f.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184564; x=1739789364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3fwt6a+ZSRl2GT0BVgVYdt+ykyjBYZya/Ag/6HqCEE=;
        b=c+ILCN6AoVQAEhao1W0yoj5e1cwOluiRQrCZlFR2bwCw5xcgxZcN17jkNWBpVgLnYm
         q3XgP+tI/dAJv3RCnyimAzpBNecmql+9HeeDtJQ7Wiukg9QjCXwqqZxGUj2dl0wwoicV
         vozpqdU9U4Y05GJHwSq6HLF56VNdyr30u9M0PmbxEfp7BRTiRjlvqH5ZeTXQP7EY96xo
         pst7VLLXQVdCWzQpnMLFd7sSVcKCd9S1EEVoi2MQoVrx3OGv5pR/nNKPgk3qXivID6SY
         33M9ZGdix9FSs0cRCjJTYp6ZWoWIMBo9PGxEVVOmeSqAYo1mNyiGWHT2EUpnsE1Lqy+n
         Kg9A==
X-Forwarded-Encrypted: i=1; AJvYcCXq5qn97mrbdMbgZdike3ahgyu4zzL3/R9GZM9dTgpYG1P9UXGZpD5cfnBSW2zIOZaQimjMfos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjQWTN5tveDkrT5t6RHN41EBcL/piABODV8JwakWG0qi07F9i
	crL7rIy5rN2kkxIrty6dbMVFeHzTSQrjCG4hiQ0eBHWprr3OyUA5ZTrqHSxW/SdYECjjpyAZPkw
	4difKvCjmFv6CNxvRkuqvF2ykwLzUv9nWpisjW8E9Cl/RDUWym4I9QAU=
X-Google-Smtp-Source: AGHT+IE3ajIjtm6u+ny5DA4/LPdiAoExyiznPqAVkQ8pdsGad4TUhnFmnovUvfvnTsggMRDFKRGAKDtZUQBkLX1Zrt7M+JDyeLUZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2383:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d13dd68f9fmr112558235ab.13.1739184564552; Mon, 10 Feb 2025
 02:49:24 -0800 (PST)
Date: Mon, 10 Feb 2025 02:49:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a9d9b4.050a0220.110943.002d.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in vxlan_vnigroup_uninit
From: syzbot <syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124d6bdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=6a9624592218c2c5e7aa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1466c2a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121f3b18580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d0a58d1d655/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99949b40299/bzImage-69b54314.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com

RBP: 0000000000000002 R08: 00007ffcf7f2bc26 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000206 R12: 0000400000000114
R13: 0000400000000110 R14: 0000400000000088 R15: 0000000000000001
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc000000002c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000160-0x0000000000000167]
CPU: 0 UID: 0 PID: 5952 Comm: syz-executor397 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vxlan_vnigroup_uninit+0x89/0x500 drivers/net/vxlan/vxlan_vnifilter.c:912
Code: 00 48 8b 44 24 08 4c 8b b0 98 41 00 00 49 8d 86 60 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 04 00 00 49 8b 86 60 01 00 00 48 ba 00 00 00
RSP: 0018:ffffc90003f67218 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8672effb
RDX: 000000000000002c RSI: ffffffff8672ecb9 RDI: ffff8880326b4f18
RBP: ffff8880326b4ef4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000020000
R13: ffff8880326b0d80 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555568fc8380(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf08e2b246 CR3: 0000000012f30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vxlan_uninit+0x1ab/0x200 drivers/net/vxlan/vxlan_core.c:2942
 unregister_netdevice_many_notify+0x12d6/0x1f30 net/core/dev.c:11824
 rtnl_newlink_create net/core/rtnetlink.c:3823 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3906 [inline]
 rtnl_newlink+0x1459/0x1d60 net/core/rtnetlink.c:4021
 rtnetlink_rcv_msg+0x95b/0xea0 net/core/rtnetlink.c:6911
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf08dd5a69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf7f2be88 EFLAGS: 00000206 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffcf7f2bea0 RCX: 00007faf08dd5a69
RDX: 0000000004008840 RSI: 0000400000000000 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffcf7f2bc26 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000206 R12: 0000400000000114
R13: 0000400000000110 R14: 0000400000000088 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vxlan_vnigroup_uninit+0x89/0x500 drivers/net/vxlan/vxlan_vnifilter.c:912
Code: 00 48 8b 44 24 08 4c 8b b0 98 41 00 00 49 8d 86 60 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 04 00 00 49 8b 86 60 01 00 00 48 ba 00 00 00
RSP: 0018:ffffc90003f67218 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8672effb
RDX: 000000000000002c RSI: ffffffff8672ecb9 RDI: ffff8880326b4f18
RBP: ffff8880326b4ef4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000020000
R13: ffff8880326b0d80 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555568fc8380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf7f2bd88 CR3: 0000000012f30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	44 24 08             	rex.R and $0x8,%al
   6:	4c 8b b0 98 41 00 00 	mov    0x4198(%rax),%r14
   d:	49 8d 86 60 01 00 00 	lea    0x160(%r14),%rax
  14:	48 89 c2             	mov    %rax,%rdx
  17:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4d 04 00 00    	jne    0x481
  34:	49 8b 86 60 01 00 00 	mov    0x160(%r14),%rax
  3b:	48                   	rex.W
  3c:	ba                   	.byte 0xba
  3d:	00 00                	add    %al,(%rax)


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

