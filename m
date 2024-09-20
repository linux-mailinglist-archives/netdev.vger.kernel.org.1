Return-Path: <netdev+bounces-129084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4697D617
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731791F248AB
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E914A636;
	Fri, 20 Sep 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK9pjwR1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153C168C3F
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838653; cv=none; b=Y/o/oV1zqECMgzDpuOwo2LkDJWr3cG0l7s4ZFS/eqsIoxrQwyju+ix2e84ly/RqiuUNULGVoPHyCguUP2cL8q4S8drAtcOGX3lsTPQ/yFxZ7dFWQVBYR7PEeQnKq+sIvJdoUgiJywRm0XNWPVqDcNFELY5VaNMvw8OAmyHOO8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838653; c=relaxed/simple;
	bh=iNttmDk6M4upK4RyVeUA+xSpDsBCgXRWzX79zm4E8Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW0ZeN3YsnJAD6Y3ryREoio2schjrbe5L64YxU4UhQR+mMFIv+YLVnp4OF9XJeaM5TuP/Kzylu8i5LmrLGOqXKzNhxNqZ65f+kYswruzpq8CeRDQRKAgC5NTJQnYcth5LP/VAqgWIDXU+gdowR0fENOAND0Jw4zrdbgqKeLl5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XK9pjwR1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726838652; x=1758374652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNttmDk6M4upK4RyVeUA+xSpDsBCgXRWzX79zm4E8Q8=;
  b=XK9pjwR17KFU5FfY/48mgz4mcwnxdfgfbBwh7qRLd6Tl/RiHjeBy/cCo
   yBcWmDfSPb2MGOXlTYGQFtY7JO/qKicUcXz2OiGhGOTYMAJTaHy+DNYjv
   k2Bq6ikleDV+leMfoAQGynd766D0V20kT+mp43g31ewjOB3W7Z8lucAkO
   DWzMADwpMrPizVFGew+Zc7pzbUcjAeBkTS9padleSCBnvou6mZeJoD1OB
   6sQu/fo5izcziEwca0US6sEJCN6XvfDFfDtJy7XLBljsUeE7KTprxxXfQ
   7/PNQyZCsL0hzOGfbltWp1Eyx8QGFjVvp3LDvjnKiNzSBBarme+CPm4pg
   Q==;
X-CSE-ConnectionGUID: k3fIVHuxT52sFpw4B6NvCA==
X-CSE-MsgGUID: Gw7QcEkgSLK8jqfQ1QLkjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29739330"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="29739330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:24:10 -0700
X-CSE-ConnectionGUID: r8pw3CUvSdeOuqFgM4Hv8w==
X-CSE-MsgGUID: X2HeuNvARQmLTPgDFtr2uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75079955"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.84.198]) ([10.245.84.198])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:24:08 -0700
Message-ID: <3981c288-e3d2-43cd-aff9-ce68d022aa04@linux.intel.com>
Date: Fri, 20 Sep 2024 15:24:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: Fix entering Safe Mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, mateusz.polchlopek@intel.com
References: <20240920115508.3168-3-marcin.szycik@linux.intel.com>
 <Zu1kelo0Wd20pyjf@boxer>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <Zu1kelo0Wd20pyjf@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.09.2024 14:03, Maciej Fijalkowski wrote:
> On Fri, Sep 20, 2024 at 01:55:09PM +0200, Marcin Szycik wrote:
>> If DDP package is missing or corrupted, the driver should enter Safe Mode.
>> Instead, an error is returned and probe fails.
>>
>> Don't check return value of ice_init_ddp_config() to fix this.
> 
> no one else checks the retval after your fix so adjust it to return void.

Thanks, will fix in v2.

>>
>> Repro:
>> * Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
>> * Load ice
>>
>> Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 0f5c9d347806..7b6725d652e1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -4748,9 +4748,7 @@ int ice_init_dev(struct ice_pf *pf)
>>  
>>  	ice_init_feature_support(pf);
>>  
>> -	err = ice_init_ddp_config(hw, pf);
>> -	if (err)
>> -		return err;
>> +	ice_init_ddp_config(hw, pf);
>>  
>>  	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
>>  	 * set in pf->state, which will cause ice_is_safe_mode to return
>> -- 
>> 2.45.0
>>
>>


