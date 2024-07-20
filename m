Return-Path: <netdev+bounces-112277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DD937ED9
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 05:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F561C21012
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 03:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FFB67D;
	Sat, 20 Jul 2024 03:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D191372
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721446947; cv=none; b=csIA5IycmKvHau0pRMmav0SsnrnsoV469Vet132BpMucZRm7iGkrE0yEPlo6ryQx+7V/y4uq/N1p/rcNhyFX9g+ePsj30KBQScXR0vgwQfdvZ7vtKKpgOIVe7slu8/ED3w/XfAoCeYVnObHSpN26dDfIR1b+Fz2iR81J+Zq9Wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721446947; c=relaxed/simple;
	bh=guYrTLv+K78nckAMU0MP6YEyW3ITecKrCZuyWXJx33M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uj9Ywqr2DOp97BVWsZ2qDZ1HYRnrZJ0uPI/aHqrcBukB/xeZOQJEX0/kgfNkB2RjhxppRIkaGvqQllbY/T790fkvRyU5qLBfEALh+dg3EcOPDBcAOmpQgOd5qv/z3eC8g7bs7xhM3pQHXLuqF6yR/eV8xKgJLzgU4yAdyq2yGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3971269bf67so37523475ab.0
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 20:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721446945; x=1722051745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdgbSaDFt/8em2ssKTDecqY+AcN3CHgxbXb4CDFUPVQ=;
        b=UPapqdplxSYHPq7qBY1Os+KpFqUE8nW7auhKI7V4gvhZlj8BeI1gSt9rfum9L5H7LK
         ZSwB55HssfBrAoTZQy8IR3OrvkXdWgotqMnSj/zLF1kCY7Mrzwe2mPiBGPHaoo9nFQs6
         wivBGDZE1ZiiiDNUJiFheGjkeaB3N6Um5+j6IFFG4DUn+oouNT+4UOdbCdL0DlTBEE+D
         VujWDPKnUIRJGeYM8j22qc8QdXTPLyJNgTRP0T+bFggqVNVIaXW0gfbsGdiOmeMdrmHs
         vrdQJUFWsnY/rWeyCTnJ5HxDZv7lKFv++2IuPjiPQBeyYblCD5VASH2HRUtqOiuxIqSc
         9kAA==
X-Forwarded-Encrypted: i=1; AJvYcCUfb7cP/0JbRDsDyyPUgZVWI42z40g4mB93K3bjixOOuDD7+tURKz/gH3rsnZvZ1Anvg3db5FOTVic28uqEBKjSClsF/rc+
X-Gm-Message-State: AOJu0YyvbB6k/hodkHuucSn3jvIDZNN2MTiwPhVrbCZA5CxYHXdrWG7Y
	fjD3Rl3v878mlw57cT52BlwS8zCFY8hvdLe1M0H3b1omh1Rdxl9SY6gmiafE2C9PiUDkkyZ60KG
	88QwEfYi9oENyRKeKvaiEKSCrcIXTkDtnynlWIuOQWF4xZ58aiY9Bv68=
X-Google-Smtp-Source: AGHT+IFv4U3XE9O/BUGFEhRcdJsNGtLd3wkfh8OJdTtuO4peqbwrkbLEHtqwA4bBjMwjuJnxRSlgNuGaHOgGYVhbuNWdW4fP1kxV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-398e420e366mr975355ab.1.1721446944754; Fri, 19 Jul 2024
 20:42:24 -0700 (PDT)
Date: Fri, 19 Jul 2024 20:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a461bd061da59915@google.com>
Subject: [syzbot] [net?] WARNING in hsr_netdev_notify
From: syzbot <syzbot+f62f559357490e4f015b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0c3836482481 Linux 6.10
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a5ea79980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4beb7abb485abb7b
dashboard link: https://syzkaller.appspot.com/bug?extid=f62f559357490e4f015b
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-0c383648.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724e4d62dcb4/vmlinux-0c383648.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c77816774342/Image-0c383648.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f62f559357490e4f015b@syzkaller.appspotmail.com

