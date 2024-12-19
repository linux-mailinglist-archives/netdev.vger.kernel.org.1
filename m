Return-Path: <netdev+bounces-153333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868F9F7B10
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB6216B8F8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B202248B4;
	Thu, 19 Dec 2024 12:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF02248B0;
	Thu, 19 Dec 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610723; cv=none; b=kN1SU7x7cnYb4JKddzu6JUIJJlBGB9XRq4fwsbRTB2EN2W9BcaGrVgNBhy7D6/oQUnngNOtemWOG1Cjtqb4KlA/EeE7GVRW4EIwHdjUlBAcA5sajoiFxsnBF6sXv1T+TwuO4sBy5DR+ebJfZvETYhlcQ/AsrcGDR2ojKPS8FIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610723; c=relaxed/simple;
	bh=O/72aCmFU4+rDHTUHpGs7g2m+6XRma4QIqni7kMFaT0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f7f1mJFsq5Z1lTv94/JBxdl20VGTGvIyE1TBScK7/3cIZMHdc+3sHxm3biXObak+PrhvmsYGGPUpwamN9eeHO7dNQWXBVMIgNnBZ8m1vGX0dIFJDQGuLTIgHkQJuk4hJiGR654V29mchz9VGIxrhVy54vDk7XeXZZXSgKqMDAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YDTyX4514z11LtT;
	Thu, 19 Dec 2024 20:15:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DFC3D180A9E;
	Thu, 19 Dec 2024 20:18:32 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 20:18:32 +0800
Message-ID: <bc9a3559-dfb2-4fba-ad61-cfabd0fbf9c7@huawei.com>
Date: Thu, 19 Dec 2024 20:18:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
To: Paolo Abeni <pabeni@redhat.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
 <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
 <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/19 17:41, Paolo Abeni wrote:
> On 12/18/24 10:02, Michal Swiatkowski wrote:
>> On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
>>> From: Hao Lan <lanhao@huawei.com>
>>>
>>> When a reset type that is not supported by the driver is input, a reset
>>> pending flag bit of the HNAE3_NONE_RESET type is generated in
>>> reset_pending. The driver does not have a mechanism to clear this type
>>> of error. As a result, the driver considers that the reset is not
>>> complete. This patch provides a mechanism to clear the
>>> HNAE3_NONE_RESET flag and the parameter of
>>> hnae3_ae_ops.set_default_reset_request is verified.
>>>
>>> The error message:
>>> hns3 0000:39:01.0: cmd failed -16
>>> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
>>> hns3 0000:39:01.0: failed to reset VF stack
>>> hns3 0000:39:01.0: failed to reset VF(4)
>>> hns3 0000:39:01.0: prepare reset(2) wait done
>>> hns3 0000:39:01.0 eth4: already uninitialized
>>>
>>> Use the crash tool to view struct hclgevf_dev:
>>> struct hclgevf_dev {
>>> ...
>>> 	default_reset_request = 0x20,
>>> 	reset_level = HNAE3_NONE_RESET,
>>> 	reset_pending = 0x100,
>>> 	reset_type = HNAE3_NONE_RESET,
>>> ...
>>> };
>>>
>>> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
>>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> I haven't signed-off this patch.
>
> Still no need to repost (yet) for this if the following points are
> solved rapidly (as I may end-up merging the series and really adding my
> SoB), but please avoid this kind of issue in the future.

Sorry, the patch is fotmated from the patch that has been accpected.
So SOB is added automatically. I will delete the SOB in next version.

>
>>> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
>>>   		return false;
>>>   	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
>>>   		hdev->rst_stats.reset_fail_cnt++;
>>> -		set_bit(hdev->reset_type, &hdev->reset_pending);
>>> +		hclge_set_reset_pending(hdev, hdev->reset_type);
>> Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
>> no reset? If yes, why in this case reset_fail_cnt++ is increasing?
>>
>> Maybe the check for NONE_RESET should be done in this else if check to
>> prevent reset_fail_cnt from increasing (and also solve the problem with
>> pending bit set)
> @Michal: I don't understand your comment above. hclge_reset_err_handle()
> handles attempted reset failures. I don't see it triggered when
> reset_type == HNAE3_NONE_RESET.
>
>>> @@ -4470,8 +4483,20 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
>>>   static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
>>>   					enum hnae3_reset_type rst_type)
>>>   {
>>> +#define HCLGE_SUPPORT_RESET_TYPE \
>>> +	(BIT(HNAE3_FLR_RESET) | BIT(HNAE3_FUNC_RESET) | \
>>> +	BIT(HNAE3_GLOBAL_RESET) | BIT(HNAE3_IMP_RESET))
>>> +
>>>   	struct hclge_dev *hdev = ae_dev->priv;
>>>   
>>> +	if (!(BIT(rst_type) & HCLGE_SUPPORT_RESET_TYPE)) {
>>> +		/* To prevent reset triggered by hclge_reset_event */
>>> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
>>> +		dev_warn(&hdev->pdev->dev, "unsupported reset type %d\n",
>>> +			 rst_type);
>>> +		return;
>>> +	}
>> Maybe (nit):
>> if (...) {
>> 	rst_type =
>> 	dev_warn();
>> }
>>
>> set_bit(rst_type, );
>> It is a little hard to follow with return in the if.
> @Michal: I personally find the patch code quite readable, do you have
> strong opinions here?
>
>>>   	set_bit(rst_type, &hdev->default_reset_request);
>>>   }
>>>   
>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> index 2f6ffb88e700..fd0abe37fdd7 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> @@ -1393,6 +1393,17 @@ static int hclgevf_notify_roce_client(struct hclgevf_dev *hdev,
>>>   	return ret;
>>>   }
>>>   
>>> +static void hclgevf_set_reset_pending(struct hclgevf_dev *hdev,
>>> +				      enum hnae3_reset_type reset_type)
>>> +{
>>> +	/* When an incorrect reset type is executed, the get_reset_level
>>> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
>>> +	 * type do not need to pending.
>>> +	 */
>>> +	if (reset_type != HNAE3_NONE_RESET)
>>> +		set_bit(reset_type, &hdev->reset_pending);
>>> +}
>> You already have a way to share the code between PF and VF, so please
>> move the same functions to common file in one direction up.
> AFAICS this can't be shared short of a large refactor not suitable for
> net as the functions eligible for sharing operate on different structs
> with different layout (hclgevf_dev vs hclge_dev). Currently all the
> shared code operates on shared structs.
>
> Cheers,

Yes, Paolo is right, this function cannot be shared.

Thanks，
Jijie Shao

>
> Paolo
>
>

