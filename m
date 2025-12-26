Return-Path: <netdev+bounces-246091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFBCDED48
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FC13005B8D
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE64298CAF;
	Fri, 26 Dec 2025 16:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2EF296BD3
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766768064; cv=none; b=AGoeBdZsWyGecHJj2Zil8BYXoFnQU6QYil9SX/YJWgpc3SLr471rjD4LQE3br12L0E/8rEjfFYtNbUN4ieTx3qRb030QUAMPdPQyPj+mYiLweUtpTuI5qycBjhylmxiqnEovYPOEDieF6ijSk83O3TEKyzFrAr29xKnbXbtoSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766768064; c=relaxed/simple;
	bh=xTIdLjDzkPW+hZ9qRl6vFKZRHGgzeS0bdj5OIkc8Dwo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q4cr4kDX6EAtAzbZqA3EjI2k7LfyX7647tVuY10FfLfGbNY8gDmPrJ2TzuBa2BQrtBP2rOprYZTfK2we5lU791zo9C5R6FMZox3QGHapuDcUMd1XogTAU5vSkSS15/YtlWJtz97Nfwgn7i//dj/1tH0tNegN+ciFqeREM8xz2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65d0318e02eso13747242eaf.1
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 08:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766768061; x=1767372861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkRzT1YWx/FtHsOJrTZodJ9TW4H1HxewHP7Py7d+JyA=;
        b=IiJyJAqE6JLudVqGzGxIHBDzvjFwFlhn40KG6TzQaqnZSegIVguLHkKN41Zkc8bWUZ
         MlbqKdHr4e43eF7xetlxJYWAWbTsXlYMpcTiGr0dIVHrGqemsLms9d3qfWnehcecB5uO
         +6jyy46tOQhCo89+xySlaP2usfQcpSjew10nZI51JYM/YOStm6SSXZtzThJmQbNzhMZf
         WZynJxnI+RKVe4JIUiLGJyjjaDSwyxkalMqx7DaRBYVadIcWsQ5C16ARjqRjrjqS+jWw
         hk5eYVtVqfNX9NcmtL51cn6G1Pj6YXZ3NT1Aravv8k7GYyLB303zGwhXHhGQdgF25ZkP
         OdCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdFuS1yvL9SUC4xw1b/JeQrL6oK3r0kO8FOOe456dRgofs7ERcjfWKBEJyXPVzx3zF5KLrBGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVx67tKWq9W7flwQBuGrHNm49AXPllit/yZ5kVfKwB4qWSyiN
	U2CwR5gyQGpKyY7MQCsyMD8mOJT7drEwgEHDwPhkx1UjwLQRQrEdfWY1Z6C9Hx6MzHUorMatJJf
	eTvsMe9ZSmnZ6JOIeSvW3AuW9AuN/ljuQYVf18ADJ6nTXBDB+4qLzqq3pJzc=
X-Google-Smtp-Source: AGHT+IGAiDptxteQyra1kB2rhoRqt6KAh9y5nth53MvIiQSF1YMRmS7U2WcUoMDQyndGTtJvblBpwNWIaznhIerXzaA6h1tUe1XD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca7:b0:65d:a5a:848c with SMTP id
 006d021491bc7-65d0eadd986mr10798647eaf.59.1766768061728; Fri, 26 Dec 2025
 08:54:21 -0800 (PST)
Date: Fri, 26 Dec 2025 08:54:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694ebdbd.050a0220.35954c.0077.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rcu_note_context_switch (5)
From: syzbot <syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9448598b22c5 Linux 6.19-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11423b1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=84d4a405ed798b40c96d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9448598b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e6328e25c1c8/vmlinux-9448598b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1590b31d26d/bzImage-9448598b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com

------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0x104/0x1de0 kernel/rcu/tree_plugin.h:332, CPU#0: syz.2.13843/20505
Modules linked in:
CPU: 0 UID: 0 PID: 20505 Comm: syz.2.13843 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rcu_note_context_switch+0x104/0x1de0 kernel/rcu/tree_plugin.h:332
Code: 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 bb 10 00 00 8b 85 84 04 00 00 85 c0 7e 0c 48 8d 3d 9c 94 e7 0e <67> 48 0f b9 3a 65 48 8b 2d 57 0e 0e 12 48 8d bd 84 04 00 00 48 b8
RSP: 0018:ffffc9000410f028 EFLAGS: 00010002
RAX: 0000000000000001 RBX: ffff88806a43bc40 RCX: ffffffff81a41b2f
RDX: 0000000000000000 RSI: ffffffff8bf2b380 RDI: ffffffff908c3650
RBP: ffff888054ce24c0 R08: 0000000000000000 R09: fffffbfff211169a
R10: ffffffff9088b4d7 R11: ffff888054ce2ff0 R12: 0000000000000000
R13: ffff888054ce24c0 R14: ffffffff9088e574 R15: ffff88806a43ac80
FS:  00007f883fff66c0(0000) GS:ffff8880d68f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004a53a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __schedule+0x2dc/0x6150 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 netlink_broadcast_filtered+0x96d/0xf90 net/netlink/af_netlink.c:1547
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0x9e/0x220 net/netlink/af_netlink.c:2593
 __ip6_del_rt_siblings net/ipv6/route.c:4056 [inline]
 ip6_route_del+0x115c/0x1d70 net/ipv6/route.c:4196
 inet6_rtm_delroute+0x27c/0x3b0 net/ipv6/route.c:5629
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8841d8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f883fff6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8841fe5fa0 RCX: 00007f8841d8f7c9
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000003
RBP: 00007f8841e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8841fe6038 R14: 00007f8841fe5fa0 R15: 00007fffea27ccb8
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   4:	48 89 f8             	mov    %rdi,%rax
   7:	83 e0 07             	and    $0x7,%eax
   a:	83 c0 03             	add    $0x3,%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7c 08                	jl     0x19
  11:	84 d2                	test   %dl,%dl
  13:	0f 85 bb 10 00 00    	jne    0x10d4
  19:	8b 85 84 04 00 00    	mov    0x484(%rbp),%eax
  1f:	85 c0                	test   %eax,%eax
  21:	7e 0c                	jle    0x2f
  23:	48 8d 3d 9c 94 e7 0e 	lea    0xee7949c(%rip),%rdi        # 0xee794c6
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	65 48 8b 2d 57 0e 0e 	mov    %gs:0x120e0e57(%rip),%rbp        # 0x120e0e8e
  36:	12
  37:	48 8d bd 84 04 00 00 	lea    0x484(%rbp),%rdi
  3e:	48                   	rex.W
  3f:	b8                   	.byte 0xb8


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