------------[ cut here ]------------
RTNL: assertion failed at net/hsr/hsr_slave.h (24)
WARNING: CPU: 0 PID: 2102 at net/hsr/hsr_slave.h:24 hsr_port_get_rtnl net/hsr/hsr_slave.h:24 [inline]
WARNING: CPU: 0 PID: 2102 at net/hsr/hsr_slave.h:24 hsr_netdev_notify+0x2e0/0x354 net/hsr/hsr_main.c:42
Modules linked in:
CPU: 0 PID: 2102 Comm: kworker/u8:13 Not tainted 6.10.0-syzkaller #0
Hardware name: linux,dummy-virt (DT)
Workqueue: bond0 bond_mii_monitor
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : hsr_port_get_rtnl net/hsr/hsr_slave.h:24 [inline]
pc : hsr_netdev_notify+0x2e0/0x354 net/hsr/hsr_main.c:42
lr : hsr_port_get_rtnl net/hsr/hsr_slave.h:24 [inline]
lr : hsr_netdev_notify+0x2e0/0x354 net/hsr/hsr_main.c:42
sp : ffff8000881e3b40
x29: ffff8000881e3b40 x28: 0000000000000003 x27: 0000000000000001
x26: 0000000000000000 x25: 0000000000000000 x24: ffff800082944d60
x23: f6f0000006dca600 x22: ffff8000881e3b88 x21: f6f0000006dca000
x20: 00000000ffffffc8 x19: 0000000000000004 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000881e3570
x14: 0000000000000000 x13: ffff80008263b080 x12: 0000000000001c08
x11: 0000000000000958 x10: ffff8000826eb080 x9 : ffff80008263b080
x8 : 00000000ffffdfff x7 : ffff8000826eb080 x6 : 80000000ffffe000
x5 : fff000007f8cbf48 x4 : 0000000000000000 x3 : fff07ffffd2e9000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f2f000000572ed80
Call trace:
 hsr_port_get_rtnl net/hsr/hsr_slave.h:24 [inline]
 hsr_netdev_notify+0x2e0/0x354 net/hsr/hsr_main.c:42
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0x54/0x74 kernel/notifier.c:461
 call_netdevice_notifiers_info+0x58/0xa4 net/core/dev.c:1992
 netdev_state_change net/core/dev.c:1374 [inline]
 netdev_state_change+0x68/0x8c net/core/dev.c:1367
 linkwatch_do_dev+0x80/0xec net/core/link_watch.c:177
 linkwatch_sync_dev+0x8c/0xc8 net/core/link_watch.c:263
 ethtool_op_get_link+0x18/0x34 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x68/0x154 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x110/0x91c drivers/net/bonding/bond_main.c:2826
 process_one_work+0x164/0x2a8 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x268/0x378 kernel/workqueue.c:3409
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/core/rtnetlink.c (1823)
WARNING: CPU: 0 PID: 2102 at net/core/rtnetlink.c:1823 rtnl_fill_ifinfo.constprop.0+0x9a8/0x1210 net/core/rtnetlink.c:1823
Modules linked in:
CPU: 0 PID: 2102 Comm: kworker/u8:13 Tainted: G        W          6.10.0-syzkaller #0
Hardware name: linux,dummy-virt (DT)
Workqueue: bond0 bond_mii_monitor
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : rtnl_fill_ifinfo.constprop.0+0x9a8/0x1210 net/core/rtnetlink.c:1823
lr : rtnl_fill_ifinfo.constprop.0+0x9a8/0x1210 net/core/rtnetlink.c:1823
sp : ffff8000881e3a30
x29: ffff8000881e3a30 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000010 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: ffff80008282be48
x20: f6f0000006dca000 x19: f4f0000006c2f600 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000881e3460
x14: 0000000000000000 x13: ffff80008263b080 x12: 0000000000001c74
x11: 000000000000097c x10: ffff8000826eb080 x9 : ffff80008263b080
x8 : 00000000ffffdfff x7 : ffff8000826eb080 x6 : 80000000ffffe000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f2f000000572ed80
Call trace:
 rtnl_fill_ifinfo.constprop.0+0x9a8/0x1210 net/core/rtnetlink.c:1823
 rtmsg_ifinfo_build_skb+0xc4/0x13c net/core/rtnetlink.c:4073
 rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4097 [inline]
 rtmsg_ifinfo+0x64/0xc4 net/core/rtnetlink.c:4116
 netdev_state_change net/core/dev.c:1376 [inline]
 netdev_state_change+0x84/0x8c net/core/dev.c:1367
 linkwatch_do_dev+0x80/0xec net/core/link_watch.c:177
 linkwatch_sync_dev+0x8c/0xc8 net/core/link_watch.c:263
 ethtool_op_get_link+0x18/0x34 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x68/0x154 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x110/0x91c drivers/net/bonding/bond_main.c:2826
 process_one_work+0x164/0x2a8 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x268/0x378 kernel/workqueue.c:3409
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/devlink/port.c (1595)
WARNING: CPU: 0 PID: 2102 at net/devlink/port.c:1595 devlink_compat_phys_port_name_get+0x250/0x2c4 net/devlink/port.c:1595
Modules linked in:
CPU: 0 PID: 2102 Comm: kworker/u8:13 Tainted: G        W          6.10.0-syzkaller #0
Hardware name: linux,dummy-virt (DT)
Workqueue: bond0 bond_mii_monitor
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : devlink_compat_phys_port_name_get+0x250/0x2c4 net/devlink/port.c:1595
lr : devlink_compat_phys_port_name_get+0x250/0x2c4 net/devlink/port.c:1595
sp : ffff8000881e39c0
x29: ffff8000881e39c0 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000010 x25: 0000000000000000 x24: f4f00000051ab000
x23: ffff8000881e3ae7 x22: 0000000000000000 x21: f6f0000006dca000
x20: ffff8000881e3b18 x19: 0000000000000010 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000881e33f0
x14: 0000000000000000 x13: ffff80008263b080 x12: 0000000000001ce0
x11: 00000000000009a0 x10: ffff8000826eb080 x9 : ffff80008263b080
x8 : 00000000ffffdfff x7 : ffff8000826eb080 x6 : 80000000ffffe000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f2f000000572ed80
Call trace:
 devlink_compat_phys_port_name_get+0x250/0x2c4 net/devlink/port.c:1595
 dev_get_phys_port_name+0x5c/0x70 net/core/dev.c:9146
 rtnl_phys_port_name_fill net/core/rtnetlink.c:1225 [inline]
 rtnl_fill_ifinfo.constprop.0+0x5d4/0x1210 net/core/rtnetlink.c:1903
 rtmsg_ifinfo_build_skb+0xc4/0x13c net/core/rtnetlink.c:4073
 rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4097 [inline]
 rtmsg_ifinfo+0x64/0xc4 net/core/rtnetlink.c:4116
 netdev_state_change net/core/dev.c:1376 [inline]
 netdev_state_change+0x84/0x8c net/core/dev.c:1367
 linkwatch_do_dev+0x80/0xec net/core/link_watch.c:177
 linkwatch_sync_dev+0x8c/0xc8 net/core/link_watch.c:263
 ethtool_op_get_link+0x18/0x34 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x68/0x154 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x110/0x91c drivers/net/bonding/bond_main.c:2826
 process_one_work+0x164/0x2a8 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x268/0x378 kernel/workqueue.c:3409
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/core/dev.c (7045)
WARNING: CPU: 0 PID: 2102 at net/core/dev.c:7045 netdev_master_upper_dev_get+0x90/0x98 net/core/dev.c:7045
Modules linked in:
CPU: 0 PID: 2102 Comm: kworker/u8:13 Tainted: G        W          6.10.0-syzkaller #0
Hardware name: linux,dummy-virt (DT)
Workqueue: bond0 bond_mii_monitor
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : netdev_master_upper_dev_get+0x90/0x98 net/core/dev.c:7045
lr : netdev_master_upper_dev_get+0x90/0x98 net/core/dev.c:7045
sp : ffff8000881e3a10
x29: ffff8000881e3a10 x28: 0000000000000000 x27: ffff80008228a3a0
x26: f4f00000051ab000 x25: ffff8000827a94c8 x24: f4f00000051ab000
x23: f4f00000051ab248 x22: 0000000000000000 x21: ffff80008282be48
x20: f6f0000006dca000 x19: f6f0000006dca000 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000881e3440
x14: 0000000000000000 x13: ffff80008263b080 x12: 0000000000001d52
x11: 00000000000009c6 x10: ffff8000826eb080 x9 : ffff80008263b080
x8 : 00000000ffffdfff x7 : ffff8000826eb080 x6 : 80000000ffffe000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f2f000000572ed80
Call trace:
 netdev_master_upper_dev_get+0x90/0x98 net/core/dev.c:7045
 rtnl_link_slave_info_fill net/core/rtnetlink.c:655 [inline]
 rtnl_link_fill net/core/rtnetlink.c:724 [inline]
 rtnl_fill_ifinfo.constprop.0+0xaf0/0x1210 net/core/rtnetlink.c:1922
 rtmsg_ifinfo_build_skb+0xc4/0x13c net/core/rtnetlink.c:4073
 rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4097 [inline]
 rtmsg_ifinfo+0x64/0xc4 net/core/rtnetlink.c:4116
 netdev_state_change net/core/dev.c:1376 [inline]
 netdev_state_change+0x84/0x8c net/core/dev.c:1367
 linkwatch_do_dev+0x80/0xec net/core/link_watch.c:177
 linkwatch_sync_dev+0x8c/0xc8 net/core/link_watch.c:263
 ethtool_op_get_link+0x18/0x34 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x68/0x154 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x110/0x91c drivers/net/bonding/bond_main.c:2826
 process_one_work+0x164/0x2a8 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x268/0x378 kernel/workqueue.c:3409
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---


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

