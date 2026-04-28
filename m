Return-Path: <netdev+bounces-281785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEMnCZiP8Gl4UwEAu9opvQ
	(envelope-from <netdev+bounces-281785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873B482E2C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDC03006159
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793333E5ED7;
	Tue, 28 Apr 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYwOZAqw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95B3E0C5A;
	Tue, 28 Apr 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372755; cv=none; b=ph8zNLc0BtJD/qrlnAghlf/E/vJOiClFCSULgwLP848jDS0kBXaBIoXFNXbSYanBMtRSFme4MzgzYzKXA16wUAqtcW0nyPR4yyIy8FdNvA6gXSNziFbf4laE5wmMl0lMayQhGDy+InL4bTAGdxuuJGJBw9WX1wqomv6asZAmBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372755; c=relaxed/simple;
	bh=Bgc9zNw8/VIIqORJYTIMHdUjkk5pjcVenC5PsPgEqi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdBdNvNAKz4V2SYx3+H+WuozpRSh71N0PLr08oKmH2UvjG0OctwMIe7fJfSVJbpZpuToFj+hqBv4QdnTdSA5S7OVfl8FKYrdXDiW9u0WYsWHAoIN5AjKXg9x8aa06IonjqJkSnxX7ATjZ3sI3y1iF/Vp14OnBXD8KfN/5RnNt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYwOZAqw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777372754; x=1808908754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bgc9zNw8/VIIqORJYTIMHdUjkk5pjcVenC5PsPgEqi8=;
  b=OYwOZAqwpQhGYpftplENX2d9cWM0+hyvNX6thfvE2qEXvkJXvvGadM8Z
   /h3A4eg1fnVPMcL+7/fCeXkJ7VSJcBnUsCnq+t9nDR9QyHl/BkP+vFUin
   /Tkdw5Y+4PK2XxyTdSXYLtcYvO5CLT+SDrNI2JJcw6Cc0U5WtS6RlTVF8
   rNTFgQutJX3P/Rouc8qwi+OmVPd2nOMmJrJ9aOFPMsiZRDdUts+5CA5bl
   DCNc8eiOHs6LXVSXj7mT8HCkOdao0U04hEvwTo2d2KGgZIZ0SAQdfHE2x
   deWioRrsMZRsqc5sRcPgt6vc3+T6heyfBN5pb7Y5eTmVM3nhWEkd0Dvf9
   g==;
X-CSE-ConnectionGUID: b9d+Ua6vR2KXvcPFS9Zs6A==
X-CSE-MsgGUID: aJ8bGpsRQpKAuGO9QNavGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82129661"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82129661"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:39:13 -0700
X-CSE-ConnectionGUID: b4j4xyRwTby95FsK2JPPBw==
X-CSE-MsgGUID: +lgNgHwhSai15uUy7ChhtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="231273121"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.81.233]) ([10.247.81.233])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:39:09 -0700
Message-ID: <84b4f8bb-3c8c-4098-bc7f-7e9fd248c5ca@linux.intel.com>
Date: Tue, 28 Apr 2026 18:39:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
 autoneg_failed field
To: Paul Menzel <pmenzel@molgen.mpg.de>, khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
 <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6873B482E2C
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
	TAGGED_FROM(0.00)[bounces-281785-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]


Hi Paul,

Thank you for your review.

On 28/4/2026 2:56 pm, Paul Menzel wrote:
> [Cc: Removed stray *Looi*]
> 
> Dear Khai Wen Tan,
> 
> 
> Thank you for your patch.
> 
> 
> Am 28.04.26 um 08:00 schrieb KhaiWenTan:
> 
> (Should spaces be added in your name?)
> 
>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>
>> autoneg_failed in struct igc_mac_info is never set in the igc driver.
>> Remove the field and the dead code checking it in
>> igc_config_fc_after_link_up().
> 
> Could you please elaborate. Why is removal the correct fix, and it’s not an 
> incomplete feature? Does auto-negotiation always succeed?
> 

Auto-negotiation does not always succeed, but igc does not use
autoneg_failed to handle that case, the field was never set anywhere
in the igc driver.

Before this patch, the only igc references to autoneg_failed were
the struct member declaration and the read in
igc_config_fc_after_link_up(). No igc code ever assigned it to true,
and git history shows no commit that added a setter since the code
creation in 2018.

The field originates from the e1000/e1000e fiber/serdes forced-link
path: when MAC-level auto-negotiation on fiber times out, the driver
forces link up and sets autoneg_failed so the flow-control code knows
pause was not negotiated and must be forced. igc has no fiber or
serdes media, it only supports copper (igc_media_type_copper), so
the code that sets autoneg_failed was never ported.

On copper, PHY auto-negotiation failure is handled differently:
- No link at all: igc_check_for_copper_link() returns before reaching
   flow-control configuration, there's nothing to configure FC on.
- Link present but autoneg not yet complete:
   igc_config_fc_after_link_up() checks MII_SR_AUTONEG_COMPLETE and
   returns early without resolving pause. The next link-status event
   re-triggers the check.
- Autoneg completes (including via parallel detection fallback when
   the link partner doesn't autoneg): the PHY still sets
   AUTONEG_COMPLETE but LP_ABILITY won't have PAUSE bits since the
   partner never sent autoneg pages. The existing flow-control logic
   in igc_config_fc_after_link_up() handles that correctly, it falls
   through to igc_fc_none or igc_fc_rx_pause based on requested_mode.

None of these paths need autoneg_failed. Keeping the field would be 
misleading to reader.


>> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
> 
> Please order it to not use the comma: Hong Aun Looi
> 

Will do, thanks.

>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
>>   drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>>   2 files changed, 1 insertion(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ 
>> ethernet/intel/igc/igc_hw.h
>> index be8a49a86d09..86ab8f566f44 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
>> @@ -92,7 +92,6 @@ struct igc_mac_info {
>>       bool asf_firmware_present;
>>       bool arc_subsystem_valid;
>>
>> -    bool autoneg_failed;
>>       bool get_link_status;
>>   };
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ 
>> ethernet/intel/igc/igc_mac.c
>> index 7ac6637f8db7..142beb9ae557 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
>>    * Checks the status of auto-negotiation after link up to ensure that the
>>    * speed and duplex were not forced.  If the link needed to be forced, 
>> then
>>    * flow control needs to be forced also.  If auto-negotiation is enabled
>> - * and did not fail, then we configure flow control based on our link
>> - * partner.
>> + * then we configure flow control based on our link partner.
>>    */
>>   s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>   {
>>       u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
>> -    struct igc_mac_info *mac = &hw->mac;
>>       u16 speed, duplex;
>>       s32 ret_val = 0;
>>
>> -    /* Check for the case where we have fiber media and auto-neg failed
>> -     * so we had to force link.  In this case, we need to force the
>> -     * configuration of the MAC to match the "fc" parameter.
>> -     */
>> -    if (mac->autoneg_failed)
>> -        ret_val = igc_force_mac_fc(hw);
>> -
>> -    if (ret_val) {
>> -        hw_dbg("Error forcing flow control settings\n");
>> -        goto out;
>> -    }
>> -
>>       /* In auto-neg, we need to check and see if Auto-Neg has completed,
>>        * and if so, how the PHY and link partner has flow control
>>        * configured.
> 
> 
> Kind regards,
> 
> Paul
> 


