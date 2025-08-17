Return-Path: <netdev+bounces-214404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA9B2944B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53BD1B24885
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5C2FF15E;
	Sun, 17 Aug 2025 16:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6799221FC4
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449555; cv=none; b=RsXM1lpaJvTf9EP/wRfZ3fvXUiIQLTCuglg+NK3E/yymTN3e10gVySodkRyeKLH9Gol8DlwowSu72XwNDjQBp7fv8nv+TerDknGAMNTIcEkzc0ItNryJmaoSNoVETRIe+bgmPhOQcJ0WQrujZu8cn0McqNkrz6VwjQ+/gL2ghKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449555; c=relaxed/simple;
	bh=La33uNruziC6aK5yC+OZwi/CjaShNe4+LeE5OKVRtsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YosJxFa0ZB1iDXDaugYX7PlHXjKREG6OCG6StUZMmmssOEg9PweyZf6ZryNGjRWvq8rYtZA/ByxIW5dXg/7JS2fZ1afAAPYIYwVAQZ2Sjq2P9156v6hmqNfu5vk7craOnMhHYNIrNNxRzP5RgPrkBR8/JxULGF49NJyHEPhO3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432dc61d9so931736039f.1
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 09:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755449553; x=1756054353;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMyjkT6Y8eXPsn2bZrda8Pw4BLi3+j8GhORmxcjlJ2s=;
        b=aNS+JGU4vn3VzMMYb+/L/xhbt3/6RcQcd2HL+p1XdTcQCL/VTU0piD9DLbeOyZg8Ei
         7ouixd+qw/a+KxESlCaH+BmUvGvVqjWIwtZr606ayUqOqTJPkYy2MSoSW2pD07v0y6bP
         MYjY+C013J2kUqfLf+RByXBHYy2j2sYEPe6PzPYKB02C9DKsNH99OFwqLsO45cDVgLrd
         Yp7UyHYwHd9VBbx3T9c+rrlpWZrS2FA3Pidb+5Tgjcrm/Px3PD+wM6v7eZgMSXZvhTzQ
         I49aICCQBIAwdaUNiTyyWk06w4ri8tijU+LbfOG7/wECu0P5RhXDVgTIoUgDl0EexbSB
         oVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX7A7SsoJTA2l8IZohxI5uSBI/nEcWIErXNAE1eFWLRfQBxbiHLsbho7LbAaSHe2FxCwoxypg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNELzD0kMHYPockD1oVypVWvgYAHjC9i+35WIINCLKu/bNRq6
	6sInEe1gE0a9mgB8GCZCnc8CPGVDklWgicM9ShTAdWNKKrwk2YpjQMHXx07rXprx8ndtR7BesUi
	j83gcIi/huOiY5uvyPzITMocw7zXaMl4vBNuSuEEKeYYdEdVCP3axIunAqTM=
X-Google-Smtp-Source: AGHT+IER8rHkZb7o5CdFfjUuJKJFKzWg2Lr3WChYbhL47cIydC0zpBc3Cvdtsg86Gu7E4tkZUCkNR+ogQpn0f3GIRRMd4U/vDfEI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156a:b0:3e3:fe5e:9b96 with SMTP id
 e9e14a558f8ab-3e57e8a6872mr165247005ab.11.1755449553002; Sun, 17 Aug 2025
 09:52:33 -0700 (PDT)
Date: Sun, 17 Aug 2025 09:52:32 -0700
In-Reply-To: <689ff631.050a0220.e29e5.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a208d0.050a0220.e29e5.006e.GAE@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    99bade344cfa Merge tag 'rust-fixes-6.17' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ea1234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce98061fb8ee27bc
dashboard link: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d13a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1754faf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e140d0491611/disk-99bade34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f581d5a99c83/vmlinux-99bade34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feceb1caceef/bzImage-99bade34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/net/usb/asix_devices.c:679:27
shift exponent 208 is too large for 64-bit type 'unsigned long'
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.17.0-rc1-syzkaller-00214-g99bade344cfa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 ax88772_init_mdio drivers/net/usb/asix_devices.c:679 [inline]
 ax88772_bind+0xdcf/0xfa0 drivers/net/usb/asix_devices.c:910
 usbnet_probe+0xa96/0x2870 drivers/net/usb/usbnet.c:1781
 usb_probe_interface+0x668/0xc30 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_new_device+0xa39/0x16f0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2958/0x4a20 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

