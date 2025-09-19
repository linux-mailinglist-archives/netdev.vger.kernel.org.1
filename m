Return-Path: <netdev+bounces-224875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6CB8B283
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19B93BC7DF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037F2C237D;
	Fri, 19 Sep 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hl4hZP7L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB831E5B63;
	Fri, 19 Sep 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311894; cv=none; b=rOEtMPmsEntiwVNXQE6h+dhMzXOQhd/NxlZLQl9yrijjSDjBObvsBAGkf+Oq9HuSY2LwmOrcBuxzWfz8XiLa1DQeK82pb2oBRuqtqVRqvhyG3VMm775WbiBVqgfashig3lTUsq4HK+tYnPPuqtDER+eFj9EO71k0MFTIaSpq2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311894; c=relaxed/simple;
	bh=0O0MahJ+NiK3QdJLSSJEqa2OFc+vnA8WlR02GHdRTgk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q6sIGAvp9DUr4pZecbM26D8nQrv7nbhpKbpGrLwijslEsomP1WO4capJIrlU4tXZCfmehWDy2OOcFJGA7FuBOz7ihKTHoYiR5Jn9C/NyN3zgyQWZ798gpJ0to9th2b57QrfJQST3tyCyBTSL+yBbhtQjEVdAl43Ylp0knNRIDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hl4hZP7L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758311893; x=1789847893;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0O0MahJ+NiK3QdJLSSJEqa2OFc+vnA8WlR02GHdRTgk=;
  b=Hl4hZP7Lp/9UN6G0eqVFtFQEn6vTUPxxs+HruNhv5NxzYP5hgzIa0nT3
   ds6DGSnMnNqUl8UmnQAAMdklUPZpT2N6Ym9d80OokrBj/GwbdJW+LWOOi
   A/37HQ+5mHtSED2up4IYtZ5z6cQl75PzT9IKmynmZJi2P5yf/riH3cqqW
   eRbJ/3m6xl2PpRCnj/uQ7p88CufFdSzfl+y0jWDKdnOtnk3Vzj7T6u+Eu
   y4bFgVPnEatbEh70F8k7yb/YlDJwprPORM5eKCX9unk4c+MuGA7tANENw
   /e86XJsiaUQBYnMsdvuasoMpPTV5eMkK6nk7Iap4aq6xt63piiGu3lzbG
   g==;
X-CSE-ConnectionGUID: vf1P6JCKQ9+a9gS3GuWLvA==
X-CSE-MsgGUID: RZn7dwQGQHq0IQ8kCNGQUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60356804"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60356804"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:58:11 -0700
X-CSE-ConnectionGUID: ++Rm/+bLQ5S3XzcYy8lhkw==
X-CSE-MsgGUID: ydSCiQyiQgSc7XmY0M6GKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="181037540"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:58:10 -0700
Message-ID: <1b86bfc3-61da-421f-ba3d-bd738232996b@intel.com>
Date: Fri, 19 Sep 2025 12:58:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/20] sfc: create type2 cxl memdev
From: Dave Jiang <dave.jiang@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
 <58917e54-5631-4e68-8e0e-bcff94c41516@intel.com>
Content-Language: en-US
In-Reply-To: <58917e54-5631-4e68-8e0e-bcff94c41516@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/25 8:59 AM, Dave Jiang wrote:
> 
> 
> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl API for creating a cxl memory device using the type2
>> cxl_dev_state struct.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> with a nit below.
> 
>> ---
>>  drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 651d26aa68dc..177c60b269d6 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -82,6 +82,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>  		return dev_err_probe(&pci_dev->dev, -ENODEV,
>>  				     "dpa capacity setup failed\n");
>>  
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> 
> As Jonathan mentioned. Maybe dev_err() to keep it consistent.

Hmm....looking at the rest of the driver files the pci_*() calls are used instead. So ignore my comment. Although typically device drivers use dev_*() calls and pci_*() calls are reserved for PCI core devices.

DJ
  
> 
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>>  	probe_data->cxl = cxl;
>>  
>>  	return 0;
> 
> 


