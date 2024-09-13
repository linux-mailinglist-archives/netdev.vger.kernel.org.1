Return-Path: <netdev+bounces-128202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAC0978739
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC24F1F214F3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BD8F6A;
	Fri, 13 Sep 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxSgBUcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAA43152;
	Fri, 13 Sep 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249972; cv=none; b=HBbFrRYh5CXHJVoPj8XVMLVLVV3+wodQW3BQy9x10rq/NE3vUJPZIYjaKhDG4+a4om31MdEjf+t+ipqJK9D3ladPH2sqzD7gZrqkPz35P3wUOAiDzdXiY3FWl2j9R+xY/946qmAl0SiKzj8miyArThvFl0lIiUCGbwnbW2rVM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249972; c=relaxed/simple;
	bh=a+NakDYgdMrb5dDBALRMmAVm2rBimhuVdJ1oIPwEYXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzayPwScnUdP1hEPMvao2YQ0GDb/AfnWZ8MGPV8HP2+f4aN4jOihppw0iX7aUdnhagzYonJ8QsURmGDPTa8h8jDhiC10V5Z4xEozxLpHnt6x4CHpVwwDdOw3b3mF1Glo3LtXYY8P/jARhFmq13vD++EpKMhw1P1m2pOIqssh/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxSgBUcQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726249971; x=1757785971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a+NakDYgdMrb5dDBALRMmAVm2rBimhuVdJ1oIPwEYXs=;
  b=BxSgBUcQLB8n3cwcYj0pWr7pPB8zLBtMMDc133dzMcULojPQkq1ASS6r
   Oyg8Q8+5rRdt86IZ5x67FdvJ9gutVmRXYEDxjL386swA+LqnFIh6BlBtU
   g40HSipfvX2sYEGlf77kL5nt2zCIm8M5MAT0+OSviPPVmN4gwvIH+0Auv
   Ss+9ty8jm9PIa1br+3D36WuHUqKr3S1pZHAGAIjxHtVGZSqCDRC6wc0sU
   vj0/llF51l6lbL+9fHjJd8lkVOQNWTt/H2HTyDM8u669WZv48HyD91rOi
   B2+Y3sfLgwHGbZlaXfCNBn0HjlDKVgTaebdkm9SotIHPcNllKh4J18rUL
   A==;
X-CSE-ConnectionGUID: A0KzNLAHS96CX3LxQ1SfeA==
X-CSE-MsgGUID: xeRnno80QzuhgPbwxwkLDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25287035"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25287035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:52:50 -0700
X-CSE-ConnectionGUID: lej8pkFCQr2JwdbwZEfp5A==
X-CSE-MsgGUID: 7SV3IL5fRPC/fUF+65cRqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98988641"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.177]) ([10.125.108.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:52:48 -0700
Message-ID: <87c61aa6-a315-4cf1-8933-4212a82111f5@intel.com>
Date: Fri, 13 Sep 2024 10:52:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c       | 32 +++++++++++++++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c    | 20 ++++++++++++++++-
>  drivers/net/ethernet/sfc/mcdi_pcol.h  | 12 ++++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  2 ++
>  5 files changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 7d69302ffa0a..d4e64cd0f7a4 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -24,6 +24,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <net/udp_tunnel.h>
> +#include "efx_cxl.h"
>  
>  /* Hardware control for EF10 architecture including 'Huntington'. */
>  
> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  			  efx->num_mac_stats);
>  	}
>  
> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
> +		nic_data->datapath_caps3 = 0;
> +	else
> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
> +
>  	return 0;
>  }
>  
> @@ -949,7 +956,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
>  
>  	efx_mcdi_rx_free_indir_table(efx);
>  
> -	if (nic_data->wc_membase)
> +	if (nic_data->wc_membase && !efx->efx_cxl_pio_in_use)
>  		iounmap(nic_data->wc_membase);
>  
>  	rc = efx_mcdi_free_vis(efx);
> @@ -1263,8 +1270,19 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		return 0;
> +
> +	/* Using PIO through CXL mapping? */
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&

