Return-Path: <netdev+bounces-284709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PnbKMXa+mnYTQMAu9opvQ
	(envelope-from <netdev+bounces-284709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D84D674C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF67301AA5C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BA3033FD;
	Wed,  6 May 2026 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1YWlQDc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED733016F2;
	Wed,  6 May 2026 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047682; cv=none; b=F2Yr56rI2+Kns/xE/Itj/3HL48GgUEVdDChqTrwrhfMOjRM9YnZ6X+dgrSTgrHKOpoMI74CvJKbu9C58Jmc8pCm5hX+65xk8pOxJAo5REz8A7Osb43Yflkur4TzDxFD7aHkTPJxi1/ee4xa7GnNLcC9UhUAUZcZCAQcW1SqsW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047682; c=relaxed/simple;
	bh=3ocJ7eGs7rV3DoF7D9r//mE2xjPMFa5UeFuNQI5fVWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6oVpmx1Hi45Uoq1WsysJTHsanrFVQd+AaI75VOJByKDjsXp1/L2ExiOO+IHpvZ6D631cajFSoBhiYsE86f39ujciynzxcS2nLLPm+AXGcIaWtFT7hGx72fPgMZpcd9vabJEKZxEDmU4UDzkpMgHXi3K3tVcudGheoJG7SDZgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1YWlQDc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778047680; x=1809583680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ocJ7eGs7rV3DoF7D9r//mE2xjPMFa5UeFuNQI5fVWk=;
  b=a1YWlQDc0/VnVrzz75YKYkWypldCSqlHYJhi3+EF75tXP9+L3YK8sScZ
   v2qIwOJDc5dYbmHgrVSZXYRHOvc9w99eGUZg+o1F+mg9cjzuP/PAKbuJZ
   vFqHuSsW9T50IJjkzwFIIDdgoymuMae8d+QRMdCjVfsKIdEY/WVvhFvYl
   z9685xQxD5YUmKmDJ4CnwUXdJ1zR8tcnIwLtZGLcrSoHGNwh58g7uNEHC
   OpxwALImIiAamosrZpjZ58tYl4W3VrCbYcNorLCy67jHVR6/VLidWeciO
   rODE71PWf0XU1EDsnH/BjZlSHVdmRa3ZhnzBcy+YjlBUNTAVigKTKT6xx
   Q==;
X-CSE-ConnectionGUID: My3CD3hsRnaPDTWV0EpjPw==
X-CSE-MsgGUID: 5EiUhiTbSOSheGR6GBmXUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89247450"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89247450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:08:00 -0700
X-CSE-ConnectionGUID: GFIFB15hQMWeag8Ieo1NqQ==
X-CSE-MsgGUID: saKn+QjaRCGwwoiWrBMWNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="274163659"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.37.237]) ([10.247.37.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:07:57 -0700
Message-ID: <9645f07a-a124-4c0e-b88c-e4262e1b2df0@linux.intel.com>
Date: Wed, 6 May 2026 14:07:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
 autoneg_failed field
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: khai.wen.tan@linux.intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
 <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
 <84b4f8bb-3c8c-4098-bc7f-7e9fd248c5ca@linux.intel.com>
 <d3d4915c-1bc5-4e04-bfc4-9d9787849c6f@molgen.mpg.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <d3d4915c-1bc5-4e04-bfc4-9d9787849c6f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 873D84D674C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]



On 28/4/2026 11:06 pm, Paul Menzel wrote:
> Dear Faizal,
> 
> 
> Am 28.04.26 um 12:39 schrieb Abdul Rahim, Faizal:
> 
>> On 28/4/2026 2:56 pm, Paul Menzel wrote:
> 
>>> Am 28.04.26 um 08:00 schrieb KhaiWenTan:
>>>
>>> (Should spaces be added in your name?)
>>>
>>>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>>
>>>> autoneg_failed in struct igc_mac_info is never set in the igc driver.
>>>> Remove the field and the dead code checking it in
>>>> igc_config_fc_after_link_up().
>>>
>>> Could you please elaborate. Why is removal the correct fix, and it’s not
>>> an incomplete feature? Does auto-negotiation always succeed?
>>
>> Auto-negotiation does not always succeed, but igc does not use
>> autoneg_failed to handle that case, the field was never set anywhere
>> in the igc driver.
>>
>> Before this patch, the only igc references to autoneg_failed were
>> the struct member declaration and the read in
>> igc_config_fc_after_link_up(). No igc code ever assigned it to true,
>> and git history shows no commit that added a setter since the code
>> creation in 2018.
>>
>> The field originates from the e1000/e1000e fiber/serdes forced-link
>> path: when MAC-level auto-negotiation on fiber times out, the driver
>> forces link up and sets autoneg_failed so the flow-control code knows
>> pause was not negotiated and must be forced. igc has no fiber or
>> serdes media, it only supports copper (igc_media_type_copper), so
>> the code that sets autoneg_failed was never ported.
>>
>> On copper, PHY auto-negotiation failure is handled differently:
>> - No link at all: igc_check_for_copper_link() returns before reaching
>>    flow-control configuration, there's nothing to configure FC on.
>> - Link present but autoneg not yet complete:
>>    igc_config_fc_after_link_up() checks MII_SR_AUTONEG_COMPLETE and
>>    returns early without resolving pause. The next link-status event
>>    re-triggers the check.
>> - Autoneg completes (including via parallel detection fallback when
>>    the link partner doesn't autoneg): the PHY still sets
>>    AUTONEG_COMPLETE but LP_ABILITY won't have PAUSE bits since the
>>    partner never sent autoneg pages. The existing flow-control logic
>>    in igc_config_fc_after_link_up() handles that correctly, it falls
>>    through to igc_fc_none or igc_fc_rx_pause based on requested_mode.
>>
>> None of these paths need autoneg_failed. Keeping the field would be
>> misleading to reader.
> 
> Thank you. For me the information about just supporting copper would be
> great to have in the commit message.

Will update.

> 
>>>> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
>>>
>>> Please order it to not use the comma: Hong Aun Looi
>>
>> Will do, thanks.
>>
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
>>>>   drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>>>>   2 files changed, 1 insertion(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/
>>>> ethernet/intel/igc/igc_hw.h
>>>> index be8a49a86d09..86ab8f566f44 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
>>>> @@ -92,7 +92,6 @@ struct igc_mac_info {
>>>>       bool asf_firmware_present;
>>>>       bool arc_subsystem_valid;
>>>>
>>>> -    bool autoneg_failed;
>>>>       bool get_link_status;
>>>>   };
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/
>>>> ethernet/intel/igc/igc_mac.c
>>>> index 7ac6637f8db7..142beb9ae557 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>>>> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
>>>>    * Checks the status of auto-negotiation after link up to ensure that
>>>> the
> 
> Just for your information, that your mailer wraps the lines of the quotes.

Ohh okay, let me check, thanks!

> […]
> 
>>>>    * speed and duplex were not forced.  If the link needed to be
>>>> forced, then
>>>>    * flow control needs to be forced also.  If auto-negotiation is enabled
>>>> - * and did not fail, then we configure flow control based on our link
>>>> - * partner.
>>>> + * then we configure flow control based on our link partner.
>>>>    */
>>>>   s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>>>   {
>>>>       u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
>>>> -    struct igc_mac_info *mac = &hw->mac;
>>>>       u16 speed, duplex;
>>>>       s32 ret_val = 0;
>>>>
>>>> -    /* Check for the case where we have fiber media and auto-neg failed
>>>> -     * so we had to force link.  In this case, we need to force the
>>>> -     * configuration of the MAC to match the "fc" parameter.
>>>> -     */
>>>> -    if (mac->autoneg_failed)
>>>> -        ret_val = igc_force_mac_fc(hw);
>>>> -
>>>> -    if (ret_val) {
>>>> -        hw_dbg("Error forcing flow control settings\n");
>>>> -        goto out;
>>>> -    }
>>>> -
>>>>       /* In auto-neg, we need to check and see if Auto-Neg has completed,
>>>>        * and if so, how the PHY and link partner has flow control
>>>>        * configured.
> 
> Kind regards,
> 
> Paul
> 


