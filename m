Return-Path: <netdev+bounces-121805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E495EC54
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A6B1C20CA9
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9613D51B;
	Mon, 26 Aug 2024 08:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369513A26B
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662227; cv=none; b=OVor1TlpG0TStOG1AXDlLctyaZzunR4woPnuwtASgztOu0YWCM9vSw6J0AM911W9Cc9lCMXuI8R+PXcfCvMGut19VwbmmAnS8wcId573AWUjzPGFA5yq9IKQqEgqsk0hcZWVxGwZakIRE0D/VPIEYWOhUM517vShTq1isGBYCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662227; c=relaxed/simple;
	bh=EhWaTDBy3rVhP2m7Fx31Arc3l6ptp3Zw9fXE07YKYwI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bvvv3AP+mgsfMlmjHKndVYHTp3qhm8jTOwGFamZOFWrw33uC43TSA/a5sxMQ/CmdzimBKezNMeVy8DJbyMsWzalqoubit3jNBwcz3vwggpNNXThQU4QvpvW4FHw+VesG08dzMBkxrd542rUey84u/y005HHQ9ocCCsH9Ac6C4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2ceca837so47171285ab.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662224; x=1725267024;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7yUeTo6zqHWjvtd+4ClcNVFnrYyq5DCC2QI+v1Yw5s=;
        b=cXPi2LTLnx9snjWieha8pOf4bvxgj9HFZBcInOkU2nTfyRUmaFRvY9gj06MSKyC0nq
         53HQnrVaCcwkWIzJSjfWY8hLS8s2igkzYq7b0IucyBEPPM3I11+gJ/spkynQcVZ327kx
         IA8YCvgtBc5PWTikltW9HCTtfBxSPervE6dQXv8RAJPQfNpe73UICR+7IcW0c+6VsXog
         pMXrBEe1UA6YDue3XYnh1lMqdpmuM6dDiCiFzKHJ3AemctD2KQI0A3FmS0MY0m2Ubf0g
         bcnpAIOhCOZ2O1pHvRPpys166OK/kHn/DzKzpoybab6k/qg6zjUy9dedp4roKOunvsfj
         +JKg==
X-Forwarded-Encrypted: i=1; AJvYcCXyFMddJFD5HtpEgcFoqMGqoeHqkXcMhS1/7/8Y9xczpS6MOAB0g/BMLvdF5a7F0EBoA/QLcFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+5jomiv/NyKDr9t9pogisjiz397uyMcqiJdo2DkIWM3WpxSD
	PyaoWBK+yxniLWynd44lQOnuQ5aqF8FwR8s3XBWAlXcTHKhSw6y3+36J8XKsSRg+8EuE/DpDxg1
	oZR93MVU4RzgRpWPL90CZyfhAG9X2t+K4q4KwHBE1/ARgJgCZ+zd5P+w=
X-Google-Smtp-Source: AGHT+IHj+/aHEvT5p9BzDuaqDFhadCHZ0XU1EUhrPlaUJIcGR2zarMtas2h3av4w3prqJQIq1CjBNup4J4CtZ1k2oJgX2hU2R5eC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39e3c9841edmr7245935ab.2.1724662224605; Mon, 26 Aug 2024
 01:50:24 -0700 (PDT)
Date: Mon, 26 Aug 2024 01:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004168390620923787@google.com>
Subject: [syzbot] [net?] WARNING in ethnl_req_get_phydev
From: syzbot <syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com>
To: andrew@lunn.ch, christophe.leroy@csgroup.eu, danieller@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kory.maincent@bootlin.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1051fa7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113da825980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5f229980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/585e02f7fe7b/disk-f9db28bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9faf5d24900/vmlinux-f9db28bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9df5868ea4f/bzImage-f9db28bb.xz

The issue was bisected to:

commit 31748765bed3fb7cebf4a32b43a6fdf91b9c23de
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Wed Aug 21 15:10:04 2024 +0000

    net: ethtool: pse-pd: Target the command to the requested PHY

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d09047980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10309047980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d09047980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")

------------[ cut here ]------------
RTNL: assertion failed at net/ethtool/netlink.c (218)
WARNING: CPU: 1 PID: 5237 at net/ethtool/netlink.c:218 ethnl_req_get_phydev+0x1f2/0x220 net/ethtool/netlink.c:218
Modules linked in:
CPU: 1 UID: 0 PID: 5237 Comm: syz-executor314 Not tainted 6.11.0-rc4-syzkaller-00565-gf9db28bb09f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:ethnl_req_get_phydev+0x1f2/0x220 net/ethtool/netlink.c:218
Code: cc cc cc cc e8 bf ac ca f7 c6 05 52 01 39 06 01 90 48 c7 c7 00 9b 11 8d 48 c7 c6 80 99 11 8d ba da 00 00 00 e8 9f d3 8c f7 90 <0f> 0b 90 90 e9 4c fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 7e
RSP: 0018:ffffc90003ce7318 EFLAGS: 00010246
RAX: 10ea674e901bf200 RBX: ffffc90003ce73e0 RCX: ffff88802a65bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8155b4d2 R09: 1ffff1101726519a
R10: dffffc0000000000 R11: ffffed101726519b R12: ffffc90003ce75f0
R13: dffffc0000000000 R14: ffff88802cfaf314 R15: ffffc90003ce7740
FS:  0000555586b4c380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001ac0 CR3: 000000002041e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethnl_set_pse_validate+0x88/0x360 net/ethtool/pse-pd.c:230
 ethnl_default_set_doit+0x2b5/0x910 net/ethtool/netlink.c:683
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
RIP: 0033:0x7f7423951f49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffce415058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7423951f49
RDX: 0000000000000000 RSI: 0000000020001ac0 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffce4150b0
R13: 00007f742399f406 R14: 0000000000000003 R15: 00007fffce415090
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

