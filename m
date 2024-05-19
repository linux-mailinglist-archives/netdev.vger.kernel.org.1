Return-Path: <netdev+bounces-97129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C608C9489
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EDAB2108D
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DB4501E;
	Sun, 19 May 2024 11:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEE8BEA
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716119730; cv=none; b=QPP0kS8J3PJNQt68Z+wSeavb7pEThw0hFUODebDOEQgsBdL3PTrt2XTgRr86z69/242X/aiDF5ZrAJHPRgDBbBn1M8hC2hB09WK9aDpcw+1JUKi9rv0aoBeZaxsDM3m6Sam6butEagJSWjm5hSt28MY3K5DayhODUybtnwspffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716119730; c=relaxed/simple;
	bh=oWnoxCvawuaWLbB8LioZ4kisCTLEz7H3drZX1cobng4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uzhVMPxTSWRAYmiVdbmjPOATRKghttUbhaSJIW/rPhrqvGs02vMjnKGPhqSwvCGmJexb5YYa22hWUpSA7hxfRU1veigptqWkwD5JaVq8GZYoGuqzwc7MWN8ytvOeixaMMLgl3kmGfbo0riQ7tdxaFY9RRVB/s5vFIn+9SjuJOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1d56d36b9so955369339f.1
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 04:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716119727; x=1716724527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAXy0C449ay7fAQSK9fA0pxPy/OVTjno3qlAc0Pg59s=;
        b=iuUwODbO2laETR3j5dSjbPaU38S8Bpw3Nn3u0puPbkRcwPMRDUG/9HxP5TSunake95
         cLn/Kt3AVIro5w2U0IONf/rmGjE93TGESXRQK8R1n3bIFSqaoZJwsrPbBpT2S4T9BXPe
         0URWIAEDiET6dWWqFXtK20EeH136qMlKFxJK0xVQt2Y9dHXymqv/uu1JuJ966+s7v7SV
         /SZnIMHfSe+I9/8v/3XyKm/rglohE8sgfybOwv26Mp/BXBZN+WJMXN3wygGA0fJyIU75
         UwzBQjE2TnY6+iOSlDqydenU0ni56PWuXQYigOI4VRIqpizbA4h95kJJOLicclSWjfLN
         9Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYiGfQtFYeIOKO9k5E/nHqnP8qGL91j2iOFYR02xo07zEUccwAdvSy2lgf9CgrNvrUmcW8kloIGmqIqmaPGtoCGGXBfP24
X-Gm-Message-State: AOJu0YzbsRoaC79F6ny0bwoTFoliSm3Noi22Q1w1bkqWwtg1Ifj19OEp
	My1V7jEkhQxgjCIIJIoHQ7Gp1W50FKXe5er8kBdRI6+IkubbuY4WDe1wMYTy+Gn/cvXUyIZQClw
	m3OOAYK+keB6KdtEZfa9DM1wn3+4GKguk9uzrTVWCHjh5voeCe62Kq30=
X-Google-Smtp-Source: AGHT+IHndB6qNyFEh5A5TMeubQ/9aRy0+ccYua3UhtSHRcevP851TxzeCfSkPoUPLpb85xqgxrsIQVcLcr6p1vnfERqchAo/2GzB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4117:b0:48a:341e:2963 with SMTP id
 8926c6da1cb9f-48a341e29c4mr892024173.1.1716119727777; Sun, 19 May 2024
 04:55:27 -0700 (PDT)
Date: Sun, 19 May 2024 04:55:27 -0700
In-Reply-To: <00000000000054bc390618ccb092@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c439230618cd427e@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in minstrel_ht_update_caps
From: syzbot <syzbot+d805aca692aded25f888@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105c75e0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=d805aca692aded25f888
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14044aa4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116335dc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227283491c2c/disk-0450d208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5c9b39757fa/vmlinux-0450d208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ab6928507ba/bzImage-0450d208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d805aca692aded25f888@syzkaller.appspotmail.com

netlink: 32 bytes leftover after parsing attributes in process `syz-executor195'.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5105 at include/net/mac80211.h:6962 rate_lowest_index include/net/mac80211.h:6962 [inline]
WARNING: CPU: 0 PID: 5105 at include/net/mac80211.h:6962 minstrel_ht_update_caps+0x44a/0x17e0 net/mac80211/rc80211_minstrel_ht.c:1733
Modules linked in:
CPU: 0 PID: 5105 Comm: syz-executor195 Not tainted 6.9.0-syzkaller-08995-g0450d2083be6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:rate_lowest_index include/net/mac80211.h:6962 [inline]
RIP: 0010:minstrel_ht_update_caps+0x44a/0x17e0 net/mac80211/rc80211_minstrel_ht.c:1733
Code: da e8 ca bc cf f9 e9 24 ff ff ff e8 80 65 7b f6 eb 17 e8 79 65 7b f6 eb 14 e8 72 65 7b f6 49 c1 fd 38 eb 0c e8 67 65 7b f6 90 <0f> 0b 90 45 31 ed 49 bf 00 00 00 00 00 fc ff df 48 8b 3c 24 4c 8b
RSP: 0018:ffffc90004d76f80 EFLAGS: 00010293
RAX: ffffffff8b1acc49 RBX: 000000000000000c RCX: ffff888022e38000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8b1acb65 R09: ffff888078874008
R10: dffffc0000000000 R11: ffffed100f10ed49 R12: 1ffff1100456e614
R13: 0b00000000000000 R14: ffff888022b730a0 R15: 0100000000000000
FS:  000055557e7c2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001040 CR3: 0000000022a8a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rate_control_rate_init+0x3d1/0x5f0 net/mac80211/rate.c:63
 sta_apply_auth_flags+0x1b6/0x410 net/mac80211/cfg.c:1710
 sta_apply_parameters+0xe20/0x1550 net/mac80211/cfg.c:2043
 ieee80211_add_station+0x3da/0x630 net/mac80211/cfg.c:2109
 rdev_add_station+0x11d/0x2b0 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1d53/0x2550 net/wireless/nl80211.c:7624
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf30f98cd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeba77eb08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdf30f98cd9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

