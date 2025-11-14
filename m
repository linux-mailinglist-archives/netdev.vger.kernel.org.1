Return-Path: <netdev+bounces-238533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98434C5AB33
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0343C3B57CF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14753596B;
	Fri, 14 Nov 2025 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ6AvlGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A961B7F4;
	Fri, 14 Nov 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078541; cv=none; b=jT9f0d1RY0LRaxveNFcFnN0QK6UreLs4WeMny8ojM7uphE+gCbnxhaT5AB9txWhEjKCW3W/CovSB2x6gdJFR8/ZWmOHxC93+WXgRKnIzcBfbXuyjykBgYtWghXd93xsRg8eT3/tVJzKabYKjmuCyxv9IiYdpB6RRDEoHsxk9GEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078541; c=relaxed/simple;
	bh=fN9TmhWAGdwHeQXGDG9AkMxQgVprB6/gzR7MhkcdEj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co11Iu7jnd7wHkIExCxEcMJU4yA8MQbWo+k/Wb1uie6ZrxrmVlOdDsmRlkZ95UfgS3kV5E1bzyHn6+NC+tDQ9jzSsb5NBnUOb3C+GpLsBIt39GX9exSUl/DPJiibYW4uimDRu1w0ilaKcaEB6i89W40CwBqnAJQPN+2LB0hD30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ6AvlGl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763078540; x=1794614540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fN9TmhWAGdwHeQXGDG9AkMxQgVprB6/gzR7MhkcdEj0=;
  b=kZ6AvlGlU4aZn2xq6jEf41aov4bTazftCf68pwfiA5z7uknbKtpryzUQ
   RDqrl/ZDKQzWb0unCHY6/bjO5USEkZ63WDUckn7plyCPWwPUblHRryMT7
   HWqaqAWgrcOEwEZaDS+uoNH7vT88aiHCl/2WPxXf4x1/NnbKN2nKwGrhh
   ZmuyBA8wJ6gq2JxpTVJksv15YLWffiA3UL+Iew7gtpb9RYqx/WMDIq9/W
   Nem9K/+6MJTbGPMpmerwmmWnZWPDfETFq94TnwQ9GV+vFAAJlTWO4PoFc
   xIMsF5VoBKLi2//eG6WZXc5hEnnucKyTqcxqmBnXquWyJLnDWWM/srzni
   g==;
X-CSE-ConnectionGUID: iCFm/iHNTueV5OuK38xd7w==
X-CSE-MsgGUID: rud/wDQkQVaGkaJ5VC4+hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65075952"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65075952"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:02:20 -0800
X-CSE-ConnectionGUID: iv52/FsMT6Khc3oddrES9A==
X-CSE-MsgGUID: eNh7HBLvQSuYq0gzlJOfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189639447"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:02:19 -0800
Message-ID: <0fdcbbef-0e48-4291-b6be-f7ee35fc44d6@intel.com>
Date: Thu, 13 Nov 2025 17:02:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 20/22] sfc: create cxl region
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-21-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Add a callback for unwinding sfc cxl initialization when the endpoint port
> is destroyed by potential cxl_acpi or cxl_mem modules removal.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 1a50bb2c0913..79fe99d83f9f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -116,6 +116,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxled);
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
> +	if (IS_ERR(cxl->efx_region)) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		cxl_dpa_free(cxl->cxled);
> +		return PTR_ERR(cxl->efx_region);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -124,6 +132,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
> +				   DETACH_INVALIDATE);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  	}


