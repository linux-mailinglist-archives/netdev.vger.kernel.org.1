Return-Path: <netdev+bounces-224841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D16B8AE3E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41E517C6B6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F52258ECE;
	Fri, 19 Sep 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8IihCB/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EB4A3E;
	Fri, 19 Sep 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306059; cv=none; b=SaY6rEXBVj5+rxtNJg0D4nZaBsc4OS4nH2ckWW4i49kO+mfgD0xq9pt4QfSfOoL/mrZjXG00UQ69vNCjpXLTR8wuBcPCiqaBgwgyCf1CMML9W/fyMJ+ttguQznhaJn+9exVPXlzG9f3qT274/aE5hTwn1FOTaY+EwsJETNR4jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306059; c=relaxed/simple;
	bh=O6TGfimDGfbEgQ/jsjQ4ENu+WV+dZu+J5uVwTi2YYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JatsogBAYkaN4aEcZ9MlSQovufnbvrcj/qiaNI/Wj+Uxwo0KDPD1/VvRV9F5Zejm/IfPlkCJTktZsoqGevWmZn+VX+hqOTzbujMbrTs2FuyGFgI+Vnthqn368YkNk/MdU8pI8884egIU0eb4nHMUWvJnDAPXw1nI4Rww5af1CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8IihCB/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758306057; x=1789842057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O6TGfimDGfbEgQ/jsjQ4ENu+WV+dZu+J5uVwTi2YYhc=;
  b=Q8IihCB/SsT5wr8XC5LeZb59jjhXtCQ9Xd8eymfSn/oD/5qxn7UM8O0l
   4CJY8dHyuazmL8lX3iCYqxpg1gsHy6sgnGrz0nFtoAFaMgPU8q8oDW1p4
   YRhkG27gCz57f2uhmpQx0a9amW+Ys+GPqX7HMbzxq4kBzYzR6miiS5mYk
   kHQ0NKYznTie3N4SH7nBFiM97pxQ4h1d3Ub3aDCW9Zd1YIMWcXC6aNK23
   C5QlMup9i61YvVY3XqkmJmcTAFva2er7Ykp0kBZnv9KvGG3Gp3KeywKlD
   oknbTHddWah+ZwaN/yMahHBLJqk0yZIqaIi7o9rJT6F/TxlcpY4ZeBSqi
   w==;
X-CSE-ConnectionGUID: KdaXWZ0/SNmtqlcKq+UByw==
X-CSE-MsgGUID: /7rBRbHKTi6S8ClB/M6Mxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71764480"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="71764480"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:20:57 -0700
X-CSE-ConnectionGUID: I0KqIfnETgi5yG43kWxjNQ==
X-CSE-MsgGUID: 0BMjWMbfR3qy6NnKp19xmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="180135429"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:20:55 -0700
Message-ID: <c4d4f61a-ef32-4156-a083-399b81a314e7@intel.com>
Date: Fri, 19 Sep 2025 11:20:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 10/20] sfc: get root decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting HPA (Host Physical Address) to use from a
> CXL root decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h                  | 15 ---------------
>  drivers/net/ethernet/sfc/Kconfig   |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
>  include/cxl/cxl.h                  | 14 ++++++++++++++
>  4 files changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 076640e91ee0..ab490b5a9457 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -219,21 +219,6 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>  
> -/*
> - * cxl_decoder flags that define the type of memory / devices this
> - * decoder supports as well as configuration lock status See "CXL 2.0
> - * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> - * Additionally indicate whether decoder settings were autodetected,
> - * user customized.
> - */
> -#define CXL_DECODER_F_RAM   BIT(0)
> -#define CXL_DECODER_F_PMEM  BIT(1)
> -#define CXL_DECODER_F_TYPE2 BIT(2)
> -#define CXL_DECODER_F_TYPE3 BIT(3)
> -#define CXL_DECODER_F_LOCK  BIT(4)
> -#define CXL_DECODER_F_ENABLE    BIT(5)
> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> -
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
>  	CXL_DECODER_HOSTONLYMEM = 3,
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 979f2801e2a8..e959d9b4f4ce 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>  config SFC_CXL
>  	bool "Solarflare SFC9100-family CXL support"
>  	depends on SFC && CXL_BUS >= SFC
> +	depends on CXL_REGION
>  	default SFC
>  	help
>  	  This enables SFC CXL support if the kernel is configuring CXL for
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 177c60b269d6..d29594e71027 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	resource_size_t max_size;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -88,13 +89,39 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		return PTR_ERR(cxl->endpoint);
> +
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max_size);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +		return PTR_ERR(cxl->cxlrd);
> +	}
> +
> +	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
> +		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
> +			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +		return -ENOSPC;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +
>  	return 0;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (probe_data->cxl)
> +		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  }
>  
>  MODULE_IMPORT_NS("CXL");
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 7722d4190573..788700fb1eb2 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -153,6 +153,20 @@ struct cxl_dpa_partition {
>  
>  #define CXL_NR_PARTITIONS_MAX 2
>  
> +/*
> + * cxl_decoder flags that define the type of memory / devices this
> + * decoder supports as well as configuration lock status See "CXL 2.0
> + * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> + * Additionally indicate whether decoder settings were autodetected,
> + * user customized.
> + */
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +#define CXL_DECODER_F_TYPE3 BIT(3)
> +#define CXL_DECODER_F_LOCK  BIT(4)
> +#define CXL_DECODER_F_ENABLE    BIT(5)
> +
>  struct cxl_memdev_ops {
>  	int (*probe)(struct cxl_memdev *cxlmd);
>  };


