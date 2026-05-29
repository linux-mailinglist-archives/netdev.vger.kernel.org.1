Return-Path: <netdev+bounces-292976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOVYKpIfGWqnqggAu9opvQ
	(envelope-from <netdev+bounces-292976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0D5FD40D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C922302BFEF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88738B125;
	Fri, 29 May 2026 05:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7439F160
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031372; cv=none; b=X/TWI2cc8HZI2iMIOPSEnv30AI4VA2Ymv+j/rJ0J9GmZlBuT5rigSaBX/7/cDMW4nNRMRT9SRbiQ+cM2EH1B1Rz9SL0B1UjKgX5sfTL5oFZjLBiycWG0NWSEjAHTaabmOneiLrVGN0tgLNPnh0lptlKvXpueFEGv87xmvj9VAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031372; c=relaxed/simple;
	bh=NKcYTPIYqr9Ob6XL6Udn/Il6DnixJy3CvjNRe2/6RC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m3DVNQ/li3a/ZzAqeUPRIXtNUmHF6usDtAIWPr+43lL0hT3MUEURIUhV5nQ9vtmLW0ZV7huOBEVHqAOk7JkaZtk/ezgu1cDSVRDYKpDHbca8gG+iWRn7QKSV0s84iHn6a3zkWXB073Ugyny6pwMI+vFSYdClH4latJAU0H8Xuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-69d874805ebso8652544eaf.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031367; x=1780636167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1eTMW0iN770HO3o9T8tICVeXH1P+QKE795ALLtpRqo=;
        b=SNVMDmGDJ6dZQarOCYNUeh7ADI9c+dD2gXIuOamHUgwmv3e5bDyhWiejBSdjPo2Y4Q
         nq1FOf6X23zz/aL+ye8ZQMi2HxS4pip6yprdKaCXtJk6GnV8Mu0tjJebv8WzDbluq2d+
         3mu5wU2qYGLOW+2eUo++Ryem/8zP8wOCA7EniMeUxHAMkt4UtMU6Fs6sk5jr6ZmOHYUf
         NnQq24nIU2+Vtwz8twg3NN/fxybaNeStySYvFuFGqIw8uWIdlqo3bGIneCY+mqsMSfDV
         tzDKKpe4ei9TfV9gkrAJ9yFsO5sG6EG6iiezqAwKsZOSpjBYyiw37C0kvFD64e+KbL/9
         WOKA==
X-Forwarded-Encrypted: i=1; AFNElJ/gIvM5ogkvRMkcis2/uTIROXmjBU0rCiYGuOiEn83rg8cyHeKhlu1ponZ1eKrBT7JDE6Hv7cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65uZZ9HFTMcWsqnAX315NoCrCm4CkUdtovyiKGwXQ81vIiRhm
	YXkR9c9foIPJng50+1A+UJB0PLBUo/2Y0HiXGMNZMTHZhkEqtP0j5Vli+bH54oaYSF+4or3bafn
	vIWGhnQAVu6qstsXzaOKI7hyM+5KeCYltnkEAXZIZ7c5rEX9esOipNAWRohU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1f02:b0:69d:d439:b222 with SMTP id
 006d021491bc7-69e03f01429mr773234eaf.14.1780031367463; Thu, 28 May 2026
 22:09:27 -0700 (PDT)
Date: Thu, 28 May 2026 22:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a191f87.ce022c6e.138e56.0003.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ipv6_chk_acast_addr
From: syzbot <syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=17ab782ed835fc0e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292976-lists,netdev=lfdr.de,819eb928d120d2bdad0e];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,goo.gl:url,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 20E0D5FD40D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    550604d6c9b9 Add linux-next specific files for 20260521
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1726e47e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ab782ed835fc0e
dashboard link: https://syzkaller.appspot.com/bug?extid=819eb928d120d2bdad0e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea4e4e647faa/disk-550604d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ea9373b711c/vmlinux-550604d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2f381baa460/bzImage-550604d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ipv6_chk_acast_addr+0x2c9/0xb20 net/ipv6/anycast.c:504
Read of size 8 at addr ffff88805f5cd510 by task ktimers/0/16

CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ipv6_chk_acast_addr+0x2c9/0xb20 net/ipv6/anycast.c:504
 icmp6_send+0x4c3/0x1b50 net/ipv6/icmp.c:679
 icmpv6_send include/linux/icmpv6.h:24 [inline]
 ip6_link_failure+0x3b/0x4c0 net/ipv6/route.c:2862
 dst_link_failure include/net/dst.h:456 [inline]
 ipip6_tunnel_xmit net/ipv6/sit.c:1035 [inline]
 sit_tunnel_xmit+0xa44/0x1b80 net/ipv6/sit.c:1072
 __netdev_start_xmit include/linux/netdevice.h:5394 [inline]
 netdev_start_xmit include/linux/netdevice.h:5403 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2df/0x860 net/core/dev.c:3905
 __dev_queue_xmit+0x1428/0x3900 net/core/dev.c:4872
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 ip6tunnel_xmit+0x226/0x6c0 include/net/ip6_tunnel.h:174
 ip6_tnl_xmit+0x216d/0x2930 net/ipv6/ip6_tunnel.c:1292
 __gre6_xmit+0xa4d/0xd50 net/ipv6/ip6_gre.c:787
 ip6gre_xmit_ipv6 net/ipv6/ip6_gre.c:845 [inline]
 ip6gre_tunnel_xmit+0xc3b/0xf70 net/ipv6/ip6_gre.c:897
 __netdev_start_xmit include/linux/netdevice.h:5394 [inline]
 netdev_start_xmit include/linux/netdevice.h:5403 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2df/0x860 net/core/dev.c:3905
 sch_direct_xmit+0x251/0x4c0 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4211 [inline]
 __dev_queue_xmit+0x171e/0x3900 net/core/dev.c:4833
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:488 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xd0b/0x1670 net/ipv6/ndisc.c:512
 addrconf_rs_timer+0x395/0x6d0 net/ipv6/addrconf.c:4056
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 10052:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_node_noprof+0x27d/0x6c0 mm/slub.c:5437
 _kmalloc_node_noprof include/linux/slab.h:1168 [inline]
 __get_vm_area_node+0x13f/0x300 mm/vmalloc.c:3215
 __vmalloc_node_range_noprof+0x36a/0x1750 mm/vmalloc.c:4022
 __vmalloc_node_noprof mm/vmalloc.c:4123 [inline]
 vmalloc_noprof+0xb2/0xe0 mm/vmalloc.c:4158
 bpf_prog_calc_tag+0x4c/0x370 kernel/bpf/core.c:307
 check_and_resolve_insns+0xbd/0x2510 kernel/bpf/verifier.c:18084
 bpf_check+0x12bf/0x51d0 kernel/bpf/verifier.c:19694
 bpf_prog_load+0x1406/0x1a10 kernel/bpf/syscall.c:3128
 __sys_bpf+0xd0b/0xd90 kernel/bpf/syscall.c:6350
 __do_sys_bpf kernel/bpf/syscall.c:6469 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6466 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6466
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10052:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6284 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6599
 bpf_prog_calc_tag+0x315/0x370 kernel/bpf/core.c:334
 check_and_resolve_insns+0xbd/0x2510 kernel/bpf/verifier.c:18084
 bpf_check+0x12bf/0x51d0 kernel/bpf/verifier.c:19694
 bpf_prog_load+0x1406/0x1a10 kernel/bpf/syscall.c:3128
 __sys_bpf+0xd0b/0xd90 kernel/bpf/syscall.c:6350
 __do_sys_bpf kernel/bpf/syscall.c:6469 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6466 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6466
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805f5cd500
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 16 bytes inside of
 freed 96-byte region [ffff88805f5cd500, ffff88805f5cd560)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805f5cdd00 pfn:0x5f5cd
flags: 0x80000000000200(workingset|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000200 ffff88813fe20280 ffffea00009c7810 ffffea000130be50
raw: ffff88805f5cdd00 0000000800200004 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10, tgid 10 (kworker/0:1), ts 109626662632, free_ts 109611667027
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1866
 prep_new_page mm/page_alloc.c:1874 [inline]
 get_page_from_freelist+0x265c/0x26e0 mm/page_alloc.c:3953
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5296
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab+0x74/0x5e0 mm/slub.c:3404
 new_slab mm/slub.c:3447 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7226
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4665
 alloc_from_pcs mm/slub.c:4763 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __kmalloc_cache_noprof+0x44e/0x690 mm/slub.c:5420
 _kmalloc_noprof include/linux/slab.h:967 [inline]
 _kzalloc_noprof include/linux/slab.h:1284 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event+0xf36/0xa390 drivers/net/netdevsim/fib.c:889
 nsim_fib_event_work+0x26e/0x3e0 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
 process_scheduled_works kernel/workqueue.c:3401 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 4981 tgid 4981 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1413 [inline]
 __free_frozen_pages+0x10af/0x1190 mm/page_alloc.c:2957
 __slab_free+0x252/0x2a0 mm/slub.c:5646
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4583 [inline]
 slab_alloc_node mm/slub.c:4912 [inline]
 __kmalloc_cache_noprof+0x338/0x690 mm/slub.c:5420
 _kmalloc_noprof include/linux/slab.h:967 [inline]
 _kzalloc_noprof include/linux/slab.h:1284 [inline]
 kernfs_fop_open+0x39a/0xcb0 fs/kernfs/file.c:641
 do_dentry_open+0x83d/0x13e0 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1052
 do_open fs/namei.c:4688 [inline]
 path_openat+0x2eea/0x3960 fs/namei.c:4847
 do_file_open+0x23e/0x4a0 fs/namei.c:4876
 do_sys_openat2+0x115/0x200 fs/open.c:1344
 do_sys_open fs/open.c:1350 [inline]
 __do_sys_openat fs/open.c:1366 [inline]
 __se_sys_openat fs/open.c:1361 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1361
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805f5cd400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88805f5cd480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88805f5cd500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                         ^
 ffff88805f5cd580: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88805f5cd600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


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

