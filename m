Return-Path: <netdev+bounces-116196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12979496F2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551211F24487
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23B381C4;
	Tue,  6 Aug 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+YdayeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E469770F3;
	Tue,  6 Aug 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965651; cv=none; b=aROc2Cj6QTlcF9UnfjiK8kqHqwPrgMm51sklqujvnua8ZYCZvMWMdBgtcD/wSNDIYhuugi1SgxHhcFB+Zyeg8GY/aZ+t3ZChwXSg2+u6XnGRrvYhHOtWncRh5lbYvfgk/vLEZZ6JF8udGdZmesUwdOTnyBWhdA1oHC3RbQ45zmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965651; c=relaxed/simple;
	bh=YYt3i1QwaVLEEfc9XdjMd+mLpl+pnz3P4xY+TvknjRI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0+ODSylsRjX4kbva8We3PK8JYZG34wB6jSQlCZRh0VMqsIL31LwZUFRnke///iVKwipYlihsP8nq7hVB2YZ92jP9YLEAUi8lgbP8xFUByD4pDThCihf/pHtRfruNfiYYZcPL0zdxz3rXXVQh5ubMciwOF75pCExYMx4fhMjqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+YdayeX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-651da7c1531so7117077b3.0;
        Tue, 06 Aug 2024 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965648; x=1723570448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/dijiz0EH92ZFCcCib2UX6qOQ2ginxd/v4yrYrYTM4=;
        b=T+YdayeXn5jzQPqYHL4s86lSPdXZOcHa2wThfPi6ixKXiCOy6NkfCywoI2nnw/E8YZ
         ouSJ5hDVSM2jjBrcnHnyghoJZFhXs77F4kGCVsxd0OJl3YXrQ4eCu0B00mKyhGC2BJ1b
         0+4MhfCltwfjILI6xA05C454Xdl4ofcVXbav8bmHUe3spEpdU+kar0YZGVcMRflfKIZ0
         GGFdD+LUlc48gE8B4eyRrsCm0R71/aWwHRZ8en2yCtXHalTSCjF9of2uaxY0WmxSY2aO
         O2mf9uQRpqXEYCO261hj6A0T+rLHVSFLDP5nbG2SzviYanpsX5bPQi86FYWFmKp6Ny+P
         lNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965648; x=1723570448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/dijiz0EH92ZFCcCib2UX6qOQ2ginxd/v4yrYrYTM4=;
        b=Ol0Mvmn46HBmyQ10yWjX8LpSnzmjGYDOYwjIKDGcjmejZEtdKfzwKeyIq+b63noCkQ
         +5Zbvrz1Eh2I1ORJ6LsTvppTglUnKCOroBSlHU6w3umeCOws7Kgc1/OUwVG/Pw1PubQk
         WWhoirRaaGcGqybxQPSx8MS5FJd+D6uMgZmRwbSuHOQSx5BHqw7uGhzRjkRcZroYjlGZ
         FmYUVgMtk1jG+/qVnIBMjdw5KDrazjMvtIGFrxH/sWirEetvUtc6+Obc/rlZYxNpfi6l
         vm7KhyXuKcvUssjtQSWZ0Xy1jO/vjcGv4y/D3IZ18ei9f9fHDy6u/hFJCeyl+2rXGo46
         bWUA==
X-Forwarded-Encrypted: i=1; AJvYcCV7G1RlXRL1c3FMwXrOFln7zsKF4IHEjitlHSL/a6J0Tw7DcXhtGaFKO3aUE3+yZnRdeW8x4NfpdLDLrbJzNMOKZyUN3W+s
X-Gm-Message-State: AOJu0YwoWtJGrtsIfbsz7jqTT4725itXVNyS2Ou+5FXxewz1a4x5qo1h
	NYGci/HSosnqzlPXLpD3B65V5DqoYYfumE99c2bMV2os1XW7emaJZr+IRA==
X-Google-Smtp-Source: AGHT+IHWLSaNIVrQIOJDYWP+LhgakR9Vk3J9gR3irIr/Ht1U3T4MeVRvDSTpH3gz5YgFxF3cA40ZjQ==
X-Received: by 2002:a0d:e087:0:b0:647:88ba:f91b with SMTP id 00721157ae682-68960777bcemr162128477b3.11.1722965647999;
        Tue, 06 Aug 2024 10:34:07 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a10659fdasm15936567b3.63.2024.08.06.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:34:07 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 6 Aug 2024 10:33:38 -0700
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 10/15] cxl: define a driver interface for DPA
 allocation
