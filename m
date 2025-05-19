Return-Path: <netdev+bounces-191518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F05ABBC01
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828A43A6F29
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D52586CA;
	Mon, 19 May 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pcv/Hyab"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7635961
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652938; cv=none; b=AMfiRYM6MIv5pBFr9bDTXe8JOW5bbfEnnRRrshpG8xUPCQ6LE0NYHFMc4PlODQcEBqw2xruxcp0jx6EUibiFtE9/rBij5V8rQ9rdBjucbHu8mo6ayPR9se8S12TPBfl20IKzrSp96k0c7NccoRhmVzIScXS/WFfcvjFyJDfxIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652938; c=relaxed/simple;
	bh=J7zRdUs2zjeswu6c1Gotaem54BW+/7Zj+WhK0PNZnHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBQ95UVmFIuW/xVC/7dzfFsptUjLaZijEkMIpASq1qY5fjAnFA5KtQF16axCZVOboJRedi+LlLQEHbywY1C6km7LtcqldcZdPFKCEmL5kUs7XzSy5h19Ssqp1u6V0Sq3q07W42OS83qXnvOivR7NfCppXDmHYzDPshoh38FZaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pcv/Hyab; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747652937; x=1779188937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J7zRdUs2zjeswu6c1Gotaem54BW+/7Zj+WhK0PNZnHc=;
  b=Pcv/Hyabqx0+S6NyzL2q6RfiFs+HO+tJG4Idhu9RzvwbBfdjiSRzjR2Y
   /jJqonwCOrrH5Ac8ZWx6LaUN1ufrZhlycGzfjVk8Kb0IYImBFddYe533y
   wVD9G+iJnUAoNAWBBIMC/gCp3O3jvJkGpSRfe4vt8BuHeD/UQ5V2nVV5O
   B9G71zQfZ58lMysXO6pMrgNfYBY4XCh46+Wdn4ftXU5mvVVSL/1RfZy05
   606yX9dn4zavIABeB8/sQv8hzke/qzz5ZWtwOckt+0N+DT6qfxVldDg+Q
   LqYyg0UM0PAaa0Sp+abiJ8v5XwON3wBgVF5Xn4FO07yrTRSp2FIICbOPE
   A==;
X-CSE-ConnectionGUID: u+ofP02SSf2Z5ddWOhTN9g==
X-CSE-MsgGUID: yCJKx2qLQsGNoU8JOi4lnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="67103226"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="67103226"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:08:55 -0700
X-CSE-ConnectionGUID: yJbzfspgTda+j3B6x+wz5A==
X-CSE-MsgGUID: ivLU9qppST2LIllAmGNA6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139832474"
Received: from cwachsma-mobl.ger.corp.intel.com (HELO [10.245.252.240]) ([10.245.252.240])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:08:52 -0700
Message-ID: <870e9fd3-0b09-4da7-97fe-cca386fa2ca2@linux.intel.com>
Date: Mon, 19 May 2025 13:08:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: add E835 device IDs
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
 <31f29ba7-7731-487c-9738-1beab56b727f@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <31f29ba7-7731-487c-9738-1beab56b727f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-16 7:30 PM, Tony Nguyen wrote:
> On 5/14/2025 3:46 AM, Dawid Osuchowski wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/ 
>> net/ethernet/intel/ice/ice_devids.h
>> index 34fd604132f5..7761c3501174 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_devids.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_devids.h
>> @@ -36,6 +36,24 @@
>>   #define ICE_DEV_ID_E830_XXV_QSFP    0x12DD
>>   /* Intel(R) Ethernet Controller E830-XXV for SFP */
>>   #define ICE_DEV_ID_E830_XXV_SFP        0x12DE
>> +/* Intel(R) Ethernet Controller E835-CC for backplane */
>> +#define ICE_DEV_ID_E835CC_BACKPLANE    0x1248
>> +/* Intel(R) Ethernet Controller E835-CC for QSFP */
>> +#define ICE_DEV_ID_E835CC_QSFP56    0x1249
>> +/* Intel(R) Ethernet Controller E835-CC for SFP */
>> +#define ICE_DEV_ID_E835CC_SFP        0x124A
>> +/* Intel(R) Ethernet Controller E835-C for backplane */
>> +#define ICE_DEV_ID_E835C_BACKPLANE    0x1261
>> +/* Intel(R) Ethernet Controller E835-C for QSFP */
>> +#define ICE_DEV_ID_E835C_QSFP        0x1262
>> +/* Intel(R) Ethernet Controller E835-C for SFP */
>> +#define ICE_DEV_ID_E835C_SFP        0x1263
>> +/* Intel(R) Ethernet Controller E835-L for backplane */
>> +#define ICE_DEV_ID_E835_L_BACKPLANE    0x1265
>> +/* Intel(R) Ethernet Controller E835-L for QSFP */
>> +#define ICE_DEV_ID_E835_L_QSFP        0x1266
>> +/* Intel(R) Ethernet Controller E835-L for SFP */
>> +#define ICE_DEV_ID_E835_L_SFP        0x1267
>>   /* Intel(R) Ethernet Controller E810-C for backplane */
>>   #define ICE_DEV_ID_E810C_BACKPLANE    0x1591
> 
> For the most part this file is sorted by device id, could you move these 
> to the corresponding spot?

Sure, will send v2.

Best regards,
Dawid

> 
> Thanks,
> Tony

