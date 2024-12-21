Return-Path: <netdev+bounces-153947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46419FA268
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 21:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F40161743
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80318872A;
	Sat, 21 Dec 2024 20:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80423153800
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734812244; cv=none; b=YCI28zjxtNT8CC9wiC58OQ3EknUhHmxn2wzpPNUF+6IP6+TA1K7neNVRG2CVLTktXCUNOZoZVAq8XHL1hcrv0Z5eh+LxRd+AnpcjZjToRho1KXfLfkvMCF/WhBT7OjUyX6NS7ZEh96nllnDjR1cBBFymGGCvLPl3d5EArVnI904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734812244; c=relaxed/simple;
	bh=ZljGlOt/uCU3rg4CZxDzOEAGQUrn/mAJX2jL6/yb/RE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xz3FlJHvyzCOQtb1T/ExNjKQL8H+lzrAD2+VQIVA910VgTr/RoC1/izIeZBN6/5Zgr94eT9I0D1RE5Od3thIAy1KKoQSqTgDY55wVF362z3n7e0MBT8RZoUVciSoBdSDyoWn8o35uMoA2g/ThyYDSPhndzdzeoEXw07Y+vKSl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so57371845ab.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 12:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734812241; x=1735417041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoMBUHn+s51SP8sfl9Lqo1jLQFQQ5jUWvpjgvzgHd/A=;
        b=lnWVguZLm8xf65qCZr08JWFTVPiSbeMcBh+g0UF8cA8wu1YnYJuzk8pDIXvHjTVxOB
         FdIAuXdxgZF9ioXlPbrjGDZ55nC2g2Lfu5cYgLBdEcTGnBNagxFzKwi2f9Q3hW8OyGjI
         HDNgNx/fk1VxygOSG8Eckhi61i+x3j8XE6U2n49uqlaxSdQkJd2FD2MLMpmLpq9GSJur
         Tk3Wo3BdiuXGb+2j7NFYcF80zGbtJB1Z8lUV9LeWs9r+YYnjrFLIOCvyReh/iJYGncxC
         uRjpyHRZrIrL/Ch6T+bt6unHRfpdX2TpqbGRbF4G9ZX2+JjEW0opHPj7eebgpyk9f6yc
         UUCw==
X-Forwarded-Encrypted: i=1; AJvYcCWT0y7EgkUgsWEfMQ7iwSktPI81bFcztWnqpf0zjDk68VWebCUleNqiBUVQxSeuJoja5dHTWII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxcnca5B2lXVBeGDUwSOoBEt37CIi6RmeZu2bm3LH7w52r1X7S
	3bdU5CIUWlz/OoDcjjaygupYMSHxtxpv/oXkxKA6Cxe0GQa5Hj6UD0n/9AjeSt+tGeieNraN6QT
	1REGgSpCo9szKzLhI3sAYuHAkMbZDhGZ2oEDxkJ/KidGM3/VKJJUKS6U=
X-Google-Smtp-Source: AGHT+IHzYkW/v7ReXyUwIOODB6yKjZsp4IhcvKZbHT2TsRuKlfyswHjT8DHA8Q6+QSTBZZOk50VBmKc9wUOVXXRiRihicotoeN3J
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2687:b0:3a7:e83c:2d10 with SMTP id
 e9e14a558f8ab-3c2d5b37857mr86744825ab.24.1734812241679; Sat, 21 Dec 2024
 12:17:21 -0800 (PST)
Date: Sat, 21 Dec 2024 12:17:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67672251.050a0220.226966.0016.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in emon
From: syzbot <syzbot+9a15d5aadb22e20c565e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59dbb9d81adf Merge tag 'xsa465+xsa466-6.13-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111957e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1586bab1323870
dashboard link: https://syzkaller.appspot.com/bug?extid=9a15d5aadb22e20c565e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c125f36d349/disk-59dbb9d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6c160c9e2d8/vmlinux-59dbb9d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c9eb7c31c9/bzImage-59dbb9d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a15d5aadb22e20c565e@syzkaller.appspotmail.com

Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL deviceDec 17 20:07:01 Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07Dec 17 20:07:01 Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: receDec 17 20:07:01 [  411.791635][   T35] bridge0: port 1(bridge_slave_0) entered disabled state
Dec 17 20:07:01 Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: rece[  411.806000][   T11] 
ived NULL device[  411.808879][   T11] =============================
Dec 17 20:07:0[  411.815076][   T11] WARNING: suspicious RCU usage
Dec 17 20:07:01 Dec 17 20:07:01 [  411.823433][   T11] 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0 Not tainted
Dec 17 20:07:01 [  411.823465][   T11] -----------------------------
Dec 17 20:07:01 [  411.837692][   T11] net/sched/sch_generic.c:1290 suspicious rcu_dereference_protected() usage!
syzkaller daemon[  411.847668][   T11] 
.err dhcpcd[5485[  411.859149][   T11] 
]: libudev: rece[  411.868725][   T11] 3 locks held by kworker/u8:0/11:
ived NULL device[  411.875527][   T11]  #0: ffff888060765948 ((wq_completion)bond0#5){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204

