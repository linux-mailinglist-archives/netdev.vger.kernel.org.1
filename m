Return-Path: <netdev+bounces-27636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7377CA19
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DA21C20C83
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A536CA72;
	Tue, 15 Aug 2023 09:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6BAD2E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936E8C433C7;
	Tue, 15 Aug 2023 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692090809;
	bh=eV1YTMJMzlnIU4HCb9/vrK3w7/XNJSy/N3IcgaVrgEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TN2ea5MEpMjTVPbWwxxp09WOwY2Uz2jgYf8okq7Ls2Y0S9sbyjC9b1ZGnLXNQu/lP
	 qjMstjy+ahUvg29NCDV8cypxP4GuhOPGVbZ8DjzesBH2b3G3hNgsDgINb3TUtA7qWr
	 nENpOilt6SQmt2Sbb66sYWBbFZuZms9750SSHYVPa/28UXEYv5aGUEYZAjQyvG6woa
	 Tfq9J+Tm8yjBeTa2HoO2VG44Ym7BmubVWdi0RGZD+9RCsbAr+xzCZi3jQsezQ1UVMb
	 nGtKXfC15QiXdiTSKg/glvwTNGWPkwyXXH6XaapU5uKO1Db6txwlOyGN8BWjct9GnH
	 cGKg3UR1sgMqA==
Date: Tue, 15 Aug 2023 12:13:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: fw@strlen.de, steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, timo.teras@iki.fi, yuehaibing@huawei.com,
	weiyongjun1@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815091324.GL22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060026.GE22185@unreal>

On Tue, Aug 15, 2023 at 04:47:58PM +0800, Dong Chenchen wrote:
> On Mon, Aug 14, 2023 at 10:00:13PM +0800, Dong Chenchen wrote:
> >> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
> >> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
> >> 
> >> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
> >> Call Trace:
> >>  <TASK>
> >>  dump_stack_lvl+0x72/0xa0
> >>  print_report+0xd0/0x620
> >>  kasan_report+0xb6/0xf0
> >>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
> >>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
> >>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
> >>  xfrm_policy_inexact_insert+0x6b/0x590
> >>  xfrm_policy_insert+0x3b1/0x480
> >>  xfrm_add_policy+0x23c/0x3c0
> >>  xfrm_user_rcv_msg+0x2d0/0x510
> >>  netlink_rcv_skb+0x10d/0x2d0
> >>  xfrm_netlink_rcv+0x49/0x60
> >>  netlink_unicast+0x3fe/0x540
> >>  netlink_sendmsg+0x528/0x970
> >>  sock_sendmsg+0x14a/0x160
> >>  ____sys_sendmsg+0x4fc/0x580
> >>  ___sys_sendmsg+0xef/0x160
> >>  __sys_sendmsg+0xf7/0x1b0
> >>  do_syscall_64+0x3f/0x90
> >>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> >> 
> >> The root cause is:
> >> 
> >> cpu 0			cpu1
> >> xfrm_dump_policy
> >> xfrm_policy_walk
> >> list_move_tail
> >> 			xfrm_add_policy
> >> 			... ...
> >> 			xfrm_policy_inexact_list_reinsert
> >> 			list_for_each_entry_reverse
> >> 				if (!policy->bydst_reinsert)
> >> 				//read non-existent policy
> >> xfrm_dump_policy_done
> >> xfrm_policy_walk_done
> >> list_del(&walk->walk.all);
> >> 
> >> If dump_one_policy() returns err (triggered by netlink socket),
> >> xfrm_policy_walk() will move walk initialized by socket to list
> >> net->xfrm.policy_all. so this socket becomes visible in the global
> >> policy list. The head *walk can be traversed when users add policies
> >> with different prefixlen and trigger xfrm_policy node merge.
> >> 
> >> The issue can also be triggered by policy list traversal while rehashing
> >> and flushing policies.
> >> 
> >> It can be fixed by skip such "policies" with walk.dead set to 1.
> >> 
> >> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
> >> Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
> >> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> >> ---
> >> v2: fix similiar similar while rehashing and flushing policies
> >> ---
> >>  net/xfrm/xfrm_policy.c | 20 +++++++++++++++-----
> >>  1 file changed, 15 insertions(+), 5 deletions(-)

<...>

> >> @@ -1253,11 +1256,14 @@ static void xfrm_hash_rebuild(struct work_struct *work)
> >>  	 * we start with destructive action.
> >>  	 */
> >>  	list_for_each_entry(policy, &net->xfrm.policy_all, walk.all) {
> >> +		if (policy->walk.dead)
> >> +			continue;
> >> +
> >>  		struct xfrm_pol_inexact_bin *bin;
> >>  		u8 dbits, sbits;
> >
> >Same comment as above.
> >
> >>  
> >>  		dir = xfrm_policy_id2dir(policy->index);
> >> -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> >> +		if (dir >= XFRM_POLICY_MAX)
> >
> >This change is unnecessary, previous code was perfectly fine.
> >
> The walker object initialized by xfrm_policy_walk_init() doesnt have policy. 
> list_for_each_entry() will use the walker offset to calculate policy address.
> It's nonexistent and different from invalid dead policy. It will read memory 
> that doesnt belong to walker if dereference policy->index.
> I think we should protect the memory.

But all operations here are an outcome of "list_for_each_entry(policy,
&net->xfrm.policy_all, walk.all)" which stores in policy iterator
the pointer to struct xfrm_policy.

How at the same time access to policy->walk.dead is valid while
policy->index is not?

Thanks

