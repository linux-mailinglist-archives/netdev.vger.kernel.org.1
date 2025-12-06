Return-Path: <netdev+bounces-243890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C7CA9F24
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 03:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F9130AE9BF
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494881C84BB;
	Sat,  6 Dec 2025 02:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15577.qiye.163.com (mail-m15577.qiye.163.com [101.71.155.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF45EAE7;
	Sat,  6 Dec 2025 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764989280; cv=none; b=GO6MQ80q7aCfyLYrPRfgU9c6XWRldy7Zqb0eHSUw74jIi0DyoeUUPgQI8QuPUyPifn5HToPaZE30pF0EAzWqe46jyaUSSCpxXljQpx5Q0GXo5okQFGie4a223CYy/1E/bpT2CEENWySy7nJjvhupN0tkOY/e/CrmVUw1yBhbPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764989280; c=relaxed/simple;
	bh=n5YuQKgp8fL3mvG32Z4syWXkR++rj/MltpujctzztrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1CWo23HVIbBWotvkVAGxRAc6nAdqR7YeY7pNcOhU5gsBBenDAYiMSlFfqpwARFoXQPMa21cySOZfnFmjFWhqb5TjN7biQc6S1hdbFaLxoaBHQsgoucWIQc5nlIrtRhmrI5RS5exgeuMm7+hHDZjyPBI1QvKllkWZmIpH3aLojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=101.71.155.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.68.66] (unknown [43.247.70.80])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c32c9789;
	Sat, 6 Dec 2025 10:42:37 +0800 (GMT+08:00)
Message-ID: <1188a9d2-a895-478b-9474-0fb84b4e2636@sangfor.com.cn>
Date: Sat, 6 Dec 2025 10:42:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout in
 ice_release_res()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <IA3PR11MB898665810DD47854F80941A7E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9af18a337109d9kunm66339721144a441
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxofVkxDTBkdHRhLHR5DH1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0tZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++

On 2025/12/6 5:09, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Ding Hui
>> Sent: Friday, December 5, 2025 9:16 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; Keller, Jacob E <jacob.e.keller@intel.com>; intel-
>> wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ding, Hui
>> <dinghui@sangfor.com.cn>
>> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout
>> in ice_release_res()
>>
>> The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
>> ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
>> to microseconds.
>>
>> But the ice_release_res() function was missed, and its logic still
>> treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
>>
>> So correct the issue by usecs_to_jiffies().
>>
> 
> Please add a brief "how verified" paragraph (platform + steps).
> This is a unit-conversion fix in a timeout path; a short test description helps reviewers and stable backports validate the change.
> 
Sorry for not being able to provide the verification information, as
I haven't actually encountered this issue.

The ice_release_res() is almost always invoked during downloading DDP
when modprobe ice.

IMO, it seems like that only when the NIC hardware or firmware enters
a bad state causing single command to fail or timeout (1 second), and
then here do the retry logic (10 senconds).

So it's hard to validate on healthy NIC, maybe inject faults in low level
function, such as ice_sq_send_cmd().

> And you can add my:
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> 
>> Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
>> ice_sq_done timeout")
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
>> b/drivers/net/ethernet/intel/ice/ice_common.c
>> index 6fb0c1e8ae7c..5005c299deb1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum
>> ice_aq_res_ids res)
>>   	/* there are some rare cases when trying to release the
>> resource
>>   	 * results in an admin queue timeout, so handle them correctly
>>   	 */
>> -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
>> +	timeout = jiffies + 10 *
>> usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
>>   	do {
>>   		status = ice_aq_release_res(hw, res, 0, NULL);
>>   		if (status != -EIO)
>> --
>> 2.17.1
> 
> 
> 

-- 
Thanks,
- Ding Hui


