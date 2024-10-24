Return-Path: <netdev+bounces-138459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BC9ADAD4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 06:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C57E1F221C5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F076166F1B;
	Thu, 24 Oct 2024 04:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA015099D
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729743688; cv=none; b=J+cQlsaJHnbYELejmEXmW7K5CGROD1gudXRi5o/w1FL7O8tnj7+fqp74gy8/ivamCNXaUqYIWL9spkRjQenJRsjx5Aa/s8IVSiqvEEgL6dQ7NeOMLIeezcccvEvrxoeAtVy9oyNxvz4aChCjgAY4XMBrebzX7dXa1+p9ZUfoSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729743688; c=relaxed/simple;
	bh=ntUm+VzT9wQ41wxCaTiMnPdbLSLed/eaPf67VYhzuPU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YuvhZI+LnW5E+/rfqmE3cjmxLljPfoZ97xQZA1YwqSrmEN+LyJp2eJCc1m8XpOKNZeT/EaDSgA/04FT6iTk3HmdAAFm3gU/0TaLHaUSCA/tzkxg5rtNJmzDqLO4YH6d0E2sDcQw1502yHX1SUm1vIN6gr7BRELYfLzMw3sMr7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so4551045ab.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 21:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729743685; x=1730348485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxBOu3s4myefwpAeZeAVashVjh+vCjIQcddqHQJpuzI=;
        b=ikW96FyqmTfPiq3fm8r0YFfqhP7cAyygIY0YjcmcyWQ0D66KynqOuneQSen73gXuu/
         ufg3TMapUm8HT0HtoZLeoLkFtOfgKNQtkeeY8kjMXRn32wO1s/+sbocmFsY0r+BvqWZC
         5oiXzzOS6iCV4ogXbQEumDP66yczUTki7IGCre24eU7CxfrxI44fReeM9dTZLGlv5Kzh
         Yo5ekCdAzbtaG9NdH5v8DN4rEIn3t9lc4ZZAMI9xpg0OBv999m9VYYeLuud8PbtBmLZL
         4TCAVlhzVzk4lKqx4mPUpaXS0lkakchK7rnQI1uL83Zzg3DDjEEDTL6d/4Tg26RWzdpL
         EbrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0WZYgTluwzWpeJ2exzL9TJxW4MGYfUOLLX3JPikWqCYLYuz6IeHghFZSXh1sKmUWXDptJu1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIR009JcS5nC4uobwWfE0zYA+09fKq7Ri4n/nsrqqbsh2hol7b
	92n/39WwOjjORhUBrECgvB0zmjPfpng8MAZW7l1OWfRa99LYkLPTSFomQ/E0jSwiai0uWx60cNR
	TvXljEV7RHCDygseUKL1wmVCjBgA+m7q1AbPGA2w0xvzizJCsBYi5aco=
X-Google-Smtp-Source: AGHT+IHjPXPK5VrVwUr3up5iuwdmufK8wThVe/M+l/PiGYs+I0fJKpIqiXFEWXiHkP/3SLAzBghRQfijXWPeW2UWulx2504+VndY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1649:b0:3a3:97b6:74fe with SMTP id
 e9e14a558f8ab-3a4d597b734mr50165655ab.11.1729743685300; Wed, 23 Oct 2024
 21:21:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:21:25 -0700
In-Reply-To: <000000000000869803061fb207d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719cb45.050a0220.10f4f4.01de.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in get_taint
From: syzbot <syzbot+ffe5c7db7c30a0fbb165@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167f48a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f68c7e50d4601b1
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe5c7db7c30a0fbb165
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1267b640580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcc7a230eb09/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96b5df297c4b/zImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe5c7db7c30a0fbb165@syzkaller.appspotmail.com

