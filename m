Return-Path: <netdev+bounces-27682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AC77CD76
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F151C20D1F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554312B67;
	Tue, 15 Aug 2023 13:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2258832
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:43:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC019199A;
	Tue, 15 Aug 2023 06:43:32 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQC921v0szVk3h;
	Tue, 15 Aug 2023 21:41:26 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:43:29 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <leon@kernel.org>
CC: <fw@strlen.de>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <timo.teras@iki.fi>,
	<yuehaibing@huawei.com>, <weiyongjun1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while reinserting policies
Date: Tue, 15 Aug 2023 21:43:28 +0800
Message-ID: <20230815123233.GM22185@unreal>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815091324.GL22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com> <20230815060026.GE22185@unreal> <20230815091324.GL22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 07:35:13PM +0800, Dong Chenchen wrote:
>> >> The walker object initialized by xfrm_policy_walk_init() doesnt have policy. 
>> >> list_for_each_entry() will use the walker offset to calculate policy address.
>> >> It's nonexistent and different from invalid dead policy. It will read memory 
>> >> that doesnt belong to walker if dereference policy->index.
>> >> I think we should protect the memory.
>> >
>> >But all operations here are an outcome of "list_for_each_entry(policy,
>> >&net->xfrm.policy_all, walk.all)" which stores in policy iterator
>> >the pointer to struct xfrm_policy.
>> >
>> >How at the same time access to policy->walk.dead is valid while
>> >policy->index is not?
>> >
>> >Thanks
>> 1.walker init: its only a list head, no policy
>> xfrm_dump_policy_start
>> 	xfrm_policy_walk_init(walk, XFRM_POLICY_TYPE_ANY);
>> 		INIT_LIST_HEAD(&walk->walk.all);
>> 		walk->walk.dead = 1;
>> 
>> 2.add the walk head to net->xfrm.policy_all
>> xfrm_policy_walk
>>     list_for_each_entry_from(x, &net->xfrm.policy_all, all)
>> 	if (error) {
>> 		list_move_tail(&walk->walk.all, &x->all);
>> 		//add the walk to list tail
>> 
>> 3.traverse the walk list
>> xfrm_policy_flush
>> list_for_each_entry(pol, &net->xfrm.policy_all, walk.all)
>> 	 dir = xfrm_policy_id2dir(pol->index);
>> 
>> it gets policy by &net->xfrm.policy_all-0x130(offset of walk in policy)
>> but when walk is head, we will read others memory by the calculated policy.
>> such as:
>>   walk addr  		policy addr
>> 0xffff0000d7f3b530    0xffff0000d7f3b400 (non-existent) 
>> 
>> head walker of net->xfrm.policy_all can be skipped by  list_for_each_entry().
>> but the walker created by socket is located list tail. so we should skip it. 
>
>list_for_each_entry_from(x, &net->xfrm.policy_all, all) gives you
>pointer to "x", you can't access some of its fields and say they
>exist and other doesn't. Once you can call to "x->...", you can 
>call to "x->index" too.
>
>Thanks
We get a pointer addr not actual variable from list_for_each_entry_from(),
that calculated by walk address dec offset from struct xfrm_policy(0x130).

walk addr: 0xffff0000d7f3b530 //allocated by socket, valid
-> dec 0x130 (use macro container_of)
policy_addr:0xffff0000d7f3b400 //only a pointer addr
-> add 0x130 
policy->walk:0xffff0000d7f3b530 //its still walker head

I think its invalid to read policy->index from memory that maybe allocated
by other user.

Thanks!
Dong Chenchen

