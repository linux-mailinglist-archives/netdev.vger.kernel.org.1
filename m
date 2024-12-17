Return-Path: <netdev+bounces-152559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B020A9F492E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5F47A62AC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D181DFD9D;
	Tue, 17 Dec 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx+ncNsx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FF1DDC1E;
	Tue, 17 Dec 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432452; cv=none; b=QG4FtxoPlwscP/cLJvvuIOAmQ0UKDhGOxT/L6keGQIyhDT/hWYSKLmkJhazdXilg6NwgEpty39q8NhsFUlTCqC4MgHYAczi0qWpG7NgHXPAwweuyhVyjTVzNLuhJd4DoOWGg0yb2Qz/45u1Did9mytF3MgBuhrhOFM+Kcx+owaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432452; c=relaxed/simple;
	bh=ms7YSqlptMiVH9QYjWXdWB62kowGUi9g3XIRxmyX34g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qICS3PmLitw6yY77RzS0KPv/XGxzvJMwe8Zk2BMCY/abd6xklApXQjVRdcu83bqOrpWsuU+3nRlwpoExbNJqpTJJo2F74+DpEPWizaB7PKozl+ejQnVzabd5MiNC4p5YpWfjH8SXWanQOdU5AVtgOGnobLnbHKAzEPXjdA2VpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx+ncNsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA5FC4CED3;
	Tue, 17 Dec 2024 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734432452;
	bh=ms7YSqlptMiVH9QYjWXdWB62kowGUi9g3XIRxmyX34g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx+ncNsxxmXd8oXq1DoWQQjzd4LIxlGMAOoBw4ILcCSFinAQde9J2MUefonna/JN8
	 P+TFILRfq7fnfNLPsF1CM7xt1FMpeHRubm/UzfHBvlNoWZkWEVB/kgCR6vUiqWJH+s
	 qjqZjgV5Q1ziiFU9nd2gc9bR+1tfm5zK7hzEnjxfkMyB5DPR4wESgHXKx1H82rN2T2
	 UelIn/9bNwprdt8O1KT28ZQ/qc7aKp1kFloFBhgrxcHP2SywbngYoVOiUVTvcSPs+0
	 vRtovMjXTQI83yGKeK6E5lG5nYHUHqVEoYBCuDYQnc0Kajkpin9aSJj00DNTCkbJOJ
	 5BDQnVQmFcOZw==
Date: Tue, 17 Dec 2024 10:47:26 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 27/27] sfc: support pio mapping based on cxl
Message-ID: <20241217104726.GQ780307@kernel.org>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-28-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-28-alejandro.lucero-palau@amd.com>

On Mon, Dec 16, 2024 at 04:10:42PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>

...

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 7367ba28a40f..6eab6dfd7ebd 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -136,10 +137,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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

nit: Smatch suggests that resource_size() may be used here.

> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);

I think rc should be be set to an error value here.

Also flagged by Smatch.

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
>  err_memdev:

...

