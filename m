Return-Path: <netdev+bounces-177166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE0A6E226
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766C47A435E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CEC264610;
	Mon, 24 Mar 2025 18:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B35261575
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840433; cv=none; b=WilriTeUBwqdblAqAsmHWiwqN+XFYicva/D5pTCxmH2x+vHZvblOHSSLeE26stLSs1K3XXegtTMCD6yQbH0YpWwFCTVJ4GtpHzuhbCognSAY10UeeZHGRrqwsLiUCmJKJ6zEJ0fclqz0/VR2f4WusIWovHfXFmttZKPgR7jpO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840433; c=relaxed/simple;
	bh=KtlEUCfyuUrw5cIGb23zFW0D0wbr27GwH1908BiJLuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f9C3re9dBY9zE1AFwSEG8xtrAkQ4AyrTQ2nW5xkuij2tRb8M4w6OVeHaAu/Oco9oqBqeB+2MLXsBIrIE6RzL8/Cnp2C0WxJ6fLNpREiELiQXIpVF5CgKuKY86zFWBRs5Ph5/iIBaKUQ36hH+rAyUH1svSIDwjXP9dHs8ss39Aro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85dcaf42b61so967718039f.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 11:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840431; x=1743445231;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfGgeD061v2X9cdK9GBmRLKxw6itSHQzCAu//F++bhs=;
        b=B5BDB4fHV2X2Y+jdC43tSJu0vGK4hZNH5+i68Gfg40yQwf+vob6XJM4Ts4YnruCNwE
         XhaKoWg7rMAvhsfMkDQa89pH/crQyHnn8rFWSUESFxmSoSHQvsLploUBVkeTUNFIDJ0q
         b9QixeF9L1RbyzhkOjlBsUl2yF645KDaWntvl8f43w9Gx3rfNOPaJQIRl2wzbYJT2xNI
         AXMK1OdcGhPxrhZ+HO11X+2ouFwMLOdfg6qdpSmXfjGFlgrElOfY7FWH7Qu8M7NiLYW/
         zioenZbPfHPkWEbIKE1uPveUdR+SOrVAZAFtvqA7PljIatdYHgWZeTPmKK2h5nXEfrPn
         QXfw==
X-Forwarded-Encrypted: i=1; AJvYcCW/nco6LY9tncb1HWmtknFcw4rn0cLT5HKO5waFP18JgYhAWsZjgSOT7jXnDEeDQMCPxWMQG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpGos9idlSa3jtEN3p1H0lB0y3ZmYHHP4e1KgW/YS2vc3H6hr
	tMhbVPBwMRUMY9P/Eq6QD7pnIxLdGjmGwi90Sm7CPtu4YEKf3XoyhBLKhQ9/ST1/Zems5oBAnSh
	Gi+I6Yaah4dBrk7GRmvdaQrzna/7dN9tYh6lVMYZoVQll+XZ7oFxrLF8=
X-Google-Smtp-Source: AGHT+IEix882w6oYG/fF3m+qql5LodKizG2K5f9lH5OYOluq5tD0B5kooSE28HZi4G0BaoKEtAS099GE4nByrxoCughyEXqpQoxM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:3d4:36da:19a1 with SMTP id
 e9e14a558f8ab-3d5961bc1e6mr160971615ab.21.1742840431391; Mon, 24 Mar 2025
 11:20:31 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:20:31 -0700
In-Reply-To: <679b398d.050a0220.48cbc.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1a26f.050a0220.a7ebc.002b.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_prep_channel
From: syzbot <syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    38fec10eb60d Linux 6.14
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114c8198580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b5b6b74098b0ef
dashboard link: https://syzkaller.appspot.com/bug?extid=c90039fcfb40175abe28
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d8a43f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12afbc4c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-38fec10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d34e40d2aad1/vmlinux-38fec10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e290e3747399/bzImage-38fec10e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
wlan1: No basic rates, using min rate instead
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5313 at net/mac80211/mlme.c:1012 ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
WARNING: CPU: 0 PID: 5313 at net/mac80211/mlme.c:1012 ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5667
Modules linked in:
CPU: 0 UID: 0 PID: 5313 Comm: syz-executor339 Not tainted 6.14.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
RIP: 0010:ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5667
Code: c6 05 4f cd 94 04 01 48 c7 c7 37 3b 4b 8d be 78 03 00 00 48 c7 c2 a0 3c 4b 8d e8 70 00 0b f6 e9 7e ca ff ff e8 16 a6 2f f6 90 <0f> 0b 90 48 8b 7c 24 30 e8 e8 5c 8b f6 48 c7 44 24 30 ea ff ff ff
RSP: 0018:ffffc9000d086500 EFLAGS: 00010293
RAX: ffffffff8b9239ba RBX: 0000000000000000 RCX: ffff888000280000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000d086850 R08: ffffffff8b920ed9 R09: ffffffff8b60cbf9
R10: 000000000000000e R11: ffff888000280000 R12: dffffc0000000000
R13: ffff888044136758 R14: ffffc9000d086710 R15: ffffc9000d086750
FS:  00007fab44b026c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fab44b01198 CR3: 0000000043c60000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_prep_connection+0xda1/0x1310 net/mac80211/mlme.c:8539
 ieee80211_mgd_auth+0xedb/0x1750 net/mac80211/mlme.c:8829
 rdev_auth net/wireless/rdev-ops.h:486 [inline]
 cfg80211_mlme_auth+0x59f/0x970 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x601/0xeb0 net/wireless/sme.c:183
 cfg80211_sme_connect net/wireless/sme.c:626 [inline]
 cfg80211_connect+0x190a/0x22f0 net/wireless/sme.c:1525
 nl80211_connect+0x19ec/0x2140 net/wireless/nl80211.c:12242
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb1f/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
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
RIP: 0033:0x7fab44b48de9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fab44b02218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fab44bd2368 RCX: 00007fab44b48de9
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007fab44bd2360 R08: 0000000000000034 R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: 00007fab44b9f294
R13: 0000200000000200 R14: 00002000000001d0 R15: 00002000000001c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

