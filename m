Return-Path: <netdev+bounces-124539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D3969E7E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653C51F24D11
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F219F408;
	Tue,  3 Sep 2024 12:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F31CA6B6;
	Tue,  3 Sep 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368260; cv=none; b=t/V+wsLA7FuOEZRrzzhwYQSk8wWZeuRGonZ4lHbdOnocShezabsI3U6SggNZPHzyBG6nHgvz+zrOKDEGxZGJGflORIXnOYh+fT5lPZJR1auAiNvrnF7m5imXJAj5kdc4hGVPKog7IkTqB1ciOwmMa4+Zrjg991oCrFcTUm1vuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368260; c=relaxed/simple;
	bh=jv6J61g2w8yMD5DyTARyh8FoK7mw7X6oBJlGAIlZwWc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N6rpdWNLqfLwbJ3loTF8WLHvBXrN8VLhFcdRlUQQ5K7kKySb3vlIa4kEQk50VqBsjSrDadwpBmwv7g2WqROBetfQyWVNflRe6424nJw/Sk4tjYH83q4fMpu98kDJA9z6OZdFztKnmozbVzcAnYFhzqMTKj5gpFKGAhEVRLfU7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WylwJ6TNmzgYd3;
	Tue,  3 Sep 2024 20:55:28 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id AD71E140258;
	Tue,  3 Sep 2024 20:57:35 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 20:57:34 +0800
Message-ID: <8e25187c-ce88-4415-91ee-4c636964b674@huawei.com>
Date: Tue, 3 Sep 2024 20:57:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 07/11] net: hibmcge: Implement rx_poll
 function to receive packets
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-8-shaojijie@huawei.com>
 <0f3cf321-3c23-43df-b6eb-55dd0a1fec64@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <0f3cf321-3c23-43df-b6eb-55dd0a1fec64@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/3 20:08, Paolo Abeni wrote:
> On 8/30/24 14:16, Jijie Shao wrote:
>> @@ -119,6 +122,20 @@ static void hbg_buffer_free_skb(struct 
>> hbg_buffer *buffer)
>>       buffer->skb = NULL;
>>   }
>>   +static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
>> +{
>> +    u32 len = hbg_spec_max_frame_len(buffer->priv, buffer->dir);
>> +    struct hbg_priv *priv = buffer->priv;
>> +
>> +    buffer->skb = netdev_alloc_skb(priv->netdev, len);
>> +    if (unlikely(!buffer->skb))
>> +        return -ENOMEM;
>
> It's preferable to allocate the skbuff at packet reception time, 
> inside the poll() function, just before passing the skb to the upper 
> stack, so that the header contents are fresh in the cache. 
> Additionally that increases the change for the allocator could hit its 
> fastpath.

In hibmcge driver, we alloc the skb memory first, after dma, and then set the dam address to the MAC for receiving packets.
After receiving a packet, MAC fills the hw rx descriptor and packet content to skb->data, and then reports an RX interrupt to trigger the driver to receive the packet.
In poll(), we use skb_reserve() to adjust the size of the SKB headroom. The skb->data is moved backward by the descriptor length(HBG_PACKET_HEAD_SIZE) to ensure
the skb->data is at the start position of the packet.

    ┌─────────────────┬────────────────────────────────────┐
    │hw rx descriptor │                packet              │
    │                 │                                    │
    └─────────────────┴────────────────────────────────────┘
    ^
   skb->data

>
>> +
>> +    buffer->skb_len = len;
>> +    memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);
>
> Out of sheer ignorace, why do you need to clear the packet data?
>
>
The length of HBG_PACKET_HEAD_SIZE is exactly the size of the rx descriptor. Therefore, we want to clear before receiving packets to ensure that the descriptor is correct.

	Thanks
	Jijie Shao


