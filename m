Return-Path: <netdev+bounces-108210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846A91E5D2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D5284DFC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A3016DC30;
	Mon,  1 Jul 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="wikFMGok"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D615E5DC;
	Mon,  1 Jul 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852711; cv=none; b=NBC68qK2i+5v0SGusfdrCsSE9aJpHWqXWt9cX5Vh3GvW+J3vvnP6YYx+8Brb8TwvrjF3dH6y5nRicsxqchKYUdIINrcg5F0zek7rTRey5mE2dAfs/+ycNmNWJDxjGg/kslIvRVa+7w2pA3yZVZ8rk4NOYoS6ZRKpoxKU3lXXrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852711; c=relaxed/simple;
	bh=/4Cz9W+u17Dk4nTNuuVX8iARLlr6f5V7inOV8D4coH8=;
	h=Message-ID:Date:MIME-Version:To:References:Cc:From:Subject:
	 In-Reply-To:Content-Type; b=lSMshpOsIlsBdxCM5aWnLMK5+YItiRX6/USioHrS+7BKnLv8heElcMJeCqDj9Lh62vIOV78qpD/A31IJxdaf3ecfw4+wvl9kZ87kNz02zoQ+/vifXd267EGdzUp13zUFS+s5UIows0eCKDek+Gh2Yxz77unYME+/tzyLTMcbSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=wikFMGok; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 7B4E77D57F;
	Mon,  1 Jul 2024 17:51:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1719852702; bh=/4Cz9W+u17Dk4nTNuuVX8iARLlr6f5V7inOV8D4coH8=;
	h=Message-ID:Date:MIME-Version:To:References:Cc:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<05071e56-bc6b-08e9-873b-bbf6f966afff@katalix.com>|
	 Date:=20Mon,=201=20Jul=202024=2017:51:42=20+0100|MIME-Version:=201
	 .0|To:=20syzbot=20<syzbot+b471b7c936301a59745b@syzkaller.appspotma
	 il.com>,=0D=0A=20davem@davemloft.net,=20edumazet@google.com,=20hda
	 nton@sina.com,=20kuba@kernel.org,=0D=0A=20linux-kernel@vger.kernel
	 .org,=20netdev@vger.kernel.org,=20pabeni@redhat.com,=0D=0A=20syzka
	 ller-bugs@googlegroups.com|References:=20<000000000000ab25fa061c31
	 dcb9@google.com>|Cc:=20Tom=20Parkin=20<tparkin@katalix.com>|From:=
	 20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[syzbo
	 t]=20[net?]=20KASAN:=20slab-use-after-free=20Read=20in=0D=0A=20l2t
	 p_tunnel_del_work|In-Reply-To:=20<000000000000ab25fa061c31dcb9@goo
	 gle.com>;
	b=wikFMGok/9QPoLmsIpEzI0mBwN8CsfjQ7hUpmqqIf6ylzlzfzDgBMw0tfZHV/IDwK
	 j0CB6GA0FXQ5TT2oYfwFnWcJgROF/49ZueqR2pDdLO7gAISJzRGK5UyJUyxPLfg08n
	 +u3GbF64YZLOb2p0iNaUqLjmyZLX9hNRVZlbMwX9ekaAOCNCUu2IT4osirwv4Su3Lt
	 WLYeB9Q/+6IYCP3JKbYkFVJg/t44JYbv8GRybHrmxqcfTDjwiThdTLdaAzKCv7B1Dq
	 Itv5NdMpDSXsPzgTi5SyYHkZUdeP+Xq+j7CMHLL/3J1CszZH+8h56r4j5zFbC8mzxU
	 Wdj+mGOYL1G1g==
Message-ID: <05071e56-bc6b-08e9-873b-bbf6f966afff@katalix.com>
Date: Mon, 1 Jul 2024 17:51:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, hdanton@sina.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <000000000000ab25fa061c31dcb9@google.com>
Cc: Tom Parkin <tparkin@katalix.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 l2tp_tunnel_del_work
In-Reply-To: <000000000000ab25fa061c31dcb9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 17:12, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=161d2066980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
> dashboard link: https://syzkaller.appspot.com/bug?extid=b471b7c936301a59745b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1094f701980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf2361980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9672225af907/disk-1c5fc27b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f14d163a914/vmlinux-1c5fc27b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ec6c331e6a6e/bzImage-1c5fc27b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in l2tp_tunnel_del_work+0xe5/0x330 net/l2tp/l2tp_core.c:1334
> Read of size 8 at addr ffff88802361a0b8 by task kworker/u8:1/12

I think this is related to a similar issue
https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
which I'm currently working on.

