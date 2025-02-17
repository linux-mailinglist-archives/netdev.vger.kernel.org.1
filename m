Return-Path: <netdev+bounces-166964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B44A38281
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0549E3B768F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7C21A446;
	Mon, 17 Feb 2025 11:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB4219A9F
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793319; cv=none; b=OwV2N3uU2p3ItrQtOAm4u65YpwaLIBPtzHLvFZ6dTcwxCviE9W/WnM9tsufxvQqgMyxjB5FLxlos9/KlVjPoWwOvEy6qWuLUZC8xYCM0pmirrfzWgqvWyyWGoVLS5TjFZVee5dmhTa4WEXq90exnfND6IZx2BpwAw8vkqIr8Vuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793319; c=relaxed/simple;
	bh=rXSpe+NJbIoKJmboP5gveOHLIThY2qfsz5ENb8Hnd7U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jfD6NBuquJW0gEeU8i6NjkO+qSofj04bfzE8o3vLOVnr9VcdFsHYrJh0g54zGE2l1XxQVx78EOaaO0G/OGvumAe1oFyzPSvVc+0onBnJ3gXwcNpZKFbvIq8uxiER1b1VYOsH2Cf8366QP3dz8N9ZP0EEF8yw5GUl3pwhB6TBpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85592464231so43573739f.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 03:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793317; x=1740398117;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2SNsfobksNLxmFD/FW73Bo3hCps2W8uGQVmV6abxOw=;
        b=Q+0YNfWkL4StLqAikcbgJPYywUQgCAckkH0M3Zc2FgIsKqI4Jc1yUFWh5Sqxk2Q0lu
         yqYwb9MGMoWNV7REpEgobDv1WGX5Jc5BA5dT6XdMrKRmEK58QGptIrZO96mJg+/lIBoC
         pQcIDGL1lXKkYntvyyvmNPjU59lMnY3U4fDx9iLWzD5EezW+yU4PEA0/E0WADwkifNN2
         4zAQ38uYJGUJaHntL0qRlLG9uPs44yd2niU1JmHStSCDxcY5p3x+GSXvZzmWKEAmWYty
         ER2VsggbG7vVFtniye4iSBDyMsYLYLsXaZ/18dyHxWP9zuKPAKzUap2qGqAbPkHxXKeP
         A0cA==
X-Forwarded-Encrypted: i=1; AJvYcCWRLFh/pxl43DXyQx5f3YGWhGRmLbM5UXxV7E+4Rk4QBJXTSVEDDNLjowmMkQV+QO23OaiumQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl1t901WbR99BZEgtbI2cYprwk7NShGkNgWtOkHwRGf+Ocnvw
	evJ0U0lkNnImq9LFq9ca91rbIcWhQ+UuK0oXN4+RrJvyzp8j81FYOxq0Dp9aM8lZ+ehL7F6KzVe
	7WGu18LRLeLTIoc0wjGWNQ7PHGqd8BtjT+zhkGX69vG7tkB70b5EZNpY=
X-Google-Smtp-Source: AGHT+IEwIJXj1gNkBRTg7wW3sJx19Gf/4sAiZn7JQ6AlVsumtfXZVz2NzV6qniTmJEuHY7zgtNyGczYBmvgMvdofbcMZL/+L266W
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d280919df3mr96423025ab.21.1739793316844; Mon, 17 Feb 2025
 03:55:16 -0800 (PST)
Date: Mon, 17 Feb 2025 03:55:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b323a4.050a0220.173698.002b.GAE@google.com>
Subject: [syzbot] [can?] WARNING in ucan_probe
From: syzbot <syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, mkl@pengutronix.de, netdev@vger.kernel.org, 
	oneukum@suse.com, pabeni@redhat.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    496659003dac Merge tag 'i2c-for-6.14-rc3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11012bf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
dashboard link: https://syzkaller.appspot.com/bug?extid=d7d8c418e8317899e88c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f7b9b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155602e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1675d5fc116/disk-49665900.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0342ce7d0bc9/vmlinux-49665900.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ce5b4978fc4/bzImage-49665900.xz

The issue was bisected to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c65bf8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c65bf8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15c65bf8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

------------[ cut here ]------------
strnlen: detected buffer overflow: 129 byte read of buffer size 128
WARNING: CPU: 0 PID: 9 at lib/string_helpers.c:1033 __fortify_report+0x9d/0xb0 lib/string_helpers.c:1032
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.14.0-rc2-syzkaller-00281-g496659003dac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__fortify_report+0x9d/0xb0 lib/string_helpers.c:1032
Code: 84 ed 48 8b 33 48 c7 c0 a0 ae 80 8c 48 c7 c1 c0 ae 80 8c 48 0f 44 c8 48 c7 c7 20 ac 80 8c 4c 89 fa 4d 89 f0 e8 04 dd 8b fc 90 <0f> 0b 90 90 5b 41 5e 41 5f 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90
RSP: 0018:ffffc900000e6b50 EFLAGS: 00010246
RAX: e8edca93825f5800 RBX: ffffffff8c80ab68 RCX: ffff88801c2f8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81817e32 R09: fffffbfff1d3a614
R10: dffffc0000000000 R11: fffffbfff1d3a614 R12: dffffc0000000000
R13: 1ffff9200001cd84 R14: 0000000000000080 R15: 0000000000000081
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d6c3b85e50 CR3: 0000000078508000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fortify_panic+0x9/0x10 lib/string_helpers.c:1039
 _Z7strnlenPKcU25pass_dynamic_object_size1m include/linux/fortify-string.h:235 [inline]
 _Z13sized_strscpyPcU25pass_dynamic_object_size1PKcU25pass_dynamic_object_size1m include/linux/fortify-string.h:309 [inline]
 ucan_probe+0x195e/0x1980 drivers/net/can/usb/ucan.c:1535
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:537
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:250
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:291
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:537
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2652
 hub_port_connect drivers/usb/core/hub.c:5523 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5663 [inline]
 port_event drivers/usb/core/hub.c:5823 [inline]
 hub_event+0x2d6d/0x5150 drivers/usb/core/hub.c:5905
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