Maybe a FIELD_GET() call would make this cleaner

DJ


> +	    efx->efx_cxl_pio_initialised) {
> +		nic_data->pio_write_base = efx->cxl->ctpio_cxl +
> +					   (pio_write_vi_base * efx->vi_stride +
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
> +		efx->efx_cxl_pio_in_use = true;
> +	} else {
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);
> @@ -1279,12 +1297,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  			nic_data->wc_membase +
>  			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>  			 uc_mem_map_size);
> -
> -		rc = efx_ef10_link_piobufs(efx);
> -		if (rc)
> -			efx_ef10_free_piobufs(efx);
>  	}
>  
> +	rc = efx_ef10_link_piobufs(efx);
> +	if (rc)
> +		efx_ef10_free_piobufs(efx);
> +
>  	netif_dbg(efx, probe, efx->net_dev,
>  		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>  		  &efx->membase_phys, efx->membase, uc_mem_map_size,
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index dd2dbfb8ba15..ef57f833b8a7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,9 +21,9 @@
>  int efx_cxl_init(struct efx_nic *efx)
>  {
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	resource_size_t start, end, max = 0;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> -	resource_size_t max;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -132,10 +132,27 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err_region;
>  	}
>  
> +	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_map;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(start, end - start);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region failed");
> +		rc = -EIO;
> +		goto err_map;
> +	}
> +
> +	efx->efx_cxl_pio_initialised = true;
> +
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  
>  	return 0;
>  
> +err_map:
> +		cxl_region_detach(cxl->cxled);
>  err_region:
>  	cxl_dpa_free(efx->cxl->cxled);
>  err_release:
> @@ -151,6 +168,7 @@ int efx_cxl_init(struct efx_nic *efx)
>  void efx_cxl_exit(struct efx_nic *efx)
>  {
>  	if (efx->cxl) {
> +		iounmap(efx->cxl->ctpio_cxl);
>  		cxl_region_detach(efx->cxl->cxled);
>  		cxl_dpa_free(efx->cxl->cxled);
>  		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index cd297e19cddc..c158a1e8d01b 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -16799,6 +16799,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  
>  /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
>  #define    MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
> @@ -17303,6 +17306,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.
> @@ -17821,6 +17827,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.
> @@ -18374,6 +18383,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 77261de65e63..893e7841ffb4 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -967,6 +967,7 @@ struct efx_cxl;
>   * @dl_port: devlink port associated with the PF
>   * @cxl: details of related cxl objects
>   * @efx_cxl_pio_initialised: clx initialization outcome.
> + * @efx_cxl_pio_in_use: PIO using CXL mapping
>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1154,6 +1155,7 @@ struct efx_nic {
>  	struct devlink_port *dl_port;
>  	struct efx_cxl *cxl;
>  	bool efx_cxl_pio_initialised;
> +	bool efx_cxl_pio_in_use;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  
> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
> index 1db64fc6e909..b7148810acdb 100644
> --- a/drivers/net/ethernet/sfc/nic.h
> +++ b/drivers/net/ethernet/sfc/nic.h
> @@ -151,6 +151,7 @@ enum {
>   * @datapath_caps: Capabilities of datapath firmware (FLAGS1 field of
>   *	%MC_CMD_GET_CAPABILITIES response)
>   * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
>   * %MC_CMD_GET_CAPABILITIES response)
>   * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
> @@ -186,6 +187,7 @@ struct efx_ef10_nic_data {
>  	bool must_check_datapath_caps;
>  	u32 datapath_caps;
>  	u32 datapath_caps2;
> +	u32 datapath_caps3;
>  	unsigned int rx_dpcpu_fw_id;
>  	unsigned int tx_dpcpu_fw_id;
>  	bool must_probe_vswitching;