Dec 17 20:07:0[  411.887451][   T11]  #1: ffffc90000107d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 syzkaller daem[  411.900848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
1 syzkaller daem[  411.900848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
1 syzkaller daem[  411.900848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2960
on.err dhcpcd[54[  411.911626][   T11] 
85]: libudev: re[  411.918877][   T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0
ceived NULL devi[  411.930806][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
ce
Dec 17 20:07[  411.942227][   T11] Workqueue: bond0 bond_mii_monitor
:01 syzkaller da[  411.948789][   T11] Call Trace:
emon.err dhcpcd[[  411.953426][   T11]  <TASK>
5485]: libudev: [  411.957721][   T11]  __dump_stack lib/dump_stack.c:94 [inline]
5485]: libudev: [  411.957721][   T11]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
received NULL de[  411.963750][   T11]  lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6845
vice
Dec 17 20:[  411.970498][   T11]  dev_deactivate_queue+0x167/0x190 net/sched/sch_generic.c:1290
07:01 syzkaller [  411.977046][   T11]  netdev_for_each_tx_queue include/linux/netdevice.h:2562 [inline]
07:01 syzkaller [  411.977046][   T11]  dev_deactivate_many+0xe7/0xb20 net/sched/sch_generic.c:1363
daemon.err dhcpc[  411.983425][   T11]  dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
d[5485]: libudev[  411.989370][   T11]  ? __pfx_dev_deactivate+0x10/0x10 net/sched/sch_generic.c:1379
: received NULL [  411.995916][   T11]  ? __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
device
Dec 17 2[  412.003163][   T11]  linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
0:07:01 syzkalle[  412.009361][   T11]  linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:268
r daemon.err dhc[  412.015758][   T11]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2726
pcd[5485]: libud[  412.022739][   T11]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
Dec 17 20:07:01 [  412.029030][   T11]  bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
Dec 17 20:07:01 [  412.035490][   T11]  ? __pfx_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4617
Dec 17 20:07:01 [  412.042486][   T11]  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
Dec 17 20:07:01 [  412.042486][   T11]  bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2962
syzkaller daemon[  412.048772][   T11]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2829
.err dhcpcd[5485[  412.055480][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
.err dhcpcd[5485[  412.055480][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
]: libudev: rece[  412.061598][   T11]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
ived NULL device[  412.067446][   T11]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205

Dec 17 20:07:0[  412.073909][   T11]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
1 syzkaller daem[  412.080205][   T11]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
on.err dhcpcd[54[  412.087183][   T11]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
85]: libudev: re[  412.093901][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
85]: libudev: re[  412.093901][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
ceived NULL devi[  412.100023][   T11]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
ce
Dec 17 20:07[  412.105986][   T11]  process_scheduled_works kernel/workqueue.c:3310 [inline]
Dec 17 20:07[  412.105986][   T11]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
:01 syzkaller da[  412.111945][   T11]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
emon.err dhcpcd[[  412.118395][   T11]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
5485]: libudev: [  412.123809][   T11]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
5485]: libudev: [  412.123809][   T11]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
received NULL de[  412.130356][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
Dec 17 20:07:01 [  412.136298][   T11]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
Dec 17 20:07:01 [  412.142060][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
Dec 17 20:07:01 [  412.148002][   T11]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
syzkaller daemon[  412.154127][   T11]  </TASK>
.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:01 syzkaller daemon.err dhcpcd[5485]: libudev: re[  412.167601][   T11] 
ceived NULL devi[  412.170615][   T11] =============================
ce
Dec 17 20:07[  412.176949][   T11] WARNING: suspicious RCU usage
:01 syzkaller da[  412.183489][   T11] 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0 Not tainted
emon.err dhcpcd[[  412.192115][   T11] -----------------------------
5485]: libudev: [  412.197850][   T11] ./include/linux/rtnetlink.h:156 suspicious rcu_dereference_protected() usage!
received NULL de[  412.208282][   T11] 
vice
Dec 17 20:[  412.219926][   T11] 
07:01 syzkaller [  412.219943][   T11] 3 locks held by kworker/u8:0/11:
daemon.err dhcpc[  412.235884][   T11]  #0: ffff888060765948 ((wq_completion)bond0#5){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
Dec 17 20:07:01 [  412.247735][   T11]  #1: ffffc90000107d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Dec 17 20:07:01 [  412.261358][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
Dec 17 20:07:01 [  412.261358][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
Dec 17 20:07:01 [  412.261358][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2960
Dec 17 20:07:01 [  412.272420][   T11] 
syzkaller daemon[  412.279756][   T11] CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0
Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]:Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL deviDec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: rece[  412.576111][   T11] BUG: sleeping function called from invalid context at net/core/dev.c:11403
ived NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daDec 17 20:07:02 syzkaller daemonDec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: reDec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485[  412.618213][   T11] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 11, name: kworker/u8:0
]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: reDec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL de[  412.658812][   T11] preempt_count: 0, expected: 0
vice
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NDec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL deviDec 17 20:07:02 [  412.702993][   T11] RCU nest depth: 1, expected: 0
Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: receDec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 syzkaller daemon.err dhcpcd[5485]: libudev: received NULL device
Dec 17 20:07:0[  412.723693][   T11] 3 locks held by kworker/u8:0/11:
2 syzkaller kern[  412.723713][   T11]  #0: ffff888060765948 ((wq_completion)bond0#5){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
.info kernel: [ [  412.723848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
.info kernel: [ [  412.723848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
.info kernel: [ [  412.723848][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2960
 411.753730][   [  412.723913][   T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0
Dec 17 20:07:02 [  412.723937][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Dec 17 20:07:02 [  412.723951][   T11] Workqueue: bond0 bond_mii_monitor
syzkaller daemon[  412.723977][   T11] Call Trace:
.err dhcpcd[5485[  412.723984][   T11]  <TASK>
]: libudev: rece[  412.723993][   T11]  __dump_stack lib/dump_stack.c:94 [inline]
]: libudev: rece[  412.723993][   T11]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
ived NULL device[  412.724020][   T11]  __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8758
Dec 17 20:07:02 [  412.724055][   T11]  ? __pfx___might_resched+0x10/0x10 kernel/sched/core.c:5880
Dec 17 20:07:02 [  412.724087][   T11]  synchronize_net+0x1b/0x60 net/core/dev.c:11403
Dec 17 20:07:02 [  412.724112][   T11]  dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377
syzkaller daemon[  412.724143][   T11]  dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
.err dhcpcd[5485[  412.724167][   T11]  ? __pfx_dev_deactivate+0x10/0x10 net/sched/sch_generic.c:1379
]: libudev: rece[  412.724193][   T11]  ? __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
Dec 17 20:07:02 [  412.724224][   T11]  linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
Dec 17 20:07:02 [  412.724247][   T11]  linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:268
Dec 17 20:07:02 [  412.724271][   T11]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2726
Dec 17 20:07:02 [  412.724297][   T11]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
syzkaller kern.i[  412.724324][   T11]  bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
nfo kernel: [  4[  412.724348][   T11]  ? __pfx_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4617
11.791635][   T3[  412.724391][   T11]  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
11.791635][   T3[  412.724391][   T11]  bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2962
5] bridge0: port[  412.724425][   T11]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2829
 1(bridge_slave_[  412.724451][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 1(bridge_slave_[  412.724451][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
0) entered disab[  412.724483][   T11]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
led state
Dec 1[  412.724505][   T11]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
7 20:07:02 syzka[  412.724531][   T11]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
ller daemon.err [  412.724563][   T11]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
dhcpcd[5485]: li[  412.724586][   T11]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
budev: received [  412.724606][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
budev: received [  412.724606][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
NULL device
Dec[  412.724641][   T11]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
 17 20:07:02 syz[  412.724665][   T11]  process_scheduled_works kernel/workqueue.c:3310 [inline]
 17 20:07:02 syz[  412.724665][   T11]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
kaller daemon.er[  412.724700][   T11]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
r dhcpcd[5485]: [  412.724722][   T11]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
libudev: receive[  412.724747][   T11]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
libudev: receive[  412.724747][   T11]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
d NULL device
D[  412.724770][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
ec 17 20:07:02 s[  412.724796][   T11]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
yzkaller daemon.[  412.724821][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
err dhcpcd[5485][  412.724847][   T11]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
: libudev: recei[  412.724889][   T11]  </TASK>
ved NULL device[  412.724900][   T11] 

Dec 17 20:07:02[  412.724913][   T11] =============================
 syzkaller daemo[  412.724930][   T11] WARNING: suspicious RCU usage
n.err dhcpcd[548[  412.724951][   T11] 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0 Tainted: G        W         
5]: libudev: rec[  412.724981][   T11] -----------------------------
eived NULL devic[  412.724996][   T11] kernel/rcu/tree_exp.h:946 Illegal synchronize_rcu_expedited() in RCU read-side critical section!
e
Dec 17 20:07:[  412.725030][   T11] 
02 syzkaller dae[  412.725048][   T11] 
mon.err dhcpcd[5[  412.725077][   T11] 3 locks held by kworker/u8:0/11:
485]: libudev: r[  412.725104][   T11]  #0: ffff888060765948 ((wq_completion)bond0#5){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
eceived NULL dev[  412.725250][   T11]  #1: ffffc90000107d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
ice
Dec 17 20:0[  412.725379][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
Dec 17 20:0[  412.725379][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
Dec 17 20:0[  412.725379][   T11]  #2: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2960
7:02 syzkaller d[  412.725439][   T11] 
aemon.err dhcpcd[  412.725449][   T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W          6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0
[5485]: libudev:[  412.725475][   T11] Tainted: [W]=WARN
 received NULL d[  412.725483][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
evice
Dec 17 20[  412.725496][   T11] Workqueue: bond0 bond_mii_monitor
:07:02 syzkaller[  412.725520][   T11] Call Trace:
 daemon.err dhcp[  412.725527][   T11]  <TASK>
cd[5485]: libude[  412.725536][   T11]  __dump_stack lib/dump_stack.c:94 [inline]
cd[5485]: libude[  412.725536][   T11]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
v: received NULL[  412.725561][   T11]  lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6845
 device
Dec 17 [  412.725586][   T11]  synchronize_rcu_expedited+0x1e5/0x450 kernel/rcu/tree_exp.h:946
20:07:02 syzkall[  412.725616][   T11]  ? __pfx_synchronize_rcu_expedited+0x10/0x10 kernel/rcu/tree_exp.h:796
er daemon.err dh[  412.725640][   T11]  ? dump_stack_lvl+0x185/0x1f0 lib/dump_stack.c:123
cpcd[5485]: libu[  412.725663][   T11]  ? lockdep_hardirqs_on+0x7c/0x110 kernel/locking/lockdep.c:4468
dev: received NU[  412.725689][   T11]  ? add_taint+0x5f/0xd0 kernel/panic.c:607
LL device
Dec 1[  412.725712][   T11]  ? __pfx___might_resched+0x10/0x10 kernel/sched/core.c:5880
7 20:07:02 syzka[  412.725739][   T11]  synchronize_net+0x3e/0x60 net/core/dev.c:11405
ller daemon.err [  412.725759][   T11]  dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377
dhcpcd[5485]: li[  412.725788][   T11]  dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
budev: received [  412.725810][   T11]  ? __pfx_dev_deactivate+0x10/0x10 net/sched/sch_generic.c:1379
NULL device
Dec[  413.250325][   T11]  ? __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
 17 20:07:02 syz[  413.257589][   T11]  linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
Dec 17 20:07:02 [  413.263782][   T11]  linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:268
syzkaller kern.w[  413.270155][   T11]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2726
arn kernel: [  4[  413.277130][   T11]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
11.806000][   T1[  413.283422][   T11]  bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
1] 
Dec 17 20:0[  413.289881][   T11]  ? __pfx_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4617
7:02 syzkaller k[  413.296871][   T11]  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
7:02 syzkaller k[  413.296871][   T11]  bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2962
ern.warn kernel:[  413.303157][   T11]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2829
 [  411.808879][[  413.309874][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 [  411.808879][[  413.309874][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
   T11] ========[  413.316003][   T11]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
================[  413.321849][   T11]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
=====
Dec 17 20[  413.328316][   T11]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
:07:02 syzkaller[  413.334612][   T11]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
 kern.warn kerne[  413.341583][   T11]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
l: [  411.815076[  413.348301][   T11]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
l: [  411.815076[  413.348301][   T11]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
][   T11] WARNIN[  413.354431][   T11]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
G: suspicious RC[  413.360376][   T11]  process_scheduled_works kernel/workqueue.c:3310 [inline]
G: suspicious RC[  413.360376][   T11]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
U usage
Dec 17 [  413.366322][   T11]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
20:07:02 syzkall[  413.372774][   T11]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
er kern.warn ker[  413.378198][   T11]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
er kern.warn ker[  413.378198][   T11]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
nel: [  411.8234[  413.384746][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
33][   T11] 6.13[  413.390684][   T11]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
.0-rc3-syzkaller[  413.396449][   T11]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
-00026-g59dbb9d8[  413.402388][   T11]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
1adf #0 Not tain[  413.408512][   T11]  </TASK>
ted
Dec 17 20:07:02 syzkaller kern.warn kernel:Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 Dec 17 20:07:02 [  413.421504][   T11] ------------[ cut here ]------------


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

