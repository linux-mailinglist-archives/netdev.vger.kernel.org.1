Return-Path: <netdev+bounces-255382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEkOO5/QfWlQTwIAu9opvQ
	(envelope-from <netdev+bounces-255382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 10:51:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960EC1712
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49218300F9DD
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115D30748B;
	Sat, 31 Jan 2026 09:49:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D92C21FE
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769852970; cv=none; b=Ts1WTFcCVLx8BPIS/b2Iynrbq3bLiOqB11foneDUEGQ8Km2WsoGXcnSdLrPXdvwQcNjyYqNsiuh8gRMJOmZF96ruxjSaaMlCU+tpziVH8TvcmNKho4yr2+E4SOTaLxqKecEzZUCs6zkPO32DkUWkfBKSZBKG57sYiEa1VaMAOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769852970; c=relaxed/simple;
	bh=/ks4b6pp0susYSFfnNG3DLwHfn9h11l6YCNj0wrWAmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fxUUyfc4CHMBGzTNyhrNUP0FM0MK92ZOwrecAyXSIIrYzqWIbZeL7T4hFUcXAZdGkYiHK0bLX0HNaEUt3CeU1aizHeMTWziPNlyiJaT7ZQKdp1PgzytrpXf8lQEnd7J1RRk9Tji8qd6WbxqI197VVETZzKcfUlaKlUF+zuflLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-4096f92cf50so6554750fac.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769852967; x=1770457767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sk0dwA9mXpxiPETTlMSUdfR5P+at6XuhGJ8JtKY8jYA=;
        b=E5B8xom2oqmA655K6+6lekZM9S+tIEPaWTTq1CocSxqJJJUMy6bkve/mOb2obCMY1D
         4u7FDkKgJa05zE1YHg8YQeDjrYUsb0s7c4okEaLmIXiGZb4O+N0HWocaDxQggW20f5Yg
         9nbth8J0EVuqbU0A8WQT5qQP0qUaflw377OWQwOoAG5OsAW0WOffF5NRsGNCl4inJE1d
         lv/Za7nfIjRa1f5S8ES3HVnwNx8e35H3a5N8Lme7TBmGYe6WUt/QKfKZ9RqoYRRqlYAh
         laiqWz/vmueg13dMXlrZ7cLVfq/YQhN4RhLq1POPxDwLYl9g/I8xGIjws+2xtdDtg92r
         DAZg==
X-Forwarded-Encrypted: i=1; AJvYcCWxkjzkyPDKuUgkI09L2Y433jKZMf+YcOcRN+rkbT1sRTsGcy3GgKIuJkpB6wobrVllzxvhP8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwH/Hw+J50Z5leK6zyFJbjwnd+CFVB9Je/oU/GhyisMBvI/ff
	tqRADFL5cmNHmdr8NRH5OiCXOZz6+/blyd6jGtpamDyee+HwaCAic7ldeUGG/lkLpThVP1fKnbD
	rYBnd6dhzIvn97g716J8340f8/M+nJ62HHzEZdugyXdBb/2KlYHA2ZD04TBI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60f:b0:662:fe6d:619f with SMTP id
 006d021491bc7-6630ef5f752mr2430640eaf.0.1769852967511; Sat, 31 Jan 2026
 01:49:27 -0800 (PST)
Date: Sat, 31 Jan 2026 01:49:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697dd027.050a0220.1d0a41.0005.GAE@google.com>
Subject: [syzbot] [hams?] KASAN: slab-use-after-free Write in nr_neigh_put
From: syzbot <syzbot+08ca620c862d89afe6d6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-255382-lists,netdev=lfdr.de,08ca620c862d89afe6d6];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 4960EC1712
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    6ad42b244136 Merge branch 'bng_en-enhancements-for-rx-and-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1421a72a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=08ca620c862d89afe6d6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b03def814aa/disk-6ad42b24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e677d64cb110/vmlinux-6ad42b24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e89660ed5369/bzImage-6ad42b24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08ca620c862d89afe6d6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:389 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:432 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:450 [inline]
BUG: KASAN: slab-use-after-free in nr_neigh_put+0x21/0x170 include/net/netrom.h:139
Write of size 4 at addr ffff888026ddaf3c by task syz.1.8003/5600

CPU: 0 UID: 0 PID: 5600 Comm: syz.1.8003 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 nr_neigh_put+0x21/0x170 include/net/netrom.h:139
 nr_del_neigh+0x25a/0x2d0 net/netrom/nr_route.c:440
 nr_rt_ioctl+0xd62/0xf90 net/netrom/nr_route.c:682
 sock_do_ioctl+0x101/0x320 net/socket.c:1254
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bd0f9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bd1d7a028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3bd1216090 RCX: 00007f3bd0f9aeb9
RDX: 0000200000000680 RSI: 000000000000890c RDI: 0000000000000006
RBP: 00007f3bd1008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3bd1216128 R14: 00007f3bd1216090 R15: 00007fffa738a9e8
 </TASK>

Allocated by task 5599:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
 kmalloc_noprof include/linux/slab.h:957 [inline]
 nr_add_neigh+0x104/0x520 net/netrom/nr_route.c:392
 nr_rt_ioctl+0xdf9/0xf90 net/netrom/nr_route.c:660
 sock_do_ioctl+0x101/0x320 net/socket.c:1254
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5600:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1be/0x650 mm/slub.c:6882
 __nr_remove_neigh net/netrom/nr_route.c:299 [inline]
 nr_remove_neigh net/netrom/nr_route.c:308 [inline]
 nr_del_neigh+0x246/0x2d0 net/netrom/nr_route.c:439
 nr_rt_ioctl+0xd62/0xf90 net/netrom/nr_route.c:682
 sock_do_ioctl+0x101/0x320 net/socket.c:1254
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888026ddaf00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 60 bytes inside of
 freed 64-byte region [ffff888026ddaf00, ffff888026ddaf40)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26dda
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe268c0 ffffea0000a56ec0 dead000000000003
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5835, tgid 5835 (syz-executor), ts 88717173954, free_ts 88621883212
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
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0x46c/0x7e0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 tnode_alloc net/ipv4/fib_trie.c:327 [inline]
 tnode_new+0xc3/0x3b0 net/ipv4/fib_trie.c:380
 fib_insert_node net/ipv4/fib_trie.c:1125 [inline]
 fib_insert_alias+0x9f7/0x1100 net/ipv4/fib_trie.c:1159
 fib_table_insert+0x695/0x1b50 net/ipv4/fib_trie.c:1354
 fib_magic+0x434/0x510 net/ipv4/fib_frontend.c:1134
 fib_add_ifaddr+0x144/0x5f0 net/ipv4/fib_frontend.c:1156
 fib_inetaddr_event+0x12e/0x190 net/ipv4/fib_frontend.c:1470
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
page last free pid 5832 tgid 5832 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbf8/0xd70 mm/page_alloc.c:2973
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Memory state around the buggy address:
 ffff888026ddae00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff888026ddae80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff888026ddaf00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff888026ddaf80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888026ddb000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

