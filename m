Return-Path: <netdev+bounces-173166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB2A57A0A
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C53189219F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554C1B414E;
	Sat,  8 Mar 2025 12:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D31A9B2A
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741435285; cv=none; b=p9zj8tk9ucrYsjR3M4f/9MNmPhRtz3HDq/ulJlhbZ7ejV5hkNaLRRpCBtW3GDtfPA+1DJsXWEw5UTfW81t6k6WRAko/O6Ihmm2KaDThzQNhUHB1K2aM3ZaUIKwC1ooxWTgOIt1BhR3yLqfjO9wKm17Rsa1OSki3/dSWAYs3ZM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741435285; c=relaxed/simple;
	bh=oEMB7zmAPtFyW+y3RmDNJpKUSGwYxKw5LrT/CvzxVaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m/sRqqHKEew6V5EdJZ1POW/1We2ocYBABg9cVre6rAuEG0XEfE7KfGsCISkkoXYI7FjQv0T2jKLafs6OBwdyMxDOGHEd76tnoqipQgwvB2qed24+DFaBslUIPkWWqjVhT9u9T8537ALU2ExBlgVIvF8WUxPtHeN1VfJWbu2cQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-84cdae60616so213911039f.3
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 04:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741435283; x=1742040083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FezIzjeURwhhJLh5k3k/9R0bmC8nS2tunASdakojAms=;
        b=pdHQvIV+7mxLWu8ZpHCpEDsHQocTsSJUhzJkFhuMDltOekUecgjdTDy3CSVW3opH7i
         oCZQUPnu/qNwf/WQHsA2P8XNgmMhJTKs/BM96OkS9jW2MddDvoifgTBtXlQcfnQk4uqN
         fjIGiCLdFlt6Pu+LNTdSj4D4leL923BhmosvqLA04uwVDM8C8Zgy3cjm6h//4zpHf3Pd
         UxODUwyKywW0fRTMryiElFIk6HkJJMV5ROvlbmuuK9kANjjzm9YY45ei5qqN6GUmFxle
         98lWM006rI6xsdOG5Ea0tQFt01DUoZc+jF/EuOj/9SU9Gx0RYh8nCrbH8MOV98or9P3R
         Z6PA==
X-Forwarded-Encrypted: i=1; AJvYcCVp18iZKeVVw4Ca+4+W8mpaLErzDtnbkqXwOIxjOsOZwscV0JQ4/+pBwXyPBjzbmwtzUWqV2Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcncplais0T1E4lMS4CWrbqi37c/Qovy6EOw9fWPC5Yq9+d7eq
	rFJ2aRrrgnY5NkQ06kQHEYoVRzOUxVQxOMI0dTunkSUj8a9KMyaz2JUHKjKMUdwNRwbnakzW6NT
	p+mtvutEUszGV9d4LQHpqL2GNtQlU9HEP9fN9U1uQ9qtAkYKbc7icETM=
X-Google-Smtp-Source: AGHT+IHGhbdI4YkXP/VSzNO8c99jmeV/l6LSj9wSD+cDKlAvDa70YmN+4NCf7kxdzUb+uT3zQLRGN1oag5Ez4eSg633/AfxaHry2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3d4:3ac3:4ca2 with SMTP id
 e9e14a558f8ab-3d44196ea56mr76108955ab.16.1741435283065; Sat, 08 Mar 2025
 04:01:23 -0800 (PST)
Date: Sat, 08 Mar 2025 04:01:23 -0800
In-Reply-To: <00000000000086d0e406184c8e78@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc3193.050a0220.14db68.001e.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_pool_cleanup
From: syzbot <syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    21e4543a2e2f Merge tag 'slab-for-6.14-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15db14b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14819878580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13db14b7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-21e4543a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65830427be5d/vmlinux-21e4543a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0e255ba87f2/bzImage-21e4543a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cd82bec15deb/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12dfaa64580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com

smc: removing ib device syz0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5401 at drivers/infiniband/sw/rxe/rxe_pool.c:116 rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116
Modules linked in:
CPU: 0 UID: 0 PID: 5401 Comm: syz-executor270 Not tainted 6.14.0-rc5-syzkaller-00214-g21e4543a2e2f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116
Code: 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 c0 6b 11 f9 48 83 3b 00 75 0b e8 b5 2f aa f8 5b c3 cc cc cc cc e8 aa 2f aa f8 90 <0f> 0b 90 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d63f0e8 EFLAGS: 00010293
RAX: ffffffff8917af46 RBX: ffff88804bc69380 RCX: ffff8880002f8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88804bc69300
RBP: 0000000000000002 R08: ffffffff88f02df3 R09: 1ffff1100978d0ee
R10: dffffc0000000000 R11: ffffffff8915c190 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88804bc68658 R15: dffffc0000000000
FS:  00007fdbc26506c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004bbba000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxe_dealloc+0x33/0x100 drivers/infiniband/sw/rxe/rxe.c:24
 ib_dealloc_device+0x50/0x200 drivers/infiniband/core/device.c:647
 __ib_unregister_device+0x366/0x3d0 drivers/infiniband/core/device.c:1520
 ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1567
 nldev_dellink+0x2c6/0x310 drivers/infiniband/core/nldev.c:1825
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbc26a2489
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdbc2650168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdbc272f4c8 RCX: 00007fdbc26a2489
RDX: 0000000020000000 RSI: 00004000000002c0 RDI: 0000000000000005
RBP: 00007fdbc272f4c0 R08: 00007fdbc26506c0 R09: 0000000000000000
R10: 00007fdbc26506c0 R11: 0000000000000246 R12: 00007fdbc272f4cc
R13: 0000000000000006 R14: 00007ffd776089d0 R15: 00007ffd77608ab8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

