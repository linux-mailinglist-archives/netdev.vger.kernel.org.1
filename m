Return-Path: <netdev+bounces-146570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D59D45FD
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 03:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DA7280CF3
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3013AA38;
	Thu, 21 Nov 2024 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkGUVf43"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54E136358;
	Thu, 21 Nov 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157806; cv=none; b=XvQgDxwdM6k12esFGf3+JJ5rWNuZAcB0Ct5Mb7rhSHqODTidOFzs2OgkiIBAgdYso6LNPi/9t5KReWMBKY35swkmAoFQ13js9wmFLzDw2Yv9SGrfY7u7w7/tnLFoXfyOgYS/XajVsMXVhVxn+gyAH0tLIiDKeepUC71OaNIW1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157806; c=relaxed/simple;
	bh=hmxlPQoYSjMhXa+NWDm9aF7Et+9HBZ+buV/9WSg6RuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPlBKHQXnNPJiTlLYLwOFsCUWZgf08zE4SNotfqBgsl0xm4hv0SAXdwzpocm3v1lj6knNOF8o5C4TROakjLRHxO9eN80OZ45xQosq4c9AN1PWIo3X01d4FJ16fIcNVWTV/gZJDB9MtOj2bJUp3camdBIDOgaAVtOl9JF4HgnpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkGUVf43; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732157804; x=1763693804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hmxlPQoYSjMhXa+NWDm9aF7Et+9HBZ+buV/9WSg6RuM=;
  b=NkGUVf43lZ/FSuVuxAKYPQJF4moSQcqUGfc/t9S8ZKnOuOpwprDgXg4F
   42THnn05NXVMfhvoEfwWIIJhz0Di+nBEeYr0LH7xckPMTPYW6Fvup6P8u
   Htd/ws7iIAHr6WgpBecLDu4mjIsNdmNYGHJpBEQF9hu2E5KzsWne6YN+z
   BHvZv0pY5hwHni5Bz3VF87x9mAtvx1gp3Ceu68Ivs1lMIwF2fuOplqaHT
   Q0Gkmcayt8r7NvZZmohK8I+NpiBh/TZFqjD3ZfCk/RPXS9KiHAhqjsIYj
   ODYTvLL8OqaDDX7RM8e4GIJvndBstockefOPnAE5gAeE2moJI/+DfJiY+
   Q==;
X-CSE-ConnectionGUID: S0bpkZo2Q7CIxymxfKw8Fg==
X-CSE-MsgGUID: P6c/VepgT+akbAvX7kIb3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42888679"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="42888679"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 18:56:44 -0800
X-CSE-ConnectionGUID: aYIwWo/+RZ6Qcli/64qtDg==
X-CSE-MsgGUID: m80GOGW4Rxep1V0UfG4Ikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="90231880"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 18:56:44 -0800
Date: Wed, 20 Nov 2024 18:56:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v5 26/27] cxl: add function for obtaining params from a
 region
Message-ID: <Zz6haeBDWRHL2IPR@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-27-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:33PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for given a opaque cxl region struct returns the params
> to be used for mapping such memory range.

I may not be understanding what needs to be opaque here.

Why not just 'add function to get a region resource'
and then add 'cxl_get_region_resource().

Region params usually refers to the member of struct cxl_region
that is called 'params' and that includes more than the resource.

--Alison

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  include/cxl/cxl.h         |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eff3ad788077..fa44a60549f7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2663,6 +2663,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end)
> +{
> +	if (!region)
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	*start = region->params.res->start;
> +	*end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ee3385db5663..7b46d313e581 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -913,6 +913,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2a8ebabfc1dd..f14a3f292ad8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -77,4 +77,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool avoid_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  #endif
> -- 
> 2.17.1
> 
> 

