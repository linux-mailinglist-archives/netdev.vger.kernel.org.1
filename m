Return-Path: <netdev+bounces-112376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33199938AAF
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14612819D3
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D015252D;
	Mon, 22 Jul 2024 08:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BD17C6C
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635586; cv=none; b=XHC5eBTdn8B71wqyiEAKOsHnE/mAwz//8xvhM0l4mGKQWvYy09NSs5kFyUavHlALUo3Bn1Hmo2PARCb6Ln+Yvx7dgNcKQ8L4d1zJrd8YAYeAR0ceZAbgPMfXCkcCSUYVEaJ2c20FOWLIRSG9JtJkp08pBMnWImJeUcv17SD/tsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635586; c=relaxed/simple;
	bh=Tztv15GA0jDJ8wirKSfVmwvfoijI42T+uf/er9IoVoc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tbBKBP3wtGLhKp+QuVDBP8PzCeMGia6SneMwpRK90FFXsrjRFM+NL7GXkUs7rqhaYK8Apn+Lhl+5Oe3Miw/tz0vZ1x/+Od6Kh2uNTWp1AEXCndXr6WnrJkh7bk/7lIkAF8rZ6OY+62+xLS+DmU2kq1kJmZwedMYUL4LJjZa7P6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397fb955949so52312175ab.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 01:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635584; x=1722240384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69J89KLrUK12TTHqyH7Dz6jarc8Rim8Ka3YADKSO6rs=;
        b=aC66un1qgIqjHIor52xXnlx7v61Qn+dNvHPastDDcSVGV+xDxdoy+5/SZwc2/uVqQj
         ikDdc4/97orQkTcT3/9siuuWG4FZ3fQG5hDBx1Foigdmy+2vpnmECHzCipsEAjjdFgJg
         A6/7BFgT8ajcwAeAm66IzS0i3rjfIuVL+w8zxyaxNtoVYrua/gYRJrzAgXd0WQ1JHUYD
         zVjQch/xtfmKTi+mT8fdH3Z/VluFc33PMqg0/L9Xr9HVtF2H5RhFC+ukCEmJseUNgInm
         dD8pCpCKL7ISx4BCoc+Go/WYv58uQOj3KsRqSuJAfGYunSg/BNmrs07Ha+pFEuSHuuDp
         91gw==
X-Forwarded-Encrypted: i=1; AJvYcCXoXjsGXGf216wBMqcmOO10OPBwwKyxqo4Wd2PP8Sv5uAGxqjZGOtSAa141sf7YC/LykJUVgW86ol3iPHTSP8KPJ9i6ZjJR
X-Gm-Message-State: AOJu0YxsfuwKOdUH80urz+/7Kk9f1BFLa5NP6FWcqGwLy2NfQ18YGV1Q
	0CTJOdKKCxR/Rjx+9SpGfeZpnJcZyR3VvRfDWs0WdZ3cT87z14wcTsdfRtpgnP20KWwxvep+MVD
	SrBQ3NNF7qp302roAQUvuJfvzCmJlPrp/B6SPzCOi2mqQN+KuGTOt5b8=
X-Google-Smtp-Source: AGHT+IEHP2yRvlO8jlbzYGXNfkmKVjT8do1WU2EVTnvMtnOEcpz8Txw568wrkVqCJp//zqtsAWQ4hdOyKw0zD1jbEI6SwuRnyLNA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-398e430f855mr3255005ab.1.1721635583827; Mon, 22 Jul 2024
 01:06:23 -0700 (PDT)
Date: Mon, 22 Jul 2024 01:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000683629061dd18557@google.com>
Subject: [syzbot] [usb?] WARNING: ODEBUG bug in netdev_release
From: syzbot <syzbot+5ce05015d99fda6eaccd@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1725d011980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a55984b4a68171
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce05015d99fda6eaccd
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112544ad980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4dd60a3afdae/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ddd99272b4b/zImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ce05015d99fda6eaccd@syzkaller.appspotmail.com

