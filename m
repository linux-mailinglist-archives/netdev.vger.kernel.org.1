Return-Path: <netdev+bounces-148537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E519E2002
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AA3286B53
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F51F6698;
	Tue,  3 Dec 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+YyHfp1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066A2AF05;
	Tue,  3 Dec 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237568; cv=none; b=OHn7hBapGE1I7O0+hY/5chDdqVh7yxJPqkrzsz+G1dJmA9bR+u9sSwr8zEqD2dCeYSJj+/mw4fqv8CJsTVl7jr2dIlXWfg+uvkPu6/FSCmYqzTdk4580DwV/lm3VpPcWyxv4HTh7YhHoS2URN5tDHbsnIZz4H9sEyy4md88oklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237568; c=relaxed/simple;
	bh=rS9m36SLoxmegxzRzWLvk9CSWmGpn7zVH4jpkU5s7Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn+u0CDoDVTRqwJe3abm/PWlDKGLy6ZX5Q9bL1lwrC0xi0v7Wp8hYYw4d0P7EkXe7NjlDBYQHe+SdsroXanhE+KWpASOBlTEjDDYXLOmXn+5gJoNPK3oQmAK5sLqVJoiI8gn4lZIu3xkAZsndhyackQdSI8+Ets9/HZnnD2qebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+YyHfp1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a10588f3so36518085e9.1;
        Tue, 03 Dec 2024 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237564; x=1733842364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4xxwe/P+GUjyb6u27Ym0kwJOLqxlZj+XI/nl2u4V+Y=;
        b=N+YyHfp15KDCpmb/XqymFbplWdT2sEzaqgqrw4ZhHJO/xM0c38RgDYFKt8DyGuahdf
         0r3qy+s52IwnuUUGN/cdnxeiz+Vd2bULAPcTTb4kMi258tFtntOOi3HZOtNmBwwXg7i7
         e6rEmHCrW5j66rT7kAmHn4gtB1GYKbNLLKsPuVVLBmdvymGMnPnZm87W8JO2pJffwP1k
         X9jzd+BP6oz93UOQK7hHpZSKKm7CxY0OzDFYi2ix8ZwCdMJNe3oulS2crarbHR76EzWd
         rxJ+wTSREZTsXKisdPNtN18Pz46fZSIseV+0KI33yPC4cCzVKP05lB4gfS5m13/doJ6M
         MD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237564; x=1733842364;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4xxwe/P+GUjyb6u27Ym0kwJOLqxlZj+XI/nl2u4V+Y=;
        b=K0rnzZmA/zcF+UZAOxJ1y/C9fj1PLqyYwtT4GtXFHycSYUIEK+CrW4MlYb9M+bWtV0
         u3GeTUrCyKneac5Uz+B2/RQgJd6wZhD7fTrQIqj4wZz1owi81y+qJ7XKDo0B/1MdarSo
         uXADpkNj55l04iVyFNHsqIvZt/4LENbpt12cOpNuWTFNpAjGXZ7ZDruvAvA2z2w97NTt
         IJXTBhNT8Q4Yr9RIaBSbxVDbFRY9rFyXenvf2Q+Q5tiz82IKEV30nUf29DLPcrD4hquv
         OIkJyiG5n7liD9SAhII1zGk9Nj4D9opiMZloDt7WXU5J8AO7cUoSlpC6HzYQ3VAyTvnh
         JGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWEuhxbFsIfGKALaAAKjfdvJAwiFyoElmI3fkr1bRcRWHjgidntw5ZhnOTSaZvVMXwhOp2bCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0/mMBGX8TOwL2k10y1EdmucZzX6SLOPTivZCEEIRfXKcftae
	wBa3Gp9OjMW32iEqAS81vgvvnwtvgcystEyXRKMbzd3AcdpCvIqg
X-Gm-Gg: ASbGncvZC1xjN8Vam1gndEtv8G8heqDSANuC6a7PHH1YkF2Xh38NSmSJ2HgyL0iUxRs
	LWQaBds9lPrjsMrpZCiypKbLQbkS7nobNGKD7uYkcOAuSqdiOG/OtEhE0bmW8sua9R5ZM1rRyOt
	wzusDOgp3188C2g46iQlrfC9EY+ynu73bEoUuEu3KGglExD4Lh3sxUafiTyyYx0oUsYiQiFptOy
	VXzj/DgaA//2FQ33+RSFp8M2dqqr3oYOMlx9zhe3jqyCTi0/qw=
