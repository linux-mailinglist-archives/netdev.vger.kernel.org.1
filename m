Return-Path: <netdev+bounces-27350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4177B920
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5161C2099B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25FCBA4C;
	Mon, 14 Aug 2023 12:58:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A65BA36
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:58:31 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB61D7;
	Mon, 14 Aug 2023 05:58:29 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPZDP4y1xz1GDZS;
	Mon, 14 Aug 2023 20:57:09 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 20:58:26 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <fw@strlen.de>
CC: <leon@kernel.org>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <timo.teras@iki.fi>,
	<yuehaibing@huawei.com>, <weiyongjun1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: xfrm: skip policies marked as dead while reinserting policies
Date: Mon, 14 Aug 2023 20:58:25 +0800
Message-ID: <20230814113034.GB7324@breakpoint.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814013352.2771452-1-dongchenchen2@huawei.com>
References: <20230814013352.2771452-1-dongchenchen2@huawei.com>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected

Dong Chenchen <dongchenchen2@huawei.com> wrote:
>> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
>> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
>> 
>> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x72/0xa0
>>  print_report+0xd0/0x620
>>  kasan_report+0xb6/0xf0
>>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
>>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
>>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
>>  xfrm_policy_inexact_insert+0x6b/0x590
>>  xfrm_policy_insert+0x3b1/0x480
>>  xfrm_add_policy+0x23c/0x3c0
>>  xfrm_user_rcv_msg+0x2d0/0x510
>>  netlink_rcv_skb+0x10d/0x2d0
>>  xfrm_netlink_rcv+0x49/0x60
>>  netlink_unicast+0x3fe/0x540
>>  netlink_sendmsg+0x528/0x970
>>  sock_sendmsg+0x14a/0x160
>>  ____sys_sendmsg+0x4fc/0x580
>>  ___sys_sendmsg+0xef/0x160
>>  __sys_sendmsg+0xf7/0x1b0
>>  do_syscall_64+0x3f/0x90
>>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
>> 
>> The root cause is:
>> 
>> cpu 0			cpu1
>> xfrm_dump_policy
>> xfrm_policy_walk
>> list_move_tail
>> 			xfrm_add_policy
>> 			... ...
>> 			xfrm_policy_inexact_list_reinsert
>> 			list_for_each_entry_reverse
>> 				if (!policy->bydst_reinsert)
>> 				//read non-existent policy
>> xfrm_dump_policy_done
>> xfrm_policy_walk_done
>> list_del(&walk->walk.all);
>> 
>> If dump_one_policy() returns err (triggered by netlink socket),
>> xfrm_policy_walk() will move walk initialized by socket to list
>> net->xfrm.policy_all. so this socket becomes visible in the global
>> policy list. The head *walk can be traversed when users add policies
>> with different prefixlen and trigger xfrm_policy node merge.
>> 
>> It can be fixed by skip such "policies" with walk.dead set to 1.
>> 
>> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
>> Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>> ---
>>  net/xfrm/xfrm_policy.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
>> index d6b405782b63..5b56faad78e0 100644
>> --- a/net/xfrm/xfrm_policy.c
>> +++ b/net/xfrm/xfrm_policy.c
>> @@ -848,6 +848,9 @@ static void xfrm_policy_inexact_list_reinsert(struct net *net,
>>  	matched_d = 0;
>>  
>>  	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
>> +		if (policy->walk.dead)
>> +			continue;
>> +
>
>Looks like we have other places that might trigger a splat, e.g.:
>
>1816 int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
>..
>1827 again:
>1828         list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
>1829                 dir = xfrm_policy_id2dir(pol->index);
>1830                 if (pol->walk.dead ||
>1831                     dir >= XFRM_POLICY_MAX ||
>
>'walker' has no pol->index, so I suspect this would trigger a kasan splat as well,
>this needs to check walk.dead before access to pol->index.
Yes, you are right. xfrm_hash_rebuild(),xfrm_dev_policy_flush() might also trigger
similar bug. xfrm_policy_walk() add "walker" to list tail and these func use 
list_for_each_entry() to traverse list.So it is unlikely to trigger the bug.

But there's still possible, i will fix it in v2.

Thanks!

