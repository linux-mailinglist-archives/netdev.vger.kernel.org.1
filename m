Return-Path: <netdev+bounces-135052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F1F99BFF7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5282BB22D2E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D913FD83;
	Mon, 14 Oct 2024 06:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061313B287
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887011; cv=none; b=BCMUmwCWq1E21zhpFfNgUSQfKzrhRj8YyPh1QKRfF7VbEmo4kU9fb8SAYXK6Q4rI27PJT2lFOvqe1y2xir1BuQ4F0+kSfleDDMiLM9Yhh559oHOtgNrDeqeEjM6dvsOvT/J0zd0+hV6QqjtPsY0GhSP0N5h3bkzwaLr3JEBjtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887011; c=relaxed/simple;
	bh=mIjIjOcqcVG+Di2IlldoF087Ep8ZF9pzUQhjWXnr+ak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TiCq5xFHQ0DyR7lBWsq1bXqFlWCefWhWSQ7Rr3KLcP0M5fnNWZ6FtgdpQHLvGhCR6tIzZZ3hNhrfsLGZRt8z0yCdAB5EaMpM2sBYKoD8d+4jXDvWYRi7xmSI5rHH7AnIoU0u9/89a+utOkbaL+0NLDhfLE/3fA8093lBS4xQmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bea901ffso28963025ab.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 23:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887009; x=1729491809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxtbwJ84bc/y0EqJX+HE6FUt5NlZynbiN6WOyx11l1A=;
        b=edUH9TaIQpyXkYQtR6F1BonfwHMbzalF/Kt1GXdh7qoRKQM/ucz4x7RCBWk2Isln0f
         gLpHMLtq76soAT5ojuGODkHG2k4uRnQvAzxndoBemNINffGj77BpZlPc61X5zT7TiUN9
         sS8PFkyiFFffFDOHtwt3PPjmp7z7yZ2C5jU98xBRFjDEFZDNtg/3DWt52kJbzee5QWUr
         PX1legtQSlNBZ+LNotasZowOP/vKkvtSR/J99qp2SsNRYynDGToHGIMx19ZdLy6T+khU
         cyo48FcVJXiAJVayfg9X7FKNMJADCd25oNJxgg9vHU6TdwXeaxQoJ7uLAh/y6tVGVC92
         k4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWSm0pP652HfqYm3enRX/Ow1WzIT3VjU5sy59qPcyCA+p/7uIwoLRNF1kbtPmP7Badx8VI4CCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAfN8FGXK41w5qxwQlElQvQtlMCffTSmnc+qPbP2uKAs5sSFx
	GgFW8Ceu5libZwFuINuTEv8ytFX/jMUFalJkZDNySQ3/NR0S+NDdf+LtNa9Z7wJMS3wrXSUQztD
	VP3lcX9lMyUAFf1Q5/nCJsx/ozg0OhpNm+xpnWyvNBNhqYj9AgKILsew=
X-Google-Smtp-Source: AGHT+IEhvpvk6RwBtBhI+SRP/T8RR8GtqfK17RK+e/ly9pawZoaMZ70YjGjqRCP3XT3uT5F0jQYn48wfkJxujFGhfowSxlmomSgT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a3bcdc0bdamr59897005ab.9.1728887008864; Sun, 13 Oct 2024
 23:23:28 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:23:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb8e0.050a0220.4cbc0.0045.GAE@google.com>
Subject: [syzbot] [usb?] [net?] KASAN: slab-use-after-free Read in usbnet_deferred_kevent
From: syzbot <syzbot+a9c09d568f7e4153f53d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1728cd27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6248f0ab12f33349
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c09d568f7e4153f53d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6977fdc3f229/disk-27cc6fdf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3cb80988930/vmlinux-27cc6fdf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/030bdb347b6a/bzImage-27cc6fdf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9c09d568f7e4153f53d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in usbnet_deferred_kevent+0x2b/0xe90 drivers/net/usb/usbnet.c:1153
Read of size 8 at addr ffff88804f87d1e8 by task kworker/1:11/15337

CPU: 1 UID: 0 PID: 15337 Comm: kworker/1:11 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events usbnet_deferred_kevent
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 usbnet_deferred_kevent+0x2b/0xe90 drivers/net/usb/usbnet.c:1153
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 14552:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x211/0x430 mm/slub.c:4270
 __kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:658
 alloc_netdev_mqs+0xd1/0x1420 net/core/dev.c:11097
 usbnet_probe+0x1b9/0x2730 drivers/net/usb/usbnet.c:1712
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 14552:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 kvfree+0x47/0x50 mm/util.c:701
 device_release+0xa1/0x240 drivers/base/core.c:2575
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3783
 free_netdev+0x4b7/0x670 net/core/dev.c:11255
 usbnet_disconnect+0x25c/0x500 drivers/net/usb/usbnet.c:1652
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 schedule_work include/linux/workqueue.h:723 [inline]
 usbnet_defer_kevent+0xd2/0x270 drivers/net/usb/usbnet.c:468
 usbnet_link_change drivers/net/usb/usbnet.c:2009 [inline]
 usbnet_probe+0x1990/0x2730 drivers/net/usb/usbnet.c:1856
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88804f87c000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 4584 bytes inside of
 freed 8192-byte region [ffff88804f87c000, ffff88804f87e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4f878
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888031822b81
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b04f640 ffffea0001f7c600 dead000000000002
raw: 0000000000000000 0000000080020002 00000001f5000000 ffff888031822b81
head: 00fff00000000040 ffff88801b04f640 ffffea0001f7c600 dead000000000002
head: 0000000000000000 0000000080020002 00000001f5000000 ffff888031822b81
head: 00fff00000000003 ffffea00013e1e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10578, tgid 10578 (syz-executor), ts 527342139934, free_ts 519758587910
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x357/0x430 mm/slub.c:4270
 __kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:658
 alloc_netdev_mqs+0xd1/0x1420 net/core/dev.c:11097
 nsim_create+0x98/0xb20 drivers/net/netdevsim/netdev.c:734
 __nsim_dev_port_add+0x42c/0x7d0 drivers/net/netdevsim/dev.c:1390
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1446 [inline]
 nsim_drv_probe+0xdbf/0x1490 drivers/net/netdevsim/dev.c:1604
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
page last free pid 937 tgid 937 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2817 [inline]
 apply_to_pmd_range mm/memory.c:2861 [inline]
 apply_to_pud_range mm/memory.c:2897 [inline]
 apply_to_p4d_range mm/memory.c:2933 [inline]
 __apply_to_page_range+0x5fd/0xd30 mm/memory.c:2967
 kasan_release_vmalloc+0xac/0xc0 mm/kasan/shadow.c:525
 purge_vmap_node+0x3fb/0x930 mm/vmalloc.c:2204
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88804f87d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804f87d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804f87d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88804f87d200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804f87d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

