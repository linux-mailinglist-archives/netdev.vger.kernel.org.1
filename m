Return-Path: <netdev+bounces-147270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C309D8D56
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 21:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BABC162DBF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310F1B4144;
	Mon, 25 Nov 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ7sH6TM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793851B87F0
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565981; cv=none; b=RzS9VTeFF9/poY+Y1tI3Z18sjKv9ifsbwqD7PWPguIO8InAUYkKg+emMJv9EMGvwAS7ueE0sI9VZMsUAHusdi9h5mI2+/H7yuJQRJAKEKtVXaLnqOQs8nEizYveoiUmmQH9LkIeiPvEqlktLFPTzKRTGDOsP1fhicQyEcD+TLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565981; c=relaxed/simple;
	bh=KJlb6x3NhUymu+6Y8syLqBjVhnjn19yo6hROLMRBuDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIHcm6KA9B36kbghP33O+fFAnRGQUsixKvZN7XdlsAVfk6XJJ2x9HbidnCAjmJkCHa9RoW2XyUpwwVU/TjQI+9V6yh3MHPkYoJeFkf/zvIDhJe9l4mFjyMAhLCpj4cRhFRSpHwoWRHc4XYQaKo5np29LGx9kiiaZHQ3y1CvVImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ7sH6TM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732565979; x=1764101979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KJlb6x3NhUymu+6Y8syLqBjVhnjn19yo6hROLMRBuDM=;
  b=NQ7sH6TMGrN+hdbu3qL6Uw0Doxw/rHQ45gMZbOXrVaERsgVezVE9QoxH
   xZKGUQT7dEArIjfBcWKeO/VavKCWyO75q0RiTKpjpOMwzYAbH5nwPV17V
   OafbJZwVXblX5YrPMDgJenrhl/rb/MIQGcHNBFabmRxN9C+y7dS/GZr5t
   xdD5lrDhaPtnuAPcTXvEPWRgQsvFsDUVh+RlTbx2gufnsxFBSJaDqhiLy
   T5nAxBb5HYLtwU9HpQPU/euWmumN1MZtG27apQwDKBlDE1AozmsQjb+PQ
   oNiSdd6vUtBcybzLbvZPhbrRMOLHFJYoCsEm8QkLePcYU/WlZV/dB/Cd5
   w==;
X-CSE-ConnectionGUID: liWmd932SKSPv8KAwxuIDQ==
X-CSE-MsgGUID: qtGHC/GDRpquLTXH5siNzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36624741"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="36624741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:19:38 -0800
X-CSE-ConnectionGUID: OgSz/mjLSXGkoj2itWL4uw==
X-CSE-MsgGUID: +CZ+MvLnQ6eBVsIJpgvNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="122238582"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.84.66]) ([10.245.84.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:19:37 -0800
Message-ID: <c661b2cb-871e-48da-80e6-df7d011024fd@linux.intel.com>
Date: Mon, 25 Nov 2024 21:19:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ixgbe: Enable XDP support when SRIOV is enabled
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <20241122121317.2117826-1-martyna.szapar-mudlaw@linux.intel.com>
 <DM4PR11MB61173CA962D7D88040365DA082232@DM4PR11MB6117.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <DM4PR11MB61173CA962D7D88040365DA082232@DM4PR11MB6117.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/22/2024 4:56 PM, Fijalkowski, Maciej wrote:
>> Remove the check that prevents XDP support when SRIOV is enabled.
>> There is no reason to completely forbid the user from using XDP
>> with SRIOV.
> I think we need some more context here in commit message.
> ixgbe HW was really short on HW queues that's why probably this restriction
> was introduced in the first place.
>
> Now I believe that driver has an ability to share XDP Tx resources with locking
> being involved and that's why you can relax the previous limitation.
>
> Correct?

Right, ixgbe hardware has a limited number of hw queues. There is 
locking in place now. The reasoning behind this change is to give users 
the flexibility to use XDP with SRIOV, there may be use cases for such 
constrained scenarios, where this tradeoff is acceptable...

I'll update commit msg.

>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-
>> mudlaw@linux.intel.com>
>>
>> ---
>>
>> Added CC netdev
>>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 459a539cf8db..a07e28107a42 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -10637,9 +10637,6 @@ static int ixgbe_xdp_setup(struct net_device
>> *dev, struct bpf_prog *prog)
>>   	bool need_reset;
>>   	int num_queues;
>>
>> -	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
>> -		return -EINVAL;
>> -
>>   	if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
>>   		return -EINVAL;
>>
>> --
>> 2.36.1
>>

