Return-Path: <netdev+bounces-85599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0189B8E4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DB1F2248C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494B38F87;
	Mon,  8 Apr 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9IzFsKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBF3A29F;
	Mon,  8 Apr 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562150; cv=none; b=HoE9o4B/fBCJEhbNaKfXNXKr4PbbkQ6/qK/31xwlkf1jLPT+dQCG6xF6cTGrH7Ryn/wx86F0m7c4YVaS5tl1VpxAcN6J5s0EWZPZvsKZI9cIwZeZNoJTi6bE63RGF23+ovD0LC5AlTZ1GizPmdiUWKYi8pVgGqx+ADtA6KlbuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562150; c=relaxed/simple;
	bh=urJAqZagQY+i5HLhlXYsgrp3WcMS2NlTAWCnEccjgRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5o5L1DLayW5OpPMqdielvDQJVb27K9UOKHsITW8k1UaXNjsd+4WKHkIVY7aJDwaQXYLx01wnIHxMwVuUtdw6GUK6AOmLaMW8tqWusayvz+mtaD276qxYUErJYhZbQYYqTOAZexEm+xxQpGGKBq27dQE//gXM9mfb7tT0byy4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9IzFsKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0316C433C7;
	Mon,  8 Apr 2024 07:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562149;
	bh=urJAqZagQY+i5HLhlXYsgrp3WcMS2NlTAWCnEccjgRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9IzFsKU/feThLuVPcT54G+4n4xltO/i2J3ouV8UpYvu9pUD2PjhqkTBFuvQ22uew
	 d5h0yKAX7mVQf4DdTd5HIqypqAMH204DUJMlnJlEmQ2kJHvn2DpIGTzQbi0TWIAukI
	 vyM1DjZoNTuimB/P5TFb8wcLZCkBIm6UPxZDBXE6RmfsgHsBaEWc9Df3RbGxJTPRor
	 UNyeBuCRN6rYxlwwf/tiN5GNYHFnx/QaUniAL264E9YSPckk/avY7iCt5x89fFpkLW
	 S3HxHln1fZioqiQivcIzpcydcwwVsWM0svVWe0bjvHDD5l6KnUxYehUIxxBlyp2rB8
	 89Hj9w+XRK+eg==
Date: Mon, 8 Apr 2024 08:42:23 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net] Bluetooth: validate setsockopt(RFCOMM_LM) user input
Message-ID: <20240408074223.GY26556@kernel.org>
References: <20240404124723.2429464-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404124723.2429464-1-edumazet@google.com>

On Thu, Apr 04, 2024 at 12:47:23PM +0000, Eric Dumazet wrote:
> syzbot reported rfcomm_sock_setsockopt_old() is copying data without
> checking user input length.
> 
>  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
>  BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
>  BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
> Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064
> 
> CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>   copy_from_sockptr include/linux/sockptr.h:55 [inline]
>   rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
>   rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
>   do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
>   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>   __do_sys_setsockopt net/socket.c:2343 [inline]
>   __se_sys_setsockopt net/socket.c:2340 [inline]
>   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f36ff898dc9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe010c2208 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f36ff898dc9
> RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000006
> RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
> R10: 00000000200000c0 R11: 0000000000000246 R12: 0000555567399338
> R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> Allocated by task 5064:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   __do_kmalloc_node mm/slub.c:3966 [inline]
>   __kmalloc+0x233/0x4a0 mm/slub.c:3979
>   kmalloc include/linux/slab.h:632 [inline]
>   __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
>   do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
>   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>   __do_sys_setsockopt net/socket.c:2343 [inline]
>   __se_sys_setsockopt net/socket.c:2340 [inline]
>   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> The buggy address belongs to the object at ffff8880209a8bc0
>  which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 1 bytes to the right of
>  allocated 2-byte region [ffff8880209a8bc0, ffff8880209a8bc2)
> 
> The buggy address belongs to the physical page:
> page:ffffea0000826a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x209a8
> flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000800 ffff888014c41280 ffffea000081fb80 dead000000000002
> raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9917548498, free_ts 0
>   set_page_owner include/linux/page_owner.h:31 [inline]
>   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
>   prep_new_page mm/page_alloc.c:1540 [inline]
>   get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
>   __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   alloc_slab_page+0x5f/0x160 mm/slub.c:2175
>   allocate_slab mm/slub.c:2338 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2391
>   ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
>   __slab_alloc mm/slub.c:3610 [inline]
>   __slab_alloc_node mm/slub.c:3663 [inline]
>   slab_alloc_node mm/slub.c:3835 [inline]
>   __do_kmalloc_node mm/slub.c:3965 [inline]
>   __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
>   kmalloc_array include/linux/slab.h:665 [inline]
>   kcalloc include/linux/slab.h:696 [inline]
>   group_cpus_evenly+0x294/0x5f0 lib/group_cpus.c:365
>   blk_mq_map_queues+0x4c/0x3e0 block/blk-mq-cpumap.c:23
>   blk_mq_alloc_tag_set+0x7ac/0xf40 block/blk-mq.c:4521
>   nbd_dev_add+0x367/0xc80 drivers/block/nbd.c:1831
>   nbd_init+0x224/0x2e0 drivers/block/nbd.c:2593
>   do_one_initcall+0x238/0x830 init/main.c:1241
>   do_initcall_level+0x157/0x210 init/main.c:1303
>   do_initcalls+0x3f/0x80 init/main.c:1319
>   kernel_init_freeable+0x435/0x5d0 init/main.c:1550
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff8880209a8a80: 06 fc fc fc 06 fc fc fc 06 fc fc fc 07 fc fc fc
>  ffff8880209a8b00: fa fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
> >ffff8880209a8b80: fa fc fc fc fa fc fc fc 02 fc fc fc fa fc fc fc
>                                            ^
>  ffff8880209a8c00: 00 fc fc fc 00 fc fc fc 00 fc fc fc 05 fc fc fc
>  ffff8880209a8c80: 05 fc fc fc 05 fc fc fc fa fc fc fc 00 fc fc fc
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOTH SUBSYSTEM)
> Cc: linux-bluetooth@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


