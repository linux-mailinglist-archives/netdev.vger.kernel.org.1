Return-Path: <netdev+bounces-148510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E19E1EF7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CEEB271FA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465E1F4299;
	Tue,  3 Dec 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8fScfzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB1F12FF;
	Tue,  3 Dec 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235711; cv=none; b=EqAPTii2h0TQNzNyXCmKxrtIU7a8+Z6N3ubib15iwzBN//JeOHQvFxTuCShGFGyoRf4wA6UCIudmcvi9reYGN52usWaDfSQdwtcDYi8ec+zdTLFxuihH/uMU+Nc7MNhgIa97x7aptaj262PPwq2EjvND6A0Zork3ojl8dF/XSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235711; c=relaxed/simple;
	bh=OHw6YLM8WjR8kvo8cEuYBU0H7H+x3Uh9MitmuzFraU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCYje7YPv3KnL1WhfB94te2LWNO2bw2g3rSIsDvy3gYBc6HRDKRR7iCGwNHdlZhDUYPXeWl+Mcp2m2ZV827eglxda3zAHWd0FHzyDx1P2TtB482UKviu7TQNL/BaU+9rtKhywSc2EluJEzbArSh6BAnYMQ0faZ6fqfvtPfD1Kaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8fScfzH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a736518eso69134295e9.1;
        Tue, 03 Dec 2024 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235708; x=1733840508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVfOfPiNuL/Q+GDQ3u9ZeXu8DfNYF8e30EZeReEQ48Y=;
        b=a8fScfzHGRFziA01bcDqEjvZej76lw8QUQxczteERAnWkeVOV4/6H+8Tysc0D8gqxB
         QY1O6eSog3sbqz+AD99P1H4XpMh+/ZZk0h4x0laBsf+Seum/uH2OLUnszmAWuMdnWdIw
         TxzKTj6KgDwhutbIBEvtzUJjssq8/vql+wKPkhdb1VqxFqlUOX70HaldTXXj+W3LE/IJ
         DU+mJJi35aQ1CBczDJKRFvEy7tmdE7uTYJRAZRP/75kVq4iAk8BvHazdYKE/gym9HAeC
         TvYh+qKCYoQyGNjLFF0hoIxKmB2UsQHxtGBqH9qx73xjDgvcgEcYprzmlOjgxuSBcpTX
         l+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235708; x=1733840508;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVfOfPiNuL/Q+GDQ3u9ZeXu8DfNYF8e30EZeReEQ48Y=;
        b=lF7WWtM6ZG/+YCf9GWueJJ5Vx7JPP/yDlo4nVb9nLV/V3xNSAtsX5jxjrU32lXXv+C
         aEGpMcti4PHuZdzg9cL6WHN2kJVnF9LkYgj2NMk/GMe1RI1miBnzR8EuLm0koDKQ1NWf
         qGHNqpDQlFAI+plgTczSO2ggkmLL+BdYRm4hZZorT0z1L33ZMn7jYFFtsdft0/F7HMPB
         XGDnrwBWhWFEizFWjqICUq4LRO/SpqHmYitUVVeQI0J1PVWtMpP50QytQLQKGS1sb9Ue
         AQB1LH4JGXy7pSKMn2YgEoclsXHwpRCnEoE1ugNs92/HLkGNA0qi+t+FPWLgXbm2/p55
         5VDw==
X-Forwarded-Encrypted: i=1; AJvYcCVtRppH3+TptnEb7kIz+rXGCmhXf/ZUnT5MEjJYumMnEYpFxDUKycC/TAp/Vez16Vz1/V8OwXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkxw32MZGFleMKupeWMVhzP3ZeGSKZnvB1lMRUUQ75veSGToCO
	BXjqL31Scxr+l2Er8AQ7D158ft4yGmnZl5qvnCzu2fgN0SQ1lpUw
X-Gm-Gg: ASbGncvvRBTpQ5YFIeOmipfjGYXa3+txanQDR+eKjWr6Wsjy6/N1AOFJtyorp+ATpqB
	YgLq4sFZbUECAu2usLQWk6wamFgfFaAqROIK/bcj9frj1IEVC+anZTGBum+us/Ph3Qedw+EaB5J
	cI7EXJU9yoS5pXvIolhuPSyX3l9qUK/OpjwU6G/mY2ApYBYeNp3VHh7YrZumd37OcBfd0CLpsur
	89TFv7utnemPQy1dGv4I6VIINTE3q0GH2nI1dwi084o3noiMvY=
X-Google-Smtp-Source: AGHT+IHnj212NxrmgKWxQcscha2F2eHEWZ+PC33JENS2JE9vSLHm8vd54vD7ryIL/mhUzkSsrB8how==
X-Received: by 2002:a05:600c:6b71:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434d0a0e3c4mr24489935e9.25.1733235707679;
        Tue, 03 Dec 2024 06:21:47 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74efbesm222406835e9.7.2024.12.03.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:21:47 -0800 (PST)
Date: Tue, 3 Dec 2024 14:21:45 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 02/28] sfc: add cxl support using new CXL API
Message-ID: <20241203141947.GA778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-3-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:11:56PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/Kconfig      |  7 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 87 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++
>  6 files changed, 156 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..a8bc777baa95 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,13 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
> +	default y
> +	help
> +	  This enables CXL support by the driver relying on kernel support
> +	  and hardware support.
>  
>  source "drivers/net/ethernet/sfc/falcon/Kconfig"
>  source "drivers/net/ethernet/sfc/siena/Kconfig"
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..e909cafd5908 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
>                             tc_encap_actions.o tc_conntrack.o
>  
> +sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
>  obj-$(CONFIG_SFC)	+= sfc.o
>  
>  obj-$(CONFIG_SFC_FALCON) += falcon/
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 650136dfc642..ef3f34f0519a 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -34,6 +34,9 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#ifdef CONFIG_SFC_CXL
> +#include "efx_cxl.h"
> +#endif
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -1004,12 +1007,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +#ifdef CONFIG_SFC_CXL
> +	efx_cxl_exit(probe_data);
> +#endif
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
>  	efx_fini_struct(efx);
>  	free_netdev(efx->net_dev);
> -	probe_data = container_of(efx, struct efx_probe_data, efx);
>  	kfree(probe_data);
>  };
>  
> @@ -1214,6 +1222,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +#ifdef CONFIG_SFC_CXL
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
> +#endif
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> @@ -1485,3 +1504,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>  MODULE_DESCRIPTION("Solarflare network driver");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, efx_pci_table);
> +#ifdef CONFIG_SFC_CXL
> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
> +#endif
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..9cfb519e569f
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev;
> +	struct efx_cxl *cxl;
> +	struct resource res;
> +	u16 dvsec;
> +	int rc;
> +
> +	pci_dev = efx->pci_dev;
> +	probe_data->cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_err(pci_dev, "CXL accel device state failed");
> +		rc = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	cxl_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +
> +err2:
> +	kfree(cxl->cxlds);
> +err1:
> +	kfree(cxl);
> +	return rc;
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (probe_data->cxl) {
> +		kfree(probe_data->cxl->cxlds);
> +		kfree(probe_data->cxl);
> +	}
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..90fa46bc94db
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 620ba6ef3514..7f11ff200c25 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1199,14 +1199,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
> -- 
> 2.17.1
> 
> 

