Return-Path: <netdev+bounces-236174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF901C39549
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A104E1C37
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A90284686;
	Thu,  6 Nov 2025 07:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6B27B4FB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412788; cv=none; b=ehvNH6UjOq8KiVA8FnsIeCli889LLFC8Av+Tyy26ybuEaWOZFRbq88rUJkBVYmbFbPjTfHoJbAqoswRY1zUH7cTjgpswph5arPkBI0aIbGRXgmm4eeGLS0ZTJoL+/ZIN9vN51/VNNuJITmHXaJ4ERlFXtaurj0eZWkl/nXSRpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412788; c=relaxed/simple;
	bh=Vsck3KVS79t9iyBWAKXa9PBwAc6LKWW5IM6f2vwD49s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k8LdKc4d+1i0zahlrMeLAjOeaijytYFj1B3rvjK5JPI7H9oAxG6s3EHRABeaDUQf8klEPh8fmkqIc6+niuMBvxOr90RZQwWX+L6aYklLGg6qIuYhNh6yJgc6CrdJh/y3nQtDDCMf4xBRl9mZ2zuGuklCsseqbOMJwyX4dyjyHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43333f50556so2016185ab.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 23:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762412786; x=1763017586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHGI1fIvq5g4LUo0l+Mvua/E9YykyS2a0n+xCruQvDo=;
        b=geKQJTRKAfwR9VdxTSJBbXEljRdn8gP0nOU9oPSTXlbn/Md7GrIj8Z2ljlP+CaCgKs
         SkWccKqktsqJrTCIo824dmKDknfZvPkrFTZbYiG6ohu8Kin+LeuUE3q/2IPxAn544TIh
         pww3QTxeI99y+8VfCt19dztNdw9fimyRs/ga8TXI1nT0RVotVSwg8OfbNuA5+t/+M4EW
         4oUVHMdAuOUxEyKPqsbVLKll+bgJMY/LKFuMGsB7+7Hwce8YC1SB22C5ptOsLCfLlop+
         iHwG8snUK10vzXJfu0axuPoJTPx3FzMX+3ZSpbO1nqIShm1sj8xp7R/bq7ckt8nx2XcQ
         A70g==
X-Forwarded-Encrypted: i=1; AJvYcCVt0mNkHRAVGACtWsXkFuMZKIU9uLbD1z1nRMyOOMWksUMeHGTSmsX2J/R4UCHL9Df9CPy8xf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCGWZuuEaKLUurWwaIOCn/sTUqy51xwpEbYif6IsELyI/yms7
	rJ97+WBCgGJWBebJGdyMryqWmQtkmHsF2jfqX++yIWi5HeH+weT7ra8TMkxMrtR71JV3PIatjx/
	Ck0KGYOI6mKyLHGydewfYhNnOeAqOQUVZexdeB1c8UNI8PQuh5vqd/v8ee18=
X-Google-Smtp-Source: AGHT+IEtLYA4a8D4q653L6XpdJakCkkDFF5JUVAdgzAl1r6TN+xd/0xGAlCuV7tFyHS/r2CKE+ekR0AUbPacvzqGZpQjspU0we4Q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d84:b0:433:209d:feee with SMTP id
 e9e14a558f8ab-433407a1353mr105670735ab.13.1762412786137; Wed, 05 Nov 2025
 23:06:26 -0800 (PST)
Date: Wed, 05 Nov 2025 23:06:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c48f2.050a0220.baf87.0080.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in qfq_reset_qdisc (2)
From: syzbot <syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    143937ca51cc arm64, mm: avoid always making PTE dirty in p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15939b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=ec7176504e5bcc33ca4e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11763734580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b9e3e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6ff641e43d2/disk-143937ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22d9e0afd13f/vmlinux-143937ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ab2dee8c9ca/Image-143937ca.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com

 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
==================================================================
BUG: KASAN: slab-use-after-free in qfq_reset_qdisc+0xcc/0x208 net/sched/sch_qfq.c:1484
Read of size 8 at addr ffff0000ca2bfe50 by task syz.0.17/6716

