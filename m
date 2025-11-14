Return-Path: <netdev+bounces-238532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7BC5AB30
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E52F34DCFD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E33185E4A;
	Fri, 14 Nov 2025 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhZpAXdL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676A35959;
	Fri, 14 Nov 2025 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078447; cv=none; b=gTWt6wkyVCdGrbKsxqUn2jh86eGGSiMTXZGXncestokhuXNI+1Ws3ifRrW4hYYdNiv9Zu3SBfESRS9n7qP1dDw04VFUyqZvpPQt4ku74GFSY5UU+PhbEMQlvMkmyNb22vXO4pwq4G25t3LwkkhrmvEUowt4dv5pv1u6MPd91/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078447; c=relaxed/simple;
	bh=fIplmWhDMhLaLLOzB5i4/6aTZOKaKwTr5pcRRDEuLps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOA3nrE0u5d6qiYDjQQUW1AOc01Amczca0aYDiPrnHVM2SFCjcPuuS2hpHqRg+dh+6HtUINaQFrAPDCV4fD8TSs/ONV4hvVIYNd5ngMMQz9xlEkCtyN7zPm9sgCa/LNhl/kF4uaw0WEMdbCXfIxsKivFBwUgCz9zll2rQ5HMRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhZpAXdL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763078446; x=1794614446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fIplmWhDMhLaLLOzB5i4/6aTZOKaKwTr5pcRRDEuLps=;
  b=PhZpAXdLYys5TeNiWk+OQsp+94Fj3PkZAPPSvkqrGvpSzqLnvyLzMV2a
   NBfuzaYRcjlIrFEn9dr2YO/CXUhUnHjO/R9Zi/Jk97vA9MpisrJ6Efp/8
   +Rs/VM/E85YlMeYuO0t+i2tLszv+TqjN3zOAyNYo5QXrNXOtEmD38mHaQ
   5kE+5lYz20VGOZO9tt7XUz8VUC6xPEFYcKrHiqEoyNMTwrKq2b/MdM6E2
   ZEYts8ng7Nc40x25XsaxMcH0KNJosbevWeJSPl8HMYwd/J4BhaVrR28S2
   7UpqL74eUzIT0nLa4ZXVK3AvApHUuqzMRN0s39CxJ9r8sPgvcQ8pMqYbU
   A==;
X-CSE-ConnectionGUID: +KdOo1AUSf2dHshk8AW9Bg==
X-CSE-MsgGUID: Q0ahXXSHTyaUlgYd311akw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65075676"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65075676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:00:45 -0800
X-CSE-ConnectionGUID: 41kGEUQRSQK73uvQk7ucUw==
X-CSE-MsgGUID: 0nWO4oi1Qoef5dscT8HCnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189639153"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:00:44 -0800
Message-ID: <9724efa5-bf02-4e4f-998d-d79b81a9dfe3@intel.com>
Date: Thu, 13 Nov 2025 17:00:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 18/22] cxl: Allow region creation by type2 drivers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders. Only support uncommitted CXL_DECODER_DEVMEM decoders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/core.h   |   5 --
>  drivers/cxl/core/hdm.c    |   7 ++
>  drivers/cxl/core/region.c | 134 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |  11 ++++
>  5 files changed, 149 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1c1726856139..9a6775845afe 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -15,11 +15,6 @@ extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> -enum cxl_detach_mode {
> -	DETACH_ONLY,
> -	DETACH_INVALIDATE,
> -};
> -
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 88c8d14b8a63..33b767bdedec 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1104,6 +1104,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  	/* decoders are enabled if committed */
>  	if (committed) {
> +		if (cxled && cxled->cxld.target_type == CXL_DECODER_DEVMEM) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: DEVMEM decoder committed by firmware. Unsupported\n",
> +				 port->id, cxld->id);
> +			kfree(cxled);
> +			return -ENXIO;
> +		}
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2424d1b35cee..63c9c5f92252 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2385,6 +2385,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>  
>  static int __attach_target(struct cxl_region *cxlr,
>  			   struct cxl_endpoint_decoder *cxled, int pos,
> @@ -2868,6 +2869,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3698,14 +3707,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	int rc, part = READ_ONCE(cxled->part);
> +	int part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
>  	do {
> @@ -3714,13 +3721,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> -	if (IS_ERR(cxlr)) {
> +	if (IS_ERR(cxlr))
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
> +
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
>  		return cxlr;
> -	}
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -3731,6 +3751,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	int rc, i;
> +
> +	struct cxl_region *cxlr __free(cxl_region_drop) =
> +		construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	/*
> +	 * Sanity check. This should not happen with an accel driver handling
> +	 * the region creation.
> +	 */
> +	p = &cxlr->params;
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s  unexpected region state\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> +			__func__);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		for (i = 0; i < ways; i++) {
> +			if (!cxled[i]->dpa_res)
> +				break;
> +			size += resource_size(cxled[i]->dpa_res);
> +		}
> +		if (i < ways)
> +			return ERR_PTR(-EINVAL);
> +
> +		rc = alloc_hpa(cxlr, size);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
> +		for (i = 0; i < ways; i++) {
> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
> +			if (rc)
> +				return ERR_PTR(rc);
> +		}
> +	}
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	return no_free_ptr(cxlr);
> +}
> +
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoders with reserved DPA capacity
> + * @ways: interleave ways required
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
> +	mutex_unlock(&cxlrd->range_lock);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> +
>  static struct cxl_region *
>  cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ef65d983e1c8..033de5a3ffd5 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
>  static int discover_region(struct device *dev, void *unused)
>  {
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
>  	int rc;
>  
>  	if (!is_endpoint_decoder(dev))
> @@ -43,7 +44,9 @@ static int discover_region(struct device *dev, void *unused)
>  	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>  		return 0;
>  
> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->state != CXL_DECODER_STATE_AUTO ||
> +	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>  		return 0;
>  
>  	/*
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1cbe53ad0416..c6fd8fbd36c4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -275,4 +275,15 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     enum cxl_partition_mode mode,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways);
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
>  #endif /* __CXL_CXL_H__ */


