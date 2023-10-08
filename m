Return-Path: <netdev+bounces-38881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D07BCD32
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA041281997
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAE8BE8;
	Sun,  8 Oct 2023 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645128472
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 08:23:08 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB1C6;
	Sun,  8 Oct 2023 01:23:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VtdcqcW_1696753375;
Received: from 30.221.145.250(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VtdcqcW_1696753375)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 16:23:02 +0800
Message-ID: <3e41f49d-abec-34b4-283b-7ad4bbff3b41@linux.alibaba.com>
Date: Sun, 8 Oct 2023 16:22:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>
Cc: jaka@linux.ibm.com, kgraul@linux.ibm.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
 <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
 <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
 <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
 <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
 <b4470cec-7b9b-5ce5-01e0-9270f6564fbb@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <b4470cec-7b9b-5ce5-01e0-9270f6564fbb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 2:14 AM, Wenjia Zhang wrote:
>
>
> On 26.09.23 11:06, D. Wythe wrote:
>>
>>
>> On 9/26/23 3:18 PM, Alexandra Winter wrote:
>>>
>>> On 26.09.23 05:00, D. Wythe wrote:
>>>> You are right. The key point is how to ensure the valid of smc sock 
>>>> during the life time of clc sock, If so, READ_ONCE is good
>>>> enough. Unfortunately, I found  that there are no such guarantee, 
>>>> so it's still a life-time problem.
>>> Did you discover a scenario, where clc sock could live longer than 
>>> smc sock?
>>> Wouldn't that be a dangerous scenario in itself? I still have some 
>>> hope that the lifetime of an smc socket is by design longer
>>> than that of the corresponding tcp socket.
>>
>>
>> Hi Alexandra,
>>
>> Yes there is. Considering scenario:
>>
>> tcp_v4_rcv(skb)
>>
>> /* req sock */
>> reqsk = _inet_lookup_skb(skb)
>>
>> /* listen sock */
>> sk = reqsk(reqsk)->rsk_listener;
>> sock_hold(sk);
>> tcp_check_req(sk)
>>
>>
>>                                                  smc_release /* 
>> release smc listen sock */
>>                                                  __smc_release
>> smc_close_active()         /*  smc_sk->sk_state = SMC_CLOSED; */
>>                                                      if 
>> (smc_sk->sk_state == SMC_CLOSED)
>> smc_clcsock_release();
>> sock_release(clcsk);        /* close clcsock */
>>      sock_put(sk);              /* might not  the final refcnt */
>>
>> sock_put(smc_sk)    /* might be the final refcnt of smc_sock  */
>>
>> syn_recv_sock(sk...)
>> /* might be the final refcnt of tcp listen sock */
>> sock_put(sk);
>>
>> Fortunately, this scenario only affects smc_syn_recv_sock and 
>> smc_hs_congested, as other callbacks already have locks to protect smc,
>> which can guarantee that the sk_user_data is either NULL (set in 
>> smc_close_active) or valid under the lock.
>> I'm kind of confused with this scenario. How could the 
> smc_clcsock_release()->sock_release(clcsk) happen?
> Because the syn_recv_sock happens short prior to accept(), that means 
> that the &smc->tcp_listen_work is already triggered but the real 
> accept() is still not happening. At this moment, the incoming 
> connection is being added into the accept queue. Thus, if the 
> sk->sk_state is changed from SMC_LISTEN to SMC_CLOSED in 
> smc_close_active(), there is still 
> "flush_work(&smc->tcp_listen_work);" after that. That ensures the 
> smc_clcsock_release() should not happen, if smc_clcsock_accept() is 
> not finished. Do you think that the execution of the 
> &smc->tcp_listen_work is already done? Or am I missing something?
>
Hi wenjia,

Sorry for late reply, we have just returned from vacation.

The smc_clcsock_release here release the listen clcsock rather than the 
child clcsock.
So the flush_work might not be helpful for this scenario.

Best wishes,
D. Wythe


>>> Considering the const, maybe
>>>> we need to do :
>>>>
>>>> 1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock 
>>>> valid during life time of clc sock
>>>> 2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release 
>>>> the very smc sock .
>>>>
>>>> In that way, we can always make sure the valid of smc sock during 
>>>> the life time of clc sock. Then we can use READ_ONCE rather
>>>> than lock.  What do you think ?
>>> I am not sure I fully understand the details what you propose to do. 
>>> And it is not only syn_recv_sock(), right?
>>> You need to consider all relations between smc socks and tcp socks; 
>>> fallback to tcp, initial creation, children of listen sockets, 
>>> variants of shutdown, ... Preferrably a single simple mechanism 
>>> covers all situations. Maybe there is such a mechanism already today?
>>> (I don't think clcsock->sk->sk_user_data or sk_callback_lock provide 
>>> this general coverage)
>>> If we really have a gap, a general refcnt'ing on smc sock could be a 
>>> solution, but needs to be designed carefully.
>>
>> You are right , we need designed it with care, we will try the 
>> referenced solutions internally first, and I will also send some RFCs 
>> so that everyone can track the latest progress
>> and make it can be all agreed.
>>> Many thanks to you and the team to help make smc more stable and 
>>> robust.
>>
>> Our pleasure 😁.  The stability of smc is important to us too.
>>
>> Best wishes,
>> D. Wythe
>>
>>


