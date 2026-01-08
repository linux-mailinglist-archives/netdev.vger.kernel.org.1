Return-Path: <netdev+bounces-248269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A03D064AA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D265C30118EF
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742A3321A5;
	Thu,  8 Jan 2026 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b="Gzm4suF4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229D2DAFA2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907568; cv=none; b=RFwJGnU890mwjmSFrIL2YZ/cD8NEXv/26xRZsFHAHrqI9JnNUUdSAH0JEpEEKMnuPS+adSKd2D7Q/rH0pSrqqzCrT5eCaxMR7qTKygyY+fhfRHkcRTKb8NBWVcP8iFwrUlYIc9Fxq2i4HWDyUKxBQfYDsO9t3JMdT4Hi7YAI7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907568; c=relaxed/simple;
	bh=TNziofX0itKaPikxcuDS4c1pWCZWnM9HXpLT8xT4L1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2IyJoX5+UlunL0dEYryyYj98ejhf4cM4EW5vUuK8nlgKKDgelxfLULdELlIq3fKTbeskIbVk4IK5W9TxrNdLolUWrASHkDq1wCpHYZ2SVJjSxgCIpk7zYtT9OtSAB9uTcQ0LpezjQUcoS7m3fy46kHZwFf9vL9j4cc1oEAnGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com; spf=none smtp.mailfrom=delta-utec.com; dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b=Gzm4suF4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=delta-utec.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b727f452fffso370062966b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delta-utec-com.20230601.gappssmtp.com; s=20230601; t=1767907565; x=1768512365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4mgDioiTeNrXSpEth1PkYXCMweER8x7RUkUG+64gCQ=;
        b=Gzm4suF4OHvwXutbqbpQXgCYF6tQyiGsyXkr++fOtBSVvCwG2DlDGPnRO2RpdFDgx9
         l0jNw/9FY7fvlebBuhlkHBu+H5vxC7u0aNUAAaVVohjdqxWtVOX574NfOHj5o7L8s5Sr
         QgjpTmDrZMwgUinTa/cEV/tpMHGtrjIU6lUxXnGmnJbCc6IYaOS2loOJ9JPPslSjTI44
         0VC/mX/M1l5Kb9nxvBogslsiGOF6g8L8UBdvlUKgetPoycBBHtNvxv6PP+kGuHWGFDFD
         l30JRR4Hc1bCW7I8GzZKA9dg6jkJdNdGc21IDVTJqJf9Xnj7Pgfypx/4NgKzM0jRtUnj
         sVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907565; x=1768512365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4mgDioiTeNrXSpEth1PkYXCMweER8x7RUkUG+64gCQ=;
        b=D8CGyUXQqMvgVvSlIQrfNxBiRNcNwT6jkXx57YSry2h060RZigR4JQMEK71E/ZwTNx
         yyvAybVCcezHM9DPlT7uXg4tEVI7qObUKi4lro/83EW+DV1KTTcpjFpHjQ2LpdaPoU9E
         I5ba1A09LVLfKcAMV6VcmehcUChFTJD+bZ2Ug2ysjbV1pLa6/S73T82+ZwCEcp/uC8gY
         S5Kf8/uChM7DvI9mxDrs49wyFo35QkZNKZ4Vkwx0Z2JNXWl+s6qC4Mab+W/KklAMXBKQ
         g9y4KRF5gyHJOBrnGdlZumlmPmS0oGCU0Plv2OaVBG3eBr5H1/BjdOjPWMjb6q55onRg
         5Q9g==
X-Forwarded-Encrypted: i=1; AJvYcCXBm1/ngEJDpYoI2lgezhecUa/BIhPOSipSdY04Rj7ZIdfWkXKlqh5mw83xxcGEPqLW5tZ0Cn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZr/1V5fZLW0HnJIWDxBC+qJmw9FQydVXtnqgNrSXAZNqUC91
	NDjSySIppJXo2e70EfsrurIyZRjC2uO75EtZgd89NzBlcrlZwNMyiJJ0E84XbsQQtg==
X-Gm-Gg: AY/fxX4a8Dq5msNlwIsJQwAGHHVTZ+q4wW0g3gWPKZ3GxnxopaiKvJEest79xRjB+FS
	yEk5HmIOGfv9HaZXIXP9hrN6uJvLdmsi76oplweyyK4Z5a80hNU0lsQYhUSii2A7degZCFpvoJp
	LRHwzlQgbctYvM0jxM2rvldt11Q6B3CgqGTppvI8h+qGa7WeToEWUghcOBroeE1GHWPOz+aijPB
	mSmkS//veRF7oE5hvBKZrA6AUOoOLQymmPRBSFz0yK8P1pAZE6EK7L47IKPDAU4wGbjQZwCj2mI
	W6bZ8ndfx9Bb1X8l7A2gzPNyB5VCdfvgbZzCiQOohLG0RtXpaT4r2JuXtBKbeGDknIUy9Nru90t
	bvZoKKntGZBTUJzLjAvvzchvlqQohDvipc7xuX1fBer/i5OiqBnTnll1Vd2d0G7JHbYYhc978Ds
	IU/0x3GsJlzxYyBPL+Onr0k1A7NT/N6PE9F4IR9SJJpsUX8BjvnJw+UVtXVa8V+GXjZ7+3qCDcL
	ZPViqUSLn+Qw4GrIHN2iZosA3hLgoQLaYYH6h8=
