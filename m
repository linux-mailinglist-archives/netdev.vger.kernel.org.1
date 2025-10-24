Return-Path: <netdev+bounces-232353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC198C0489C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19A71888868
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6AB265CB2;
	Fri, 24 Oct 2025 06:39:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC618EB0;
	Fri, 24 Oct 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287947; cv=none; b=MZANjrPsNw3GhZaM+qRV3fmzBs1U4D8tmGI2vGdM4uh2QVDcoca0XlwYrb2zfJSx67fEk538+Rf/4iJCxWCvmV8irbSnAjfM2G02r46slvJl0LRqowav6RBTNND6SEJ+jCA4XMitZL1Qao85deod5wbJaZ2sk/dH25a9oXkNTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287947; c=relaxed/simple;
	bh=RUHE8iJmBlRsQEc5EW4vCzzCdD+8XbCcV/ItdmFqlT0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U/ywqdadCuzbc0Q7M398eA34O5apF+6VBLHFpVDfLBazFz0VSjZddvdVNiNDr19Dk1OyaU88qmmy20Lzta1Qc4qroawPNQsdoW8bYTlhhPHwsUhGbpChPm7Ny83EzgM7f24asz5gKM7POKR5B3nUdgchn758Zk4Lh8V2A19zAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ctCmC4hDyzxX6n;
	Fri, 24 Oct 2025 14:34:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F40E5180489;
	Fri, 24 Oct 2025 14:39:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 14:39:00 +0800
Message-ID: <cc7362e8-e8ae-4813-a73b-d752b403332a@huawei.com>
Date: Fri, 24 Oct 2025 14:39:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not
 re-enabled in irq_handle issue
To: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-2-shaojijie@huawei.com>
 <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/24 9:15, Jacob Keller wrote:
>
> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>> irq initialized with the macro HBG_ERR_IRQ_I will automatically
>> be re-enabled, whereas those initialized with the macro HBG_IRQ_I
>> will not be re-enabled.
>>
>> Since the rx buf avl irq is initialized using the macro HBG_IRQ_I,
>> it needs to be actively re-enabled.
>>
> This seems like it would be quite a severe issue. Do you have
> reproduction or example of what the failure state looks like?

priv->stats.rx_fifo_less_empty_thrsld_cnt can only be increased to 1
and cannot be increased further.

It is not a very serious issue, it affects the accuracy of a statistical item.

>
>  From the fixed commit, the RX_BUF_AVL used to be HBG_ERR_IRQ_I but now
> it uses HBG_IRQ_I so that it can have its own custom handler.. but
> HBG_IRQ_I doesn't set re_enable to true...
>
> It seems like a better fix would be having an HBG_ERR_IRQ_I variant that
> lets you pass your own function instead of making the handler have to do
> the hbg_hw_irq_enable call in its handler?

Currently, only the RX_BUF_AVL interrupt needs to be enabled separately.
Personally, I think it is acceptable to temporarily not use the an HBG_ERR_IRQ_I variant.

>
>> Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handling feature")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
>> index 8af0bc4cca21..ae4cb35186d8 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
>> @@ -32,6 +32,7 @@ static void hbg_irq_handle_rx_buf_val(struct hbg_priv *priv,
>>   				      const struct hbg_irq_info *irq_info)
>>   {
>>   	priv->stats.rx_fifo_less_empty_thrsld_cnt++;
>> +	hbg_hw_irq_enable(priv, irq_info->mask, true);
>>   }
>>   
>>   #define HBG_IRQ_I(name, handle) \