Message-ID: <ZrJecn2KNn_5_Xef@fan>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-11-alejandro.lucero-palau@amd.com>

On Mon, Jul 15, 2024 at 06:28:30PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to  map the minimum amount of memory the driver needs to
> operate vs the total possible that can be mapped given HPA availability.
> 
> Factor out the core of cxl_dpa_alloc, that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h            |   1 +
>  drivers/cxl/core/hdm.c             | 153 +++++++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx.c     |   2 +
>  drivers/net/ethernet/sfc/efx_cxl.c |  18 +++-
>  drivers/net/ethernet/sfc/efx_cxl.h |   1 +
>  include/linux/cxl_accel_mem.h      |   7 ++
>  6 files changed, 161 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 625394486459..a243ff12c0f4 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -76,6 +76,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_decoder_mode mode);
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);

Function declared twice here.

Fan
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
>  
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4af9225d4b59..3e53ae222d40 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/cxl_accel_mem.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -420,6 +421,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	up_write(&cxl_dpa_rwsem);
>  	return rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
>  
>  int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_decoder_mode mode)
> @@ -467,30 +469,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	return rc;
>  }
>  
> -int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> +					 resource_size_t *start_out,
> +					 resource_size_t *skip_out)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	resource_size_t free_ram_start, free_pmem_start;
> -	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> -	int rc;
> -
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.region) {
> -		dev_dbg(dev, "decoder attached to %s\n",
> -			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> -	}
>  
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held(&cxl_dpa_rwsem);
>  
>  	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
>  		last = p;
> @@ -528,14 +517,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
>  	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> +		avail = 0;
> +	}
> +
> +	if (!avail)
> +		return 0;
> +	if (start_out)
> +		*start_out = start;
> +	if (skip_out)
> +		*skip_out = skip;
> +	return avail;
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	int rc;
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.region) {
> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
> +			     dev_name(&cxled->cxld.region->dev));
> +		rc = -EBUSY;
>  		goto out;
>  	}
>  
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
> +
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxl_decoder_mode_name(cxled->mode), &avail);
> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> +			     &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> @@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     bool is_ram,
> +					     resource_size_t min,
> +					     resource_size_t max)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_decoder_mode mode;
> +	struct device *cxled_dev;
> +	resource_size_t alloc;
> +	int rc;
> +
> +	if (!IS_ALIGNED(min | max, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	if (!cxled_dev)
> +		cxled = ERR_PTR(-ENXIO);
> +	else
> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (IS_ERR(cxled))
> +		return cxled;
> +
> +	if (is_ram)
> +		mode = CXL_DECODER_RAM;
> +	else
> +		mode = CXL_DECODER_PMEM;
> +
> +	rc = cxl_dpa_set_mode(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (max)
> +		alloc = min(max, alloc);
> +	if (alloc < min) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index cb3f74d30852..9cfe29002d98 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -901,6 +901,8 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  
>  	efx_fini_io(efx);
>  
> +	efx_cxl_exit(efx);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 6d49571ccff7..b5626d724b52 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -84,12 +84,28 @@ void efx_cxl_init(struct efx_nic *efx)
>  		goto out;
>  	}
>  
> -	if (max < EFX_CTPIO_BUFFER_SIZE)
> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>  		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
>  				  max, EFX_CTPIO_BUFFER_SIZE);
> +		goto out;
> +	}
> +
> +	cxl->cxled = cxl_request_dpa(cxl->endpoint, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled))
> +		pci_info(pci_dev, "CXL accel request DPA failed");
>  out:
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  }
>  
> +void efx_cxl_exit(struct efx_nic *efx)
> +{
> +	struct efx_cxl *cxl = efx->cxl;
> +
> +	if (cxl->cxled)
> +		cxl_dpa_free(cxl->cxled);
> + 
> + 	return;
> + }
>  
>  MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 76c6794c20d8..59d5217a684c 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -26,4 +26,5 @@ struct efx_cxl {
>  };
>  
>  void efx_cxl_init(struct efx_nic *efx);
> +void efx_cxl_exit(struct efx_nic *efx);
>  #endif
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index f3e77688ffe0..d4ecb5bb4fc8 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>  
>  #include <linux/cdev.h>
> +#include <linux/pci.h>
>  
>  #ifndef __CXL_ACCEL_MEM_H
>  #define __CXL_ACCEL_MEM_H
> @@ -41,4 +42,10 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>  					       int interleave_ways,
>  					       unsigned long flags,
>  					       resource_size_t *max);
> +
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     bool is_ram,
> +					     resource_size_t min,
> +					     resource_size_t max);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif
> -- 
> 2.17.1
> 

