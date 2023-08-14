Return-Path: <netdev+bounces-27235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D777B202
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE246280FB7
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702F6ABC;
	Mon, 14 Aug 2023 07:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1B5C98
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6D9C433C8;
	Mon, 14 Aug 2023 07:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691996633;
	bh=DM+JJ+ZGmtq8OUU4oXT6tfyiRynncn7hCNTgM2YToBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toQyCX7JDXh/jjcEqfp3wE2tJMtqiO7Mxq3ZSWW1GnhyOUT6KHg0w6ZYV33xpDcGJ
	 qleCwVZIxX3+pEdlf6XqwBx2zqxbD6Ym2+m9y3zIBwKe2PVDPvbQ6DixnUMT81iUQf
	 8b5RUFKyjZRYO6lh/9lQl19vtk54qK8DMmponoehz4EoXlUwrjq6jIWh+7i8Ifs2fm
	 Ys7xWdnl/Bk9GkIxa4LaOzK9bEGlI+GC+MScMVR2+Noa0sjm8FdB2O8OuQwKdNnwiU
	 bk2XI8NvZ3pSlG8czOMETG6HDktYd6oIo3B8na2pzovZ29j2kQfIZCq/PMZ9693hTa
	 oSAkDJ2Ij+3jQ==
Date: Mon, 14 Aug 2023 10:03:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, fw@strlen.de, timo.teras@iki.fi,
	yuehaibing@huawei.com, weiyongjun1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230814070349.GA3921@unreal>
References: <20230814013352.2771452-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814013352.2771452-1-dongchenchen2@huawei.com>

On Mon, Aug 14, 2023 at 09:33:52AM +0800, Dong Chenchen wrote:
> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
> 
> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x72/0xa0
>  print_report+0xd0/0x620
>  kasan_report+0xb6/0xf0
>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
>  xfrm_policy_inexact_insert+0x6b/0x590
>  xfrm_policy_insert+0x3b1/0x480
>  xfrm_add_policy+0x23c/0x3c0
>  xfrm_user_rcv_msg+0x2d0/0x510
>  netlink_rcv_skb+0x10d/0x2d0
>  xfrm_netlink_rcv+0x49/0x60
>  netlink_unicast+0x3fe/0x540
>  netlink_sendmsg+0x528/0x970
>  sock_sendmsg+0x14a/0x160
>  ____sys_sendmsg+0x4fc/0x580
>  ___sys_sendmsg+0xef/0x160
>  __sys_sendmsg+0xf7/0x1b0
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> 
> The root cause is:
> 
> cpu 0			cpu1
> xfrm_dump_policy
> xfrm_policy_walk
> list_move_tail
> 			xfrm_add_policy
> 			... ...
> 			xfrm_policy_inexact_list_reinsert
> 			list_for_each_entry_reverse
> 				if (!policy->bydst_reinsert)
> 				//read non-existent policy
> xfrm_dump_policy_done
> xfrm_policy_walk_done
> list_del(&walk->walk.all);
> 
> If dump_one_policy() returns err (triggered by netlink socket),
> xfrm_policy_walk() will move walk initialized by socket to list
> net->xfrm.policy_all. so this socket becomes visible in the global
> policy list. The head *walk can be traversed when users add policies
> with different prefixlen and trigger xfrm_policy node merge.
> 
> It can be fixed by skip such "policies" with walk.dead set to 1.

But where in the xfrm_dump_policy() flow, these policies are becoming to
be walk.dead == 1?

Thanks

> 
> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
> Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  net/xfrm/xfrm_policy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index d6b405782b63..5b56faad78e0 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -848,6 +848,9 @@ static void xfrm_policy_inexact_list_reinsert(struct net *net,
>  	matched_d = 0;
>  
>  	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
> +		if (policy->walk.dead)
> +			continue;
> +
>  		struct hlist_node *newpos = NULL;
>  		bool matches_s, matches_d;
>  
> -- 
> 2.25.1
> 
> 

