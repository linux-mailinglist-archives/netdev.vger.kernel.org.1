Return-Path: <netdev+bounces-126279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E29705F0
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F611F21B3F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE0136663;
	Sun,  8 Sep 2024 09:07:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EC4D8CE
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786443; cv=none; b=WUN/BMqJRnamrEgzjF20Oqmtq08vEm4joDTp67pwBbhTl/G/ioOd49mBCOr8v54jfs4uJAiVY8toXHNktBM6Jy+q+RJzYD84Qn882U5JeddfRUSi8EVzjvcotNMtL2Uup53T8QmdMWRVs43+AgYs164ZGshj/icOzzEH/nhgtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786443; c=relaxed/simple;
	bh=dSZPabuk2Xw9JBNpJxD0E+Nnx6D+OjKimxJj4yQggf4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EYjwWuhnK76SnN56JaXohWAYa2NV30psS+qfxh+m+r7LVnn50lCI9YzBxcbSxxuVjOu0wcjVnkoSW8dPudlce5zpUAKRpsf6eQZMvDhff+QJZFHlVt/AYkiyWzcIImh0ojhVd45kvC7BU77/iW+AI1j3Z2chbXTo8AnDkExq3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04c905651so49154335ab.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 02:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725786441; x=1726391241;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PB0M6FGbcM3nEADdSG1yQ0/pULQ4npq5ZFp90/FjKXo=;
        b=v7Zq4P02com55enaxKXPpQ+RLNOBD9dj5m9hj8rkUeWAexuKJKYHjgry7JVzrRnjZo
         lT0lPGGDNGlm3KlcEnqSRGBxAFhJq+kdI2y6YIPfZfjikbEqcEJGDAw2DNX0FuVwRhmz
         BOI86rKxx+p6qgeEGsd0EdwDgSenikdK9JEyx3TQn7OtqtBeNGyV8DlHJZkW+oCd7ZRq
         r4PZ0t2ku7RAR8wraPEkJ+Oz5r8U7P95MBWatK/BUJ6Th3r+6FuSx3QveQkOY9SVobPW
         aksqkzNxYngwmBZYHp7kmRvqeNqs+G9NNytV1MJvRwC3GADwrpZlCBQcNEmiOwwEqU96
         d6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVxXMEYxSzfO9qcjAIcRRgOsJyq9dO2Rmj6W+3z6hUGKTA2kQ94RRZqTMApXvZJU7IMdntiOLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLP1zjx90XGBTNolFUw4J2EOTR3saySYr4YcUQc9WvUvFZLu5u
	eoqA9l+SZ9XhjpZk6/NqVNt2zVrYGKC4uFiTds3jqUkfZw8+EofMukX4r3O8zeNGIx07vPEihxO
	r94ev6LguZaSRwniz81uR3Kh6vR48GZD9ym+zEUve5zzXBrHqOucbak0=
X-Google-Smtp-Source: AGHT+IHlidgohIFoZ7hFghlXrWnl5/UDEYRWLo9NWP6gaSXPiHepHaoW1o0VoZwjjoYha8evlpTR6/ii6vR3DECh5O7q5MYDV+SR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a04f08e03dmr96650525ab.15.1725786441281; Sun, 08 Sep 2024
 02:07:21 -0700 (PDT)
Date: Sun, 08 Sep 2024 02:07:21 -0700
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca8574062197f744@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f723224742fc Merge tag 'nf-next-24-09-06' of git://git.ker..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16678877980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b0e00580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e61c7f434312/disk-f7232247.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70b00f168d68/vmlinux-f7232247.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4186da6223fd/bzImage-f7232247.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54

CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-01155-gf723224742fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5247:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5246:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x149/0x360 mm/slub.c:4598
 settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029b4dd00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888029b4dd00, ffff888029b4dd60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29b4d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801ac41280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 9062203522, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2325
 allocate_slab+0x5a/0x2f0 mm/slub.c:2488
 new_slab mm/slub.c:2541 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3727
 __slab_alloc+0x58/0xa0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 usb_hub_create_port_device+0xc8/0xc10 drivers/usb/core/port.c:743
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x2503/0x3640 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:657
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:799
 driver_probe_device+0x50/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888029b4dc00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888029b4dc80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888029b4dd00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888029b4dd80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888029b4de00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

