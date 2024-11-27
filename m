Return-Path: <netdev+bounces-147656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF59DAF21
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6A4B20B02
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563E2036E8;
	Wed, 27 Nov 2024 21:55:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D5202F7B
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744525; cv=none; b=DGje8Zzw3GJ4y/BCkWGuuz+bWbIdKb/BMivcaiS+YEPztY5aKZnA3+WrJqZL+4Jcs9Zzxeu1BXJyv1/ZvLqFq1KNSC+ZMaCqGaw2AC6RcDKtPDkSZNeZEqCPOBaLSxxJFjhLkRMAC3E/Pi7PrEfZDjp+U9VwKYg7qYQ3y42Hezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744525; c=relaxed/simple;
	bh=wHM2OrL8e79dKeH2gD8Yp82lDj4yCL0xRcvE5WB7s9s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jCiOPLkYGi63rx46iNGRrVKGMirIUvHZKXOp8u1fKRQjR9xn4U4I19/RIMTevVDUf+QSIG55M/FnyLppwIPowz1HLHE+xLq82N9K6AOGHC18l8zoUAHnLRZ2076O7j8O2IOpm/byGs0aM8heuBBIrVBYEI9yPxh3oUbssd3DhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84182041b05so12463539f.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 13:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732744523; x=1733349323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Epg/2RMhmpPXmBlb4qS8YZsKov8fLNlh2IrMDtv8Kxs=;
        b=pDtFIFy5Ihcsc+TSy1CBFWacEwR7jcKRSoeOdAkTiRSDO15oSMub/6xp+r1Gh+UeQx
         Ss2OzdCy4MDnK4ydHfooW86R10MVegm4CDzWqCMSzds5rLOFsY6CoLXpPXx+oMLn1w4m
         YeWE0zZTPg1NwEDL3veavhdUdxlcujaa512iX7lYVnac2JCCcdRCm2GUf4W1xajZ+g7l
         pqMJdSvRyE2pHD7O6CbjLJh95JbS1uGI2NM1ykPhPPXb+7GG0t4XgVKY8Ku7ZGZ6hjMl
         v244uCogk4G2qP/2UAWkNJ2tMGulAP4IN08WFR+ozZCJ2ijmXcWyezHXa//zcLZUikzS
         lo6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfjmkHciKqU/TabatXgLRTmWeqrKu9VWreZ537RknhmCf/qDZSVoheDBZBoZxsZVDIdtCoIHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmi7x+5IWvH9/86OP0jw6tVxIRVVF37GTqxworvJATuaqGW2j
	pGjPLjOa6VN1cNs5b+q9sMg4oFqRAAvE68X//AYCeh68iqLeSp9f/NGB/aeujSazlnSWJg8Jp/J
	PJOhxmgFSpToZEu3+m+XD/Nq2CoQTnJgxiJ02txnF3N/weaygB/1B+xA=
X-Google-Smtp-Source: AGHT+IF5KfYlQB4ZglRygUfFv4HlReybSxnwAVaXI2cqd9V0GHNEQqdc0dKCshkBV2GNUJoSGcfKFgsp2XiTCNqdtyszvdoerLAW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d05:b0:3a7:8040:595b with SMTP id
 e9e14a558f8ab-3a7c555ec95mr39547485ab.9.1732744523085; Wed, 27 Nov 2024
 13:55:23 -0800 (PST)
Date: Wed, 27 Nov 2024 13:55:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747954b.050a0220.253251.0064.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in __hw_addr_add_ex (2)
From: syzbot <syzbot+a29a4fe94b1560756f7d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f153a692bac Merge commit 'bf40167d54d5' into fixes
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17e6d230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdbbf8ef410bf2e8
dashboard link: https://syzkaller.appspot.com/bug?extid=a29a4fe94b1560756f7d
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1080aca7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c3a940580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-5f153a69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf8994051afc/vmlinux-5f153a69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7603ef590293/Image-5f153a69.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a29a4fe94b1560756f7d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in memcmp+0xc0/0xca lib/string.c:676
Read of size 1 at addr ffffffff895cb520 by task syz-executor156/3200

