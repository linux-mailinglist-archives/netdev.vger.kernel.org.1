Return-Path: <netdev+bounces-118719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16759528E5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E6A1C225DD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEF149DE3;
	Thu, 15 Aug 2024 05:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD161474C5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699354; cv=none; b=sIq1tFMvBtvP19dWv8n330VCyDu1kKc+1cdg//cIykcjJzlLPND7FHlR7i2x5GtJUqeZTedtdYeMOXXsHB99szeUIj9yDGFEHGaPd7Usm4wIi2tmM1qHwHK4B/mqaTuYm9aXUgfgmYOfpjuQUPMNqPACab8MXrJvz7Cg+KPfOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699354; c=relaxed/simple;
	bh=URV/MlZthj7juKk+yWXjJ1JpskzrHIiSgB34s+l9GF0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jmRtnmEy8yZXnnckwzG3FQYc4bj3mfZosFC7lLHEtoxQcPwIhslMSVRQrPtaCjdtzahxZHsoiuMiMe/b9COP6rWtrc8WT0//60mGIfjbKQZDYvw1VF/vQiE7MjpMZFKYT+GwwvGdnf9PJX5VO86yAzuAnNtmph95TKKu5OmMLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-397e0efded3so6889725ab.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 22:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699351; x=1724304151;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6c3T7dzjd8G3NPI3QuE2OHQXYpsfhbpSHDfwsIpSams=;
        b=IXApM/zf4eUwpKa2w8tm2WGf027gPNUZcQ/HMbWA1p2yGdlkT7ZGVWlSa1/WDYiz6R
         /g4WxyUDXXnM/xW9hK679g5nFZvoVN+FFFSqDQ0B+wVyipseI7UaM5f8dmRsvFHrdnlX
         OtpBDQginO43p+U4dSSl97NaUrswAU0mPQmNoOWnlAB2riPbWUC6kjEEc9Nmxesf65HE
         1eF9WffOg/8C5k/Q4Zhplz1ah0s8rMUM0Y0gZ9IH/MeJIzChkhU9C6Nj8O43QhEKu6LM
         NQiXtY1pxRAjeW/cthRxLZsgV/VRUy0ai9ITsQsgNoqFe0JwfY1LreoXyvU2eYAuLmMt
         lnjA==
X-Forwarded-Encrypted: i=1; AJvYcCU9nRUfqghALloDMAxfhzNMQdV0tPaKoEEgT6QXxISEixwGbpUP8t/eri7d9rbij5DPM2rDBR7QjiQUfoRMLXIBfZyk6420
X-Gm-Message-State: AOJu0YyMynny4O0tTk2upnx/3e8AhAeEflQUxjW6jyY8BgWoHzjs09Cx
	dlV7HEgiXhzL/S/fA0Lfu0cHmKxCP3zJS9aquayIVZf5gBdffKa93dSR1ei78+2TF8zFS34g9SL
	uWWRG+m+cR0TpjK1wC+TXwDk2Vbuz/kJJNbFqEPa0itwJNoGvRbCpEYI=
X-Google-Smtp-Source: AGHT+IE8quMni3/bXkdVqmwV5ZyXvamIBo+gSdYP/foBlL8UH1pv3O06k7ukzGyeTu+oBlf6yo0r+vZcpBCaEtkIh579lO5he31z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39d12461c72mr4019665ab.2.1723699351159; Wed, 14 Aug 2024
 22:22:31 -0700 (PDT)
Date: Wed, 14 Aug 2024 22:22:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000869803061fb207d1@google.com>
Subject: [syzbot] [net?] [usb?] WARNING: ODEBUG bug in get_taint
From: syzbot <syzbot+ffe5c7db7c30a0fbb165@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d07b43284ab3 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a20ad5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27ce3a8f7447229f
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe5c7db7c30a0fbb165
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-d07b4328.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79ba6ea858b2/vmlinux-d07b4328.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64a75a9460ef/zImage-d07b4328.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe5c7db7c30a0fbb165@syzkaller.appspotmail.com

