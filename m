Return-Path: <netdev+bounces-153335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6E9F7B41
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C6C7A26C3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531402236F6;
	Thu, 19 Dec 2024 12:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F71EA90;
	Thu, 19 Dec 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611213; cv=none; b=jAl2YVamVAo1oFr/frIARtSq8HSVXJYZ0Js6tVMiNaddaKY7jcqBoDjkA6f+cYpCIRvg2pZAX/FBuM9rUOr7jLTYv2PJgr5stpDj7o18c/l7MTitH9II9T1RXmflH/L6cuqLGDStNTCtYpsKOBCQ01SzH+Sb4QnY9XHLVBALrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611213; c=relaxed/simple;
	bh=FOyJbgLN3SI3M2ed+uWBrsn19+l8pqoyS3cGW5BUKQo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OG/ghNbwkrootPU7yxT31Twjl66Y2OAplOfdfLUvK1kMkWhJUFG/ofw2uDKrfOf65yPEzxOIKoqwqnxqPwmjJoA+iG8BAFZsYEJEcCLJ4eVTdiglXm0c4mwE0zknvhfNqwm10NgtzA4Bd8r67bFWafDrUs5paqp/7V3eaxrfVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YDV9d39kczRjR1;
	Thu, 19 Dec 2024 20:24:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A1FF180101;
	Thu, 19 Dec 2024 20:26:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 20:26:46 +0800
Message-ID: <08171da0-7a81-4bf2-89c2-b9da9e4367e2@huawei.com>
Date: Thu, 19 Dec 2024 20:26:45 +0800
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
 <Z2PxQ8A5DObivci8@mev-dev.igk.intel.com>
 <85e10807-c2ea-41c8-a5b1-64105f7f30ce@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <85e10807-c2ea-41c8-a5b1-64105f7f30ce@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/19 18:43, Paolo Abeni wrote:
> On 12/19/24 11:11, Michal Swiatkowski wrote:
>> On Thu, Dec 19, 2024 at 10:41:53AM +0100, Paolo Abeni wrote:
>>> On 12/18/24 10:02, Michal Swiatkowski wrote:
>>>> On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
>>>>> From: Hao Lan <lanhao@huawei.com>
>>>>>
>>>>> When a reset type that is not supported by the driver is input, a reset
>>>>> pending flag bit of the HNAE3_NONE_RESET type is generated in
>>>>> reset_pending. The driver does not have a mechanism to clear this type
>>>>> of error. As a result, the driver considers that the reset is not
>>>>> complete. This patch provides a mechanism to clear the
>>>>> HNAE3_NONE_RESET flag and the parameter of
>>>>> hnae3_ae_ops.set_default_reset_request is verified.
>>>>>
>>>>> The error message:
>>>>> hns3 0000:39:01.0: cmd failed -16
>>>>> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
>>>>> hns3 0000:39:01.0: failed to reset VF stack
>>>>> hns3 0000:39:01.0: failed to reset VF(4)
>>>>> hns3 0000:39:01.0: prepare reset(2) wait done
>>>>> hns3 0000:39:01.0 eth4: already uninitialized
>>>>>
>>>>> Use the crash tool to view struct hclgevf_dev:
>>>>> struct hclgevf_dev {
>>>>> ...
>>>>> 	default_reset_request = 0x20,
>>>>> 	reset_level = HNAE3_NONE_RESET,
>>>>> 	reset_pending = 0x100,
>>>>> 	reset_type = HNAE3_NONE_RESET,
>>>>> ...
>>>>> };
>>>>>
>>>>> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
>>>>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> I haven't signed-off this patch.
>>>
>>> Still no need to repost (yet) for this if the following points are
>>> solved rapidly (as I may end-up merging the series and really adding my
>>> SoB), but please avoid this kind of issue in the future.
>>>
>>>>> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
>>>>>   		return false;
>>>>>   	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
>>>>>   		hdev->rst_stats.reset_fail_cnt++;
>>>>> -		set_bit(hdev->reset_type, &hdev->reset_pending);
>>>>> +		hclge_set_reset_pending(hdev, hdev->reset_type);
>>>> Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
>>>> no reset? If yes, why in this case reset_fail_cnt++ is increasing?
>>>>
>>>> Maybe the check for NONE_RESET should be done in this else if check to
>>>> prevent reset_fail_cnt from increasing (and also solve the problem with
>>>> pending bit set)
>>> @Michal: I don't understand your comment above. hclge_reset_err_handle()
>>> handles attempted reset failures. I don't see it triggered when
>>> reset_type == HNAE3_NONE_RESET.
>>>
>> Maybe I missed sth. The hclge_set_reset_pending() is added to check if
>> reset type isn't HNAE3_NONE_RESET. If it is the set_bit isn't called. It
>> is the only place where hclge_set_reset_pending() is called with a
>> variable, so I assumed the fix is for this place.
>>
>> This means that code can be reach here with HNAE3_NONE_RESET which is
>> unclear for me why to increment resets if rest_type in NONE. If it is
>> true that hclge_reset_err_handle() is never called with reset_type
>> HNAE3_NONE_RESET it shouldn't be needed to have the
>> hclge_set_reset_pending() function.
> You are right, I felt off-track.
>
> @Jijie: how can 'reset_type' be set to an unsupported value?!? I don't
> see that in the code, short of a memory corruption on uninit problem.
> Are you sure you are not papering over a different issue here? At least
> some more info (either in the commit description or in a code comment)
> is IMHO needed. Otherwise you should probably catch that before
> hclge_reset_err_handle() time.

Thanks for reviewing the code.

In fact, we used hclge_set_reset_pendin() to check in entire reset path,
not just hclge_reset_err_handle().

But seems like overkill, I'll try to simplify the modification.

Thank you.

Jiejie Shao


