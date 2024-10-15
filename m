Return-Path: <netdev+bounces-135719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F399F033
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390521C2160A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD11C4A2B;
	Tue, 15 Oct 2024 14:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6411AF0C3;
	Tue, 15 Oct 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004046; cv=none; b=gsqf4fdPbpHjFbnegrVSFtd3ScdRwODkQE3/r0T177T6LXuZnrpavhEdSHP/ECEc/G7Bv47peLk4J85Y30W7balh+Qt2iZI44SwKX6D58687LbYN8mfa3vC2AZo5qetIh09Eg0Vyr2jICmunIF0YFeal7x/dvWDqroNkspybOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004046; c=relaxed/simple;
	bh=zRSEFfRZbRs4RMPQOm5KoPf38olnVjjbhbnQZqH170U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KT18GlmzLwK/+DBTyJkuQrLlJyavVY97ZHmQDhW5+t+HoX70vNTsCGxmiE7FPSQPZEYFLCKuiUZDg7gb14stz4VDfROpTLpslsve2uAUhIAA5dz559hmXCgJegZ1HomLZVffpm9TU2recIYvYwY9v3urgn6p08MnfmLveI9Sxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XScXK0ZLfz2Dddq;
	Tue, 15 Oct 2024 22:52:49 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B35B1A0188;
	Tue, 15 Oct 2024 22:54:02 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 22:54:01 +0800
Message-ID: <609764d0-21e9-49d0-acb1-e2f2666bef0d@huawei.com>
Date: Tue, 15 Oct 2024 22:54:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241014145115.44977-1-wanghai38@huawei.com>
 <0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600001.china.huawei.com (7.193.23.3)


On 2024/10/15 0:59, Florian Fainelli wrote:
> On 10/14/24 07:51, Wang Hai wrote:
>> The bcm_sysport_xmit() returns NETDEV_TX_OK without freeing skb
>> in case of dma_map_single() fails, add dev_kfree_skb() to fix it.
>>
>> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT 
>> Ethernet MAC driver")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > --->   drivers/net/ethernet/broadcom/bcmsysport.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
>> b/drivers/net/ethernet/broadcom/bcmsysport.c
>> index c9faa8540859..0a68b526e4a8 100644
>> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
>> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
>> @@ -1359,6 +1359,7 @@ static netdev_tx_t bcm_sysport_xmit(struct 
>> sk_buff *skb,
>>           netif_err(priv, tx_err, dev, "DMA map failed at %p 
>> (len=%d)\n",
>>                 skb->data, skb_len);
>>           ret = NETDEV_TX_OK;
>> +        dev_kfree_skb_any(skb);
>
> Since we already have a private counter tracking DMA mapping errors, I 
> would follow what the driver does elsewhere in the transmit path, 
> especially what bcm_sysport_insert_tsb() does, and just use 
> dev_consume_skb_any() here.

Hi, Florian.

Thanks for the suggestion, I've resent the v2 version of this one as well.

[PATCH v2 net] net: systemport: fix potential memory leak in 
bcm_sysport_xmit()


