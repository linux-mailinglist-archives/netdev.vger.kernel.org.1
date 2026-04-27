Return-Path: <netdev+bounces-281274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GrFDt4o72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:14:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E946FA78
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A00A3015489
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4D3AF65C;
	Mon, 27 Apr 2026 09:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82813537E0
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281098; cv=none; b=Kk5vqEYoSCX9KULEdz2oERsmHHnALNJrXP4ss7h5Mq0am/8P+zaOTyIrBu9ll0Qu6MstmyqGt25/hIgiT8nBJyq/Yg2s1cN75FydaPOK/SF0O37m7s7eP4OKo8H/1qbHG+RazqpSoURssdYNOMPVNMO0uFW5UbIYGFJSn/g79lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281098; c=relaxed/simple;
	bh=jhGn3H6ocpNxJ4vyT3z3D8M3pZX4kkkF9znL6PXQRTw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pDprbfQw8iw7qFMd/EDlTZO1qut+8g4uPA7jZyPrvv8v+9dltFqaaDjZ8T8HybMa6JVbFb5RnV4bYUVUStqgOJ8JvoShwodJshmtEFLA1mLoefHD/O+se3iYJtPSQzW0IX8qd+A6kAjrRfQhoHZRXPtmrdGsaeQjk+5/HYrf2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69499294b86so369350eaf.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281096; x=1777885896;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzGg3B+iYTsTVsDgfi9HtRk3XALEky74wv8gUZg0ikI=;
        b=IpHvsmu5QLjksf886Iq3nFg9AyzYMl75DQOWpnWh0crdKjUdhLofxDG6ZwGAm2lwNP
         iy7NWEOnd9vK1xgEL/ag7AsbiTGeE4DDJz8pTrjYSJXH16EjzfShap+VwVeqA5pySwy5
         QbzTup0DH5dEWP2/+rKakOdInIGm8aG5oUiSJOilWzSYGDcN01nU+I1kdTC7yevzvcvt
         5k8AuSpRVO0tqYa8aHk/61aGaG1dcUYNu0e0J6l8vFj1lPbxnpCRx6hyQsj5D34dMkb2
         ydum8/PIwotAASjFwTKZuOSP8yh67XYz0qQzbc4MljjL2+ZcxtXc8oEn5V5a7Ce1wbGz
         u74w==
X-Forwarded-Encrypted: i=1; AFNElJ8wjIkPsH7VXaQxeGraan3k4Und7a7KX4JcgIPU9zTcXqCbYPkWAVCfuhCmJa/khz5b3oZmpVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0v3QLvuoS5t/ASTR76EvlfWOwiRe1Mo5vY0CzRzFPTsu/c+M
	kkKUgIWLJrm1FsMBXrDdgE8jg0Wk/7YOIdpmQ3Us88Y+OJTkEEkM7ZBaNl7slwtu8CtP8/sc2Yx
	sYiFZZZLC8sshPGXFAJuHZdWODApobBZfwK3tuhHu+uBd1ud0sN+9Y/muJg0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:28c8:b0:67e:36e9:79aa with SMTP id
 006d021491bc7-69462e5e116mr18644274eaf.16.1777281095982; Mon, 27 Apr 2026
 02:11:35 -0700 (PDT)
Date: Mon, 27 Apr 2026 02:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef2847.170a0220.11de9.001a.GAE@google.com>
Subject: [syzbot] [hams?] KASAN: slab-use-after-free Read in ax25_send_frame (3)
From: syzbot <syzbot+9c8999af06ca7df15fc6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A12E946FA78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ca77bfc4078c8193];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281274-lists,netdev=lfdr.de,9c8999af06ca7df15fc6];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]

Hello,

syzbot found the following issue on:

