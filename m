Return-Path: <netdev+bounces-81381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4E887A10
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7711C20B8C
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988F5813E;
	Sat, 23 Mar 2024 19:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D655E53
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711220786; cv=none; b=jLAO5x5QVAYqm2zfFNDnWh/pm9FfzUqyijDyYkHnIJLOaq7qC/tGGZFlUZQacgEsAVJAv2/gbbxmVW4EYS+wMQ0prDQaWFrrdLvwS/HnnqpHmN2swKtozpLD5dQ6dLpMP1Pt9lM/pzhhl6YcPqDRRMsR1ieVOwiiTZBAPdZsGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711220786; c=relaxed/simple;
	bh=hJ3SpCFTtEoLUMRBGQRGufcb8/uTAuDr6RGbPrKf78Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=glKk+pj9oq7Ql56/5PTC/yyS9/z+B8qnj8aH6ZhzMRFKRb6GQmp54lTrpnz2qSZ0SvaPe3eS4l6gw61BLpqnDvoEZzplMuGbOKw24MbE/tuSMf++t5rPvmRXfZDjdN0W7uS0Ro5soU7p7Y3s0CQ1y5Q3hdt8yQYEM0LJ9ZyCyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc61b1d690so234717039f.3
        for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 12:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711220784; x=1711825584;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvGGHxv2dVjZMIRQKVzk860suXN7W25uUimRQfWJUFc=;
        b=WWEbt76N8bYKySE7hy+4eJxghR/XcIr14wdTBMDnacb9Ax9YbvndWeHqt2PGRKYes4
         gJFVxlPsrLJnaB/HB/78Zc2RfZsuw3PRwWoAuNZ+DDvFwWevcALjQHKUKivQ9YGawIHY
         6X9f2ctG1wQNJX0zzgNZNUIJHzNqeY7IJg/JiSZCj2HEKobdRSKjdiR6JJ9jM9cyPWn8
         B1P7LC1jlila7kLsIGq2f8nJxZ09G37P3lkcaNPsuyciNZBBa6DzR+JO41isHMj9TvYo
         f5cUxfBGWXllV+7f2uyk+6M3nC2g2XuXqiG50yRt0+6gCe93xQaRYVZ55cNSa+gwlZc0
         aiWA==
X-Forwarded-Encrypted: i=1; AJvYcCWpNDQky0ui9wFE0VSfzIUP9HGBjUSoBmASduoNjGjxDh7RXJE6wUHlWd+ZBhwDbPvK2vGNDk6QMbXXjpb4KN5dZ++oVA9f
X-Gm-Message-State: AOJu0YyvZqJTYgJCKGomOi3FduvKHzs80DwnLqsqeBz0S9GTy47afxXF
	d49ENyKa34qTmDz5x0/8pfu7HWjkss9sF6y8F2r9S4OhsR9hYlSxEOgSsekibB//eNK+X6zFAiG
	XcYa2Nsv9sfcwIKYZ6ZMzkCeXHYGj3J9ZyoMpDRBMTllFEh5t+NwBAB4=
X-Google-Smtp-Source: AGHT+IEtIusLw+RBra1ey8ityXWDhHKxsK5wVZfi4Oq6XlLaZWkdOe1xgUYc9tuIeQAeQh/FP9GOntrT6CKA7+RfKrHF12HpLGiz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2191:b0:476:ef9f:d5fb with SMTP id
 s17-20020a056638219100b00476ef9fd5fbmr63358jaj.6.1711220784184; Sat, 23 Mar
 2024 12:06:24 -0700 (PDT)
Date: Sat, 23 Mar 2024 12:06:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f94ee2061458a2e0@google.com>
Subject: [syzbot] [net?] WARNING: ODEBUG bug in netdev_freemem (3)
From: syzbot <syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    484193fecd2b Merge tag 'powerpc-6.9-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1268a7b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14c4d3466a37c9f4
dashboard link: https://syzkaller.appspot.com/bug?extid=83845bb93916bb30c048
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-484193fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e8ed1ba07eb/vmlinux-484193fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/267cfc5f351e/zImage-484193fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83845bb93916bb30c048@syzkaller.appspotmail.com

