Return-Path: <netdev+bounces-224868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B706B8B1AA
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFB11C223E1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2B2561A7;
	Fri, 19 Sep 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsTu2g1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9824E4D4;
	Fri, 19 Sep 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311173; cv=none; b=PtcKwp9gJuwE7s5FYO71OBZnl4A9TA/ev+x/zg6UN1dokl36EcUg9zEwaHupGMNBd+B5PKqqLq3lKbOwrRJ5zenq+gNuXmMmljt+XcXk51MbKtghgJ7sXzUXg4/vvMV1MDECOmpqr3kme5y4DAVicDGQWUwYtJKAfNHp2kIfUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311173; c=relaxed/simple;
	bh=Qxy5JuXnac9GW0vWPRGFZYQ4K8hZE/WIabH4rCSGmik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ5bo8bGqpzrxg+CdUalC83OfD5Gl/iUedEkWD/2OtK2HqjzytCvP+Aqs8E+MwIKUffRin5ZksmmPXZfPq3L0UClO1uLEQzqOeMAiB2DCTDP8QLgLWvdK136LqKHr5p954OlKBV75P1Oh8AMgSBZt2AbiuKs0JjIrfHacgeyDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsTu2g1Y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758311172; x=1789847172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qxy5JuXnac9GW0vWPRGFZYQ4K8hZE/WIabH4rCSGmik=;
  b=QsTu2g1YrY5J/r/Yg6fyzeDVaCLRuA4cd3GKfM0cu6PpFIM9UfD5yLEv
   0DfGthcfsfVtv7aN7MRAt5QH4A+2r4PtO7BeOKoM/tM+DXr+Rqrh3Tmq9
   lAAfAqxtPlIu7IZ5nwxuuiZgu+5ZzsG9tb9jt8GP1Jg6R1rZCKMZr7hGo
   REaKvzyLiTwthuscHBr68dACmObgsDjBGef1JyY0HFlNamgsI4ZPypQEz
   yjefoaaKn770zbQdZDmjLSjxjoQP8PmFIYLid0jUpmM759L6WMw/HV9Mf
   uDCq+dtpNC4KKO5ErOz80sRsHJforhL7BIjtXYxnKNitTyopWOk/yTBKe
   Q==;
X-CSE-ConnectionGUID: F+4Ub+SITranBXno9TMN1Q==
X-CSE-MsgGUID: NipoChkxSnGfhF07k6jkAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="83268950"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="83268950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:46:11 -0700
X-CSE-ConnectionGUID: PRfqglmRSSSaMxjQuFuxfw==
X-CSE-MsgGUID: 7NjKp86uRqS6cL+jn964pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="213065584"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:46:09 -0700
Message-ID: <bd1d7584-b842-4a65-967d-578bdbdda5ca@intel.com>
Date: Fri, 19 Sep 2025 12:46:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
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
> ---
>  drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..d1b1d8ab348a 100644
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
> + * @cxled: endpoint decoder linked to the DPA
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
> @@ -613,6 +622,80 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
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
> + * @mode: DPA operation mode (ram vs pmem)

s/DPA operation mode/CXL partition mode/

I would just leave out ram vs pmem. When something new comes like DPA, you'll have to augment it if you had that.

> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a cxl_endpoint_decoder struct or an error

Returns a pointer to a 'struct cxl_endpoint_decoder' on success or an errno encoded pointer on failure.

> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but it could not be available
> + * due to HPA constraints.

I'm not understanding what you mean by "but it could not be available due to HPA constraints". Maybe the last sentence needs to be rephrased.

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
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +					cxl_find_free_decoder(cxlmd);

Move this down to right before cxled is checked. It's ok the declare variable right before using with cleanup macros.

DJ

> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
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
> index ab490b5a9457..0020d8e474a6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>  
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
>  DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 788700fb1eb2..0a607710340d 100644
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
> @@ -273,4 +274,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_CXL_H__ */


