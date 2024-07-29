Return-Path: <netdev+bounces-113769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3C93FDB7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17A81F22CF7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65D186E2D;
	Mon, 29 Jul 2024 18:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335774420
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279030; cv=none; b=A1HhLRBLyLGMP+9PbZUbfES8EJYmD7H1BMTx8CDoX5HJrD/AKnl75XmC7XH6AqSjDXUt2H/L1/FLyPJwmU4ouh6EvF2Y2rt7KBWH6Amw9gEPiqC/NBv/5CzaKEk4oBoLDyOmQ4Lzz4A0IVjrqyxLUO8oDCKdkJLm/2GHH2773fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279030; c=relaxed/simple;
	bh=eY4ugEDb6jRzq/pexxxehLVeNuXwCCtl5z9EorIXf/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zwq7L3ZuntXPKmNrkzvSeja7PwAaVwGLzNmY2kOhuHZCey0FXaGckeKh2pu12uH8oJ5f2WUfvAKgW4+JlX+fxZQe8IVMzaUq+HrGzt9LQf6oXbfRuSUqqPOYMSXOgI9NY4sHiX0wd4on0z0Y7xR4r0/xQRpuSb7LlFL75dON8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so471611939f.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279028; x=1722883828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HdwkffihZ+EwPucL3qbfXXPnxbwonIAqD5Z4x1q1uo=;
        b=k4lTKcYlUDBTW+vDVyu7vJTyYijkKk0zyXnt/t8Np3MZESHzXQoSyzzQgSj7ldpeO+
         00hkVT6slMk4TlLt7rP3TlK5mSTbcXTFxet7uIAjqdYGUynO99Huk22n16kilJPhw0n8
         lce52HkNpc1LJA0XwivaXfDTFiOShiL04iis9UvvMmivjOUKqrmokWWFVJL+40ITQtlR
         ldAjRpzGFqTeAVlWeBBw78OuugIHg6cyK+mqmIdlGi0nXjTNZgu0kbBQDPoNKbPDR1zD
         hfk4TiCbosnRzxgSjtt8HcG3brBrZ0xG576T14XeX65Fed1pvlskch9v3JNmMCCz658F
         EIbw==
X-Forwarded-Encrypted: i=1; AJvYcCVWrSTQZejTfa7tBOo5E0V/c/HwcwH+8GM9xpJtjGqIAG4mjGBeps1KrtTazaFHelhoYUxp9o6ZtIKrFek67BXRMmmIyg3b
X-Gm-Message-State: AOJu0YyS3qyiLKtwgCIZL7cOA2kxmrekeCG9NdwR4UrZ3Nw+AwTCmfm2
	9bYzHmRXrax/zF1p2OsLWao0Mea/ve0hg6G3nIJkykwcA1gSM9Q0EaDR92OMIIXUuebUIPfuyy9
	/gtYcQE+LrftuND1NyWU8vK74102fWXoE+3YWLNtPjrKcrfAE0elKMCY=
X-Google-Smtp-Source: AGHT+IFvoN+itrC2YNMnV/kLznBYA9SKUsPbIpvfu6ywevT+cqAAWOHCiqDTZp9Sor1ce36bj8KsGn3jsftcBWEmKbLQmQKngVX7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4118:b0:4c2:8a0c:380d with SMTP id
 8926c6da1cb9f-4c64a5d960bmr708206173.3.1722279028080; Mon, 29 Jul 2024
 11:50:28 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:50:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac553b061e675573@google.com>
Subject: [syzbot] [wireless?] WARNING in plfxlc_mac_release
From: syzbot <syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	srini.raju@purelifi.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14faa9e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d80965980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ccfd3d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22dd51445d03/disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f85f111961d5/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7971b4814e87/bzImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=2ef5, idProduct=000a, bcdDevice=21.c2
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
plfxlc 1-1:1.167: Firmware Version: 0
plfxlc 1-1:1.167: Unit type is station
plfxlc 1-1:1.167: vendor command failed (-71)
plfxlc 1-1:1.167: FPGA download failed (-22)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 41 at drivers/net/wireless/purelifi/plfxlc/mac.c:105 plfxlc_mac_release+0x89/0xb0 drivers/net/wireless/purelifi/plfxlc/mac.c:105
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: kworker/0:2 Not tainted 6.10.0-syzkaller-g933069701c1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:plfxlc_mac_release+0x89/0xb0 drivers/net/wireless/purelifi/plfxlc/mac.c:105
Code: 3d f8 66 fd 48 8d bb 08 33 00 00 be ff ff ff ff e8 5c 61 f5 02 31 ff 89 c3 89 c6 e8 21 f3 66 fd 85 db 75 d4 e8 18 f8 66 fd 90 <0f> 0b 90 5b 5d e9 0d f8 66 fd 48 c7 c7 d8 9e 32 8a e8 21 f1 bb fd
RSP: 0018:ffffc900004c6f50 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83ec60bf
RDX: ffff888105ab3a00 RSI: ffffffff83ec60c8 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000098df1
R13: ffff88810f6eb000 R14: ffff8881137eb080 R15: ffff88810f6eb078
FS:  0000000000000000(0000) GS:ffff8881f6200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055993fa01a80 CR3: 000000010d7ae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 probe+0x84a/0xba0 drivers/net/wireless/purelifi/plfxlc/usb.c:694
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e66/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

