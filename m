Return-Path: <netdev+bounces-154498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3319FE39A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9025A1882817
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E11A08AB;
	Mon, 30 Dec 2024 08:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03F1A072A
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735546044; cv=none; b=G7/VM8St1L19d3TD8SUBt+ChPg3PJU3pOzI/fO3z0Ah2aG1OrI7Xldxv9Kx9sy4DWE5nJK+0p/vJq0vwv7Bp5AobUI+QeaxkMW9VSKhd5Rit9BN/+3ry2UooeJGC/slg+69Y9G7Ex+kdS2B2ICOg8WGL5/x3oSxdshHrE5hXRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735546044; c=relaxed/simple;
	bh=OIM1Y4NWbpcMyvZVBjutclcMuYNLDE1DrkEVY49eH2Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sWvcQSpPl9pgQ+r1MvSGSNlUibw/ypkKmolEv2CoZkgt9f4q4DQg1YLyChay2rZSlu0wEmw/TyfAI7yNxvu1xsJ2kxTeLPVZQfzNGT6ujt0imIyp83t14eJnZBMeKXFxrsTESzlIpt7EkpfGwXcHLcaATZWT9+uO0OVDBCk+Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a812f562bbso193540625ab.1
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 00:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735546042; x=1736150842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUynRFj7VEaV10r6/OF/rVuvmpEf0FuTJOYT9ttzejI=;
        b=nYcHY7cMupV3v0I9ojKeLpYcrOE1MR3XZaAcCM61zzpdqAtGxlx6+t7O716r+bwT0i
         +bE/qGSdO/41tjUUUvlbXoHvnc3BJD2u+V/84YODf7q2wDiuTJHsLg3udZPpwb6Cwbe3
         0fPoN7inGj1UOVIfj7UTfRRKyc5b8lBtQLMGMUSCW9ksOFFxsOkhlOMiSIY8G0fpLKbQ
         sylodGobU/Tu1H9OmIkT1P/7BzBuxlPpd1frbhlX//T3E04cOdcVo/IiZ0+S/Plh1ub7
         8YAtwRJplaO/7dh2BEuh6pqLXx9B3PggPgYzQWANJ2bOhPjzMrP8dJuxEwHW/2VXNTWI
         RKwA==
X-Forwarded-Encrypted: i=1; AJvYcCUzM1i9gBCPgbayZ1HGwo17jbpKAvXCHec6h7UXJVF0QW5hi5lwlAgZ4zWUCcLBp3UEiLrJ2+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtnwLgS52pEe8fi4kfzXRYn0GRo+htcuWXUzyfXpRpRKRTran+
	xmYB8KLM4YKTgrsT7Bhwu1TAm+OkL6wIVxfZSosV1+sjU7IfVxV5/Ca0cAXSGHq0UmscmDKHhW3
	5sht/v5WpMTv3fcOXyEr3RjKhvzQ0ByQXk5HzijVpdGbKGh3jj8H9D10=
X-Google-Smtp-Source: AGHT+IHcas72jpuAKR45Az0d9LXedHbJuJbMmRnepkwBxyRbY3YVOKrSHZNR0PnX0Cs2Di1qnyJJSNij0pxxa8x+QDPY5ZbRNgDE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3c2d277f709mr274937865ab.7.1735546042375; Mon, 30 Dec 2024
 00:07:22 -0800 (PST)
Date: Mon, 30 Dec 2024 00:07:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677254ba.050a0220.2f3838.04ba.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_active_links
From: syzbot <syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172402c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=0c5d8e65f23569a8ffec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aa690f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155ce2f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d66e09941d/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa24ea0a81d/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9c0b1e880a/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 52 at net/mac80211/link.c:504 ieee80211_set_active_links+0x7ba/0x9c0 net/mac80211/link.c:504
Modules linked in:
CPU: 0 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_set_active_links+0x7ba/0x9c0 net/mac80211/link.c:504
Code: 94 c4 31 ff 44 89 e6 e8 f4 b5 04 f7 45 84 e4 0f 84 81 fc ff ff e8 06 b4 04 f7 e8 21 46 77 f6 e9 72 fc ff ff e8 f7 b3 04 f7 90 <0f> 0b 90 b8 ea ff ff ff e9 74 fa ff ff e8 e4 b3 04 f7 e8 bf 7f ea
RSP: 0018:ffffc90000bd7b78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880276ce9d0 RCX: ffffffff8a949444
RDX: ffff8880206b9e00 RSI: ffffffff8a949b59 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: ffffffff901d16d4
R13: 0000000000000001 R14: ffff8880277f8e40 R15: ffff8880276cd720
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005556f9227000 CR3: 00000000757fe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_if_parse_active_links+0xa4/0x110 net/mac80211/debugfs_netdev.c:733
 wiphy_locked_debugfs_write_work+0xe3/0x1c0 net/wireless/debugfs.c:215
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

