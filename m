Return-Path: <netdev+bounces-169460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53F8A44085
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494411888804
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EF268FC2;
	Tue, 25 Feb 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8PnWe9A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247E20AF88
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489360; cv=none; b=g9uCy3xc7iWD/Fty2AmrICddo1gjlR5HIRnVcS/Ko03a8KDmFair+qQcQWg6Z5ikBFyYVnfM2pJGsMl5uVsFv6d2cnuZaUkqUX5WGsumWjNnguFCiu8UlUrvM/VwxLOPWWhxmpvCqXI+EVl//s7c3RS4c+O9yhoL1R9/8K/QqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489360; c=relaxed/simple;
	bh=BilTGQVbMAK56Cu8FXenUbyVQjZzgIqhrZu3KqOSndE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmpwbmJJHVfDMk94iRjUidC8CY71uyqAyj/c1/YA0XpsHoXHBaGfLh4zgWBTIhxDBiuHRZwtgJuE4ebbZv/RQ5MOM8QpzWTKDDiinI4EUjsACD02QaoM/+hleSrUUP0szN3/q5AajUErMRr5OIK1qEOJLGsHh6VylrO9yUPhztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8PnWe9A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740489358; x=1772025358;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BilTGQVbMAK56Cu8FXenUbyVQjZzgIqhrZu3KqOSndE=;
  b=C8PnWe9A1o82b0zNP1e7fsvZ3fTfkWmC/4QidMxO7xYgKA4tbbIDtKNL
   GjkDHINjK8sec4WHD8ji0DvanurkhMWaoxxc7a3zcVLXq8mTvJ/qE55pN
   5YLr90ueZnnQMdluWhl3ZoAbAPPKxLYqnsStzBQkCQKsqmNn9rGtYAkOZ
   86Y3Z3goiXFNw0yeZznMtr0jMe22V9yvYfqu5gON5jNPssbENAcpjotyF
   TCKzcmAdPO/w14Lb/gpJTfVnvP6yqmIeNDUoLM/eRPVNr3+yt9yYVSBCF
   HWoW/d6KV2LV33OQYmm80BLyMabT+qKEArnucx6U8CZZ3iMszkvhOjUXF
   Q==;
X-CSE-ConnectionGUID: D2/LurHAS5mRDIbLeve+6w==
X-CSE-MsgGUID: Wx2QKHgeSUWaGzdvmtKQyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="40479065"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="40479065"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:15:57 -0800
X-CSE-ConnectionGUID: VrtSALc7QgOMCQQz8zPGMw==
X-CSE-MsgGUID: pQizwE4yQ2KJTkkiNjohsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121358694"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.112.135]) ([10.245.112.135])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:15:56 -0800
Message-ID: <4583cf1b-46b0-4664-a0b3-f02331685955@linux.intel.com>
Date: Tue, 25 Feb 2025 14:15:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix fwlog after driver
 reinit
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250220150438.352642-3-martyna.szapar-mudlaw@linux.intel.com>
 <eb5e8d47-30ba-4b95-9b34-ba2de829e131@molgen.mpg.de>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <eb5e8d47-30ba-4b95-9b34-ba2de829e131@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/20/2025 9:11 PM, Paul Menzel wrote:
> Dear Martyna,
> 
> 
> Thank you for your patch.
> 
> Am 20.02.25 um 16:04 schrieb Martyna Szapar-Mudlaw:
>> Fix an issue when firmware logging stops after devlink reload action
>> driver_reinit or driver reset. Fix it by restoring fw logging when
> 
> Maybe elaborate, why/how driver reinit or reset disables fwlog.
>

ok, I can expand commit message

>> it was previously registered before these events.
> 
> I’d add a blank line between paragraphs.>

ok

>> Restoring fw logging in these cases was faultily removed with new
>> debugfs fw logging implementation.
>> Failure to init fw logging is not a critical error so it is safely
>> ignored.
> 
> How can this be tested?

By examining debugfs fwlog data file, information from fw is no longer 
logged to this file after driver reinit (devlink dev reload 
pci/{PCI_Bus} action driver_reinit). In patches 73671c3162c8 ("ice: 
enable FW logging") and 9d3535e71985 ("ice: add ability to read and 
configure FW log data") it is described how to enable and collect ice fw 
logs.
In case of failure during fwlog registration, debug prints indicating 
this are logged.

> 
>> Fixes: 73671c3162c8 ("ice: enable FW logging")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar- 
>> mudlaw@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ 
>> ethernet/intel/ice/ice_main.c
>> index a03e1819e6d5..6d6873003bcb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -5151,6 +5151,13 @@ int ice_load(struct ice_pf *pf)
>>       devl_assert_locked(priv_to_devlink(pf));
>> +    if (pf->hw.fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
>> +        err = ice_fwlog_register(&pf->hw);
>> +        if (err)
>> +            pf->hw.fwlog_cfg.options &=
>> +                ~ICE_FWLOG_OPTION_IS_REGISTERED;
> 
> Should an error be logged in the failure case?

ice_fwlog_register function already provides logs in case of failure

Thank you for the review,
Martyna

> 
>> +    }
>> +
>>       vsi = ice_get_main_vsi(pf);
>>       /* init channel list */
>> @@ -7701,6 +7708,13 @@ static void ice_rebuild(struct ice_pf *pf, enum 
>> ice_reset_req reset_type)
>>           goto err_init_ctrlq;
>>       }
>> +    if (hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
>> +        err = ice_fwlog_register(hw);
>> +        if (err)
>> +            hw->fwlog_cfg.options &=
>> +                ~ICE_FWLOG_OPTION_IS_REGISTERED;
>> +    }
> 
> Ditto.
> 
>> +
>>       /* if DDP was previously loaded successfully */
>>       if (!ice_is_safe_mode(pf)) {
>>           /* reload the SW DB of filter tables */
> 
> 
> Kind regards,
> 
> Paul
> 


