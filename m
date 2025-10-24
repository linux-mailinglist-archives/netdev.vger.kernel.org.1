Return-Path: <netdev+bounces-232367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C0C04B3F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226AF3BC751
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5772C3761;
	Fri, 24 Oct 2025 07:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283B2C3242;
	Fri, 24 Oct 2025 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290474; cv=none; b=ZCcFcjhxnrRHQ8VOj03s3Qs+rdLLsubjs+1LRdZRjvBgWs2ifLPmpWd8pgMbf6nuKHx1IoNS+At0+qMkNtolK1I4b7O5+HDCOuCY/lwsTlC7aAXWHD9tAv0yHQaRqWG2xewfOgJ3z/YfITpRiGLPcPMlqSBgv5LVFB14PJHjcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290474; c=relaxed/simple;
	bh=C+PMhCJXT7hCS+fUqPYZIs2gkifJxBoAnNYkuvRZhKM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=otNKK6NojU3n8VnY42ZjxUinPoysIlFGk0PhOSL9BSpuzJFMYCrRLrgtS9W+bKiqpKLHbpD6qU9uYkdTGOHsuznP0dByLIw3R/M75w/mTCQLx9f/Sno6+mp2jdO4n3oTMfRFyJwkSRH50znGEDDOFwlV85io7ZYhIYbpN2anp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ctDhz3np2zTgyh;
	Fri, 24 Oct 2025 15:16:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A73B140203;
	Fri, 24 Oct 2025 15:21:02 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 15:21:01 +0800
Message-ID: <1a685858-833a-4ccf-93b2-d878eee25722@huawei.com>
Date: Fri, 24 Oct 2025 15:21:00 +0800
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
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the inappropriate
 netif_device_detach()
To: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-4-shaojijie@huawei.com>
 <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/24 9:05, Jacob Keller wrote:
>
> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>> current, driver will call netif_device_detach() in
>> pci_error_handlers.error_detected() and do reset in
>> pci_error_handlers.slot_reset().
>> However, if pci_error_handlers.slot_reset() is not called
>> after pci_error_handlers.error_detected(),
>> driver will be detached and unable to recover.
>>
>> drivers/pci/pcie/err.c/report_error_detected() says:
>>    If any device in the subtree does not have an error_detected
>>    callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
>>    error callbacks of any device in the subtree, and will
>>    exit in the disconnected error state.
>>
>> Therefore, when the hibmcge device and other devices that do not
>> support the error_detected callback are under the same subtree,
>> hibmcge will be unable to do slot_reset.
>>
> Hmm.
>
> In the example case, the slot_reset never happens, but the PCI device is
> still in an error state, which means that the device is not functional..
>
> In that case detaching the netdev and remaining detached seems like an
> expected outcome?
>
> I guess I don't fully understand the setup in this scenario.

We have encountered some non-fatal errors, such as the SMMU event 0x10,
which triggered the PCIe RAS and caused the network port to become unusable.

the event does not significantly affect the normal use of the network port,
so it is unreasonable to say that the network port cannot be used.

We do our best to ensure the normal use of the network ports;
otherwise, unless there is a serial port,
it will no longer be possible to connect to the board.

To prevent such issues, I move netif_device_detach() from error_detected() to slot_reset().
Either do netif_device_detach() and error_detected(), otherwise do nothing.


>
>> This path move netif_device_detach from error_detected to slot_reset,
>> ensuring that detach and reset are always executed together.
>>
>> Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handling feature")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> index 83cf75bf7a17..e11495b7ee98 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
>> @@ -136,12 +136,11 @@ static pci_ers_result_t hbg_pci_err_detected(struct pci_dev *pdev,
>>   {
>>   	struct net_device *netdev = pci_get_drvdata(pdev);
>>   
>> -	netif_device_detach(netdev);
>> -
>> -	if (state == pci_channel_io_perm_failure)
>> +	if (state == pci_channel_io_perm_failure) {
>> +		netif_device_detach(netdev);
>>   		return PCI_ERS_RESULT_DISCONNECT;
>> +	}
>>   
>> -	pci_disable_device(pdev);
>>   	return PCI_ERS_RESULT_NEED_RESET;
>>   }
>>   
>> @@ -150,6 +149,9 @@ static pci_ers_result_t hbg_pci_err_slot_reset(struct pci_dev *pdev)
>>   	struct net_device *netdev = pci_get_drvdata(pdev);
>>   	struct hbg_priv *priv = netdev_priv(netdev);
>>   
>> +	netif_device_detach(netdev);
>> +	pci_disable_device(pdev);
>> +
>>   	if (pci_enable_device(pdev)) {
>>   		dev_err(&pdev->dev,
>>   			"failed to re-enable PCI device after reset\n");
> Here, we disable the device only to immediately attempt to re-enable it?

Yes, the driver attempts to re-enable the PCIe device.

Thanks,
Jijie Shao


