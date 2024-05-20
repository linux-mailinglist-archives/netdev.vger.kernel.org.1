Return-Path: <netdev+bounces-97153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1A48C9838
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 05:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8548A1C21349
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 03:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44596D527;
	Mon, 20 May 2024 03:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7BCA4E
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175599; cv=none; b=eJUH1NPF2+NGADjUsvaHZ/v7U8kh3MfgdiafSXomD64SyjPbZKu7Gndlhexj9Ms+QNlpvCDZvaJBIZO3Z4/2TwNcCxsprDnWhC6A4zdy6RyQ6puPPmA8+hwf5mBPTIbeLEMIhG0VF9d1jMwG1T09hyihhBE/BGVW96B1Gm+oDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175599; c=relaxed/simple;
	bh=SIU6BkS1vNzohVMZSXLGegnX1XFP2mVd9tSMrjddPYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvV/TxYptrO477Wvz6mAf+Ny3DDEoCs7yahTgJfXiufKGxU1Vhyp8mH8jPXqIxvCwCCXzSK2OdK43tnPDsYc03bZTFxByOAq/pa1g6RtlavEuEloREctPoQvsMcqQK58tO1JRKK2GvEZHgJoVlabzSR/dPxjsiRrIQdXdCKONO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so1130713639f.3
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 20:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716175596; x=1716780396;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6554Dml7AVC9MMh7rMkJuSnNnsg9u5RHnuC+rU8Skd8=;
        b=wnZdusJEc2BY28RDgW4SDS0k/tZncLfDR/Xy0/0+2xGCc9Myn96f6kprj2NStSb/cZ
         Wan2vtC3zIKsGZCXNVPhPMN4DAih4881J8chxqjstntlwYFNdFoqAo/xUEa+uJmlPKju
         WfQ1quGLsxVLlNVNS9L48KGlHdSzWgresLw623pZdZibIYBR7eA69vLSQoe46Uc86zPR
         Uv1JWgghKHqWgrmYA/LcmuUZdYXTSrvGXe3PN8XMb2iV0sCRHf2XSXITjScOdF2RW2CP
         GwD0HRXzrdx57zKQnQAqerNMNC1NSFWcplMm+xInJY6Z9loF29lpXKNng12iOs5+CiVM
         4n7A==
X-Forwarded-Encrypted: i=1; AJvYcCVg6YwBGSBwk1WijlLysd4ohybiJ4DPZs7klLm5SPAFyrrtTDCw67o8zTwCchh5pkIZsKPPmYOuRnG894l31vU4Cvetv9s4
X-Gm-Message-State: AOJu0YzoVeiXfIpgR1DlJsDXg/ERgHQXY8jfE3Sx4a5jFukimLeV3X6F
	wai5+I6Ngh0P1Q9gbWC2jaaDrDII0lCz++3aj7faBJLiasvk8yuINs4a7avTnKWFUPU5e7rvyJZ
	zs7PhASvvUqwj6ZWXw0hSkFcPRHRxPa1h264vn/agQxFUkDX9LN+SxSI=
X-Google-Smtp-Source: AGHT+IGt94fYQGCRX5Zrv8KGd9W8Iosc0WKmoDzVVJhaCxBiZ0SwoSALa9IjHh+5C+1S7DC7NtnH6Fv+9HnFCvP7ztOIaiJWNRoa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc1:b0:7da:19cb:1c7f with SMTP id
 ca18e2360f4ac-7e1b500ee78mr139469739f.0.1716175596551; Sun, 19 May 2024
 20:26:36 -0700 (PDT)
Date: Sun, 19 May 2024 20:26:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce12ef0618da4417@google.com>
Subject: [syzbot] [net?] INFO: task hung in addrconf_dad_work (4)
From: syzbot <syzbot+46af9e85f01be0118283@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f0ecf0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e50cba0cee5dac3a
dashboard link: https://syzkaller.appspot.com/bug?extid=46af9e85f01be0118283
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/890a976d962e/disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03885a88739f/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec1af8562020/bzImage-a5131c3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46af9e85f01be0118283@syzkaller.appspotmail.com

INFO: task kworker/u8:5:145 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:14192 pid:145   tgid:145   ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4192
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
2 locks held by init/1:
2 locks held by kworker/u8:1/12:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc90000117d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc90000117d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
3 locks held by kworker/1:0/25:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc900001f7d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc900001f7d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8f599888 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/30:
 #0: ffffffff8e336020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e336020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e336020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
5 locks held by kworker/u9:0/53:
 #0: ffff8881a659a948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff8881a659a948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc90000bd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc90000bd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffff8881e35a1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:309
 #3: ffff8881e35a0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5548
 #4: ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: shrink_slab+0x12b/0x14d0 mm/shrinker.c:649
1 lock held by kswapd1/89:
3 locks held by kworker/u8:5/145:
 #0: ffff888029f86148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888029f86148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc90002d17d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc90002d17d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8f599888 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4192
