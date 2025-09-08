Return-Path: <netdev+bounces-220831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75040B48FC7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B728344D9C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5230BF70;
	Mon,  8 Sep 2025 13:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908F30AD1A
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338594; cv=none; b=lay/2UR63HjvsRaX2/RbHwhJUwOIEGLKBWmEHs0xU+EVP91qHzVIPUlVEDGUXUrpc5AH6p1ZTHVt+LfJFzsyHy9jfjYq1sEE+9GMPSCaDNrBscN7E2QrdI4AyL+Wm4BNuz/CUMtLWa5e2Ytnu6AquaC0qow8cqL1R3XswaGinUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338594; c=relaxed/simple;
	bh=WwjFSgide+j0J8+MEM1KQVy1lEu8jTrK1hDVyDW0bww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qonJ35Z4Eo1PskQFLA4R/1JzApJDHhvZvu7Hh5Y1rSjNvazBrgmSePKxqS15qloWk10oujL71u4F+ua5coZy0m8QZINcUmDGbjbj83Yd/6HcqodRTydqtFP4v56Bmt57Dg7Xxy8P+I/lREnY7rKTt9OjBfWQurQ1EX41FhLdh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8877131dec5so343214739f.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 06:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338591; x=1757943391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz62WV/AVE2GA/H5HhYYG8S1kte75hYZLJm6MRCusx8=;
        b=V6pC+z+8knry4lhtXKOq5ng6OKpzbn6+3QKa6trSOas+MkCv/EZd4d7iw+EBhVIED1
         MMsRDCTw3p5bmd8dGVlYUgxdpd7jPCvn5zI8WBchG/Zrj8aixiPDz00Ca/irNUmS9qFF
         4zC26MGYpS0xZKpoCDwjW0jQGyENWTXvCuiaLNoTKQdaMo4YnUsKGE97f4FWhV7RVkEC
         LFsTHsOoAg19RJ8UhpncIDkUjwgUvnRY2kqmun3hnn8fC34/xa5ELdcw1dpUuZxBHAzH
         4aGDiQjcL/ESxxZZhSl5eFC5aZrRbgvqIcTLzs8lyErPfWSIS5vQrbRXSyRGcyXwxrnw
         Fdkw==
X-Forwarded-Encrypted: i=1; AJvYcCVpR1z4HSkA4AsTZq61v0d7KQ/CvFwnQqj2A+BZzvG13BAwt9eDZf6GNgFCiTEouhzgAO+AEcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfuoy2N71NBKYKrd3OnpuKEDKZxjBLp+Fjv2OOVwMFTXFuI40
	TABg7Su5yPckPL2gJkdz6ejgsK0rdd3XUVAH5UFyBXTmUyKhf1F8x6O8SOZonJVW31cDrqAVlXf
	Di4HCclgmLYJYkZ4Dm0VZvXkvkOxFvd+OoiVbas3ZXLTnUxENSDP2oPmIg+g=
X-Google-Smtp-Source: AGHT+IGGfzTq3QneV+RLtg8/QyXJD91IY25TclMqkc100fjXHn73SB+BU6srBxJY/uMDyhe2nekn3IGCKmswEpQ0t1iS12Po6v4Z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228a:b0:408:1ec5:ddd7 with SMTP id
 e9e14a558f8ab-4081ec5dee5mr42031245ab.20.1757338590807; Mon, 08 Sep 2025
 06:36:30 -0700 (PDT)
Date: Mon, 08 Sep 2025 06:36:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bedbde.050a0220.192772.087c.GAE@google.com>
Subject: [syzbot] [net?] [usb?] WARNING: ODEBUG bug in trace_suspend_resume
From: syzbot <syzbot+51fb5a1c5d4b6056f9f1@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170e587c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ea9f6450a1c85f2
dashboard link: https://syzkaller.appspot.com/bug?extid=51fb5a1c5d4b6056f9f1
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-76eeb9b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f783b9be048/vmlinux-76eeb9b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1eaa9296791e/zImage-76eeb9b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51fb5a1c5d4b6056f9f1@syzkaller.appspotmail.com

