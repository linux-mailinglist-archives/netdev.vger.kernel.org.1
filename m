Return-Path: <netdev+bounces-169804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB8A45C36
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9C3A6D94
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAB254AE7;
	Wed, 26 Feb 2025 10:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA626B098
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567262; cv=none; b=k3JQm9THGNt6kGPwHi9opRKC9Jt6VZBDwpSIi+6xtI9SoF3sRlyPj/tJx967rYOpgmhgqr49knwwMGXYtvcXqzL9iL3rW22LmBLDp3ucT8lOgbuEw1tzKS9cYxcXW5LjniAlcWhvnt02FM/E/80/EBAO6IbTh55pAjdoiP4d34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567262; c=relaxed/simple;
	bh=Qs2eopeLtj6FqaBsS/f9Lvq9GwF7fXrRnRy9gdlOVDw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pJNnvqjL8ULOgTs2BH54qzT/qa1CzxKyVdrZZqDj8/A/XE73381fWkWX+UE9T6IxWrZRVhmynNXBQU59EkLi3/XOZ/6BTgCXH1Q5gf4u6CgNARghivkE+LG9bZoCtjJvO9AlSxrMktKm3D5jvXyEoRnEjCVBCxHrIJiWT4HIpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso51840005ab.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740567260; x=1741172060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ywVTkBOTGXpD4dtX6/3aeHzuNHi338K7wvDLA2azj8=;
        b=fJ8NlL+3T+8zcNOnBWmgNbKO+HdYE5HbeSR97YpB8CP460RezFuIiSBoxXFg3ovK+K
         Q99qwy67zHdyUN1aTfAU1HY7xx9za7uonLg9KacC6VYUtWcKsD7Gmq/3HIX29KEgJmil
         cvGcbhDCBmw3GCCqV2rf6IaRZv+kJlvXY4UPsIHcYTwMbt1XhcgFtSCsgYyg52RTk4AL
         6hsnItw7qBY9jX3vNctIcEcQwqT5QXnzywhH4dkdbzsE6meEyCf5dtwlsCXbmTgANLwk
         2hsNGc64Bq59tB42R7Sxb9YBymtgiF1mTHMZ/d3QEuVNXJGKEeud/MiPNrUSoWtXxvRW
         JC5g==
X-Forwarded-Encrypted: i=1; AJvYcCXQo9Z2iSmGAPVE9tU7OW/lpUjhE2/+x8b2+01fbMrV1RJ5jQ3VHpYdtwEaWb1YyGrGYEq+cLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7siTV5WLCSiUsCZW1M5Ki+7cTMQ2KlXQvwDDK8yLtE8lJ5rh
	7OdhjOmb1ENHfoMyUIZD/DW/+ygk3nNjZaZ3B0b3AQnjl86R8ucj1qF00uo8zStffu6vMrsKDBI
	1/e4j/4RKCpGNel/5b4pPNKMAU4oAlRmlwB29Lma0DufBzZ9AAC3ilqI=
X-Google-Smtp-Source: AGHT+IF8gLd4yzsv1WPHl52n1M8hACs+R+LGrr6hGH0ZFK52nrRI7fUoPV6viMHZct4cOmlyoMGezzjmXyyVoIK1u1F2nsklBAC9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3d1:966c:fc8c with SMTP id
 e9e14a558f8ab-3d2cb514b1emr187392555ab.17.1740567260091; Wed, 26 Feb 2025
 02:54:20 -0800 (PST)
Date: Wed, 26 Feb 2025 02:54:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bef2dc.050a0220.38b081.00f9.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_disassoc
From: syzbot <syzbot+91d7214a5ebebe3792cf@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b73498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=91d7214a5ebebe3792cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91d7214a5ebebe3792cf@syzkaller.appspotmail.com

wlan1: deauthenticating from 08:02:11:00:00:00 by local choice (Reason: 3=DEAUTH_LEAVING)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 18257 at net/mac80211/mlme.c:3920 ieee80211_set_disassoc+0x1177/0x1620 net/mac80211/mlme.c:3920
Modules linked in:
CPU: 0 UID: 0 PID: 18257 Comm: kworker/u8:17 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
RIP: 0010:ieee80211_set_disassoc+0x1177/0x1620 net/mac80211/mlme.c:3920
Code: 00 00 00 48 3b 84 24 a0 00 00 00 0f 85 b1 04 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 2a 4b 2d f6 90 <0f> 0b 90 eb b4 e8 1f 4b 2d f6 90 0f 0b 90 eb a9 e8 14 4b 2d f6 90
RSP: 0018:ffffc9000b7aed20 EFLAGS: 00010293
RAX: ffffffff8b94b3b6 RBX: 0000000000000001 RCX: ffff88802ff78000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000b7aee10 R08: ffffffff8b94a435 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88804fc70d80 R15: ffffc9000b7aeda8
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f651f2d7d60 CR3: 0000000068174000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_mgd_deauth+0xa88/0x1080 net/mac80211/mlme.c:9754
 rdev_deauth net/wireless/rdev-ops.h:509 [inline]
 cfg80211_mlme_deauth+0x582/0x930 net/wireless/mlme.c:519
 cfg80211_sme_disconnect net/wireless/sme.c:667 [inline]
 cfg80211_disconnect+0x3e7/0x7e0 net/wireless/sme.c:1557
 cfg80211_netdev_notifier_call+0x1ba/0x1490 net/wireless/core.c:1540
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2180 [inline]
 call_netdevice_notifiers net/core/dev.c:2194 [inline]
 __dev_close_many+0x145/0x350 net/core/dev.c:1663
 dev_close_many+0x24e/0x4c0 net/core/dev.c:1714
 dev_close+0x1c0/0x2c0 net/core/dev.c:1740
 cfg80211_shutdown_all_interfaces+0xbb/0x1d0 net/wireless/core.c:277
 ieee80211_remove_interfaces+0x108/0x700 net/mac80211/iface.c:2285
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1681
 mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5665
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6545
 ops_exit_list net/core/net_namespace.c:172 [inline]
 cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

