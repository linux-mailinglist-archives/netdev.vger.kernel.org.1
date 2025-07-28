Return-Path: <netdev+bounces-210595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A4DB14037
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A437A294E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001921018A;
	Mon, 28 Jul 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQ7EG2lk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D751A254E;
	Mon, 28 Jul 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719847; cv=none; b=STfB0rBvqPDaQ0ObrkbZfJ012wlJuwVJnaDpnKr1S9jdnmUlS3wG11lolDFypry96RVOlQpCs8OHSvDg0ItFMK6jxIuZWfn26kAMWajrSZQvFzyu4Zs0s3rjJrExhNXy1iAF7tglici4p0GMXryOrZ6FcPBqSN9v1Culu2lM30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719847; c=relaxed/simple;
	bh=Yfo2CDWhidzYdHV2GZdMyeUkKsJr2tSBGxTxLJicNj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3yPq3SwUgBHRgAOZhiPLZVqlZ37mebVIlVqkJlIb6ivGHc6LMTVoLi+MH3m6XMueCmFmv6U/ObReSRNE+SMeuYXIAzCFPhaIPoPsB4bvW9vzQxqhgm7jDNEvmyMxoVMCLd3hP72HNaGMLhp5VM+wHB70Zh7Lp1QiCIDTzqIrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQ7EG2lk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753719845; x=1785255845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yfo2CDWhidzYdHV2GZdMyeUkKsJr2tSBGxTxLJicNj4=;
  b=JQ7EG2lkfAXE4/aPasZ6vB6WUxoit1QVY5/X9ID3//x0MpJe7Hg5LF0+
   0UTvPGFUE498TdYNgNsGHZs4nayasAWS0IQRpHUQuWW8m2BE7QNDLJqu0
   qPOdAVKQC92LbSnNXhoQ6pyXmJv5EwsYceEdlADnfkJc2DVSL+r7oYxlQ
   zaLvXNiSjyYigHXx7A0gQ8j3YMrCRugR+aLimxGW/QNYD7cIrNlcnd0eO
   VMjS/QwjvZ8hTpz0z7BQDogU1bhHsh5BfJCOga0CBsMxjJx1pRmcrQyaE
   ad8CTfDMHfMJnBpY+9ha8yXYUEJFUyzCgzkodcA53sP6zJ8awRpW0Q/pz
   A==;
X-CSE-ConnectionGUID: uw2xmifZSe+d6Fw3/wzm/Q==
X-CSE-MsgGUID: J5zpQRzLRIaqEGBp661VIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56053636"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56053636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:24:04 -0700
X-CSE-ConnectionGUID: XHT44JwGTd2xUbyEGh7iyQ==
X-CSE-MsgGUID: F52q0jYQQfi6kXBwx7dMdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193444203"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.240]) ([10.247.118.240])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:23:59 -0700
Message-ID: <1e1a898b-1872-4aa5-9a3e-a593e3f5ad6c@intel.com>
Date: Mon, 28 Jul 2025 09:23:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/22] cxl: allow Type2 drivers to map cxl component
 regs
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
 <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/25 3:55 PM, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device component registers.
> 
> I would squash this with patch5, up to Dave.

I would prefer that. In general I'd prefer to see the enabling code going with where it's being used to see how it gets utilized. It makes reviewing a bit easier. Thanks!

DJ
> 
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/port.c |  1 +
>>  drivers/cxl/cxl.h       |  7 -------
>>  drivers/cxl/cxlpci.h    | 12 ------------
>>  include/cxl/cxl.h       |  8 ++++++++
>>  include/cxl/pci.h       | 15 +++++++++++++++
>>  5 files changed, 24 insertions(+), 19 deletions(-)
>>
> [..]
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 9c1a82c8af3d..0810c18d7aef 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -70,6 +70,10 @@ struct cxl_regs {
>>  	);
>>  };
>>  
>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> +
>>  struct cxl_reg_map {
>>  	bool valid;
>>  	int id;
>> @@ -223,4 +227,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>  		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>>  						      sizeof(drv_struct), mbox);	\
>>  	})
>> +
>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask);
> 
> With this function now becoming public it really wants some kdoc, and a
> rename to add devm_ so that readers are not suprised by hidden devres
> behavior behind this API.
> 
> It was ok previously because it was private to drivers/cxl/ where
> everything is devres managed.