> 
> CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Workqueue: l2tp l2tp_tunnel_del_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   l2tp_tunnel_del_work+0xe5/0x330 net/l2tp/l2tp_core.c:1334
>   process_one_work kernel/workqueue.c:3248 [inline]
>   process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
>   worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Allocated by task 5102:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   __do_kmalloc_node mm/slub.c:4123 [inline]
>   __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4136
>   kmalloc_noprof include/linux/slab.h:664 [inline]
>   kzalloc_noprof include/linux/slab.h:778 [inline]
>   l2tp_session_create+0x3b/0xc20 net/l2tp/l2tp_core.c:1675
>   pppol2tp_connect+0xca3/0x17a0 net/l2tp/l2tp_ppp.c:782
>   __sys_connect_file net/socket.c:2049 [inline]
>   __sys_connect+0x2df/0x310 net/socket.c:2066
>   __do_sys_connect net/socket.c:2076 [inline]
>   __se_sys_connect net/socket.c:2073 [inline]
>   __x64_sys_connect+0x7a/0x90 net/socket.c:2073
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 0:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>   poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>   __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2196 [inline]
>   slab_free mm/slub.c:4438 [inline]
>   kfree+0x149/0x360 mm/slub.c:4559
>   __sk_destruct+0x58/0x5f0 net/core/sock.c:2191
>   rcu_do_batch kernel/rcu/tree.c:2535 [inline]
>   rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
>   handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>   __do_softirq kernel/softirq.c:588 [inline]
>   invoke_softirq kernel/softirq.c:428 [inline]
>   __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> 
> Last potentially related work creation:
>   kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>   __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>   __call_rcu_common kernel/rcu/tree.c:3072 [inline]
>   call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
>   pppol2tp_release+0x24b/0x350 net/l2tp/l2tp_ppp.c:457
>   __sock_release net/socket.c:659 [inline]
>   sock_close+0xbc/0x240 net/socket.c:1421
>   __fput+0x406/0x8b0 fs/file_table.c:422
>   task_work_run+0x24f/0x310 kernel/task_work.c:180
>   exit_task_work include/linux/task_work.h:38 [inline]
>   do_exit+0xa27/0x27e0 kernel/exit.c:874
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1023
>   __do_sys_exit_group kernel/exit.c:1034 [inline]
>   __se_sys_exit_group kernel/exit.c:1032 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88802361a000
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 184 bytes inside of
>   freed 1024-byte region [ffff88802361a000, ffff88802361a400)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23618
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffefff(slab)
> raw: 00fff00000000040 ffff888015041dc0 ffffea00008d3400 0000000000000002
> raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
> head: 00fff00000000040 ffff888015041dc0 ffffea00008d3400 0000000000000002
> head: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
> head: 00fff00000000003 ffffea00008d8601 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4757, tgid 4757 (S41dhcpcd), ts 76204097888, free_ts 76202473642
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
>   prep_new_page mm/page_alloc.c:1481 [inline]
>   get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
>   __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
>   __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>   alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>   alloc_slab_page+0x5f/0x120 mm/slub.c:2265
>   allocate_slab+0x5a/0x2f0 mm/slub.c:2428
>   new_slab mm/slub.c:2481 [inline]
>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
>   __slab_alloc+0x58/0xa0 mm/slub.c:3757
>   __slab_alloc_node mm/slub.c:3810 [inline]
>   slab_alloc_node mm/slub.c:3990 [inline]
>   __do_kmalloc_node mm/slub.c:4122 [inline]
>   __kmalloc_noprof+0x257/0x400 mm/slub.c:4136
>   kmalloc_noprof include/linux/slab.h:664 [inline]
>   kzalloc_noprof include/linux/slab.h:778 [inline]
>   tomoyo_init_log+0x1b3e/0x2050 security/tomoyo/audit.c:275
>   tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
>   tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
>   tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
>   tomoyo_environ security/tomoyo/domain.c:672 [inline]
>   tomoyo_find_next_domain+0x1384/0x1cf0 security/tomoyo/domain.c:878
>   tomoyo_bprm_check_security+0x115/0x180 security/tomoyo/tomoyo.c:102
>   security_bprm_check+0x65/0x90 security/security.c:1191
>   search_binary_handler fs/exec.c:1785 [inline]
>   exec_binprm fs/exec.c:1839 [inline]
>   bprm_execve+0xa56/0x17c0 fs/exec.c:1891
>   do_execveat_common+0x553/0x700 fs/exec.c:1998
> page last free pid 4757 tgid 4757 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1093 [inline]
>   free_unref_page+0xd22/0xea0 mm/page_alloc.c:2588
>   __slab_free+0x31b/0x3d0 mm/slub.c:4349
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>   slab_post_alloc_hook mm/slub.c:3940 [inline]
>   slab_alloc_node mm/slub.c:4002 [inline]
>   __do_kmalloc_node mm/slub.c:4122 [inline]
>   __kmalloc_noprof+0x1a3/0x400 mm/slub.c:4136
>   kmalloc_noprof include/linux/slab.h:664 [inline]
>   tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
>   tomoyo_supervisor+0xe0d/0x11f0 security/tomoyo/common.c:2095
>   tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
>   tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
>   tomoyo_environ security/tomoyo/domain.c:672 [inline]
>   tomoyo_find_next_domain+0x1384/0x1cf0 security/tomoyo/domain.c:878
>   tomoyo_bprm_check_security+0x115/0x180 security/tomoyo/tomoyo.c:102
>   security_bprm_check+0x65/0x90 security/security.c:1191
>   search_binary_handler fs/exec.c:1785 [inline]
>   exec_binprm fs/exec.c:1839 [inline]
>   bprm_execve+0xa56/0x17c0 fs/exec.c:1891
>   do_execveat_common+0x553/0x700 fs/exec.c:1998
>   do_execve fs/exec.c:2072 [inline]
>   __do_sys_execve fs/exec.c:2148 [inline]
>   __se_sys_execve fs/exec.c:2143 [inline]
>   __x64_sys_execve+0x92/0xb0 fs/exec.c:2143
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff888023619f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88802361a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88802361a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                          ^
>   ffff88802361a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88802361a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