X-Google-Smtp-Source: AGHT+IE0MpXxXZVi5dEwBqmDutJHMJb9alW6aAJtrrZpx7J+VawqTBHIKODyTszPM6OoBIAkQVKjPA==
X-Received: by 2002:a17:906:aa0c:b0:b79:cd80:6fff with SMTP id a640c23a62f3a-b84299bcce9mr944986266b.17.1767907564749;
        Thu, 08 Jan 2026 13:26:04 -0800 (PST)
Received: from localhost.localdomain (2001-1c00-3405-d100-4ecd-82cc-9bd7-0e66.cable.dynamic.v6.ziggo.nl. [2001:1c00:3405:d100:4ecd:82cc:9bd7:e66])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564e05sm941034666b.65.2026.01.08.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 13:26:04 -0800 (PST)
From: Boudewijn van der Heide <boudewijn@delta-utec.com>
To: edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	boudewijn@delta-utec.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Subject: Re: [PATCH net] macvlan: Fix use-after-free in macvlan_common_newlink
Date: Thu,  8 Jan 2026 22:25:51 +0100
Message-ID: <20260108212552.9522-1-boudewijn@delta-utec.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANn89iKnnVJGCCmsiDZ4CqYJKjEWN3PREwaVXLzOBWqDKhOxtA@mail.gmail.com>
References: <CANn89iKnnVJGCCmsiDZ4CqYJKjEWN3PREwaVXLzOBWqDKhOxtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> It completely fixes the problem.
> 
> Crash occurs in
>
>             if (entry->vlan->flags & MACVLAN_FLAG_NODST)
>
> because entry->vlan has been freed already :
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in macvlan_forward_source+0x512/0x630
> drivers/net/macvlan.c:436
> Read of size 2 at addr ffff888029fb8dfc by task syz.1.2073/14062
>
> CPU: 0 UID: 0 PID: 14062 Comm: syz.1.2073 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 10/25/2025
> Call Trace:
> <TASK>
> dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> print_address_description mm/kasan/report.c:378 [inline]
> print_report+0xca/0x240 mm/kasan/report.c:482
> kasan_report+0x118/0x150 mm/kasan/report.c:595
> macvlan_forward_source+0x512/0x630 drivers/net/macvlan.c:436
> macvlan_handle_frame+0x1ba/0x12e0 drivers/net/macvlan.c:495
> __netif_receive_skb_core+0x95f/0x2f90 net/core/dev.c:6024
> __netif_receive_skb_one_core net/core/dev.c:6135 [inline]
> __netif_receive_skb+0x72/0x380 net/core/dev.c:6250
> netif_receive_skb_internal net/core/dev.c:6336 [inline]
> netif_receive_skb+0x1bb/0x750 net/core/dev.c:6395
> tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
> tun_get_user+0x2aa3/0x3dc0 drivers/net/tun.c:1953
> tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
> new_sync_write fs/read_write.c:593 [inline]
> vfs_write+0x5c9/0xb30 fs/read_write.c:686
> ksys_write+0x145/0x250 fs/read_write.c:738
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f90edf8e1ff
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54
> 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
> RSP: 002b:00007f90eedb6000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f90ee1e6180 RCX: 00007f90edf8e1ff
> RDX: 000000000000004e RSI: 0000200000000180 RDI: 00000000000000c8
> RBP: 00007f90ee013f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000004e R11: 0000000000000293 R12: 0000000000000000
> R13: 00007f90ee1e6218 R14: 00007f90ee1e6180 R15: 00007ffd5dc50558
> </TASK>
>
> Allocated by task 13998:
> kasan_save_stack mm/kasan/common.c:56 [inline]
> kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
> __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
> kasan_kmalloc include/linux/kasan.h:262 [inline]
> __do_kmalloc_node mm/slub.c:5657 [inline]
> __kvmalloc_node_noprof+0x5d5/0x920 mm/slub.c:7134
> alloc_netdev_mqs+0xa6/0x11b0 net/core/dev.c:11997
> vti6_init_net+0x104/0x370 net/ipv6/ip6_vti.c:1146
> ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
> setup_net+0x110/0x330 net/core/net_namespace.c:446
> copy_net_ns+0x3e3/0x570 net/core/net_namespace.c:581
> create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
> unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:226
> ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3171
> __do_sys_unshare kernel/fork.c:3242 [inline]
> __se_sys_unshare kernel/fork.c:3240 [inline]
> __x64_sys_unshare+0x38/0x50 kernel/fork.c:3240
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 13998:
> kasan_save_stack mm/kasan/common.c:56 [inline]
> kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
> kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
> poison_slab_object mm/kasan/common.c:252 [inline]
> __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
> kasan_slab_free include/linux/kasan.h:234 [inline]
> slab_free_hook mm/slub.c:2540 [inline]
> slab_free mm/slub.c:6668 [inline]
> kfree+0x1c0/0x660 mm/slub.c:6876
> vti6_init_net+0x2e2/0x370 net/ipv6/ip6_vti.c:1168
> ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
> setup_net+0x110/0x330 net/core/net_namespace.c:446
>
> copy_net_ns+0x3e3/0x570 net/core/net_namespace.c:581
> create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
> unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:226
> ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3171
> __do_sys_unshare kernel/fork.c:3242 [inline]
> __se_sys_unshare kernel/fork.c:3240 [inline]
> __x64_sys_unshare+0x38/0x50 kernel/fork.c:3240
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888029fb8000
> which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 3580 bytes inside of
> freed 4096-byte region [ffff888029fb8000, ffff888029fb9000)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29fb8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff88803317c501
> anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88813ffb0500 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000040004 00000000f5000000 ffff88803317c501
> head: 00fff00000000040 ffff88813ffb0500 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000040004 00000000f5000000 ffff88803317c501
> head: 00fff00000000003 ffffea0000a7ee01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask
> 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
>pid 11169, tgid 11169 (modprobe), ts 207829820236, free_ts
> 207789169305
> set_page_owner include/linux/page_owner.h:32 [inline]
> post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
> prep_new_page mm/page_alloc.c:1854 [inline]
> get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
> __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
> alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
> alloc_slab_page mm/slub.c:3075 [inline]
> allocate_slab+0x86/0x3b0 mm/slub.c:3248
> new_slab mm/slub.c:3302 [inline]
> ___slab_alloc+0xf2b/0x1960 mm/slub.c:4656
> __slab_alloc+0x65/0x100 mm/slub.c:4779
> __slab_alloc_node mm/slub.c:4855 [inline]
> slab_alloc_node mm/slub.c:5251 [inline]
> __do_kmalloc_node mm/slub.c:5656 [inline]
> __kvmalloc_node_noprof+0x6b6/0x920 mm/slub.c:7134
> seq_buf_alloc fs/seq_file.c:38 [inline]
> seq_read_iter+0x202/0xe20 fs/seq_file.c:210
> proc_reg_read_iter+0x1b7/0x280 fs/proc/inode.c:299
> new_sync_read fs/read_write.c:491 [inline]
> vfs_read+0x55a/0xa30 fs/read_write.c:572
> ksys_read+0x145/0x250 fs/read_write.c:715
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 11127 tgid 11119 stack trace:
> reset_page_owner include/linux/page_owner.h:25 [inline]
> free_pages_prepare mm/page_alloc.c:1395 [inline]
> __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
> __folio_put+0x21b/0x2c0 mm/swap.c:112
> folio_put include/linux/mm.h:1612 [inline]
> put_page include/linux/mm.h:1681 [inline]
> do_exit+0x183b/0x2310 kernel/exit.c:1002
> do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
> get_signal+0x1285/0x1340 kernel/signal.c:3034
> arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
> __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
> exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
> __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
> syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
> syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
> syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
> do_syscall_64+0x2d0/0xf80 arch/x86/entry/syscall_64.c:100
> entry_SYSCALL_64_after_hwframe+0x77/0x7f




