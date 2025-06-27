Return-Path: <netdev+bounces-202045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F7AEC16D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D08188C2B5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2420B223DEE;
	Fri, 27 Jun 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbiP7RPs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5981E98F3;
	Fri, 27 Jun 2025 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057182; cv=none; b=gv+0Jd3/VsMQWitmT9/vIicsyGTJDCVwjqiAk21xg2p6NCG/Q7F7O3VnpoYLtQUibzUfhUJs+ze1FKcqI8Gbuqgvyc5S7loHBOMlWWf6K+BNqijjMG/BaMFmL/Phy1wkGjau1Pn1smW0XavuhuG0gE3PCxdr13ONn/koC1L7/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057182; c=relaxed/simple;
	bh=8u3ND+uBMZ6FjalnvuK8HSWUx8WRpbsT9ZWb01T88ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab38wMbJuKjN/5me2kaAkj6aoeIi+kS5I1YYjPW7zVV0vkb0R11tkr78JHdmpxdQcleSiy1awp7KcAGJLXcWq/Qbl7MwSjqGviBJS4YGPZlgNwNGwhp7VvroNwX9Zb3lQWsMhdjZUpr0U0ZwguuC2IuNrELNy3W44xRwqpEeE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbiP7RPs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751057180; x=1782593180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8u3ND+uBMZ6FjalnvuK8HSWUx8WRpbsT9ZWb01T88ko=;
  b=UbiP7RPsj9EB/x8cDd6BtiIi3/psWR5u69mxFTwom9TRfPiCl6cFmYos
   9JZN0qYTDDg8cK763mP4ZYtE6ZJYFEHBlqGklVm+Gb9Sz/vyVrgZnsEyJ
   QTjum6RuFTZefUqKQzWe4RWRuHyWNYHcY4HGpix9GbzG4vgaSPhLnW/JP
   gmHRpNrTV3nNMPlxTtEy1x7aRlUChAQvA9Wefu5oStlW5KKaoGpYM42Dn
   LO7Jbh9dqkzDZiwM+PYvUnZbD4xIJDZh0KrJNpq7gzfIGfEZ+wgX69aGd
   Td2MNNTeT3RIiA999po/5vwliRneq102Gz9/hE7nVpxj9fghWz8V30APb
   A==;
X-CSE-ConnectionGUID: kx2oLuyUS0SapAc7sYuaUA==
X-CSE-MsgGUID: cg9T6K8ETVOVZBSunfoJGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="57185923"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="57185923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 13:46:19 -0700
X-CSE-ConnectionGUID: 6ZMRPLCqSvW5Q+Wk9XQXBQ==
X-CSE-MsgGUID: NPP/FOIRQ2uGvrSdixSJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153441276"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 13:46:17 -0700
Message-ID: <5b3f6c11-c51c-4f24-98c1-3d5ceadf4278@intel.com>
Date: Fri, 27 Jun 2025 13:46:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/22] cxl: Define a driver interface for DPA
 allocation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace.

cxl_get_hpa_freespace()

> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c | 93 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..b17381e49836 100644
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
> @@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  	return base;
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
> @@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -686,6 +695,90 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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

return cxled->cxld.id == port->hdm_end + 1;

> +}
> +
> +static struct cxl_endpoint_decoder *
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {

Probably ok to just use guard() here

> +		dev = device_find_child(&endpoint->dev, NULL,
> +					find_free_decoder);
> +	}
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
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
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
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +				cxl_find_free_decoder(cxlmd);
> +	struct device *cxled_dev;
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!cxled) {
> +		rc = -ENODEV;
> +		goto err;

return ERR_PTR(-ENODEV);

cxled_dev is not set here. In fact it's never set anywhere. the put_device() later will fail. Although the __free() should take care of it right? The err path isn't necessary?

> +	}
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

return no_free_ptr(cxled);

DJ

> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3af8821f7c15..6e724a8440f5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -636,6 +636,8 @@ void put_cxl_root(struct cxl_root *cxl_root);
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>  
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index dd37b1d88454..a2f3e683724a 100644
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
> @@ -247,4 +248,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_CXL_H__ */


