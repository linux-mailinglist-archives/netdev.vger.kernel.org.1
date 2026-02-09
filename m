Return-Path: <netdev+bounces-257987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHJIJmJPimmUJQAAu9opvQ
	(envelope-from <netdev+bounces-257987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:19:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651C114B7C
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78EA63004DDC
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9030E0E9;
	Mon,  9 Feb 2026 21:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FA3016F5
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671966; cv=none; b=VmRVg5+JIzb26Ek4HBtDK6Cd/Ib+5ci8k0kgWfXUrTaYMWW/7/QWgF2WFzyG2TgjFb9rNv1QBqtmzQse80b4f2eTSROIX+CoOe/DSdPTA+zdAbCsZ/trKYNyjZqKfciDreTAUGgAz8TkbDr8Vrhb3GtBAwJiY3t1P0qw1ayJFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671966; c=relaxed/simple;
	bh=Nbkl/vz2LN6nu8UTUXdvTKsfgVhz2lAs5CmuOUKseb8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gVbTo4uWgBxhYWkq6xalLkxerlVPmZzmaig5X8f6EtHDtnnwTvbcyTBWRE8uuBeJXCSakFA2dahwsJsHDunPh5a3KuHxKKOOdNLMFOpJF4SaAxswjYAzSpkKErCePN+J2BpxW/nGi7l1PoLTRi4GpLoY+HzZ840WiPoZZUclbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6630d58662aso1174050eaf.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 13:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770671964; x=1771276764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLZUqbwpe/GJ2pLfrY4f0YT0egrtI0pvL/m0lE4yhJA=;
        b=g1FyfJHGspE+jlm9auKsoDKNSYsI3KkSA5sl2FhsX7zIA5K15yEmx+K45ttzhoVVXU
         r6kjq6ZG0FlbL+b+QFxbYPeC0J2/detrfLFiiPA1ZkxVt+rJCCQqNuV8TOKiclZvoBRD
         a4M8lwz+nQbfK4lI0OIn3dAvC8pZT9AFU+aHPkZWFJZEJDR84rdc/DZzaZDp5A/l87gL
         pRycXCXqzeAY2YUKmx16z94SijeweiOTpDI11Orrm+EmPmiinXyziEIQl2RQWzQQjM6K
         Txnu8yENDfeK+ijOEpy65NsumC8n5ulKDBH/GbGzFefnUMrgQCoUpGECvdfENGevQTGW
         /RCA==
X-Forwarded-Encrypted: i=1; AJvYcCVnKITNir/vTDMB7j3vLjfKaRIPfHudrfIVId2l7jVB8/NgcsrdjeqdfT1MncQUpruPUB8MLx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VocZXyawppNwjrR/xxmRoqz0rlTPM1cKDY5qHUpOE9ErFJdf
	XfWrCQ40s/g9Fzqh7v8O39u36JAGyRDZ3VVNoXkUHQbqZSSUBA8C35exMrgRGfNzDfcrecikTL3
	EpPXO6HBYO3g2DJdi1dDXhuNMHKcvSw0bcJF9zcgA120kE/K48qtZTnKQiOI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a2:b0:662:fabc:b108 with SMTP id
 006d021491bc7-66d099c57f2mr6191118eaf.5.1770671964173; Mon, 09 Feb 2026
 13:19:24 -0800 (PST)
Date: Mon, 09 Feb 2026 13:19:24 -0800
In-Reply-To: <00000000000086d83c0615ba6f9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a4f5c.050a0220.3b3015.0081.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __schedule (5)
From: syzbot <syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, hpa@zytor.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257987-lists,netdev=lfdr.de,28bdcfc1dab2ffa279a5];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3651C114B7C
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    05f7e89ab973 Linux 6.19
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15651b22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80
dashboard link: https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111b465a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171d533a580000

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
Read of size 4 at addr ffff88807e37a580 by task kworker/u8:7/3479

CPU: 1 UID: 0 PID: 3479 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue:  0x0 (gid-cache-wq)
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
 worker_thread+0x526/0xe40 kernel/workqueue.c:3436
 kthread+0x3b3/0x730 kernel/kthread.c:463
 ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 5947:
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

Freed by task 5952:
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
 __local_bh_enable_ip+0xff/0x120 kernel/softirq.c:457
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 netif_addr_unlock_bh include/linux/netdevice.h:4874 [inline]
 dev_uc_add+0xd4/0x110 net/core/dev_addr_lists.c:694
 vlan_dev_set_mac_address+0x2d4/0x440 net/8021q/vlan_dev.c:324
 netif_set_mac_address+0x304/0x4a0 net/core/dev.c:9985
 do_setlink.isra.0+0x75f/0x3e50 net/core/rtnetlink.c:3110
 rtnl_changelink net/core/rtnetlink.c:3776 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
 rtnl_newlink+0x11bd/0x2380 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x4aa/0x520 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807e37a4c0
 which belongs to the cache mm_struct of size 2968
The buggy address is located 192 bytes inside of
 freed 2968-byte region [ffff88807e37a4c0, ffff88807e37b058)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e378
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888033218c01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ff30b40 dead000000000100 dead000000000122
raw: 0000000000000000 00000000800a000a 00000000f5000000 ffff888033218c01
head: 00fff00000000040 ffff88813ff30b40 dead000000000100 dead000000000122
head: 0000000000000000 00000000800a000a 00000000f5000000 ffff888033218c01
head: 00fff00000000003 ffffea0001f8de01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5573, tgid 5573 (dhcpcd-run-hook), ts 54892168157, free_ts 54822253634
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
page last free pid 5571 tgid 5571 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x822/0x1130 mm/page_alloc.c:2973
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x127/0x160 mm/slub.c:3886
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __kmalloc_cache_noprof+0x2e1/0x810 mm/slub.c:5775
 kmalloc_noprof include/linux/slab.h:957 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x1a0/0x20c0 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x506/0x1340 security/tomoyo/common.c:2198
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x364/0x460 security/tomoyo/file.c:838
 security_inode_getattr+0x116/0x280 security/security.c:1869
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x11f/0x3f0 fs/stat.c:356
 vfs_fstatat+0x7b/0xf0 fs/stat.c:375
 __do_sys_newfstatat+0x9d/0x120 fs/stat.c:542
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807e37a480: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88807e37a500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e37a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807e37a600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e37a680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

