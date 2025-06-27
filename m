Return-Path: <netdev+bounces-202075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDCAEC2B3
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BB87B49B8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95D28FFCB;
	Fri, 27 Jun 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1MgpzNe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070528852D;
	Fri, 27 Jun 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064133; cv=none; b=KpdKD6R04luLd1YpAGwAjL4mG//Dc2SBBFe7lTUrhz6j7ypLqHmQ9qn8aRLdHUfDiHFy1sNTMmzVg6A4csFR9P2WKDiaDkbP8zeHKwtG7vJmHdeqaPjyEOCvSohBzRz5nduokEU9TdUhw8z/A48iNUDR4clU89o0NGRp2K/HbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064133; c=relaxed/simple;
	bh=TA1Dtz16X6SSRE4c5KF/eT8Bjbegkbx9q9Gp81JKUw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0hd0p9Oc8fVLBFUQRQ8ubcipHN2MOteUAEJe2pKgGVhUCfrY7xjW2k2V2wddk26Pc4G9NYy9z4w+TMQs3ErBjGIfGfQBiczBG3yMYKVvi4MbhleJ6pzmNDT2pQiGJIe2artD3eoIUW737RHwovkIRLLst89/8cR2hcmo7PQX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1MgpzNe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751064132; x=1782600132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TA1Dtz16X6SSRE4c5KF/eT8Bjbegkbx9q9Gp81JKUw8=;
  b=P1MgpzNezc1/hzzvB5Vof7faiJVwssd4EW6lNmwuWZ4fVOCc4ECuHPb4
   xDtVZX3XmmQrwOo+suLA1Pet9d3SdsZU6OGIRfbwn4bBOd2lGdWt6zqlz
   5e+5ho5c1ij+4ZJPFmuIjxM5A8IHkJEnSy7arFgTK/iVcBT+fFM7FlsSA
   2y6E7rwBPN/Xfmciz16MDwfsfL0q9wOFylGtxeA0QHEIIEMaTjgZhy6Sv
   d+mmcxhi7n06fggFWy+ErE/OftvIRVdDrpom3BTkZPYtW5Qg6udga/MUd
   34hbK4Q08yGYvfUj5zP2XC+o3Xp9e5KlQtVUVwn96iDPjffDeeNqJKevH
   A==;
X-CSE-ConnectionGUID: JDB66wgjRsG0LTDSzGeiXw==
X-CSE-MsgGUID: 5m50HNEMQ462XHTIxTaKIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53324858"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53324858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:42:11 -0700
X-CSE-ConnectionGUID: 50VSodcsTBiPQ6M8P5xH0g==
X-CSE-MsgGUID: XGkmH/qFQOGlKylyhQQBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="183833835"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:42:10 -0700
Message-ID: <380431fc-686f-4ed5-bb1a-c7e679f88555@intel.com>
Date: Fri, 27 Jun 2025 15:42:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/22] cxl: Define a driver interface for HPA free
 space enumeration
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA

from Device Physical Address (DPA)

> (host-physical-address space). Before determining how much DPA to

Host Physical Address (HPA)

> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,

s/equal, some sepcifically targets/equal. Some HPA targets/

s/target PMEM/targets PMEM/


> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).

s/host-only (HDM-H)/HDM-H (host-only)/
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 169 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  11 +++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..03e058ab697e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,175 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	/*
> +	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
> +	 * 32 bits, the bitmap functions can be used.

Should this be type2_find_max_hpa() since CXL_DECODER_F_MAX here is defined to only check up to the type2 bit?

> +	 */
> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {

'found' never greater than 1 since it breaks immediately above on the first encounter? Should the break be there?

> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
Could res be NULL here on the first iteration with res = cxlrd->res->child && res == NULL? Maybe set res to cxlrd->res above, and then pass in res->child to resource_size() above?

> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}

Can you do something like this to avoid keep checking prev?

if (prev) {
	if (!resource_size(prev))
		continue;
	if (res->start > prev->end + 1) {
		...
	}
} else {
	if (res->start > cxlrd->res->start) {
		...
	}
}

> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
Maybe

if (next) {
	...
} else {
	...
}

> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));

Should this ref grab be a lot earlier in this function? Before we start using the cxlrd members?

> +		ctx->cxlrd = cxlrd;> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: the endpoint requiring the HPA
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);

Should move this whole line below right before checking for 'root'.

> +
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +/*
> + * TODO: those references released here should avoid the decoder to be
> + * unregistered.

Are we missing code? Is it done later in the series?

> + */
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(CXLRD_DEV(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b35eff0977a8..3af8821f7c15 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -665,6 +665,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)

Maybe lower case to keep formatting same as other similar macros under CXL subsystem?

> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2928e16a62e2..dd37b1d88454 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -25,6 +25,11 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +#define CXL_DECODER_F_MAX 3
> +

redefinition from drivers/cxl/cxl.h. Should those definition be deleted? Maybe move the whole thing over to here and call CXL_DECODER_F_MAX something else?

>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.
> @@ -236,4 +241,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlmds);
>  struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>  void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif /* __CXL_CXL_H__ */


