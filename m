Return-Path: <netdev+bounces-206327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19EB02A8D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 13:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC93A272D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575219AD8B;
	Sat, 12 Jul 2025 11:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148B81E
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752318990; cv=none; b=XJqiRVe0ZnYo7JgeqDal/NYJsSz06rRky7H4Zd8eMvSan+sC+5mLffYHV5M+s5jCGRINMZIu5HWjl2drtCuIj+/C3TOW/aOBc+IxeqbGUyh6t7TnCb8k3GAaUF9pjCm/oW896Gudyxp20sTMBZ5nMaVWfVo1ofzLGNABjHykhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752318990; c=relaxed/simple;
	bh=fkliFdOGrgyDsHA8ugNAmVaLbtENtinBLlPZsBlbK6E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qZV4qA/4x224aln75UWSFdoJ8O1I9KXUL5oIxVZhAvZ2knsLn30sS5fx4wvq3ZDxXZrBSB32foyO0uiBkzT70pBMbCu8e/sZDJI6c6va3Z0BsvvCYvlGGkIDZZmR1zeo6eyf8QTtIPi71JwoajdAg7h1/NAF2buE5Q8Hb4aCYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso24977625ab.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 04:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752318988; x=1752923788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln9wyZoePS6s/7ad+P5to3f3dT7ZBQFACqcfRroFUog=;
        b=D9FNf9vdvcrPRfWyOCQrG4KDc9DAz4yf01kYH5Ei9rQz1OKcjircESwYDjyGz9Q8rY
         K/BAVhZlCp95Vdr3h9XzjB2N0+EBq+QaplMlgREZJ56dHwZWUmvnXUEexIdp/TVfzqUV
         bFMzBVJJqBFnB5y14iHQQL0ytIHKDFMIKOAyZjOqc0yLatxweyB4FNMY76yc4e0RmIR8
         hO24BisZ7AC4X0XijAGN0E9Vquc4LbbS/4DYwtW4mz839IpGYWAFO8QHDiWtcMsDjbw9
         P6a+oSwZwzUp+W2VnGpby4E3UMjhasOLKQGMKDLl9bJPU87P9hK8uYpNQxXPLKQ7oMs8
         gNBg==
X-Forwarded-Encrypted: i=1; AJvYcCU3qzxVBG+FKmBiVehjS8Hn+Y9a0hqU3aODifbAniB7E6onmmwSAqps8e4NIuGWO+Y4bj11Z8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dB7IVQ+CJlxCktt0hLIvht+wK+MWBBA23ec84Yq9rGrPfRKQ
	tnEONiFgF0T1KP0Y48ukwjZUPkHgc+GgExQimn/Rcq/PaYkdROvtcFvkIMD7Va9r2OgU+64pN4z
	OeJogMM8C09mrN4EX+JRw/A4qRAf7jQuWILAmSh56s5KswwjSt7egIcGJCZ0=
X-Google-Smtp-Source: AGHT+IGoMTTByFH/DLrj059941v3CjcDlsKl0AViY4gE/n+5+BkCz2AB227JPI0+0e4eHrllaeCSN7LT1qm93W/yELsR0CDTShrX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220d:b0:3dc:8b57:b76c with SMTP id
 e9e14a558f8ab-3e253287b01mr76000835ab.9.1752318988329; Sat, 12 Jul 2025
 04:16:28 -0700 (PDT)
Date: Sat, 12 Jul 2025 04:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872440c.a00a0220.26a83e.0078.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in static_key_dec_not_one
From: syzbot <syzbot+0d84405982752c58ff64@syzkaller.appspotmail.com>
To: ardb@kernel.org, jbaron@akamai.com, jpoimboe@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e3b66e32601 vsock: fix `vsock_proto` declaration
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10f5f28c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=0d84405982752c58ff64
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11faaf1afe22/disk-1e3b66e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba355ce28c50/vmlinux-1e3b66e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/018f94fd1327/bzImage-1e3b66e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d84405982752c58ff64@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12213 at kernel/jump_label.c:282 static_key_dec_not_one+0x198/0x1d0 kernel/jump_label.c:282
Modules linked in:
CPU: 0 UID: 0 PID: 12213 Comm: syz.1.1132 Not tainted 6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:static_key_dec_not_one+0x198/0x1d0 kernel/jump_label.c:282
Code: aa 10 48 3b 4c 24 60 75 45 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c6 f7 7b 09 cc e8 c0 53 ca ff eb b7 e8 b9 53 ca ff 90 <0f> 0b 90 b0 01 eb ad 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e0 fe ff
RSP: 0018:ffffc900047c72a0 EFLAGS: 00010287
RAX: ffffffff81f60ae7 RBX: ffffffff99fd3080 RCX: 0000000000080000
RDX: ffffc9000bf4a000 RSI: 0000000000000216 RDI: 0000000000000217
RBP: ffffc900047c7358 R08: ffffffff99fd3083 R09: 1ffffffff33fa610
R10: dffffc0000000000 R11: fffffbfff33fa611 R12: ffffc900047c72e0
R13: 1ffff920008f8e58 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f23746486c0(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000069232000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __static_key_slow_dec_cpuslocked+0x19/0x110 kernel/jump_label.c:297
 __static_key_slow_dec kernel/jump_label.c:321 [inline]
 static_key_slow_dec+0x45/0x90 kernel/jump_label.c:336
 ovs_dp_change+0x3c1/0x570 net/openvswitch/datapath.c:1776
 ovs_dp_cmd_set+0x1ec/0x3b0 net/openvswitch/datapath.c:2000
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f237378e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2374648038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f23739b5fa0 RCX: 00007f237378e929
RDX: 000000000000c000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f2373810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f23739b5fa0 R15: 00007ffe78621018
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

