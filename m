Return-Path: <netdev+bounces-227707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99DBB5C86
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 04:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CBE19E0043
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7229993A;
	Fri,  3 Oct 2025 02:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A141487D1
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456887; cv=none; b=AmM66SWX4FIl5pq300yaDoZYCCwdFbnaOQmSBfEEtR7fKpuHsfG3uOOwFF6R+coIYzJcE/Owiz4wLZjQ2t7g/uesh+efe2AkQ1/DIFN3iiBQT3x5HIhzSjQYUNxFRWuuoqF37CB5SKIAAghe/ahA3D2IaA3zY5VjVrPRiVgspn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456887; c=relaxed/simple;
	bh=8Y9Zd8cX3gcaUQdOiOPrBV36+MV24/YVHihfRjj2q48=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L7Wpf5An1+T5NN0U/4mYQATP6CHMoYSLo3vpqtNUpeymr2byVGOO2LOWN3fFTydhGERf91WIrOlEiB7t16xPXH92rUxAVfM0y2XWZjV6fapjPZChFNvJgLZX93r7+G57l891oxlYX2cDIb06jj9wmmgaWhBTWSGEQx4799jzKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42d8a33a27aso43263625ab.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 19:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759456884; x=1760061684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VXCwbgzxAMA+OjC0S2OE89DRe7vm2C3ZDHpdhAqaX4=;
        b=CJmYZ2br0Er6CzrL/58TfGI7c+Bn4cMTrxFr2fSHVmCYFgXIJWXt+CDuxJ1IMhRrV2
         1588Oz16saZwv/+eFQMXvujOalshxSSEVdkytGEq8BseZkFKHWikkwTj00XYewhlcDv0
         gOGB5LjnRjsqQ8A1gqVbHEfvd6mZWO3ceLmtwvxFeB0KClrgs1w1oqAqqfkXXhzgCWxd
         2EMpLkU0lfhHnMvJZnepNbxrbfYAwUV3MQPpvMxHaVUl2Sln+8uRTygwsdkkenr0gW+q
         UoweJj/AvCmKTw1zWAGtRh/icz3ciJtsLgP3ApwsyI/p0rpZ9YmkM3I7dDwl6kacBoRj
         eMoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPnuIejnAdVYkNfdG7GPfuBnSHQQjFcfIWgg6rg7lwmaRi6AAbkoNpErKFRKUWFncwR8+mTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVdDn7y5tP5Y0V975YX8rBFdju71ncHTG3PaIzGPFP3n2MLTA
	hNdgJK2ATb+omqLEOhYqgWyb61HcvbzT7etEhvrfALIjL662w0JK5TSASVpjE0QdWWvAluIuXj0
	5YsbfANbRaQoLB6NPX6MbMnj09nYywV9RW2kqD0+3tuq+mWqWJsuUXoEt3f8=
X-Google-Smtp-Source: AGHT+IFPzIxFdGnr15vQCKRbd9V4cLt9iQIXQtZx0F1xc4ALwCCx1lDzlWbG4sxU24XA6rUHLwfzONJvCbVpdaha1+2C0D0/0wM2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:40e:a0e1:2f61 with SMTP id
 e9e14a558f8ab-42e7ad849d3mr15854935ab.26.1759456884660; Thu, 02 Oct 2025
 19:01:24 -0700 (PDT)
Date: Thu, 02 Oct 2025 19:01:24 -0700
In-Reply-To: <68b9e0db.050a0220.192772.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df2e74.050a0220.1696c6.003a.GAE@google.com>
Subject: Re: [syzbot] [usb?] [net?] KMSAN: uninit-value in lan78xx_reset
From: syzbot <syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com>
To: Rengarajan.S@microchip.com, Thangaraj.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, andrew@lunn.ch, 
	bhanuseshukumar@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, o.rempel@pengutronix.de, pabeni@redhat.com, 
	rengarajan.s@microchip.com, syzkaller-bugs@googlegroups.com, 
	thangaraj.s@microchip.com, unglinuxdriver@microchip.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dc1ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3efb3c89344fb053
dashboard link: https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14731214580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ca65cd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf1acf3bcd3b/disk-7f707257.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7447ff07b887/vmlinux-7f707257.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16ebb9562804/bzImage-7f707257.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=0424, idProduct=7850, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
lan78xx 1-1:1.0 (unnamed net_device) (uninitialized): EEPROM read operation timeout
=====================================================
BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
 lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707
 usb_probe_interface+0xd23/0x1460 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d4/0xdc0 drivers/base/dd.c:659
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:801
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:831
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:959
 bus_for_each_drv+0x3e0/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1031
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1080
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3689
 usb_set_configuration+0x3493/0x3b70 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xfc/0x290 drivers/usb/core/generic.c:250
 usb_probe_device+0x38a/0x690 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d4/0xdc0 drivers/base/dd.c:659
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:801
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:831
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:959
 bus_for_each_drv+0x3e0/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1031
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1080
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3689
 usb_new_device+0x1062/0x20f0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x54e0/0x7620 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3346
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3427
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x233/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable sig.i.i created at:
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1092 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x77e/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766

CPU: 0 UID: 0 PID: 5106 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

