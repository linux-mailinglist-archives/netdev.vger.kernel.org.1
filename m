Return-Path: <netdev+bounces-42513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1A7CF150
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1A4281D4D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2BBD29B;
	Thu, 19 Oct 2023 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106658F64
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:33:11 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617809F;
	Thu, 19 Oct 2023 00:33:09 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuTArjW_1697700785;
Received: from 30.221.144.219(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VuTArjW_1697700785)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 15:33:06 +0800
Message-ID: <305c7ae2-a902-3e30-5e67-b590d848d0ba@linux.alibaba.com>
Date: Thu, 19 Oct 2023 15:33:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
 <bdcb307f-d2a8-4aef-bb7d-dd87e56ff740@linux.ibm.com>
 <ee641ca5-104b-d1ec-5b2a-e20237c5378a@linux.alibaba.com>
 <ad5e4191-227e-4a62-a110-472618ef7de1@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ad5e4191-227e-4a62-a110-472618ef7de1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/19/23 4:26 AM, Wenjia Zhang wrote:
>
>
> On 17.10.23 04:06, D. Wythe wrote:
>>
>>
>> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>>
>>>
>>> On 11.10.23 09:33, D. Wythe wrote:
>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>
>>>> Note that we always hold a reference to sock when attempting
>>>> to submit close_work. 
>>> yes
>>> Therefore, if we have successfully
>>>> canceled close_work from pending, we MUST release that reference
>>>> to avoid potential leaks.
>>>>
>>> Isn't the corresponding reference already released inside the 
>>> smc_close_passive_work()?
>>>
>>
>> Hi Wenjia,
>>
>> If we successfully cancel the close work from the pending state,
>> it means that smc_close_passive_work() has never been executed.
>>
>> You can find more details here.
>>
>> /**
>> * cancel_work_sync - cancel a work and wait for it to finish
>> * @work:the work to cancel
>> *
>> * Cancel @work and wait for its execution to finish. This function
>> * can be used even if the work re-queues itself or migrates to
>> * another workqueue. On return from this function, @work is
>> * guaranteed to be not pending or executing on any CPU.
>> *
>> * cancel_work_sync(&delayed_work->work) must not be used for
>> * delayed_work's. Use cancel_delayed_work_sync() instead.
>> *
>> * The caller must ensure that the workqueue on which @work was last
>> * queued can't be destroyed before this function returns.
>> *
>> * Return:
>> * %true if @work was pending, %false otherwise.
>> */
>> boolcancel_work_sync(structwork_struct *work)
>> {
>> return__cancel_work_timer(work, false);
>> }
>>
>> Best wishes,
>> D. Wythe
> As I understand, queue_work() would wake up the work if the work is 
> not already on the queue. And the sock_hold() is just prio to the 
> queue_work(). That means, cancel_work_sync() would cancel the work 
> either before its execution or after. If your fix refers to the former 
> case, at this moment, I don't think the reference can be hold, thus it 
> is unnecessary to put it.
>>

I am quite confuse about why you think when we cancel the work before 
its execution,
the reference can not be hold ?


Perhaps the following diagram can describe the problem in better way :

smc_close_cancel_work
smc_cdc_msg_recv_action


sock_hold
queue_work
                                                                if 
(cancel_work_sync())        // successfully cancel before execution
sock_put()                        //  need to put it since we already 
hold a ref before   queue_work()


>>>> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link 
>>>> groups")
>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>> ---
>>>>   net/smc/smc_close.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>>> index 449ef45..10219f5 100644
>>>> --- a/net/smc/smc_close.c
>>>> +++ b/net/smc/smc_close.c
>>>> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct 
>>>> smc_sock *smc)
>>>>       struct sock *sk = &smc->sk;
>>>>         release_sock(sk);
>>>> -    cancel_work_sync(&smc->conn.close_work);
>>>> +    if (cancel_work_sync(&smc->conn.close_work))
>>>> +        sock_put(sk);
>>>>       cancel_delayed_work_sync(&smc->conn.tx_work);
>>>>       lock_sock(sk);
>>>>   }
>>


