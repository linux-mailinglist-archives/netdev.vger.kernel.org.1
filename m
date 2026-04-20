Return-Path: <netdev+bounces-279927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKzVLfie5mmyywEAu9opvQ
	(envelope-from <netdev+bounces-279927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB74345B7
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66F8A30069AE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512C3CF058;
	Mon, 20 Apr 2026 21:47:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DD3C3425
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721644; cv=none; b=d46BkojqV8JEOC8QtQWJdLmHp6yVW4WuVukDI55/7LRi6DsnWf4YZcI4fzqEvKtbStJWYQI0FKQGjC9WV7iFR9VD96I/61/OEBpIkXZoANaxYqhNcbHMAeSMid1Hb0RFCDMG8QUMt5oIH4aOsyCttlhvqB9gFBV/fr4cB3snFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721644; c=relaxed/simple;
	bh=30oTKc/cluTM7EZtRjSa/q8KkzVYmAprKF2NnyBd718=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l5Xl2gf1+Vr1GWajex2ZdPw/PXbU3iOX1aPu841hoC3HxkO1y/UHyLag8Ez+FQlWWHsesQ8BftSGPVWkbv9zr3cL11tlPQ518LrHwYlnZC8bWNls30nU+JWhcyKm8vCTTNJm+uZExMU3oXNN3MYGVJ62TiHNW3OtibWTj8HFhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7dcd603855aso1238682a34.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721640; x=1777326440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpSebxuwISWBXtttRGllv6OThiDp0ScPrSL9/tEWrbc=;
        b=D8UvsIHZOW+IA+oTFvAUgNDt8uYp7De/aSOXSbpcV9qvDm+ht+pSh6ASWei+RxW3c+
         RLIgjGKdYmIkO+5emC4C+mcaOSruBDrMDAnQOVBg6IFnkuOUX/awRj3JsEeoa9aJ1uxW
         PjeCM3VdxI9zlYaA8pv3K+CaNpTWk9W6hMJHqlaKGPNwScFVc7GnNxNYrG/IbYYDJ7S0
         GI7o0hGIqvDGWVrWO5ZoHpn6cHfx08u8MdgEKmCJyZXPrsZpoh7NQabswF9oEPFB4QeL
         vKV2ZH0CcDNAzLl6+ohPYBEJi721Kzwr8vrU1xV8GJOPDc6mAWoWeznlB+pHaf9l8LKf
         0gKw==
X-Forwarded-Encrypted: i=1; AFNElJ/XX5lAA1LYAU9sdt7EDx1vvuUCMt0StgSjxoJh8Hnj0djhYW+0KOrqdoEjNU8BojvZ/+cOhOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMyWz3bg4x6WIM9w4rBd8hN5CkFmbLT3F9EtDkTYkNBsfpxdH
	EtUXTjR2+6OJLD6fKFhIv9mT2q/FFBWijRLNCvz52zKNM68U4VMKLo28RJ4mz6HRBIhOOmvW9B5
	FSoTugcc4UZKArTPzszBrTOGIhmW+U/VZOUpeOVU5t5UGI2lmTttMF+DBs4M=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:840e:b0:694:9224:d78e with SMTP id
 006d021491bc7-6949224decfmr1023868eaf.9.1776721639860; Mon, 20 Apr 2026
 14:47:19 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:47:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e69ee7.050a0220.24bfd3.002b.GAE@google.com>
Subject: [syzbot] [net?] [usb?] KASAN: slab-use-after-free Read in rtl8150_start_xmit
From: syzbot <syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=547af2cd0df5277f];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279927-lists,netdev=lfdr.de,3f46c095ac0ca048cb71];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: BBAB74345B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c1f49dea2b8f Merge tag 'mm-hotfixes-stable-2026-04-19-00-1..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=158822d2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547af2cd0df5277f
dashboard link: https://syzkaller.appspot.com/bug?extid=3f46c095ac0ca048cb71
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0b2d34cef3a/disk-c1f49dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54e06fcfd92f/vmlinux-c1f49dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0aa8d05931c2/bzImage-c1f49dea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rtl8150_start_xmit+0x71f/0x760 drivers/net/usb/rtl8150.c:712
Read of size 4 at addr ffff88810eb7a930 by task kworker/0:4/5226