4 locks held by kworker/u8:6/2426:
6 locks held by kworker/u8:8/2822:
1 lock held by jbd2/sda1-8/4493:
1 lock held by udevd/4530:
2 locks held by getty/4832:
 #0: ffff88802a0ac0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by sshd/5067:
 #0: ffff8880221ec420 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:165 [inline]
 #0: ffff8880221ec420 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5633 [inline]
 #0: ffff8880221ec420 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:5693
 #1: ffffffff8e42a400 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3771 [inline]
 #1: ffffffff8e42a400 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
 #1: ffffffff8e42a400 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath+0xd31/0x23d0 mm/page_alloc.c:4202
3 locks held by syz-fuzzer/5070:
2 locks held by syz-fuzzer/5075:
3 locks held by syz-fuzzer/5087:
4 locks held by kworker/u9:1/17744:
1 lock held by syz-executor.2/18180:
 #0: ffff888065c500e0 (&type->s_umount_key#60){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888065c500e0 (&type->s_umount_key#60){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888065c500e0 (&type->s_umount_key#60){++++}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:504
4 locks held by kworker/u9:2/18553:
 #0: ffff88805e87e148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff88805e87e148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc90003377d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc90003377d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffff888073ef9060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:309
 #3: ffff888073ef8078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5548
2 locks held by syz-executor.4/18796:
3 locks held by syz-executor.2/19219:
2 locks held by syz-executor.1/19286:
2 locks held by rm/19503:
3 locks held by modprobe/19505:
5 locks held by kworker/u8:7/19507:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5075 Comm: syz-fuzzer Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__ref_is_percpu include/linux/percpu-refcount.h:174 [inline]
RIP: 0010:percpu_ref_tryget_many include/linux/percpu-refcount.h:243 [inline]
RIP: 0010:percpu_ref_tryget+0x82/0x180 include/linux/percpu-refcount.h:266
Code: 1f c6 05 fa 02 92 0d 01 48 c7 c7 e0 3b d7 8b be 0f 03 00 00 48 c7 c2 20 3c d7 8b e8 f8 73 72 ff 49 bf 00 00 00 00 00 fc ff df <48> 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 08 15 f7 ff
RSP: 0000:ffffc900034c6c30 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffff888078a32010 RCX: ffff88807a811e00
RDX: dffffc0000000000 RSI: ffffffff8c1ec8c0 RDI: ffffffff8c1ec880
RBP: ffff888078a32000 R08: ffffffff92f0b587 R09: 1ffffffff25e16b0
R10: dffffc0000000000 R11: fffffbfff25e16b1 R12: ffff888078a32054
R13: ffff888016ac4000 R14: ffffffff82009d14 R15: dffffc0000000000
FS:  000000c000d1e490(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dff07a1696 CR3: 0000000075c00000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 css_tryget include/linux/cgroup_refcnt.h:45 [inline]
 mem_cgroup_iter+0x2d3/0x560 mm/memcontrol.c:1228
 shrink_node_memcgs mm/vmscan.c:5884 [inline]
 shrink_node+0x135b/0x2d60 mm/vmscan.c:5908
 shrink_zones mm/vmscan.c:6152 [inline]
 do_try_to_free_pages+0x695/0x1af0 mm/vmscan.c:6214
 try_to_free_pages+0x760/0x1100 mm/vmscan.c:6449
 __perform_reclaim mm/page_alloc.c:3774 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
 __alloc_pages_slowpath+0xdc3/0x23d0 mm/page_alloc.c:4202
 __alloc_pages+0x43e/0x6c0 mm/page_alloc.c:4588
 alloc_pages_mpol+0x3e8/0x680 mm/mempolicy.c:2264
 alloc_pages mm/mempolicy.c:2335 [inline]
 folio_alloc+0x128/0x180 mm/mempolicy.c:2342
 filemap_alloc_folio+0xdf/0x500 mm/filemap.c:984
 __filemap_get_folio+0x41a/0xbb0 mm/filemap.c:1926
 filemap_fault+0xba2/0x1760 mm/filemap.c:3299
 __do_fault+0x135/0x460 mm/memory.c:4531
 do_read_fault mm/memory.c:4894 [inline]
 do_fault mm/memory.c:5024 [inline]
 do_pte_missing mm/memory.c:3880 [inline]
 handle_pte_fault mm/memory.c:5300 [inline]
 __handle_mm_fault+0x45fe/0x7250 mm/memory.c:5441
 handle_mm_fault+0x27f/0x770 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1332 [inline]
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x446/0x8a0 arch/x86/mm/fault.c:1533
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x43d098
Code: Unable to access opcode bytes at 0x43d06e.
RSP: 002b:000000c000d378e0 EFLAGS: 00010202
RAX: 00000000013b25a8 RBX: 00000000014b5540 RCX: 0000000000000000
RDX: 00000000013b25a8 RSI: 00000000009c053f RDI: 0000000000e4fcc0
RBP: 000000c000d37950 R08: 00000000ffffffff R09: 0000000000000080
R10: 0000000000000001 R11: 000000000001960e R12: 0000000000000002
R13: ffffffffffffffff R14: 000000c0001c4820 R15: 0000000000000000
 </TASK>
ICMPv6: ndisc: ndisc_alloc_skb failed to allocate an skb
ICMPv6: ndisc: ndisc_alloc_skb failed to allocate an skb


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

