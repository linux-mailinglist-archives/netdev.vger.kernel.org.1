Return-Path: <netdev+bounces-182018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9B6A875CF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15B1662BA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBE190068;
	Mon, 14 Apr 2025 02:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4557C93
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596872; cv=none; b=FHpGdBs1iMfbpq1dc6uLzoOEUoqIl+F9cmFxXTSM42h1aYB4rI6Ypo0n+KmRtXwOD7BoK+qNIBQ8sfPtIzyy0FdsDqwLQ7hMntq7mTCC1uCCU1nv0f8wDKjt40zqXshpi7Ut1SDZsaOcTZ6wAynwIjmEGsDHFlY0rBtNwOACa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596872; c=relaxed/simple;
	bh=1ZwwdYTGU5eP1PvszW23eXK3SXV/9wrKU1PZuxVNGq8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A4/Rc1mmMaH0EEt4wSteOfp06yndwzweoJBh2o//mrJsmCUZTcfQUsP/F2Uvtpq2ekM3cI3zbELbLN9T7oFu2+g7xRvdaFKDa+e/ygvoVbGHxOfslKT3knxeKMvGBL1WSnhlcLuQIeTOD7hO2OGfy+2JlSpAqEIMwXCu/InKzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so36184905ab.2
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 19:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744596869; x=1745201669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4U3vm5KyLDVe813rGEZxD6jhF3GorwL/kZbe5pwLbA=;
        b=PZx9UG6dBzh3sZ47qkTSacg80ko9tVKUPdbL6xoPi2nR2d02rSyNys3rfVYJuslQQJ
         wn7QlcuL6MGNhrl761Lr0PUX6U2SRyb9q8bWyKZ2dh9dLzpeL3NW2H3UlxNvGbrKGi5Y
         Y5tAcySR2lvnDkwyPw4JIDicDaJAo1E9sVXGWJ+WBbUmYFWiqVhh7vAn6gjvP0+v6Ign
         FngLEg9eN326YQ6b4DYKcusaagXer2d06wVahKMFtsKMUAoH4pbDhSCoWFJjcsif8hp5
         dAH6M74IZJvfTVfL9O8JaHWaSj8J8lPWenjDf7qCWk+jJsXQxpBwWLDmJ1gnIZtQYExU
         oc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmoCwWsXtOOvhJr2rLeER+HNkN8VM6/Q2229cjlhttAMvbizxucOjSiDOyrSzpvlCEeXfOmi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmb5inPPelU1HFn/JsCEUH7iRMCKQQ2UOvio9hHvR2W+gdRtA
	k5Iu95jcteF0UzcHJotyVqQy/OOcQ+g4VQ5r0RhZ4bajCJEjF9/Get0yrFy5ToiQOWKrgFWeuMv
	R9XJKQ55QqVib0XVnMJgPqtMISnLXGCxyw3rllWXh2L03N/yHo9GVnBU=
X-Google-Smtp-Source: AGHT+IGDSvTUmB4gCQMpiUIkgtkxZWWUgx12ReBIKshV37JfP7dx3ZEyF1LvEpAywzJVhlykljAbiZP/1u8AKO4bK9b4Bz3yO3wr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2601:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d7ec1dd010mr117782695ab.3.1744596869451; Sun, 13 Apr 2025
 19:14:29 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:14:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fc6f85.050a0220.2970f9.039d.GAE@google.com>
Subject: [syzbot] [net?] WARNING in netdev_nl_dev_fill
From: syzbot <syzbot+ab6046c8981706660600@syzkaller.appspotmail.com>
To: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jdamato@fastly.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    311920774c40 configs/debug: run and debug PREEMPT
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe37e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=ab6046c8981706660600
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594f74c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c5723f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e03f27bfdf3/disk-31192077.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a331144c511b/vmlinux-31192077.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50e193bbfbdd/bzImage-31192077.xz

The issue was bisected to:

commit 99e44f39a8f7138f8b9d2bd87b17fceb483f8998
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Apr 8 19:59:53 2025 +0000

    netdev: depend on netdev->lock for xdp features

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1519f23f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1719f23f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1319f23f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab6046c8981706660600@syzkaller.appspotmail.com
Fixes: 99e44f39a8f7 ("netdev: depend on netdev->lock for xdp features")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5842 at ./include/net/netdev_lock.h:17 netdev_assert_locked include/net/netdev_lock.h:17 [inline]
WARNING: CPU: 0 PID: 5842 at ./include/net/netdev_lock.h:17 netdev_nl_dev_fill+0x6bc/0x860 net/core/netdev-genl.c:41
Modules linked in:
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor216 Not tainted 6.14.0-syzkaller-13332-g311920774c40 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_assert_locked include/net/netdev_lock.h:17 [inline]
RIP: 0010:netdev_nl_dev_fill+0x6bc/0x860 net/core/netdev-genl.c:41
Code: 1c 24 44 29 eb 4c 89 e8 48 c1 e8 03 42 0f b6 04 38 84 c0 0f 85 4a 01 00 00 41 89 5d 00 31 c0 e9 4d fe ff ff e8 e5 ed c4 f7 90 <0f> 0b 90 e9 2c fa ff ff e8 d7 ed c4 f7 90 0f 0b 90 42 80 3c 3b 00
RSP: 0018:ffffc90004166a20 EFLAGS: 00010293
RAX: ffffffff89fe695b RBX: 0000000000000000 RCX: ffff8880303b5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004166b50 R08: ffffffff89fe637c R09: 1ffff11009e4f5dc
R10: dffffc0000000000 R11: ffffed1009e4f5dd R12: ffff88803259c000
R13: ffff888034e433c0 R14: ffff888034e433c0 R15: ffffc90004166ba0
FS:  000055557df6b480(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95074a6b30 CR3: 000000007d20e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_genl_dev_notify+0x1fb/0x450 net/core/netdev-genl.c:102
 netdev_genl_netdevice_event+0x81/0xa0 net/core/netdev-genl.c:-1
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2273 [inline]
 call_netdevice_notifiers net/core/dev.c:2287 [inline]
 register_netdevice+0x16c0/0x1b80 net/core/dev.c:11109
 cfg80211_register_netdevice+0x149/0x2f0 net/wireless/core.c:1490
 ieee80211_if_add+0x119b/0x1780 net/mac80211/iface.c:2225
 ieee80211_register_hw+0x3718/0x42d0 net/mac80211/main.c:1604
 mac80211_hwsim_new_radio+0x2adc/0x4a60 drivers/net/wireless/virtual/mac80211_hwsim.c:5559
 hwsim_new_radio_nl+0xed0/0x2290 drivers/net/wireless/virtual/mac80211_hwsim.c:6243
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb38/0xf00 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 __sys_sendto+0x365/0x4c0 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95074f6dac
Code: ba 56 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 00 57 02 00 48 8b
RSP: 002b:00007ffe66048c60 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f950757f300 RCX: 00007f95074f6dac
RDX: 0000000000000024 RSI: 00007f950757f350 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffe66048cb4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f950757f350 R15: 0000000000000000
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

