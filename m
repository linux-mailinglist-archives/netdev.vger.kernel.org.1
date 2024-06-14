Return-Path: <netdev+bounces-103658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75F908F54
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC52A286C3E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CB282E1;
	Fri, 14 Jun 2024 15:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C94EB55
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380222; cv=none; b=ho5I9YH+ixoBQhesk1osczc2S3ZVBF/fRDjfnpN5qHkvKWkLNkk1CNKh9nihllnoXHUpTzBbxVP3D+WtHQBmzBZmyHoD9Cza5O9lHSwMbyvaG0c21QSzzaOs37n9xHhIjSYkpzmkfuDL1LjkOITmqQwKZVJT2D2LjkfAjNG6VJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380222; c=relaxed/simple;
	bh=eEaMUsD2rZrdszBawcdmXrpAkK9gZi0K/sFTkhrTvJw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cIgzqj4cP7k0juElr748HkneUHCnYo2FxwDZjsoF2GOrzXt31CuiY40vSJk9oWEYmGNhp2OUly+8JvgXzkCr3rmZ6oV+ofsXtlyw4YrWSTsyezlCxhb5dRUwURGkCySt+Awn6OyUMEb5MrAb/sw0a+UqNk1eDKDcoeMVsoLf8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3759b8709afso24884795ab.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718380220; x=1718985020;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2j2pYJL3E7Tl8CHR3yVJ1heQbZR4qqoUVD6Td5o04c=;
        b=VA+KPsqayL+yNEr+a3rn5Pi/Bbh4Z6ONrCgrXgiStTcpey/UMSFDGo+DkiHAOJbZGU
         7Qts/q+H/24/WahQGp2Vp+aNPHBpQoKgH6hebHAczB3YMyTiNexUfYyt0yfqIJufrDex
         8pxlZlXuLhKnile6k9lKFXB6iG75Czz/s6rg0oweLSPhbQHu0nswT6e55Y2TrIe/LvO8
         +g7eVnjWQ47tsLqHv8Ik26PuyBXnyTPEIIr9pA26ARPNO9Q2+CpJ4zIVUiLSZT0MXCeW
         V/xWy0uJfxL7fG1TKKt2NNqGyKaPoiKnkUz/eLQxaCw2XjX7p/5LoZXk4pRQ16E3z1tD
         EXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhUC6Qh52fym3wnJU5InnMoQvMhHfaTCQ1QYyNi32WNYQzL376rAVwngr9XN3h+9b1Krd5oyVqvm//k3w2jV2UMLGz15hj
X-Gm-Message-State: AOJu0YzJte+iWxN9lq32DlxcsTtoZqrzwRAiGzosZE6CNWJ2Nylhw2Dr
	ZedX5YVB1J2LJMyUG+zt2u4cETOMnZl01qtM/EBMj11TDjA1q1M3XLWwGqCr2h269kWlkWfV34P
	fE1zBdB6Or0VikZue8heYz5f+mwUGL6o2iWIL3CYQXV+m/fJK2fd5D6U=
X-Google-Smtp-Source: AGHT+IH1zmV3U3XvSe6YiB+uqVWTuWnQPg4pCFKXeRSuAMpaB6caxUG3TcLORbeaK4pVcuQTukWd2YCPMggg0GFH303blRVbltAo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:a03d:773a with SMTP id
 e9e14a558f8ab-375e0e27c0fmr1674525ab.1.1718380220552; Fri, 14 Jun 2024
 08:50:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:50:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2aa7a061adb921e@google.com>
Subject: [syzbot] [wpan?] WARNING in lowpan_xmit
From: syzbot <syzbot+ba0ca9eb9e8da84dadeb@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17789a56980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=ba0ca9eb9e8da84dadeb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4edf8b28d7f/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f9b0fd6168d/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2c5f918ca4f/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba0ca9eb9e8da84dadeb@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1237 at include/linux/skbuff.h:3069 skb_network_header_len include/linux/skbuff.h:3069 [inline]
WARNING: CPU: 1 PID: 1237 at include/linux/skbuff.h:3069 lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
WARNING: CPU: 1 PID: 1237 at include/linux/skbuff.h:3069 lowpan_xmit+0xe38/0x11a0 net/ieee802154/6lowpan/tx.c:282
Modules linked in:
CPU: 1 PID: 1237 Comm: aoe_tx0 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:skb_network_header_len include/linux/skbuff.h:3069 [inline]
RIP: 0010:lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
RIP: 0010:lowpan_xmit+0xe38/0x11a0 net/ieee802154/6lowpan/tx.c:282
Code: 85 7c fe ff ff 48 01 81 48 02 00 00 e8 91 ea 24 fe e9 59 fc ff ff e8 d7 79 f4 f6 90 0f 0b 90 e9 17 f6 ff ff e8 c9 79 f4 f6 90 <0f> 0b 90 e9 fa f6 ff ff e8 bb 79 f4 f6 0f b7 8d e0 fe ff ff 48 c7
RSP: 0018:ffffc900049979c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888022284cb0 RCX: ffffffff8a99627f
RDX: ffff8880232b1e00 RSI: ffffffff8a996b87 RDI: 0000000000000003
RBP: ffffc90004997b60 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000000 R12: ffff88807cecf836
R13: 000000000000ffff R14: ffffc90004997a50 R15: ffff88807cecf780
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd216ae56c6 CR3: 0000000061aee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:4882 [inline]
 netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x143/0x790 net/core/dev.c:3594
 __dev_queue_xmit+0x7ba/0x4130 net/core/dev.c:4393
 dev_queue_xmit include/linux/netdevice.h:3095 [inline]
 tx+0xcc/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1e7/0x3c0 drivers/block/aoe/aoecmd.c:1229
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

