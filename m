Return-Path: <netdev+bounces-135611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4A99E67D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A79D1F24F3A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB551EBA1A;
	Tue, 15 Oct 2024 11:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AA1EBA12;
	Tue, 15 Oct 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992499; cv=none; b=UvSmHZckaI3ccbAS3WFEmYOPS3YlV0eQhrXwlvgbos1e4G3Qhu1ybnWBG41kWMOR25+Wk8gyVTwq+QyVygFEuG1F+KFNA0QhnViezgN6BTSw+wFGW5EsBnOVcj2mifl0qzZ5EPDmQErSLV6vbSeQ64s24/IrYnx01/5RRz/uhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992499; c=relaxed/simple;
	bh=PwdqZoJg4DBVUyTiC+Dy5ay2rzg/+x9WrxO8ZIYNKF0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=krEs2AG4rl8ux6ncSP5n7c+z/OqTcQ+5mRgzhHrklOpRc/i8BQ2uynI+MH0PRt5X8xAnLuPXr8CFu2vTCgoUJMTo8kcyfQKGhPAWU81giIDcL0H0LQXnj8Cz+NAhhIZ/1a6+KoKWet8LOx+c75V0aXWxHq6yRn2BN0o6XeC4COo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XSXGh5G05zQrhn;
	Tue, 15 Oct 2024 19:40:44 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 09709180AE9;
	Tue, 15 Oct 2024 19:41:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:41:26 +0800
Message-ID: <44023e6f-5a52-4681-84fc-dd623cd9f09d@huawei.com>
Date: Tue, 15 Oct 2024 19:41:26 +0800
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
	<horms@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<christophe.jaillet@wanadoo.fr>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-8-shaojijie@huawei.com>
 <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

on 2024/10/15 18:28, Paolo Abeni wrote:
> On 10/10/24 16:21, Jijie Shao wrote:
>> @@ -124,6 +129,20 @@ static void hbg_buffer_free_skb(struct 
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
> It looks like I was not clear enough in my previous feedback: 
> allocating the sk_buff struct at packet reception time, will be much 
> more efficient, because the sk_buff contents will be hot in cache for 
> the RX path, while allocating it here, together with the data pointer 
> itself will almost ensure 2-4 cache misses per RX packet.
>
> You could allocate here the data buffer i.e. via a page allocator and
> at rx processing time use build_skb() on top of such data buffer.
>
> I understand it's probably such refactor would be painful at this 
> point, but you should consider it as a follow-up.

Thank you for your advice.
We're actually focusing on optimizing performance now.

But according to the test results, the current performance bottleneck
is not in the driver or protocol stack.

This driver is a PCIe driver, the device is on the BMC side.
All data transfer needs to pass through the PCIe DMA.
As a result, the maximum bandwidth cannot be reached.
Currently, we have a special task to track and optimize performance.
Your suggestion is reasonable and we will adopt it when optimizing performance.

If possible, we do not want to modify this patch for the time being.
Because patch set has been modified many times,
we hope it can be accepted as soon as possible if there are no other serious problems.
We have some other features waiting to be sent.

Some patches will be sent in the future to optimize performance.

Thank you.

>
> Side note: the above always uses the maximum MTU for the packet size, 
> if the device supports jumbo frames (8Kb size packets), it will 
> produce quite bad layout for the incoming packets... Is the device 
> able to use multiple buffers for the incoming packets?

In fact, jumbo frames are not supported in device, and the maximum MTU is 4Kb.

Thanks,

Jijie Shao


