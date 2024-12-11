Return-Path: <netdev+bounces-151081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090A9ECC18
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA181888853
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E5238E35;
	Wed, 11 Dec 2024 12:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B4238E23
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920375; cv=none; b=IVMvxbB/IkYTuTuGIqSUXIC61GVUTZWSC6oAeEw5xDlfMbDX/DFryFX7KY7Zk4E+BFXc8WzZYnq0V93so90VZPI07qsFa16OgYZ4MP2ssI7+MTBGBQmrVtmMGSjz/LAxwthqVsGFoMnm7SJLpfjwzPTJCcma1tRwT76wuEZvMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920375; c=relaxed/simple;
	bh=hunXydSSJnWtI/fE50MBwYEaKPGu+a5vN/yej7F4uY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qqBmJGJd83ag4PLsDgMYkunYOzopZJyQqyuC6GtTu12/iz67Jfq621PAd7ujI+4yHn5j1Im9CrPfTpLcnEjjjkgdi8/A0tltU7/tnjiaFbzWk9y+7xDkhYbV67BVIwFEtWNvtqI79UrZruCGCRE/z3qZ5YNV+USKHSnL0zs1twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y7ZhL4Yj0z21n1Y;
	Wed, 11 Dec 2024 20:30:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9698A1A0188;
	Wed, 11 Dec 2024 20:32:43 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Dec 2024 20:32:43 +0800
Message-ID: <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
Date: Wed, 11 Dec 2024 20:32:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/11 2:14, David Wei wrote:
> On 2024-12-10 04:25, Yunsheng Lin wrote:
>> On 2024/12/4 12:10, David Wei wrote:
>>
>>>  	bnxt_copy_rx_ring(bp, rxr, clone);
>>> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>>  	rxr->rx_next_cons = 0;
>>>  	page_pool_disable_direct_recycling(rxr->page_pool);
>>> +	if (bnxt_separate_head_pool())
>>> +		page_pool_disable_direct_recycling(rxr->head_pool);
>>
>> Hi, David
>> As mentioned in [1], is the above page_pool_disable_direct_recycling()
>> really needed?
>>
>> Is there any NAPI API called in the implementation of netdev_queue_mgmt_ops?
>> It doesn't seem obvious there is any NAPI API like napi_enable() &
>> ____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_stop()/
>> bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.
>>
>> 1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@huawei.com/
> 
> Hi Yunsheng, there are explicitly no napi_enable/disable() calls in the
> bnxt implementation of netdev_queue_mgmt_ops due to ... let's say HW/FW
> quirks. I looked back at my discussions w/ Broadcom, and IIU/RC
> bnxt_hwrm_vnic_update() will prevent any work from coming into the rxq
> that I'm trying to stop. Calling napi_disable() has unintended side
> effects on the Tx side.

It seems that bnxt_hwrm_vnic_update() sends a VNIC_UPDATE cmd to disable
a VNIC? and a napi_disable() is not needed? Is it possible that there may
be some pending NAPI work is still being processed after bnxt_hwrm_vnic_update()
is called?

> 
> The intent of the call to page_pool_disable_direct_recycling() is to
> prevent pages from the old page pool from being returned into the fast
> cache. These pages must be returned via page_pool_return_page() so that
> the it can eventually be freed in page_pool_release_retry().
> 
> I'm going to take a look at your discussions in [1] and respond there.

Thanks.