CPU: 0 UID: 0 PID: 6716 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 qfq_reset_qdisc+0xcc/0x208 net/sched/sch_qfq.c:1484
 qdisc_reset+0x128/0x598 net/sched/sch_generic.c:1038
 __qdisc_destroy+0x134/0x4bc net/sched/sch_generic.c:1077
 qdisc_put net/sched/sch_generic.c:1109 [inline]
 dev_shutdown+0x35c/0x47c net/sched/sch_generic.c:1497
 unregister_netdevice_many_notify+0xbb8/0x1de0 net/core/dev.c:12242
 unregister_netdevice_many net/core/dev.c:12317 [inline]
 unregister_netdevice_queue+0x2b4/0x300 net/core/dev.c:12161
 unregister_netdevice include/linux/netdevice.h:3389 [inline]
 __tun_detach+0x5d4/0x1304 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x118/0x1f8 drivers/net/tun.c:3436
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Allocated by task 6716:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3a4/0x65c mm/slub.c:5748
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 qfq_change_class+0x498/0xbe8 net/sched/sch_qfq.c:479
 __tc_ctl_tclass net/sched/sch_api.c:2274 [inline]
 tc_ctl_tclass+0x988/0x10b0 net/sched/sch_api.c:2304
 rtnetlink_rcv_msg+0x624/0x97c net/core/rtnetlink.c:6963
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6981
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2719
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 6716:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 __kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2523 [inline]
 slab_free mm/slub.c:6611 [inline]
 kfree+0x184/0x600 mm/slub.c:6818
 qfq_change_class+0x92c/0xbe8 net/sched/sch_qfq.c:533
 __tc_ctl_tclass net/sched/sch_api.c:2274 [inline]
 tc_ctl_tclass+0x988/0x10b0 net/sched/sch_api.c:2304
 rtnetlink_rcv_msg+0x624/0x97c net/core/rtnetlink.c:6963
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6981
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2719
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the object at ffff0000ca2bfe00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 80 bytes inside of
 freed 128-byte region [ffff0000ca2bfe00, ffff0000ca2bfe80)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10a2bf
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000000 ffff0000c0001a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ca2bfd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
 ffff0000ca2bfd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000ca2bfe00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff0000ca2bfe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000ca2bff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
==================================================================
Unable to handle kernel paging request at virtual address 006a007b60000350
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
[006a007b60000350] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6716 Comm: syz.0.17 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : qfq_reset_qdisc+0xbc/0x208 net/sched/sch_qfq.c:1484
lr : qfq_reset_qdisc+0x158/0x208 net/sched/sch_qfq.c:1483
sp : ffff8000a5b577c0
x29: ffff8000a5b577d0 x28: 0000000000000000 x27: 1fffe0001a92d05a
x26: 006a807b60000350 x25: dfff800000000000 x24: 0000000000000000
x23: 035403db00001a84 x22: 035403db00001a34 x21: ffff0000d49682d0
x20: ffff0000d49682d8 x19: ffff0000d4968000 x18: 1fffe000337db690
x17: 3d3d3d3d3d3d3d3d x16: ffff800082de9540 x15: 0000000000000001
x14: 1ffff0001250b1b8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001250b1b9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c9320000 x7 : 0000000000000001 x6 : ffff8000805638d4
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008936af34
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 qfq_reset_qdisc+0xbc/0x208 net/sched/sch_qfq.c:1484 (P)
 qdisc_reset+0x128/0x598 net/sched/sch_generic.c:1038
 __qdisc_destroy+0x134/0x4bc net/sched/sch_generic.c:1077
 qdisc_put net/sched/sch_generic.c:1109 [inline]
 dev_shutdown+0x35c/0x47c net/sched/sch_generic.c:1497
 unregister_netdevice_many_notify+0xbb8/0x1de0 net/core/dev.c:12242
 unregister_netdevice_many net/core/dev.c:12317 [inline]
 unregister_netdevice_queue+0x2b4/0x300 net/core/dev.c:12161
 unregister_netdevice include/linux/netdevice.h:3389 [inline]
 __tun_detach+0x5d4/0x1304 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x118/0x1f8 drivers/net/tun.c:3436
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: d1002116 b4000656 910142d7 d343fefa (38796b48) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d1002116 	sub	x22, x8, #0x8
   4:	b4000656 	cbz	x22, 0xcc
   8:	910142d7 	add	x23, x22, #0x50
   c:	d343fefa 	lsr	x26, x23, #3
* 10:	38796b48 	ldrb	w8, [x26, x25] <-- trapping instruction


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

