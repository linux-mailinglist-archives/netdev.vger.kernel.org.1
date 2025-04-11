Return-Path: <netdev+bounces-181838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E44A868EA
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 00:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D7A18805F5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355EF29DB8F;
	Fri, 11 Apr 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOk58w5M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED71C8639;
	Fri, 11 Apr 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411280; cv=none; b=dWr+AMxOqXVh2K7yCC+mVIVcEhZ8HaV6qrCqu5UGZbbYwfis1Dsf2Fc2MAQsnpAQ4B7L3mDb2Aq+/GS62AuF7ZTQtPa75ElXu3UlkiEisempLaObsxxQvjCO1HjJiS2SGsBE21/tB+nJkdy7fp2Z++ECnEGqACZawikL9t4RotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411280; c=relaxed/simple;
	bh=wUn+Q9grWlvzadqoR7RfmTS24THBdZDCMBxU6qVLQ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwbNdtlLvdc2tUyv7Wwz8zsezX5occ+6xZVU+QhDVevH7oZ3lpRzscQfyHsCEAkY5ugj4MN2TkBzHaqUuZdqzYBPNahbxdrosq4cESdyQybwb/3SFQpgXjKLtRCqBjLUV3qFoUt3j0s9v6sYk9RJ76DX7rMWvlk+iiEPZSRtslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOk58w5M; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744411277; x=1775947277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wUn+Q9grWlvzadqoR7RfmTS24THBdZDCMBxU6qVLQ1c=;
  b=dOk58w5M2zdKKcvAlDqSHNve13p+FdWz8c+7EcBmisbwcRkXHP5+D8F6
   pHOXEdM67kn3PBaLGROXfscK03AVePi1zI+d3TbfZGGs/XDP06i4VrrWc
   fiNt3TZu2YZgQnU6WU46gAwawLCy0UwHKORWq+F+kUuuCvYSlTw+9Sf9D
   vbyu6+rMaD0HO0TXu7Tzr4eu5j8dsSbtfgh57GdiZfL3N0vBzNSNQT0g0
   Mhj06VWh3r6us62FDNAnuRbZDdOQyeO3p0TF4DQK4BRP8TP4ji7VR+iyI
   wIK5erndyxMykAyQTDW85UIyfBg+B3xU1cyLJ9F7AgyBoVVKFpV8K6Lhs
   A==;
X-CSE-ConnectionGUID: 0JNuoa+tSbKUb0YpPZIsnQ==
X-CSE-MsgGUID: +WKoc2w2Ria4qD1BN9sPBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="49625965"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="49625965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:41:17 -0700
X-CSE-ConnectionGUID: KvlEj7mFRFix0ozOJ+Wztw==
X-CSE-MsgGUID: 0CydifeXQ3Sehl8lcgjZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="166503097"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:41:16 -0700
Message-ID: <a0ed9543-dab3-4c56-b128-f3372eb3ce82@intel.com>
Date: Fri, 11 Apr 2025 15:41:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/23] cxl: define a driver interface for DPA
 allocation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Define an API,
> cxl_request_dpa(), that tries to allocate the DPA memory the driver
> requires to operate. The memory requested should not be bigger than the
> max available HPA obtained previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 +++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..db6d99e07d45 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -572,6 +573,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -686,6 +688,87 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_free_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @is_ram: DPA operation mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but it could not be available
> + * due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     bool is_ram,

Why not just pass in 'enum cxl_partition_mode' directly?

DJ

> +					     resource_size_t alloc)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_partition_mode mode;
> +	struct device *cxled_dev;
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (!cxled_dev)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	if (!cxled) {
> +		rc = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (is_ram)
> +		mode = CXL_PARTMODE_RAM;
> +	else
> +		mode = CXL_PARTMODE_PMEM;
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index a098b4e26980..22061646b147 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/cdev.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /*
> @@ -256,4 +257,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     bool is_ram,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif


