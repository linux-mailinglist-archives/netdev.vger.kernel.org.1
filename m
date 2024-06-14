Return-Path: <netdev+bounces-103621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E6908CCF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C15D1F26B5B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C979CF;
	Fri, 14 Jun 2024 13:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDC19D8AE
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373441; cv=none; b=BncP6BH4wdgT7BPk0BaidpZw5z4XWJJne8FmBVgwVp0GLYXElHFtS0BcZLECalZY2rK1pMkwchy/Roabz8TWziqPJ3jHdqJ7uuiG3aHWsioWwDKE4KHyyJh2DCzVXhep22oQdJ6sAGMHehJZcgm2Aal2FoSJVXe/RdPiYjFNtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373441; c=relaxed/simple;
	bh=BYD8UOEU2vVnYti+IZtFPBfQoWeOOHaqqXqCOEEm9a4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R+j0WpP6o4jf+G4RiH7iJG6mNb9RG2wLEN0q/ShcIwmKhW0q2DjFe1f4U0KagXJMGVnkIzyilIE6F0UXGB0gy1s0lR3DbazIKgjOttQMpTsY8G0QBMqsnxDeJ+w/aFNsElXjZ5UbLHEt1eCVw0wWuaj6AD5yUFAnGZYVFd4NUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so214560739f.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718373438; x=1718978238;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKfSpRWCAohZXKFpcx5c8GbsuZPJk363sAvhcB7aaFk=;
        b=Uizgc/f5pNLptnqvur2uOxmPjl9XkvtcFw3/gQnvislsx3Bm9sa3+64qv0WYgBT4K0
         LBYMdlFCEERkGse0T+vVk2cR+6bDqi9UBL47Ca3P/o5ptF2O0vnlrNzZSoaxe9kEFC0H
         WF5KGRZQYrup5EyhhfP5qPIdWMITwNkgOHP/4GtpeI/CoqjuNzKk99c5EG4gaIPrF6Lt
         BQBgcxrRQVY85VqAObMs8LTULwiEGAouF182UWKmLc/sKLzTiicBaS+xHfNzTaIMq8Kq
         UxWmQ/5+qzUqzKIr0jmkHeb8gXx4FlW8eHePo61+tEXsEKUOH/pKgW1u3mHgfatNiQ92
         oLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo1SFxMxwzehG/9f+tdGwiy+RqSiM/kQ56atShdfdeaXqL4ff3hmcPy+xfeGA8zMYaMpvW0Jhe/olTA1tR4f4Wp1XhXRtV
X-Gm-Message-State: AOJu0YzYjsTe4kNOZoSKMRwNqSAwkRgYrFPlzvBMKLtfN/RMrd6wbpV1
	h4yJxAqpTL2K2y9GD5mE9hJ9WHgpTKUOkVJduZ9ZXgmaufwTp/SbemDE2sNA5YjC7R8cHB26VYg
	VnO9RKKzKxEqztodfw04bEZ6RbIGUnyP0mQ5OJkZCmnoEuzR9GFCaeYc=
X-Google-Smtp-Source: AGHT+IGun4W5Tjwq8Ryn2pfhvlBE3+obd/1fTziq7wxTty3KC22+aeEND9OHvCNW7ijYqKL8UNSkGSaV4yNuchci12SYaO5w11IE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-375e1036551mr1968155ab.6.1718373438558; Fri, 14 Jun 2024
 06:57:18 -0700 (PDT)
Date: Fri, 14 Jun 2024 06:57:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065a682061ad9fe42@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in mini_qdisc_pair_swap
From: syzbot <syzbot+f243d5f2675d3151439a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=149601f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=f243d5f2675d3151439a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f243d5f2675d3151439a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mini_qdisc_pair_swap+0x68/0x164 net/sched/sch_generic.c:1557
Read of size 8 at addr ffff00018c4b9000 by task kworker/u4:6/261

