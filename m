Return-Path: <netdev+bounces-212318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56BB1F307
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 10:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C4A18C3F57
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8A239E65;
	Sat,  9 Aug 2025 08:08:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AC1F8725
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726912; cv=none; b=YurBbA0pYqujiFYQgsGhDVlFy/b6ORZuLHBuItcfeDllu+GLAwQHhXVIL4yCBzEbFuN0eGhLmyDCCyruQYLvc2S+AeC5HpeHBaGI+GAh1Xakf7+ubYFbA2xRwf54H4PhhOdJ1aaDiZ9gLvhd7GyfncYQ1EXOBh+Pc985w8d/w4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726912; c=relaxed/simple;
	bh=gxhJv3M6LTgsTm9Y7kg+WT4sO+pHU5IOfXqCVEzQPeI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ndr3kfLCJZ8Z2ia3IzAdCoaC00t1mcqnen8quGYe5fWr7qiLczA9u5r5Bhc3BbLyGkQG3LnCpIiwQNvgiIdyD0eF31rZxT1JKS9c+ltnZEpvoO1cycCLvqvlQnKcNwHp/C4QVXFOAZNHRQfWNujy8cCMKDto3vxzcvMNRTKgMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87b2a58a4c0so336359039f.0
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 01:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754726910; x=1755331710;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb9JiR6xp3nJjHaWZta3Yh54N0h9tCnSUrjA3nNswFg=;
        b=WvIGv9TmUlcZ3obZUZFOV7c1WuzdpBudpW3AH4VZu8Ae3OSaEhfv2kdK0gETAgAZlf
         hV3R47t85WqBFHL2W8MBa+r3/8YeLXK2khBatypqVpLQeY9SQvHpnggU3fuTgNoh+oOe
         Hya03mgkt2LMBHcZzEAjlo9aWRjt5tbVZrrdluasYWwRpKosPQf+YGM0e9HO44uvV440
         8FX2g1baG7K2A8JjUjtYl+KYOltiXHaVD0YbUX/3d1gPURVNASdGBYvuqrC1CvgASUHy
         Eh6MCVX1XW0PZLgwBVE9CHHAcQIvfsZcc2CBJxl/c8dpQ3sNaF8glk+YuRnvijiqDAzF
         nsbw==
X-Forwarded-Encrypted: i=1; AJvYcCXzm38SQgswmMgIYEYzaNkYcYnyUaJyHO+JeH+Hafc9AjtVbqEkUJ36IMrPjtewDBs/wwaPPfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiPPgRflb+nvnPmcEgvhss7pRDAeSMtDg7Gz7k9ppD/FDeVZ/
	SCjSPsPuV5rmS+ysQqnVCvWT4GASReJJPLqSsuVfxiht0wxIgU7mXKgwROJL8qQFgYHnXIy5uYJ
	DkAsk+lJDGp/cKWYMgjHWajN8KTBP0GdXs37zNI97y+8+FRdb3FXg+nmQ/AY=
X-Google-Smtp-Source: AGHT+IFRJ0gQJJTCyilBOiHjVnsBnC4TBMAhvaWvlqiSt+fL7dpw6KWbz+K2NDmVSPmUAlTnH9dcggAsMRc4PAKPZYEKmeMH1/wD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e533159919mr101574425ab.15.1754726910075; Sat, 09 Aug 2025
 01:08:30 -0700 (PDT)
Date: Sat, 09 Aug 2025 01:08:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689701fe.a70a0220.7865.0030.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_link_info_change_notify (3)
From: syzbot <syzbot+4b9a40c62f9a80195a4f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f07aa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1bb6a60e53533c7
dashboard link: https://syzkaller.appspot.com/bug?extid=4b9a40c62f9a80195a4f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c830eae67136/disk-7e161a99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc8fc9ead36/vmlinux-7e161a99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db1e8c2fe140/bzImage-7e161a99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b9a40c62f9a80195a4f@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 14825 at net/mac80211/main.c:425 ieee80211_link_info_change_notify+0x349/0x3f0 net/mac80211/main.c:425
Modules linked in:
CPU: 0 UID: 0 PID: 14825 Comm: syz.4.1907 Not tainted 6.16.0-syzkaller-11699-g7e161a991ea7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:ieee80211_link_info_change_notify+0x349/0x3f0 net/mac80211/main.c:425
Code: 74 24 08 48 81 c6 20 01 00 00 48 89 74 24 08 e8 fd f8 bc f6 8b 54 24 04 48 8b 74 24 08 48 c7 c7 c0 42 08 8d e8 48 97 7b f6 90 <0f> 0b 90 90 e9 0b fe ff ff e8 d9 f8 bc f6 90 0f 0b 90 e9 21 fd ff
RSP: 0018:ffffc90003c6fb30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88805ab04d80 RCX: ffffc9000e0ef000
RDX: 0000000000080000 RSI: ffffffff817a3315 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88805ab05728
R13: ffff88805ab06500 R14: 0000000000000000 R15: ffff88805abe8e40
FS:  00007fb6b366a6c0(0000) GS:ffff8881246c6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdb6ffb5f40 CR3: 000000005f61b000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_recalc_txpower+0xe4/0x110 net/mac80211/iface.c:81
 ieee80211_set_tx_power+0x2b8/0x10d0 net/mac80211/cfg.c:3263
 rdev_set_tx_power net/wireless/rdev-ops.h:600 [inline]
 cfg80211_wext_siwtxpower+0x30e/0x680 net/wireless/wext-compat.c:893
 ioctl_standard_call+0xb5/0x1d0 net/wireless/wext-core.c:1043
 wireless_process_ioctl.constprop.0+0x291/0x3d0 net/wireless/wext-core.c:981
 wext_ioctl_dispatch net/wireless/wext-core.c:1014 [inline]
 wext_ioctl_dispatch net/wireless/wext-core.c:1002 [inline]
 wext_handle_ioctl+0x226/0x2a0 net/wireless/wext-core.c:1075
 sock_ioctl+0x3a1/0x6b0 net/socket.c:1291
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb6b278eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb6b366a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb6b29b6080 RCX: 00007fb6b278eb69
RDX: 0000200000000040 RSI: 0000000000008b26 RDI: 0000000000000006
RBP: 00007fb6b2811df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb6b29b6080 R15: 00007fffe088baf8
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

