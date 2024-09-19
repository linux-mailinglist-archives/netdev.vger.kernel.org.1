Return-Path: <netdev+bounces-129004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE497CE74
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB4285243
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C113BADF;
	Thu, 19 Sep 2024 20:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577B5FEE6
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726777762; cv=none; b=T6aWqaDQgtvHW8w5CqHt7dTkpyOzg4HRNiD0Bhhflh/aamjG7s8uN+LbbiIHJQuuI0CJ/migT3mR/5l3Xy/gG3zwKtbtdYn0CwN7DN3luEX8wsH/Fnhc5LS2Bjh9Uo/ox1tXCsqUQiaIB6pineA4PG74jjceZjcyw/teNL4zLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726777762; c=relaxed/simple;
	bh=DAJqHls5Z0Gh1+rOswdQCFx5R8rtot6DM8V0KKD9u4k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dcPDcIlGg/u1HXleLZuhylcq7uo/GyuX9IPMWroCQTesnTTjozTeyhzJPCw01Yb89B8DlNm2DCBWNzYzWkWiZfrchQfur7TKX8Dhc+P13ZHxh8gxC4bozSz+swLTvUq6c5QmwLcswnOUojZW1geLvl40MH1j7fAP/unKF2R2VQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f4e119c57so13807365ab.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726777760; x=1727382560;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DN2914apgWymUOCk6lZsIDS6FL9SL9oIBlj62IVcVU=;
        b=axV7kVnQF6KR24IBX6x6D3YptFt+fOk0H3Adat4foJKmZEqwgV3B2am4o4djxY11gg
         sPnJSx5lney9Nfuf6h4JTXC27d1elHqnpBZ+xa/5c0kdPCBXTyj/hBeOI6G9PrGeby/n
         6jTshFJX3KIiyEWfmfaDeb5yMLAOTZ2Y3cXUWf2K6Kuhek4HUJaJ5gw1EW2ozSdmWDAA
         rMWWIfOK3szNfe0opYRdpYzJP7BExDbelCQMrDFzc/BueOWJ8jPMumbEqrLWsRA2KosG
         UyYItXeyGuOs2XGJrohEr9k1Bfax/8QI9I7aFCqTdhsyFecnjg9so+2rjU5Kwt498Vhi
         ZxkA==
X-Forwarded-Encrypted: i=1; AJvYcCUs1vDRxttxBnCuT25mqngU+UFMcUXMa2529PNPslQslylNk9NnB95JxwJPxVgKAiSW05c/mcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfcYmnjba0ky9tl2wdBoulJW6yYXOVvFcfJLwuu4VWyzGlnZP
	ShemEvR8qlfpA6FHJiCVTOKXeN3NWVCsw2aSglzDckgIciy/ymA+SQIF+0XLMetM6Z9SQPFVGm+
	ok1ZEaN5IwjfeM6yAWxiIA2Uriy/2BcWFISvBDQ/g99ZM0IBZ/8N//Fc=
X-Google-Smtp-Source: AGHT+IHt8Wj47NWZOei2ttjIMadLl4DpZswtTAYAvyIz4+slOz8Scr0KIqmTQb5pCEQRNc5yaXG/eW3K7MTQipobsj3PtnrqluoZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:3a0:8c83:91fb with SMTP id
 e9e14a558f8ab-3a0c8d09198mr8524195ab.20.1726777760081; Thu, 19 Sep 2024
 13:29:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:29:20 -0700
In-Reply-To: <000000000000aefb4d061e34a346@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec89a0.050a0220.29194.0044.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in linkwatch_event (4)
From: syzbot <syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    932d2d1fcb2b Merge tag 'dlm-6.12' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120d6607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c208b3605ba9ec44
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1069b69f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-932d2d1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbcb7198214b/vmlinux-932d2d1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/418eaebf4817/bzImage-932d2d1f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com

INFO: task kworker/u4:3:5245 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-05442-g932d2d1fcb2b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:23120 pid:5245  tgid:5245  ppid:2      flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900003b7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900003b7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4d08 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
2 locks held by kworker/u4:0/11:
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900003d7d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900003d7d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
1 lock held by khungtaskd/25:
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
2 locks held by kworker/u4:10/2886:
2 locks held by dhcpcd/4810:
 #0: ffff88801ca91c40 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff88801ca91c40 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
1 lock held by dhcpcd/4811:
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
2 locks held by getty/4894:
 #0: ffff88801dfa10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-execprog/5124:
 #0: ffff88803fe4bc40 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff88803fe4bc40 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
1 lock held by syz-executor/5122:
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
3 locks held by kworker/u4:1/5157:
 #0: ffff888035d58948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888035d58948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002ddfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002ddfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4d08 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
3 locks held by kworker/u4:3/5245:
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000246fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000246fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4d08 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by kworker/u4:5/5250:
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000249fd00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000249fd00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
2 locks held by kworker/u4:7/5252:
 #0: ffff88801fe3e998 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 #1: ffff88801fe28948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
2 locks held by syz-executor/5732:
 #0: ffff888035e21070 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff888035e21070 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
2 locks held by udevd/5760:
 #0: ffff8880119e8658 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff8880119e8658 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
8 locks held by syz-executor/5784:
 #0: ffff88801ed72420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
 #0: ffff88801ed72420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888046575888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880354e4968 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f561ca8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
 #4: ffff8880441160e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff8880441160e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1004
 #5: ffff888044110250 (&devlink->lock_key#23){+.+.}-{3:3}, at: nsim_drv_probe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
 #6: ffffffff8fcc4d08 (rtnl_mutex){+.+.}-{3:3}, at: nsim_init_netdevsim drivers/net/netdevsim/netdev.c:678 [inline]
 #6: ffffffff8fcc4d08 (rtnl_mutex){+.+.}-{3:3}, at: nsim_create+0x408/0x890 drivers/net/netdevsim/netdev.c:750
 #7: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #7: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #7: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
2 locks held by udevd/5785:
 #0: ffff8880122dd148 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff8880122dd148 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
2 locks held by udevd/5788:
 #0: ffff888011dcd8e0 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff888011dcd8e0 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
1 lock held by modprobe/5813:
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #0: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329
2 locks held by modprobe/5814:
 #0: ffff88804c225df0 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:700 [inline]
 #0: ffff88804c225df0 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:6015
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3898 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3923 [inline]
 #1: ffffffff8ea300e0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xcfb/0x2390 mm/page_alloc.c:4329

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.11.0-syzkaller-05442-g932d2d1fcb2b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

