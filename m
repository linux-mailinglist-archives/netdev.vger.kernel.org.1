Return-Path: <netdev+bounces-106184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC749151CC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FA4284B02
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705A19B595;
	Mon, 24 Jun 2024 15:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086401DFF5
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242123; cv=none; b=HUTJSn7CVaHSk8E2rbG9R9skID8qhnSN/graEqtVEKdkGgyUZ27I80BHa/zlb9lipVZXS1pmUGa31l6EpnvAU4NFoZZXiHQOvz/pCH1Q7yusK3odq0BnlciW+Zid+zsNcbcgolSg2R6Y073gNfZ3PWZ+U9AXF57p/etn1tj3m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242123; c=relaxed/simple;
	bh=MNr/iW7hektiD1H3kRheYm/jFxPg/XU6IynSNsEZCbQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FjOYhZ94mTilzRPTo/zozbvnRC96aJYXlsfl6a2zUvoti1kBOFps2bm9pKfN7DeABaI/dvlLGuDEL9yv2olUgidSsIF4ZTakU0YpV2rnno+eEAsXu8N0PF1EdwwzBGSP49d//wIYRdd6M7Cw3UQCjSnLf/oBTq3xcj8POvRjg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-376229f07a8so45952205ab.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 08:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242121; x=1719846921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONAk/9gMOLl8MwIxQFP3SbpLQofEWlsXstY30enpvjw=;
        b=Pj9QBHJKoUPT0ZVnO8bFy0pH0Mb30e6mrYVy5GoNnZPBXiipPgZhtS8SNU2a4GS8ye
         BDJ5iDAOlzC+Cb4MHiFxzbUMy1Oiyq+L91KxoB5PYxXpWHdiDdsz4doWAGfV+A8dOZ5s
         JwlBKCQ0D2ID8hhae1ORiWJZLuUO1km3wjtysWrdUCVOzmOVZ/v/bE2TdJtnchTAE2y8
         rbT33mqEz54C0YbVsqlRZGDkeiLAxrKhQPJBsmf1ScLXc1+VzvnD0ALt/qiByWEAziOm
         MaEibhD+60ICuKK4LpNFD89ZZcB0UQZEUozRHMxt03o+xLBnKeXN6tISfmfmQj1rKamu
         ve3g==
X-Forwarded-Encrypted: i=1; AJvYcCUMNqmi7Vq1v/Pwuh/sSWWlthSW0oyYYjJySXHZh6p5xqIzWWrp3kbNuFJlCnjbbEu9Y27FdtfAT93VTLbJJyTaU6yuhC1e
X-Gm-Message-State: AOJu0Yw2vo3We91loJveV/eFtWy115BejSzFqhhbOJ2peQ1hf/pDJTMF
	FWZlVOtk6+zA3ubag+BGcp23Tmc1JwHk3C2XQeFWyZbNnWKN/PiguzmGTUx/EJ2WweKMJIyyfui
	y3ZCvMpHKSSPG2v2B941HLB/r0A68SPOPCoyEiy5oe90qfCjZ72+gGR8=
X-Google-Smtp-Source: AGHT+IEoIocCWQfOAZR+v0VwMf8y02t3JJsst6mQZtIsxeuPxTjIs24h6sQVoVN5ty+G51QWUkqIWxu0IRxfgynuMCksvDsLWLRH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:376:4441:9 with SMTP id
 e9e14a558f8ab-376444101f9mr4206395ab.2.1719242121035; Mon, 24 Jun 2024
 08:15:21 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:15:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e85d76061ba43f6d@google.com>
Subject: [syzbot] [net?] WARNING in dev_deactivate_many
From: syzbot <syzbot+e9121deb112a224121e0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    819984a0dd36 kselftest: devices: Add of-fullname-regex pro..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12779c82980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ccd5ad0e0c891e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e9121deb112a224121e0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1680423e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1690b5ea980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a1c28712015/disk-819984a0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be01b9b3db3a/vmlinux-819984a0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c8994363c20/bzImage-819984a0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9121deb112a224121e0@syzkaller.appspotmail.com

 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
ref_tracker: freed in:
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 netdev_put include/linux/netdevice.h:4071 [inline]
 dev_watchdog_down net/sched/sch_generic.c:570 [inline]
 dev_deactivate_many+0x214/0xb40 net/sched/sch_generic.c:1362
 dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1396
 linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:175
 __linkwatch_run_queue+0x233/0x690 net/core/link_watch.c:234
 linkwatch_event+0x8f/0xc0 net/core/link_watch.c:277
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2496 at lib/ref_tracker.c:255 ref_tracker_free+0x61e/0x820 lib/ref_tracker.c:255
Modules linked in:
CPU: 0 PID: 2496 Comm: kworker/0:0 Not tainted 6.10.0-rc4-syzkaller-00053-g819984a0dd36 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:ref_tracker_free+0x61e/0x820 lib/ref_tracker.c:255
Code: 00 44 8b 6b 18 31 ff 44 89 ee e8 4d d8 f1 fe 45 85 ed 0f 85 a6 00 00 00 e8 3f dd f1 fe 48 8b 34 24 48 89 ef e8 83 f3 32 04 90 <0f> 0b 90 bb ea ff ff ff e9 4e fd ff ff e8 20 dd f1 fe 4c 8d 6d 44
RSP: 0018:ffffc900002d7298 EFLAGS: 00010202
RAX: 0000000000000201 RBX: ffff8881137311c0 RCX: 0000000000000000
RDX: 0000000000000202 RSI: ffffffff86c7d6e0 RDI: 0000000000000001
RBP: ffff88811fc185e0 R08: 0000000000000001 R09: fffffbfff1997dae
R10: ffffffff8ccbed77 R11: fffffffffffda9a0 R12: 1ffff9200005ae55
R13: 0000000005a60115 R14: ffff8881137311d8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae50793120 CR3: 00000001026b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 netdev_put include/linux/netdevice.h:4071 [inline]
 dev_watchdog_down net/sched/sch_generic.c:570 [inline]
 dev_deactivate_many+0x214/0xb40 net/sched/sch_generic.c:1362
 __dev_close_many+0x145/0x310 net/core/dev.c:1543
 dev_close_many+0x24c/0x6a0 net/core/dev.c:1581
 unregister_netdevice_many_notify+0x46d/0x19f0 net/core/dev.c:11194
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11295
 usbnet_disconnect+0xed/0x500 drivers/net/usb/usbnet.c:1621
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
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

