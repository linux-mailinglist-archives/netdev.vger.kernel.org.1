Return-Path: <netdev+bounces-128900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2344297C601
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC2B2101E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91D198E9E;
	Thu, 19 Sep 2024 08:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81920198E89
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735164; cv=none; b=Vzge+rx7bY4do9p1V6FveotgA5N3mqvQGoRxS/MzVSjKVWcTYuP29wUZTY5o8qbwIPpNQfilF0K4gvKjKnsnZUmUIi2/rY0O7WH9ZMdSg955pfhhX9Vs7EFQe/aDCdCtXXJLidICUsg+v9KG3/+56rC8fL9qMxodw/ecrIUWKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735164; c=relaxed/simple;
	bh=kYwCv5sv9KfvCJBn26jDnLgU0bUWbl04Vg+RVZhMsq0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EFpebU5kxrTHQUgSqGO8pWiIHysRGFcOAOPg20x9eTy2SOGO2WxZjiGKsgENxZ3bHlEsRBl6TCkPzaStwNEbdBAtrtAD8KPxJw5OFIG8sGg/RCj9i9DsXZDdEasdsiTUow0eLnuYPxcnqIaInQC118tueZLs1e2khwZE4A1LZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda2c8997so92476039f.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735161; x=1727339961;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CucrDLGCr3HZQj1ivHANWlKFBdFmj2G9jQkJWNHp3E0=;
        b=uM5+gpVLqxzCOK7mAkV6mN/U29SbgXh7o8MLdbBTgpSgD2ygHRg9fYln/h9MY4LYKj
         nNN2BDGSWBC2vkV1yCLRidXG3NCveeiEGOko/G8l23+8nUXo1EnMI/IIMtaeKYT9Wl4F
         0sLKh5RxiCW6JPm9YiNpFH4A6FIK7pU6SZfnCpf3TpezIQbp/GCuuBaaG2dUiim0n4md
         WKR+iaAsa0vg4aS2Q41KxhFpWIFUvd0aMyyBgDixLZGLsrd727lqlZpHhFCxt5lOMgNM
         TfpPYQehz0sVU3CKVTZ3FaON/70AtnxGWV48WUBgXA2Q2Z7FjRyd5d3xT9dzGrzArPX7
         K1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWT0JQI2vrcju9b0V5R/sSpX/D/Ils8UKRc54kHB3B0rYgrbXA4WoOpOTRAoYWHZHa+jhzwd6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMN0RXk41lUZuhdD0AXXepN6djKXryQcz6qyUetkBn6Jfv+K4s
	U7u2N16Tv+neseh0W9S3ISGxp/FssK8jozPLbkieHsGtpGNGG/IEVAkW5gpRgLDwrLAJ6wVUtyG
	mKvCLakhxPTBfxM/HJRdzZSb3LFZ1ZceppJmNYcWAukCWohz0mq7NL4Q=
X-Google-Smtp-Source: AGHT+IFyXUIAtOAnGeh/qnZ3ls62nIdTiNrkuckDdCk8ZtOLGaUIB51FPjIKE35rMa8pLsoe5wwF3Pli+4cCPVSAol/+YPKzk5Ah
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc5:b0:3a0:9b0c:6b2c with SMTP id
 e9e14a558f8ab-3a09b0c6c78mr158550055ab.18.1726735161575; Thu, 19 Sep 2024
 01:39:21 -0700 (PDT)
Date: Thu, 19 Sep 2024 01:39:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ebe339.050a0220.92ef1.0018.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in team_priority_option_set (2)
From: syzbot <syzbot+5d4949ba4b4e3cd4ce75@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36f6b72cb855 Merge tag 'linux-can-fixes-for-6.11-20240912'..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1474f49f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=5d4949ba4b4e3cd4ce75
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b17d84e12326/disk-36f6b72c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/510692f0040b/vmlinux-36f6b72c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcf62c7b4234/bzImage-36f6b72c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d4949ba4b4e3cd4ce75@syzkaller.appspotmail.com

list_del corruption, ffff8880299f0480->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 13501 Comm: syz.3.2331 Not tainted 6.11.0-rc7-syzkaller-00103-g36f6b72cb855 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 1f 8a fc 06 90 0f 0b 48 c7 c7 20 93 60 8c 4c 89 fe e8 0d 8a fc 06 90 0f 0b 48 c7 c7 80 93 60 8c 4c 89 fe e8 fb 89 fc 06 90 <0f> 0b 48 c7 c7 e0 93 60 8c 4c 89 fe 48 89 d9 e8 e6 89 fc 06 90 0f
RSP: 0018:ffffc90002fb71c0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: b60106a26df02a00
RDX: ffffc9000a214000 RSI: 0000000000003e3c RDI: 0000000000003e3d
RBP: ffff8880299f0480 R08: ffffffff817401bc R09: fffffbfff1cfa0e0
R10: dffffc0000000000 R11: fffffbfff1cfa0e0 R12: dffffc0000000000
R13: ffff8880299f0400 R14: ffff888067894e20 R15: ffff8880299f0480
FS:  00007fdb7e7586c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70cda0ef98 CR3: 0000000058d50000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 __team_queue_override_port_del drivers/net/team/team_core.c:825 [inline]
 team_queue_override_port_prio_changed drivers/net/team/team_core.c:882 [inline]
 team_priority_option_set+0x164/0x7d0 drivers/net/team/team_core.c:1520
 team_option_set drivers/net/team/team_core.c:375 [inline]
 team_nl_options_set_doit+0xa18/0x1090 drivers/net/team/team_core.c:2650
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb7d97def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb7e758038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdb7db35f80 RCX: 00007fdb7d97def9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007fdb7d9f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdb7db35f80 R15: 00007fff8cc9fa38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 1f 8a fc 06 90 0f 0b 48 c7 c7 20 93 60 8c 4c 89 fe e8 0d 8a fc 06 90 0f 0b 48 c7 c7 80 93 60 8c 4c 89 fe e8 fb 89 fc 06 90 <0f> 0b 48 c7 c7 e0 93 60 8c 4c 89 fe 48 89 d9 e8 e6 89 fc 06 90 0f
RSP: 0018:ffffc90002fb71c0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: b60106a26df02a00
RDX: ffffc9000a214000 RSI: 0000000000003e3c RDI: 0000000000003e3d
RBP: ffff8880299f0480 R08: ffffffff817401bc R09: fffffbfff1cfa0e0
R10: dffffc0000000000 R11: fffffbfff1cfa0e0 R12: dffffc0000000000
R13: ffff8880299f0400 R14: ffff888067894e20 R15: ffff8880299f0480
FS:  00007fdb7e7586c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70cda0ef98 CR3: 0000000058d50000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

