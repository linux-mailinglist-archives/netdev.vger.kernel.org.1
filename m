Return-Path: <netdev+bounces-138145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5AC9AC30B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8512B274F4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42416A959;
	Wed, 23 Oct 2024 09:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCA1662FA
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674487; cv=none; b=LOwlUhgkyAYrgv0QKLfQjpYiU7nApQSxsUEpAe18+7Cjy2uAUZju+Bweioarkie/FAhWdfgf5cMb5fkHkvtUga4n5mEd6v4cv6yPK7aYF8w0gj9q0vRtUX7CsvYYQg18gFuFjl9Za06EExFAGmxEhakRy0M5ggA9Du+WDKULQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674487; c=relaxed/simple;
	bh=DEo4SLGz1G2zeUxzABcMR3UPMB+fMq/6/FTuD/eCmM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GpIOCxjlO3HQ5WZCgJWI3jEWHS84dvKzQhl7YdfjvksrILTwZyNHXnp7II9cFTY6/S2e3tgeXX4WNBScj4bAFgbfogskupdhOYT1FGgPrNSBAJEl3xy2NIXsEG48WeNMYqB65vnWUQodeTABek//t0v4231kiekvlvx19qSFwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYNRv5KDMzfdYm;
	Wed, 23 Oct 2024 17:05:31 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 1094814039F;
	Wed, 23 Oct 2024 17:08:02 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:08:01 +0800
Message-ID: <f2c9b77d-c67c-4c11-b2f3-bcf80a22a5a9@huawei.com>
Date: Wed, 23 Oct 2024 17:08:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igb: Fix potential invalid memory access in
 igb_init_module()
To: Simon Horman <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <cramerj@intel.com>,
	<shannon.nelson@amd.com>, <mitch.a.williams@intel.com>, <jgarzik@redhat.com>,
	<auke-jan.h.kok@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
References: <20241022063807.37561-1-yuancan@huawei.com>
 <20241022155630.GY402847@kernel.org>
Content-Language: en-US
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <20241022155630.GY402847@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)


On 2024/10/22 23:56, Simon Horman wrote:
> + Alexander Duyck
>
> On Tue, Oct 22, 2024 at 02:38:07PM +0800, Yuan Can wrote:
>> The pci_register_driver() can fail and when this happened, the dca_notifier
>> needs to be unregistered, otherwise the dca_notifier can be called when
>> igb fails to install, resulting to invalid memory access.
>>
>> Fixes: fe4506b6a2f9 ("igb: add DCA support")
> I don't think this problem was introduced by the commit cited above,
> as it added the call to dca_unregister_notify() before
> pci_register_driver(). But rather by the commit cited below which reversed
> the order of these function calls.
>
> bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576")
>
> I'm unsure if it is necessary to repost the patch to address that.
> But if you do, and assuming we are treating this as a bug fix,
> please target it for the net (or iwl-net) tree like this:
>
> Subject: [PATCH net v2] ...
Ok, I will send a v2 patch to the net tree, thanks!
>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index f1d088168723..18284a838e24 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -637,6 +637,10 @@ static int __init igb_init_module(void)
>>   	dca_register_notify(&dca_notifier);
>>   #endif
>>   	ret = pci_register_driver(&igb_driver);
>> +#ifdef CONFIG_IGB_DCA
>> +	if (ret)
>> +		dca_unregister_notify(&dca_notifier);
>> +#endif
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.17.1
>>
>>
-- 
Best regards,
Yuan Can


