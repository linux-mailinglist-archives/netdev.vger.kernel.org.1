Return-Path: <netdev+bounces-201407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21011AE955F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5808E17ED10
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7421CA00;
	Thu, 26 Jun 2025 05:52:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1991991DD
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917148; cv=none; b=B1F+NA3TzRoj0ifuprL3wIpsGuKMKz5lhoB3q1NSkIl/xEo6/z2byoqsaTuRx9mUkszklNWZU5tnkmUlQDNw6ZMby7UMX2QgqOgTl6ndpsX51KJsJdmZrHbwWJ3HjN1XhMoxHyYvnMR5pTIVMFDfkd/jZFYa8sGXVWvO0m8FmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917148; c=relaxed/simple;
	bh=RXMbzcQSoJKE9ykFfb2yTRmmHDkT4qUAGkezzIxwoGQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fXna0Tejty/ZdG+Gqmt4LVuM1A3/cnscPWspQMaLp74LH7xbiGyWAGiZFUY9r3/vyshC73ypYNuwQqf76HD+5M7d7+Xm2bX15NBMr3Fbiy228RVAaybPmqzxIhqJXXDet+3MzrLnzfmbowQgNEqpRJX4wu7NhhPJd3UTByRUdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso14039585ab.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750917146; x=1751521946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5qIX76GQbLAMhtK3yhwLgQO2r1QVdiLVxVs2+RE5IU=;
        b=IAfDIRKVmBEx8TZfdhyuSiwzhrFL7/lJIpiOGV7RNtodm+uBSIMeCmCQouispIiE+r
         9y2mzCIInMbbwh0kyMzm/cj54mQ0YPfX1OQuPbjtq3oAQDxjULn8bu5RJaHXNhy+cc6q
         cjWhfyIqQNZI6LYE1ek0NcRBKpgJdJPgBsP306UUY0M6rijb+GCH58djBLu3O/9Ao9qQ
         6KeXd9jfekt2qq4E2VstUDdKOEGO8z59E0yrxezdNJhML/mjPWmU1kF1lRXc/ja1hKoV
         Sjgu9UmUeKZz/wBOV88QSIfj2e9E0wTjDHjUPKmfg7NXbBzEyxxjVlzJ/omR8U8K7oas
         x5MA==
X-Forwarded-Encrypted: i=1; AJvYcCVe5kTzZgDr4+7JYsEdCEMGoB4Hz/1anWN6hSFJ9JGQWxHwrMGrxoyay+5DW3B6NSk8y4/QEvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYS3NGUVPln1iDgRGoA9QZuVn1Gk+TbaLbdw6nrfleNmv7jl9/
	MHKyDJ6cPEOukYqtA1mhGxQ2/upBxuap5ZiXo2Z2oZse9nHlhRtKSUkH1Mu+tbEZJqDemJs9Wna
	Uh1fjfNf86afMjjM3590qu4wINC5zG7+2VJmHW9lUm+8tdCOB3Ae+eXTkXDE=
X-Google-Smtp-Source: AGHT+IGnrS8TsKVt529lc+6pBcoL3p7g8LigqVs4S/xvSHpZFqi2lf+RJCFFbk66jG0XyxAtgx6e0rPjL1dK/D1fm4OZL9G5p1kl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440c:10b0:3df:3464:ab86 with SMTP id
 e9e14a558f8ab-3df3464ae71mr42358045ab.9.1750917145864; Wed, 25 Jun 2025
 22:52:25 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685ce019.a00a0220.2e5631.0206.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in _ieee80211_sta_cur_vht_bw
From: syzbot <syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    010c40c1f50e Merge tag 'wireless-2025-06-25' of https://gi..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10825b70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=ededba317ddeca8b3f08
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb94516e5d57/disk-010c40c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86a8a81b1a19/vmlinux-010c40c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05406e73c0a2/bzImage-010c40c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11521 at ./include/net/mac80211.h:7748 ieee80211_chan_width_to_rx_bw include/net/mac80211.h:7748 [inline]
WARNING: CPU: 0 PID: 11521 at ./include/net/mac80211.h:7748 _ieee80211_sta_cur_vht_bw+0x524/0x6e0 net/mac80211/vht.c:549
Modules linked in:
CPU: 0 UID: 0 PID: 11521 Comm: syz.0.1373 Not tainted 6.16.0-rc2-syzkaller-00185-g010c40c1f50e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ieee80211_chan_width_to_rx_bw include/net/mac80211.h:7748 [inline]
RIP: 0010:_ieee80211_sta_cur_vht_bw+0x524/0x6e0 net/mac80211/vht.c:549
Code: 00 00 00 eb 49 41 83 fd 05 74 30 41 83 fd 0d 75 13 e8 80 ac e5 f6 b8 04 00 00 00 eb 31 e8 74 ac e5 f6 eb 28 e8 6d ac e5 f6 90 <0f> 0b 90 eb 1d e8 62 ac e5 f6 b8 02 00 00 00 eb 13 e8 56 ac e5 f6
RSP: 0018:ffffc90003936f48 EFLAGS: 00010283
RAX: ffffffff8adaafe3 RBX: ffff8880580dc000 RCX: 0000000000080000
RDX: ffffc900049a2000 RSI: 00000000000003aa RDI: 00000000000003ab
RBP: 0000000000000000 R08: ffff888027683c00 R09: 0000000000000007
R10: 000000000000000d R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000007 R14: ffff8880580dc180 R15: 1ffff1100b01b830
FS:  00007f6ba57f66c0(0000) GS:ffff888125c51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000045c0 CR3: 0000000031c9c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_sta_cur_vht_bw net/mac80211/ieee80211_i.h:2229 [inline]
 __ieee80211_vht_handle_opmode+0x3c0/0x850 net/mac80211/vht.c:701
 sta_link_apply_parameters+0xbb8/0xec0 net/mac80211/cfg.c:1965
 sta_apply_parameters+0x944/0x15b0 net/mac80211/cfg.c:2089
 ieee80211_add_station+0x424/0x6a0 net/mac80211/cfg.c:2172
 rdev_add_station+0x105/0x290 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1723/0x1b40 net/wireless/nl80211.c:7843
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ba798e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6ba57f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6ba7bb5fa0 RCX: 00007f6ba798e929
RDX: 0000000000000000 RSI: 0000200000001080 RDI: 0000000000000005
RBP: 00007f6ba7a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6ba7bb5fa0 R15: 00007ffc309021b8
 </TASK>


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

