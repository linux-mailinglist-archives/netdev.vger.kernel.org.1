Return-Path: <netdev+bounces-213023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A043B22DD9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7ADA165E5B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7D2F549A;
	Tue, 12 Aug 2025 16:31:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900B2F2900
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016298; cv=none; b=HlIdKGiwUMcfnFF81s9xDSLW0OmgDDYELA1uW4hh/Vr664V0qTfZrMDpJ79z2LLgqrNO8Qf9eieUNu21cv6I1dRVynFlu/6uv2npjVNI1NRzz6CjVu4t877k9qsfmpkVDBhu2S42jvtm3o8oB4XTPfas1Lvm7hH0XQE+2VuFsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016298; c=relaxed/simple;
	bh=mEyCROJ7ksAaIcSi5vN82QcICHBjKIOinJzgTmepqOM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HLXerIr6LfpfoXoMYGaBjZD4G4JoNjDe2Y62CZpaDliny2m7KUorck3eJr49OdXXK5zWJRhh2ugk/yVYMVXNaNeZ/ts3sEYVKPzYbTnaffpAvNUySH/OqA/h7YhGCFIy71KSabimBPrj6lIIzN0KVv6LVnamuovwGHUVG2y8/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88178b5ce3aso543640039f.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016296; x=1755621096;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLs7X8EcsVOsOKLnQEUaliSvTAEIpt58s/g0vpng1nM=;
        b=HXa2DYKn5axsSbTQrIpDZUFjF9LRAi/8lbJNE4j284FIo0onaz+RFVGRYMuRpNUMVe
         zCI9c8KU1dLr/7Xwha5EhYD3x5ENozNSBeMPByxxVvZGgsKpAgH7EvUYOeTgeajcdsv/
         Pw+hrr2QYvMKqrtNJbYjFSChQqfkkwOIBWpYBvJEjPrLQHBN+2TkB4cq/QUvx4rVqfHK
         Inb9GMBnelhk/X9GZL4FKMBdrQA878K8/BDTvgexispgVIhxsxo49Nughqkk4j7fd7cC
         YPBdozv9VghjnBJMtdJQFPe9FWYtmu3GYRdlLJu6123kepF3m/FSAErmQO+2h6nW0za5
         cOjw==
X-Forwarded-Encrypted: i=1; AJvYcCXuSn6eU2N4c5aSMOC64jXGU5qPouRvE7DDkkewa3lEYeMBn6WJjiIwqpVO0OY2PpHVW1dk7Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEb9VdwqM8CS57ohIx1JKkLrhL8Mpcr3muZZOCESTgtO6pT++w
	HcmSXbC8Z4Iig99RGzye1VVYajHNFzXGbdW79HiBb6Rc3rNYdxq4RQilBP1IC56cBXRSITiaSh7
	w4kRffj6ix7m7Sjugrf0FfkA5JjRW4kolhKxXTQf6IdK6JEwF8c4d/jKsUi8=
X-Google-Smtp-Source: AGHT+IEYzhTGVCbYOSHr1Q87yxGIKJMLmS9Bu1iiBsS6tu96Bx51Qr0SGjZsDKB1lC5wmcbZsChLLF/4UUqoYYZZdqQDdajafY2h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9744:0:b0:881:72ca:57f with SMTP id
 ca18e2360f4ac-88428c2ae6fmr24103239f.10.1755016295785; Tue, 12 Aug 2025
 09:31:35 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:31:35 -0700
In-Reply-To: <67251e01.050a0220.529b6.0162.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b6c67.050a0220.7f033.0134.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15494c34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1428caf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11da19a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cdc3889e34d0/mount_4.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1412a842580000)

The issue was bisected to:

commit c8992cffbe7411c6da4c4416d5eecfc6b78e0fec
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Dec 1 18:55:05 2021 +0000

    Bluetooth: hci_event: Use of a function table to handle Command Complete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d538c4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d538c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d538c4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:183 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common+0xcb4/0x24ac kernel/locking/mutex.c:678
Read of size 8 at addr ffff0000c99f80a0 by task khidpd_05c25886/6940

CPU: 0 UID: 0 PID: 6940 Comm: khidpd_05c25886 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __mutex_waiter_is_first kernel/locking/mutex.c:183 [inline]
 __mutex_lock_common+0xcb4/0x24ac kernel/locking/mutex.c:678
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 l2cap_unregister_user+0x74/0x190 net/bluetooth/l2cap_core.c:1728
 hidp_session_thread+0x3d0/0x46c net/bluetooth/hidp/core.c:1304
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Allocated by task 6767:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x2fc/0x4c8 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 hci_alloc_dev_priv+0x2c/0x1b84 net/bluetooth/hci_core.c:2448
 hci_alloc_dev include/net/bluetooth/hci_core.h:1706 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:399 [inline]
 vhci_create_device+0x108/0x6d4 drivers/bluetooth/hci_vhci.c:471
 vhci_get_user drivers/bluetooth/hci_vhci.c:528 [inline]
 vhci_write+0x314/0x3d4 drivers/bluetooth/hci_vhci.c:608
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 6984:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x74/0x98 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x17c/0x474 mm/slub.c:4879
 hci_release_dev+0xf48/0x1060 net/bluetooth/hci_core.c:2776
 bt_host_release+0x70/0x8c net/bluetooth/hci_sysfs.c:87
 device_release+0x8c/0x1ac drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b0/0x438 lib/kobject.c:737
 put_device+0x28/0x40 drivers/base/core.c:3797
 hci_free_dev+0x24/0x34 net/bluetooth/hci_core.c:2579
 vhci_release+0x84/0xd0 drivers/bluetooth/hci_vhci.c:666
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:961
 do_group_exit+0x194/0x22c kernel/exit.c:1102
 get_signal+0x11dc/0x12f8 kernel/signal.c:3034
 do_signal+0x274/0x4434 arch/arm64/kernel/signal.c:1618
 do_notify_resume+0xb0/0x1f4 arch/arm64/kernel/entry-common.c:152
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:173 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:182 [inline]
 el0_svc+0xb8/0x180 arch/arm64/kernel/entry-common.c:880
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 kasan_record_aux_stack+0xb0/0xc8 mm/kasan/generic.c:548
 insert_work+0x54/0x2cc kernel/workqueue.c:2184
 __queue_work+0xc88/0x1210 kernel/workqueue.c:2343
 queue_work_on+0xdc/0x18c kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 hci_cmd_timeout+0x178/0x1c8 net/bluetooth/hci_core.c:1480
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Second to last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 kasan_record_aux_stack+0xb0/0xc8 mm/kasan/generic.c:548
 insert_work+0x54/0x2cc kernel/workqueue.c:2184
 __queue_work+0xdb0/0x1210 kernel/workqueue.c:2339
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
 call_timer_fn+0x1b4/0x818 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1793 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x54c/0x76c kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2403
 handle_softirqs+0x328/0xc88 kernel/softirq.c:579
 __do_softirq+0x14/0x20 kernel/softirq.c:613

The buggy address belongs to the object at ffff0000c99f8000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 160 bytes inside of
 freed 8192-byte region [ffff0000c99f8000, ffff0000c99fa000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1099f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0002280 fffffdffc374ca00 0000000000000005
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0002280 fffffdffc374ca00 0000000000000005
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3267e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c99f7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c99f8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c99f8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff0000c99f8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c99f8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

