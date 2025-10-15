Return-Path: <netdev+bounces-229763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC9BE09A3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9340237D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F74502F;
	Wed, 15 Oct 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gs/Dxnwc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30956129E6E;
	Wed, 15 Oct 2025 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559363; cv=none; b=biGQh9tbfdnpY8/e8ZeZGfLffhSrpdB0ozqMUMeJOitsDdx3AjXK8ImWqi1D+Wmoz2h9Q6n1S0UQw2dreKuZXj5Gjy4CsWt5kDusZQZcwrMFWCahTJ8p33oMXgRwE7GfnJ2FSE2WAxJWs2dgXAw3X3tLaRTaBzzmtdNU+ArWnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559363; c=relaxed/simple;
	bh=SJuYFA7t3MoPd2JTYwP1ftkXvqPvC2BSeJpQL6cOtDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8i6T/1OCnwKfvkLkixOdTzmetwvsuYnofjgLClbJBgAx//eQ0GuBrjOrwwCqZMP+mqayZA3IUCd5olsG4PJ4HBI6EEdOjaS+Vt9ydxvoF1m6Ed/5xqIugN7rAdQ1BYy0ms4fV1rWfQgu/g8oetFgghucv2w6Ggr/ePW57B+wro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gs/Dxnwc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559363; x=1792095363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SJuYFA7t3MoPd2JTYwP1ftkXvqPvC2BSeJpQL6cOtDM=;
  b=gs/DxnwcT245KAKnzvYD4C6Pwng2zNAqajC2CYmOpTGJCM1Gu/9BbZaB
   rRmEU/pcXGhiD+NV/eUEttmIwdrkO10d5srsAepJupkkyt2WWed0h2tDX
   7Z5YL4MulQgK+s2cQBr7Cl37gItoN8Y4eOZyoaGJYb0547tgqv9LP0vam
   F+2ju+5fgfchOaVhBeoeKP/+SbveHfeTAASbpoIs9431t9jAUdbU1Fe+f
   LOLBQqJgxPCG0jiGBdSp3uX50yfMN5aIaSKMmrf/P4vHv+IWRctqC5D2K
   td7GWvt2ItqMETMrLXewV+tai41Vb4yL7Vyn7oMOopqbjzmBWEf6ekQ27
   g==;
X-CSE-ConnectionGUID: nDUJlqXjR82gLlqHqdIGpg==
X-CSE-MsgGUID: Fp5ouZWCRlaLaYH+Sw1LZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62674280"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62674280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:16:01 -0700
X-CSE-ConnectionGUID: 1NTcdTD8QfadgH6b0RZuqA==
X-CSE-MsgGUID: +LbqJNOERqes6D0AjN2diw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182052360"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:16:00 -0700
Message-ID: <c9941eeb-045c-439a-ad1b-d0d6820eb7bc@intel.com>
Date: Wed, 15 Oct 2025 13:15:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 14/22] sfc: get endpoint decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-15-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251006100130.2623388-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index d7c34c978434..1a50bb2c0913 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENOSPC;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		cxl_put_root_decoder(cxl->cxlrd);

Might be good to create a __free() macro for freeing the root decoder instead of having to do this for every error path in this function.

DJ

> +		return PTR_ERR(cxl->cxled);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl)
> +	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
> +	}
>  }
>  
>  MODULE_IMPORT_NS("CXL");


