Return-Path: <netdev+bounces-23114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2ED76AFFB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1679B1C20CAB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814E200A7;
	Tue,  1 Aug 2023 09:53:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE371F95A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3B2C433C8;
	Tue,  1 Aug 2023 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690883613;
	bh=C1Jpvk6Bv1fJ8LhqNqMP28sVV5LTGPAKle530diCObQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGGq8VGH0oI27DvpXs+XK9QUEyog4WpEWkukuZSq9I+oslxXrGfZeo2R7MUT0w1gu
	 xv7N13SybzqNy1OAmxTdg6RYqoPJSj3eoxISvCrNqJaPJiMqq6TYXv+1WSZ1QehamE
	 MMmHUr4AVwfq0tvmweK8v949SJtpW80NpldgPHOZ+A0HEd+lviTWASsJcjyKEKIZkK
	 Q3+BzNvMeBsf2nlqp+nUo2OtpFBnSJM5ZX3+JkNncxFp6c+KY96Wgy35V+zZNyrj5Q
	 6nZnJJfNXdHT4MMPw0HBnvJ8KTwiXr9FqzBcikpRQ3zjlB7zH4ARK+0Il8QD50vlaW
	 Kj0Uqk1jhxpGw==
Date: Tue, 1 Aug 2023 11:53:30 +0200
From: Simon Horman <horms@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] vxlan: Fix nexthop hash size
Message-ID: <ZMjWGnWc+vLQQ/5n@kernel.org>
References: <20230731200208.61672-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731200208.61672-1-bpoirier@nvidia.com>