cdc_ncm 1-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.0-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4334 at lib/debugobjects.c:515 debug_print_object+0xc4/0xd8 lib/debugobjects.c:515
ODEBUG: free active (active state 0) object: 84c3a7cc object type: work_struct hint: usbnet_deferred_kevent+0x0/0x388 drivers/net/usb/usbnet.c:630
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 4334 Comm: kworker/1:4 Not tainted 6.10.0-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<818efbe0>] (dump_backtrace) from [<818efcdc>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:82622804 r5:00000000 r4:81feae20
[<818efcc4>] (show_stack) from [<8190d370>] (__dump_stack lib/dump_stack.c:88 [inline])
[<818efcc4>] (show_stack) from [<8190d370>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<8190d31c>] (dump_stack_lvl) from [<8190d3b0>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82864d0c
[<8190d398>] (dump_stack) from [<818f0784>] (panic+0x120/0x358 kernel/panic.c:347)
[<818f0664>] (panic) from [<80241f54>] (check_panic_on_warn kernel/panic.c:240 [inline])
[<818f0664>] (panic) from [<80241f54>] (print_tainted+0x0/0xa0 kernel/panic.c:235)
 r3:8260c5c4 r2:00000001 r1:81fd3f0c r0:81fdb594
 r7:80826ddc
[<80241ee0>] (check_panic_on_warn) from [<80242148>] (__warn+0x7c/0x180 kernel/panic.c:693)
[<802420cc>] (__warn) from [<80242434>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:726)
 r8:00000009 r7:8203a2f4 r6:ea749a8c r5:83d81800 r4:00000000
[<80242250>] (warn_slowpath_fmt) from [<80826ddc>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:515)
 r10:00000005 r9:84c3a000 r8:81a01b64 r7:82063da4 r6:828c8614 r5:ea749b34
 r4:8260cda8
[<80826d18>] (debug_print_object) from [<8082867c>] (__debug_check_no_obj_freed lib/debugobjects.c:990 [inline])
[<80826d18>] (debug_print_object) from [<8082867c>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1020)
 r8:84c3a800 r7:84c3a7cc r6:00000100 r5:00000003 r4:00000000
[<80828428>] (debug_check_no_obj_freed) from [<804bb71c>] (slab_free_hook mm/slub.c:2202 [inline])
[<80828428>] (debug_check_no_obj_freed) from [<804bb71c>] (slab_free mm/slub.c:4464 [inline])
[<80828428>] (debug_check_no_obj_freed) from [<804bb71c>] (kfree+0x1a0/0x340 mm/slub.c:4585)
 r10:82778cc0 r9:84f0b080 r8:84c3a000 r7:804614a8 r6:82c023c0 r5:ddea47e0
 r4:84c3a000
[<804bb57c>] (kfree) from [<804614a8>] (kvfree+0x2c/0x30 mm/util.c:696)
 r10:82778cc0 r9:84f0b080 r8:84c3a000 r7:00000000 r6:85096780 r5:85152000
 r4:84c3a000
[<8046147c>] (kvfree) from [<8145906c>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2031)
 r5:85152000 r4:84c3a000
[<81459040>] (netdev_release) from [<80a6417c>] (device_release+0x38/0xa8 drivers/base/core.c:2581)
 r5:85152000 r4:84c3a3c0
[<80a64144>] (device_release) from [<818c9a3c>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80a64144>] (device_release) from [<818c9a3c>] (kobject_release lib/kobject.c:720 [inline])
[<80a64144>] (device_release) from [<818c9a3c>] (kref_put include/linux/kref.h:65 [inline])
[<80a64144>] (device_release) from [<818c9a3c>] (kobject_put+0xc8/0x1f8 lib/kobject.c:737)
 r5:81b49224 r4:84c3a3c0
[<818c9974>] (kobject_put) from [<80a643a8>] (put_device+0x18/0x1c drivers/base/core.c:3787)
 r7:84f0b800 r6:84c3a10c r5:84c3a000 r4:00000000
[<80a64390>] (put_device) from [<8140e054>] (free_netdev+0x114/0x18c net/core/dev.c:11196)
[<8140df40>] (free_netdev) from [<80d3b2d0>] (usbnet_disconnect+0xac/0xf0 drivers/net/usb/usbnet.c:1636)
 r6:84c3a794 r5:84c3a680 r4:00000000
[<80d3b224>] (usbnet_disconnect) from [<80d9fa70>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:84f0b830 r6:82778cc0 r5:00000000 r4:84f0b800
[<80d9f9ec>] (usb_unbind_interface) from [<80a6c284>] (device_remove drivers/base/dd.c:568 [inline])
[<80d9f9ec>] (usb_unbind_interface) from [<80a6c284>] (device_remove+0x64/0x6c drivers/base/dd.c:560)
 r10:00000000 r9:84f0b080 r8:00000044 r7:84f0b874 r6:82778cc0 r5:00000000
 r4:84f0b830
[<80a6c220>] (device_remove) from [<80a6d79c>] (__device_release_driver drivers/base/dd.c:1270 [inline])
[<80a6c220>] (device_remove) from [<80a6d79c>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1293)
 r5:00000000 r4:84f0b830
[<80a6d610>] (device_release_driver_internal) from [<80a6d828>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1316)
 r9:84f0b080 r8:82cd1f40 r7:82cd1f38 r6:82cd1f0c r5:84f0b830 r4:82cd1f30
[<80a6d810>] (device_release_driver) from [<80a6b90c>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:574)
[<80a6b840>] (bus_remove_device) from [<80a65a24>] (device_del+0x148/0x38c drivers/base/core.c:3868)
 r9:84f0b080 r8:83d81800 r7:04208060 r6:00000000 r5:84f0b830 r4:84f0b874
[<80a658dc>] (device_del) from [<80d9d48c>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:84f0b800 r7:84f0b000 r6:8508fec8 r5:00000001
 r4:00000038
[<80d9d3b0>] (usb_disable_device) from [<80d922ec>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2304)
 r10:00000001 r9:846e9800 r8:84f0b0c4 r7:83d6d400 r6:84f0b080 r5:84f0b000
 r4:60000113
[<80d92200>] (usb_disconnect) from [<80d94e9c>] (hub_port_connect drivers/usb/core/hub.c:5361 [inline])
[<80d92200>] (usb_disconnect) from [<80d94e9c>] (hub_port_connect_change drivers/usb/core/hub.c:5661 [inline])
[<80d92200>] (usb_disconnect) from [<80d94e9c>] (port_event drivers/usb/core/hub.c:5821 [inline])
[<80d92200>] (usb_disconnect) from [<80d94e9c>] (hub_event+0xd78/0x194c drivers/usb/core/hub.c:5903)
 r10:00000001 r9:00000101 r8:83a3bd00 r7:84f0b000 r6:83d6cc00 r5:83d6d610
 r4:00000001
[<80d94124>] (hub_event) from [<802658fc>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3231)
 r10:82e5c805 r9:83d81800 r8:01800000 r7:ddde4000 r6:82e5c800 r5:83a3bd00
 r4:85073080
[<80265748>] (process_one_work) from [<802664e0>] (process_scheduled_works kernel/workqueue.c:3312 [inline])
[<80265748>] (process_one_work) from [<802664e0>] (worker_thread+0x1ec/0x3f4 kernel/workqueue.c:3390)
 r10:83d81800 r9:850730ac r8:61c88647 r7:ddde4020 r6:82604d40 r5:ddde4000
 r4:85073080
[<802662f4>] (worker_thread) from [<8026f538>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df815e78 r8:85020a00 r7:85073080 r6:802662f4 r5:83d81800
 r4:85072440
[<8026f434>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:134)
Exception stack(0xea749fb0 to 0xea749ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026f434 r4:85072440
Rebooting in 86400 seconds..


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

