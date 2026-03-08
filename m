Return-Path: <netdev+bounces-265305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEhSGtF8rWnx3QEAu9opvQ
	(envelope-from <netdev+bounces-265305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:42:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6A230716
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58BB6300616B
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC73815EF;
	Sun,  8 Mar 2026 13:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5736C595
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977357; cv=none; b=OKS1k7Rer31kRpzkI+T6U4ZwOib+Ykbh7XzKY4LtY6Xr3vYoRPOCM8W6/szE7Af6z/dTouKiAp04y8dIJt4Tk16At3nOeJjl31O3AtiBL66fEcErpZGD6+RMIGJ07YClYQ6CWJwb2OaYAXCB+u3uCEhXwmZeP8Qy96ocAiR+j6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977357; c=relaxed/simple;
	bh=Y767hthQElkwiUOpfbzenSB8ljKeAc8AV5Wux2DKT3Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LXD+0Qqd/NTkbKQBg1qFLvZiE5ZXyLRbV/984rn93tEF6oXw5cl/BtkjtRaHvekHvuYaJDPsJzS8BlBh6nfOJFk6RC4wJKbtiRcBix3n4MLWm02RlLtiTIqDd4gt7sPQ218je4SRPqGfUJuCyUaaJcZoJ/Xf+vTe1BIvi8hr3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c51b2d6cso130540517eaf.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977355; x=1773582155;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuT/w6uChiDn7kVpuNZFwv0Wt6om3/3NbN3DaCStb0w=;
        b=usAE3HXYWC6AE+wYqSdy6VxotXxYx5PpqhEoAUCsUk0ITeFsOHOamMcainPR6cYpU3
         ZLqSgOY0/kPi5zRTM6QaDna5PFglNie5LtD1n07n29b/Ffeqp/neqxYQY/0TsfoeBI1E
         Yk+oVlVXseuAwapFvSI0CNfUOYU1CKw5fe5XLjWFG23cohuaBH0cRd0KAZWFOKL3NmG/
         BhjKVUNcF/eDSOF6Cg/045eCtVAQS7lx+PAMGdv8ivbiftHSe8Erys8psFhxdhogSY6J
         AdX0aDPTP09JxV2dyx756yu3ToX/QiFgNsjLXxC2qKvVmPyPMHbXl1dWOneAeCEDKtT+
         P3kg==
X-Forwarded-Encrypted: i=1; AJvYcCX2slBOvHedonLhegRow7LSzPgzF/2j2siIM9QQazqYnZMV2qNv/JFG4bhTgdORnzrT1u+ncKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnfqtj+QXApg9Pn+bnf9Slu70BQhTn0+rRTGnmoG7xZqJT6MX
	nYR/rpjCX7yxrOgQjHwSrvxHY8e59iCQJgrup6KE8+tPA+vrOYHcG/u8vCHg85TW8LPVRiMbV+N
	/2n072fSKhy9Waxb1Y4CRopPZ6NCfT4W7OpxPXsb5Jeh+7ZWX3t80+KoXzno=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:488a:b0:67b:a8ec:fed0 with SMTP id
 006d021491bc7-67ba8ed0326mr1872509eaf.19.1772977355361; Sun, 08 Mar 2026
 06:42:35 -0700 (PDT)
Date: Sun, 08 Mar 2026 06:42:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ad7ccb.a00a0220.b130.0003.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in sock_def_readable (2)
From: syzbot <syzbot+f50072212ab792c86925@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 07B6A230716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3b4642149033fe7c];
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
	TAGGED_FROM(0.00)[bounces-265305-lists,netdev=lfdr.de,f50072212ab792c86925];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    6de23f81a5e0 Linux 7.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148d655a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4642149033fe7c
dashboard link: https://syzkaller.appspot.com/bug?extid=f50072212ab792c86925
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1085e55a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e6d9e6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6de23f81.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5258f38d5768/vmlinux-6de23f81.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7730b97aa5a/bzImage-6de23f81.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:381 [inline]
BUG: KASAN: slab-use-after-free in waitqueue_active include/linux/wait.h:127 [inline]
BUG: KASAN: slab-use-after-free in wq_has_sleeper include/linux/wait.h:161 [inline]
BUG: KASAN: slab-use-after-free in skwq_has_sleeper include/net/sock.h:2404 [inline]
BUG: KASAN: slab-use-after-free in sock_def_readable+0x1cb/0x580 net/core/sock.c:3610
Read of size 8 at addr ffff888047cb0c00 by task kworker/0:4/5308