CPU: 1 UID: 0 PID: 3200 Comm: syz-executor156 Not tainted 6.12.0-rc1-syzkaller-00012-g5f153a692bac #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010a14>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85f7c3cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85fd797a>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff85fd797a>] dump_stack_lvl+0x122/0x196 lib/dump_stack.c:120
[<ffffffff85f861e4>] print_address_description mm/kasan/report.c:377 [inline]
[<ffffffff85f861e4>] print_report+0x290/0x5a0 mm/kasan/report.c:488
[<ffffffff80970318>] kasan_report+0xec/0x118 mm/kasan/report.c:601
[<ffffffff8097214e>] __asan_report_load1_noabort+0x12/0x1a mm/kasan/report_generic.c:378
[<ffffffff85f525ae>] memcmp+0xc0/0xca lib/string.c:676
[<ffffffff84d3805e>] __hw_addr_add_ex+0xee/0x676 net/core/dev_addr_lists.c:88
[<ffffffff84d3b06a>] __dev_mc_add net/core/dev_addr_lists.c:867 [inline]
[<ffffffff84d3b06a>] dev_mc_add+0xac/0x108 net/core/dev_addr_lists.c:885
[<ffffffff84edd5e2>] mrp_init_applicant+0xe8/0x56e net/802/mrp.c:873
[<ffffffff85ad13e2>] vlan_mvrp_init_applicant+0x26/0x30 net/8021q/vlan_mvrp.c:57
[<ffffffff85ac7490>] register_vlan_dev+0x1b4/0x922 net/8021q/vlan.c:170
[<ffffffff85acfab0>] vlan_newlink+0x3d2/0x5fc net/8021q/vlan_netlink.c:193
[<ffffffff84d83228>] rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
[<ffffffff84d83228>] __rtnl_newlink+0xfe2/0x1738 net/core/rtnetlink.c:3730
[<ffffffff84d839ea>] rtnl_newlink+0x6c/0xa2 net/core/rtnetlink.c:3743
[<ffffffff84d7259a>] rtnetlink_rcv_msg+0x428/0xdbe net/core/rtnetlink.c:6646
[<ffffffff850b3e8e>] netlink_rcv_skb+0x216/0x3dc net/netlink/af_netlink.c:2550
[<ffffffff84d6454c>] rtnetlink_rcv+0x26/0x30 net/core/rtnetlink.c:6664
[<ffffffff850b2140>] netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
[<ffffffff850b2140>] netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1357
[<ffffffff850b2ce0>] netlink_sendmsg+0x864/0xdc6 net/netlink/af_netlink.c:1901
[<ffffffff84c5e82a>] sock_sendmsg_nosec net/socket.c:729 [inline]
[<ffffffff84c5e82a>] __sock_sendmsg+0xcc/0x160 net/socket.c:744
[<ffffffff84c5f436>] ____sys_sendmsg+0x5ce/0x79e net/socket.c:2602
[<ffffffff84c66b4c>] ___sys_sendmsg+0x144/0x1e6 net/socket.c:2656
[<ffffffff84c67624>] __sys_sendmsg+0x130/0x1f0 net/socket.c:2685
[<ffffffff84c67754>] __do_sys_sendmsg net/socket.c:2694 [inline]
[<ffffffff84c67754>] __se_sys_sendmsg net/socket.c:2692 [inline]
[<ffffffff84c67754>] __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2692
[<ffffffff8000f2d4>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
[<ffffffff85fd9c4a>] do_trap_ecall_u+0x1aa/0x216 arch/riscv/kernel/traps.c:331
[<ffffffff85ffcac6>] _new_vmalloc_restore_context_a0+0xc2/0xce

The buggy address belongs to the variable:
 vlan_mrp_app+0x60/0x3e80

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x897cb
flags: 0xffe000000002000(reserved|node=0|zone=0|lastcpupid=0x7ff)
raw: 0ffe000000002000 ff1c00000025f2c8 ff1c00000025f2c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff895cb400: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
 ffffffff895cb480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff895cb500: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                               ^
 ffffffff895cb580: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
 ffffffff895cb600: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
==================================================================


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

