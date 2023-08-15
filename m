Return-Path: <netdev+bounces-27755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7D77D19E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DC61C20DDD
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1E17ACA;
	Tue, 15 Aug 2023 18:19:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EA13AFD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6BC433C8;
	Tue, 15 Aug 2023 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123585;
	bh=LxisV8f2urtyHho0Fhd/EnDIivuMoVIqPDjpt7QMK1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slGkrHpCW+Oh6UeFJMyeu7b3M/KFMnj5spDl+fP0Y5RDiD6p8xYwcCtUU5yWd7tpv
	 Ai4orLB88U//sLXlBcCFD+zxFY35uCtpJswChaPySCIjdRnVtMnXqSldsr73LpzGFG
	 JbHTWJCwch+q3nOdcyMl0zceHZu3y94i0JRwsoluWdP+i4GADrv+f7YHg7iMLvtTju
	 IhjJvp/rERQmDAmZC6SnZPA9+K6nnDOjqrfeTHF4d8ut3eFHrAwYeag33HOjinA/rj
	 otBACCG9jNEPG/hjZQQRJP33jonXTjAXTKDnWd5oZgXXb0N+Y03wlDwopytXuLfKgn
	 8Y8Tevo/Hw3jw==
Date: Tue, 15 Aug 2023 21:19:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: fw@strlen.de, steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, timo.teras@iki.fi, yuehaibing@huawei.com,
	weiyongjun1@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815181940.GO22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815091324.GL22185@unreal>
 <20230815123233.GM22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815123233.GM22185@unreal>

On Tue, Aug 15, 2023 at 09:43:28PM +0800, Dong Chenchen wrote:
> On Tue, Aug 15, 2023 at 07:35:13PM +0800, Dong Chenchen wrote:
> >> >> The walker object initialized by xfrm_policy_walk_init() doesnt have policy. 
> >> >> list_for_each_entry() will use the walker offset to calculate policy address.
> >> >> It's nonexistent and different from invalid dead policy. It will read memory 
> >> >> that doesnt belong to walker if dereference policy->index.
> >> >> I think we should protect the memory.
> >> >
> >> >But all operations here are an outcome of "list_for_each_entry(policy,
> >> >&net->xfrm.policy_all, walk.all)" which stores in policy iterator
> >> >the pointer to struct xfrm_policy.
> >> >
> >> >How at the same time access to policy->walk.dead is valid while
> >> >policy->index is not?
> >> >
> >> >Thanks
> >> 1.walker init: its only a list head, no policy
> >> xfrm_dump_policy_start
> >> 	xfrm_policy_walk_init(walk, XFRM_POLICY_TYPE_ANY);
> >> 		INIT_LIST_HEAD(&walk->walk.all);
> >> 		walk->walk.dead = 1;
> >> 
> >> 2.add the walk head to net->xfrm.policy_all
> >> xfrm_policy_walk
> >>     list_for_each_entry_from(x, &net->xfrm.policy_all, all)
> >> 	if (error) {
> >> 		list_move_tail(&walk->walk.all, &x->all);
> >> 		//add the walk to list tail
> >> 
> >> 3.traverse the walk list
> >> xfrm_policy_flush
> >> list_for_each_entry(pol, &net->xfrm.policy_all, walk.all)
> >> 	 dir = xfrm_policy_id2dir(pol->index);
> >> 
> >> it gets policy by &net->xfrm.policy_all-0x130(offset of walk in policy)
> >> but when walk is head, we will read others memory by the calculated policy.
> >> such as:
> >>   walk addr  		policy addr
> >> 0xffff0000d7f3b530    0xffff0000d7f3b400 (non-existent) 
> >> 
> >> head walker of net->xfrm.policy_all can be skipped by  list_for_each_entry().
> >> but the walker created by socket is located list tail. so we should skip it. 
> >
> >list_for_each_entry_from(x, &net->xfrm.policy_all, all) gives you
> >pointer to "x", you can't access some of its fields and say they
> >exist and other doesn't. Once you can call to "x->...", you can 
> >call to "x->index" too.
> >
> >Thanks
> We get a pointer addr not actual variable from list_for_each_entry_from(),
> that calculated by walk address dec offset from struct xfrm_policy(0x130).

The thing is that you must get valid addr pointer and not some random
memory address.

> 
> walk addr: 0xffff0000d7f3b530 //allocated by socket, valid
> -> dec 0x130 (use macro container_of)
> policy_addr:0xffff0000d7f3b400 //only a pointer addr
> -> add 0x130 
> policy->walk:0xffff0000d7f3b530 //its still walker head
> 
> I think its invalid to read policy->index from memory that maybe allocated
> by other user.

This is not how pointers are expected to be used. Once you have pointer
to the struct, the expectation is that all fields in that struct are
accessible.

Anyway, we discussed this topic a lot.

Thanks

> 
> Thanks!
> Dong Chenchen
> 

