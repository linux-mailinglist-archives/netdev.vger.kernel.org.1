Return-Path: <netdev+bounces-94202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059458BE98F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA51C23C77
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7F16D9CD;
	Tue,  7 May 2024 16:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FD16C688
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100082; cv=none; b=JKEjTpemICP1PtH9aQhzuP9vgPU72g8YPwFa00in5IsSAWktGzKST7M57SYbOXRyJRseLnBBYNaGFnVTbSqey0xtSEi2nuDa4snb/HIfPY1HrWedNXse1i5Yy61UmG8WpETQ3TE2nJvo63Mj17pJPtOBYosnVpPRHhTaU1LzqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100082; c=relaxed/simple;
	bh=AzlKhiG1mh6g3a66sjKCAxc25fDQc/PgmHOO3eXDQaw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u4BK36r3+2vvntgHBlB+QOFMC1dU5hzEUh8cKXu3xtHXkKTkptM9Ep8I0hcqQSbbTlxt1GjPH1t4IPAI3MDZzZDHGxd5cuaph9ZFj+VfsNHrkLYz0+OUesSkGnaBPH5PlOvL1QSkASFAQNUj/g0yfYie8SaPLTpfBqYl+67l9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e186a8af8bso69862339f.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100079; x=1715704879;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgvR9oRSytAO9NBz0K1QIsnebNTgL08/8AVH103tg/I=;
        b=kYfdnN3LHPBi9uJ6ueB36ZxkAb0R9vhtL8CuQOjidBOPMRjVvhtf5qNhPcHzgS4rgm
         ooktQ8nm4jE/35T6jZMyOuWliwMs1GVC0gnuN7ZAPG3CSY/Aha0Wuex0yyS0bod4YolY
         LnITueQXIcFqRTFPlI+0rvLNfRaPUsC5tRajWGyJFX+OohaDhnCKJpaeHSW3Mo5gUj1p
         CU/T8qtAaHPmat6ORpZHrEmDKH9AMC8v6ML5EVooNhl1rTbP93tn7KyGvVhtPSQRgJEm
         SNz7juytMP0jHxEXZ6n4MUqWIGqSYr2A/AiNTwAOdUpZnxhxVY0H4ObVw9dWZ2zbSBwi
         ft2g==
X-Forwarded-Encrypted: i=1; AJvYcCW2O0jLaIpzl4lNK5HVvD/jN+pfTWzsbpmWjg0Yk12Le1nkh/2WfHQOhA7y4Tyr4lEHaywO2RFChHlLzcuJknx4BnI8YvNx
X-Gm-Message-State: AOJu0YyKYVZG3Nv2uxW75EabZx/z1GbX7MC/4Id38w3jNfUxmGqBBByF
	RK24zAyye7xWZPkKOgvAYHBVGykaT5RNOPUT6SB3TQrsSEVLrhvah9qNL97dgDjjXLjiR9bC9V2
	/PIUlfanKlH9Vp1A/tz0PdEO5ZnbmBE8ZqkAk1jAbel9c0nv9V4ZCiFs=
X-Google-Smtp-Source: AGHT+IEFGEw+ps6ADGFBmqBGnxabzZVGLEw//1iCASOPy8LaLIZnucvCZwHQsltAdgMRQ1IOChZn0V6GC//cfrU8ZLYVf/V+dFAd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3787:b0:488:b879:a392 with SMTP id
 w7-20020a056638378700b00488b879a392mr286661jal.6.1715100079494; Tue, 07 May
 2024 09:41:19 -0700 (PDT)
Date: Tue, 07 May 2024 09:41:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe2e920617dfdafb@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9abbc24128bc Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16d93522180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11839322180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13010a54180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce13ec3ed5ad/disk-9abbc241.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/256cbd314121/vmlinux-9abbc241.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0af86fb52109/Image-9abbc241.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __skb_unlink include/linux/skbuff.h:2366 [inline]
BUG: KASAN: slab-use-after-free in __skb_dequeue include/linux/skbuff.h:2385 [inline]
BUG: KASAN: slab-use-after-free in __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
BUG: KASAN: slab-use-after-free in __skb_queue_purge include/linux/skbuff.h:3181 [inline]
BUG: KASAN: slab-use-after-free in kcm_release+0x170/0x4c8 net/kcm/kcmsock.c:1691
Read of size 8 at addr ffff0000ced0fc80 by task syz-executor329/6167

