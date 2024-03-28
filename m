Return-Path: <netdev+bounces-82736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24588F832
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3331B212A1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1AA4F8AB;
	Thu, 28 Mar 2024 06:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E004F88E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608919; cv=none; b=bHfw6wB8VbQHWLpsGR2YI9fe0d20FZXRxAgakvFFacnzM9PSrsVkVo82HcJrnL7n9JcTqbn2rrHf4Jslm81XeByUQ4d2dp6xKDYh7MZ9plT+iAQ5pHFpkDHTheMo4hdmsW6QLvWzFJgyr28suEnV4CJmKTDmmCoxhddbYsQdVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608919; c=relaxed/simple;
	bh=2fyVaUsZFTan7wuwhsap+GM+OrmCodYjQgxDz3cqFxs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JV7p3aUPH5JkHRhLPj4pEz63JbiqzwRx3vJzXGbHaNQNdZmePWbLU6gSpl2j3EE2Ml3Ywf7TuJcyoiOIVrgxnTgF+tQFdDAkObMZ0foD4eaAf+t43ZgxyQ0WWLOyqO5BjLLPQksMoTx0g2/pFgvJzNt6+KlxKnrRtjXVSD/yreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d022d0c76aso54166539f.3
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 23:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711608917; x=1712213717;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E/rXIt+7CvbLzlbJO4yXgpA0XKHTyInmlxo4zDQfLE=;
        b=Br1kRYy+/TgUJxWQdaRwVpM/NKbf0s5zF/JBZ0BgH96fsG9WlAVg6g5XB/naZR95yD
         dtnP/edJFhuT7s9NOe3fFJAHk42lyhFF5qgSaiaDiiM/uCVI+Iup/yTryQjxzJ6GZHFm
         Xo407sYInozbfXCo+XhES0zWfZfcY2cBUKu/MZtl4+ampRjDPUtE/JHoxBA0m2VEI9h+
         6batgeQG3KlDoIlH59BRcTZ7Ru3NwWHDrmoB4wnkE7V9dGCBnEgdaNVarI9VCVvbxYL3
         i/uWwIWLTuxv+GQeK/g4ntXU0mdmo5ofhu3Uzax2XlI2I+OHV35FSNG92tnnlV97LwIS
         cmTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1INjuBkZax1mnjKy6B4etq8rx0vsq6eehPVbC9BL+cJ5moYHCHnLl5ACJeaYjeXaW02f2wdlXKA6drnaHkW1n571PufNl
X-Gm-Message-State: AOJu0YwGaKdQSJPIxux0KCOycZ1/T4obGUz9Mf4B2mMFPnP7yLmm8lr0
	K8SWkTNyBqd+WsghGRbVqhhvppCsG4gwdYFucSNVMSGQn6pbqww+Yrfq9W3wZ42DVa6e+KpBZd5
	qx9rPe8CWy799fAzhylE6aOMsJi9nacFSPWtKY+FKwHG/E0WPebwSXxA=
X-Google-Smtp-Source: AGHT+IG3vAY+ssWCjAmwFEXyLitc8vwEwCfM1d4gXp1HX3hujFGheiW1S1aKADUng0Rc0gQZPGwVC1VW0Xw4KwZpFm/BPAB52QNL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4af:b0:368:7775:2df2 with SMTP id
 e15-20020a056e0204af00b0036877752df2mr27444ils.5.1711608917110; Wed, 27 Mar
 2024 23:55:17 -0700 (PDT)
Date: Wed, 27 Mar 2024 23:55:17 -0700
In-Reply-To: <000000000000f94ee2061458a2e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fc08e0614b30176@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in netdev_freemem (3)
From: syzbot <syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    498e47cd1d1f Fix build errors due to new UIO_MEM_DMA_COHER..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15236d7e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43f1e0cbdb852271
dashboard link: https://syzkaller.appspot.com/bug?extid=83845bb93916bb30c048
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a9c4f9180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-498e47cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88de02166e48/vmlinux-498e47cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f2f314f3da3/zImage-498e47cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com

