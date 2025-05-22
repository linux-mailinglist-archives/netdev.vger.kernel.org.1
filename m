Return-Path: <netdev+bounces-192565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7169AC0662
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2611D18837CD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55634221FB3;
	Thu, 22 May 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0PfP88D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C571714AC
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900708; cv=none; b=n/dgKlXhTFM5+0sz89tRcFfDkqoJajzWNfIE7zkURTgb4bQIrD/Bm2kH7KeWp4mcrbYnMNFZ2RJdyDbbrzGz8ttTrbWHtSGXWXkuVI2BFyEdbZJfcuj/NxDFozTjtlj2iLDlTXFL8eumOi7/olQIQV31fsQf/u0SvjfbMY1xwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900708; c=relaxed/simple;
	bh=uaFxc+tt/XBn4O6Z8JFRyd08xW/PTWvjlVr6kMC4Wm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDaUXTqyY316wCfRsH3jgNfhY2xdTEhSldE7am7jvASzjWDwIhMSunqEeoaFIyclx7VrtTjDJGjlhU0BVhWK7u1qSr6Dk9r0gUPRrp3C2owo4V4Tg9zJ7eQacBMLtJ9WHni4vLaR7PFoJyPxQaKeun2K1E1sNuugeSEEsLDfo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0PfP88D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747900707; x=1779436707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uaFxc+tt/XBn4O6Z8JFRyd08xW/PTWvjlVr6kMC4Wm4=;
  b=f0PfP88D6pctSHtzJqdBwMmihecqjJf3rt8EtZM4SB/bMtRVCTud1TEE
   BuxmvqNPpmmQFNlLHDOTJ2GdqBJC22SSU6dA+iGANmbjGTA6Jj4Ebdmah
   eX96oHMmkHmjFkiZ2B9dYm1+/cGg9PDM0i+y0REPnXJ+HcAIaeusji1FI
   8CS1n2fSdhLIqLQXe3d2ACY8+qWbplw40rYw3qI91S/p8taW3anI5y6m+
   6GNRImfTDrRPOrJlsqsXFyXbFhSpMFEv3661IX06FNk9PH8MSwvEv5GLU
   G5XD/75BxVJUaywhjbaD92Kqhz39/BErdKpwr2U3VdeLN9HcVEwo3QwgL
   w==;
X-CSE-ConnectionGUID: KYRYH+MqSjOSzHqwkKLzKQ==
X-CSE-MsgGUID: +YrZAVoyQPSM1Vo1NRW40Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60153197"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="60153197"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 00:58:26 -0700
X-CSE-ConnectionGUID: dqZ64TUAQ26/HF/ZJ77a2Q==
X-CSE-MsgGUID: qpuECeyhRHSbTxRRG+MgCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="141402614"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.67]) ([172.28.180.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 00:58:25 -0700
Message-ID: <1e7b314d-55d4-4e9b-9046-0dd624a5e347@linux.intel.com>
Date: Thu, 22 May 2025 09:58:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: add E835 device IDs
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Konrad Knitter <konrad.knitter@intel.com>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
 <8c8999a7-d586-4bc6-9912-b088d9c3049f@molgen.mpg.de>
 <46e45673-66fa-4942-a733-fdcbc95b5ee1@linux.intel.com>
 <4b67b9cd-47d1-4fbc-8de0-86d364f36dce@molgen.mpg.de>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <4b67b9cd-47d1-4fbc-8de0-86d364f36dce@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-22 9:01 AM, Paul Menzel wrote:
> Dear Dawid,
> 
> 
> Am 19.05.25 um 13:11 schrieb Dawid Osuchowski:
>> On 2025-05-16 10:57 PM, Paul Menzel wrote:
>>> Am 14.05.25 um 12:46 schrieb Dawid Osuchowski:
>>>> E835 is an enhanced version of the E830.
>>>> It continues to use the same set of commands, registers and interfaces
>>>> as other devices in the 800 Series.
>>>>
>>>> Following device IDs are added:
>>>> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
>>>> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
>>>> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
>>>> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
>>>> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
>>>> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
>>>> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
>>>> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
>>>> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP
>>>
>>> Should you resend, it’d be great, if you added the datasheet name, 
>>> where these id’s are present.
>>
>> Sorry it isn't publicly available yet.
> 
> Too bad, but the name of the datasheet would still be useful in the 
> commit message, so people could point to it, or, should it ever be made 
> public, can find it.

I understand your concern.

Given our datasheet naming scheme so far [1], I think folks
interested in viewing the datasheet can easily search our Resource & 
Documentation Center [2] to find what they're looking for once it 
becomes available.

[1] 
https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html
[2] 
https://www.intel.com/content/www/us/en/resources-documentation/developer.html

Best regards,
Dawid

> 
> 
> Kind regards,
> 
> Paul


