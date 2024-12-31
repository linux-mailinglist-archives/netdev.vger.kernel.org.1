Return-Path: <netdev+bounces-154639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B69FF069
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913087A1EAA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCB19D06E;
	Tue, 31 Dec 2024 15:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FED18787A
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660168; cv=none; b=OCyybUefFJS2wpyjMTiXV/cdzdgM2+nrMOUhUIOKDNDQn30wc//+mheyTOa50k0HQ94oYwWKl3CKkKLzd+wYR5j9OCfsAqkKV44UUO6PG4cXTou4rvrVjGMetIQEdFsZhwiVLEhNZAo6UjoIZwY+Cf4JIQ9Zzd+j3CGMq1cSYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660168; c=relaxed/simple;
	bh=ALno9oh33zEF/o4+9wc2IH/yXCgfgbbN+kXL7QfCQXk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JvUUqVVA2Z8M/MGqAwnSGTULQxRXdwntiq4vW9+JhQBd63WI3Atbsk1ynaD8x/h1BTfAqb2+dMZcAD882ABUn/WXCbuEzCvhqIAET4elFHgE01EI6y58hkSRSDVlH9JQjBCUpV5dQ/ROKrTDgLAq5+6k6x6922lvU/gAri2EYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so99684145ab.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 07:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735660165; x=1736264965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF1IcJ5J93B8GZB8mezhFa1KlIt75eZnUVGZ+S8oRqA=;
        b=Dw13OhQlwQvildOnZYusFK9gyzcIL0J4pJYyd8zxQ2d9egg3ROm1M1WMdMzEyyoNqv
         jElEVnp/Xgb6rCTuQcbnotRo5km8hwTMk0nICQUrA7X7F8Ekuds6N6e8ML34LCxu7gR0
         C0LmbVzdFnc3htUTvu51PMcP5wvHAJmEz2podH4zZjnCuOuIBo2vMsJh9IelYaNGJrQV
         B1DKbQHsDCD/H8o0+IY64isX4s4zhxw9DgmWG9svCGYuwCKOsVvLd/UgzUewYT+CQ+B/
         8/fr33USGswfWZ8VAEUpjSW7Ca1zRyA1ZSx8ecKxks/bOxLys7VJ7mbGzPaUkMAgh3K+
         Bm7g==
X-Forwarded-Encrypted: i=1; AJvYcCUYDmTGZ0Lomu1Ag9MrSL42qqdoPegloNjdNEtB0zKooIb2cB9LxJvcHkUvZEZu0vVTMF38zLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBjyDIgmqceXEwwLgLQZj4+Qt1+jyHODE/aEt68KQuMMJ4V74
	untPgl14lJYE0g9HfaTj6Gt3nd9H4fKD7tEB6ZD+7mtY4fraKMSJPl5cVNaWatBsfPK0ssyZf0h
	D5ctzWhC+wER26mr1Y54M1fVq0TV17X0zgt1iD+lXdEdrST5YIagrewA=
X-Google-Smtp-Source: AGHT+IFuYuFxVhvi+x2hjCdSm/IfKaYLH8VOsiYAt0/r0/mXRJ37lEopIVykRPcIp8mYVRRpsQ6d0hZHg7esFiNJaiDYywrPhJqv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3284:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3c2d58197b4mr286690285ab.22.1735660165694; Tue, 31 Dec 2024
 07:49:25 -0800 (PST)
Date: Tue, 31 Dec 2024 07:49:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67741285.050a0220.25abdd.0911.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in linkwatch_do_dev (2)
From: syzbot <syzbot+8ad3d259a2ccebee708d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d6ef8b40d075 Merge tag 'sound-6.13-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1678d018580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa8dc22aa6de51f5
dashboard link: https://syzkaller.appspot.com/bug?extid=8ad3d259a2ccebee708d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-d6ef8b40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdc7bb9169c5/vmlinux-d6ef8b40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d04f28579e9d/bzImage-d6ef8b40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ad3d259a2ccebee708d@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1290 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
 #0: ffff8881063bd948 ((wq_completion)bond0#10){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204

stack backtrace:
 lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6845
 dev_deactivate_queue+0x167/0x190 net/sched/sch_generic.c:1290
 netdev_for_each_tx_queue include/linux/netdevice.h:2562 [inline]
 dev_deactivate_many+0xe7/0xb20 net/sched/sch_generic.c:1363
 bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
 bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2962
 </TASK>
WARNING: suspicious RCU usage
-----------------------------
other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u32:8/1145:
stack backtrace:
CPU: 2 UID: 0 PID: 1145 Comm: kworker/u32:8 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Workqueue: bond0 bond_mii_monitor
 <TASK>
 linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
 bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2962
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
=============================
-----------------------------
other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
 #0: ffff8881063bd948 ((wq_completion)bond0#10){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204

stack backtrace:
Call Trace:
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
[ BUG: Invalid wait context ]
-----------------------------
other info that might help us debug this:
stack backtrace:
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377
 linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:180
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 </TASK>
Tainted: [W]=WARN
Workqueue: bond0 bond_mii_monitor
RSP: 0018:ffffc90005f47390 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806a83fb80 RCX: ffffffff815a50d9
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R13: ffff888026f7a440 R14: ffff888026f7a440 R15: ffff88806a83ebc0
CR2: 00007ffe20f4de14 CR3: 00000000317f2000 CR4: 0000000000352ef0
Call Trace:
 __schedule+0x297/0x5ad0 kernel/sched/core.c:6661
 mutex_optimistic_spin kernel/locking/mutex.c:485 [inline]
 __mutex_lock_common kernel/locking/mutex.c:589 [inline]
 __mutex_lock+0x8a1/0xa60 kernel/locking/mutex.c:735
 exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377
 linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:268
 bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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

