Return-Path: <netdev+bounces-161602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42056A229A1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58937A2F80
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DA1A8F74;
	Thu, 30 Jan 2025 08:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E9148832
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226063; cv=none; b=CDwv+6HvU8NLALjOUbQHS24tumCHkCzCKzELuS7eH2ciUwpPaMYKBEj9Tq4ehHGHQiC+ONskGQUytNDkfhSqslWkA1cyjIIEbntF/jxogZ6EYhOvfAojzds88ft6I6Q8COk5TCbmL/uTg6HNXlmgoP6NXqojkEYiUEp9nzYAYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226063; c=relaxed/simple;
	bh=wR+Z6K1GgOLuF+lGSInZHWuV82Wfi8tZE152oYjdFsw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OD6CcArS6zh5ubj4jhgS4zk2VFNVHyD7nUmQC5xA9D73sZu25wiS1Su+z9x0c4rxQ/oWYN/nDMeGU4HDb1yNltcKQekLv+SER7vfR05Vm0KE0ZEsTkwjQc18PmtYmqbxrroqQ12+6osQ9h4uFDwYPrPpU9h9BD4ryQ2H9Ik/Mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cfe0ce0dbbso8115435ab.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738226061; x=1738830861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ/o4/b6Ex4RAzVYvoOkrNxkjEsseTNCeqYnPshcqow=;
        b=qOw2TTErgRcFmrhkAPOJL7JrOAsoPT6zt5fMdFq6k0vQ2Q3PKisUcXP4CD+/NclxjC
         Se8alI25G3DZ+WoaBg7gRd4tn6BNgXPcjH6Bt83SSiy3CSEf4VEhzKxIq4pK+9Dbp/9I
         7sDx2R0ZhGbs5yC2ZqkBMWu1yhPrUYBchQQd1+j1EVTZI7k+2yrC1m7SRcO1093WJyT0
         ZNPw4dWGjuMENmU+IXtgmWnTVhjjeLvAFX/qovll6L9wd1za2DO1iIGqeJc5Nub211TU
         dMNyZv3H/BKkRdNeGepFcYn7TF27kyI3BKNFvKdw1MZ5oaBKNC4SBMk/rKZUyp+K+teP
         mH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTvbQ+24t9BdHHTQNsDNTfr3LN6+5X5HxLypXa/rTtCYw1pcBMXbqwK/mMWGmN/nRznETGf+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrD52vNxoolHvWYGedSzD9RLDAfdZW6geQICzVXnRsIjXNL1kv
	k3nwh9RDzgj1Qea1191LPaEyRAarJI5454G0Iqmli2OcjH6YJ4LXo5cbdvhNq8NWmla1faB9nrK
	ww4ceogPJyctGEWQI4ltYr7VMiL5y/ju020xXC2db4DIpgilJwRu7Vpg=
X-Google-Smtp-Source: AGHT+IG0zbLTMwlsYNF9aK6Ma79fu3b0ZtPLHtGzfC+iMAq9WW2j2Ex60YLgFoNd4Gt2cIvQsYevSPvpuoJys8ZWxepfTvyPew6K
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:3cf:fcc4:eff9 with SMTP id
 e9e14a558f8ab-3cffe3e5dbemr58975175ab.8.1738226061121; Thu, 30 Jan 2025
 00:34:21 -0800 (PST)
Date: Thu, 30 Jan 2025 00:34:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679b398d.050a0220.48cbc.0004.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_prep_channel
From: syzbot <syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    805ba04cb7cc Merge tag 'mips_6.14' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d3ae24580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d796da73b2f708c
dashboard link: https://syzkaller.appspot.com/bug?extid=c90039fcfb40175abe28
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-805ba04c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85ee30d862e7/vmlinux-805ba04c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fcbe505a48e/bzImage-805ba04c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com

wg2: entered promiscuous mode
wg2: entered allmulticast mode
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
loop0: detected capacity change from 0 to 40427
F2FS-fs (loop0): Unrecognized mount option "activR_logs=6" or missing value
loop0: detected capacity change from 0 to 65536
XFS (loop0): Mounting V5 Filesystem 9b7348e5-2fa0-41a5-9526-c53a678b01f3
XFS (loop0): Torn write (CRC failure) detected at log block 0x10. Truncating head block from 0x12.
XFS (loop0): Tail block (0x10000) overwrite detected. Updated to 0x0
XFS (loop0): Corruption warning: Metadata has LSN (1:48) ahead of current LSN (1:16). Please unmount and run xfs_repair (>= v4.3) to resolve.
XFS (loop0): log mount/recovery failed: error -22
XFS (loop0): log mount failed
wlan1: No basic rates, using min rate instead
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5314 at net/mac80211/mlme.c:1012 ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
WARNING: CPU: 0 PID: 5314 at net/mac80211/mlme.c:1012 ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5666
Modules linked in:
CPU: 0 UID: 0 PID: 5314 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-08291-g805ba04cb7cc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
RIP: 0010:ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5666
Code: c6 05 e7 7e 87 04 01 48 c7 c7 77 8d 29 8d be 78 03 00 00 48 c7 c2 60 8e 29 8d e8 50 1c 1d f6 e9 7e ca ff ff e8 76 4d 41 f6 90 <0f> 0b 90 48 8b 7c 24 30 e8 a8 69 9c f6 48 c7 44 24 30 ea ff ff ff
RSP: 0018:ffffc9000d3f6540 EFLAGS: 00010283
RAX: ffffffff8b7e1f5a RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e91a000 RSI: 00000000000008be RDI: 00000000000008bf
RBP: ffffc9000d3f6890 R08: ffffffff8b7df479 R09: ffffffff8b50af99
R10: 000000000000000e R11: ffff88801cd5a440 R12: dffffc0000000000
R13: ffff88805317a758 R14: ffffc9000d3f6750 R15: ffffc9000d3f6790
FS:  00007f4f4434a6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ab7f95ed8 CR3: 0000000041010000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_prep_connection+0xda1/0x1310 net/mac80211/mlme.c:8538
 ieee80211_mgd_auth+0xcec/0x1480 net/mac80211/mlme.c:8828
 rdev_auth net/wireless/rdev-ops.h:486 [inline]
 cfg80211_mlme_auth+0x59f/0x970 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x601/0xeb0 net/wireless/sme.c:183
 cfg80211_sme_connect net/wireless/sme.c:626 [inline]
 cfg80211_connect+0x1486/0x1d10 net/wireless/sme.c:1525
 nl80211_connect+0x188f/0x1fe0 net/wireless/nl80211.c:12236
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:713 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:728
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2568
 ___sys_sendmsg net/socket.c:2622 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2654
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f4358cd29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f4434a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4f437a5fa0 RCX: 00007f4f4358cd29
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000008
RBP: 00007f4f4360e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4f437a5fa0 R15: 00007ffdba3bb598
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

