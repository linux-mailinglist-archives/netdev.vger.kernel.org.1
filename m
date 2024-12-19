Return-Path: <netdev+bounces-153327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8859F7AAB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361097A0321
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B3223330;
	Thu, 19 Dec 2024 11:48:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682221FCFCB;
	Thu, 19 Dec 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608914; cv=none; b=h2PZn+741qdww0CuiJTrVZAjpAFNSKw/xwUP6hwXyQJ4wbpsow0I27lzOCczFgH74RpdyxEll6WwpUMpbv3Aic9JQ9bqvXYUbfIs/I5YxcL1vTCYWaCX96L5KRLGzdd3obyrImoHxYoNTkMmw9SXtHwvcvRV4enWCRFxyQ/SPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608914; c=relaxed/simple;
	bh=lA8KN30gn0SXjqkoEs7SWyWLrJJJ1JF30PO/CZNfUnY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mttFYPZSWTmJ89q522XBw8Ihra+c6cveVOXEFqQhfGlKBMusiNRyPLUeGAidfEgB+M8D5bY5bP3j4hlv0sA19EuWQfD6aJ/dTZpOmDIsUEFLqAFwdyEc6ykLdQ6AKhgP2UjUlgONTcbLLTz8ledDNp8QPsbBlgcbhmQtdvunvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YDTJc3HDyz2KXsx;
	Thu, 19 Dec 2024 19:45:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 784EC140202;
	Thu, 19 Dec 2024 19:48:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 19:48:27 +0800
Message-ID: <a96a6923-6a48-4760-97fb-01eed3735e26@huawei.com>
Date: Thu, 19 Dec 2024 19:48:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V2 net 5/7] net: hns3: initialize reset_timer
 before hclgevf_misc_irq_init()
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-6-shaojijie@huawei.com>
 <Z2KT7bLfHmx01wSU@mev-dev.igk.intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Z2KT7bLfHmx01wSU@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/18 17:20, Michal Swiatkowski wrote:
> On Tue, Dec 17, 2024 at 09:08:37AM +0800, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> Currently the misc irq is initialized before reset_timer setup. But
>> it will access the reset_timer in the irq handler. So initialize
>> the reset_timer earlier.
>>
>> Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> index fd0abe37fdd7..8739da317897 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> @@ -2313,6 +2313,7 @@ static void hclgevf_state_init(struct hclgevf_dev *hdev)
>>   	clear_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state);
>>   
>>   	INIT_DELAYED_WORK(&hdev->service_task, hclgevf_service_task);
> Comment here that timer needs to be initialized before misc irq will be
> nice, but that is onlu my impression.


I'll add a comment in the next version.

Thanks,
Jijie Shao

>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
> Thanks
>> +	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
>>   
>>   	mutex_init(&hdev->mbx_resp.mbx_mutex);
>>   	sema_init(&hdev->reset_sem, 1);
>> @@ -3012,7 +3013,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
>>   		 HCLGEVF_DRIVER_NAME);
>>   
>>   	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
>> -	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
>>   
>>   	return 0;
>>   
>> -- 
>> 2.33.0

