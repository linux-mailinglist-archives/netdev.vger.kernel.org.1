Return-Path: <netdev+bounces-98075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7C8CF1DD
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34FE1F21276
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911231292C4;
	Sat, 25 May 2024 22:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF5138E
	for <netdev@vger.kernel.org>; Sat, 25 May 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716675089; cv=none; b=PmogeP1Pfsii1RczfZXuWesqazpF17/UZRZhI2jY/H3JKviuWde01fNuKfDNJ5NQ2DLQueuqIVtI6GY4SI4TbtvnUopi7sPGFkk+NRH4PFMlMVBPraX5hd7N8jvyBWXsug/Veevco7PFu4PZfEQPWV9RQaoN71MTBc11wga2dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716675089; c=relaxed/simple;
	bh=Ur6Dqeq0an0sbxzY2FE9RISeaqM2GD8B9pxEVjBqYzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SQThmaVT3dqdNhCz0HXUlbptnugBIgKhZILZ1I8KGLBTob5FixA7pP/SEfAH0JdOJq72iNe1wOBtC2oLWrQbHoG4NcG67OafeqB2xepR9jmJpeqxndfG99tpMv6A5zEYaWdxfqKCZkcCwAsFaNzb0AAZvHF+jOcKakFxlJO7Q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e8dc9db8deso125558139f.1
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 15:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716675087; x=1717279887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/zSiWmUCwwFtr8N3mtKOP5EhN+bLIF0RlbPBoqAQQA=;
        b=J0EJeQe0lR25nY8nDv2oIyVWWlyHY2531Dg9j+ZA3I8dkw6nJSQdo0Nyz8Hfhvo2JP
         tWmvdjrj1gx4NoFmfUf38429QeMeTRUXdTa5Bk0XqQ8XZ0rC9LwMLNeET8VNk5My3nS1
         Q8TpQx2a3Nd5fLJWZr5DdNiGkFTfhYcurbPWwBpdFTJFKuKdxhwjzueqqDRjzc0cJ8GR
         e4MkjRodOotyivZUXXLm9q19n+93kcI5tLFMknErIVbKvNC23OiXvu83k/5bZu1vK8PL
         RM98aCKrZe7QZxYFwFh7JjbzIn8spafWXzmrIv1APu3HrpYxrpg9syVohitDegSF/Kkz
         QdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCViesCXVMXL4ArNAgBI3wZW7KhQ8OxXVCGx5p5UAiLHPxtLs8YmSnFh9IqDxJZjfWXL5/mCrbc0rBFiIG+slIYyAYXaH6wW
X-Gm-Message-State: AOJu0Yz7gdhhLGVKwPtK6x+uTscA6bus4O0SXrshrpfEQ2x8iWs6mFk1
	SPG95/4q1heSsq0E1RlUdp1mREf80PS1WQWsx988xR/sYrKG+EshLA+AZxW9AKDAkJpYLjwOwAp
	rTu5DpSGQ0I+V1QJn9Dj9GwHqWmlAt2UjUd25txi9JqA9U75P/O5EZ1c=
X-Google-Smtp-Source: AGHT+IEs8z+X+07dgO7E18/9FA03B9oURp12kahDawJ3tMw3IPK4ANvdQyKYYgpMe3KhoPrxjuF6P004tsJ6KfQ1vL1r/dCnXjcS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9f13:0:b0:488:9e3e:56af with SMTP id
 8926c6da1cb9f-4b03a7f0153mr219154173.1.1716675087366; Sat, 25 May 2024
 15:11:27 -0700 (PDT)
Date: Sat, 25 May 2024 15:11:27 -0700
In-Reply-To: <000000000000fdef8706191a3f7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c70ce206194e906b@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16624572980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f181c8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz-executor.2'.
------------[ cut here ]------------
no supported rates for sta 08:02:11:00:00:01 (0xf, band 0) in rate_mask 0xfff with flags 0x10
WARNING: CPU: 1 PID: 5269 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 1 PID: 5269 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-12071-g66ad4829ddd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 20 90 e1 8c 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 b8 9e 60 f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc9000334eb00 EFLAGS: 00010246
RAX: 50bad2e5ba5ebe00 RBX: ffff88807bf10f44 RCX: ffff88807c4e1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802cd2f2a8 R08: ffffffff815847a2 R09: fffffbfff1c3996c
R10: dffffc0000000000 R11: fffffbfff1c3996c R12: 0000000000000000
R13: 000000000000000c R14: 000000000000000f R15: dffffc0000000000
FS:  00007f8c6eddf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c6edddf78 CR3: 000000007ce9e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rate_control_send_low+0xf9/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_tx_h_rate_ctrl+0xc88/0x1a10 net/mac80211/tx.c:763
 invoke_tx_handlers_late+0xb3/0x18e0 net/mac80211/tx.c:1848
 ieee80211_tx+0x2e3/0x470 net/mac80211/tx.c:1969
 __ieee80211_tx_skb_tid_band+0x4e2/0x610 net/mac80211/tx.c:6103
 ieee80211_tx_skb_tid+0x264/0x420 net/mac80211/tx.c:6131
 ieee80211_mgmt_tx+0x1b46/0x2170 net/mac80211/offchannel.c:989
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0x950/0x16a0 net/wireless/mlme.c:937
 nl80211_tx_mgmt+0xb0d/0x1190 net/wireless/nl80211.c:12651
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8c6e07cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c6eddf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8c6e1abf80 RCX: 00007f8c6e07cee9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f8c6e0c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8c6e1abf80 R15: 00007ffccd0b27a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

