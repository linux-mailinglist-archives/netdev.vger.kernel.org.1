Return-Path: <netdev+bounces-200787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED9AE6E81
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF8D3AF35B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A02E62BC;
	Tue, 24 Jun 2025 18:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BF27F4F5
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789114; cv=none; b=uEZup0X8bbLn3Um/vJ4fsdoOpzOSQSy6g+H9W35B+F7WiWRwXcqdHINhvidHk8EmZ7oaRHi0EzUYKPDxgzYALi895HipJqI45280JeX8/DF69DFNKD/RTIj9xh3YhFO7GxjQZ6py0qAmR/75XxfpFgN2fVBbqwybb8E2pZTL/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789114; c=relaxed/simple;
	bh=b3gqybE5Pb4fbf+NG8nF+cHOxnanQ96YrphONGlLhb8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QDl+haCBDokkS5HHE8QYW3QpCCSocIbOxivLQyuI4Um6g8RlSktv1bdiBVfsy6LpyyLfrDsDfgFlJzCmUFLImHAMS06klwv1UtqEIWoG8vvIOQY+qgD99r8YMIp/EVtQkkxocJXxdr0R/R9n10X4pRwYLb0akqaOa3dsvijgnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddbec809acso11473025ab.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750789112; x=1751393912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nbEx6aMVKqdWvyMJYQZTfplcow4MaQFasYOV9mpc5Q=;
        b=fZiLewb5fAg/BECTUu0e2xJgcrC+ZBHty/Ai5KpTlrsWjAQDAo03B67TFMw7w5AEgy
         Mi3KIIkh7gGB7xgoVRrivvzX3a2f+CxH7qAAt9yHVBd8A1kmErgWhZTRYv6ut8lfF+S6
         IdgMnVrXc/dj80vPtwuql3z1Fml3iFEF0S0YL4F8BPIFFlgoKuCQaEAXBXioQKqkM0ri
         kD6rSm4lejCp3GQRqtb42YHKT2L7UPkuVH/EnWEl8rGvV3MMRA5pbEzygTQb9LkRWMCP
         nA79nMXTsIv1tHhtuUEOmZhsX2QZa5h8tfcIoeD/guQ9OPIjeY4q591VFQHelDWOwi3j
         CEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5SoA9juLEpMtevIni3KYOfdPCYvUpTn8zZnjSb+/JPV7riVldaIDF1TLTrbZkqt+JAW3OIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJerkRMW5p1wK0t+Au9PQ5+cUmZNvnZrwRX9pMEoO9VyyILqG
	q3uMbuptcxQaNqDXjg0OWZmU6OF/KYgCn6ePHn0/kksr19mDilo5p2kU+Ba4LTHhnfQzAwD1bI5
	/rEUqsSCA9GPRDy/23KnjnQFZKs6G71CrxJ5vte6WXN8HaTKB8disLcIo2fA=
X-Google-Smtp-Source: AGHT+IEKpUzUpSGavgSOnfmZjsCqKhAYX//2LVI3qo9n5HmjNzxIxrIBnPG8//vvvhzAPnERsu6qLWjtRY1G8q5OkwK8qpUdhg7q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:3dd:c4ed:39c0 with SMTP id
 e9e14a558f8ab-3df328e0374mr964335ab.1.1750789111711; Tue, 24 Jun 2025
 11:18:31 -0700 (PDT)
Date: Tue, 24 Jun 2025 11:18:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685aebf7.a00a0220.2e5631.008d.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mark_subflow_endp_available (2)
From: syzbot <syzbot+c6e2db6fd15f31126b7a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75f5f23f8787 Merge tag 'block-6.16-20250619' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140f8182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=c6e2db6fd15f31126b7a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-75f5f23f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7979df97154f/vmlinux-75f5f23f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/010807ef6fc8/bzImage-75f5f23f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6e2db6fd15f31126b7a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.3.1789'.
netlink: 8 bytes leftover after parsing attributes in process `syz.3.1789'.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 12059 at net/mptcp/pm_kernel.c:880 __mark_subflow_endp_available net/mptcp/pm_kernel.c:880 [inline]
WARNING: CPU: 0 PID: 12059 at net/mptcp/pm_kernel.c:880 __mark_subflow_endp_available+0x12e/0x140 net/mptcp/pm_kernel.c:876
Modules linked in:
CPU: 0 UID: 0 PID: 12059 Comm: syz.3.1789 Not tainted 6.16.0-rc2-syzkaller-00231-g75f5f23f8787 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:880 [inline]
RIP: 0010:__mark_subflow_endp_available+0x12e/0x140 net/mptcp/pm_kernel.c:876
Code: 48 0f ab 9d 88 0a 00 00 5b 5d 41 5c 41 5d e9 d9 f8 4c f6 e8 64 d0 b3 f6 eb ca e8 5d d0 b3 f6 e9 60 ff ff ff e8 c3 f8 4c f6 90 <0f> 0b 90 e9 78 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc900036373d8 EFLAGS: 00010283
RAX: 00000000000057d6 RBX: 0000000000000000 RCX: ffffc9000d761000
RDX: 0000000000080000 RSI: ffffffff8b6f236d RDI: 0000000000000001
RBP: ffff888025d08b80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888025d09608
R13: ffff888025d095b8 R14: ffff8880653cde80 R15: 0000000000000000
FS:  00007f1bc288a6c0(0000) GS:ffff8880d6753000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1bc2888fb8 CR3: 0000000064977000 CR4: 0000000000352ef0
DR0: 0000000000000007 DR1: 000000000000009b DR2: 00040000ffffffff
DR3: 0000000000000009 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:915 [inline]
 mptcp_pm_nl_del_addr_doit+0xaf4/0xed0 net/mptcp/pm_kernel.c:1013
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1bc198e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1bc288a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1bc1bb6080 RCX: 00007f1bc198e929
RDX: 000000002000c094 RSI: 0000200000000000 RDI: 0000000000000006
RBP: 00007f1bc1a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1bc1bb6080 R15: 00007ffc06c0d828
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

