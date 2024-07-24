Return-Path: <netdev+bounces-112882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A093B973
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CD51C21810
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B951420B0;
	Wed, 24 Jul 2024 23:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570A13B58C
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721863947; cv=none; b=EWwV7cw9ZdMKRNwBSCDba/ik/erPJ10ErUzwkzElXStdBhvaZpuohVtELdYgi20KmKazttJxOdY3m4w3T4OEQ6Sj5savFxzC4rJ/elhfKcbWOPzccfqmkZW6hAwmPmbQQLI6FejCFrdeHsV62Br4UDIC6RFhapSUdB1rJOUOoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721863947; c=relaxed/simple;
	bh=kfRvAwbeVtNWRofTnzUgX5Acm4O53yfy4KgN63KsPc4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rOh++7sUi5zrkzqWqprcmfl/2aPhDEDsJrGBrGruHj8Ek7v42GvxamoIvBuOPFP89BOEe/ZjuGvO4L9rI9EKPnDlmQDTeTMG8AkiktXTsXT2t4k6Ei7Dtngw3Uhomwx24icI2mbi+1BiiwZHpYsgBVfdOfU2ahno/zBlfvjocpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39915b8e08dso4586855ab.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721863945; x=1722468745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwTTtjYlw5GVDjSrxnJcd1PrIjYrxQ+ocsAA4fC9mYI=;
        b=Ywyqo2teu9Rjy3cbviYHQ8CngJOK75U8IHrzY0QK8a52iJll9u9+ZK2rqr4rRnWTGo
         WRrlMkOxs3oy0ck6fQAOgCKBntKK+m0KYEEaeFkAEgY8xtLNFlOr7axUAl3fzY6tNuxg
         FREHizjeAdrW+dLHWg/sLrYx6NWGQ6UUadQ53FeHIW5nUmoR/NpYriYOIy4sHp1JzHc9
         Ei9AXZOFNFaHAPyuswPHzyOjAcV7zk2Qf+5FfjJ3E53qNEFuHDdu7tQht1qZJPfC+/VO
         VMFemAM/ZVchkoeGgAdSdN0Lro8QrbTeimLOtfQlFAucxdNWzu+eAGzgocoOYUF0uxIt
         nPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVwZKtqmX+Y78cvI3F6zgN7N61+0YJW5D1LruRmAFd86/X9xMeBVgPGB+fZ9a4uHSS10b/EuOUjQ1VC8729OQGjtY76Rl+g
X-Gm-Message-State: AOJu0Yx7Hs6bjEuRyz7iSL3xuji3tDhR2UdxtOiVm5lTgjtKhwzk5tjd
	0d9X0yGEzedB3zCaAbS2YN5yxlzZHpgSAQv4xfzEPMUgS+tQ14o4n+DJzcxldAOp6+1Bd2K5DWS
	o15gOWc97rTziKH72xfMIeGSMvm/R34ekyODX4xftQZAfU3/a86MD9gc=
X-Google-Smtp-Source: AGHT+IFdsZrDwVIjd+HFfjr1YDzeifRR8x2hO6ihEGMvnyapxkEZtHozrnYcRina5m52eNnZhcbhghUGfyJJWdQYEvtSBUqQMPRQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:39a:1b94:9733 with SMTP id
 e9e14a558f8ab-39a23f5b73bmr141775ab.2.1721863944984; Wed, 24 Jul 2024
 16:32:24 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caeb6e061e06b05a@google.com>
Subject: [syzbot] [net?] [usb?] KMSAN: uninit-value in skb_put
From: syzbot <syzbot+1b110e469044ea5131fc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3c3ff7be9729 Merge tag 'powerpc-6.11-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1445bdfd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f80e9475fcd20eb6
dashboard link: https://syzkaller.appspot.com/bug?extid=1b110e469044ea5131fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e380ff27a7b/disk-3c3ff7be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74499c63aea1/vmlinux-3c3ff7be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9806780eb03b/bzImage-3c3ff7be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b110e469044ea5131fc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in skb_put+0x1d2/0x230 net/core/skbuff.c:2594
 skb_put+0x1d2/0x230 net/core/skbuff.c:2594
 rx_complete+0xd5/0xe00 drivers/net/usb/usbnet.c:594
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 smap_restore arch/x86/include/asm/smap.h:56 [inline]
 __msan_poison_alloca+0x163/0x1b0 mm/kmsan/instrumentation.c:290
 __rseq_handle_notify_resume+0x447/0x22c0 kernel/rseq.c:333
 rseq_handle_notify_resume include/linux/rseq.h:38 [inline]
 resume_user_mode_work include/linux/resume_user_mode.h:62 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xa0/0x170 kernel/entry/common.c:218
 do_syscall_64+0xda/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4706
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2304 [inline]
 allocate_slab+0x20a/0x1550 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3706
 __slab_alloc mm/slub.c:3796 [inline]
 __slab_alloc_node mm/slub.c:3849 [inline]
 slab_alloc_node mm/slub.c:4016 [inline]
 kmem_cache_alloc_node_noprof+0x5fd/0xb80 mm/slub.c:4071
 __alloc_skb+0x1e9/0x7b0 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_uevent_skb+0xdb/0x350 lib/kobject_uevent.c:289
 uevent_net_broadcast_tagged lib/kobject_uevent.c:352 [inline]
 kobject_uevent_net_broadcast+0x243/0xd70 lib/kobject_uevent.c:413
 kobject_uevent_env+0xd29/0x11e0 lib/kobject_uevent.c:593
 kobject_uevent+0x37/0x50 lib/kobject_uevent.c:641
 rx_queue_add_kobject net/core/net-sysfs.c:1120 [inline]
 net_rx_queue_update_kobjects+0x66c/0xa80 net/core/net-sysfs.c:1160
 register_queue_kobjects net/core/net-sysfs.c:1895 [inline]
 netdev_register_kobject+0x30e/0x530 net/core/net-sysfs.c:2140
 register_netdevice+0x1aae/0x22d0 net/core/dev.c:10435
 lapbeth_new_device drivers/net/wan/lapbether.c:418 [inline]
 lapbeth_device_event+0x10d6/0x16f0 drivers/net/wan/lapbether.c:460
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe8/0x440 kernel/notifier.c:461
 call_netdevice_notifiers_info+0x1be/0x2b0 net/core/dev.c:1994
 __dev_notify_flags+0x217/0x3b0
 dev_change_flags+0x168/0x1d0 net/core/dev.c:8914
 devinet_ioctl+0x13ec/0x22c0 net/ipv4/devinet.c:1177
 inet_ioctl+0x4bd/0x6d0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xb7/0x540 net/socket.c:1222
 sock_ioctl+0x727/0xd70 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1a06/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 6199 Comm: udevd Not tainted 6.10.0-syzkaller-10729-g3c3ff7be9729 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


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

