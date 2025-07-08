Return-Path: <netdev+bounces-205100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67BAFD5B9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F4C1C23608
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A32E716D;
	Tue,  8 Jul 2025 17:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D92E5B11
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997090; cv=none; b=scCiyWoltdI1i/ZSzuwN4kjJulbiaJIfltTMhAk0MHGS0WXzsijLD2N6KO1XGvrx1RDDrgc/9/utuNXmL03agChs07IbzkeN30FnmKDw1IG7rl7xBcWRMvkm+6GimSV8Fgfiy/Mswp7+cBJ7Wh1pAsCJjoekFlSVtGebN5yQdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997090; c=relaxed/simple;
	bh=j8S9vY8YEpgAZ+9EOTe6TqmituCFgPwLRcCdXTJ/ClI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o00SWdFNM7PEjjjgJUr80ShakThZ6RvepzkDD2idqtkbkonhg76YmUHpgfzHgIr34GSdkxWMkoEZRBk4edUkTdikmbE94uHxkP8kNkoTWZB5MkDnxLBBn+IMA7BCrSVoDnTkzCCMBxYdnIcQIwkHlJiQhUyD4/PsCsB2wSNubZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df309d9842so124020065ab.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 10:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997087; x=1752601887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TeThu1b9aE+CPbvKACRdaDEcTafO62ZyIapw7YKedY=;
        b=b9xq6FHzbfRmVkhSoBzJQOQdyioLN/u6NjMvFwh6h11nUSa+NKqchaTb5CrZPE5Ehn
         9iJu6wI0cYvtqMBZIDGTcELK01Q1wJliem0laq1Hjmo1X7893Esh8JnYgpgqs0TWO2VI
         mzqquzTyB0I2VNOA1FO9sFuetdPl+Z+89TGpnSHmwA3EjwTwaMewW9sRWR3yqBA62Vdg
         AW0g5kM9SdHrll0nuLYACstGOIMCjZGueoO2W/vn70BaZzvnVU429WEd45vTSNBqN7+i
         HPUjWUSdG0Ox1bODBFDgOEcYqiCj7NSPy4d4YxwYbFDE8SbN397bavlmlyheCIqwTJo4
         gI2A==
X-Forwarded-Encrypted: i=1; AJvYcCVg+j3Mzr3MaxCCTXyKWzGkS5pIqmM61wKv6Rvqc7Qk30DpEZ9jW/b72eYhm/NsgnWvnkDy6Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHV3ulVnXnD+2JsceCDLc6a8P4ug1JAuVuB2gldtpT5PzS2JtI
	4AxB0qIF0ueN6uWvZvHSexOTa9TGFQBhAWgmmZOzUCGosGRkDnFsZltqyfLr1yLGTvNm6VIM8j0
	Z6U+azRBYuXr+w9mKi4VnSx9NSGohlMhCx4jWl41T5JHJCQ7qAQM6EBHZBdo=
X-Google-Smtp-Source: AGHT+IHcCjqcbO63Nl0JY0A3bU593vUxVeXcAZKB6aOep3GpMpLNYi4983VKkyY8HO25v6N/RwGdaEJkUpU2NpS2Y/pqUD8Fpyqc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1527:b0:3e0:4f66:310a with SMTP id
 e9e14a558f8ab-3e1355a8e41mr169148195ab.16.1751997087610; Tue, 08 Jul 2025
 10:51:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5a9f.050a0220.1ffab7.0017.GAE@google.com>
Subject: [syzbot] [usb?] WARNING in usbnet_status_start
From: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1b07cc0868f arm64: dts: s32g: Add USB device tree informa..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1554d582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11680a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c9abd4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3eab0cb43ae2/disk-d1b07cc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/934d59614ed5/vmlinux-d1b07cc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b24078bc227/bzImage-d1b07cc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com

sierra_net 4-1:0.11 wwan0: register 'sierra_net' at usb-dummy_hcd.3-1, Sierra Wireless USB-to-WWAN Modem, 00:00:00:00:01:0b
------------[ cut here ]------------
WARNING: CPU: 1 PID: 37 at drivers/net/usb/usbnet.c:266 usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:266
Modules linked in:
CPU: 1 UID: 0 PID: 37 Comm: kworker/1:1 Not tainted 6.16.0-rc4-syzkaller-00311-gd1b07cc0868f #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:266
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 4e 48 8b bb 70 03 00 00 89 ee e8 25 95 0c 00 41 89 c5 e9 36 ff ff ff e8 a8 3f ec fc 90 <0f> 0b 90 45 31 ed e9 39 ff ff ff 4c 89 ff e8 d4 41 49 fd e9 e9 fe
RSP: 0018:ffffc90000277098 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888100f80d00 RCX: ffffffff84930727
RDX: ffff888105693a00 RSI: ffffffff84919188 RDI: ffff888100f80d00
RBP: 0000000000000cc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888100f81070
R13: ffffffff89be8f70 R14: ffff88811da1f028 R15: ffff88811da1f024
FS:  0000000000000000(0000) GS:ffff888269262000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd6ab63358 CR3: 0000000116716000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 sierra_net_probe drivers/net/usb/sierra_net.c:929 [inline]
 sierra_net_probe+0x70/0xb0 drivers/net/usb/sierra_net.c:921
 usb_probe_interface+0x303/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5948
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

