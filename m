Return-Path: <netdev+bounces-153911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BF9FA06F
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C21886C46
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9B1F0E32;
	Sat, 21 Dec 2024 11:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE22594AE
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734780686; cv=none; b=BXW3HNRR9YJI7swgxWMmsflxJfDdN0irX4hx9POWQu7/Vj8EmazAotgIy3ctS7GZPwuc3KZ5skd1vGZrwI327p+ePq2EvDr/dxOxW/++tYmUD48NCxJ9j7XmILfthUauaRzRdXrUJp19zrSkvMx6kC0cB9DN4ruBzkYrvD3TuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734780686; c=relaxed/simple;
	bh=+ii/HPnF4l1nLSP21EHA0qCwoZUXYZ705VztIMcGip8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sPV/rVFHH2giXDFS8Gfqbss3RmYi/EMz6OHFvSYMdxP45khIg0FgyGqPxRBA0ealX7fqNwTJbbwfqQ+NzbnhFy2x5er328XQ7Zq0xIZDzTVQcS/N14KlOA7bgWBTuX/HzCsmrMnEAYdtxLlff8aIaAbFDOtn4PmSODyoSpTXAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a81684bac0so51910005ab.0
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 03:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734780683; x=1735385483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSl0BUaCp0hxe4mCxMmcuXqXTBDKjLadROmZpjRuaTA=;
        b=eRS9H9dLU6sOlhH0XNon1KLH6xkhpSJIZts+m4Z2NKkRiEDB7sdZwCeJ4Aqe4ss4Jj
         egQjCXXDT6jPToKazPEXLlcu/gBg7//bBTh9A8def3PKp8rZOvCFaKufLm11NUfH6a2E
         5sJYdPLWnfPLCkrj1lm0ZS7yEO9Fw9lMosrd5F4kuLdqHte5JjB7TgBwLXk6GlexfYCH
         E+EG/Cbm+6dsBfnsXI34YuNMh7WnGMpf58+ZuodC03miVxqC9nJ4K3sPqEHMBbkIrbfo
         6Dqtn/gn4FyEB9TNCiBlimt6Dok++Scj5yErxi23p3C2YuS8Lm3KxFgVZBfcaX1xsllJ
         9nqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Hkt5JApQnUPknFr5ebOZgFPffnhLdelh9TZ11I0gTBpYBA+it8XahN1zwKdBRqv5KglTGxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwx2e9vMN2vrcmWPDOPF7UsUnQdvNU18UWllViendeXOxBpI5s
	ZgnpYeugce3vC55eK4hbC5yuR4VtjGItZOMCpJOSKbnJIuYuwSRdpsUfxwcw59hJaKgK2vP1QIk
	VCFWI30kdmzgcfYzgg9AC1J0rPFRBfpMbBvZg7UW4fSdPBFDcCZh+H5M=
X-Google-Smtp-Source: AGHT+IHbskSylUeOMgoyiOi3c7EkZj+L5IOUu+/luiRy10/WPb2mox3S2CKWtiWnLOJADPc8FGWhDHW2V/jrpmGI+1OdX8NkneTX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2687:b0:3a7:e83c:2d10 with SMTP id
 e9e14a558f8ab-3c2d5b37857mr73143185ab.24.1734780683777; Sat, 21 Dec 2024
 03:31:23 -0800 (PST)
Date: Sat, 21 Dec 2024 03:31:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6766a70b.050a0220.25abdd.012d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_get_tsf
From: syzbot <syzbot+48d64503fdea9b2ee378@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128282df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=48d64503fdea9b2ee378
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/129158790532/disk-f44d154d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4893f23f2c39/vmlinux-f44d154d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b12b565fb71e/bzImage-f44d154d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48d64503fdea9b2ee378@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 2894 at net/mac80211/driver-ops.c:249 drv_get_tsf+0x1c7/0x780 net/mac80211/driver-ops.c:249
Modules linked in:
CPU: 0 UID: 0 PID: 2894 Comm: kworker/u8:6 Not tainted 6.13.0-rc3-syzkaller-00017-gf44d154d6e3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_get_tsf+0x1c7/0x780 net/mac80211/driver-ops.c:249
Code: 0f 84 44 05 00 00 e8 38 93 0c f7 49 81 c4 20 01 00 00 e8 2c 93 0c f7 44 89 f2 4c 89 e6 48 c7 c7 40 f6 9d 8c e8 5a 59 cd f6 90 <0f> 0b 90 90 e8 10 93 0c f7 4c 89 ea 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000c337c00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888024f68d80 RCX: ffffffff815a16c9
RDX: ffff888030430000 RSI: ffffffff815a16d6 RDI: 0000000000000001
RBP: ffff888024ea0e40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888024f68120
R13: ffff888024f69728 R14: 0000000000000000 R15: ffff888024ea06a8
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3d933b CR3: 000000002fde0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_if_fmt_tsf+0x42/0x70 net/mac80211/debugfs_netdev.c:661
 wiphy_locked_debugfs_read_work+0xe3/0x1c0 net/wireless/debugfs.c:135
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

