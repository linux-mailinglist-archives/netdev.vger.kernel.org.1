Return-Path: <netdev+bounces-239165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D20C64C43
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CEC0129373
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E725524C;
	Mon, 17 Nov 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrbAwHvH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003023F439;
	Mon, 17 Nov 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391631; cv=none; b=phaAjX/cxnmvAb/QrQce6BXRrQAG/DVk1R53xaGIpWob/wnd7s8x3MHPqlxg+3hWbifZqVSRcaUDhZXAFC6xUac35GZfy3wE2/VrlOnzBcjpxEDFU5nuL8Kx4pEGUmv80QjHN2av72QNL9gvuLOLUAXuZkX/xeeOLl7Fpiv4JDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391631; c=relaxed/simple;
	bh=hmMEbfTFN5n4CBo7J7vCAo90FSilyOzfTyWJPEvu0pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xk2SVXOVti5LtdzbC+WQ+FX0QbqQg3HoizFnmW6OMdCgeOK2AEOBh5D/3179LktedgPC9HQtneL8vehChl39nLu80g9rNQTXEUAN/8iSVr56tQ3gc7l4JP+QD6piy2TaiCyd1MwS0023K+PPGXBLMEovVHXrDi7Zo9PXNXrDFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrbAwHvH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763391629; x=1794927629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hmMEbfTFN5n4CBo7J7vCAo90FSilyOzfTyWJPEvu0pw=;
  b=TrbAwHvHHwOhDRbAQHXqadnhxkEx1unaHmh1vvvY4M/7XRcCpx0htGWI
   GiUSvpINXBJyfe0y2FYAY91kQaxSS1bCsyD/nBqLInzTMMVVjpj5VusE1
   c0kCNbZ02J/65vgTy2OVRuoM9FPVmLyjmLvvU2Ks1LeIesTAr2lkhY7Ht
   46ANLYbWO4oM2EIxUtZJz2HS5gps0h0wGzI456RdVVgxDuIC7afWrVNHb
   ylMojHN0DvXvF4kCWq78NooaVqnrrm/OkAjgYDrcRVTm0tdtG8XWLJhDj
   0HTQ4FNY1wgmVt8l23+GDuC2auoiCOsJRqWDLuZQkzzjVxvGhyL0kRSjX
   w==;
X-CSE-ConnectionGUID: wcx/rsR9S92I8ppBFxq0Ig==
X-CSE-MsgGUID: 0joTU6b/Rrao/Y8Py7hd8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76494758"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76494758"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:00:28 -0800
X-CSE-ConnectionGUID: 67tIj6PyS6e/Mbr+45zG3w==
X-CSE-MsgGUID: w/9CJWlwShy9SNemyIRH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="194569126"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.43]) ([10.125.109.43])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:00:27 -0800
Message-ID: <3ef9ee39-b568-4f08-ba4f-82be65248cf6@intel.com>
Date: Mon, 17 Nov 2025 08:00:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <20251112154103.000025fd@huawei.com>
 <8d0b9a21-c1bd-453f-903b-22aa302b3639@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <8d0b9a21-c1bd-453f-903b-22aa302b3639@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/25 1:12 AM, Alejandro Lucero Palau wrote:
> 
> On 11/12/25 15:41, Jonathan Cameron wrote:
>> On Mon, 10 Nov 2025 15:36:41 +0000
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>>> initialization.
>>>
>>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>>> exported and shared with CXL Type2 device initialization.
>>>
>>> Fix cxl mock tests affected by the code move, deleting a function which
>>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>>> setup RCH dport component registers from RCRB").
>> As I replied late to v19, I'd like to understand more about this comment.
>> If it was not being used, why can't we remove it before this patch?
> 
> 
> I replied back then, but if you think this is what I should do with no exception, I'll do it.
> 
> Should it be part of this patchset or something I should send independently?

Alison is out this week due to a personal matter. I would just send this ahead and be done with it if it's just a function removal cleanup. 

DJ

> 
> 
>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


