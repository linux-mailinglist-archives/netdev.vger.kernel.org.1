Return-Path: <netdev+bounces-248478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BFD094E5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371A7305B1CE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32308359F99;
	Fri,  9 Jan 2026 12:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2533CE9A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960205; cv=none; b=evbTCWc+YcRa/UgZ6PyXJTTAV+ES/mlZJkkYv9iuzRpzuNRoQdfr7wJUGtKQFuwk+7uthZMFkl7h/f4ss4UOYFFAgEfAIDB2zWcBjuoCbAZKCsO3pzbksA8Ubn2Un06mMtctv+Omf0Yfjk3CDC1Z6rBvMSB8BZuayTW70ZLss/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960205; c=relaxed/simple;
	bh=UwTZgAC2ahnRgnL6r3+0rJc8v7w2PpSmTlk6SeQ+AQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oreq/ZqHmbSqa37Wu/Vdp/rL/1RRmhZtxUY+umxLlxl908vi9mLxmoWnIcLjJlL51KuastWpBJBYWF1QpOxj6CGxZUg7PfSU4jR+dGZyNDLc03TbTtwuF9o/kP0mU0H8w0yhm43nut4tsOzl/P9nrMl2s3K5xP8oK+Ja6815oQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c76977192eso17763039a34.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 04:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767960202; x=1768565002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eBqcUKntc/xjXI4MwMmdCQdek13PN01LOI8f78Zq0=;
        b=AofO4eLbeU1xZjP/t6KdoQq+iO+HODQL8VUAXaeS/I5JD896rFf5lOkI8w7Y0t28D5
         Uesre944wye8aMvTFMkrCn+a2d0+dkK1rTnpdEsrEbJXIM9f27WQShgW9kZNxBa/RBtu
         DO7uURkH6grqf8kU1fAtobmH1BOmB+fI8CDrJ/inoIKoQ2PrYLq2NB9MhBodYa1P5wKm
         qN2NBPQ0ycdhFqFG5PQOvSSG+iMvsWJKLqMXyW8BJJlcnOv5mah4t5FsEjebO2M24jyx
         GItGP7Otm4JPRU1EUSnNo9dpbsyBxb+1hILZpeUDKPSTA2lETX1SOANGkavgRBWCgN23
         SQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXIJpEbOXFrWh71xWfyWhFdZKZyxlkrTK7oDzO7vmBxHOyxo5+Z88gOl9lc1xFn0fM355pY1v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VODaty/Y/DjOHJoZ91vfPs62gs1lh0D7COQCiH3Rtl2Qywn7
	D1J+2G+sMRK+jDhPiyQ5dde/6M4WPhtmEqUPCe+Hh6nPbTmnaBe+eDgINexX2KjLbO3vRK9DtwX
	nnarxamjyO2WW2RRW8HCuBIlLTZrAzv7Icx+43vJ1JxzHhZj/1Iqmjrfxksk=
X-Google-Smtp-Source: AGHT+IGw3xu6or5awLAcqCzp2QeOVI3sqbKjV57T7h4He5al++xuLDl2F9HYyJRpGJVHK4kVRTmn8fmMWtvsos1oBF9xNfQsqD4K
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2285:b0:65b:31e2:2e0c with SMTP id
 006d021491bc7-65f54f070e1mr4931163eaf.2.1767960202526; Fri, 09 Jan 2026
 04:03:22 -0800 (PST)
Date: Fri, 09 Jan 2026 04:03:22 -0800
In-Reply-To: <695ff3c8.050a0220.1c677c.03a6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6960ee8a.050a0220.1c677c.03c7.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ipgre_header (4)
From: syzbot <syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bf583a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=7c134e1c3aa3283790b9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1718df92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f7e922580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com

gre1: entered allmulticast mode
skbuff: skb_under_panic: text:ffffffff89ec2b07 len:-1825582908 put:-1825582932 head:ffff888040e65040 data:ffff887fadb68054 tail:0xd8 end:0x180 dev:bond0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5515 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 60 b0 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 6a f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000294e720 EFLAGS: 00010282
RAX: 0000000000000098 RBX: dffffc0000000000 RCX: 52eb4dbabbc3e900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc9000294e487 R09: 1ffff92000529c90
R10: dffffc0000000000 R11: fffff52000529c91 R12: ffff8880125288d0
R13: ffff888040e65040 R14: ffff887fadb68054 R15: 00000000000000d8
FS:  0000555559b63500(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556b723b4950 CR3: 0000000035eaf000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 skb_under_panic net/core/skbuff.c:223 [inline]
 skb_push+0xc3/0xe0 net/core/skbuff.c:2641
 ipgre_header+0x67/0x290 net/ipv4/ip_gre.c:897
 dev_hard_header include/linux/netdevice.h:3436 [inline]
 arp_create+0x3fd/0x990 net/ipv4/arp.c:578
 arp_send_dst net/ipv4/arp.c:314 [inline]
 arp_send+0xa5/0x190 net/ipv4/arp.c:328
 inetdev_send_gratuitous_arp net/ipv4/devinet.c:1571 [inline]
 inetdev_event+0x1156/0x15b0 net/ipv4/devinet.c:1638
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 netif_open+0xfd/0x170 net/core/dev.c:1711
 dev_open+0x125/0x260 net/core/dev_api.c:201
 bond_enslave+0x6ca/0x3ac0 drivers/net/bonding/bond_main.c:1881
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
 rtnl_newlink_create+0x677/0xb00 net/core/rtnetlink.c:3854
 __rtnl_newlink net/core/rtnetlink.c:3957 [inline]
 rtnl_newlink+0x16e7/0x1c90 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febbb38f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc3087d58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007febbb5e5fa0 RCX: 00007febbb38f7c9
RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007febbb413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007febbb5e5fa0 R14: 00007febbb5e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Code: c7 60 b0 6f 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 6a f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000294e720 EFLAGS: 00010282
RAX: 0000000000000098 RBX: dffffc0000000000 RCX: 52eb4dbabbc3e900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc9000294e487 R09: 1ffff92000529c90
R10: dffffc0000000000 R11: fffff52000529c91 R12: ffff8880125288d0
R13: ffff888040e65040 R14: ffff887fadb68054 R15: 00000000000000d8
FS:  0000555559b63500(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e030273048 CR3: 0000000035eaf000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

