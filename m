Return-Path: <netdev+bounces-109320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF64927E53
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819E3286873
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048213D245;
	Thu,  4 Jul 2024 20:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A80136E17
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126042; cv=none; b=Rs2YVeeEXbGdYCpiTP45Bq3gj42nLbs4prhLU+zURwNs2VSmT+/I+E+tny1FPVJmmkuSNIyCO/xaoREVzUFBxptEcGnxMnq1hfNXLz1Rm2MrKtgvoO0mgMOX/iKuYWt5IdkGtTjcoD9VDE6kU5Y5Al6DU6IhPQmrXoXaA+KiB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126042; c=relaxed/simple;
	bh=S5HqlRk3b/2Q4kQjCtQP6F2tRnwAPUUFU+bMUaAHsoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aqyqHcBQMW7nRkxyghDbVwYyynCZx/He9G5fYXa3MvAA8KLe8qSO//gWkAfZ6AhBeYRGGMFUPW2ChClaEOshbmBfbOtl6UgNAikkQh1wBcCxVnxPFbcKQ9xoxhtpeDz3M9EFUzGuIAULWL3Ahjah81PdSniO6UEdwlxcYVb9r+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so132907639f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 13:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126039; x=1720730839;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHVdTz7dNOJp1MZT9ljgUFnR3O7FBNavr4wLDa+DUo=;
        b=baIQ1JhhBfhAW9gCLzGXfiDQygtczw0ZQoQ4iWCQpEbLRcBt+3dv+sfaXf3AkFztzV
         AKsV4gpO8fAcHlItozDOYrj7pzg+45YS1rMeAAZ8Fq4inxgyRmF9S2+isBLx3vGwoeNh
         lVaHgLoGdWCMSjfWHeukt3MzX8ccs0E2INeGp20X7xH+KQMZALtA9RiGjYL8S/WosQwp
         W3AEqV2A5+j2p0oIDc1h5yhtitbKqN05V2ZY2PB38B+B3OZ6tSpFR5VPYHeOsux8zD4L
         RFrleesZQXCjL5TdW8nIr9CyOtF1fbJFvb9JDc0r4q2WaSn1v0a1F48VMnhzpvYYO8zE
         KufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZRNXebLGSOa9+1pY2PK8bIxwebZ6y5fk7f5BHaP2qcRh7KPz5ryA5uyhev3VP/1qwcK9ZJ8LFylweslck251KwznG0FQ1
X-Gm-Message-State: AOJu0Yw5uDKMgB4gna9J7+lT6WHmP/afE7EnS4AS06Is7d1YHX7JC3A0
	P4m6OGdbxQPZpXgmlJlB35Esamvz2fZt6BEDSSUOO+8UTzKlwxs3BP7R3Z5owtfDBmSg82LCguR
	LqBaEcT8F1GP8jplipZnQhCXuNYfanOTOZcI+JZGEJQIvLHN2aHshFV4=
X-Google-Smtp-Source: AGHT+IH0kCTIvS4rZWt8o3gZK8z59LI0fYO8NQFmNKPoqmFdRaAqg0dEFkYXCHXqs6s9ZCbjJAojzO1riJhiLXaYHM0YNuEq8oJ/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d90:b0:7eb:98cb:d769 with SMTP id
 ca18e2360f4ac-7f66e023d09mr16466839f.3.1720126039669; Thu, 04 Jul 2024
 13:47:19 -0700 (PDT)
Date: Thu, 04 Jul 2024 13:47:19 -0700
In-Reply-To: <000000000000ce42b9061c54d76a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000904fae061c720d44@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (3)
From: syzbot <syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    aa77b1128016 net: dsa: microchip: lan937x: Add error handl..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e4f06e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4644e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108cedc1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c24cba42b8d2/disk-aa77b112.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/988109eb0cd8/vmlinux-aa77b112.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7845e638463/bzImage-aa77b112.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5095 at net/mac80211/rate.c:48 rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Modules linked in:
CPU: 0 PID: 5095 Comm: syz-executor313 Not tainted 6.10.0-rc5-syzkaller-01209-gaa77b1128016 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Code: 00 00 00 e8 1a 72 01 f7 f0 41 80 8d 82 01 00 00 20 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 39 aa 9b f6 90 <0f> 0b 90 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d eb 65 89 e9 80
RSP: 0018:ffffc90003627058 EFLAGS: 00010293
RAX: ffffffff8afa7ce7 RBX: ffff88802262eb98 RCX: ffff88802c188000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8afa7952 R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: ffff8880227d8e20
R13: ffff888021078000 R14: 1ffff1100420f00a R15: 0000000000000000
FS:  0000555575af5380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001080 CR3: 000000001f8c2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_apply_auth_flags+0x1b6/0x410 net/mac80211/cfg.c:1711
 sta_apply_parameters+0xe23/0x1550 net/mac80211/cfg.c:2061
 ieee80211_add_station+0x3da/0x630 net/mac80211/cfg.c:2127
 rdev_add_station+0x11b/0x2b0 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1d53/0x2550 net/wireless/nl80211.c:7683
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f465b7bbb99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe52ee7d48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f465b7bbb99
RDX: 0000000000000000 RSI: 0000000020001080 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000003a28
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

