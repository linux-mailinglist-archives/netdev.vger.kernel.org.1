Return-Path: <netdev+bounces-189770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC2AB39DA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD24188DEC8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B251DDC1D;
	Mon, 12 May 2025 13:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8E1DACA1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058250; cv=none; b=UEwbNsXgJ8OSJR3u1zAhLceRSHXqwpmNTknE9aquKWY1qXlKt/6zBlZIucLllHn0kqoTDYxgFjpjOIB7x+lFkbzkIF7K8p32akYqVIDrK6CJCphK/2jsEyZfPPSt48WhGBLnD/QnNTduyEgST3slzDDGO2AdrFBoKru7FLPNSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058250; c=relaxed/simple;
	bh=7RAlISt8/E2mtYY1m8sG1WhEzq6hte6h11oIGnvZSlo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Irno5923Yo4k7QSsJOOykyhPblgakppJF68Qhi5QtiBRSXtlSIp1XeGoiCxCzlmvykmELHdXhP36ayhVd7DpypbkiK1OUDmtcVdjc577aHSEWwq1Wv/Q8JHYZ8whp5C3+hk4FACtS6uLrJGHBNFrbnhT9NEMbHN4GeJeDGIf7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d6c613bd79so44011115ab.2
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 06:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058248; x=1747663048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qEldaJQrN1XLSdI/YZ+WwSugx3cmBfgPCd9rN1E+8Y=;
        b=sXQ8hEFwt9JHv2KbANw8/e7l0tnaKbaUi/TUBEsf+Ejp7aogKVj5IMidume/TQuexw
         6WzE7ByEqier05yBFcUrvFPGjrKoqiJfhmdfFavLlIhW5jayLHN//HWgB/Iu9mfIcNaS
         wGGrNkEfbd2xLJHaoHqJpUfTmZ6fsL2GzSqXL0C/D/i4jAEq3Y31XWJtJ+JJBUw+zKVI
         NAxkNY5aGRufWGzFHF1J3AQJxOjEcr9FMyVLLpenYSQ67hs9b9unEUUf+W2fZzrlJJN7
         i+9a1M1eAkqD1rUl+2QitZomFBqcQklFgVkZWO6LUe7OkDmogx8B/XJHCevNmVfBAMGA
         4Atg==
X-Forwarded-Encrypted: i=1; AJvYcCWKJIH+uDQn6J0wsJYa5HUJk1frgerFUgx7d3dsexAYH9+y1tGYRW+NJr7hTGB0lOUoxf5mQQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5tGCmWXVFtH385UlGHu+O/jRQK87jOG+ENqcqzVQOIxOcQF3
	5UGol29DpKoVqhUMC2rCisH3Hb0S6i11L2DQ609JMewD6L6MXNlk1LwdMPN3QKYrxQ/L3VgLsPj
	XU2MOjhAGuLuzP1WA9olpGwC5hnp+z7gTDgytNqudWvJ+trJh+80G9lI=
X-Google-Smtp-Source: AGHT+IH/Oyi5JeTmBjORfU3yO+4b8SgajjuQWgF+82RhcxjkDnIy4C73RhL8Jai9ANy2dzU1rGCya6P2yKiINqQrEMlUlHgC9wAH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3d5:890b:d9df with SMTP id
 e9e14a558f8ab-3da7e20d8a3mr137789365ab.15.1747058248293; Mon, 12 May 2025
 06:57:28 -0700 (PDT)
Date: Mon, 12 May 2025 06:57:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821fe48.050a0220.f2294.0065.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper
From: syzbot <syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d76bb1ebb558 Merge tag 'erofs-for-6.15-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17814670580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c351a0f6229e67
dashboard link: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1744c4d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a5e4f4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d76bb1eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21f7d4121801/vmlinux-d76bb1eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/453c9d554035/bzImage-d76bb1eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5415 at net/mac80211/tdls.c:1461 ieee80211_tdls_oper+0x364/0x640 net/mac80211/tdls.c:1460
Modules linked in:
CPU: 0 UID: 0 PID: 5415 Comm: syz-executor228 Not tainted 6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_tdls_oper+0x364/0x640 net/mac80211/tdls.c:1460
Code: 6f 01 00 00 e8 4d 83 d7 f6 eb 22 e8 46 83 d7 f6 4c 89 e2 eb 21 e8 3c 83 d7 f6 b8 bd ff ff ff e9 1c fe ff ff e8 2d 83 d7 f6 90 <0f> 0b 90 4c 8b 7c 24 08 48 8b 14 24 4d 8d a7 2a 1d 00 00 4c 89 e0
RSP: 0018:ffffc9000d3d7380 EFLAGS: 00010293
RAX: ffffffff8ae84d23 RBX: dffffc0000000000 RCX: ffff88801f6f4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8880435d8187 R09: 1ffff110086bb030
R10: dffffc0000000000 R11: ffffed10086bb031 R12: ffff888044381d2e
R13: ffff888044380d80 R14: 1ffff110088702e4 R15: 0000000000000000
FS:  000055556871b380(0000) GS:ffff88808d6cb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff650f3fe8 CR3: 000000001e235000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rdev_tdls_oper net/wireless/rdev-ops.h:940 [inline]
 nl80211_tdls_oper+0x282/0x440 net/wireless/nl80211.c:12586
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
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
RIP: 0033:0x7f1c4a288aa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff650f5058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1c4a288aa9
RDX: 00000000000000c0 RSI: 0000200000000240 RDI: 0000000000000003
RBP: 0000200000000240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
R13: 00002000000001c8 R14: 00007fff650f508c R15: 0000200000000188
 </TASK>


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