> > The report shows the freed object is in kmalloc-cg-4k (size 4096):
> >
> > The buggy address belongs to the object at ffff888030eda000
> > which belongs to the cache kmalloc-cg-4k of size 4096
> >
> > struct macvlan_port fits this size (due to the large hash tables),
> > whereas struct macvlan_source_entry is much smaller.
> > The crash happens at offset 3580, which corresponds to the vlan_source_hash array inside the port:
> >
> > The race occurs in the register_netdevice() error path in macvlan_common_newlink():
> >
> > 1. netdev_rx_handler_register() succeeds
> > 2. register_netdevice() fails.
> > 3. macvlan_port_destroy() is called, performing a synchronous kfree(port).
> >
> > If a packet arrives during step 3,
> > macvlan_handle_frame() accesses port->vlan_source_hash (via macvlan_forward_source),
> > after it is freed.
> >
> > My patch restores the kfree_rcu behavior for the port (removed in 2016).
> > I believe both fixes are needed: yours for the source entries, and mine for the port itself.

> I do not think your patch is needed.

> Let's wait after my patch is merged, we will see if new syzbot reports
> are found.

Thanks for the detailed explanation and for clarifying the crash.
That makes sense.

Let’s see how things look once your patch is merged and syzbot
reruns. If new reports show a port lifetime issue, we can revisit
this then.

Thanks,
Boudewijn