asix 1-1:0.0 eth1: register 'asix' at usb-dummy_hcd.0-1, ASIX AX88178 USB 2.0 Ethernet, 02:0d:96:66:af:53
usb 1-1: USB disconnect, device number 4
asix 1-1:0.0 eth1: unregister 'asix' usb-dummy_hcd.0-1, ASIX AX88178 USB 2.0 Ethernet
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3790 at lib/debugobjects.c:515 debug_print_object+0xc4/0xd8 lib/debugobjects.c:515
ODEBUG: free active (active state 0) object: 84babfcc object type: work_struct hint: usbnet_deferred_kevent+0x0/0x388 drivers/net/usb/usbnet.c:630
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 3790 Comm: kworker/1:4 Not tainted 6.11.0-rc3-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<81954e48>] (dump_backtrace) from [<81954f44>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:826228c4 r5:00000000 r4:8200bc94
[<81954f2c>] (show_stack) from [<81972c18>] (__dump_stack lib/dump_stack.c:93 [inline])
[<81954f2c>] (show_stack) from [<81972c18>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:119)
[<81972bc4>] (dump_stack_lvl) from [<81972c58>] (dump_stack+0x18/0x1c lib/dump_stack.c:128)
 r5:00000000 r4:8286bd18
[<81972c40>] (dump_stack) from [<819559ec>] (panic+0x120/0x358 kernel/panic.c:348)
[<819558cc>] (panic) from [<80242204>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<819558cc>] (panic) from [<80242204>] (get_taint+0x0/0x1c kernel/panic.c:236)
 r3:8260c5c4 r2:00000001 r1:81ff44b8 r0:81ffc290
 r7:808269c4
[<80242190>] (check_panic_on_warn) from [<80242358>] (__warn+0x7c/0x180 kernel/panic.c:735)
[<802422dc>] (__warn) from [<80242644>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:768)
 r8:00000009 r7:8205a9ac r6:dfdada8c r5:840eb000 r4:00000000
[<80242460>] (warn_slowpath_fmt) from [<808269c4>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:515)
 r10:00000005 r9:84bab800 r8:81a01c24 r7:82084f34 r6:828cf69c r5:dfdadb34
 r4:8260cda4
[<80826900>] (debug_print_object) from [<80828264>] (__debug_check_no_obj_freed lib/debugobjects.c:990 [inline])
[<80826900>] (debug_print_object) from [<80828264>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1020)
 r8:84bac000 r7:84babfcc r6:00000100 r5:00000003 r4:00000000
[<80828010>] (debug_check_no_obj_freed) from [<804bc624>] (slab_free_hook mm/slub.c:2219 [inline])
[<80828010>] (debug_check_no_obj_freed) from [<804bc624>] (slab_free mm/slub.c:4473 [inline])
[<80828010>] (debug_check_no_obj_freed) from [<804bc624>] (kfree+0x198/0x338 mm/slub.c:4594)
 r10:82777c18 r9:849a7480 r8:84bab800 r7:80461638 r6:82c023c0 r5:ddea33a0
 r4:84bab800
[<804bc48c>] (kfree) from [<80461638>] (kvfree+0x2c/0x30 mm/util.c:696)
 r10:82777c18 r9:849a7480 r8:84bab800 r7:00000000 r6:8503a5c0 r5:85081f80
 r4:84bab800
[<8046160c>] (kvfree) from [<814bdc9c>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2031)
 r5:85081f80 r4:84bab800
[<814bdc70>] (netdev_release) from [<80a6d5c8>] (device_release+0x38/0xa8 drivers/base/core.c:2582)
 r5:85081f80 r4:84babbc0
[<80a6d590>] (device_release) from [<8192ecd0>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80a6d590>] (device_release) from [<8192ecd0>] (kobject_release lib/kobject.c:720 [inline])
[<80a6d590>] (device_release) from [<8192ecd0>] (kref_put include/linux/kref.h:65 [inline])
[<80a6d590>] (device_release) from [<8192ecd0>] (kobject_put+0xc8/0x1f8 lib/kobject.c:737)
 r5:81b4b6cc r4:84babbc0
[<8192ec08>] (kobject_put) from [<80a6d7f4>] (put_device+0x18/0x1c drivers/base/core.c:3790)
 r7:849a4000 r6:84bab90c r5:84bab800 r4:00000000
[<80a6d7dc>] (put_device) from [<81472c04>] (free_netdev+0x114/0x18c net/core/dev.c:11197)
[<81472af0>] (free_netdev) from [<80d4ef68>] (usbnet_disconnect+0xac/0xf0 drivers/net/usb/usbnet.c:1636)
 r6:84babf94 r5:84babe80 r4:00000000
[<80d4eebc>] (usbnet_disconnect) from [<80db6c88>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:849a4030 r6:82777c18 r5:00000000 r4:849a4000
[<80db6c04>] (usb_unbind_interface) from [<80a756cc>] (device_remove drivers/base/dd.c:568 [inline])
[<80db6c04>] (usb_unbind_interface) from [<80a756cc>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:00000000 r9:849a7480 r8:00000044 r7:849a4074 r6:82777c18 r5:00000000
 r4:849a4030
[<80a75668>] (device_remove) from [<80a76be4>] (__device_release_driver drivers/base/dd.c:1272 [inline])
[<80a75668>] (device_remove) from [<80a76be4>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1295)
 r5:00000000 r4:849a4030
[<80a76a58>] (device_release_driver_internal) from [<80a76c70>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1318)
 r9:849a7480 r8:82fbc140 r7:82fbc138 r6:82fbc10c r5:849a4030 r4:82fbc130
[<80a76c58>] (device_release_driver) from [<80a74d50>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a74c84>] (bus_remove_device) from [<80a6ee60>] (device_del+0x148/0x38c drivers/base/core.c:3871)
 r9:849a7480 r8:840eb000 r7:04208060 r6:00000000 r5:849a4030 r4:849a4074
[<80a6ed18>] (device_del) from [<80db46a4>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:849a4000 r7:849a7400 r6:851af308 r5:849a7400
 r4:60000113
[<80db45c8>] (usb_disable_device) from [<80da9504>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2304)
 r10:00000001 r9:84348800 r8:849a74c4 r7:83c83000 r6:849a7480 r5:849a7400
 r4:60000113
[<80da9418>] (usb_disconnect) from [<80dac1b4>] (hub_port_connect drivers/usb/core/hub.c:5361 [inline])
[<80da9418>] (usb_disconnect) from [<80dac1b4>] (hub_port_connect_change drivers/usb/core/hub.c:5661 [inline])
[<80da9418>] (usb_disconnect) from [<80dac1b4>] (port_event drivers/usb/core/hub.c:5821 [inline])
[<80da9418>] (usb_disconnect) from [<80dac1b4>] (hub_event+0xe78/0x194c drivers/usb/core/hub.c:5903)
 r10:00000001 r9:00000100 r8:8390af00 r7:849a7400 r6:83c82800 r5:83c83210
 r4:00000001
[<80dab33c>] (hub_event) from [<80265f30>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3231)
 r10:82f1da05 r9:840eb000 r8:01800000 r7:ddde4000 r6:82f1da00 r5:8390af00
 r4:85005f00
[<80265d7c>] (process_one_work) from [<80266b14>] (process_scheduled_works kernel/workqueue.c:3312 [inline])
[<80265d7c>] (process_one_work) from [<80266b14>] (worker_thread+0x1ec/0x3f4 kernel/workqueue.c:3390)
 r10:840eb000 r9:85005f2c r8:61c88647 r7:ddde4020 r6:82604d40 r5:ddde4000
 r4:85005f00
[<80266928>] (worker_thread) from [<8026fb6c>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df87de78 r8:84ba0280 r7:85005f00 r6:80266928 r5:840eb000
 r4:8500c1c0
[<8026fa68>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfdadfb0 to 0xdfdadff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fa68 r4:8500c1c0
Rebooting in 86400 seconds..


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

