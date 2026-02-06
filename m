Return-Path: <netdev+bounces-257621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEzbAHEehmm9JwQAu9opvQ
	(envelope-from <netdev+bounces-257621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:01:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B110F100AC1
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0826D3004D34
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5B34B661;
	Fri,  6 Feb 2026 17:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062C33D6F7
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397293; cv=none; b=W25FcpNyr6GeaepZgdipV0GtGp1pSAVJDJ75dt4SFupp7/e/Q0PnchbIrXhNIgB7OzEddjQFjQSAGoHzoKXLnknux0RKeNibm0fUn8hhrllXfiFtLMXa7yPCsZqm2wtJmltAOWRtSVOYxDLWGHXeW83CmBmYeVrqki90ouIvrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397293; c=relaxed/simple;
	bh=pKVcU2JZ37tw67VJn5v4W+1Gcb/jY1TMSpQtWOKYkE0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gk8MYuqO/mW//fJDwk7mMEv+eZF9cXrPsV46C1evRnnQZ4ZsXQfYk589V4SoB/qO3Q2Cr8dWjedDd7URhvvWBoLzoQNojGqGwfHD6CGNQ42b7Lc89rLQAmrv8uTdCliRXB+z8ilb8SkXwzKvJpq8Ki1j3XIEBwXGSO19mn/18Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d19e3a3770so7673830a34.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397292; x=1771002092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsNq0Ae0P9x7QzAJocednScquolrBFQ3GLaKkM2R1+o=;
        b=Aa1RGdu3l1KNrSt/bIq+CybFJJrTMcEk4YPUhegXp+3yBYdozl9b9gKUcJXvu+6TjK
         2aQ1nk3k7MV2NUw90JNcir8PRFUkwQVfgkTFHpRV/WXLrK+KrXtrbaiwNSYvlr5Pav6i
         BGeiMQ3Md8yC8mZCsfw4oOzIYk36ncacSk50fmYXmkZKemdGJBOg92LbTaovTFwIOTUW
         qu9P+FV4iS/PsGxskpouCUS1SwS3nswRRAA7CyNj1kHPcQ1pnRtfcfr8KIiTRPYol3QV
         RHKfJAkI39+XA4a5hLsZ97A3FwwQPGFU1BqZXYT2maML3G3BcOzt9hlxjcNRS0bfzjcV
         Dqjg==
X-Forwarded-Encrypted: i=1; AJvYcCUWh7Py2vwhZmzUgG6lk5deJk7FnGwz2GEQD0Fn6HsljSiGqDwJF+UccjePhJ2CNmHCiF22XM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMYvTpYvMX4R6MFhJ4AdjfZlEj+cTX8wYeLoS/2YZrpCs9FZN
	08u2NeE5VhZNwpkV7ZAIC15NF0Yo51z0Qh3RvBmpSYNEg/Oi9z21774FlVi2Aq/+wT6U2FHQAxs
	c63CA7uK//WvlWrP2BgwRxtjgaGDx5aXRQSGT+Xtwg3DB0YyI47+iE+TnWqg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3096:b0:65f:6cf5:f963 with SMTP id
 006d021491bc7-66d099c58b8mr1612059eaf.6.1770397291723; Fri, 06 Feb 2026
 09:01:31 -0800 (PST)
Date: Fri, 06 Feb 2026 09:01:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69861e6b.a00a0220.37c87e.0039.GAE@google.com>
Subject: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_t0timer_expiry
From: syzbot <syzbot+44cccec2c6a4501f6a45@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257621-lists,netdev=lfdr.de,44cccec2c6a4501f6a45];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B110F100AC1
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    24cf78c73831 net/mlx5e: SHAMPO, Switch to header memcpy
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177127fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=44cccec2c6a4501f6a45
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9514a76ff576/disk-24cf78c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f26244320f5/vmlinux-24cf78c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0823b49ca48/bzImage-24cf78c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44cccec2c6a4501f6a45@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rose_send_frame net/rose/rose_link.c:105 [inline]
BUG: KASAN: slab-use-after-free in rose_transmit_restart_request net/rose/rose_link.c:198 [inline]
BUG: KASAN: slab-use-after-free in rose_t0timer_expiry+0x1ea/0x560 net/rose/rose_link.c:83
Read of size 8 at addr ffff88803369f818 by task syz.3.19792/27398

CPU: 0 UID: 0 PID: 27398 Comm: syz.3.19792 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 rose_send_frame net/rose/rose_link.c:105 [inline]
 rose_transmit_restart_request net/rose/rose_link.c:198 [inline]
 rose_t0timer_expiry+0x1ea/0x560 net/rose/rose_link.c:83
 call_timer_fn+0x192/0x5a0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:unwind_next_frame+0x183/0x23c0 arch/x86/kernel/unwind_orc.c:-1
