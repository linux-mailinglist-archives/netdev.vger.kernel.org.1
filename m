Return-Path: <netdev+bounces-45360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA387DC4B3
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B10D1C20A8E
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 03:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BFFA54;
	Tue, 31 Oct 2023 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEB524B
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 03:04:28 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29026A6;
	Mon, 30 Oct 2023 20:04:25 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvFmQjo_1698721454;
Received: from 30.221.149.157(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvFmQjo_1698721454)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 11:04:22 +0800
Message-ID: <947b7e7d-3b65-af4c-4583-04913f98b2d3@linux.alibaba.com>
Date: Tue, 31 Oct 2023 11:04:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 4/5] net/smc: protect connection state transitions in
 listen work
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-5-git-send-email-alibuda@linux.alibaba.com>
 <52133656-4dc6-4f32-9881-b63f19bb8859@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <52133656-4dc6-4f32-9881-b63f19bb8859@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/13/23 1:14 AM, Wenjia Zhang wrote:
>
>
> On 11.10.23 09:33, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> Consider the following scenario:
>>
>>                 smc_close_passive_work
>> smc_listen_out_connected
>>                 lock_sock()
>> if (state  == SMC_INIT)
>>                 if (state  == SMC_INIT)
>>                     state = SMC_APPCLOSEWAIT1;
>>     state = SMC_ACTIVE
>>                 release_sock()
>>
>> This would cause the state machine of the connection to be corrupted.
>> Also, this issue can occur in smc_listen_out_err().
>>
>> To solve this problem, we can protect the state transitions under
>> the lock of sock to avoid collision.
>>
> To this fix, I have to repeat the question from Alexandra.
> Did the scenario occur in real life? Or is it just kind of potencial 
> problem you found during the code review?
>

Hi Wenjia,

This is a real issue that occurred in our environment rather than being 
obtained from code reviews.
Unfortunately, since this patch does not cause panic, but rather 
potential reference leaks, so it is difficult for me
to provide a very intuitive error message.

> If it is the former one, could you please show us the corresponding 
> message, e.g. from dmesg? If it is the latter one, I'd like to deal 
> with it more carefully. Going from this scenario, I noticed that there 
> could also be other similar places where we need to make sure that no 
> race happens. Thus, it would make more sense to find a systematic 
> approach.
>

We agree that we should deal with it with more care, In fact, this issue 
is very complex and we may spend a lot of time discussing it. Therefore, 
I suggest that we can temporarily drop it
so that we can quickly accept the patch we have already agreed on. I 
will send those patches separately in the future.

Best Wishes,
D. Wythe

>> Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in 
>> af_smc")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 5ad2a9f..3bb8265 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1926,8 +1926,10 @@ static void smc_listen_out_connected(struct 
>> smc_sock *new_smc)
>>   {
>>       struct sock *newsmcsk = &new_smc->sk;
>>   +    lock_sock(newsmcsk);
>>       if (newsmcsk->sk_state == SMC_INIT)
>>           newsmcsk->sk_state = SMC_ACTIVE;
>> +    release_sock(newsmcsk);
>>         smc_listen_out(new_smc);
>>   }
>> @@ -1939,9 +1941,12 @@ static void smc_listen_out_err(struct smc_sock 
>> *new_smc)
>>       struct net *net = sock_net(newsmcsk);
>> this_cpu_inc(net->smc.smc_stats->srv_hshake_err_cnt);
>> +
>> +    lock_sock(newsmcsk);
>>       if (newsmcsk->sk_state == SMC_INIT)
>>           sock_put(&new_smc->sk); /* passive closing */
>>       newsmcsk->sk_state = SMC_CLOSED;
>> +    release_sock(newsmcsk);
>>         smc_listen_out(new_smc);
>>   }


