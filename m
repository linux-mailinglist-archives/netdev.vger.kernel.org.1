Return-Path: <netdev+bounces-52761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3474800183
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 03:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C278A1C20C3B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC117E1;
	Fri,  1 Dec 2023 02:18:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2622E129
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 18:18:16 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShGnt2RXKzNm4t;
	Fri,  1 Dec 2023 10:13:54 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 10:18:13 +0800
Message-ID: <99a06a0b-a909-8e89-4299-e0209d138696@huawei.com>
Date: Fri, 1 Dec 2023 10:18:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] ipvlan: implemente .parse_protocol hook function
 in ipvlan_header_ops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <fw@strlen.de>, <luwei32@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <maheshb@google.com>
References: <20231130030225.3571231-1-shaozhengchao@huawei.com>
 <6568cddb64f2c_f7062294da@willemb.c.googlers.com.notmuch>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <6568cddb64f2c_f7062294da@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/12/1 2:00, Willem de Bruijn wrote:
> Zhengchao Shao wrote:
>> The .parse_protocol hook function in the ipvlan_header_ops structure is
>> not implemented. As a result, when the AF_PACKET family is used to send
>> packets, skb->protocol will be set to 0.
>> The IPVLAN device must be of the Ethernet type. Therefore, use
>> eth_header_parse_protocol function to obtain the protocol.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Small typo in the subject line: implemente.
> 
> Ipvlan is a device of type ARPHRD_ETHER (ether_setup).
> 
Hi Willem:
	Thank you for your review. I will send v2.

Zhengchao Shao
> Tangential to this patch:
> 
> I checked that ipvlan_start_xmit indeed only expects packets with
> skb->data at Ethernet header. ipvlan_queue_xmit checks
> 
>          if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
>                  goto out;
> 
> It may later call ipvlan_xmit_mode_l3 and ipvlan_get_L3_hdr, which
> has such cases:
> 
>          case htons(ETH_P_IP): {
>                  u32 pktlen;
>                  struct iphdr *ip4h;
>              
>                  if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
>                          return NULL;
> 
> That pskb_may_pull should include the ethernet header. It gets
> pulled for L3 mode in ipvlan_process_outbound, *after* the above.
> 
>> ---
>>   drivers/net/ipvlan/ipvlan_main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
>> index 57c79f5f2991..f28fd7b6b708 100644
>> --- a/drivers/net/ipvlan/ipvlan_main.c
>> +++ b/drivers/net/ipvlan/ipvlan_main.c
>> @@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops = {
>>   	.parse		= eth_header_parse,
>>   	.cache		= eth_header_cache,
>>   	.cache_update	= eth_header_cache_update,
>> +	.parse_protocol	= eth_header_parse_protocol,
>>   };
>>   
>>   static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device *dev)
>> -- 
>> 2.34.1
>>
> 
> 