dm9601 1-1:0.0 eth1: register 'dm9601' at usb-dummy_hcd.0-1, Davicom DM96xx USB 10/100 Ethernet, 6e:f1:98:9e:dd:08
usb 1-1: USB disconnect, device number 3
dm9601 1-1:0.0 eth1: unregister 'dm9601' usb-dummy_hcd.0-1, Davicom DM96xx USB 10/100 Ethernet
------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at lib/debugobjects.c:612 debug_print_object+0xc4/0xd8 lib/debugobjects.c:612
ODEBUG: free active (active state 0) object: 83fea804 object type: work_struct hint: usbnet_deferred_kevent+0x0/0x38c drivers/net/usb/usbnet.c:1862
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<80201a24>] (dump_backtrace) from [<80201b20>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:8281f77c r5:00000000 r4:82260afc
[<80201b08>] (show_stack) from [<8021fbe4>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201b08>] (show_stack) from [<8021fbe4>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<8021fb90>] (dump_stack_lvl) from [<8021fc24>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82a77d18
[<8021fc0c>] (dump_stack) from [<80202624>] (vpanic+0x10c/0x30c kernel/panic.c:430)
[<80202518>] (vpanic) from [<80202858>] (trace_suspend_resume+0x0/0xd8 kernel/panic.c:566)
 r7:808dcb04
[<80202824>] (panic) from [<80254960>] (check_panic_on_warn kernel/panic.c:323 [inline])
[<80202824>] (panic) from [<80254960>] (get_taint+0x0/0x1c kernel/panic.c:318)
 r3:8280c684 r2:00000001 r1:82247518 r0:8224ef94
[<802548e8>] (check_panic_on_warn) from [<80254ac4>] (__warn+0x80/0x188 kernel/panic.c:837)
[<80254a44>] (__warn) from [<80254db4>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:872)
 r8:00000009 r7:822b9fa4 r6:df845a84 r5:83210000 r4:00000000
[<80254bd0>] (warn_slowpath_fmt) from [<808dcb04>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:612)
 r10:00000005 r9:83fea000 r8:81c01e68 r7:822e5578 r6:82ae3d64 r5:df845b2c
 r4:8280ccb8
[<808dca40>] (debug_print_object) from [<808de568>] (__debug_check_no_obj_freed lib/debugobjects.c:1099 [inline])
[<808dca40>] (debug_print_object) from [<808de568>] (debug_check_no_obj_freed+0x25c/0x2a4 lib/debugobjects.c:1129)
 r8:83feb000 r7:83fea804 r6:00000100 r5:00000003 r4:00000000
[<808de30c>] (debug_check_no_obj_freed) from [<804ff448>] (slab_free_hook mm/slub.c:2353 [inline])
[<808de30c>] (debug_check_no_obj_freed) from [<804ff448>] (slab_free mm/slub.c:4695 [inline])
[<808de30c>] (debug_check_no_obj_freed) from [<804ff448>] (kfree+0x190/0x394 mm/slub.c:4894)
 r10:00000100 r9:8297e2a0 r8:83fea000 r7:805002d4 r6:83002480 r5:dde88ca0
 r4:83fea000
[<804ff2b8>] (kfree) from [<805002d4>] (kvfree+0x2c/0x30 mm/slub.c:5110)
 r10:00000100 r9:8297e2a0 r8:83fea000 r7:00000000 r6:85cfb6c0 r5:85ce5380
 r4:83fea000
[<805002a8>] (kvfree) from [<815c2d70>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2250)
 r5:85ce5380 r4:83fea000
[<815c2d44>] (netdev_release) from [<80b3d638>] (device_release+0x38/0xa8 drivers/base/core.c:2565)
 r5:85ce5380 r4:83fea3a0
[<80b3d600>] (device_release) from [<81a13a90>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80b3d600>] (device_release) from [<81a13a90>] (kobject_release lib/kobject.c:720 [inline])
[<80b3d600>] (device_release) from [<81a13a90>] (kref_put include/linux/kref.h:65 [inline])
[<80b3d600>] (device_release) from [<81a13a90>] (kobject_put+0xa0/0x1f4 lib/kobject.c:737)
 r5:81d4ebec r4:83fea3a0
[<81a139f0>] (kobject_put) from [<80b3d884>] (put_device+0x18/0x1c drivers/base/core.c:3797)
 r7:000000c0 r6:00000000 r5:00000000 r4:83fea000
[<80b3d86c>] (put_device) from [<815733f0>] (free_netdev+0x190/0x248 net/core/dev.c:12002)
[<81573260>] (free_netdev) from [<80e326e0>] (usbnet_disconnect+0xb8/0xfc drivers/net/usb/usbnet.c:1673)
 r7:85c75400 r6:83fea7d4 r5:83fea6c0 r4:00000000
[<80e32628>] (usbnet_disconnect) from [<80e9ce4c>] (usb_unbind_interface+0x84/0x2bc drivers/usb/core/driver.c:458)
 r8:85c77c88 r7:85c75474 r6:85c75430 r5:00000000 r4:85c77c00
[<80e9cdc8>] (usb_unbind_interface) from [<80b45a00>] (device_remove drivers/base/dd.c:571 [inline])
[<80e9cdc8>] (usb_unbind_interface) from [<80b45a00>] (device_remove+0x64/0x6c drivers/base/dd.c:563)
 r10:00000100 r9:85c77c88 r8:00000044 r7:85c75474 r6:8297e2a0 r5:00000000
 r4:85c75430
[<80b4599c>] (device_remove) from [<80b46ef0>] (__device_release_driver drivers/base/dd.c:1274 [inline])
[<80b4599c>] (device_remove) from [<80b46ef0>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1297)
 r5:00000000 r4:85c75430
[<80b46d64>] (device_release_driver_internal) from [<80b46f7c>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1320)
 r9:85c77c88 r8:8335cd40 r7:8335cd38 r6:8335cd0c r5:85c75430 r4:8335cd30
[<80b46f64>] (device_release_driver) from [<80b45040>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:579)
[<80b44f74>] (bus_remove_device) from [<80b3f2d8>] (device_del+0x148/0x38c drivers/base/core.c:3878)
 r9:85c77c88 r8:83210000 r7:04208060 r6:00000000 r5:85c75430 r4:85c75474
[<80b3f190>] (device_del) from [<80e9a888>] (usb_disable_device+0xd4/0x1e8 drivers/usb/core/message.c:1418)
 r10:00000100 r9:00000000 r8:00000000 r7:85c75400 r6:85c77c00 r5:85d09588
 r4:00000002
[<80e9a7b4>] (usb_disable_device) from [<80e8f650>] (usb_disconnect+0xec/0x2ac drivers/usb/core/hub.c:2344)
 r9:84966e00 r8:85c77ccc r7:83f41000 r6:85c77c88 r5:85c77c00 r4:60000013
[<80e8f564>] (usb_disconnect) from [<80e9264c>] (hub_port_connect drivers/usb/core/hub.c:5406 [inline])
[<80e8f564>] (usb_disconnect) from [<80e9264c>] (hub_port_connect_change drivers/usb/core/hub.c:5706 [inline])
[<80e8f564>] (usb_disconnect) from [<80e9264c>] (port_event drivers/usb/core/hub.c:5870 [inline])
[<80e8f564>] (usb_disconnect) from [<80e9264c>] (hub_event+0x1194/0x1950 drivers/usb/core/hub.c:5952)
 r10:00000100 r9:83ce2f2c r8:83f40800 r7:85c77c00 r6:83ce2800 r5:00000001
 r4:00000001
[<80e914b8>] (hub_event) from [<8027a398>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3236)
 r10:8335cf70 r9:8326fe05 r8:83210000 r7:dddced40 r6:8326fe00 r5:83ce2f2c
 r4:830b9600
[<8027a1e4>] (process_one_work) from [<8027afe0>] (process_scheduled_works kernel/workqueue.c:3319 [inline])
[<8027a1e4>] (process_one_work) from [<8027afe0>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3400)
 r10:61c88647 r9:83210000 r8:830b962c r7:82804d40 r6:dddced40 r5:dddced60
 r4:830b9600
[<8027ade4>] (worker_thread) from [<80281fcc>] (kthread+0x12c/0x280 kernel/kthread.c:463)
 r10:00000000 r9:830b9600 r8:8027ade4 r7:df83de60 r6:830b9700 r5:83210000
 r4:00000001
[<80281ea0>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf845fb0 to 0xdf845ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80281ea0
 r4:830b6a40
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