CPU: 0 UID: 0 PID: 5226 Comm: kworker/0:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 rtl8150_start_xmit+0x71f/0x760 drivers/net/usb/rtl8150.c:712
 __netdev_start_xmit include/linux/netdevice.h:5343 [inline]
 netdev_start_xmit include/linux/netdevice.h:5352 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x128/0x7a0 net/core/dev.c:3904
 sch_direct_xmit+0x194/0x890 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4209 [inline]
 __dev_queue_xmit+0x278a/0x4930 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3401 [inline]
 neigh_resolve_output net/core/neighbour.c:1619 [inline]
 neigh_resolve_output+0x51d/0x8f0 net/core/neighbour.c:1599
 neigh_output include/net/neighbour.h:556 [inline]
 ip6_finish_output2+0xa92/0x1f20 net/ipv6/ip6_output.c:136
 __ip6_finish_output+0x359/0xd10 net/ipv6/ip6_output.c:208
 ip6_finish_output net/ipv6/ip6_output.c:219 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x2a1/0xa50 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:470 [inline]
 NF_HOOK.constprop.0+0x115/0x5a0 include/linux/netfilter.h:318
 mld_sendpack+0x923/0xef0 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x75a/0xc10 net/ipv6/mcast.c:2693
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3466
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5226:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_node_noprof+0x26b/0x6b0 mm/slub.c:4950
 __alloc_skb+0x140/0x710 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack.isra.0+0x18e/0xa30 net/ipv6/mcast.c:1775
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1886
 add_grec+0x139a/0x1940 net/ipv6/mcast.c:2025
 mld_send_cr net/ipv6/mcast.c:2148 [inline]
 mld_ifc_work+0x3c5/0xc10 net/ipv6/mcast.c:2693
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3466
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 2860:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_mempool_poison_object+0x91/0x150 mm/kasan/common.c:539
 kasan_mempool_poison_object include/linux/kasan.h:363 [inline]
 napi_skb_cache_put+0x68/0x740 net/core/skbuff.c:1459
 net_tx_action+0x2b0/0xf90 net/core/dev.c:5807
 handle_softirqs+0x1dd/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x160/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff88810eb7a8c0
 which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 112 bytes inside of
 freed 232-byte region [ffff88810eb7a8c0, ffff88810eb7a9a8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10eb7a
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888102e8c8c0 dead000000000100 dead000000000122
raw: 0000000000000000 00000008000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2971, tgid 2971 (syz-executor), ts 110258130289, free_ts 109191008280
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0xf34/0x3a90 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x273/0x28a0 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6b0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 kmem_cache_alloc_noprof+0x520/0x6a0 mm/slub.c:4905
 skb_clone+0x190/0x400 net/core/skbuff.c:2107
 dev_queue_xmit_nit+0x255/0xa80 net/core/dev.c:2574
 xmit_one net/core/dev.c:3884 [inline]
 dev_hard_start_xmit+0x2fc/0x7a0 net/core/dev.c:3904
 sch_direct_xmit+0x194/0x890 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4209 [inline]
 __dev_queue_xmit+0x278a/0x4930 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3401 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0xea0/0x2350 net/ipv4/ip_output.c:237
 __ip_finish_output.part.0+0x1b4/0x350 net/ipv4/ip_output.c:315
 __ip_finish_output net/ipv4/ip_output.c:303 [inline]
 ip_finish_output net/ipv4/ip_output.c:325 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x392/0xc00 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:470 [inline]
 ip_local_out+0x193/0x1f0 net/ipv4/ip_output.c:131
page last free pid 5250 tgid 5248 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x692/0xf10 mm/page_alloc.c:2943
 tlb_batch_list_free mm/mmu_gather.c:161 [inline]
 tlb_finish_mmu+0x27d/0x810 mm/mmu_gather.c:552
 exit_mmap+0x454/0xa10 mm/mmap.c:1313
 __mmput kernel/fork.c:1178 [inline]
 mmput+0xe0/0x430 kernel/fork.c:1201
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x833/0x2a60 kernel/exit.c:963
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3037
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x7e/0x430 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x682/0x7f0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88810eb7a800: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88810eb7a880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88810eb7a900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88810eb7a980: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff88810eb7aa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

