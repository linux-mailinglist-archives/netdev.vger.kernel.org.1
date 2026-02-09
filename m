Return-Path: <netdev+bounces-257979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKV9I1Ipimm6HwAAu9opvQ
	(envelope-from <netdev+bounces-257979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:37:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC61139B4
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2395304483B
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B638A72A;
	Mon,  9 Feb 2026 18:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00F3876C7
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662134; cv=none; b=svBzS8WbI2EvVV3G8ub8oJhQVDK9FUGzwSUsHn27xaTAZaHUpiwKBmImHW0DaUv5OnYmNHI9GZBmEduBXg0X+BN1Kdg8+9fa405dmWHheLyzbhXsCePV4O081Js+/JQfu5Dlq+K3iU3Zim6dZZFTjlncVLU2TD3LavZtVM3uU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662134; c=relaxed/simple;
	bh=LdVtwpRxDCnJM5F0Vu1ghRkmhsv/wKAya9T/ZdcmWxk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=anv7nVXmO7wcb6+dH8JvD9pEOz2hDXDt1lQlmhqiO/nTy8uqNlLFDGyMaeyOaz9R5BE5iH7mQzUYORQVdMEQfTdP/l5/T3H8S6Dlaz8Os2/zFNBHkAY6JcT6d0ScjFGJt9rCZFzBmwstBN2FHhQOrODkn/AaUNtQXg+UZTfi7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-66ae8dc8e36so12725871eaf.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 10:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662133; x=1771266933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t27OSZioXi3DhRXbmTrMhKKPcnoiLHYsUdZ0l+733Pc=;
        b=pTJpxfk/Y3GxjT4BrVhsKU7LzTMLwBtAh/KMYPXeMeyhiKMSrSfKNBaQB8U3KlSHhB
         a9FwLq0rdeuKeKjI+son1BahGloZv4ZmNKW8WJv2klG4iGDZZZPNc4c5ZV2MHl2EOPNk
         +/AlCzH+8iGJhIFP5n1+bxo96DT66BhWSnXsP41Gliru9ZoJWxCIx+yI+jNwZb77/D8e
         0jafHCnxbxba6niPjHkut3bveKvMteQHvZbbO/nFyZBmx8OWEuA1zwuIbF+9wug5d2WF
         R3fWPSrpl7/kQVRuTarvF4X55R8SNQqty9DEek97TEpZ9tyabAB2bg2d7ZLD47URDpVg
         gIDw==
X-Forwarded-Encrypted: i=1; AJvYcCUD3eZ5I/d2+nn6PH7a8Q1Cuq5pM81Ol4umHwZ+h5sEsGE6DzfttWH4cR8JhEeaYSsXN82Ec1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRz58edSKjteOBFLpZtPSLYPMxNI9gw8FT20EGVmxczCtKX3uF
	A/23ghVI3V5IPwZm1gbvQzz4aYsaH2+uFhsTHHKF66xETjDWq1/5dkeKl82ansY/jO3wgc3Kmql
	265X6uuqjQtXGC0kWxx1tTFujsPnBiA1CUAt8idzBLQ4PTLOnp5zznIHTDHc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c81:b0:662:c9d0:c8fd with SMTP id
 006d021491bc7-66d0c854dfemr5447774eaf.57.1770662133305; Mon, 09 Feb 2026
 10:35:33 -0800 (PST)
Date: Mon, 09 Feb 2026 10:35:33 -0800
In-Reply-To: <00000000000086d83c0615ba6f9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a28f5.a00a0220.34fa92.004a.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __schedule (5)
From: syzbot <syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, hpa@zytor.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257979-lists,netdev=lfdr.de,28bdcfc1dab2ffa279a5];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: E0BC61139B4
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    05f7e89ab973 Linux 6.19
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17daf65a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80
dashboard link: https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1029533a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea9f39c5175d/disk-05f7e89a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/734edeebfa32/vmlinux-05f7e89a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2cb36d849f0/bzImage-05f7e89a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in membarrier_switch_mm kernel/sched/sched.h:3666 [inline]
BUG: KASAN: slab-use-after-free in context_switch kernel/sched/core.c:5230 [inline]
BUG: KASAN: slab-use-after-free in __schedule+0xc56/0x5fa0 kernel/sched/core.c:6867
Read of size 4 at addr ffff88801db4e2c0 by task kworker/u8:1/13

CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 membarrier_switch_mm kernel/sched/sched.h:3666 [inline]
 context_switch kernel/sched/core.c:5230 [inline]
 __schedule+0xc56/0x5fa0 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0xdd/0x390 kernel/sched/core.c:6964
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7021
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0xc9a/0x1b90 kernel/locking/mutex.c:776
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 addrconf_dad_work+0x11f/0x1360 net/ipv6/addrconf.c:4194
 process_one_work+0x9c2/0x1840 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3421
 kthread+0x3b3/0x730 kernel/kthread.c:463
 ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 5942:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x2ad/0x780 mm/slub.c:5270
 dup_mm kernel/fork.c:1519 [inline]
 copy_mm kernel/fork.c:1581 [inline]
 copy_process+0x73df/0x7890 kernel/fork.c:2221
 kernel_clone+0xfc/0x930 kernel/fork.c:2651
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2792
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6090:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kmem_cache_free+0x143/0x720 mm/slub.c:6789
 mmdrop include/linux/sched/mm.h:55 [inline]
 mmdrop_sched include/linux/sched/mm.h:83 [inline]
 mmdrop_lazy_tlb_sched include/linux/sched/mm.h:110 [inline]
 finish_task_switch.isra.0+0x76e/0xb70 kernel/sched/core.c:5143
 context_switch kernel/sched/core.c:5263 [inline]
 __schedule+0xfee/0x5fa0 kernel/sched/core.c:6867
 preempt_schedule_common+0x42/0xc0 kernel/sched/core.c:7051
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x61/0x80 kernel/locking/spinlock.c:194
 anon_pipe_write+0xdaa/0x1d40 fs/pipe.c:596
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801db4e200
 which belongs to the cache mm_struct of size 2968
The buggy address is located 192 bytes inside of
 freed 2968-byte region [ffff88801db4e200, ffff88801db4ed98)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1db48
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888031ddb901
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ff30b40 dead000000000100 dead000000000122
raw: 0000000000000000 00000000800a000a 00000000f5000000 ffff888031ddb901
head: 00fff00000000040 ffff88813ff30b40 dead000000000100 dead000000000122
head: 0000000000000000 00000000800a000a 00000000f5000000 ffff888031ddb901
head: 00fff00000000003 ffffea000076d201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5202, tgid 5202 (udevd), ts 49764882375, free_ts 49738398245
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1e1/0x250 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0xe3d/0x2e10 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x26c/0x2410 mm/page_alloc.c:5240
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab mm/slub.c:3248 [inline]
 new_slab+0x2c4/0x440 mm/slub.c:3302
 ___slab_alloc+0xda3/0x1ca0 mm/slub.c:4656
 __slab_alloc.isra.0+0x63/0x110 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_noprof+0x4ec/0x780 mm/slub.c:5270
 dup_mm kernel/fork.c:1519 [inline]
 copy_mm kernel/fork.c:1581 [inline]
 copy_process+0x73df/0x7890 kernel/fork.c:2221
 kernel_clone+0xfc/0x930 kernel/fork.c:2651
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2792
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5349 tgid 5349 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x822/0x1130 mm/page_alloc.c:2973
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x2ad/0x780 mm/slub.c:5270
 vm_area_dup+0x27/0x8e0 mm/vma_init.c:123
 __split_vma+0x18c/0xe30 mm/vma.c:513
 vms_gather_munmap_vmas+0x3aa/0x1320 mm/vma.c:1423
 __mmap_setup mm/vma.c:2405 [inline]
 __mmap_region+0x46e/0x2820 mm/vma.c:2734
 mmap_region+0x180/0x3e0 mm/vma.c:2830
 do_mmap+0xc63/0x12f0 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:581
 ksys_mmap_pgoff+0x328/0x5b0 mm/mmap.c:604
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801db4e180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801db4e200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801db4e280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88801db4e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801db4e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