cdc_ncm 2-1:1.0 usb0: register 'cdc_ncm' at usb-dummy_hcd.1-1, CDC NCM (NO ZLP), 42:42:42:42:42:42
usb 2-1: USB disconnect, device number 80
cdc_ncm 2-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.1-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 44 at lib/debugobjects.c:514 debug_print_object+0xc4/0xd8 lib/debugobjects.c:514
ODEBUG: free active (active state 0) object: 84e6c7ac object type: work_struct hint: usbnet_deferred_kevent+0x0/0x388 drivers/net/usb/usbnet.c:630
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 6.9.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<81878e9c>] (dump_backtrace) from [<81878f98>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e44 r5:00000000 r4:81fc4710
[<81878f80>] (show_stack) from [<81896734>] (__dump_stack lib/dump_stack.c:88 [inline])
[<81878f80>] (show_stack) from [<81896734>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<818966e0>] (dump_stack_lvl) from [<81896774>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82858d18
[<8189675c>] (dump_stack) from [<81879a40>] (panic+0x120/0x358 kernel/panic.c:348)
[<81879920>] (panic) from [<8024390c>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<81879920>] (panic) from [<8024390c>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c584 r2:00000001 r1:81fad394 r0:81fb4f3c
 r7:8080b850
[<80243898>] (check_panic_on_warn) from [<80243b00>] (__warn+0x7c/0x180 kernel/panic.c:694)
[<80243a84>] (__warn) from [<80243dec>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:727)
 r8:00000009 r7:820112e0 r6:df915a7c r5:82ee6c00 r4:00000000
[<80243c08>] (warn_slowpath_fmt) from [<8080b850>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:514)
 r10:00000005 r9:84e6c000 r8:81a02b44 r7:820391e8 r6:828bc414 r5:df915b24
 r4:8260ce18
[<8080b78c>] (debug_print_object) from [<8080d0e8>] (__debug_check_no_obj_freed lib/debugobjects.c:989 [inline])
[<8080b78c>] (debug_print_object) from [<8080d0e8>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1019)
 r8:84e6c800 r7:84e6c7ac r6:00000100 r5:00000003 r4:00000000
[<8080ce94>] (debug_check_no_obj_freed) from [<804b2650>] (slab_free_hook mm/slub.c:2078 [inline])
[<8080ce94>] (debug_check_no_obj_freed) from [<804b2650>] (slab_free mm/slub.c:4280 [inline])
[<8080ce94>] (debug_check_no_obj_freed) from [<804b2650>] (kfree+0x1a0/0x334 mm/slub.c:4390)
 r10:82775a30 r9:84d86080 r8:84e6c000 r7:8045a7ac r6:82c023c0 r5:ddea96a0
 r4:84e6c000
[<804b24b0>] (kfree) from [<8045a7ac>] (kvfree+0x2c/0x30 mm/util.c:680)
 r10:82775a30 r9:84d86080 r8:84e6c000 r7:00000000 r6:84f41900 r5:84f71480
 r4:84e6c000
[<8045a780>] (kvfree) from [<813b36cc>] (netdev_freemem+0x1c/0x20 net/core/dev.c:10797)
 r5:84f71480 r4:84e6c000
[<813b36b0>] (netdev_freemem) from [<813ee72c>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2031)
[<813ee700>] (netdev_release) from [<80a41a70>] (device_release+0x38/0xa8 drivers/base/core.c:2565)
 r5:84f71480 r4:84e6c3b8
[<80a41a38>] (device_release) from [<81852e00>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80a41a38>] (device_release) from [<81852e00>] (kobject_release lib/kobject.c:720 [inline])
[<80a41a38>] (device_release) from [<81852e00>] (kref_put include/linux/kref.h:65 [inline])
[<80a41a38>] (device_release) from [<81852e00>] (kobject_put+0xc8/0x1f8 lib/kobject.c:737)
 r5:81b485c4 r4:84e6c3b8
[<81852d38>] (kobject_put) from [<80a41cf8>] (put_device+0x18/0x1c drivers/base/core.c:3813)
 r7:84d86400 r6:84e6c10c r5:84e6c000 r4:00000000
[<80a41ce0>] (put_device) from [<813a4a18>] (free_netdev+0x108/0x188 net/core/dev.c:10993)
[<813a4910>] (free_netdev) from [<80d110f0>] (usbnet_disconnect+0xac/0xf0 drivers/net/usb/usbnet.c:1636)
 r6:84e6c774 r5:84e6c660 r4:00000000
[<80d11044>] (usbnet_disconnect) from [<80d6c068>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:84d86430 r6:82775a30 r5:00000000 r4:84d86400
[<80d6bfe4>] (usb_unbind_interface) from [<80a49b4c>] (device_remove drivers/base/dd.c:568 [inline])
[<80d6bfe4>] (usb_unbind_interface) from [<80a49b4c>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:84d86080 r9:828eccc4 r8:00000044 r7:84d86474 r6:82775a30 r5:00000000
 r4:84d86430
[<80a49ae8>] (device_remove) from [<80a4b064>] (__device_release_driver drivers/base/dd.c:1270 [inline])
[<80a49ae8>] (device_remove) from [<80a4b064>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1293)
 r5:00000000 r4:84d86430
[<80a4aed8>] (device_release_driver_internal) from [<80a4b0f0>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1316)
 r9:828eccc4 r8:82eaa540 r7:82eaa538 r6:82eaa50c r5:84d86430 r4:82eaa530
[<80a4b0d8>] (device_release_driver) from [<80a491f0>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a49124>] (bus_remove_device) from [<80a43274>] (device_del+0x15c/0x3bc drivers/base/core.c:3894)
 r9:828eccc4 r8:84d86400 r7:82ee6c00 r6:84f72e08 r5:04208060 r4:84d86430
[<80a43118>] (device_del) from [<80d69ac4>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:84d86400 r7:84d86000 r6:84f72e08 r5:00000001
 r4:00000038
[<80d699e8>] (usb_disable_device) from [<80d5e930>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2296)
 r10:00000001 r9:84110200 r8:84d860c4 r7:8391e400 r6:84d86080 r5:84d86000
 r4:60000013
[<80d5e844>] (usb_disconnect) from [<80d615e0>] (hub_port_connect drivers/usb/core/hub.c:5352 [inline])
[<80d5e844>] (usb_disconnect) from [<80d615e0>] (hub_port_connect_change drivers/usb/core/hub.c:5652 [inline])
[<80d5e844>] (usb_disconnect) from [<80d615e0>] (port_event drivers/usb/core/hub.c:5812 [inline])
[<80d5e844>] (usb_disconnect) from [<80d615e0>] (hub_event+0xe78/0x194c drivers/usb/core/hub.c:5894)
 r10:00000001 r9:00000100 r8:83b28500 r7:84d86000 r6:8391dc00 r5:8391e610
 r4:00000001
[<80d60768>] (hub_event) from [<802665fc>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r10:83400a05 r9:82ee6c00 r8:00000180 r7:ddde3f00 r6:83400a00 r5:83b28500
 r4:82eae680
[<80266444>] (process_one_work) from [<80267320>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<80266444>] (process_one_work) from [<80267320>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:82ee6c00 r9:82eae6ac r8:61c88647 r7:ddde3f20 r6:82604d40 r5:ddde3f00
 r4:82eae680
[<80267134>] (worker_thread) from [<80270034>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df879e90 r8:82eb0500 r7:82eae680 r6:80267134 r5:82ee6c00
 r4:82eb0280
[<8026ff30>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf915fb0 to 0xdf915ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026ff30 r4:82eb0280
Rebooting in 86400 seconds..


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