X-Google-Smtp-Source: AGHT+IGQWkFjhBQrlAOa7TfvUGhqt/oQaNUu3UTObZ3txFl+xzooWcUjbQgJkzv99i8xFz8aKH7CXg==
X-Received: by 2002:a05:600c:4fc5:b0:434:9d36:1f04 with SMTP id 5b1f17b1804b1-434d3f8e4d9mr5150955e9.4.1733237563929;
        Tue, 03 Dec 2024 06:52:43 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe2e7sm192141795e9.11.2024.12.03.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:52:43 -0800 (PST)
Date: Tue, 3 Dec 2024 14:52:42 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 28/28] sfc: support pio mapping based on cxl
Message-ID: <20241203145242.GK778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-29-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-29-alejandro.lucero-palau@amd.com>

Hi Alejandro,

On Mon, Dec 02, 2024 at 05:12:22PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c       | 49 +++++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  4 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 452009ed7a43..f2aeffc323c6 100644
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
> @@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
>  static void efx_ef10_remove(struct efx_nic *efx)
>  {
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	int rc;
>  
>  #ifdef CONFIG_SFC_SRIOV
> @@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
>  
>  	efx_mcdi_rx_free_indir_table(efx);
>  
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
> +#else
>  	if (nic_data->wc_membase)
> +#endif
>  		iounmap(nic_data->wc_membase);
>  
>  	rc = efx_mcdi_free_vis(efx);
> @@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	unsigned int channel_vis, pio_write_vi_base, max_vis;
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	unsigned int uc_mem_map_size, wc_mem_map_size;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	void __iomem *membase;
>  	int rc;
>  
> @@ -1263,8 +1281,27 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size) {
> +		netif_dbg(efx, probe, efx->net_dev, "wc_mem_map_size is 0\n");

Please still print the details of the memory BAR that the netif_dbg has below.
It is useful for debugging.

> +		return 0;
> +	}
> +
> +	/* Set up the WC mapping */
> +
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +	    probe_data->cxl_pio_initialised) {
> +		/* Using PIO through CXL mapping? */
> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
> +					   (pio_write_vi_base * efx->vi_stride +
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
> +		probe_data->cxl_pio_in_use = true;
> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);
> @@ -1279,12 +1316,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
> index 71b32fc48ca7..78eb8aa9702a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -24,9 +24,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>  	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
> +	resource_size_t max;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> -	resource_size_t max;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -135,10 +136,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_region;
>  	}
>  
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_region_params;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region failed");

This error will be more useful if you print out the start & size. Users can
the check that against /proc/iomem.

> +		goto err_region_params;
> +	}
> +
>  	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;
>  
>  	return 0;
>  
> +err_region_params:
> +	cxl_accel_region_detach(cxl->cxled);
>  err_region:
>  	cxl_dpa_free(cxl->cxled);
>  err3:
> @@ -153,6 +169,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		iounmap(probe_data->cxl->ctpio_cxl);
>  		cxl_accel_region_detach(probe_data->cxl->cxled);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 7f11ff200c25..79b0e6663f23 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1209,6 +1209,7 @@ struct efx_cxl;
>   * @efx: Efx NIC details
>   * @cxl: details of related cxl objects
>   * @cxl_pio_initialised: cxl initialization outcome.
> ++ * @cxl_pio_in_use: PIO using CXL mapping

Extra + sign here isn't right. Please build kdoc, I expect it would have caught this.

Martin

>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
> @@ -1216,6 +1217,7 @@ struct efx_probe_data {
>  #ifdef CONFIG_SFC_CXL
>  	struct efx_cxl *cxl;
>  	bool cxl_pio_initialised;
> +	bool cxl_pio_in_use;
>  #endif
>  };
>  
> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
> index 9fa5c4c713ab..c87cc9214690 100644
> --- a/drivers/net/ethernet/sfc/nic.h
> +++ b/drivers/net/ethernet/sfc/nic.h
> @@ -152,6 +152,8 @@ enum {
>   *	%MC_CMD_GET_CAPABILITIES response)
>   * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
>   * %MC_CMD_GET_CAPABILITIES response)
> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
> + * %MC_CMD_GET_CAPABILITIES response)
>   * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
> @@ -186,6 +188,7 @@ struct efx_ef10_nic_data {
>  	bool must_check_datapath_caps;
>  	u32 datapath_caps;
>  	u32 datapath_caps2;
> +	u32 datapath_caps3;
>  	unsigned int rx_dpcpu_fw_id;
>  	unsigned int tx_dpcpu_fw_id;
>  	bool must_probe_vswitching;
> -- 
> 2.17.1
> 
> 

