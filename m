Return-Path: <netdev+bounces-129215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58797E420
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33CB2810F4
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 23:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EC7711B;
	Sun, 22 Sep 2024 23:08:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327F535D4
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727046503; cv=none; b=aFsiyTheHxhqQC/HmYKQogjvxJCxCg5bRInvlilnV12D0a5OJkBgMR7SydUOeEEnZphwk8t4TvuvBC85AWvYcVsDK/WtzFbYYbSkNXASLIpZCHNPSJaPQbClOhmc4YvyLTeG1tkRttKSL2qsYf0nTPKevS/S4RpNmGLbllBie/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727046503; c=relaxed/simple;
	bh=VEMKNRhtM8106fxnnmEHNXFe77uEvoQwoECzdjmjkBw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OBmrPMBBWD9je/fEFeUyUCQDKUABq3jvEFycl7aQxbsY5cto+Z51pYjtRgIrB33PoxOL/D0ckE5XTDHHTWX4J6DayBNx8avnj+qRmTcRQBfyig2HUmdj5zblnezh0LqQPJz2LmgjKQD3qvRn9Az7xAT6VCyXYYkPD7diddn50Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f5605c674so60792875ab.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 16:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727046501; x=1727651301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKzSJ/WaGJM/ku5gQoaoOIrRJShwWPCCrXWi3XodAHg=;
        b=NWrJDC1E5m8oUxwkpJj/QBvqI2UyswVB+3yZw2diCTEfTMjtbdmAVSHT2XRlOyORmT
         NRhdo5zzw7bpjO6bG6qgFyQ9cL7nJi5fszqB2xiWgLO0AH9c32si7eQ34fOYAMRQoFcy
         s3g62BMynvSfYfd8sn6MFlnq0kfwjMSpv7l0mw4CLFXfkk286jd3rnpGmt4SsMzxS9Ra
         AfyWFZDqWLYzvdFdiq9h1gukRR2aAsuiXv6iQMbZBAz2JAAGOrPqbTqkjQR1wqChaiGi
         hFjcj7PiEMWBNkevDvdVGo0G6G/JW+xSSmiNKYeJlzbZK+5Qulr2sVriZJ/zPu7XbHY4
         dD9w==
X-Forwarded-Encrypted: i=1; AJvYcCVp5la/tkKXFqLd7WLJglJUDTIITwRfo8t8kgPZxCVR2BvuO1OJaHWtS88/nxdCreSApSBaORU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6GZmkOt4C0C06WnOGv8z7xT/HvGoHGn8YcG8Rmbt68S4aHnn
	LGnvgReIB9qi5gBkbLY6PoaW/7Bjjp3/8Qhuuph3ZD61QdAwGnfrc5CWtAOI7t+ukHi9tG//dHQ
	WAmg+16GvA7d/XPdPJDlpFyD26zAtWw1UVAGI0wYaeR3NJ4NGfhqqxyU=
X-Google-Smtp-Source: AGHT+IHLDjB33A3pCGradFc/31YGrEYQVjlq9w3rRdYgCR6dbgkKL+Q/KSRP1Azpj/pA/wl8TmwEnkv/vrmlh+E/PEOVEYYYUZ44
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c544:0:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a0c8ceecd2mr85137885ab.13.1727046501203; Sun, 22 Sep 2024
 16:08:21 -0700 (PDT)
Date: Sun, 22 Sep 2024 16:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f0a365.050a0220.a27de.000a.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hif_usb_reg_in_cb
From: syzbot <syzbot+e5388ea6d2de83957e35@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131524a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b82e97dfbc92f0
dashboard link: https://syzkaller.appspot.com/bug?extid=e5388ea6d2de83957e35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b415ca186bb1/disk-bdf56c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ce89ea52bab/vmlinux-bdf56c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f99c9bf1bec/bzImage-bdf56c75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5388ea6d2de83957e35@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __skb_set_length include/linux/skbuff.h:3190 [inline]
BUG: KMSAN: uninit-value in ath9k_hif_usb_reg_in_cb+0x84d/0x9b0 drivers/net/wireless/ath/ath9k/hif_usb.c:756
 __skb_set_length include/linux/skbuff.h:3190 [inline]
 ath9k_hif_usb_reg_in_cb+0x84d/0x9b0 drivers/net/wireless/ath/ath9k/hif_usb.c:756
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1026 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1043
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x33/0x60 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 dummy_pullup+0x273/0x320 drivers/usb/gadget/udc/dummy_hcd.c:924
 usb_gadget_disconnect_locked+0x1f8/0x5b0 drivers/usb/gadget/udc/core.c:777
 gadget_unbind_driver+0xe6/0x5f0 drivers/usb/gadget/udc/core.c:1666
 device_remove drivers/base/dd.c:566 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x58a/0x990 drivers/base/dd.c:1295
 driver_detach+0x360/0x540 drivers/base/dd.c:1358
 bus_remove_driver+0x465/0x500 drivers/base/bus.c:742
 driver_unregister+0x8d/0x100 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x55/0xa0 drivers/usb/gadget/udc/core.c:1731
 raw_release+0x1bc/0x400 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x32c/0x1120 fs/file_table.c:431
 ____fput+0x25/0x30 fs/file_table.c:459
 task_work_run+0x268/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x170 kernel/entry/common.c:218
 do_syscall_64+0xda/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4725
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2263
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2343
 alloc_slab_page mm/slub.c:2413 [inline]
 allocate_slab+0x320/0x12c0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3819
 __slab_alloc mm/slub.c:3909 [inline]
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 kmem_cache_alloc_noprof+0x57a/0xb20 mm/slub.c:4142
 skb_clone+0x303/0x550 net/core/skbuff.c:2084
 dev_queue_xmit_nit+0x4d0/0x12a0 net/core/dev.c:2315
 xmit_one net/core/dev.c:3584 [inline]
 dev_hard_start_xmit+0x17d/0xa20 net/core/dev.c:3604
 __dev_queue_xmit+0x3576/0x55e0 net/core/dev.c:4424
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 neigh_connected_output+0x5a0/0x690 net/core/neighbour.c:1594
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0x2347/0x2ba0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
 ip6_finish_output+0xbb8/0x14b0 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x356/0x620 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xb9f/0x14c0 net/ipv6/ndisc.c:511
 ndisc_send_rs+0x97e/0xae0 net/ipv6/ndisc.c:721
 addrconf_rs_timer+0x488/0x6f0 net/ipv6/addrconf.c:4042
 call_timer_fn+0x49/0x580 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1845 [inline]
 __run_timers kernel/time/timer.c:2419 [inline]
 __run_timer_base+0x84e/0xe90 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2449
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x68/0x120 kernel/softirq.c:637
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702

CPU: 0 UID: 0 PID: 7385 Comm: syz.1.489 Tainted: G        W          6.11.0-syzkaller-04744-gbdf56c7580d2 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

