Return-Path: <netdev+bounces-126272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3021970495
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC868282BA1
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD84683;
	Sun,  8 Sep 2024 01:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD3181
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725757225; cv=none; b=uaiq0OPDVSTvZUSakYjzKNo15QcfiPiVgbVSziHa/M7nfWSySXhXzaD4IUyJJ+TESgnRR6g2VS8xz0qdmIhIBftPieerxcKdZ37OdsEfZWt95aoozYFbFjpifbsNMEKVx0BEAiQ6orXqCfsXobJkRW3pd5qAK0gVmbm9RJx41hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725757225; c=relaxed/simple;
	bh=nN+Xdy6eqP5nBG0WviKyMcsgSxSk912KV85ek1jZnNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k8wSlwYfnGIBX35eFK5RFryiG0EFdGxEo1xuj2OZCq4o1ml5M86DsVHlxh3dq3Lzxd9NADJKkL7rto7c6rwLwTuMLqJ/BCTLRrLYRY4wf4mVjrOcgGXvMZ9y4LdRWuhWb5ez9Iso3kRHUJtkRp9pAyTUti0DYeVWj0Zo0xRJ+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a05009b331so32586975ab.0
        for <netdev@vger.kernel.org>; Sat, 07 Sep 2024 18:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725757223; x=1726362023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le4o9LNhRw5dRCRxm9Zvl+lgrjIbcNn76g7qdenbjhY=;
        b=rBp/bVJfzrxHeOAMoNbx/KJNnhniAJx7v9+VyZ6Ftun1PY/r47hpec5xBbilnfaI9x
         ZfCvlF6Xf7LrT0zRG6MuiV2nl+NdLbdYozCC3ls/V20oy6Cr0B1BxObp102/mX2q7TR6
         oYy5rAxHi2Ge831Hpl/LotnMzLjFWoWBgtSXmnyQEM6HxY0igbGg1wMv3Ba6gLVgjRQh
         fF9Yt6Ixyts9RsxZRp4tQKkTCPQFPrVrEtoRxHkJ0+QpbQk/FvOn8sc17VjFL2KHliyK
         wOYTZTN90TNFoQzAsMOENH6564J8DMKOFIzyngad7nMRYp7UAnZpKHpYEHo9CCCGdG/v
         U6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSGinSOsGPIuPgM8TDLNJPYK6j8PVVw2m7FjAeTMfPYCBAxLO94iOmqWWn0MZjx84Rqvfhqkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIfBkXN+Ow46O6i98v+VxkeGu5oIdTW5QZzYxx3ThluXEURE/
	LISk1LOU9NuQ2lXiTpNwv2KZVdEiC0rkogf4v84uJ9ir16jwBFeVBKwqI6HjDt68BCLbdfCM43d
	bBamlJJj9q/WolCjODr7kpUzysU94E7E737jMKQSkq2KyOeQo0NBD/Xg=
X-Google-Smtp-Source: AGHT+IHRjMQWpg6IH2uXQypexFMtW3rcieDBX/0qB8PLabGDjpHfj5ILKTmT0let7fJ39+AhNtx40ROSrUqrFZoyYUcw0GsLfmdW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3a0:4a63:e7b3 with SMTP id
 e9e14a558f8ab-3a056868d66mr32414835ab.9.1725757222922; Sat, 07 Sep 2024
 18:00:22 -0700 (PDT)
Date: Sat, 07 Sep 2024 18:00:22 -0700
In-Reply-To: <000000000000a45a92061ce6cc7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dbdfe0621912ad7@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (2)
From: syzbot <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1378abc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=1df6ffa7a6274ae264db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e80e00580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1493effb980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb526efe4f45/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a7b8adfc0a8/bzImage-d1f2d51b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000002 R14: 00007ffc64b5c120 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5214 at net/core/dev.c:11568 __dev_change_net_namespace+0x171a/0x1830 net/core/dev.c:11568
Modules linked in:
CPU: 0 UID: 0 PID: 5214 Comm: syz-executor241 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_change_net_namespace+0x171a/0x1830 net/core/dev.c:11568
Code: 01 90 48 c7 c7 40 e2 0c 8d 48 c7 c6 20 e2 0c 8d ba c5 2c 00 00 e8 36 d0 cb f7 90 0f 0b 90 90 e9 54 ea ff ff e8 f7 ab 09 f8 90 <0f> 0b 90 e9 4a fb ff ff e8 e9 ab 09 f8 90 0f 0b 90 e9 d5 fe ff ff
RSP: 0018:ffffc9000314efc0 EFLAGS: 00010293
RAX: ffffffff8989e0b9 RBX: dffffc0000000000 RCX: ffff888034d44880
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc9000314f3f8 R08: ffffffff8989dbf9 R09: 1ffffffff283c909
R10: dffffc0000000000 R11: fffffbfff283c90a R12: ffff888035ac01b8
R13: ffff888035ac0bf0 R14: ffff888035ac0734 R15: 00000000fffffff4
FS:  00005555597a9480(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c5e3e6440 CR3: 0000000048598000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_change_net_namespace include/linux/netdevice.h:3932 [inline]
 cfg802154_switch_netns+0xc8/0x390 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
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
RIP: 0033:0x7fe650790ba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc64b5c098 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc64b5c0b0 RCX: 00007fe650790ba9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 0000000000000002 R08: 00007ffc64b5be36 R09: 00007ffc64b5c0b0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000002 R14: 00007ffc64b5c120 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

