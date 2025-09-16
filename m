Return-Path: <netdev+bounces-223420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E36B59156
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB952399B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB2286890;
	Tue, 16 Sep 2025 08:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2F2192F2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012874; cv=none; b=QRnKkI9ZGLvsKd8JK+sw6UfzVqF8bJUj1rlL7hUDnSJHhBsYNkG5955Ae19WPER4UHmpXQiKA6vOlIFh8lRB2pYHNhESUjMkBxuHWq55k14CfPxVdPgVCu+by4o66FL841rUQh0WcXOls/FoW+yTs/i0rmn9UTJPpYPebI63jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012874; c=relaxed/simple;
	bh=rWSFg93zJw/EVdFHHieAIdWz85smh+2OhFH0HRdsVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=COIKazve348Hyb8BHctde7X/yYakrcJ6kWcN5MiYUJPJZM+tggwyJ+zCNxaDZfuxL5gE8HsbZPKpU8rq9UzuTWNpbDAxcfT6vMQsIwrS4MGcYfx23SLt6QvKJ4vWOB1s3okA311YJALBiB4DgwWaoUDh/UNW0c1tm0yOKKovvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-424019a3dfaso20740705ab.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012872; x=1758617672;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TcDWRbd+yIuJdUm2xw0Yx2oXd0R8a0H3/AvRt2C8dk=;
        b=chNbv3wgh9nlZpbQUVkaswzmgwr0LXmmmJGyo8MrcOaklY9VOkER06/j3X1L8ymRRO
         Bb6icV2kWRqGTntzBiICeolTMNkPETPKviZ5yQQq1c8SyhAHulX+t0AAP/ZVomAUOg7V
         QFY/pH4mmRqxAXVTdmDcRoI5xSd2nOGL4KMjPvhJu4yRrA2McDSGvfvaxDOLoOrPasAN
         05TryI6fGRyuwJ8uX6KF2P/NFeIIj6pn2WZcLUT9/9CkTWYZBNaUvEJD5WoB86FYgYrg
         4Qy3YLMuEUjY8TrYzGJTP17cLIezQr+CqV9+UwD4LCYqz2Tfr2SBIhHc9zA65eGhlczf
         d60A==
X-Forwarded-Encrypted: i=1; AJvYcCXa3GvIOk5T8MZCymUHIDBrmSAw0jlGCnQLRrXr9/HqE/dEg1DHhgIUSzmejQXjvGHrXsaifk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnnA2Jm/1UxYqxPzt7uPuBrA0QPhVpOgk8E+t//N88cTljcr+
	4uhJHBRjtevtyf+Ty05ebDF/Pt7L/JzHxtU8l5c1XHDoVhhJIGN2hvxmPTRjDFCJHJ3MzRMeSvd
	1IzjUgS5/xpYsAdzkgi+hxv22eOOlZ51D61DoMBcplj3KySRkc/guqDaYrv4=
X-Google-Smtp-Source: AGHT+IFwt6D47g9F04dozxpZAXZD1svcTDwOwgWtjSPXWunGFTumQCoHUno7PfdvlJA/15zVscsHe9iNXSUCU9Pe0z99dY/bKrY1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:419:de32:2ce2 with SMTP id
 e9e14a558f8ab-420a53aeadbmr147875485ab.32.1758012872433; Tue, 16 Sep 2025
 01:54:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 01:54:32 -0700
In-Reply-To: <689d0a4a.050a0220.7f033.0164.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c925c8.050a0220.50883.0019.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_rehash_bss
From: syzbot <syzbot+dc6f4dce0d707900cdea@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17077b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6f4dce0d707900cdea
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148db47c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fd7762580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-46a51f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccc826c963ac/vmlinux-46a51f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79f8a247dcf5/bzImage-46a51f4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc6f4dce0d707900cdea@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 43 at net/wireless/scan.c:1666 rb_insert_bss net/wireless/scan.c:1666 [inline]
WARNING: CPU: 0 PID: 43 at net/wireless/scan.c:1666 cfg80211_rehash_bss+0x1e6/0x540 net/wireless/scan.c:1723
Modules linked in:
CPU: 0 UID: 0 PID: 43 Comm: kworker/u4:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:rb_insert_bss net/wireless/scan.c:1666 [inline]
RIP: 0010:cfg80211_rehash_bss+0x1e6/0x540 net/wireless/scan.c:1723
Code: e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 33 03 00 00 ff 45 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 0c 3d af 00 cc 90 <0f> 0b 90 4c 8b 2c 24 4c 89 ef e8 7b 4c 02 fa 84 c0 74 78 e8 e2 dd
RSP: 0018:ffffc900005e6f20 EFLAGS: 00010246
RAX: ffffffff8acfee15 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801f0c8000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880113f6c68 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888043c281a0
R13: ffff88801a485430 R14: dffffc0000000000 R15: ffff88801a484c20
FS:  0000000000000000(0000) GS:ffff88808d00a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c009610000 CR3: 0000000011e4c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 cfg80211_update_assoc_bss_entry+0x3f6/0x6a0 net/wireless/scan.c:3471
 cfg80211_ch_switch_notify+0x3c1/0x780 net/wireless/nl80211.c:20399
 ieee80211_sta_process_chanswitch+0xad4/0x2870 net/mac80211/mlme.c:-1
 ieee80211_rx_mgmt_beacon+0x19c7/0x2cd0 net/mac80211/mlme.c:7523
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8093
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

