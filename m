Return-Path: <netdev+bounces-199085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F5ADEE37
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1AC7A18EC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B727F00D;
	Wed, 18 Jun 2025 13:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974C2E9ED7;
	Wed, 18 Jun 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254258; cv=none; b=d6/qfy3/Mwci6fljvzK8d2H7civ0d7e/kFQZAhlXDBj2I1PrIJIqGvu/mwIOimNFmN3GBRRoiY/23tePGmOnomouQalrmh5U1p1AB8yo0cFWFw9B8m98FC3BtihLSRjj++qWgab/dfx/9fqPjS6ZY+AgU/VZZ5tGQ7lwlsPgqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254258; c=relaxed/simple;
	bh=co5bGLiFes/lPuppOZJbAHvjUkoyFffOex0DflgZZBk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oLO9m446u2wMbtYTQNMpg/0c0ycsF8APuy1BJ6A8+AOdRwJ4ar2ZtB1xiy/9MOlI0oQNUQk30R5phaBR/FnQ7siNIddw8LjEk5DqP23wViSUwC86aAv/MmMiOUkG7VQn/qTLgxs5B7rX7kS9EIccLOBGEr+PgI++kSb6nKBePB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bMlH01WyPz2Cfm2;
	Wed, 18 Jun 2025 21:40:12 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A63401A016C;
	Wed, 18 Jun 2025 21:44:06 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 21:44:05 +0800
Message-ID: <c546b003-5161-479c-902d-103b67838d75@huawei.com>
Date: Wed, 18 Jun 2025 21:44:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH V2 net-next 5/8] net: hns3: set the freed pointers to NULL
 when lifetime is not end
To: Simon Horman <horms@kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-6-shaojijie@huawei.com>
 <20250618111212.GI1699@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250618111212.GI1699@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/18 19:12, Simon Horman wrote:
> On Tue, Jun 17, 2025 at 09:02:52AM +0800, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> There are several pointers are freed but not set to NULL,
>> and their lifetime is not end immediately. To avoid misusing
>> there wild pointers, set them to NULL.
>>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 1 +
>>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 ++++
>>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
>>   3 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> index 6a244ba5e051..0d6db46db5ed 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> @@ -276,6 +276,7 @@ static int hns3_lp_run_test(struct net_device *ndev, enum hnae3_loop mode)
>>   			good_cnt++;
>>   		} else {
>>   			kfree_skb(skb);
>> +			skb = NULL;
> I am sceptical about the merit of setting local variables to NULL like this.
> In general defensive coding is not the preferred approach in the Kernel.
>
> And in this case, won't this result in a NULL dereference when
> skb_get(skb) is called if the loop this code resides in iterates again?

Since HNS3_NIC_LB_TEST_PKT_NUM is 1, the loop will only iterate once,
so the current change will not cause any issues.
However, upon reviewing the code, this change is indeed unnecessary and may cause confusion,
so I will drop this change in the v3.

But I hope this patch can still be retained, and the other changes should be appropriate.

Thansk,
Jijie Shao

>
>>   			netdev_err(ndev, "hns3_lb_run_test xmit failed: %d\n",
>>   				   tx_ret);
>>   		}
> ...
>

