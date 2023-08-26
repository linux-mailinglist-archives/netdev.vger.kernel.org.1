Return-Path: <netdev+bounces-30860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BBD789492
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D95C28197F
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB91371;
	Sat, 26 Aug 2023 07:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D210F5
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 07:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D2DC433C7;
	Sat, 26 Aug 2023 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693036666;
	bh=s5UFF6YdVTUzLTpts9iidYKRQGA4rnxTrUx4AVS1eNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czasA/TWa0axRcpv4fCRzdo2mSn9QVvP7C1EJhqCpP/TTbxruqgfuBzc2HV462x1Y
	 qdENlbLRGTY87aws09om8gEg/0lD4h86NNckAYWhT91zHlM0yAur8vn9edb0shiHtM
	 O/dBWrVZU4fSq3rWEGLuy9l7za8QxXTLnxjRroAvaigdrBZnYO39k72Dg7sqqb0+eT
	 etdNdtt0cfE8AjuQ33UoTn7ckc2r99RMUTPrUbG6bVeo9K3tQX4nLlJJYfpcCvsdcd
	 q78qzlIhlYTCxv1BF0bwepoAJBcQ8seGkxGzQ/6Tje6AOHnoDbSdmD/H4axA4ZBjv1
	 JmjHhnOFICf5A==
Date: Sat, 26 Aug 2023 09:57:40 +0200
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, gal@nvidia.com, martin.lau@linux.dev
Subject: Re: [PATCH net-next 1/2] net: Fix skb consume leak in
 sch_handle_egress
Message-ID: <20230826075740.GO3523530@kernel.org>
References: <20230825134946.31083-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825134946.31083-1-daniel@iogearbox.net>

On Fri, Aug 25, 2023 at 03:49:45PM +0200, Daniel Borkmann wrote:
> Fix a memory leak for the tc egress path with TC_ACT_{STOLEN,QUEUED,TRAP}:
> 
>   [...]
>   unreferenced object 0xffff88818bcb4f00 (size 232):
>   comm "softirq", pid 0, jiffies 4299085078 (age 134.028s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 80 70 61 81 88 ff ff 00 41 31 14 81 88 ff ff  ..pa.....A1.....
>   backtrace:
>     [<ffffffff9991b938>] kmem_cache_alloc_node+0x268/0x400
>     [<ffffffff9b3d9231>] __alloc_skb+0x211/0x2c0
>     [<ffffffff9b3f0c7e>] alloc_skb_with_frags+0xbe/0x6b0
>     [<ffffffff9b3bf9a9>] sock_alloc_send_pskb+0x6a9/0x870
>     [<ffffffff9b6b3f00>] __ip_append_data+0x14d0/0x3bf0
>     [<ffffffff9b6ba24e>] ip_append_data+0xee/0x190
>     [<ffffffff9b7e1496>] icmp_push_reply+0xa6/0x470
>     [<ffffffff9b7e4030>] icmp_reply+0x900/0xa00
>     [<ffffffff9b7e42e3>] icmp_echo.part.0+0x1a3/0x230
>     [<ffffffff9b7e444d>] icmp_echo+0xcd/0x190
>     [<ffffffff9b7e9566>] icmp_rcv+0x806/0xe10
>     [<ffffffff9b699bd1>] ip_protocol_deliver_rcu+0x351/0x3d0
>     [<ffffffff9b699f14>] ip_local_deliver_finish+0x2b4/0x450
>     [<ffffffff9b69a234>] ip_local_deliver+0x174/0x1f0
>     [<ffffffff9b69a4b2>] ip_sublist_rcv_finish+0x1f2/0x420
>     [<ffffffff9b69ab56>] ip_sublist_rcv+0x466/0x920
>   [...]
> 
> I was able to reproduce this via:
> 
>   ip link add dev dummy0 type dummy
>   ip link set dev dummy0 up
>   tc qdisc add dev eth0 clsact
>   tc filter add dev eth0 egress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress redirect dev dummy0
>   ping 1.1.1.1
>   <stolen>
> 
> After the fix, there are no kmemleak reports with the reproducer. This is
> in line with what is also done on the ingress side, and from debugging the
> skb_unref(skb) on dummy xmit and sch_handle_egress() side, it is visible
> that these are two different skbs with both skb_unref(skb) as true. The two
> seen skbs are due to mirred doing a skb_clone() internally as use_reinsert
> is false in tcf_mirred_act() for egress. This was initially reported by Gal.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com

Reviewed-by: Simon Horman <horms@kernel.org>