cdc_ncm 1-1:1.0 usb0: register 'cdc_ncm' at usb-dummy_hcd.0-1, CDC NCM (NO ZLP), 42:42:42:42:42:42
usb 1-1: USB disconnect, device number 23
cdc_ncm 1-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.0-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at lib/debugobjects.c:514 debug_print_object+0xc4/0xd8 lib/debugobjects.c:514
ODEBUG: free active (active state 0) object: 84ff57cc object type: work_struct hint: usbnet_deferred_kevent+0x0/0x394 drivers/net/usb/usbnet.c:633
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: usb_hub_wq hub_event
Call trace: 
[<81999930>] (dump_backtrace) from [<81999a2c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:82622f44 r5:00000000 r4:8203d814
[<81999a14>] (show_stack) from [<819b7ec8>] (__dump_stack lib/dump_stack.c:94 [inline])
[<81999a14>] (show_stack) from [<819b7ec8>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<819b7e74>] (dump_stack_lvl) from [<819b7f08>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82870d18
[<819b7ef0>] (dump_stack) from [<8199a558>] (panic+0x120/0x374 kernel/panic.c:354)
[<8199a438>] (panic) from [<802420e0>] (check_panic_on_warn kernel/panic.c:243 [inline])
[<8199a438>] (panic) from [<802420e0>] (get_taint+0x0/0x1c kernel/panic.c:238)
 r3:8260c5c4 r2:00000001 r1:82025be8 r0:8202d650
 r7:80854748
[<8024206c>] (check_panic_on_warn) from [<80242244>] (__warn+0x80/0x188 kernel/panic.c:748)
[<802421c4>] (__warn) from [<80242534>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:783)
 r8:00000009 r7:8208c8e8 r6:df841a8c r5:82e36c00 r4:00000000
[<80242350>] (warn_slowpath_fmt) from [<80854748>] (debug_print_object+0xc4/0xd8 lib/debugobjects.c:514)
 r10:00000005 r9:84ff5000 r8:81a01c24 r7:820b76d8 r6:828dd084 r5:df841b34
 r4:8260cda4
[<80854684>] (debug_print_object) from [<80855fd8>] (__debug_check_no_obj_freed lib/debugobjects.c:989 [inline])
[<80854684>] (debug_print_object) from [<80855fd8>] (debug_check_no_obj_freed+0x254/0x2a0 lib/debugobjects.c:1019)
 r8:84ff5800 r7:84ff57cc r6:00000100 r5:00000003 r4:00000000
[<80855d84>] (debug_check_no_obj_freed) from [<804c916c>] (slab_free_hook mm/slub.c:2273 [inline])
[<80855d84>] (debug_check_no_obj_freed) from [<804c916c>] (slab_free mm/slub.c:4579 [inline])
[<80855d84>] (debug_check_no_obj_freed) from [<804c916c>] (kfree+0x190/0x394 mm/slub.c:4727)
 r10:8277e5bc r9:84706480 r8:84ff5000 r7:8046d140 r6:82c023c0 r5:ddeacdc0
 r4:84ff5000
[<804c8fdc>] (kfree) from [<8046d140>] (kvfree+0x2c/0x30 mm/util.c:701)
 r10:8277e5bc r9:84706480 r8:84ff5000 r7:00000000 r6:8505cb00 r5:8509c780
 r4:84ff5000
[<8046d114>] (kvfree) from [<814fbd38>] (netdev_release+0x2c/0x34 net/core/net-sysfs.c:2034)
 r5:8509c780 r4:84ff5000
[<814fbd0c>] (netdev_release) from [<80aa3aa0>] (device_release+0x38/0xa8 drivers/base/core.c:2575)
 r5:8509c780 r4:84ff53c0
[<80aa3a68>] (device_release) from [<8197378c>] (kobject_cleanup lib/kobject.c:689 [inline])
[<80aa3a68>] (device_release) from [<8197378c>] (kobject_release lib/kobject.c:720 [inline])
[<80aa3a68>] (device_release) from [<8197378c>] (kref_put include/linux/kref.h:65 [inline])
[<80aa3a68>] (device_release) from [<8197378c>] (kobject_put+0xa0/0x1f4 lib/kobject.c:737)
 r5:81b4c9c4 r4:84ff53c0
[<819736ec>] (kobject_put) from [<80aa3ccc>] (put_device+0x18/0x1c drivers/base/core.c:3783)
 r7:84707000 r6:00000000 r5:84ff5000 r4:00000000
[<80aa3cb4>] (put_device) from [<814b03d8>] (free_netdev+0x134/0x1ac net/core/dev.c:11255)
[<814b02a4>] (free_netdev) from [<80d87a48>] (usbnet_disconnect+0xb8/0xfc drivers/net/usb/usbnet.c:1652)
 r6:84ff5794 r5:84ff5680 r4:00000000
[<80d87990>] (usbnet_disconnect) from [<80df0138>] (usb_unbind_interface+0x84/0x2c4 drivers/usb/core/driver.c:461)
 r8:00000044 r7:84707030 r6:8277e5bc r5:00000000 r4:84707000
[<80df00b4>] (usb_unbind_interface) from [<80aabb8c>] (device_remove drivers/base/dd.c:569 [inline])
[<80df00b4>] (usb_unbind_interface) from [<80aabb8c>] (device_remove+0x64/0x6c drivers/base/dd.c:561)
 r10:00000000 r9:84706480 r8:00000044 r7:84707074 r6:8277e5bc r5:00000000
 r4:84707030
[<80aabb28>] (device_remove) from [<80aad078>] (__device_release_driver drivers/base/dd.c:1273 [inline])
[<80aabb28>] (device_remove) from [<80aad078>] (device_release_driver_internal+0x18c/0x200 drivers/base/dd.c:1296)
 r5:00000000 r4:84707030
[<80aaceec>] (device_release_driver_internal) from [<80aad104>] (device_release_driver+0x18/0x1c drivers/base/dd.c:1319)
 r9:84706480 r8:82f65640 r7:82f65638 r6:82f6560c r5:84707030 r4:82f65630
[<80aad0ec>] (device_release_driver) from [<80aab1ec>] (bus_remove_device+0xcc/0x120 drivers/base/bus.c:576)
[<80aab120>] (bus_remove_device) from [<80aa5528>] (device_del+0x148/0x38c drivers/base/core.c:3864)
 r9:84706480 r8:82e36c00 r7:04208060 r6:00000000 r5:84707030 r4:84707074
[<80aa53e0>] (device_del) from [<80dedb54>] (usb_disable_device+0xdc/0x1f0 drivers/usb/core/message.c:1418)
 r10:00000000 r9:00000000 r8:84707000 r7:84706400 r6:850a5248 r5:00000001
 r4:00000038
[<80deda78>] (usb_disable_device) from [<80de29b8>] (usb_disconnect+0xec/0x29c drivers/usb/core/hub.c:2304)
 r10:00000001 r9:84c65200 r8:847064c4 r7:83dee400 r6:84706480 r5:84706400
 r4:60000113
[<80de28cc>] (usb_disconnect) from [<80de5668>] (hub_port_connect drivers/usb/core/hub.c:5361 [inline])
[<80de28cc>] (usb_disconnect) from [<80de5668>] (hub_port_connect_change drivers/usb/core/hub.c:5661 [inline])
[<80de28cc>] (usb_disconnect) from [<80de5668>] (port_event drivers/usb/core/hub.c:5821 [inline])
[<80de28cc>] (usb_disconnect) from [<80de5668>] (hub_event+0xe78/0x194c drivers/usb/core/hub.c:5903)
 r10:00000001 r9:00000100 r8:83b10700 r7:84706400 r6:8381e400 r5:83dee610
 r4:00000001
[<80de47f0>] (hub_event) from [<80266034>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3229)
 r10:82e64805 r9:82e36c00 r8:00800000 r7:dddd00c0 r6:82e64800 r5:83b10700
 r4:82cb6080
[<80265e80>] (process_one_work) from [<80266c18>] (process_scheduled_works kernel/workqueue.c:3310 [inline])
[<80265e80>] (process_one_work) from [<80266c18>] (worker_thread+0x1ec/0x3bc kernel/workqueue.c:3391)
 r10:82e36c00 r9:82cb60ac r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:82cb6080
[<80266a2c>] (worker_thread) from [<8026fc94>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df839e78 r8:82cb5b40 r7:82cb6080 r6:80266a2c r5:82e36c00
 r4:82cb5980
[<8026fb90>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf841fb0 to 0xdf841ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fb90 r4:82cb5980
Rebooting in 86400 seconds..


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

