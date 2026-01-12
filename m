Return-Path: <netdev+bounces-248973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDDD123EC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497243080F76
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF33563CF;
	Mon, 12 Jan 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lI52NzFo"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAE3563E5
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216562; cv=none; b=JsdFIVsj19yVZheUbe6iO/zv5nMWVatQo2tWuCsYupA6eh+Ts0sMpt3ca3yYweq4zn8B22+A+D7U4cxlIf5Jd7rgc3bdUGhvQguyA0BDIMLcLnFraEOqfIPDsMDtTGkIAtrJ9366M7InymuFnQ4m36qbGBzuJwuaCuwEAqrDM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216562; c=relaxed/simple;
	bh=Db+JLgfhgPbrmjm+BvY1BCZxrocDTkbXnQO8sRkgvm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGW0Pu5XHrDfaAUBMCC+0wRHH6srYCPCNiySB4Hm2MODp7U3/RJwGP25w43OaWgHwQITsHR+tbcqfVWKgvUPikBrxiz/cFtp/ireSF+1+jHq/H+Ovn3FXAGUhgU6uc2Xut8Q/9vQZ6hGU3H4n3wsId/0p+V4yqphEbU441CXx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lI52NzFo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <979e42ca-66fb-4ca6-b68f-c10b4e441369@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768216557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxfb4Bn1vJD8qml0fHR5DFLihS+BAFpThU3mlxgfg/A=;
	b=lI52NzFo2hu8Jv99Ed37qm8sEEcS1UKMPUTjQI2UstbP8Tt+096KhV+XmuHv0UzGNU0jLC
	ki2cctM7L81XTBi7cOZZ1W5qY/goa6ru0T2YrFkp64WIiLmy2dczbaENNRd0mOw7Zm5PAv
	caaCQXoGN9zCN2WHEYTxXpp7abdWz4w=
Date: Mon, 12 Jan 2026 11:15:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ice: fix setting RSS VSI hash for E830
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
 <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
 <1e162d79-20a2-4de3-8862-aa4fbe842132@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <1e162d79-20a2-4de3-8862-aa4fbe842132@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 09:36, Marcin Szycik wrote:
> 
> 
> On 09.01.2026 17:44, Vadim Fedorenko wrote:
>> On 09/01/2026 08:53, Marcin Szycik wrote:
>>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>>> mistakenly set to the value of another field, instead of its original
>>> value, probably due to a typo. What happens next is hardware-dependent:
>>>
>>> On E810, only the first bit is meaningful (see
>>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>>> state than before VSI update.
>>>
>>> On E830, some of the remaining bits are not reserved. Setting them
>>> to some unrelated values can cause the firmware to reject the update
>>> because of invalid settings, or worse - succeed.
>>>
>>> Reproducer:
>>>     sudo ethtool -X $PF1 equal 8
>>>
>>> Output in dmesg:
>>>     Failed to configure RSS hash for VSI 6, error -5
>>>
>>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>> index cf8ba5a85384..08268f1a03da 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>> @@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>>        ctx->info.q_opt_rss |=
>>>            FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>>        ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>>> -    ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>>> +    ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>>
>> The very same typo pattern is in ice_vc_handle_rss_cfg() in
>> ice/virt/rss.c
>>
>> I believe both places have to be fixed.
> 
> Hmm... where exactly? ice_vc_rss_hash_update() (called from ice_vc_handle_rss_cfg()) looks correct.

Sorry, it was fixed in 3a6d87e2eaac ("ice: implement GTP RSS context
tracking and configuration") when the logic was moved to
ice_vc_rss_hash_update(), but this code was never backported, the
problem exists in 6.18...

> 
> Thanks for reviewing,
> Marcin
> 
>>
>>>          err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>>        if (err) {
>>
> 


