Return-Path: <netdev+bounces-139620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7099B3947
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D812827B6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA31DF989;
	Mon, 28 Oct 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ3f6nA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D41DF962;
	Mon, 28 Oct 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140674; cv=none; b=C4NWJfJnwLGhOXF0twRkgxG5kFCivBAut8HrR6byen+khHRTxscXXdQ7eRv+SR0pqdMGS3+kgxIhdRWm1EspqsMJstCb0c/9CgAST5dN/e5z8MqcmCjVLY6g02jeTUy0M9U7C900y9fIUl62L6h6uNiAfPcRDenNUZETT32NNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140674; c=relaxed/simple;
	bh=1IfWTLCUgEOgu5xZOkUO+RyyKtQNftqgLOGvEOmzanY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNuQuW0raGEIjpAdT9GSlkRwMX3g3QT+SrJZubva1TLLl/PhKO7VFBbF1huZD2j1/sPA0ojuCDZQ+GqZaeFMkRoMUxZzFDo2MTr5KtCzxq5JZenIGhfbRcloRpdsk1oy2g8+WHHmDKsL5HEHs++hkDTGBHcTtX2fRTkGwJTaonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ3f6nA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F2AC4CEC3;
	Mon, 28 Oct 2024 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730140673;
	bh=1IfWTLCUgEOgu5xZOkUO+RyyKtQNftqgLOGvEOmzanY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gZ3f6nA8NaU3zd+2Vw16ypMhkqCtnkLBOwZ4RXzNxEp0Omwm1T+SAcs4+X3lOiiE8
	 LLA9qiCHuMcb0HX+ad/ds8emXPtjYQBmDNqMPfkvTV5qVM3tQRdD5bM9HFVt28gw0I
	 WDJRKe+EVUGHtxRlEoKEG57OWxJ6El9986Nxt4+B6eNnCBw74KqNnK6WN6t+wMDj1P
	 n0o74eeLVhQXg6po7gXJGsDFWorA45C6sNnO6KxzJXZqxd0gz4g0uLVWxjOXMrGNOu
	 PvUI6zILlKFl5g0ydzmZc6ZJxVoHtMr3qr8Fo6IJTjiImVeLU1M4PF2AsKDMC2rfXb
	 w3qeY0xNzQYuQ==
Message-ID: <913828ac-9fc6-4261-883a-06ac87d86aa6@kernel.org>
Date: Mon, 28 Oct 2024 19:37:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] BUG: Bad page state in bpf_test_run_xdp_live
To: syzbot <syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com,
 ilias.apalodimas@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, Mina Almasry <almasrymina@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 David Hildenbrand <david@redhat.com>
References: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc. Toke  (I see page_pool used from xdp_test_run_batch)

Cc. Mina (as I see page_pool_alloc_netmem() below)

On 28/10/2024 00.42, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6d858708d465 Merge branch 'net-ethernet-freescale-use-pa-t..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d6a65f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e7f0cac6eaefe81d
> dashboard link: https://syzkaller.appspot.com/bug?extid=d121e098da06af416d23
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156b48a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144db640580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/88c678a36ec8/disk-6d858708.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b19b4fbbd593/vmlinux-6d858708.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/18fef9c3fe20/bzImage-6d858708.xz
> 
> The issue was bisected to:
> 
> commit dba1b8a7ab6853a84bf3afdbeac1c2f2370d3444

$ git describe --contains dba1b8a7ab6853a84bf3afdbeac1c2f2370d3444
v6.8-rc1~131^2~268

> Author: Jesper Dangaard Brouer <hawk@kernel.org>
> Date:   Fri Nov 24 10:16:52 2023 +0000
> 
>      mm/page_pool: catch page_pool memory leaks
> 

Bisect is likely wrong, as this patch simply catch page_pool memory leaks.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1578f640580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1778f640580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1378f640580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
> Fixes: dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks")
> 
> BUG: Bad page state in process syz-executor203  pfn:278e1
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e1dc0 pfn:0x278e1
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000

