Return-Path: <netdev+bounces-147227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3A9D8622
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F01EB35F36
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2221AA789;
	Mon, 25 Nov 2024 13:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7141A7275
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540583; cv=none; b=Czido+VL0DvfsBEdErKlg8jAuYpQF3jKBFgLXIUQkO9DBt2ArYNTzPbEfM3kQMwt2ZYElwXiXOvOZUhDDBk61AqZQQ2Thk4e8r30Fvxuiy3rF1BT9q7rLeuu27La+rYEi7RRC6q0pMJFeG9B0y8sVrmbRXn0UPScLvav5OXgLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540583; c=relaxed/simple;
	bh=roIkGxppyk36vBN5Aa6eHc1RlxwoOMeS01gUbDbG0fQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UXBqut0t5+PLVu9HatK3iL4fbN+WOgHS0fy95r6J3u01ZE1hMP4u9HWObBvmVeVs319dRJ8iUNL5lHpIfXrxL/+wDIliN2HoB1en5FNseNcy/6dqwyNt6wh8jsn928t8kJb2G/J/MZZnDMFrAe8KEmSPSkjZni5ldfZKo9xE6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8419aa46a87so97734639f.2
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 05:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540581; x=1733145381;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUeEscvPl0THsXTCcyvV67cLrpataPHdN4bYi/SNHVE=;
        b=h8gCYSCuAQBeoWCg/Z4HmWjmpWB1YGFb+mdqbm1+oiDKYTHnKe4VdXa7w9PsMpJg1O
         QujWVxIJYAn8DaAF1iEh3ejjEHPH1o3U7vIDwroNFGzm3z1enhhsxgJv+3mNKp+LBPDk
         nIcp5b0MYl/w12ICReNC/lpM9OsMeZpYeQXA03vqJMV/tZcjSb7wBMs/vlStDv2SK7JM
         AdSuygzDcL5HCxTE4X4iZvCHOqiASF66QnrcpwamacI2HFp7rPWWTCYvWwSCeaqdEN4x
         nWkV313GZe7dm+6/WWSUwSn99rXsMpPrzGZjOkAmDEdmtIYOJjR5MF1gJtDFf0ioTnZ9
         cA0g==
X-Forwarded-Encrypted: i=1; AJvYcCWsgND7nBx/Aoeyn3OkHyqxx9nt0ZNJ8f+Iza8g9d/c6lo4COzvJBTxRcZGEJJPdjkm2BNyi6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb55fpJAnaq41rPJ+WAMxqSR44TtaI8ebhIiOZx1I3u1Rgu6xe
	38L0Cr08B+TSQR4L4ohFVCLxauRHsNUujiyzEycst+JUPTHMW1jt8diLfhO0hPg2f1N1mhnBpq6
	1LCcgyt+ZODZIQ6OuNTrusA0bHAVy8QS6VRMP1W1KGudCYgW9llZy0Mk=
X-Google-Smtp-Source: AGHT+IFZP3MFmJFXYawZzjM1WHJDr4FPegED77nU69hwDq7WZ9qe3AIs018Ze5kDsiDe4gsMBEXzftjOoB3DZW6FcP1ToXBaj05U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:3a7:629a:8be8 with SMTP id
 e9e14a558f8ab-3a79acfca70mr162786835ab.3.1732540581438; Mon, 25 Nov 2024
 05:16:21 -0800 (PST)
Date: Mon, 25 Nov 2024 05:16:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674478a5.050a0220.1cc393.0081.GAE@google.com>
Subject: [syzbot] [net?] WARNING in call_netdevice_notifiers_info (2)
From: syzbot <syzbot+9b66539a997baee14f5d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14ffd75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=9b66539a997baee14f5d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1539da626e54/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d44dbcc68df2/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76fdad1309ae/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b66539a997baee14f5d@syzkaller.appspotmail.com

RTNL: assertion failed at net/core/dev.c (1987)
WARNING: CPU: 0 PID: 12 at net/core/dev.c:1987 call_netdevice_notifiers_info+0x106/0x110 net/core/dev.c:1987
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bond0 bond_mii_monitor
RIP: 0010:call_netdevice_notifiers_info+0x106/0x110 net/core/dev.c:1987
Code: cc cc cc cc e8 2b 74 fd f7 c6 05 ec 80 70 06 01 90 48 c7 c7 20 5e 0e 8d 48 c7 c6 00 5e 0e 8d ba c3 07 00 00 e8 db 6c be f7 90 <0f> 0b 90 90 e9 73 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001176d8 EFLAGS: 00010246
RAX: a4b68b757b823100 RBX: ffff88805a365ac0 RCX: ffff88801befda00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8155fe42 R09: 1ffffffff203c906
R10: dffffc0000000000 R11: fffffbfff203c907 R12: dffffc0000000000
R13: 1ffff92000022ee0 R14: 0000000000000004 R15: ffffc90000117720
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffeb14c9ff8 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
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

