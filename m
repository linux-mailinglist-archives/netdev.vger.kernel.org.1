Return-Path: <netdev+bounces-151524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29A9EFF0B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F19188813C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2561DB54C;
	Thu, 12 Dec 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVXzDkHC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3761DAC83;
	Thu, 12 Dec 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041670; cv=none; b=hAHKznjTGsbq2iiiHvCtBlxx0pY7GKazfXZ31O9jpmVxigQOuZ5npLN2GntjuBQyWNK4RjX6b/0fH9ezbsKP4yelS9b3mrsancm8b2HWVBWhIvPtb/OGmt1acxg/w0scfwMa1Js0Rss6Z2L0SfcY9YxQf6jB9yZ4KAsVpelhmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041670; c=relaxed/simple;
	bh=G+KtAS+rlxBGvf+qHr2ZXx6Ieqa+kjzLUFo8Cc2SXns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCCbnNJtAI7cPVOqrgePknmWO8MVRUfGml99Eb0iV0+aGBskvDu6H8QyQV8OiWEoGzM4Bogn6ggx6TEGJTEerutFMexdXc9WrkKrvzNKXFR701BqcMNx4p/ucM58D2Eq8zyPJWpKjpAJ8kTLqCXNu5jANunnCFRW2pocLxRancQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVXzDkHC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734041669; x=1765577669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G+KtAS+rlxBGvf+qHr2ZXx6Ieqa+kjzLUFo8Cc2SXns=;
  b=aVXzDkHCAUh2cpVYW1ErhxeYaPW7m7BJmDqGBvA2V2JJHXj/4YzsiGEK
   VqE5AIL6AQJ/jPEb1Zhxq/UB4aQ0lyCly5lqdw+wjZFJX2njRbc/KmV5U
   NLQv0LlSTHBBqUkIVDKmJJqx6iOBpiIfKK489nckFjwWftftoa3tTNRok
   JeUNBqmiKwT7iGFo4Eg2qAY3asXm6RdfpvvMAN2EErRfp4K3xjxOyBDQo
   yUhVfL52v0AjZdAEnQR43ruI0Oo7wVip4cSdEykgN/kAHuu/u2TzDGY+R
   niwe23VgSkLEvkiIWZ4qrwj9yY+dTJCXeZhH/vW+IwRPiwRvC4pHDKJAZ
   A==;
X-CSE-ConnectionGUID: BZLv2ECQSOCEPvbi2s2BJw==
X-CSE-MsgGUID: Y24s+jtrS52cX+VuHjlvNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="37330327"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="37330327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 14:14:28 -0800
X-CSE-ConnectionGUID: SlIJ1yTLSSyfDqKsIoHnkA==
X-CSE-MsgGUID: /SB9dEtKTuGh+6qcfW6Zow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96235051"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.120]) ([10.125.110.120])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 14:14:27 -0800
Message-ID: <7d7a3ab4-d7f1-45aa-a618-04a5e341fa55@intel.com>
Date: Thu, 12 Dec 2024 15:14:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] cxl: avoid driver data for obtaining cxl_dev_state
 reference
To: Alison Schofield <alison.schofield@intel.com>, alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com
References: <20241203162112.5088-1-alucerop@amd.com>
 <Z1tZzf_RqsfRFwvF@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z1tZzf_RqsfRFwvF@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/24 2:46 PM, Alison Schofield wrote:
> On Tue, Dec 03, 2024 at 04:21:12PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL Type3 pci driver uses struct device driver_data for keeping
>> cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
>> field should not be used when code requires cxl_dev_state to work with
>> and such a code used for Type2 support.
>>
>> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
>>
>> Seize the change for removing the unused cxl_port param.
>>
> 
> Dave,
> 
> Jonathan previously offered Reviewed-by tag so this looks good to
> apply. I've added another review tag and also massaged the 
> changelog for your consideration.
> 
> cxl/pci: Add Type 1/2 support to cxl_dvsec_rr_decode()
> 
> In cxl_dvsec_rr_decode() the pci driver expects to retrieve a cxlds,
> struct cxl_dev_state, from the driver_data field of struct device.
> While that works for Type 3, drivers for Type 1/2 devices may not
> put a cxlds in the driver_data field.
> 
> In preparation for supporting Type 1/2 devices, replace parameter
> 'struct device' with 'struct cxl_dev_state' in cxl_dvsec_rr_decode().
> 
> Remove the unused parameter 'cxl_port' in cxl_dvsec_rr_decode().
> 
> [as: massaged commit msg and log]
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Thanks! I'll take it with the commit log changes.

> 
> 
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/pci.c        | 6 +++---
>>  drivers/cxl/cxl.h             | 3 ++-
>>  drivers/cxl/port.c            | 2 +-
>>  tools/testing/cxl/test/mock.c | 6 +++---
>>  4 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5b46bc46aaa9..420e4be85a1f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>>  	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>>  }
>>  
>> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  			struct cxl_endpoint_dvsec_info *info)
>>  {
>> -	struct pci_dev *pdev = to_pci_dev(dev);
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct device *dev = cxlds->dev;
>>  	int hdm_count, rc, i, ranges = 0;
>>  	int d = cxlds->cxl_dvsec;
>>  	u16 cap, ctrl;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index f6015f24ad38..fdac3ddb8635 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -821,7 +821,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>  				struct cxl_endpoint_dvsec_info *info);
>>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +struct cxl_dev_state;
>> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  			struct cxl_endpoint_dvsec_info *info);
>>  
>>  bool is_cxl_region(struct device *dev);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 24041cf85cfb..66e18fe55826 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	struct cxl_port *root;
>>  	int rc;
>>  
>> -	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
>> +	rc = cxl_dvsec_rr_decode(cxlds, &info);
>>  	if (rc < 0)
>>  		return rc;
>>  
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index f4ce96cc11d4..4f82716cfc16 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>>  
>> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  			       struct cxl_endpoint_dvsec_info *info)
>>  {
>>  	int rc = 0, index;
>>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>>  
>> -	if (ops && ops->is_mock_dev(dev))
>> +	if (ops && ops->is_mock_dev(cxlds->dev))
>>  		rc = 0;
>>  	else
>> -		rc = cxl_dvsec_rr_decode(dev, port, info);
>> +		rc = cxl_dvsec_rr_decode(cxlds, info);
>>  	put_cxl_mock_ops(index);
>>  
>>  	return rc;
>> -- 
>> 2.17.1
>>
>>