CPU: 1 PID: 6167 Comm: syz-executor329 Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __skb_unlink include/linux/skbuff.h:2366 [inline]
 __skb_dequeue include/linux/skbuff.h:2385 [inline]
 __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
 __skb_queue_purge include/linux/skbuff.h:3181 [inline]
 kcm_release+0x170/0x4c8 net/kcm/kcmsock.c:1691
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1421
 __fput+0x30c/0x738 fs/file_table.c:376
 ____fput+0x20/0x30 fs/file_table.c:404
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x618/0x1f64 kernel/exit.c:871
 do_group_exit+0x194/0x22c kernel/exit.c:1020
 get_signal+0x1500/0x15ec kernel/signal.c:2893
 do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 6166:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x70/0x84 mm/kasan/generic.c:626
 unpoison_slab_object mm/kasan/common.c:314 [inline]
 __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x204/0x4c0 mm/slub.c:3903
 __alloc_skb+0x19c/0x3d8 net/core/skbuff.c:641
 alloc_skb include/linux/skbuff.h:1296 [inline]
 kcm_sendmsg+0x1d3c/0x2124 net/kcm/kcmsock.c:783
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_sendmsg+0x220/0x2c0 net/socket.c:768
 splice_to_socket+0x7cc/0xd58 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0xec/0x1d8 fs/splice.c:1164
 splice_direct_to_actor+0x438/0xa0c fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x1e4/0x304 fs/splice.c:1233
 do_sendfile+0x460/0xb3c fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __arm64_sys_sendfile64+0x160/0x3b4 fs/read_write.c:1348
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 6167:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x5c/0x74 mm/kasan/generic.c:640
 poison_slab_object+0x124/0x18c mm/kasan/common.c:241
 __kasan_slab_free+0x3c/0x78 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x15c/0x3d4 mm/slub.c:4363
 kfree_skbmem+0x10c/0x19c
 __kfree_skb net/core/skbuff.c:1109 [inline]
 kfree_skb_reason+0x240/0x6f4 net/core/skbuff.c:1144
 kfree_skb include/linux/skbuff.h:1244 [inline]
 kcm_release+0x104/0x4c8 net/kcm/kcmsock.c:1685
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1421
 __fput+0x30c/0x738 fs/file_table.c:376
 ____fput+0x20/0x30 fs/file_table.c:404
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x618/0x1f64 kernel/exit.c:871
 do_group_exit+0x194/0x22c kernel/exit.c:1020
 get_signal+0x1500/0x15ec kernel/signal.c:2893
 do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000ced0fc80
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 0 bytes inside of
 freed 240-byte region [ffff0000ced0fc80, ffff0000ced0fd70)

The buggy address belongs to the physical page:
page:00000000d35f4ae4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10ed0f
flags: 0x5ffc00000000800(slab|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000800 ffff0000c1cbf640 fffffdffc3423100 dead000000000004
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ced0fb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000ced0fc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff0000ced0fc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff0000ced0fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff0000ced0fd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================
Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6167 Comm: syz-executor329 Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __skb_unlink include/linux/skbuff.h:2369 [inline]
pc : __skb_dequeue include/linux/skbuff.h:2385 [inline]
pc : __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
pc : __skb_queue_purge include/linux/skbuff.h:3181 [inline]
pc : kcm_release+0x1a4/0x4c8 net/kcm/kcmsock.c:1691
lr : __skb_unlink include/linux/skbuff.h:2368 [inline]
lr : __skb_dequeue include/linux/skbuff.h:2385 [inline]
lr : __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
lr : __skb_queue_purge include/linux/skbuff.h:3181 [inline]
lr : kcm_release+0x1a0/0x4c8 net/kcm/kcmsock.c:1691
sp : ffff800097a775e0
x29: ffff800097a77600 x28: 1fffe0001b4b0051 x27: 1fffe0001b4b0053
x26: dfff800000000000 x25: 0000000000000008 x24: 02a800ec00001817
x23: ffff0000ced0fc80 x22: ffff0000da580298 x21: ffff0000da580288
x20: ffff0000da580000 x19: 0000000000000000 x18: 1fffe00036804796
x17: ffff80008ec8d000 x16: ffff80008ac97900 x15: ffff600019da1f90
x14: 1fffe00019da1f90 x13: 00000000000000fa x12: fffffffffffffffe
x11: ffff600019da1f90 x10: 1fffe00019da1f91 x9 : ffff800093475840
x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffff800080297af0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ced0fc80
Call trace:
 __skb_unlink include/linux/skbuff.h:2369 [inline]
 __skb_dequeue include/linux/skbuff.h:2385 [inline]
 __skb_queue_purge_reason include/linux/skbuff.h:3175 [inline]
 __skb_queue_purge include/linux/skbuff.h:3181 [inline]
 kcm_release+0x1a4/0x4c8 net/kcm/kcmsock.c:1691
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1421
 __fput+0x30c/0x738 fs/file_table.c:376
 ____fput+0x20/0x30 fs/file_table.c:404
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x618/0x1f64 kernel/exit.c:871
 do_group_exit+0x194/0x22c kernel/exit.c:1020
 get_signal+0x1500/0x15ec kernel/signal.c:2893
 do_signal+0x23c/0x3b44 arch/arm64/kernel/signal.c:1249
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: f94006f8 91002279 9776b98f d343ff28 (387a6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f94006f8 	ldr	x24, [x23, #8]
   4:	91002279 	add	x25, x19, #0x8
   8:	9776b98f 	bl	0xfffffffffddae644
   c:	d343ff28 	lsr	x8, x25, #3
* 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction


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