cdc_ncm 2-1:1.0 usb0: register 'cdc_ncm' at usb-dummy_hcd.1-1, CDC NCM (NO ZLP), 42:42:42:42:42:42
usb 2-1: USB disconnect, device number 97
cdc_ncm 2-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.1-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8555 at lib/debugobjects.c:514 debug_print_object+0xc4/0xd8 lib/debugobjects.c:514
ODEBUG: free active (active state 0) object: 8477b7ac object type: work_struct hint: usbnet_deferred_kevent+0x0/0x388 drivers/net/usb/usbnet.c:630
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 8555 Comm: kworker/0:2 Not tainted 6.8.0-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<81878b5c>] (dump_backtrace) from [<81878c58>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e44 r5:00000000 r4:81fc46f8
[<81878c40>] (show_stack) from [<818963f4>] (__dump_stack lib/dump_stack.c:88 [inline])
[<81878c40>] (show_stack) from [<818963f4>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<818963a0>] (dump_stack_lvl) from [<81896434>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82858d18
[<8189641c>] (dump_stack) from [<81879700>] (panic+0x120/0x358 kernel/panic.c:348)
[<818795e0>] (panic) from [<8024390c>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<818795e0>] (panic) from [<8024390c>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c584 r2:00000001 r1:81fad380 r0:81fb4f28
 r7:8080b528
[<80243898>] (check_panic_on_warn) from [<80243b00>] (__warn+0x7c/0x180 kernel/panic.c:694)
[<80243a84>] (__warn) from [<80243dec>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:727)
 r8:00000009 r7:820112c8 r6:dfdada7c r5:834b0c00 r4:00000000
[<80243c08>] (warn_slowpath_fmt) from [<8080b528>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:514)
 r10:00000005 r9:8477b000 r8:81a02b44 r7:820391d0 r6:828bc414 r5:dfdadb24
 r4:8260ce18
[<8080b464>] (debug_print_object) from [<8080cdc0>] (__debug_check_no_obj_freed lib/debugobjects.c:989 [inline])
[<8080b464>] (debug_print_object) from [<8080cdc0>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1019)
 r8:8477b800 r7:8477b7ac r6:00000100 r5:00000003 r4:00000000
[<8080cb6c>] (debug_check_no_obj_freed) from [<804b2458>] (slab_free_hook mm/slub.c:2078 [inline])
[<8080cb6c>] (debug_check_no_obj_freed) from [<804b2458>] (slab_free mm/slub.c:4280 [inline])
[<8080cb6c>] (debug_check_no_obj_freed) from [<804b2458>] (kfree+0x1a0/0x334 mm/slub.c:4390)
 r10:82775a30 r9:8513d880 r8:8477b000 r7:8045a5b4 r6:82c023c0 r5:dde99ce0
 r4:8477b000
[<804b22b8>] (kfree) from [<8045a5b4>] (kvfree+0x2c/0x30 mm/util.c:680)
 r10:82775a30 r9:8513d880 r8:8477b000 r7:00000000 r6:84cd7280 r5:85154100
 r4:8477b000
[<8045a588>] (kvfree) from [<813b3384>] (netdev_freemem+0x1c/0x20 net/core/dev.c:10797)
 r5:85154100 r4:8477b000
[<813b3368>] (netdev_freemem) from [<813ee3e4>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2031)
[<813ee3b8>] (netdev_release) from [<80a41748>] (device_release+0x38/0xa8 drivers/base/core.c:2565)
 r5:85154100 r4:8477b3b8
[<80a41710>] (device_release) from [<81852ac0>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80a41710>] (device_release) from [<81852ac0>] (kobject_release lib/kobject.c:720 [inline])
[<80a41710>] (device_release) from [<81852ac0>] (kref_put include/linux/kref.h:65 [inline])
[<80a41710>] (device_release) from [<81852ac0>] (kobject_put+0xc8/0x1f8 lib/kobject.c:737)
 r5:81b48594 r4:8477b3b8
[<818529f8>] (kobject_put) from [<80a419d0>] (put_device+0x18/0x1c drivers/base/core.c:3813)
 r7:8513c800 r6:8477b10c r5:8477b000 r4:00000000
[<80a419b8>] (put_device) from [<813a46d0>] (free_netdev+0x108/0x188 net/core/dev.c:10993)
[<813a45c8>] (free_netdev) from [<80d10dc8>] (usbnet_disconnect+0xac/0xf0 drivers/net/usb/usbnet.c:1636)
 r6:8477b774 r5:8477b660 r4:00000000
[<80d10d1c>] (usbnet_disconnect) from [<80d6bd40>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:8513c830 r6:82775a30 r5:00000000 r4:8513c800
[<80d6bcbc>] (usb_unbind_interface) from [<80a49824>] (device_remove drivers/base/dd.c:568 [inline])
[<80d6bcbc>] (usb_unbind_interface) from [<80a49824>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:8513d880 r9:828eccc4 r8:00000044 r7:8513c874 r6:82775a30 r5:00000000
 r4:8513c830
[<80a497c0>] (device_remove) from [<80a4ad3c>] (__device_release_driver drivers/base/dd.c:1270 [inline])
[<80a497c0>] (device_remove) from [<80a4ad3c>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1293)
 r5:00000000 r4:8513c830
[<80a4abb0>] (device_release_driver_internal) from [<80a4adc8>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1316)
 r9:828eccc4 r8:82ecaf40 r7:82ecaf38 r6:82ecaf0c r5:8513c830 r4:82ecaf30
[<80a4adb0>] (device_release_driver) from [<80a48ec8>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a48dfc>] (bus_remove_device) from [<80a42f4c>] (device_del+0x15c/0x3bc drivers/base/core.c:3894)
 r9:828eccc4 r8:8513c800 r7:834b0c00 r6:8533a608 r5:04208060 r4:8513c830
[<80a42df0>] (device_del) from [<80d6979c>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:8513c800 r7:8513d800 r6:8533a608 r5:00000001
 r4:00000038
[<80d696c0>] (usb_disable_device) from [<80d5e608>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2296)
 r10:00000001 r9:85ca7a00 r8:8513d8c4 r7:83766000 r6:8513d880 r5:8513d800
 r4:60000013
[<80d5e51c>] (usb_disconnect) from [<80d612b8>] (hub_port_connect drivers/usb/core/hub.c:5352 [inline])
[<80d5e51c>] (usb_disconnect) from [<80d612b8>] (hub_port_connect_change drivers/usb/core/hub.c:5652 [inline])
[<80d5e51c>] (usb_disconnect) from [<80d612b8>] (port_event drivers/usb/core/hub.c:5812 [inline])
[<80d5e51c>] (usb_disconnect) from [<80d612b8>] (hub_event+0xe78/0x194c drivers/usb/core/hub.c:5894)
 r10:00000001 r9:00000100 r8:83976300 r7:8513d800 r6:83cf9400 r5:83766210
 r4:00000001
[<80d60440>] (hub_event) from [<802665fc>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r10:82fcbe05 r9:834b0c00 r8:00000080 r7:dddcff00 r6:82fcbe00 r5:83976300
 r4:84efea80
[<80266444>] (process_one_work) from [<80267320>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<80266444>] (process_one_work) from [<80267320>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:834b0c00 r9:84efeaac r8:61c88647 r7:dddcff20 r6:82604d40 r5:dddcff00
 r4:84efea80
[<80267134>] (worker_thread) from [<80270034>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:e098de90 r8:8466cec0 r7:84efea80 r6:80267134 r5:834b0c00
 r4:84e6d1c0
[<8026ff30>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfdadfb0 to 0xdfdadff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026ff30 r4:84e6d1c0
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

