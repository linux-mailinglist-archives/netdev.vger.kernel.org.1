Return-Path: <netdev+bounces-49685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C177F310E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E7128383B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B538F90;
	Tue, 21 Nov 2023 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E4BA
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:36:11 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SZRdW0jJCzMnG4;
	Tue, 21 Nov 2023 22:31:27 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 22:36:09 +0800
Message-ID: <e3488110-e3c2-49cd-401b-a6ef51a79f9d@huawei.com>
Date: Tue, 21 Nov 2023 22:36:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] ipv4: igmp: fix refcnt uaf issue when receiving igmp
 query packet
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231121020558.240321-1-shaozhengchao@huawei.com>
 <ZVwcWmg5NtuTSV7q@Laptop-X1>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZVwcWmg5NtuTSV7q@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/21 10:56, Hangbin Liu wrote:
> Hi Zhengchao,
> On Tue, Nov 21, 2023 at 10:05:58AM +0800, Zhengchao Shao wrote:
>> ---
>>   net/ipv4/igmp.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
>> index 76c3ea75b8dd..f217581904d6 100644
>> --- a/net/ipv4/igmp.c
>> +++ b/net/ipv4/igmp.c
>> @@ -1044,6 +1044,8 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>>   	for_each_pmc_rcu(in_dev, im) {
>>   		int changed;
>>   
>> +		if (!netif_running(im->interface->dev))
>> +			continue;
> 
> I haven't checked this part for a long time. What's the difference of in_dev->dev
> and im->interface->dev? I though they are the same, no?
> 
> If they are the same, should we stop processing the query earlier? e.g.
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 76c3ea75b8dd..f4e1d229c9aa 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1082,6 +1082,9 @@ int igmp_rcv(struct sk_buff *skb)
>                          goto drop;
>          }
> 
> +       if (!netif_running(dev))
> +               goto drop;
> +
>          in_dev = __in_dev_get_rcu(dev);
>          if (!in_dev)
>                  goto drop;
> 
> 
> BTW, does IPv6 MLD has this issue?
I also think mld has the same issue.

Thread A 				Thread B
icmpv6_rcv				br_dev_stop
   igmp6_event_query			  br_multicast_leave_snoopers
     start mc_query_work		            ipv6_dev_mc_dec
       Thread C				      __ipv6_dev_mc_dec
	mld_query_work				mutex_lock
	  ...				        igmp6_group_dropped//r=1
	  ...					mutex_unlock
	  ...					ma_put
	  ...					  refcount_dec_...//r=0
	  mutex_lock                  		
	  __mld_query_work
             igmp6_group_queried
	      refcount_inc(&ma->mca_refcnt) //r increased from 0
	  mutex_lock
Check whether the value of mcs_uses is 0 will solve the issue.

also I think checking whether the device is still running in IGMP does
not solve the uaf issue, but reduces the probability of the issue. I
will try to use a lock to solve the IGMP refcnt uaf issue.

> 
> Thanks
> Hangbin
> 

