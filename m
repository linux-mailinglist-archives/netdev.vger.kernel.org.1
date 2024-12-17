Return-Path: <netdev+bounces-152673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D39F5544
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2602171E5A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AC1FCFF7;
	Tue, 17 Dec 2024 17:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569691FC7E3
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457704; cv=none; b=qqVs/3qvSTFpA/QG8iQ6FITYoF7dbMT+syJjBSf0nDcPjuCI1rIxvky0A0Yyip64wCTH4lEZhRi4eftrhleze+SO/QlO7mVps5vOX4yK3dlxeOHREgq3TzCycTIkt2nOAiCtM720D5MukE8FrDX4uKUN8Cxi5tO19MYr2IOQEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457704; c=relaxed/simple;
	bh=cCOulBrxMtTYqZ2UiLo7/vUTZR3wTcaNP9GlZI4ZKxY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KToPWKzD6gah1hEmV1z7CDaq7Mc19Uuklfc8wTcYzfCpAjrCsRfOmsQP9LfEQFNkNnM3+Ro4ue3cLNc8aAm5NdlMYQMp/KQ93uXtr4bQuHyZO6k78djsWWww74VeUNG2EUgm7KkrSBxJCjwijWwv51Rl6sM7LR/cEYpOKHdLvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso53454745ab.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457701; x=1735062501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cm3NviY1/Xhe2vIwXw/oIGBuY1ITFav/N10nmHzyjys=;
        b=Iopcet+6JqZwWhhlGkmmLgTHtqxdBJGWY0HRj48/J3sIUsWudjxu17bBLvx0b3yMA4
         C1ZnBsGp6O4wddW50vlZWKCwsNC26Hm5EZCdBQN5WIfGaeSgBScXmmlTBlgzbEo6lmny
         +oqnlsQY/uOTvZTerpAqTs+N0mqOSKP31S5eFUTHFAqsvpEpTZ1Cbn3WZvXalQY2dQ/2
         ZtmACBx/gMjq07IoAknWDo2O6Jy8CfrKVmLx0FDh07rTqhy22Iqx0oAr3WHPtk6E1Lll
         W8b6cKMbtNCoglWt4DAVqz5f7sD0InMfOE76qpc3vl8glo1TsJaUSYGFLGMxEnNv5dtk
         8S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9fl5/sMXnGIC6JVsHhLBJAlmw0kfIUKnz9si21tiRv9ua40UiJIeMu9FD0P4uaNxeKH7fskA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkF4wfR/YopcMHymTPiDlkD+bHTBGaFjMRRDH7hI/jIcyEJHM
	5bzXarXWd6/2lSXpwsI/rTuQwITprZsNv2zAGDVnSE8shdOVe17ZNnb32Xf0c3bMjw7ZePGx5tv
	JU3aDZtBJgg01RPjRpe4nUXUS7shg+XKQMdYUxc6iKK+H1W/6Aw/6iHw=
X-Google-Smtp-Source: AGHT+IGWFX50yNkK+5g5ZsFwdtBDRCOH5RLKE3W+W9I1B9ffC4LSFgsrkozFJlqM66tTyGD6EWzc+52XRiPIV26o/4YAdiF+3FDH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:3a7:c5ff:e698 with SMTP id
 e9e14a558f8ab-3bd803baa26mr4822865ab.0.1734457701638; Tue, 17 Dec 2024
 09:48:21 -0800 (PST)
Date: Tue, 17 Dec 2024 09:48:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b965.050a0220.29fcd0.0072.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in mac80211_hwsim_tx
From: syzbot <syzbot+433ee38d8684adcfbeb9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    429fde2d81bc net: tun: fix tun_napi_alloc_frags()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1017da0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=433ee38d8684adcfbeb9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e1be018333/disk-429fde2d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec564480cb6e/vmlinux-429fde2d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d9902c93ef5/bzImage-429fde2d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+433ee38d8684adcfbeb9@syzkaller.appspotmail.com

------------[ cut here ]------------
Invalid VIF (ffff88807e14e9d0) magic 0x0, 08:02:11:00:00:01, 3/1
WARNING: CPU: 0 PID: 5908 at drivers/net/wireless/virtual/mac80211_hwsim.c:237 hwsim_check_magic drivers/net/wireless/virtual/mac80211_hwsim.c:235 [inline]
WARNING: CPU: 0 PID: 5908 at drivers/net/wireless/virtual/mac80211_hwsim.c:237 mac80211_hwsim_tx+0x1b6f/0x23c0 drivers/net/wireless/virtual/mac80211_hwsim.c:2026
Modules linked in:
CPU: 0 UID: 0 PID: 5908 Comm: kworker/0:6 Not tainted 6.13.0-rc2-syzkaller-00131-g429fde2d81bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: mld mld_ifc_work
RIP: 0010:hwsim_check_magic drivers/net/wireless/virtual/mac80211_hwsim.c:235 [inline]
RIP: 0010:mac80211_hwsim_tx+0x1b6f/0x23c0 drivers/net/wireless/virtual/mac80211_hwsim.c:2026
Code: 28 84 c0 0f 85 06 08 00 00 45 0f b6 8e 61 04 00 00 48 c7 c7 40 2a a9 8c 4c 89 f6 44 89 e2 48 89 e9 41 89 d8 e8 52 e7 50 fa 90 <0f> 0b 90 90 e9 69 f2 ff ff e8 d3 3d 90 fa 90 0f 0b 90 e9 d5 f2 ff
RSP: 0018:ffffc9000479ebf0 EFLAGS: 00010246
RAX: 8672fc10cd8df200 RBX: 0000000000000003 RCX: ffff888031a21e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807e14ee2a R08: ffffffff81600a42 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807e14e9d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f48a26a56c0 CR3: 0000000061e5a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drv_tx net/mac80211/driver-ops.h:37 [inline]
 wake_tx_push_queue net/mac80211/util.c:298 [inline]
 ieee80211_handle_wake_tx_queue+0x1ae/0x2d0 net/mac80211/util.c:315
 drv_wake_tx_queue net/mac80211/driver-ops.h:1362 [inline]
 schedule_and_wake_txq net/mac80211/driver-ops.h:1369 [inline]
 ieee80211_queue_skb+0x1ae9/0x24b0 net/mac80211/tx.c:1664
 ieee80211_tx+0x2c4/0x470 net/mac80211/tx.c:1967
 __ieee80211_subif_start_xmit+0xe93/0x1600 net/mac80211/tx.c:4339
 ieee80211_subif_start_xmit+0xde/0x4d0 net/mac80211/tx.c:4533
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3606
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4434
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x12c7/0x17b0 net/ipv6/ip6_output.c:141
 ip6_finish_output+0x41e/0x840 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x430 include/linux/netfilter.h:314
 mld_sendpack+0x843/0xdb0 net/ipv6/mcast.c:1819
 mld_send_cr net/ipv6/mcast.c:2120 [inline]
 mld_ifc_work+0x7d9/0xd90 net/ipv6/mcast.c:2651
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