CPU: 1 PID: 261 Comm: kworker/u4:6 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: netns cleanup_net
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 mini_qdisc_pair_swap+0x68/0x164 net/sched/sch_generic.c:1557
 clsact_chain_head_change+0x28/0x38 net/sched/sch_ingress.c:60
 tcf_chain_head_change_item net/sched/cls_api.c:493 [inline]
 tcf_chain0_head_change_cb_del+0x1e0/0x2d8 net/sched/cls_api.c:940
 tcf_block_put_ext+0xfc/0x33c net/sched/cls_api.c:1529
 clsact_destroy+0x1fc/0x790 net/sched/sch_ingress.c:300
 __qdisc_destroy+0x160/0x4b8 net/sched/sch_generic.c:1067
 qdisc_put net/sched/sch_generic.c:1094 [inline]
 shutdown_scheduler_queue+0x168/0x200 net/sched/sch_generic.c:1147
 dev_shutdown+0x244/0x480 net/sched/sch_generic.c:1481
 unregister_netdevice_many_notify+0x7f4/0x17b8 net/core/dev.c:11073
 unregister_netdevice_many net/core/dev.c:11139 [inline]
 default_device_exit_batch+0xa1c/0xa9c net/core/dev.c:11619
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x5dc/0x8d0 net/core/net_namespace.c:618
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 5782:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x26c/0x49c mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 uevent_show+0x160/0x320 drivers/base/core.c:2656
 dev_attr_show+0x60/0xcc drivers/base/core.c:2364
 sysfs_kf_seq_show+0x2d0/0x43c fs/sysfs/file.c:59
 kernfs_seq_show+0x150/0x1fc fs/kernfs/file.c:205
 seq_read_iter+0x3e0/0xc44 fs/seq_file.c:230
 kernfs_fop_read_iter+0x144/0x5c8 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:2081 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x78c/0x954 fs/read_write.c:476
 ksys_read+0x15c/0x26c fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:627
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 5782:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:589
 poison_slab_object+0x124/0x18c mm/kasan/common.c:240
 __kasan_slab_free+0x3c/0x70 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x144/0x3cc mm/slub.c:4409
 uevent_show+0x1c8/0x320 drivers/base/core.c:2669
 dev_attr_show+0x60/0xcc drivers/base/core.c:2364
 sysfs_kf_seq_show+0x2d0/0x43c fs/sysfs/file.c:59
 kernfs_seq_show+0x150/0x1fc fs/kernfs/file.c:205
 seq_read_iter+0x3e0/0xc44 fs/seq_file.c:230
 kernfs_fop_read_iter+0x144/0x5c8 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:2081 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x78c/0x954 fs/read_write.c:476
 ksys_read+0x15c/0x26c fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:627
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff00018c4b8000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 allocated 4096-byte region [ffff00018c4b8000, ffff00018c4b9000)

The buggy address belongs to the physical page:
page:000000000267b9c9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1cc4b8
head:000000000267b9c9 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002140 fffffdffc6008a00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00018c4b8f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00018c4b8f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff00018c4b9000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff00018c4b9080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff00018c4b9100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Unable to handle kernel paging request at virtual address e0d5c054000002d6
KASAN: maybe wild-memory-access in range [0x06b202a0000016b0-0x06b202a0000016b7]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[e0d5c054000002d6] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 261 Comm: kworker/u4:6 Tainted: G    B              6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: netns cleanup_net
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mini_qdisc_pair_swap+0x130/0x164 net/sched/sch_generic.c:1585
lr : mini_qdisc_pair_swap+0x124/0x164 net/sched/sch_generic.c:1585
sp : ffff800097bb74e0
x29: ffff800097bb74e0 x28: 1fffe00018f4985c x27: ffff800089180b74
x26: 1fffe00018f4986c x25: 06b202a000001696 x24: dfff800000000000
x23: 1fffe00031897200 x22: ffff00018c4b9000 x21: ffff0000c7a4c310
x20: 00000000000170f0 x19: 06b202a0000016b6 x18: 1fffe00036804396
x17: ffff80008ec9d000 x16: ffff800080276f8c x15: 0000000000000001
x14: 1ffff00011dcf390 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : 1fffe00018b89781
x8 : 00d64054000002d6 x7 : 1fffe00036804397 x6 : ffff8000803be9e4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000c5c4bc00 x1 : 0000000000000000 x0 : 00000000000170f0
Call trace:
 mini_qdisc_pair_swap+0x130/0x164 net/sched/sch_generic.c:1585
 clsact_chain_head_change+0x28/0x38 net/sched/sch_ingress.c:60
 tcf_chain_head_change_item net/sched/cls_api.c:493 [inline]
 tcf_chain0_head_change_cb_del+0x1e0/0x2d8 net/sched/cls_api.c:940
 tcf_block_put_ext+0xfc/0x33c net/sched/cls_api.c:1529
 clsact_destroy+0x1fc/0x790 net/sched/sch_ingress.c:300
 __qdisc_destroy+0x160/0x4b8 net/sched/sch_generic.c:1067
 qdisc_put net/sched/sch_generic.c:1094 [inline]
 shutdown_scheduler_queue+0x168/0x200 net/sched/sch_generic.c:1147
 dev_shutdown+0x244/0x480 net/sched/sch_generic.c:1481
 unregister_netdevice_many_notify+0x7f4/0x17b8 net/core/dev.c:11073
 unregister_netdevice_many net/core/dev.c:11139 [inline]
 default_device_exit_batch+0xa1c/0xa9c net/core/dev.c:11619
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x5dc/0x8d0 net/core/net_namespace.c:618
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 97b951d7 91008333 aa0003f4 d343fe68 (38786908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97b951d7 	bl	0xfffffffffee5475c
   4:	91008333 	add	x19, x25, #0x20
   8:	aa0003f4 	mov	x20, x0
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38786908 	ldrb	w8, [x8, x24] <-- trapping instruction


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

