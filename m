Return-Path: <netdev+bounces-229760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3EBE0943
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1FC19C4FFD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F5308F1D;
	Wed, 15 Oct 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5YayLST"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100D1DB54C;
	Wed, 15 Oct 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558891; cv=none; b=J/KcNZVJMg3dJMryQlZynyLsIyi2ooly+abt6gbyAhs6FafBFZbhOT1gMe13/hixxlVt48pIi8t/E+ufDmj7zIL2xfxx87XWsSTLVEkhRVbHt0bWiwD4Qrkb+oOAGRxEqiHWY0lVRbvE9EcSFm/dgWXt/qti7j2yxdMQqfWhAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558891; c=relaxed/simple;
	bh=Qt2pPaFxOJpta4nuz+Zsz6U9fKmAbLvTL+MjVHPrbFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBlTXvPP7kGqNjW8Fe94zw8ytH2iGaO6RDkR4bb28ATZUAevFeGZs8efLKKCQKlGs0FUluYJY3MwXafDxvDJrCL5Iva8N9vQE89UX1HCo0CvQe2wZXW10kNaQ9ssOpSlicGQi3hbQnEblTPd68o1eEYiLZaQsyvpq3F/eizntMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5YayLST; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760558889; x=1792094889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qt2pPaFxOJpta4nuz+Zsz6U9fKmAbLvTL+MjVHPrbFs=;
  b=D5YayLST/0srmHs+l2YPbfEIZmfbnpPraV8+TaiKbIJxQhQCmVR7BXKA
   teI0rNAFTqmFimf9kPjaZg51Ink7FcHrI+su5Q6OqiGVYXDc8qNHmPIRN
   j+K82HaPzY+6tg5MH//jEua/aByc51AOdPYZxnLedz1YOWPpy+VhWuDnv
   0mnFjbS7Y7wEga2JLrDWIg9BY6kuisqOwQWXhJrjT08LnXN3wUWdtbFOw
   +cbGbRbBgp1s3yXzC14mhvU08BvlE9WmCJ7yZHuATFn7970Wvqsyu4//x
   oFcYnT3Uu6xsiTk3fk0krh0rgBJIyt8oAvO+dWS7At0hnj3q15asIneNU
   A==;
X-CSE-ConnectionGUID: ESNC6Fj+Tl+3gR4xbGycNA==
X-CSE-MsgGUID: n4rirzO1TRetx7Wvm79SUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66395562"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="66395562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:08:07 -0700
X-CSE-ConnectionGUID: yEqPW4ssR5Ocwne4/WK4cg==
X-CSE-MsgGUID: CXqGWSxzRJa+sO/1/bZ7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182672539"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:08:06 -0700
Message-ID: <e7b2ff72-5367-4493-8bbe-40c05b3de607@intel.com>
Date: Wed, 15 Oct 2025 13:08:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/22] cxl: Define a driver interface for DPA
 allocation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace().
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

just a nit below

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/hdm.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..70a15694c35d 100644
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
> @@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>  	return resource_contains(res, &_addr);
>  }
>  
> +/**
> + * cxl_dpa_free - release DPA (Device Physical Address)
> + *

no blank line needed here

DJ> + * @cxled: endpoint decoder linked to the DPA
> + *
> + * Returns 0 or error.
> + */
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
> @@ -582,6 +590,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -613,6 +622,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  	return 0;
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
> +	return cxled->cxld.id == (port->hdm_end + 1);
> +}
> +
> +static struct cxl_endpoint_decoder *
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	dev = device_find_child(&endpoint->dev, NULL,
> +				find_free_decoder);
> +	if (dev)
> +		return to_cxl_endpoint_decoder(dev);
> +
> +	return NULL;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @mode: CXL partition mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
> + * an errno encoded pointer on failure.
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but which could not be fully
> + * available due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +		cxl_find_free_decoder(cxlmd);
> +
> +	if (!cxled)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return no_free_ptr(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> +
>  static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ab490b5a9457..6ca0827cfaa5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>  
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
>  DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2966b95e80a6..1cbe53ad0416 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -270,4 +271,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_CXL_H__ */