Code: e5 18 00 00 49 8d 5e 35 48 89 d8 48 c1 e8 03 48 89 44 24 28 0f b6 04 28 84 c0 0f 85 45 1b 00 00 4c 89 6c 24 48 4c 89 64 24 20 <4c> 89 7c 24 50 48 89 5c 24 18 0f b6 1b 48 8b 44 24 30 80 3c 28 00
RSP: 0018:ffffc9000b9b6f18 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc9000b9b701d RCX: 0000000080000001
RDX: 000000002bf25168 RSI: ffffffff8c0739e0 RDI: ffffffff8c0739a0
RBP: dffffc0000000000 R08: ffffffff81757195 R09: ffffffff8e55a360
R10: ffffc9000b9b7038 R11: ffffffff81af9170 R12: 1ffff92001736dfd
R13: ffffc9000b9b7038 R14: ffffc9000b9b6fe8 R15: ffffffff81757195
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_track_caller_noprof+0x558/0x7f0 mm/slub.c:5768
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 __kernfs_new_node+0xa9/0x8e0 fs/kernfs/dir.c:633
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 __kernfs_create_file+0x4b/0x2e0 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:313
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x673/0x1180 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:229 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:255
 setup_port drivers/infiniband/core/sysfs.c:1247 [inline]
 ib_setup_port_attrs+0xe1b/0x2140 drivers/infiniband/core/sysfs.c:1433
 add_one_compat_dev+0x448/0x650 drivers/infiniband/core/device.c:1005
 rdma_dev_init_net+0x243/0x2f0 drivers/infiniband/core/device.c:1221
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0x118/0x340 net/core/net_namespace.c:446
 copy_net_ns+0x50e/0x730 net/core/net_namespace.c:581
 create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0x11a/0x160 kernel/nsproxy.c:226
 ksys_unshare+0x4f4/0x900 kernel/fork.c:3171
 __do_sys_unshare kernel/fork.c:3242 [inline]
 __se_sys_unshare kernel/fork.c:3240 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3240
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdee19aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdec3ee028 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fbdee415fa0 RCX: 00007fbdee19aeb9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000006a040000
RBP: 00007fbdee208c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbdee416038 R14: 00007fbdee415fa0 R15: 00007fff2eb07768
 </TASK>

Allocated by task 21222:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
 kmalloc_noprof include/linux/slab.h:957 [inline]
 rose_add_node+0x23c/0xf00 net/rose/rose_route.c:85
 rose_rt_ioctl+0xd35/0x12a0 net/rose/rose_route.c:748
 rose_ioctl+0x3fb/0x8f0 net/rose/af_rose.c:1382
 sock_do_ioctl+0x101/0x320 net/socket.c:1254
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 27424:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1be/0x650 mm/slub.c:6882
 rose_neigh_put include/net/rose.h:166 [inline]
 rose_timer_expiry+0x4cb/0x600 net/rose/rose_timer.c:183
 call_timer_fn+0x192/0x5a0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff88803369f800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 24 bytes inside of
 freed 512-byte region [ffff88803369f800, ffff88803369fa00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3369c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe26c80 ffffea000161c300 dead000000000002
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe26c80 ffffea000161c300 dead000000000002
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000cda701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 16116, tgid 16112 (syz.4.17690), ts 1033791837005, free_ts 1026914999440
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __kmalloc_cache_noprof+0x40d/0x6e0 mm/slub.c:5775
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 cfcnfg_create+0x68/0x380 net/caif/cfcnfg.c:80
 caif_init_net+0x81/0xc0 net/caif/caif_dev.c:514
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0x118/0x340 net/core/net_namespace.c:446
 copy_net_ns+0x50e/0x730 net/core/net_namespace.c:581
 create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0x11a/0x160 kernel/nsproxy.c:226
 ksys_unshare+0x4f4/0x900 kernel/fork.c:3171
page last free pid 16021 tgid 16021 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbf8/0xd70 mm/page_alloc.c:2973
 __slab_free+0x2ce/0x320 mm/slub.c:6008
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x370/0x6e0 mm/slub.c:5270
 vm_area_alloc+0x24/0x140 mm/vma_init.c:32
 __mmap_new_vma mm/vma.c:2510 [inline]
 __mmap_region mm/vma.c:2752 [inline]
 mmap_region+0xf85/0x1f40 mm/vma.c:2830
 do_mmap+0xc39/0x10c0 mm/mmap.c:558
 vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
 elf_map fs/binfmt_elf.c:399 [inline]
 elf_load+0x248/0x6a0 fs/binfmt_elf.c:422
 load_elf_interp+0x4ce/0xb60 fs/binfmt_elf.c:689
 load_elf_binary+0x1b2f/0x2980 fs/binfmt_elf.c:1254
 search_binary_handler fs/exec.c:1669 [inline]
 exec_binprm fs/exec.c:1701 [inline]
 bprm_execve+0x93d/0x1410 fs/exec.c:1753
 do_execveat_common+0x50f/0x690 fs/exec.c:1859
 do_execve fs/exec.c:1933 [inline]
 __do_sys_execve fs/exec.c:2009 [inline]
 __se_sys_execve fs/exec.c:2004 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2004

Memory state around the buggy address:
 ffff88803369f700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803369f780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803369f800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88803369f880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803369f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	e5 18                	in     $0x18,%eax
   2:	00 00                	add    %al,(%rax)
   4:	49 8d 5e 35          	lea    0x35(%r14),%rbx
   8:	48 89 d8             	mov    %rbx,%rax
   b:	48 c1 e8 03          	shr    $0x3,%rax
   f:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  14:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
  18:	84 c0                	test   %al,%al
  1a:	0f 85 45 1b 00 00    	jne    0x1b65
  20:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
  25:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
* 2a:	4c 89 7c 24 50       	mov    %r15,0x50(%rsp) <-- trapping instruction
  2f:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
  34:	0f b6 1b             	movzbl (%rbx),%ebx
  37:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
  3c:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)


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

