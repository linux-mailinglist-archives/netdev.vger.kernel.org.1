Return-Path: <netdev+bounces-157734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53526A0B6D0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA261889E9C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEB22A4EB;
	Mon, 13 Jan 2025 12:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AC204581
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771131; cv=none; b=eFADgrSaJ/3EJqUVdCY/YO8Wns4bcnthGKa5FzHmM629x0z+nM0fbOjBWYl66435D06j4VcJ1+v75zXGuiBBysQHlI5nfJ0W3ubhuRiO1BUwURJh/aBMody0RD2tNzwO50otdtApqMX/FxIYTvsCEniuLLUsZQRf/P+/7Z3zkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771131; c=relaxed/simple;
	bh=wk6Be8Rzoltg/X/rxu+04rAKF1RCNnxpNvlvXmovYq4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JWyi5XzStnDIyI9CJXcHXKF5HgQEPp7+67V/rnUM9LcrPG+mnJ4UmvIfYJUWALCg2cPK+80ngUANgi11Jc8qShW0MX2E+VHsJPXvIg8f6WcbSQPXa+NPH4zrCV12tTORZ/0uEROSM5FtENJv1lu+JDMNUYTXZfO9Vz55fc1fvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso39212095ab.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736771129; x=1737375929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlKlMGa3zAnMBI/+QCYv2Q2QQ45YDo0HW/RLvV58LG8=;
        b=qguHm+RcvxLA5IHcj5Im6L1TIMUTdluINKxNSZRK3Tp4r19EKPQnapo2mLt6Kmj8kB
         i50vxKymM/Pan9U1VfWeNsfV8Nx3oTHMXZrE7A+lvBXDtCoxp57qHINVmYYCLNXeDZIf
         XNAVd4RkN4lQfUBm3T1IyYblzSGr8U1WykZnXc33Qas64gFl9ktx6elOlXJPTKmUyLE9
         7ACB2y6egV6w58ifz1Q3hqin7YCOApb1mbTH5EJuCN89z+NsErwObQG4pSoLlceHTDjn
         8HtgcPy4OERqngo8Yzyp5ZOnAtVV0jW9mf7Kis91hAFJZByjlJ6x6M871fd/syk0pTwT
         tMRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLFLyELE27dd5LPwh8sl+TqNlO3ZeRfhDYa5RmiLkzgEZ1EejcPMi2HXa4quINEQzzfWhepcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU5zddseHPRBEehPKM5KLtIlHvTdLyZFtd2BNXmZ8pZxInXMO
	Vd92C+cYQ8zMbNFbImPtq5k6hUhLX9ZFfkBwHv4oUkvq4f54UHZvotkYpajXq5zEftd9exfsOqv
	GiFCHP9o3R2vK/z8RAnGV/7w2Splk5P9TTf7ByWMCdz2LYgg9xj5MDSY=
X-Google-Smtp-Source: AGHT+IF2NvZ1BRMFx7ZHQ4buguv70ui5XOgr4S7wznRGZdEytm0f4H6+j68zj/7vwrS7iXt6RxH6g8cvicd9Un43WFknvWNnmRO/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ae:b0:3a7:c5ca:5f58 with SMTP id
 e9e14a558f8ab-3ce3a9b5404mr138741435ab.7.1736771129252; Mon, 13 Jan 2025
 04:25:29 -0800 (PST)
Date: Mon, 13 Jan 2025 04:25:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67850639.050a0220.216c54.0050.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in netpoll_poll_disable (2)
From: syzbot <syzbot+54f9a6de31e425e46ace@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    577490b6abb9 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=134b270f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5408fc4cf982e2c4
dashboard link: https://syzkaller.appspot.com/bug?extid=54f9a6de31e425e46ace
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9a89a276c80/disk-577490b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c19133a4de5/vmlinux-577490b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0dde1fa5fad3/Image-577490b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54f9a6de31e425e46ace@syzkaller.appspotmail.com

