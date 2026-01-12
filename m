Return-Path: <netdev+bounces-249074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F1D13BBA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05693024E7A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD92E7F29;
	Mon, 12 Jan 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flcc08cV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC32D7DD1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231438; cv=none; b=gw0fQpoS8N/YTqQMn4eVCkLdh7PbTuJw/ptbti/qMHPKdNhtfobn3yBnOSuyVCWNvMitIufclPfnYDb87gY4jLMP/pFnFkN10RvXb3iyVLAaNOBHDXLfZVNS43dGw7xuiAoGrxGV2g6DUYUM8ZwzF2q0pGunu41NMejUoA6YEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231438; c=relaxed/simple;
	bh=QZmQ2xiScu/QFP5/d6AlycS1kU+gd+Aa44hgGOscw50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzfqEpntOuSVmKFyndd3B007+Jt6qG+e3l50Vc7/lFsD0bUgHBmWW4/OHOCrHTNOlL2rU4PMXlKFjTkjJNOfcSW52LpJJ7fpZbD3cCjZCGp48WXlK+zVInhUpsXXYtjkctcjQQSzlZys0qYjpEXjG9PdpGVlHUTXzRi1lqV8UvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flcc08cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED8C16AAE;
	Mon, 12 Jan 2026 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231438;
	bh=QZmQ2xiScu/QFP5/d6AlycS1kU+gd+Aa44hgGOscw50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=flcc08cVx2MucxdUv3kdtKWideU26rwhFWUgUlTVzHmjdv0l8qiEuiGErK/P+Fz+g
	 PzwAOIzLlYvGR/gSvsQJ5bHKRAU9b8GhzOzwtrNUWD47ndI354ae2prhmyF/EML6H+
	 ft7hIOGGV0IbyoqgfFKcw3HUwkHPGzSFfedAL0yX7i5q+Yi+7E3baqbTferUIF+6NL
	 qfPGUprMgXvGW+IkB+OTmsMQ29RzZoiNtOlIHt5Kbc3sCMPZODsYqkWBhz1MawvzTi
	 zyGy0He+cAYQDYIfxZwFPBLy6Rl2dW+usxPwJBPl4fNqcD2j9xJ2yisMfEXwTk4UiP
	 R+9LQvXTDNNug==
Message-ID: <a279c2ae-a443-46e8-9fd4-aee82a5845a0@kernel.org>
Date: Mon, 12 Jan 2026 08:23:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and
 rt_del_uncached_list()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260112103825.3810713-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260112103825.3810713-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 3:38 AM, Eric Dumazet wrote:
> syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
> in an interesting way [1]
> 
> Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> list->prev, while the prior write on list->next went well.
> 
> static inline void INIT_LIST_HEAD(struct list_head *list)
> {
> 	WRITE_ONCE(list->next, list); // This went well
> 	WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> }
> 
> Issue here is that rt6_uncached_list_del() did not attempt to lock
> ul->lock, as list_empty(&rt->dst.rt_uncached) returned
> true because the WRITE_ONCE(list->next, list) happened on the other CPU.
> 
> We might use list_del_init_careful() and list_empty_careful(),
> or make sure rt6_uncached_list_del() always grabs the spinlock
> whenever rt->dst.rt_uncached_list has been set.
> 
> A similar fix is neeed for IPv4.
> 
> [1]
> 
>  BUG: KASAN: slab-use-after-free in INIT_LIST_HEAD include/linux/list.h:46 [inline]
>  BUG: KASAN: slab-use-after-free in list_del_init include/linux/list.h:296 [inline]
>  BUG: KASAN: slab-use-after-free in rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
>  BUG: KASAN: slab-use-after-free in rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
> Write of size 8 at addr ffff8880294cfa78 by task kworker/u8:14/3450
> 
> CPU: 0 UID: 0 PID: 3450 Comm: kworker/u8:14 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xca/0x240 mm/kasan/report.c:482
>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>   INIT_LIST_HEAD include/linux/list.h:46 [inline]
>   list_del_init include/linux/list.h:296 [inline]
>   rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
>   rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
>   addrconf_ifdown+0x143/0x18a0 net/ipv6/addrconf.c:3853
>  addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
>   notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>   call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>   call_netdevice_notifiers net/core/dev.c:2282 [inline]
>   netif_close_many+0x29c/0x410 net/core/dev.c:1785
>   unregister_netdevice_many_notify+0xb50/0x2330 net/core/dev.c:12353
>   ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
>   ops_undo_list+0x3dc/0x990 net/core/net_namespace.c:248
>   cleanup_net+0x4de/0x7b0 net/core/net_namespace.c:696
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
> 
> Allocated by task 803:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   unpoison_slab_object mm/kasan/common.c:340 [inline]
>   __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
>   kasan_slab_alloc include/linux/kasan.h:253 [inline]
>   slab_post_alloc_hook mm/slub.c:4953 [inline]
>   slab_alloc_node mm/slub.c:5263 [inline]
>   kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
>   dst_alloc+0x105/0x170 net/core/dst.c:89
>   ip6_dst_alloc net/ipv6/route.c:342 [inline]
>   icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
>   mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
>   mld_send_cr net/ipv6/mcast.c:2154 [inline]
>   mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> Freed by task 20:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
>   poison_slab_object mm/kasan/common.c:253 [inline]
>   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>   kasan_slab_free include/linux/kasan.h:235 [inline]
>   slab_free_hook mm/slub.c:2540 [inline]
>   slab_free mm/slub.c:6670 [inline]
>   kmem_cache_free+0x18f/0x8d0 mm/slub.c:6781
>   dst_destroy+0x235/0x350 net/core/dst.c:121
>   rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>   rcu_core kernel/rcu/tree.c:2857 [inline]
>   rcu_cpu_kthread+0xba5/0x1af0 kernel/rcu/tree.c:2945
>   smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> Last potentially related work creation:
>   kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
>   kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
>   __call_rcu_common kernel/rcu/tree.c:3119 [inline]
>   call_rcu+0xee/0x890 kernel/rcu/tree.c:3239
>   refdst_drop include/net/dst.h:266 [inline]
>   skb_dst_drop include/net/dst.h:278 [inline]
>   skb_release_head_state+0x71/0x360 net/core/skbuff.c:1156
>   skb_release_all net/core/skbuff.c:1180 [inline]
>   __kfree_skb net/core/skbuff.c:1196 [inline]
>   sk_skb_reason_drop+0xe9/0x170 net/core/skbuff.c:1234
>   kfree_skb_reason include/linux/skbuff.h:1322 [inline]
>   tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
>   __dev_xmit_skb net/core/dev.c:4260 [inline]
>   __dev_queue_xmit+0x26aa/0x3210 net/core/dev.c:4785
>   NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>   ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
>   NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
>   mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
>   mld_send_cr net/ipv6/mcast.c:2154 [inline]
>   mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> The buggy address belongs to the object at ffff8880294cfa00
>  which belongs to the cache ip6_dst_cache of size 232
> The buggy address is located 120 bytes inside of
>  freed 232-byte region [ffff8880294cfa00, ffff8880294cfae8)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x294cf
> memcg:ffff88803536b781
> flags: 0x80000000000000(node=0|zone=1)
> page_type: f5(slab)
> raw: 0080000000000000 ffff88802ff1c8c0 ffffea0000bf2bc0 dead000000000006
> raw: 0000000000000000 00000000800c000c 00000000f5000000 ffff88803536b781
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9, tgid 9 (kworker/0:0), ts 91119585830, free_ts 91088628818
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
>   prep_new_page mm/page_alloc.c:1865 [inline]
>   get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3915
>   __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
>   alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2486
>   alloc_slab_page mm/slub.c:3075 [inline]
>   allocate_slab+0x86/0x3b0 mm/slub.c:3248
>   new_slab mm/slub.c:3302 [inline]
>   ___slab_alloc+0xb10/0x13e0 mm/slub.c:4656
>   __slab_alloc+0xc6/0x1f0 mm/slub.c:4779
>   __slab_alloc_node mm/slub.c:4855 [inline]
>   slab_alloc_node mm/slub.c:5251 [inline]
>   kmem_cache_alloc_noprof+0x101/0x6c0 mm/slub.c:5270
>   dst_alloc+0x105/0x170 net/core/dst.c:89
>   ip6_dst_alloc net/ipv6/route.c:342 [inline]
>   icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
>   mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
>   mld_send_cr net/ipv6/mcast.c:2154 [inline]
>   mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
> page last free pid 5859 tgid 5859 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1406 [inline]
>   __free_frozen_pages+0xfe1/0x1170 mm/page_alloc.c:2943
>   discard_slab mm/slub.c:3346 [inline]
>   __put_partials+0x149/0x170 mm/slub.c:3886
>   __slab_free+0x2af/0x330 mm/slub.c:5952
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
>   kasan_slab_alloc include/linux/kasan.h:253 [inline]
>   slab_post_alloc_hook mm/slub.c:4953 [inline]
>   slab_alloc_node mm/slub.c:5263 [inline]
>   kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
>   getname_flags+0xb8/0x540 fs/namei.c:146
>   getname include/linux/fs.h:2498 [inline]
>   do_sys_openat2+0xbc/0x200 fs/open.c:1426
>   do_sys_open fs/open.c:1436 [inline]
>   __do_sys_openat fs/open.c:1452 [inline]
>   __se_sys_openat fs/open.c:1447 [inline]
>   __x64_sys_openat+0x138/0x170 fs/open.c:1447
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
> 
> Fixes: 8d0b94afdca8 ("ipv6: Keep track of DST_NOCACHE routes in case of iface down/unregister")
> Fixes: 78df76a065ae ("ipv4: take rt_uncached_lock only if needed")
> Reported-by: syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6964cdf2.050a0220.eaf7.009d.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  net/core/dst.c   | 1 +
>  net/ipv4/route.c | 4 ++--
>  net/ipv6/route.c | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