dead000000000040 == PP_SIGNATURE

> raw: ffff8880278e1dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated

I'm unfamiliar with "page_owner" system?

> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248414468, free_ts 71048141035
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Not tainted 6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>


(no more comment below, but kept remaining email intact)

> BUG: Bad page state in process syz-executor203  pfn:278e2
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e2dc0 pfn:0x278e2
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e2dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248403197, free_ts 71048146269
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:278e3
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e3dc0 pfn:0x278e3
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e3dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248392499, free_ts 71048151461
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:278e4
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e4dc0 pfn:0x278e4
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e4dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248381341, free_ts 71048156641
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:278e5
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e5dc0 pfn:0x278e5
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e5dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248370083, free_ts 71048161843
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:278e6
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e6dc0 pfn:0x278e6
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e6dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248358846, free_ts 71048190667
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:278e7
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880278e7dc0 pfn:0x278e7
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff8880278e7dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248347054, free_ts 71048196073
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:6a1f0
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806a1f0dc0 pfn:0x6a1f0
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff88806a1f0dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248335775, free_ts 71048201729
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:6a1f1
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806a1f1dc0 pfn:0x6a1f1
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff88806a1f1dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248324385, free_ts 71048206965
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:6a1f2
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806a1f2dc0 pfn:0x6a1f2
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff88806a1f2dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248313104, free_ts 71048212188
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:6a1f3
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806a1f3dc0 pfn:0x6a1f3
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff88806a1f3dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248301669, free_ts 71048217415
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inline]
>   skb_free_head net/core/skbuff.c:1096 [inline]
>   skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   __netif_receive_skb_core+0x3edd/0x4570 net/core/dev.c:5642
>   __netif_receive_skb_list_core+0x2b1/0x980 net/core/dev.c:5743
>   __netif_receive_skb_list net/core/dev.c:5810 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5901
>   netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5953
>   xdp_recv_frames net/bpf/test_run.c:279 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:360 [inline]
>   bpf_test_run_xdp_live+0x1b0d/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7effeb162d19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007effeb0f4228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007effeb1e5338 RCX: 00007effeb162d19
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 00007effeb1e5330 R08: 00007effeb0f46c0 R09: 00007effeb0f46c0
> R10: 00007effeb0f46c0 R11: 0000000000000246 R12: 00007effeb1b21bc
> R13: 2caa1414ac000000 R14: 656c6c616b7a7973 R15: 00007ffc0d3b6078
>   </TASK>
> BUG: Bad page state in process syz-executor203  pfn:6a1f4
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806a1f4dc0 pfn:0x6a1f4
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888026a8f000 0000000000000000
> raw: ffff88806a1f4dc0 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5947, tgid 5944 (syz-executor203), ts 71248290591, free_ts 71048222589
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>   alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>   __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>   page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>   page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>   page_pool_dev_alloc_pages include/net/page_pool/helpers.h:96 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:305 [inline]
>   bpf_test_run_xdp_live+0x950/0x2160 net/bpf/test_run.c:389
>   bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1317
>   bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
>   __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5938 tgid 5938 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>   taskstats_tgid_alloc kernel/taskstats.c:582 [inline]
>   taskstats_exit+0x360/0xa60 kernel/taskstats.c:621
>   do_exit+0x9ad/0x28e0 kernel/exit.c:924
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>   __do_sys_exit_group kernel/exit.c:1099 [inline]
>   __se_sys_exit_group kernel/exit.c:1097 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 1 UID: 0 PID: 5947 Comm: syz-executor203 Tainted: G    B              6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   bad_page+0x166/0x1b0 mm/page_alloc.c:501
>   free_page_is_bad mm/page_alloc.c:918 [inline]
>   free_pages_prepare mm/page_alloc.c:1100 [inline]
>   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>   skb_free_frag include/linux/skbuff.h:3405 [inl
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

