Return-Path: <netdev+bounces-243891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A7CAA141
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 06:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4315230532BD
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05A16D9C2;
	Sat,  6 Dec 2025 05:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055724414;
	Sat,  6 Dec 2025 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764998393; cv=none; b=cpoknVugDC1TBdDq2SBpOgwaU6TAzr6HvhZyigGtFFHc2IOYgzh9J0QXr3XwNGPIot7VNNXNE/5gwZ64uzx0nG0je88B6KBQx1W35o5gDEvKwCfxsZPOTF4tY7PuRdZtTqhWPejNvgJ66wXIO6OoxHIF090efRJxY+tCAzPcb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764998393; c=relaxed/simple;
	bh=0BPdBzeqG9QpISRNQrcc51u2AJ4rbOKcGauC5xlLFZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tya0BhAr5Cl519MSw1xxYH/DPc0/4v8yFwcyt0KSR8jmC5BpRm4ui1Iqre9ZgchOPX00ndrm2EXVfHVD3pJeauyGrO/EWzbM04sO8ZbXRvmYNQUSckMOocdT+hiS2fBZb00tcAV5ibOKBTiTAk1bJy/Cwd7520MrSLaDIo+ocWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.68.66] (unknown [43.247.70.80])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c31e3f3a;
	Sat, 6 Dec 2025 09:50:25 +0800 (GMT+08:00)
Message-ID: <528656fe-7a85-46ec-9e73-7e05c144026f@sangfor.com.cn>
Date: Sat, 6 Dec 2025 09:50:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: Fix incorrect timeout in ice_release_res()
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205081609.23091-1-dinghui@sangfor.com.cn>
 <aTMFRkYZGtk3a_EP@horms.kernel.org>
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <aTMFRkYZGtk3a_EP@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9af15a672e09d9kunm9d8187fe140c881
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh0fVh9OTxgZGBkZTBlNTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0tZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++

On 2025/12/6 0:16, Simon Horman wrote:
> On Fri, Dec 05, 2025 at 04:16:08PM +0800, Ding Hui wrote:
>> The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
>> ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
>> to microseconds.
>>
>> But the ice_release_res() function was missed, and its logic still
>> treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
>>
>> So correct the issue by usecs_to_jiffies().
>>
>> Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
>> Signed-off-by: Ding Hui<dinghui@sangfor.com.cn>
> Thanks,
> 
> I agree with the analysis above and that the problem was introduced
> by the cited commit.
> 
> As a fix for code present in net this should probably be targeted
> at net (or iwl-net?) rather than net-next. But perhaps there is
> no need to repost just to address that.
> 

Sorry, I mixed up the purposes of the net and net-next branches, thank
you for pointing that out, it should be net.
I'll keep that in mind in the future.

>> ---
>>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>> index 6fb0c1e8ae7c..5005c299deb1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
>>   	/* there are some rare cases when trying to release the resource
>>   	 * results in an admin queue timeout, so handle them correctly
>>   	 */
>> -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
>> +	timeout = jiffies + 10 * usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
>>   	do {
>>   		status = ice_aq_release_res(hw, res, 0, NULL);
>>   		if (status != -EIO)
> I agree this minimal change is appropriate as a bug fix.
> 
> But I think that it would be good to provide a follow-up
> that reworks this code a bit to to use read_poll_timeout().
> As per the aim of the cited commit.
> 

Actually, the ice_aq_release_res() called by ice_release_res() already
implements the underlying logic via read_poll_timeout() by that commit,
and here is primarily responsible for retrying the important release
command.

> This should be targeted at net-next (or iwl-next?).
> Once this bug fix propagates to in net-next.
> 
> Reviewed-by: Simon Horman<horms@kernel.org>
> 
> 

-- 
Thanks,
- Ding Hui


