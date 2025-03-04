Return-Path: <netdev+bounces-171558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02440A4D9AC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047FD188E07C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5001FECA5;
	Tue,  4 Mar 2025 10:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FC1FCFE5
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082483; cv=none; b=YyuvGlGzYccr1JXMjMKcveFPRYQakVVhnHjO6YsQSe8pEm39Gl5Xl1a6pnf69F+siwBEXPZ3pi3HPGYCHndBQkLwqJFIV2V6xsfrliOayKZjLvlAjZkNX4jXbwe93XnRwMhuzexDQ94BXaIUhfeZYda1to6iShabffxucIl2htI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082483; c=relaxed/simple;
	bh=IC2XuvAa0lYwETLpVyqSTP4i+snCCLzIsrczhgUaPW8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jJ7qt854Fw0dlUhB7N6gzU/lxow9leW14cNh6kMeUEUiJm0PxTzqeZ7EGqJAg/delA8tTpkeKEWCZ1ptv9+sSh6Yx9xaE9fvls5GHfqOdBkviWvLu+Yi6/coPgdLM6bOtv0dY2yzLZgoJhCzHsaF4JHRcSI41f1mCk64IlP/3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d3d9be92f5so49493045ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 02:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082480; x=1741687280;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/Zc68BmvYrG4jaGwK/AZGXtKiFZv6jpzD48qgb9cBE=;
        b=Ccf9cViEZm7Kc4nCCQDZK86GqUtrvKuFmbv7YJt9PDbggpKv8EC42CfDgGf3T/vAy9
         peWSxgNQ/OQMDoMU/7u6ZwhHNRLpPnqh4E/k/03dGYkiyerQnOs2wb0xenhQPA9HWoeK
         rnAxGoV75Es8xRGozfNJ8wcODnfClvOWcAxeMxpDg0pAlZyR8MLehMqIGXtnlAYiUgKT
         OwDpyO2M01SFQtbmpqyuo2w/gOKEkKRj4lrlOGxmk96Fd/Uq/3pNJGNHNMqtFUgtamxy
         NSh7He/hLx2xx5sQhNi2jVyCZt2wsC2aawEzFyu7ttJnWvllJzNYAGgVvbKSQ302inUJ
         TDfw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+q0QGjQW1pzqzE+MmIN8UmiZ2niZxyMdm15kX4lxob1vvuoUdDqDoymLTvgQB5Q9fSH/yXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvgVk7meF2qjpNPYmbuMvq5vj2WU3JVIEnu2fYph2JoPzqFQr
	Dg05rndOHC5I87Z2fj3qvGn5JbmrekGXIv4gSzjfh/KAHIC5cP5YO0V3cO9m1JmcbKko1E2P6UO
	R7TkqGLE/8XHMQofayYybvcwRdqcl4UxOIgYVrvcKdeGebyAQgXqFlB0=
X-Google-Smtp-Source: AGHT+IE+JQ3bVgUjZ4h9h61JVoaR+BgwUKVT1Lg/GxkRTFPjGUIJ8/JP6fybev+q2+bolt2673MCB9vANX5Y3q3LzSfEQCsZjav2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3d0:f2ca:65aa with SMTP id
 e9e14a558f8ab-3d41dbf0910mr24052925ab.4.1741082480591; Tue, 04 Mar 2025
 02:01:20 -0800 (PST)
Date: Tue, 04 Mar 2025 02:01:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c6cf70.050a0220.15b4b9.000a.GAE@google.com>
Subject: [syzbot] [net?] WARNING in taprio_get_start_time
From: syzbot <syzbot+2ca2c2f6cd8f0efac48e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3424291dd242 Merge branch 'ipv4-fib-convert-rtm_newroute-a..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11226fb8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1770b825960d3ae8
dashboard link: https://syzkaller.appspot.com/bug?extid=2ca2c2f6cd8f0efac48e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94c5b9f4e9a5/disk-3424291d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c19be66773b/vmlinux-3424291d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5defd4d4c3bb/bzImage-3424291d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ca2c2f6cd8f0efac48e@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.3.1243'.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 10562 at net/sched/sch_taprio.c:1223 taprio_get_start_time+0x16d/0x1a0 net/sched/sch_taprio.c:1223
Modules linked in:
CPU: 1 UID: 0 PID: 10562 Comm: syz.3.1243 Not tainted 6.14.0-rc4-syzkaller-00873-g3424291dd242 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:taprio_get_start_time+0x16d/0x1a0 net/sched/sch_taprio.c:1223
Code: 00 74 08 48 89 ef e8 d2 b0 23 f8 48 89 5d 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 34 70 bc f7 90 <0f> 0b 90 b8 f2 ff ff ff eb dd 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000499ee40 EFLAGS: 00010293
RAX: ffffffff8a054f0c RBX: 0000000000000001 RCX: ffff88807bc0bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888061f902d4 R08: ffffffff8a054eb5 R09: 1ffffffff28a973c
R10: dffffc0000000000 R11: ffffffff816179a0 R12: 0000000000000000
R13: 0000002d526987fd R14: dffffc0000000000 R15: 0000000000000000
FS:  00007fbeb5b246c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f615db80f98 CR3: 0000000058954000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 taprio_change+0x240d/0x44f0 net/sched/sch_taprio.c:1939
 taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2114
 qdisc_create+0x9d4/0x11a0 net/sched/sch_api.c:1360
 tc_modify_qdisc+0xbbb/0x1f10
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6928
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbeb4d8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbeb5b24038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbeb4fa5fa0 RCX: 00007fbeb4d8d169
RDX: 0000000000000000 RSI: 00004000000007c0 RDI: 0000000000000004
RBP: 00007fbeb4e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbeb4fa5fa0 R15: 00007ffce7058248
 </TASK>


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

