Return-Path: <netdev+bounces-227895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37EBB9A1F
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57071892D97
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4018DF9D;
	Sun,  5 Oct 2025 17:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE552846F
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759685989; cv=none; b=PJekhbq0kxuMNo27pamA+Dv+Yuc4hagmAYoG0qm9fHe1OkrWvSoLHFaC8xcwh1wOUY3E0topuPLTKxi/jGvQ2AjkNKCB9tOZE/cGJIzyMMzTorGtNN64y+eSaC5AFodLj1fRMW+owAdKyZVPT6QopR9lupVYYl4RXoe2wKCVj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759685989; c=relaxed/simple;
	bh=nGMZlh8YRXJFiwj1WHQWX3DEZ/YTq1nxUfTioYgrzEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jp6s6W+/vm8XQZbJk9+1/aW0eYhwP6g6fWAOvbo9Bg6kCciNX61LYb9TH43FIc5Fy6TPw48RkOIKiAhPP/a0E5KCIGtTEZltoJ4DxZnPAs7rpI+vX/dDrPGjGB+XBCShpg35Jm4MQSBiV1cRazaclErncbfPAng8XH+kxbORjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f67904af6so37033695ab.3
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 10:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759685987; x=1760290787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UM/s2stlbkbjMDBqjadsHrnvi+SIhkGISTSy+AXGwiI=;
        b=lNgAJbJxRYOGOwBWDEQC30SKKIzb7mNcuBnSSHn4x6tmQd1UuIzmXI3R3YjO4APAH3
         bik5qXF0aqVNx6Z5J4qq0DyF/e7gf9ooDakR8jpFJbweARrBtBbAii2RjogL9hnkk1Q6
         +MpKqRo0IwGvRxeOHBy4qxyHvulE3zcceCRtbu3vm2XpU3nl3YtGAdiThoGIf+BI4iNQ
         dN4L2rHcrZORl8j6WLGEzizYC1uky6XN80Pb7wCwC38FYQ5k8Mx4wZydd2dQ22DMYhqj
         x9bCUfQk9ClvTg+iYITqJcWNMEFVnGS2V+HJmZDEQIj6licjxF7jAFbLoJUsl975Bj1F
         b5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVLE6nIJpo8DXnx+7SOgB60mURnrNaku6UhfdhwLgfW9Mw4T/cZnqPcFJuAJhRUK3wFlbt1ssw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizgPdH7xmcXQt/BqhNhIpVySE/JoGok0KlDE1WOX+hiiQ/Z/h
	3XeGJDmsfmb3CJ3G6J0lac5pFkvyw4npaXzFLfC9PqScUiNRT3j4NlKLgDmFgFaqY63hDCBWSeb
	JKnMUPsdopBnn6Pg4N9tiawO3/vCEs0KJ2XKReQUAU3raVfyMV7cKY6hZW8g=
X-Google-Smtp-Source: AGHT+IFdNHa3yHnwgUcHEAKF175+o/JdTd73vogzQbGtwiKpPd5+lgXkDQhfcQyCVNSsI1AtNs52jPtyEfsoAVwu73jso91W3hIE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:42d:7dea:1e09 with SMTP id
 e9e14a558f8ab-42e7ad6ea2fmr120047055ab.21.1759685986895; Sun, 05 Oct 2025
 10:39:46 -0700 (PDT)
Date: Sun, 05 Oct 2025 10:39:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2ad62.a00a0220.2ba410.0018.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm_state_migrate (2)
From: syzbot <syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b946f6bb7d6 selftests/bpf: Fix realloc size in bpf_get_ad..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=13be46e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0ef71bdead6/disk-4b946f6b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c8251d5df12/vmlinux-4b946f6b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29bad3cdad16/bzImage-4b946f6b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 __xfrm_state_destroy net/xfrm/xfrm_state.c:800 [inline]
WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_put include/net/xfrm.h:928 [inline]
WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_migrate+0x13bc/0x1b10 net/xfrm/xfrm_state.c:2165
Modules linked in:
CPU: 0 UID: 0 PID: 30386 Comm: syz.6.7969 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__xfrm_state_destroy net/xfrm/xfrm_state.c:800 [inline]
RIP: 0010:xfrm_state_put include/net/xfrm.h:928 [inline]
RIP: 0010:xfrm_state_migrate+0x13bc/0x1b10 net/xfrm/xfrm_state.c:2165
Code: da fd de f7 90 0f 0b 90 e9 ab fa ff ff e8 cc fd de f7 4c 89 f7 be 03 00 00 00 e8 0f f0 a4 fa e9 77 fb ff ff e8 b5 fd de f7 90 <0f> 0b 90 e9 f6 fe ff ff e8 a7 fd de f7 eb d9 44 89 f1 80 e1 07 38
RSP: 0018:ffffc90003afecc0 EFLAGS: 00010287
RAX: ffffffff89df782b RBX: ffff888029ffc880 RCX: 0000000000080000
RDX: ffffc90020769000 RSI: 0000000000000213 RDI: 0000000000000214
RBP: 0000000000000001 R08: ffff888029ffc8eb R09: 1ffff110053ff91d
R10: dffffc0000000000 R11: ffffed10053ff91e R12: dffffc0000000000
R13: 1ffff9200075fe2a R14: ffff888029ffc8e8 R15: ffff888079932200
FS:  00007fe59aadf6c0(0000) GS:ffff888126373000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c31a411 CR3: 00000000280be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000200000000300
DR3: 0000000000000000 DR6: 00000000ffff0ff1 DR7: 0000000000000600
Call Trace:
 <TASK>
 xfrm_migrate+0xefa/0x2330 net/xfrm/xfrm_policy.c:4669
 xfrm_do_migrate+0x796/0x900 net/xfrm/xfrm_user.c:3144
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2617
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
 __sys_sendmsg net/socket.c:2703 [inline]
 __do_sys_sendmsg net/socket.c:2708 [inline]
 __se_sys_sendmsg net/socket.c:2706 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe599b8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe59aadf038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe599de6090 RCX: 00007fe599b8eec9
RDX: 0000000000042000 RSI: 0000200000000380 RDI: 0000000000000005
RBP: 00007fe599c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe599de6128 R14: 00007fe599de6090 R15: 00007ffdb88a6108
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

