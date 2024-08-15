Return-Path: <netdev+bounces-118763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A1952B3F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E6628306A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDA19DF46;
	Thu, 15 Aug 2024 08:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DE1993B0
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711031; cv=none; b=Bm0UZqz4GZs0FeGz5Gzr+x4Q/S/zFlaISB6WnHc0HoDGBnFbb4cjtcyRBqsGouUK2EuecRGVnqTHyk+2CHTRTqCFiYnp8ePJQawOS1VZG11C4vxDb6NQ+TYnxElsLAjK0MTMlWGXZtgS/uguIChliBXrkjr8BaVusFDlaoSyzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711031; c=relaxed/simple;
	bh=N4l9P209oqwZaVdRGSNqEWsdCan0raFms7HhOrKMKFY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VtYTDgRrTtNrBvKWxtmSf5jHrBOo0AWSgpd8ALn92sjElARsfKUp/4BlWdU3J1AP03xZIvE58gJtDLSqDH8MgS+tq5I2rel1LtE5Hwi7KH5oeXEBw7z6+wuBA8Uz0N25wX3aHbqQ/oTkylIZVqwGDDFT+twztdQCawoxjO+MgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wkz4L4GDkz1T7Lg;
	Thu, 15 Aug 2024 16:36:34 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 85737140159;
	Thu, 15 Aug 2024 16:37:05 +0800 (CST)
Received: from [10.67.111.5] (10.67.111.5) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 16:37:04 +0800
Subject: Re: [PATCH v2 -next] sfc: Add missing pci_disable_device() for error
 path
To: <ecree.xilinx@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <vladimir.oltean@nxp.com>,
	<alex.austin@amd.com>, <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
References: <20240815030436.1373868-1-yiyang13@huawei.com>
 <20240815082112.GA35524@gmail.com>
From: "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <f283412e-051b-dd65-b2bc-72e56e03b398@huawei.com>
Date: Thu, 15 Aug 2024 16:37:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240815082112.GA35524@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)

On 2024/8/15 16:21, Martin Habets wrote:
> On Thu, Aug 15, 2024 at 03:04:36AM +0000, Yi Yang wrote:
>> This error path needs to disable the pci device before returning.
> 
> Can you explain why this is needed? What goes wrong without this patch?
> 
>>
>> Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
>> Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
>> Fixes: 89c758fa47b5 ("sfc: Add power-management and wake-on-LAN support")
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>>
>> v2: add pci_disable_device() for efx_pm_resume() (drivers/net/ethernet/sfc/efx.c)
>> and ef4_pm_resume() (drivers/net/ethernet/sfc/falcon/efx.c)
>>
>>   drivers/net/ethernet/sfc/efx.c        | 6 ++++--
>>   drivers/net/ethernet/sfc/falcon/efx.c | 6 ++++--
>>   drivers/net/ethernet/sfc/siena/efx.c  | 6 ++++--
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 6f1a01ded7d4..bf6567093001 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -1278,13 +1278,15 @@ static int efx_pm_resume(struct device *dev)
>>   	pci_set_master(efx->pci_dev);
>>   	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	down_write(&efx->filter_sem);
>>   	rc = efx->type->init(efx);
>>   	up_write(&efx->filter_sem);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	rc = efx_pm_thaw(dev);
> 
> This always falls through into the failure path, even if efx_pm_thaw
> succeeds.
> Same for the other files.
> 
> Martin
> 
>> +fail:
>> +	pci_disable_device(pci_dev);
>>   	return rc;
>>   }
>>   
>> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
>> index 8925745f1c17..2c3cf1c9a1a7 100644
>> --- a/drivers/net/ethernet/sfc/falcon/efx.c
>> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
>> @@ -3027,11 +3027,13 @@ static int ef4_pm_resume(struct device *dev)
>>   	pci_set_master(efx->pci_dev);
>>   	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	rc = efx->type->init(efx);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	rc = ef4_pm_thaw(dev);
>> +fail:
>> +	pci_disable_device(pci_dev);
>>   	return rc;
>>   }
>>   
>> diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
>> index 59d3a6043379..dce9a5174e4a 100644
>> --- a/drivers/net/ethernet/sfc/siena/efx.c
>> +++ b/drivers/net/ethernet/sfc/siena/efx.c
>> @@ -1240,13 +1240,15 @@ static int efx_pm_resume(struct device *dev)
>>   	pci_set_master(efx->pci_dev);
>>   	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	down_write(&efx->filter_sem);
>>   	rc = efx->type->init(efx);
>>   	up_write(&efx->filter_sem);
>>   	if (rc)
>> -		return rc;
>> +		goto fail;
>>   	rc = efx_pm_thaw(dev);
>> +fail:
>> +	pci_disable_device(pci_dev);
>>   	return rc;
>>   }
>>   
>> -- 
>> 2.25.1
>>
> .
> 
Sorry. This is a coccinelle warning, Not a problem that actually 
happened. Maybe it doesn't have to be fixed.

-- 

