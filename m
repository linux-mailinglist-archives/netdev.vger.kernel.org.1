Return-Path: <netdev+bounces-187277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84FAA6070
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A9F17D449
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1520297D;
	Thu,  1 May 2025 15:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E836FB9
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111996; cv=none; b=G8s181nfq99f0pznLoVp5j4lXOYCGtBayfAqQndK2kv7JdFUUls0FBW62LU2Mq4M1QsCidP1rc2/pNmgrN54Q8voHlKN5jLKF0hkAYSCIEOJfHbn/2MmjzH/nyn6Fwfnvkkku+cytDmM8UEGpJhxl4upPkPaDwU2SK9FRGUp5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111996; c=relaxed/simple;
	bh=PZrVqLkKLxBnkjDS6spRwpFbqjKJMgrvdkbPDd0TV6o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t9t66VsWVC3frZk35K+Shey/b8j5gE5x+S62KyW0aM+MWEEh9k344ncYWXg/zo6hLLVzmNTt33fGNigQAHsM8vFzbCzoheZkJExtU+GciDVzLvQ8h+RZFUnvzK4fvFWdnA47lmNXGjkXhPxaxJDP+1EDTl9SXOaapTK2XNcloMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d8f1c1ce45so19741385ab.2
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 08:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746111994; x=1746716794;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Af995hKEHGR6LxVvtOyR45WwuregV9GdoWQTeUlgLGs=;
        b=Q4+8zTJ7pk4nEdlpec9d774T9RDMKJ1UNmJuKl9wc7qFks1fbMDvYZtUMkw3AoMZwi
         t08k7lpBPW2U8h0f3pLr1JhDxPizAzrFITPGM8Dhrhcv3GA4If9weemCDhWB7ylERbq1
         7TIpEY5VUYRT3sxuIBAW592QbszOw7Amlbs5dkRJv+1Ib6UKQ0VqjiR3ztQ2Oi2T58r9
         ZyagpJj2kYP4IfORkJhgyHVRxvdza75MOnsXbxpRfG+jYgOIRhUBNzhSiTjrTmqB1V/I
         OF9DGZrs9fkVPMQrsj/b6xU//Cbd6nRYJsH832VN07EigaDTfQIlVyGS0PrqZACChauX
         xuug==
X-Forwarded-Encrypted: i=1; AJvYcCW6XIt2FWI0b2FwgVIv/oSMfQ1O9Oe26OpYWR5b5JxKh/3t4gpkiGdqYAIkZrbRbT2UnTxsIgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Tn8rIRtm57OtBy1akz4NR5uVpkddNo/zwWcDVytqS9XDJ5VG
	xFMnsD6pQPf/Q8czRsI4jIbCs+LXCHkOTSr4XUe4uQUthksm/jmZ7sovLSwSHJOgtGn5rpnCrMR
	LmDDTCc3zK31XgpV0WNedX4Q9jrlA/JJjUsnLK1DIZQkxbh7e5w/kAaY=
X-Google-Smtp-Source: AGHT+IGk4SqaeyAwG9Gjg6vryATVjo+008/jtxRA8NnjPuIdbKDXUa0j/is46Fb7xBFf3TMkMCIr8o/JuEv9nhjbnutyluHn6k8J
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c5:b0:3d8:1f87:9431 with SMTP id
 e9e14a558f8ab-3d967fc6c11mr89735465ab.12.1746111994077; Thu, 01 May 2025
 08:06:34 -0700 (PDT)
Date: Thu, 01 May 2025 08:06:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68138dfa.050a0220.14dd7d.0016.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nsim_fib_event_nb
From: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    deeed351e982 Merge branch 'pds_core-cleanups'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1125e39b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96ee122b7e5ad7d4
dashboard link: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a46f74580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e2d02f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9cc381b3437/disk-deeed351.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2df0da84738b/vmlinux-deeed351.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1f015928ca2/bzImage-deeed351.xz

The issue was bisected to:

commit e6f497955fb6a072999db491a01dd3a203d5bcea
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Fri Apr 18 00:03:45 2025 +0000

    ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153481cc580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=173481cc580000
console output: https://syzkaller.appspot.com/x/log.txt?x=133481cc580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().")

IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
IPv6: NLM_F_CREATE should be set when creating new route
IPv6: NLM_F_CREATE should be set when creating new route
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib_event_nb+0xed8/0x1080 drivers/net/netdevsim/fib.c:1043
Modules linked in:
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor175 Not tainted 6.15.0-rc3-syzkaller-00644-gdeeed351e982 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
RIP: 0010:nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
RIP: 0010:nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
RIP: 0010:nsim_fib_event_nb+0xed8/0x1080 drivers/net/netdevsim/fib.c:1043
Code: fa be 02 00 00 00 eb 0a e8 25 a2 bf fa be 01 00 00 00 4c 89 f7 e8 38 e6 b7 fd 4c 8b 64 24 08 e9 91 f4 ff ff e8 09 a2 bf fa 90 <0f> 0b 90 e9 70 fb ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 35
RSP: 0018:ffffc90003fff028 EFLAGS: 00010293
RAX: ffffffff87001b77 RBX: 0000000000000002 RCX: ffff88802d180000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff888078d6642f R09: 1ffff1100f1acc85
R10: dffffc0000000000 R11: ffffed100f1acc86 R12: ffff888072f34000
R13: ffffc90003fff1a0 R14: 0000000000000001 R15: ffffc90003fff1b8
FS:  00005555830fa380(0000) GS:ffff8881260c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007d7da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:35
 call_fib6_multipath_entry_notifiers+0xe6/0x150 net/ipv6/ip6_fib.c:427
 ip6_route_multipath_add net/ipv6/route.c:5593 [inline]
 inet6_rtm_newroute+0x1a0c/0x1c70 net/ipv6/route.c:5717
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d91f8d999
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff05e7f5e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000200000000300 RCX: 00007f6d91f8d999
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

