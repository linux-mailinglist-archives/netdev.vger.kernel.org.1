Return-Path: <netdev+bounces-162610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B5A275B9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C47E3A6721
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B92213E97;
	Tue,  4 Feb 2025 15:22:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F0213E81
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682539; cv=none; b=KnGNlDILPVoUl6d4NyD+Gc9Ta1RKPt4YpQEhTh0PTnXcvSKeI0xMEE5sNx5qhS4o0eG/dUfPT+KPaNTh4UI7IKw0oAYAFVGrUACKS+6sZLnA21YToDrEyTFxMsrpUJfboUWqVSbKwZj0VlrvQy5C0c3U/o+7X+b7yOKonZBR9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682539; c=relaxed/simple;
	bh=2vXrDXIaNLJV8dw2lCHlrfrmA4H2Rlh03vvxp6UINsU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vb5jhMveuXqiIXVMdzZoYeNrgKy+D1bt5F3TzbEiR9qeLhNozpB562tKhwUYd1jlFnsaU97Fhe/oIqCSjffSTpz5j0XYYB0DL4cchntu502yoIJdqd6PeXsJXH2LQFd2NmkEgiOTkjVuG5Wbkn86Qnl8D47tS/Jav5/yI+inEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d04b390e9cso1791015ab.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682536; x=1739287336;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB9a/jpSevfqYoda9DEyRndCIaWpKHT1O1m+rdGRDDU=;
        b=chpfZI5qmr7eRH6RaECdP6UVxtAe/bd2gPwIoMZ3mG6GDde+iGAkWd5yMwglV0qV3h
         hC4v25MFxGEAFQoti4qXpSAIbJCpQhVzlo9X7LoDo2E25uG6HNqkOaemR4Kqf37UagI9
         KBa4nIuzmBaFVhxhNuBOSkAAl+N1NtwnOiNPn2Y9ndKa9/tu1uoPJAvCs8hLFgHxEGP2
         iqL+hqaeSKfW6k+YvBkPet23q/KYv0d3i8KRCfqsa+RzJ6uai+/ypmZBnxCBTaY7t+cD
         dF6u5LZSSw1Q7cI7GMjkkqyt2bYKlANLNC9aWfpQVCLODmnE3yWIud+mOSKu5Ih6+zdC
         kiwA==
X-Forwarded-Encrypted: i=1; AJvYcCWMqaislnrBBNg06MzLAtvt5zTuG07Ob+Tj9f3jGJ/9r4VW4Zr6GnkInq7iptLM7FUklzGC7OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouphiSWwTMa349tTqsECJTosyZTzFVuZrn3afqRleNOvUwx6s
	HEkxRhyLnE6tQorxCz8LIVRrgx/HsM6wNj5IV3xYNMimvCGHVsf562JuBcdraSZvFapf8Pl6rC4
	grps+oMoUJbkIHbvRIin44QQNBARt5o4I/eMnzdN+qzf1ied47fzhzlE=
X-Google-Smtp-Source: AGHT+IFBhLy3sqUuaR+jJRhF5gJj5QyQdAQcZTtSDxscMMNuBeiRLMMiOpCtL1yGBymCQu7hscISWK5zqMV6wjplVg+mv2gt3+Pv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d0124da53emr141067535ab.13.1738682536490; Tue, 04 Feb 2025
 07:22:16 -0800 (PST)
Date: Tue, 04 Feb 2025 07:22:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a230a8.050a0220.d7c5a.00ba.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in generic_hwtstamp_ioctl_lower
 (2)
From: syzbot <syzbot+86a8ab09a0f655f1ff19@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13324b24580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d83cc1742b7377
dashboard link: https://syzkaller.appspot.com/bug?extid=86a8ab09a0f655f1ff19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17324b24580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161595f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d07b0558b0e/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5e2250eb3b1/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e676d17effc/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86a8ab09a0f655f1ff19@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 5827 Comm: syz-executor976 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:generic_hwtstamp_ioctl_lower+0x125/0x420 net/core/dev_ioctl.c:456
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 b7 02 00 00 48 ba 00 00 00 00 00 fc ff df 4d 8b 75 10 49 8d 7e 10 48 89 f8 48 c1 e8 03 <0f> b6 0c 10 49 8d 46 27 48 89 c6 83 e0 07 48 c1 ee 03 0f b6 14 16
RSP: 0018:ffffc90003e4f250 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff88807c788000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff893547b8 RDI: 0000000000000010
RBP: ffffc90003e4f338 R08: 0000000000000007 R09: 0000000000000003
R10: ffffc90003e4f2ab R11: 0000000000000001 R12: 1ffff920007c9e4e
R13: ffffc90003e4f410 R14: 0000000000000000 R15: 1ffff920007c9e9b
FS:  0000555562e35380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 0000000078b1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_hwtstamp_get_lower net/core/dev_ioctl.c:480 [inline]
 generic_hwtstamp_get_lower+0xe8/0x130 net/core/dev_ioctl.c:468
 dev_get_hwtstamp_phylib+0x181/0x610 net/core/dev_ioctl.c:291
 tsconfig_prepare_data+0x15f/0x650 net/ethtool/tsconfig.c:51
 ethnl_default_doit+0x31a/0xbd0 net/ethtool/netlink.c:493
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:713 [inline]
 __sock_sendmsg net/socket.c:728 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2568
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2622
 __sys_sendmsg+0x16e/0x220 net/socket.c:2654
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f098155c919
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca30ea5f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f09815aa4ad RCX: 00007f098155c919
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f09815aa47d R08: 0000000000000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09815aa3e5
R13: 0000000000000001 R14: 00007ffca30ea640 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_hwtstamp_ioctl_lower+0x125/0x420 net/core/dev_ioctl.c:456
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 b7 02 00 00 48 ba 00 00 00 00 00 fc ff df 4d 8b 75 10 49 8d 7e 10 48 89 f8 48 c1 e8 03 <0f> b6 0c 10 49 8d 46 27 48 89 c6 83 e0 07 48 c1 ee 03 0f b6 14 16
RSP: 0018:ffffc90003e4f250 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff88807c788000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff893547b8 RDI: 0000000000000010
RBP: ffffc90003e4f338 R08: 0000000000000007 R09: 0000000000000003
R10: ffffc90003e4f2ab R11: 0000000000000001 R12: 1ffff920007c9e4e
R13: ffffc90003e4f410 R14: 0000000000000000 R15: 1ffff920007c9e9b
FS:  0000555562e35380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 0000000078b1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 b7 02 00 00    	jne    0x2c5
   e:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  15:	fc ff df
  18:	4d 8b 75 10          	mov    0x10(%r13),%r14
  1c:	49 8d 7e 10          	lea    0x10(%r14),%rdi
  20:	48 89 f8             	mov    %rdi,%rax
  23:	48 c1 e8 03          	shr    $0x3,%rax
* 27:	0f b6 0c 10          	movzbl (%rax,%rdx,1),%ecx <-- trapping instruction
  2b:	49 8d 46 27          	lea    0x27(%r14),%rax
  2f:	48 89 c6             	mov    %rax,%rsi
  32:	83 e0 07             	and    $0x7,%eax
  35:	48 c1 ee 03          	shr    $0x3,%rsi
  39:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx


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

