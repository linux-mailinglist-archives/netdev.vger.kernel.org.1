Return-Path: <netdev+bounces-49648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC017F2D60
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEAF2822F3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C834A9AE;
	Tue, 21 Nov 2023 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F016192
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:38:40 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SZP3H4pznz1P8jn;
	Tue, 21 Nov 2023 20:35:07 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 20:38:34 +0800
Message-ID: <9a221a65-71ae-2bca-e33c-f62c6b625461@huawei.com>
Date: Tue, 21 Nov 2023 20:38:34 +0800
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi Hangbin:
	Yes, they are the same.

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

I will take a look at IPv6 MLD later. maybe tonight.
Thank you.

Zhengchao Shao
> 
> Thanks
> Hangbin
> 

