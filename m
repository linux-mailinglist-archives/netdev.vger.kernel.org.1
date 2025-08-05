Return-Path: <netdev+bounces-211743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B3B1B736
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0713D1896B30
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474C2798FE;
	Tue,  5 Aug 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIQVPSgM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7D25A2B4;
	Tue,  5 Aug 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406883; cv=none; b=dWVwJcqWQCHQE5vfAfO5r37ndNEEZ0HtfLMOJrvDTcqmDLx4ad6aZXvt1RLRPP2C2/FnO61FbUeVT0relMMP+Od426WxajcscFtlMb5lh77XTEFZ5nriGp12fhSAh9z1PPPG7jnHb2HGM38TJoQwB/QFU8dARwZwSXz06U896AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406883; c=relaxed/simple;
	bh=OgxvU2U/rIls3YUPk2Xiew3IaNaux0N1yoo/6ZWPObo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0J+hA9+wDN7d/9asHJjNvThxQperUFAb6KWPtKekOETEomj55f0C49lIJK/Y75MwlY2B/lmSsl+MYsqcDKj66wlSka/0a3V84N43FB2F41csbHXS1i0cxTIW4vUzZlN7FVVaAfHsKY9MjEFcX1WbC74JCJlk/+8GRLjOXH9kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIQVPSgM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754406882; x=1785942882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OgxvU2U/rIls3YUPk2Xiew3IaNaux0N1yoo/6ZWPObo=;
  b=YIQVPSgMimgs5nVAxQu0FkmT36KzJvgWlKiFq3a0ZAwU5Zp1l2p5TsTy
   6a0Kk3wqez1YgOhFKDVwd+4grxx47AbFmkFlJttfkyaN2P+HcFr7i5D91
   gIzaWsA2cDy/eVN27RazePEWcsDNVUHSCuWRvcW88O9+alsNTLceJjusH
   BNEJu9trddsjOZwdy0e2hOxV+062BdZlVJ8kj+vlLAyKAEWPChETNZ4DG
   mRoadTzQdPjotms1zBS8JatZdDSiCc3hhN1BUv7bb91x57Tqy70H01yrg
   BPg2+KXR8aL5PVwbHiCgUplbP8fm2+HJ+0a7VkDD537xucWr82D4iyyKN
   w==;
X-CSE-ConnectionGUID: 0+vVP08tQBa6bf9qT4HQeQ==
X-CSE-MsgGUID: 9CoAaru2R0mA9cOBycJymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67780253"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67780253"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 08:14:42 -0700
X-CSE-ConnectionGUID: HrkeV8ACSo+1lmhny9HpxQ==
X-CSE-MsgGUID: uiOJxe/jTV+qOiDwLuA2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168697805"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.81]) ([10.247.119.81])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 08:14:34 -0700
Message-ID: <0a3f605f-ecb3-4edf-97c5-2e7f510403d1@intel.com>
Date: Tue, 5 Aug 2025 08:14:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/22] cxl: Add type2 device basic support
To: Alejandro Lucero Palau <alucerop@amd.com>, dan.j.williams@intel.com,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
 <6883fb4a46aff_134cc7100be@dwillia2-xfh.jf.intel.com.notmuch>
 <3a0f28e9-c329-4bbb-a0c4-19fde9755dbf@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3a0f28e9-c329-4bbb-a0c4-19fde9755dbf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/5/25 3:45 AM, Alejandro Lucero Palau wrote:
> 
> On 7/25/25 22:46, dan.j.williams@intel.com wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>> (type 2) with a new function for initializing cxl_dev_state and a macro
>>> for helping accel drivers to embed cxl_dev_state inside a private
>>> struct.
>>>
>>> Move structs to include/cxl as the size of the accel driver private
>>> struct embedding cxl_dev_state needs to know the size of this struct.
>>>
>>> Use same new initialization with the type3 pci driver.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> ---
>>>   drivers/cxl/core/mbox.c      |  12 +-
>>>   drivers/cxl/core/memdev.c    |  32 +++++
>>>   drivers/cxl/core/pci.c       |   1 +
>>>   drivers/cxl/core/regs.c      |   1 +
>>>   drivers/cxl/cxl.h            |  97 +--------------
>>>   drivers/cxl/cxlmem.h         |  85 +------------
>>>   drivers/cxl/cxlpci.h         |  21 ----
>>>   drivers/cxl/pci.c            |  17 +--
>>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>>   include/cxl/pci.h            |  23 ++++
>>>   tools/testing/cxl/test/mem.c |   3 +-
>>>   11 files changed, 303 insertions(+), 215 deletions(-)
>>>   create mode 100644 include/cxl/cxl.h
>>>   create mode 100644 include/cxl/pci.h
>> Thanks for the updates.
>>
>> Now, I notice this drops some objects out of the existing documentation
>> given some kdoc moves out of drivers/cxl/. The patch below fixes that
>> up, but then uncovers some other Documentation build problems:
>>
>> $ make -j14 htmldocs SPHINXDIRS="driver-api/cxl/"
>> make[3]: Nothing to be done for 'html'.
>> Using alabaster theme
>> source directory: driver-api/cxl
>> ./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_DEVMEM' not described in enum 'cxl_devtype'
>> ./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_CLASSMEM' not described in enum 'cxl_devtype'
>> ./include/cxl/cxl.h:225: warning: expecting prototype for cxl_dev_state_create(). Prototype was for devm_cxl_dev_state_create() instead
> 
> 
> OK.  I can fix those problems easily (bad punctuation). I can not see the one about the prototype, but maybe it is due to the base commit. BTW, which one should I use for next version and rebasing on Terry's patches?

Latest against upstream RC is usually preferred. So 6.17-rc1 is probably the earliest.

DJ

> 
> 
> Thanks
> 
> 
>> Note, this file was renamed in v6.16 to theory-of-operation.rst,
>> git-apply can usually figure that out.
>>
>> cxlpci.h is not currently referenced in the documentation build since it
>> has not kdoc, so no need for a new include/cxl/pci.h entry, but
>> something to look out for if a later patch adds some kdoc.
>>
>> -- 8< --
>> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
>> index d732c42526df..ddaee57b80d0 100644
>> --- a/Documentation/driver-api/cxl/memory-devices.rst
>> +++ b/Documentation/driver-api/cxl/memory-devices.rst
>> @@ -344,6 +344,9 @@ CXL Core
>>   .. kernel-doc:: drivers/cxl/cxl.h
>>      :doc: cxl objects
>>   +.. kernel-doc:: include/cxl/cxl.h
>> +   :internal:
>> +
>>   .. kernel-doc:: drivers/cxl/cxl.h
>>      :internal:


