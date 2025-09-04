Return-Path: <netdev+bounces-220072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD333B445E2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C459E1C8380D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963E25FA2D;
	Thu,  4 Sep 2025 18:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C125A357
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012190; cv=none; b=rx/pn0f0bg3rpl275c4s3K6Lao4TQoFq2GlbbILQ+43FtGHmaEfByFnSM7lci2+mAKCm8/l0nnW8PDM/ZRamqYdD3D9q6Q7IFwl9UkKMupWrmreyMV5ubZ/ipuE0JLoG0x+mfYM6Rs/Ug5pzv69oAh9KAqMwVPjgVdjlLVtfReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012190; c=relaxed/simple;
	bh=jB2rfBlXI0KkJ1zLVCcqRlAI+kHXxRER+mLzQEyMzug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NOeMLgEW38qRJRRrTxKrB1X2PmL0BF1l+OcdBD1d0zuvz4UMpwUcPiWtzp3BuFFwcohPnO+gbcTxqh7RG+wqrdZbTebFawB+wXtHp77xNyX4eAuWwcFpocK5jcfswHV7EHg07MqxEdlnTZMH5QYmoEOpSO33slq/KmB7LXN7erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f2af10496eso16256755ab.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 11:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012188; x=1757616988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VE33VSoKEOrL6ZD9wabtHhy48BYqLCrHMaZLCCfhp8=;
        b=C8SqFFFH1hloMt0ZKtCDo2fnxKDe5O3cgw2RGoLkZMNmDbTSXiTEfcUs7JzYdd8pgU
         VJhhCFe+Qg4RMwIb5FTC5hv4MkJ2LrseaBW0CUNsvEMs11Y7kgnb2ch+7FAaP8G2YzXj
         InfJbPQ8Aku74kEDLWUwDD0u1F5Ms8W/ABjku7i1sMS16ekTgBt5d0DbDgaaNDxraqcn
         qkDEPnSfxSYV5ljdIwtDPF8KhxixJwBJWjoJrq52P0gSdtKl8185oph7sXl/NrNuuz+V
         suYRNWstpPwhUJcioJqaiP23ztXHElMJuENyhNoLU9zIgzl919GSguxBessU8DL8yVWi
         j3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWUtS9yThxEQBjSPqlOfkBChaO88mrxg38JWUfmB1Q2v4rSGw2yLM8N/McoLgN0/JwNh1CeN4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSJQH81W1eOjmZhMElLSWbRzVbDbzP3ZZ/VjZZATFmgozf/Z8
	yQnRmIqPGBMBuABB+CVISssmjxzuk30cVCJ921Iccn621TWpjW6/l1b7a50RjU2T1xxZ0ooC75Q
	oGOZ3VvirEVSbIxR230PNkdi4O7yQdtg4K4cuo0op+f9SJ2MB0g04AjIoxM4=
X-Google-Smtp-Source: AGHT+IEIqGSnOjPqGGEOP6+o6ewLipRC5K/t7OoQxeZDoXfzg276OMR6fz3QI22W6j+Y6d7UcGZYohHPdEZozGrvN3N1OjWi5IA7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3f2:1a77:4876 with SMTP id
 e9e14a558f8ab-3f4024cb129mr325626485ab.26.1757012188003; Thu, 04 Sep 2025
 11:56:28 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:56:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9e0db.050a0220.192772.000f.GAE@google.com>
Subject: [syzbot] [net?] [usb?] KMSAN: uninit-value in lan78xx_reset
From: syzbot <syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com>
To: Rengarajan.S@microchip.com, Thangaraj.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1342fa62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=845da2a9c105a0be
dashboard link: https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec99afb47153/disk-c8bc81a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0879d84349c/vmlinux-c8bc81a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9a55e2d5763/bzImage-c8bc81a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com

lan78xx 1-1:1.0 (unnamed net_device) (uninitialized): EEPROM is busy
=====================================================
BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
 lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707
 usb_probe_interface+0xd20/0x1460 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d4/0xdc0 drivers/base/dd.c:659
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:801
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:831
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:959
 bus_for_each_drv+0x3e3/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1031
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1080
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3689
 usb_set_configuration+0x3493/0x3b70 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xfc/0x290 drivers/usb/core/generic.c:250
 usb_probe_device+0x38d/0x690 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d4/0xdc0 drivers/base/dd.c:659
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:801
 driver_probe_device+0x70/0x8b0 drivers/base/dd.c:831
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:959
 bus_for_each_drv+0x3e3/0x680 drivers/base/bus.c:462
 __device_attach+0x3c8/0x5c0 drivers/base/dd.c:1031
 device_initial_probe+0x33/0x40 drivers/base/dd.c:1080
 bus_probe_device+0x3ba/0x5e0 drivers/base/bus.c:537
 device_add+0x12a9/0x1c10 drivers/base/core.c:3689
 usb_new_device+0x1062/0x20f0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x54e0/0x7620 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xb8e/0x1d80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:463
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable sig.i.i created at:
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1092 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x77e/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766

CPU: 1 UID: 0 PID: 7482 Comm: kworker/1:6 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: usb_hub_wq hub_event
=====================================================


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

