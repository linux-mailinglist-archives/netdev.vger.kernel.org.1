Return-Path: <netdev+bounces-181842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6AA86919
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F5E1B846A1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272E23A995;
	Fri, 11 Apr 2025 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOvBmeiD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D4202F87;
	Fri, 11 Apr 2025 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413538; cv=none; b=IrvbL1HHaS1LpU03yNkOwoPCtd5SWddyGkTeE7zrfu0R5kotA3O9Jl61g9/rXDutlQZV7Y7w4o/f6BQTFEm4hHEEyJOm+wt25Fl8i5sDxw1ujFfay/7UBGqg8LHMkq/gu3yLEAzSevqiyYagHv9qLguKhmRI6P6Xw1rnM9H+q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413538; c=relaxed/simple;
	bh=vQs2PxrGrDmqMMOZu/dnXDoyB1thjPde63wtCSz4rs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGGvfm7xQdSV9pXvdIwZYJFmehXf8H0aGtj5jm8p0pf0EVXOFSprGzpzRqGq1cYoXoZGryRBIKPBIcoT88zuHlnBeZsgbqGR3JhL+w2fx70OyFxNeQf0jzOo7GVkJiScMLN/8LtfmNrdPKEisp5gv1DS4y7wuOxdzc4CBka5/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOvBmeiD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744413536; x=1775949536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vQs2PxrGrDmqMMOZu/dnXDoyB1thjPde63wtCSz4rs0=;
  b=lOvBmeiDihFNZt2K8x2pMkxM4oA4fPmaVKLh3udmTMDBOZytgJPJK9N0
   vawPXNQw09ebKaREAKFiKz0uHRcvHoiuf0BYP9iSRqkFBypfuvJp1PwRw
   8a52QexNZdHrC1L3gYA/E8mqtiIJ4JR1WXVIf1jmU/UcZvXWO0MfCJgdn
   KYgkG7UdeFphehBxhlUNlsmxTymk/JObHvCZKzPF10kjrcf32J6SbucjU
   aF+qMsVgachCWgMVYC+a3IfwPxtwA+x4O3eBQF8r2XQyXtxQWlNpRvJlU
   jQldR+VR0MjkZyYlZkc/H3W58ne0fo37g2uxi98xFm4QxruNrikxJmMzt
   A==;
X-CSE-ConnectionGUID: QNgp6QlLR8Kh7N1aYknBSQ==
X-CSE-MsgGUID: CxPPmbuRSoax11RDCNf6cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="57354213"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="57354213"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:18:54 -0700
X-CSE-ConnectionGUID: 2omd6tn8SC29N2dQEEB9/Q==
X-CSE-MsgGUID: gZHV8M2vSO+DrRm98G9ZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134299768"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:18:53 -0700
Message-ID: <9913bfa1-c612-4b51-8b53-4b5449c8dd30@intel.com>
Date: Fri, 11 Apr 2025 16:18:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/23] cxl: allow region creation by type2 drivers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 135 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  3 files changed, 135 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 892fb799bf46..f2e1d5719a70 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	cxled->part = -1;
> +	rc = cxl_region_detach(cxled);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2816,6 +2827,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
> @@ -3520,14 +3539,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
> @@ -3536,13 +3553,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> -	if (IS_ERR(cxlr)) {
> +	if (IS_ERR(cxlr))
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
> -		return cxlr;
> -	}
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
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -3553,6 +3580,98 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +
> +	/*
> +	 * Sanity check. This should not happen with an accel driver handling
> +	 * the region creation.
> +	 */
> +	p = &cxlr->params;
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s  unexpected region state\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__);
> +		rc = -EBUSY;
> +		goto err;
> +	}
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto err;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto err;
> +
> +	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_region_attach(cxlr, cxled, 0);> +	up_read(&cxl_dpa_rwsem);
> +> +	if (rc)
> +		goto err;

	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
		rc = cxl_region_attach(cxlr, cxled, 0);
		if (rc)
			goto err;
	}



> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	return cxlr;
> +err:
> +	drop_region(cxlr);
> +	return ERR_PTR(rc);
> +}
> +
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + * @ways: interleave ways required
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled, int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))
> +		return cxlr;
	scoped_guard(mutex, &cxlrd->range_lock) {
		cxlr = __construct_new_region(cxlrd, cxled, ways);
		if (IS_ERR(cxlr))
			return cxlr;
	}

DJ

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
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d2bfd1ff5492..f352f2b1c481 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
>  static int discover_region(struct device *dev, void *root)
>  {
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
>  	int rc;
>  
>  	if (!is_endpoint_decoder(dev))
> @@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
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
> index 22061646b147..133d6db3a70a 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -261,4 +261,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     bool is_ram,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled, int ways);
> +
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