CPU: 0 UID: 0 PID: 5308 Comm: kworker/0:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 list_empty include/linux/list.h:381 [inline]
 waitqueue_active include/linux/wait.h:127 [inline]
 wq_has_sleeper include/linux/wait.h:161 [inline]
 skwq_has_sleeper include/net/sock.h:2404 [inline]
 sock_def_readable+0x1cb/0x580 net/core/sock.c:3610
 send_to_lecd+0x322/0x600 net/atm/lec.c:538
 lec_arp_resolve net/atm/lec.c:1787 [inline]
 lec_start_xmit+0xec0/0x2660 net/atm/lec.c:285
 __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
 netdev_start_xmit include/linux/netdevice.h:5284 [inline]
 xmit_one net/core/dev.c:3871 [inline]
 dev_hard_start_xmit+0x2d8/0x870 net/core/dev.c:3887
 sch_direct_xmit+0x251/0x4c0 net/sched/sch_generic.c:347
 __dev_xmit_skb net/core/dev.c:4186 [inline]
 __dev_queue_xmit+0x1538/0x38a0 net/core/dev.c:4802
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x25c/0x610 net/ipv6/ip6_output.c:219
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 NF_HOOK+0xa2/0x3a0 include/linux/netfilter.h:318
 mld_sendpack+0x8b4/0xe40 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x835/0xe70 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6850:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 kmem_cache_alloc_lru_noprof+0x2b8/0x640 mm/slub.c:4849
 sock_alloc_inode+0x28/0xc0 net/socket.c:322
 alloc_inode+0x6a/0x1b0 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc net/socket.c:637 [inline]
 __sock_create+0x12d/0x9d0 net/socket.c:1569
 sock_create net/socket.c:1663 [inline]
 __sys_socket_create net/socket.c:1700 [inline]
 __sys_socket+0xd6/0x1b0 net/socket.c:1747
 __do_sys_socket net/socket.c:1761 [inline]
 __se_sys_socket net/socket.c:1759 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1759
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6859:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2687 [inline]
 slab_free mm/slub.c:6124 [inline]
 kmem_cache_free+0x187/0x630 mm/slub.c:6254
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 destroy_inode fs/inode.c:402 [inline]
 evict+0x95b/0xb10 fs/inode.c:870
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 __fput+0x691/0xa70 fs/file_table.c:477
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888047cb0b80
 which belongs to the cache sock_inode_cache of size 1344
The buggy address is located 128 bytes inside of
 freed 1344-byte region [ffff888047cb0b80, ffff888047cb10c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47cb0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888038584a01
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888030419c80 dead000000000100 dead000000000122
raw: 0000000000000000 00000008000b000b 00000000f5000000 ffff888038584a01
head: 04fff00000000040 ffff888030419c80 dead000000000100 dead000000000122
head: 0000000000000000 00000008000b000b 00000000f5000000 ffff888038584a01
head: 04fff00000000002 ffffea00011f2c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5295, tgid 5295 (syz-execprog), ts 87351971632, free_ts 76295178870
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3255 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3444
 new_slab mm/slub.c:3502 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7134
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4578
 alloc_from_pcs mm/slub.c:4681 [inline]
 slab_alloc_node mm/slub.c:4815 [inline]
 kmem_cache_alloc_lru_noprof+0x37c/0x640 mm/slub.c:4849
 sock_alloc_inode+0x28/0xc0 net/socket.c:322
 alloc_inode+0x6a/0x1b0 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc net/socket.c:637 [inline]
 __sock_create+0x12d/0x9d0 net/socket.c:1569
 mptcp_subflow_create_socket+0xfb/0x800 net/mptcp/subflow.c:1788
 __mptcp_socket_create net/mptcp/protocol.c:110 [inline]
 __mptcp_nmpc_sk+0x155/0x790 net/mptcp/protocol.c:142
 mptcp_setsockopt_v6 net/mptcp/sockopt.c:399 [inline]
 mptcp_setsockopt+0xe4a/0x36a0 net/mptcp/sockopt.c:922
 do_sock_setsockopt+0x270/0x400 net/socket.c:2322
 __sys_setsockopt net/socket.c:2347 [inline]
 __do_sys_setsockopt net/socket.c:2353 [inline]
 __se_sys_setsockopt net/socket.c:2350 [inline]
 __x64_sys_setsockopt+0x18a/0x210 net/socket.c:2350
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
page last free pid 5281 tgid 5281 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __slab_free+0x263/0x2b0 mm/slub.c:5532
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 __kmalloc_cache_noprof+0x2ba/0x660 mm/slub.c:5334
 kmalloc_noprof include/linux/slab.h:962 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x195/0x1fb0 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x353/0x1570 security/tomoyo/common.c:2232
 tomoyo_audit_env_log security/tomoyo/environ.c:37 [inline]
 tomoyo_env_perm+0x151/0x1f0 security/tomoyo/environ.c:64
 tomoyo_environ security/tomoyo/domain.c:673 [inline]
 tomoyo_find_next_domain+0x15cb/0x1aa0 security/tomoyo/domain.c:889
 tomoyo_bprm_check_security+0x11b/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x85/0x240 security/security.c:794
 search_binary_handler fs/exec.c:1654 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x896/0x1460 fs/exec.c:1748
 do_execveat_common+0x50d/0x690 fs/exec.c:1846
 __do_sys_execve fs/exec.c:1930 [inline]
 __se_sys_execve fs/exec.c:1924 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1924
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff888047cb0b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047cb0b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047cb0c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888047cb0c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047cb0d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

