Return-Path: <netdev+bounces-128198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBE978726
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE01C227C1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACA84A32;
	Fri, 13 Sep 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lECAqKOA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828E81ACA;
	Fri, 13 Sep 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249709; cv=none; b=IQP7m7PmgOmDbKEeNqnA5skWFQ2egIdKasHaQvBCKL0nQ0LeZR/Wv0DUvQAhAF0jeVf2j39xpvIqVCdGot9TUQdSbrVwqqpPx1ycdQdf5wlGs3bSSiWqiHE486iGLJ3TcZNpdyGIP0zqEKghQys0n58C0tjAJL15EzzFk7uhpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249709; c=relaxed/simple;
	bh=euw/sDERBUlCXi68Fuorr4nj24wWTHSLrSVoRfwzWeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHTCRiYCNGLwG6BuWi7onOVjRaid/lQhSNcIAlh9ZQEpv/kB9m4Q+IWBgQxQCpG3WhFTiCHFxWdlFW54th9DiPgfuGM4nrIvJq14ofX+No6ZKNnoXbj0mY/BDK5VzN+w1BO3/k6Wp1ue6gl5g3wMACVy6DkdVoYunTC+UwaQF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lECAqKOA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726249708; x=1757785708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=euw/sDERBUlCXi68Fuorr4nj24wWTHSLrSVoRfwzWeA=;
  b=lECAqKOAMV0BLAFJmAFdF/02Wmh3f/8GUXhMNZCNT8tz+ZLRIpcPGR/N
   Uig7kzM5rnRzbbsDsB0I/WAYywx2bhOSASEym8GH2gEWe1to038lA8sMI
   Wuh1RSS6zGaTNlpzTVo08pe9yXxlKScI7snnupy8+9nFWQKtGaR1BeGta
   kcdRKTWGrgqful0sGfjpi+TRWfLuOtsDsUxrd9zadSXXwdGeO+mz68+W9
   PPatM95LP78sivDQGz8QI+tdrJMT3a8gZ4PwxQQ8MN41mCBmHJmNf8Q+/
   oD2cksSClF9pgf/m2MlM+SqSTUv7aCRPS10IsuHcHmq57+87uYDoAtGTi
   w==;
X-CSE-ConnectionGUID: NR/O8MYyRQ235iJMJFu6OQ==
X-CSE-MsgGUID: aPDyyRN8RUiIl60w1zxY0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24700842"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24700842"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:27 -0700
X-CSE-ConnectionGUID: OFr8k54ARxKKX0TxpBd61Q==
X-CSE-MsgGUID: 44W/CurgTluKWoGIfoWvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68914263"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.177]) ([10.125.108.177])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:26 -0700
Message-ID: <8afb39a9-c04f-4e61-af75-e7f6adcee36f@intel.com>
Date: Fri, 13 Sep 2024 10:48:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] cxl: add function for obtaining params from a
 region
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-20-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for given a opaque cxl region struct returns the params
> to be used for mapping such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  include/linux/cxl/cxl.h   |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45b4891035a6..e0e2342bb1ed 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2662,6 +2662,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end)

Maybe just pass in a 'struct range' to be filled out instead of start/end?

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

I think at least for me, it's better to have the introduction of helper functions to be with the code where it gets called to provide the full picture and thus make a better review. Especially if the function is fairly small. So maybe squash this patch and the next one. There may be a few other situations like this in this series worth the same consideration.
  
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 120e961f2e31..b26833ff52c0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -904,6 +904,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
>  int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 169683d75030..ef3bd8329bd8 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -76,4 +76,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     struct cxl_endpoint_decoder *cxled);
>  
>  int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  #endif

