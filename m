Return-Path: <netdev+bounces-211329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C487CB18059
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2850583B7A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F225235355;
	Fri,  1 Aug 2025 10:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0222D7BF;
	Fri,  1 Aug 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045090; cv=none; b=J3Jl4OYrADPEcdXd0HmAKXcBNxMrLoX6scD9riEQpA/Rkcd9JahEyp/tQLm2I80Eldz96FN3C1ACdACvl9gVkqmdcHt8vlzpp2/JVUbOphGvCQMzMuICgwvNlS0sSmWDtbBb80KkPaCucIEhVJfys+hZquJA8ik6+acnEuciIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045090; c=relaxed/simple;
	bh=POetWaU0Nzl/J0eiw/DFtp8lJPkgimOrvFI+/VeZbC8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G00NBq/JMJmvwLbXpgExPc1Xnof7uV6rY2YUwUjog/P/OXhsmDGw1jSOTG23JXIxOiNx3RZJsqG3RN6CCahf66efIVylGl6DB92DRXeFtbUya8tUjk76Yq++vOTT8MgyJRZIq7B20QWXQSqUGkB7GUGJZmktTUSgw3skzGy0RwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4btjKH5Btyz27j8W;
	Fri,  1 Aug 2025 18:45:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CE9FA14027A;
	Fri,  1 Aug 2025 18:44:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 18:44:37 +0800
Message-ID: <15388e7f-45a8-4356-88c9-45848c3a296f@huawei.com>
Date: Fri, 1 Aug 2025 18:44:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rtnl deadlock issue
To: Simon Horman <horms@kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-2-shaojijie@huawei.com>
 <20250801100520.GJ8494@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250801100520.GJ8494@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/1 18:05, Simon Horman wrote:
> On Thu, Jul 31, 2025 at 09:47:47PM +0800, Jijie Shao wrote:
>> Currently, the hibmcge netdev acquires the rtnl_lock in
>> pci_error_handlers.reset_prepare() and releases it in
>> pci_error_handlers.reset_done().
>>
>> However, in the PCI framework:
>> pci_reset_bus - __pci_reset_slot - pci_slot_save_and_disable_locked -
>>   pci_dev_save_and_disable - err_handler->reset_prepare(dev);
>>
>> In pci_slot_save_and_disable_locked():
>> 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>> 		if (!dev->slot || dev->slot!= slot)
>> 			continue;
>> 		pci_dev_save_and_disable(dev);
>> 		if (dev->subordinate)
>> 			pci_bus_save_and_disable_locked(dev->subordinate);
>> 	}
>>
>> This will iterate through all devices under the current bus and execute
>> err_handler->reset_prepare(), causing two devices of the hibmcge driver
>> to sequentially request the rtnl_lock, leading to a deadlock.
>>
>> Since the driver now executes netif_device_detach()
>> before the reset process, it will not concurrently with
>> other netdev APIs, so there is no need to hold the rtnl_lock now.
>>
>> Therefore, this patch removes the rtnl_lock during the reset process and
>> adjusts the position of HBG_NIC_STATE_RESETTING to ensure
>> that multiple resets are not executed concurrently.
>>
>> Fixes: 3f5a61f6d504f ("net: hibmcge: Add reset supported in this module")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> index 503cfbfb4a8a..94bc6f0da912 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> @@ -53,9 +53,11 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
>>   {
>>   	int ret;
>>   
>> -	ASSERT_RTNL();
>> +	if (test_and_set_bit(HBG_NIC_STATE_RESETTING, &priv->state))
>> +		return -EBUSY;
>>   
>>   	if (netif_running(priv->netdev)) {
>> +		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>>   		dev_warn(&priv->pdev->dev,
>>   			 "failed to reset because port is up\n");
>>   		return -EBUSY;
>> @@ -64,7 +66,6 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
>>   	netif_device_detach(priv->netdev);
>>   
>>   	priv->reset_type = type;
>> -	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>>   	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
>>   	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
>>   	if (ret) {
>> @@ -84,10 +85,8 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
>>   	    type != priv->reset_type)
>>   		return 0;
>>   
>> -	ASSERT_RTNL();
>> -
>> -	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>>   	ret = hbg_rebuild(priv);
>> +	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
> Hi Jijie,
>
> If I understand things correctly, then with this patch the
> HBG_NIC_STATE_RESETTING bit is used to prevent concurrent execution.
>
> Noting that a reset may be triggered via eththool, where hbg_reset() is
> used as a callback, I am concerned about concurrency implications for lines
> below this one.

Yes, just like the following, it can lead to reset and net open concurrency.
===========

      reset1                                              reset2                               open

set_bit HBG_NIC_STATE_RESETTING

      netif_device_detach()
      
      resetting...

clear_bit HBG_NIC_STATE_RESETTING
                                               set_bit HBG_NIC_STATE_RESETTING
                                                    netif_device_detach()

       netif_device_attach()
                                                          resetting...                     hbg_net_open()
                                                                                           hbg_txrx_init()

                                               clear_bit HBG_NIC_STATE_RESETTING
                                                       netif_device_attach()

============
Thank you for your reminder.
I will fix it in V2

Jijie Shao

>>   	if (ret) {
>>   		priv->stats.reset_fail_cnt++;
>>   		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
>> @@ -101,12 +100,10 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
>>   	return ret;
>>   }
>>   
>> -/* must be protected by rtnl lock */
>>   int hbg_reset(struct hbg_priv *priv)
>>   {
>>   	int ret;
>>   
>> -	ASSERT_RTNL();
>>   	ret = hbg_reset_prepare(priv, HBG_RESET_TYPE_FUNCTION);
>>   	if (ret)
>>   		return ret;
>> @@ -171,7 +168,6 @@ static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
>>   	struct net_device *netdev = pci_get_drvdata(pdev);
>>   	struct hbg_priv *priv = netdev_priv(netdev);
>>   
>> -	rtnl_lock();
>>   	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
>>   }
>>   
>> @@ -181,7 +177,6 @@ static void hbg_pci_err_reset_done(struct pci_dev *pdev)
>>   	struct hbg_priv *priv = netdev_priv(netdev);
>>   
>>   	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
>> -	rtnl_unlock();
>>   }
>>   
>>   static const struct pci_error_handlers hbg_pci_err_handler = {
>> -- 
>> 2.33.0
>>

