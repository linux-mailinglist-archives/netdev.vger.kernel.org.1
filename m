Return-Path: <netdev+bounces-129273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070A97E99E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79615B20A93
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3B1940BE;
	Mon, 23 Sep 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUARyK4M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AA194A54
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086447; cv=none; b=m4cjtIqD/MK9s7OEnl6A5zBUV/mP/5WtcVAnAQcgrX0NyX+JQVLnbDxuyPjmMBkt80N1spLGZm2ZhQ80tDcEjpRHe1L27CsNmSOJldKnn50J68T5UCeLMD+V/G2iJKUqNBEr0Rs82AlVx4NVFv4yH3u7MX6PhRLUe4Oh10YMulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086447; c=relaxed/simple;
	bh=p5o1Jo6U3AZKAQbTtFOZi3I5CXN3bA3pd+Y097tFe/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2vUtPh7alyOLbBeJcV9y5VOiOVhXbbmDRIdmSYJv0shxWngY/x5+JbGbQYH74RZ4VXxEHfv122DIT4iu7JA9xGL12IUci01TfNI59fu+Spi4UslydqqYZUAnzuLiEFCPKJJlcu8WElVFAVtKVYKKQWGaC1pPdefX+NATYpAqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUARyK4M; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727086445; x=1758622445;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p5o1Jo6U3AZKAQbTtFOZi3I5CXN3bA3pd+Y097tFe/4=;
  b=ZUARyK4MroLCI1poW1Wz6C/2YWuS0PuiYaCG9YjJ8hVMDx3FEcFtdfC4
   y/pyIqg/iJXWVdG2q0NtCZoe3o820SKS+iYpDgQ83m2cwHtvNlbId87XE
   uKIM3Igw8oCaJcxeXuTro/0jW7eVu5b+amly392cQfAj4xRw4CjggurIy
   ELB7jOxa9UraX6ruvQrj/3wNhxq8l+bBhctXa9iFzSRb3wMobN7fgkjHj
   MthVdFWxHKwd3gfuicodAohMej/z5L4edcHcjU5REWuX2nQgboFz5BQVj
   7G+8bobb6i7VgE9ZtmaeBigTHdHxwbtufR/DPs3UgTgNhBGzZ/V6LToKj
   w==;
X-CSE-ConnectionGUID: 6wqDYhV5T2i91YkHu1/ISw==
X-CSE-MsgGUID: fT3SH4TYRwiGv2m9BEQixA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29747954"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29747954"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 03:14:04 -0700
X-CSE-ConnectionGUID: Zb6YVVJWS4mXEqQzo05cPA==
X-CSE-MsgGUID: rNh90k91REKm5TsT+6h0Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75962603"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.26.245]) ([10.246.26.245])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 03:14:03 -0700
Message-ID: <3ecfcc55-f31f-40ee-b7f2-49b567c3e8a2@linux.intel.com>
Date: Mon, 23 Sep 2024 12:13:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: Fix entering Safe
 Mode
To: Brett Creeley <bcreeley@amd.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, mateusz.polchlopek@intel.com
References: <20240920165916.9592-3-marcin.szycik@linux.intel.com>
 <5cda9974-6c19-4216-9139-0ac83c95303c@amd.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <5cda9974-6c19-4216-9139-0ac83c95303c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20.09.2024 19:14, Brett Creeley wrote:
> 
> 
> On 9/20/2024 9:59 AM, Marcin Szycik wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> If DDP package is missing or corrupted, the driver should enter Safe Mode.
>> Instead, an error is returned and probe fails.
>>
>> Don't check return value of ice_init_ddp_config() to fix this.
>>
>> Change ice_init_ddp_config() type to void, as now its return is never
>> checked.
>>
>> Repro:
>> * Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
>> * Load ice
>>
>> Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>> v2: Change ice_init_ddp_config() type to void
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 0f5c9d347806..aeebf4ae25ae 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -4548,34 +4548,27 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
>>    *
>>    * This function loads DDP file from the disk, then initializes Tx
>>    * topology. At the end DDP package is loaded on the card.
>> - *
>> - * Return: zero when init was successful, negative values otherwise.
>>    */
>> -static int ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
>> +static void ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
>>   {
>>          struct device *dev = ice_pf_to_dev(pf);
>>          const struct firmware *firmware = NULL;
>>          int err;
>>
>>          err = ice_request_fw(pf, &firmware);
>> -       if (err) {
>> +       if (err)
>>                  dev_err(dev, "Fail during requesting FW: %d\n", err);
>> -               return err;
>> -       }
>>
>>          err = ice_init_tx_topology(hw, firmware);
>>          if (err) {
>>                  dev_err(dev, "Fail during initialization of Tx topology: %d\n",
>>                          err);
>>                  release_firmware(firmware);
>> -               return err;
>>          }
>>
>>          /* Download firmware to device */
>>          ice_load_pkg(firmware, pf);
>>          release_firmware(firmware);
>> -
>> -       return 0;
>>   }
>>
>>   /**
>> @@ -4748,9 +4741,7 @@ int ice_init_dev(struct ice_pf *pf)
>>
>>          ice_init_feature_support(pf);
>>
>> -       err = ice_init_ddp_config(hw, pf);
>> -       if (err)
>> -               return err;
>> +       ice_init_ddp_config(hw, pf);
> 
> I just commented this on v1 as I didn't expect it to be resent. I'm also okay with Maciej's suggestion, but I wanted to offer an alternative option.
> 
> As an alternative solution you could potentially do the following, which
> would make the flow more readable:
> 
> err = ice_init_ddp_config(hw, pf);
> if (err || ice_is_safe_mode(pf))
>        ice_set_safe_mode_caps(hw);

This sounds reasonable, I'll change it if there will be no more comments.

> Also, should there be some sort of messaging if the device goes into
> safe mode? I wonder if a dev_dbg() would be better than nothing. If ice_init_ddp_config() fails, then it will print an error message, so maybe a dev_warn/info() is warranted if (err)? Of course this would depend on ice_init_ddp_config() to return a non-void value.

ice_request_fw() already prints a dev_err() message when entering safe mode, so I don't think it's necessary here.

Thanks,
Marcin
> 
> Thanks,
> 
> Brett
> 
>>
>>          /* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
>>           * set in pf->state, which will cause ice_is_safe_mode to return
>> -- 
>> 2.45.0
>>
>>


