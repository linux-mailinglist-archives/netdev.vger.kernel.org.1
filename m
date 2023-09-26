Return-Path: <netdev+bounces-36200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB27AE3E1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 05:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E2AB71F25236
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F851102;
	Tue, 26 Sep 2023 03:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C47F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 03:01:02 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44044FF;
	Mon, 25 Sep 2023 20:00:59 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VsvCxfb_1695697255;
Received: from 30.221.147.7(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VsvCxfb_1695697255)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 11:00:56 +0800
Message-ID: <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
Date: Tue, 26 Sep 2023 11:00:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Content-Language: en-US
To: Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
 <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 5:43 PM, Alexandra Winter wrote:
> On 25.09.23 10:29, D. Wythe wrote:
>> Hi Wenjia,
>>
>>> this is unfortunately not sufficient for this fix. You have to make sure that is not a life-time problem. Even so, READ_ONCE() is also needed in this case.
>>>
>> Life-time problem? If you means the smc will still be NULL in the future,  I don't really think so, smc is a local variable assigned by smc_clcsock_user_data.
>> it's either NULL or a valid and unchanged value.
>>
>> And READ_ONCE() is needed indeed, considering not make too much change, maybe we can protected following
> The local variable smc is a pointer to the smc_sock structure, so the question is whether you can just do a READ_ONCE
> and then continue to use the content of the smc_sock structure, even though e.g. a smc_close_active() may be going on in
> parallel.
>
>> smc = smc_clcsock_user_data(sk);
>>
>> with sk_callback_lock， which solves the same problem. What do you think?
> In af_ops.syn_recv_sock() and thus also in smc_tcp_syn_recv_sock()
> sk is defined as const. So you cannot simply do take sk_callback_lock, that will create compiler errors.
>   (same for smc_hs_congested() BTW)
>
> If you are sure the contents of *smc are always valid, then READ_ONCE is all you need.


Hi Alexandra,

You are right. The key point is how to ensure the valid of smc sock 
during the life time of clc sock, If so, READ_ONCE is good
enough. Unfortunately, I found  that there are no such guarantee, so 
it's still a life-time problem.  Considering the const, maybe
we need to do :

1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock valid 
during life time of clc sock
2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release the 
very smc sock .

In that way, we can always make sure the valid of smc sock during the 
life time of clc sock. Then we can use READ_ONCE rather
than lock.  What do you think ?

> Maybe it is better to take a step back and consider what needs to be protected when (lifetime).
> Just some thoughts (there may be ramifications that I am not aware of):
> Maybe clcsock->sk->sk_user_data could be set to point to smc_sock as soon as the clc socket is created?
> Isn't the smc socket always valid as long as the clc socket exists?
> Then sk_user_data would no longer indicate whether the callback functions were set to smc values, but would that matter?
> Are there scenarios where it matters whether the old or the new callback function is called?
> Why are the values restored in smc_close_active() if the clc socket is released shortly after anyhow?

That's a good question, We have discussed internally and found that this 
is indeed possible. We can completely not to unset sk_user_data,
which can reduce many unnecessary judgments and locks, and no side 
effects found. We will try this approach internally and conduct multiple
rounds of testing. However, in any case, returning to the initial issue, 
the prerequisite for everything is to ensure the valid of smc sock
during the life time of clc sock. So we must have a mechanism to work it 
out. and holding referenced solutions might be a good try, what do you
think?

Best Wishes,
D. Wythe