HEAD commit:    e728258debd5 Merge tag 'net-7.1-rc1' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d109ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca77bfc4078c8193
dashboard link: https://syzkaller.appspot.com/bug?extid=9c8999af06ca7df15fc6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24195bde5d1d/disk-e728258d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78131d1b0e14/vmlinux-e728258d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/836d0dd78c10/bzImage-e728258d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c8999af06ca7df15fc6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in kmemdup_noprof+0x55/0x70 mm/util.c:140
Read of size 66 at addr ffff8880310ac600 by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 kmemdup_noprof+0x55/0x70 mm/util.c:140
 kmemdup_noprof include/linux/fortify-string.h:763 [inline]
 ax25_send_frame+0x693/0x9f0 net/ax25/ax25_out.c:78
 rose_send_frame net/rose/rose_link.c:106 [inline]
 rose_transmit_restart_request net/rose/rose_link.c:198 [inline]
 rose_t0timer_expiry+0x255/0x560 net/rose/rose_link.c:83
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: db 70 02 e9 53 f4 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 81 10 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8e607dc0 EFLAGS: 00000242
RAX: 0000000000110dc7 RBX: ffffffff819aae9a RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8dfd8f45 RDI: ffffffff8c289f60
RBP: ffffffff8e607eb0 R08: ffff8880b86339db R09: 1ffff110170c673b
R10: dffffc0000000000 R11: ffffed10170c673c R12: 0000000000000000
R13: 1ffffffff1cd25d8 R14: 0000000000000000 R15: 1ffffffff1cd25d8
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x36a/0x5f0 kernel/sched/idle.c:352
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:451
 rest_init+0x2de/0x300 init/main.c:762
 start_kernel+0x38a/0x3e0 init/main.c:1220
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147
 </TASK>

Allocated by task 10474:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 rose_add_node+0x471/0xf00 net/rose/rose_route.c:109
 rose_rt_ioctl+0xd35/0x12a0 net/rose/rose_route.c:748
 rose_ioctl+0x3fb/0x8f0 net/rose/af_rose.c:1387
 sock_do_ioctl+0x101/0x320 net/socket.c:1313
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6561
 rose_neigh_put include/net/rose.h:165 [inline]
 rose_timer_expiry+0x4c3/0x600 net/rose/rose_timer.c:183
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff8880310ac600
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff8880310ac600, ffff8880310ac660)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x310ac
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe2e280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 22916083211, free_ts 22905974702
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x392/0x660 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 lookup_or_create_module_kobject+0x75/0x170 kernel/params.c:759
 module_add_driver+0x79/0x320 drivers/base/module.c:46
 bus_add_driver+0x391/0x670 drivers/base/bus.c:760
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 usb_register_driver+0x1e4/0x390 drivers/usb/core/driver.c:1078
 do_one_initcall+0x250/0x870 init/main.c:1392
 do_initcall_level+0x104/0x190 init/main.c:1454
 do_initcalls+0x59/0xa0 init/main.c:1470
 kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbc7/0xd30 mm/page_alloc.c:2943
 vfree+0x1d1/0x2f0 mm/vmalloc.c:3472
 tpg_free+0x3aa/0x430 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:202
 vivid_dev_release+0xc5/0x120 drivers/media/test-drivers/vivid/vivid-core.c:865
 v4l2_device_release drivers/media/v4l2-core/v4l2-device.c:51 [inline]
 kref_put include/linux/kref.h:65 [inline]
 v4l2_device_put+0x81/0xd0 drivers/media/v4l2-core/v4l2-device.c:56
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:2070 [inline]
 vivid_probe+0x4a4a/0x72b0 drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0xf9/0x190 drivers/base/platform.c:1418
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __driver_attach+0x34c/0x640 drivers/base/dd.c:1295
 bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x345/0x670 drivers/base/bus.c:756
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 vivid_init+0x561/0x5f0 drivers/media/test-drivers/vivid/vivid-core.c:2294
 do_one_initcall+0x250/0x870 init/main.c:1392

Memory state around the buggy address:
 ffff8880310ac500: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff8880310ac580: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff8880310ac600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff8880310ac680: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880310ac700: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	db 70 02             	(bad) 0x2(%rax)
   3:	e9 53 f4 02 00       	jmp    0x2f45b
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 13 81 10 00 	verw   0x108113(%rip)        # 0x10813b
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

