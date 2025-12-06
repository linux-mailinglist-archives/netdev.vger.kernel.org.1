Return-Path: <netdev+bounces-243908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE8CAA6A6
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 14:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BABF03011FB5
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CD2F3C27;
	Sat,  6 Dec 2025 13:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998329D269;
	Sat,  6 Dec 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765026578; cv=none; b=AUl8PYyUYQSgrMzmTU8pmSSZl6JAFaNou3BkAKHVsF27GDy1OXlzYQoVy0yoD32mTzVwBDVw2v2nHE5GYw8nq5zhr8W5Qj9ZYqdM4DqguseFyu3jPpQzrdWzCnSicPsPOi+GaIbpTRCzOsf9Hw76vp2Bj4JxJej4PT2GjGuUSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765026578; c=relaxed/simple;
	bh=DcaS9iHewSnmOdLQxkykP57nbS2FRWKDM/VEhfD4hDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq8Zj8tX2nHuMR+jVj9f4snpyFMFqNJUAMl0Rie/qRmPWnBXkg1wwiJnoYx5fb0pjdoIwvMvjhxlNK7GOlq/ZVPis/ZBGvjPFwnubTtGT3k4/fgiWrfeSJx588uDp7IKY7Er6lz6b1fnaIoj1UT+oHHTLtIox944DWyzkp9snnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [192.168.1.38] (unknown [113.92.158.29])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c3a7d440;
	Sat, 6 Dec 2025 21:09:19 +0800 (GMT+08:00)
Message-ID: <568da81f-d892-4921-ac87-2a2de78c422a@sangfor.com.cn>
Date: Sat, 6 Dec 2025 21:08:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout in
 ice_release_res()
To: Simon Horman <horms@kernel.org>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org"
 <kuba@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20251205081609.23091-1-dinghui@sangfor.com.cn>
 <IA3PR11MB898665810DD47854F80941A7E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <1188a9d2-a895-478b-9474-0fb84b4e2636@sangfor.com.cn>
 <aTP7g5lmRMF5YtQO@horms.kernel.org>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <aTP7g5lmRMF5YtQO@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9af3c7f62409d9kunm9be59ed3188bf97
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSU9LVkxITU8eT0tMHUoZHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkhVQklVSk5DVUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

On 2025/12/6 17:46, Simon Horman wrote:
> On Sat, Dec 06, 2025 at 10:42:36AM +0800, Ding Hui wrote:
>> On 2025/12/6 5:09, Loktionov, Aleksandr wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>>>> Of Ding Hui
>>>> Sent: Friday, December 5, 2025 9:16 AM
>>>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>>>> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>>>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>>>> pabeni@redhat.com; Keller, Jacob E <jacob.e.keller@intel.com>; intel-
>>>> wired-lan@lists.osuosl.org
>>>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ding, Hui
>>>> <dinghui@sangfor.com.cn>
>>>> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout
>>>> in ice_release_res()
>>>>
>>>> The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
>>>> ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
>>>> to microseconds.
>>>>
>>>> But the ice_release_res() function was missed, and its logic still
>>>> treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
>>>>
>>>> So correct the issue by usecs_to_jiffies().
>>>>
>>>
>>> Please add a brief "how verified" paragraph (platform + steps).
>>> This is a unit-conversion fix in a timeout path; a short test description helps reviewers and stable backports validate the change.
>>>
>> Sorry for not being able to provide the verification information, as
>> I haven't actually encountered this issue.
>>
>> The ice_release_res() is almost always invoked during downloading DDP
>> when modprobe ice.
>>
>> IMO, it seems like that only when the NIC hardware or firmware enters
>> a bad state causing single command to fail or timeout (1 second), and
>> then here do the retry logic (10 senconds).
>>
>> So it's hard to validate on healthy NIC, maybe inject faults in low level
>> function, such as ice_sq_send_cmd().
> 
> In that case I would suggest adding something like this:
> 
> Found by inspection (or static analysis, or a specific tool if publicly
> available, ...).
> Compile tested only.
> 

Sure, I'll send v2 later.

>>
>>> And you can add my:
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>
>>>
>>>> Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
>>>> ice_sq_done timeout")
>>>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>>>> ---
>>>>    drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
>>>> b/drivers/net/ethernet/intel/ice/ice_common.c
>>>> index 6fb0c1e8ae7c..5005c299deb1 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>>>> @@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum
>>>> ice_aq_res_ids res)
>>>>    	/* there are some rare cases when trying to release the
>>>> resource
>>>>    	 * results in an admin queue timeout, so handle them correctly
>>>>    	 */
>>>> -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
>>>> +	timeout = jiffies + 10 *
>>>> usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
>>>>    	do {
>>>>    		status = ice_aq_release_res(hw, res, 0, NULL);
>>>>    		if (status != -EIO)
>>>> --
>>>> 2.17.1
>>>
>>>
>>>
>>
>> -- 
>> Thanks,
>> - Ding Hui
>>
>>
> 
> 

-- 
Thanks,
-dinghui