On Mon, Jul 31, 2023 at 04:02:08PM -0400, Benjamin Poirier wrote:
> The nexthop code expects a 31 bit hash, such as what is returned by
> fib_multipath_hash() and rt6_multipath_hash(). Passing the 32 bit hash
> returned by skb_get_hash() can lead to problems related to the fact that
> 'int hash' is a negative number when the MSB is set.
> 
> In the case of hash threshold nexthop groups, nexthop_select_path_hthr()
> will disproportionately select the first nexthop group entry. In the case
> of resilient nexthop groups, nexthop_select_path_res() may do an out of
> bounds access in nh_buckets[], for example:
>     hash = -912054133
>     num_nh_buckets = 2
>     bucket_index = 65535
> 
> which leads to the following panic:
> 
> BUG: unable to handle page fault for address: ffffc900025910c8
> PGD 100000067 P4D 100000067 PUD 10026b067 PMD 0
> Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 4 PID: 856 Comm: kworker/4:3 Not tainted 6.5.0-rc2+ #34
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:nexthop_select_path+0x197/0xbf0
> Code: c1 e4 05 be 08 00 00 00 4c 8b 35 a4 14 7e 01 4e 8d 6c 25 00 4a 8d 7c 25 08 48 01 dd e8 c2 25 15 ff 49 8d 7d 08 e8 39 13 15 ff <4d> 89 75 08 48 89 ef e8 7d 12 15 ff 48 8b 5d 00 e8 14 55 2f 00 85
> RSP: 0018:ffff88810c36f260 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000002000c0 RCX: ffffffffaf02dd77
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffc900025910c8
> RBP: ffffc900025910c0 R08: 0000000000000001 R09: fffff520004b2219
> R10: ffffc900025910cf R11: 31392d2068736168 R12: 00000000002000c0
> R13: ffffc900025910c0 R14: 00000000fffef608 R15: ffff88811840e900
> FS:  0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc900025910c8 CR3: 0000000129d00000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x1ee/0x5c0
>  ? __pfx_is_prefetch.constprop.0+0x10/0x10
>  ? __pfx_page_fault_oops+0x10/0x10
>  ? search_bpf_extables+0xfe/0x1c0
>  ? fixup_exception+0x3b/0x470
>  ? exc_page_fault+0xf6/0x110
>  ? asm_exc_page_fault+0x26/0x30
>  ? nexthop_select_path+0x197/0xbf0
>  ? nexthop_select_path+0x197/0xbf0
>  ? lock_is_held_type+0xe7/0x140
>  vxlan_xmit+0x5b2/0x2340
>  ? __lock_acquire+0x92b/0x3370
>  ? __pfx_vxlan_xmit+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx_register_lock_class+0x10/0x10
>  ? skb_network_protocol+0xce/0x2d0
>  ? dev_hard_start_xmit+0xca/0x350
>  ? __pfx_vxlan_xmit+0x10/0x10
>  dev_hard_start_xmit+0xca/0x350
>  __dev_queue_xmit+0x513/0x1e20
>  ? __pfx___dev_queue_xmit+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? mark_held_locks+0x44/0x90
>  ? skb_push+0x4c/0x80
>  ? eth_header+0x81/0xe0
>  ? __pfx_eth_header+0x10/0x10
>  ? neigh_resolve_output+0x215/0x310
>  ? ip6_finish_output2+0x2ba/0xc90
>  ip6_finish_output2+0x2ba/0xc90
>  ? lock_release+0x236/0x3e0
>  ? ip6_mtu+0xbb/0x240
>  ? __pfx_ip6_finish_output2+0x10/0x10
>  ? find_held_lock+0x83/0xa0
>  ? lock_is_held_type+0xe7/0x140
>  ip6_finish_output+0x1ee/0x780
>  ip6_output+0x138/0x460
>  ? __pfx_ip6_output+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx_ip6_finish_output+0x10/0x10
>  NF_HOOK.constprop.0+0xc0/0x420
>  ? __pfx_NF_HOOK.constprop.0+0x10/0x10
>  ? ndisc_send_skb+0x2c0/0x960
>  ? __pfx_lock_release+0x10/0x10
>  ? __local_bh_enable_ip+0x93/0x110
>  ? lock_is_held_type+0xe7/0x140
>  ndisc_send_skb+0x4be/0x960
>  ? __pfx_ndisc_send_skb+0x10/0x10
>  ? mark_held_locks+0x65/0x90
>  ? find_held_lock+0x83/0xa0
>  ndisc_send_ns+0xb0/0x110
>  ? __pfx_ndisc_send_ns+0x10/0x10
>  addrconf_dad_work+0x631/0x8e0
>  ? lock_acquire+0x180/0x3f0
>  ? __pfx_addrconf_dad_work+0x10/0x10
>  ? mark_held_locks+0x24/0x90
>  process_one_work+0x582/0x9c0
>  ? __pfx_process_one_work+0x10/0x10
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  ? mark_held_locks+0x24/0x90
>  worker_thread+0x93/0x630
>  ? __kthread_parkme+0xdc/0x100
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x1a5/0x1e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x60
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
> RIP: 0000:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> CR2: ffffc900025910c8
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:nexthop_select_path+0x197/0xbf0
> Code: c1 e4 05 be 08 00 00 00 4c 8b 35 a4 14 7e 01 4e 8d 6c 25 00 4a 8d 7c 25 08 48 01 dd e8 c2 25 15 ff 49 8d 7d 08 e8 39 13 15 ff <4d> 89 75 08 48 89 ef e8 7d 12 15 ff 48 8b 5d 00 e8 14 55 2f 00 85
> RSP: 0018:ffff88810c36f260 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000002000c0 RCX: ffffffffaf02dd77
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffc900025910c8
> RBP: ffffc900025910c0 R08: 0000000000000001 R09: fffff520004b2219
> R10: ffffc900025910cf R11: 31392d2068736168 R12: 00000000002000c0
> R13: ffffc900025910c0 R14: 00000000fffef608 R15: ffff88811840e900
> FS:  0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000129d00000 CR4: 0000000000750ee0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x2ca00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> Fix this problem by ensuring the MSB of hash is 0 using a right shift - the
> same approach used in fib_multipath_hash() and rt6_multipath_hash().
> 
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


