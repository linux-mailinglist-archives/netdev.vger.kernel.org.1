Return-Path: <netdev+bounces-135717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74DF99F028
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669FFB21250
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FDD1C07F8;
	Tue, 15 Oct 2024 14:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A21FC7EC;
	Tue, 15 Oct 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003934; cv=none; b=qHB686wqbpa7RaTEhXvNZfxhfUl9lz524OJAn68/xBsx7IC7NrHhhj5S+L5kRtNL1O3jzlbEZwxLzbAMkjSwwvgt489M0LglMvGGfmMkVoAkAnPjAHjln5sY3UewMrmuBz74VlZl2l/WNxoxW9QZJRvwefztl6EWlqYi+ggwwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003934; c=relaxed/simple;
	bh=y87iWwER98HS/XwERmHJIlph+6PTIfqI7aOgycGVSFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tMNmXRXifjj3/Q4KvcSbcC5rfRhMJgFDhEojIklh7UqqG1dRmcun8QO8YpulYtWReW+Ku/KD0y9ACw7PBaDhJTamjcdzHWxP+l0JRqbJeQdSlFdy+eTghEM+FjY0bSVSP3LPcKiCU+mf1Ji6kqFcGynNCpYBTs14D1ixR/4WeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XScTz4FybzySVc;
	Tue, 15 Oct 2024 22:50:47 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 9447018005F;
	Tue, 15 Oct 2024 22:52:10 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 22:52:09 +0800
Message-ID: <f275b30a-4892-4867-936f-c8de41c05b9e@huawei.com>
Date: Tue, 15 Oct 2024 22:52:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	<justin.chen@broadcom.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<zhangxiaoxu5@huawei.com>
CC: <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241014145901.48940-1-wanghai38@huawei.com>
 <924f6a1b-17af-4dc8-80e3-7c7df687131a@broadcom.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <924f6a1b-17af-4dc8-80e3-7c7df687131a@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)


On 2024/10/15 1:14, Florian Fainelli wrote:
> On 10/14/24 07:59, Wang Hai wrote:
>> The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
>> in case of mapping fails, add dev_kfree_skb() to fix it.
>>
>> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet 
>> controller")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c 
>> b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> index 82768b0e9026..9ea16ef4139d 100644
>> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> @@ -322,6 +322,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>               }
>>               /* Rewind so we do not have a hole */
>>               spb_index = intf->tx_spb_index;
>> +            dev_kfree_skb(skb);
>
> Similar reasoning to the change proposed to bcmsysport.c, we already 
> have a private counter tracking DMA mapping errors, therefore I would 
> consider using dev_consume_skb_any() here.

Hi, Florian.

Thanks for the suggestion, I've resent v2.

[PATCH v2 net] net: bcmasp: fix potential memory leak in bcmasp_xmit()


