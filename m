Return-Path: <netdev+bounces-168435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C155A3F097
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60257AB37B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C5205518;
	Fri, 21 Feb 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtaTkVs2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA33205511
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130755; cv=none; b=CuXg0DjgJcRC/zZ2AihUq89RHe8JuPgRt8PNvCFV27xU3ndJtOpqb6D0yiqSk7s+sfJ6+RDeSldolT6w0YTRGomihlQAAs8kfZll2qfh0FPwMEK78C3nOfbBf820BpSmPDJF+LUyx/f2r+6dBrxED8ZXUVIXRJJRCDKWoEiWEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130755; c=relaxed/simple;
	bh=ypHSjeMhvEL6lzT/9gZtGZLdCaUojf6hRPWXsKHq6cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNSXqm+JaGXvMN+DPDThSBMjTo0lGz/c2SukgBLwhxTtijCkNPSNPuJ2rikhUJwXe+0O/ctCXf6r0vcwo7VoxmUedO69XRYQk+9JzIevqLSuWbkUItIna1/t4gs7NNmfBUFAGhjMfnYY11s5PZEpLBeDitIG032J8g+wuUaGMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtaTkVs2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740130753; x=1771666753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ypHSjeMhvEL6lzT/9gZtGZLdCaUojf6hRPWXsKHq6cA=;
  b=MtaTkVs2XTGkFiJQ2GLjGnchnSppr0b1CGZ+gDzEmQ4twh/7UFVcz2GM
   TWsh8P70ad0KjwdM7bN+L9zPjxsBOjHZFBaBJGJEg4/O0my1VchvEOukp
   Mc9Fql3YND2rA4Xp7N8ywQJtNvjQZQqNARVh4HcPP/YPsqnwj/w0rGwD7
   knDX7MDlJ1HYxJWdpgiu7zyM9zJLSL6RmqD9vRL9KrTnhZbGPEgDzp3Ri
   mFU11BgkUX60kj/imrHm450yDWaOZVYcm5v5ZSmfzPGgsiW5Go2sj3yPH
   5S929ppexpIZemUWe6d9EQtnzIrarAbdqsDoLPgH64gzG83sCWACufe8V
   A==;
X-CSE-ConnectionGUID: Bo7G0kxmTe6iDX/yVaOxEA==
X-CSE-MsgGUID: /dN/9ZMnTcm/WA3YnF8qcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52374633"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52374633"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 01:39:12 -0800
X-CSE-ConnectionGUID: sCJgPV6FSh+R2T0LS+EcWA==
X-CSE-MsgGUID: BNtqYb15R5CPtswph0+OVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115276416"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.60.175]) ([10.247.60.175])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 01:39:09 -0800
Message-ID: <d831ac5e-96b9-47de-93ed-3d4f10a8b2aa@linux.intel.com>
Date: Fri, 21 Feb 2025 17:39:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] igc: Change Tx mode for MQPRIO offloading
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de>
 <6ff37238-ff0e-43c9-a88d-1258fd4ce7ef@linux.intel.com>
 <87wmdj8ydu.fsf@kurt.kurt.home>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <87wmdj8ydu.fsf@kurt.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>>> index 1e44374ca1ffbb86e9893266c590f318984ef574..6e4582de9602db2c6667f1736cc2acaa4d4b5201 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>>> @@ -47,7 +47,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>>>    		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
>>>    
>>>    	if (adapter->strict_priority_enable)
>>> -		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
>>> +		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>>>    
>>>    	return new_flags;
>>>    }
>>
>> IGC_FLAG_TSN_QBV_ENABLED is set multiple times in different lines:
>>
>> 	if (adapter->taprio_offload_enable)
>> 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>>
>> 	if (is_any_launchtime(adapter))
>> 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>>
>> 	if (is_cbs_enabled(adapter))
>> 		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
>>
>> 	if (adapter->strict_priority_enable)
>> 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>>
>> 	return new_flags;
>> }
>>
>> We can combine the conditions to simplify:
>> 	if (adapter->taprio_offload_enable ||
>>               is_any_launchtime(adapter) ||
>>               adapter->strict_priority_enable)
>> 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
> 
> Sure.
> 
> Should I send a v2 or do you want to carry this patch in your next fpe
> series?

I think you can go ahead with v2. It shouldn’t conflict much with the next 
fpe series, and if my future series gets stalled, at least yours won’t be 
affected.