bridge0: port 1(bridge_slave_0) entered disabled state
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 7557 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 0 PID: 7557 at kernel/locking/lockdep.c:232 __lock_acquire+0x7b0/0x7904 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 0 UID: 0 PID: 7557 Comm: kworker/u8:12 Tainted: G        W          6.13.0-rc6-syzkaller-g577490b6abb9 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: netns cleanup_net
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4850 [inline]
pc : __lock_acquire+0x7b0/0x7904 kernel/locking/lockdep.c:5176
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4850 [inline]
lr : __lock_acquire+0x7a4/0x7904 kernel/locking/lockdep.c:5176
sp : ffff80009eff7040
x29: ffff80009eff7300 x28: ffff0000d7a60000 x27: ffff0000d7a60b40
x26: 1fffe0001af4c168 x25: 0000000000000000 x24: 0000000000000001
x23: ffff0000d7a60a78 x22: ffff0000d7a60b20 x21: ffff0000d7a60b44
x20: 00000000000015c5 x19: ffff8000931c7a78 x18: ffff80009eff6738
x17: 0000000000000000 x16: ffff8000803b4180 x15: 0000000000000001
x14: 1ffff00011f49f9c x13: dfff800000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 0c98272ec0943100
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff8000804a69fc
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008047cc34
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4850 [inline] (P)
 __lock_acquire+0x7b0/0x7904 kernel/locking/lockdep.c:5176 (P)
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 down+0x3c/0xe8 kernel/locking/semaphore.c:59
 netpoll_poll_disable+0xe8/0x100 net/core/netpoll.c:222
 __dev_close_many+0x104/0x3c8 net/core/dev.c:1532
 dev_close_many+0x1e0/0x474 net/core/dev.c:1585
 unregister_netdevice_many_notify+0x454/0x1c6c net/core/dev.c:11502
 unregister_netdevice_many+0x28/0x38 net/core/dev.c:11592
 cleanup_net+0x5c8/0xa34 net/core/net_namespace.c:643
 process_one_work+0x7a8/0x15cc kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 489272
hardirqs last  enabled at (489271): [<ffff80008030e224>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:394
hardirqs last disabled at (489272): [<ffff80008b6c638c>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (489272): [<ffff80008b6c638c>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (489270): [<ffff8000861788ac>] pppoe_flush_dev drivers/net/ppp/pppoe.c:327 [inline]
softirqs last  enabled at (489270): [<ffff8000861788ac>] pppoe_device_event+0x464/0x4a0 drivers/net/ppp/pppoe.c:346
softirqs last disabled at (489268): [<ffff800086178530>] pppoe_flush_dev drivers/net/ppp/pppoe.c:279 [inline]
softirqs last disabled at (489268): [<ffff800086178530>] pppoe_device_event+0xe8/0x4a0 drivers/net/ppp/pppoe.c:346
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000018
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
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
[dfff800000000018] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:

CPU: 0 UID: 0 PID: 7557 Comm: kworker/u8:12 Tainted: G        W          6.13.0-rc6-syzkaller-g577490b6abb9 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: netns cleanup_net
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4850 [inline]
pc : __lock_acquire+0x574/0x7904 kernel/locking/lockdep.c:5176
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4850 [inline]
lr : __lock_acquire+0x7a4/0x7904 kernel/locking/lockdep.c:5176
sp : ffff80009eff7040
x29: ffff80009eff7300 x28: ffff0000d7a60000 x27: ffff0000d7a60b40
x26: 1fffe0001af4c168 x25: 0000000000000000 x24: 0000000000000001
x23: ffff0000d7a60a78 x22: ffff0000d7a60b20 x21: 00000000000000c4
x20: 00000000000015c5 x19: ffff8000931c7a78 x18: ffff80009eff6738

x17: 0000000000000000
 x16: ffff8000803b4180
 x15: 0000000000000001
x14: 1ffff00011f49f9c x13: dfff800000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 0c98272ec0943100

x8 : 0000000000000018
 x7 : 4e5241575f534b43
 x6 : ffff8000804a69fc

x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008047cc34
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000

Call trace:
 check_wait_context kernel/locking/lockdep.c:4850 [inline] (P)
 __lock_acquire+0x574/0x7904 kernel/locking/lockdep.c:5176 (P)
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 down+0x3c/0xe8 kernel/locking/semaphore.c:59
 netpoll_poll_disable+0xe8/0x100 net/core/netpoll.c:222
 __dev_close_many+0x104/0x3c8 net/core/dev.c:1532
 dev_close_many+0x1e0/0x474 net/core/dev.c:1585
 unregister_netdevice_many_notify+0x454/0x1c6c net/core/dev.c:11502
 unregister_netdevice_many+0x28/0x38 net/core/dev.c:11592
 cleanup_net+0x5c8/0xa34 net/core/net_namespace.c:643
 process_one_work+0x7a8/0x15cc kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 34000fa8 aa1f03e8 91031115 d343fea8 (38ed6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	34000fa8 	cbz	w8, 0x1f4
   4:	aa1f03e8 	mov	x8, xzr
   8:	91031115 	add	x21, x8, #0xc4
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38ed6908 	ldrsb	w8, [x8, x13] <-- trapping instruction


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

