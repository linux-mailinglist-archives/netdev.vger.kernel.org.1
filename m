Return-Path: <netdev+bounces-76893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C986F479
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B151F218AE
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB71B67F;
	Sun,  3 Mar 2024 10:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4392900
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709462898; cv=none; b=eJ2HvZ6E4gijL1XYyJa38BO5sTfilJufUYrIadOb9hUyag8cKyg5vyhDtjQZcbbo75pQ+kgHHFkNXWrJnJ/kCldbNPaAjINsYUtAtGFOfax8oAwzRpuSblKxVJ0AjiJOsmEa0dAegLFDIJL+vH683g/1t4v1jEx3WyBjgQ3cfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709462898; c=relaxed/simple;
	bh=VjuhQGCzGOfzaihRX2JyJ76FsPEOFBeLHPY+5Hq/WRw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=puuaAF1Q3dseyAHyRgk2Je9azk5DiB2KF2czE2y2btc+Ib5agBJOEnQH6ZhffTTq2zrQClxj5cUYr+Xj01ZXVp+lnEjZzTAzJhOMVKISASzL1gcJXGXxD3J1RKhkjnsRL+KCFmvPA6t2fIdOiNs9jpEQRFzjcPxYnuFHRvfDRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c495649efdso475288339f.2
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709462896; x=1710067696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV/zkV9C2v6G1+zSdNLoBMk/XcnewbbvU219oPM9wzo=;
        b=sQqvBEqbFp+CUWu6na7xn/qSBDvUbGsUMuSAC2Q/6FEu4ugCijkR7etE/7YOmzskqI
         TqNT8bBa8TD++JL0E3YdVaCfdDkj/T6GDhq1TmQCWn5UBtmcZySk/mTWyk4eADs7uKE5
         ylrTk6LLudrSSnrBNlqmulkFSrGYv0Xhum21utMbWq8ESBwdpOzWjOJ6v70Qoeaxctgk
         ijoiTLXkK9rvCtkmMxX3daL3H6dKAoaTH/GIItBO1VYx71aXOqjZpZrUQjnKSvom2MSK
         EqZ5coE70DOfsDQstq2+gV7B0ViO9DQqrvU6ARBxZEl883b16SKZRqK+sbCciVcpXv6U
         i8RA==
X-Forwarded-Encrypted: i=1; AJvYcCXmKylmw9CWr4ijAtAh8Wx6LwvlRNTKnEzsPBH5vH2avL12zaly7czFeGQc3r6Lm1i8bLQPpkUI5HmTVNZ9EYfKeuQePaOc
X-Gm-Message-State: AOJu0YwjpmVRbvmvtd9HI1lMblj3QpNPMzeWdZzjQvuCGuD+Yi02vUt7
	cNstPe7dZyMd0wS2/vW94/ZEbxlzvjwKsiZU478ukqlbaS+t5i4lpdZ5c6ug1ozGhmmdRJnwzy5
	WwajjQZJw8kX5XJRR2iMoy1l6adSFtcp0G2brQyYRLKh0EVqOlkSjBCw=
X-Google-Smtp-Source: AGHT+IHQRAaAzXWtAlHHXRq3FoQG0Pu2gvokhMpmLxgURuAWvd1ROW62KNKw88NbXloTj/U16U80J53/2ZZuXL510i8T6Lb2u6bw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348c:b0:474:e855:df7a with SMTP id
 t12-20020a056638348c00b00474e855df7amr54497jal.5.1709462896666; Sun, 03 Mar
 2024 02:48:16 -0800 (PST)
Date: Sun, 03 Mar 2024 02:48:16 -0800
In-Reply-To: <000000000000903473060e875e9e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b69bf20612bf586e@google.com>
Subject: Re: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
From: syzbot <syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ccc1a2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12918b32180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b3efac180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
 __netdev_start_xmit include/linux/netdevice.h:4980 [inline]
 netdev_start_xmit include/linux/netdevice.h:4994 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
 __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 raw_sendmsg+0x64e/0xc10 net/ieee802154/socket.c:299
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x352/0x790 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1296 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
 sock_alloc_send_skb include/net/sock.h:1855 [inline]
 raw_sendmsg+0x367/0xc10 net/ieee802154/socket.c:282
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5044 Comm: syz-executor263 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

