Return-Path: <netdev+bounces-52762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A38800189
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 03:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6D51C20B52
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3511C3D;
	Fri,  1 Dec 2023 02:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B819131
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 18:22:58 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ShGw35v3Xz1P93C;
	Fri,  1 Dec 2023 10:19:15 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 10:22:55 +0800
Message-ID: <ae51828e-e2fa-8cd4-0f4f-58af3590cffa@huawei.com>
Date: Fri, 1 Dec 2023 10:22:55 +0800
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
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <fw@strlen.de>, <luwei32@huawei.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231130030225.3571231-1-shaozhengchao@huawei.com>
 <CANn89iKhtEcZm4g_xykYQDjeT90EeWCWFTUDLr-T9yxr0gqH3g@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89iKhtEcZm4g_xykYQDjeT90EeWCWFTUDLr-T9yxr0gqH3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/12/1 2:05, Eric Dumazet wrote:
> On Thu, Nov 30, 2023 at 3:50 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>
>> The .parse_protocol hook function in the ipvlan_header_ops structure is
>> not implemented. As a result, when the AF_PACKET family is used to send
>> packets, skb->protocol will be set to 0.
>> The IPVLAN device must be of the Ethernet type. Therefore, use
>> eth_header_parse_protocol function to obtain the protocol.
>>
> 
> Please add a Fixes: tag
> 
Hi Eric:
	Thank you for your reply. I will add it in v2.
> Also, why macvlan would not need a similar patch ?
> 
   Yes, I think macvlan also need to get protocol, although the protocol
is not used in TX of the macvlan driver. I will make a patch later.

Zhengchao Shao
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/ipvlan/ipvlan_main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
>> index 57c79f5f2991..f28fd7b6b708 100644
>> --- a/drivers/net/ipvlan/ipvlan_main.c
>> +++ b/drivers/net/ipvlan/ipvlan_main.c
>> @@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops = {
>>          .parse          = eth_header_parse,
>>          .cache          = eth_header_cache,
>>          .cache_update   = eth_header_cache_update,
>> +       .parse_protocol = eth_header_parse_protocol,
>>   };
>>
>>   static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device *dev)
>> --
>> 2.34.1
>>

