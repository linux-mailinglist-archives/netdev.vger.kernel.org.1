Return-Path: <netdev+bounces-224491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65114B857DC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF7C1CC0C9A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01B214812;
	Thu, 18 Sep 2025 15:08:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BF238C16;
	Thu, 18 Sep 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208120; cv=none; b=Akqpedb7EU40fku4b0TMfGYuOI23E2nYe9Ebdgp5UMD8lSIXhnxZsDM9iaBbSAJt6ug5tpRzD66SzKaeraEPAxScf9Em9yz+XG5QqlUU/Z9WbsiQBJ6I5UsHmyMpQ+rWkfxMuZbYp+dyZdY4wxgL4481qBxEpWBFyT7qhZ6I/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208120; c=relaxed/simple;
	bh=gg7trQRsqucCzppGFhcqluVwiB2+H76Tlz3d44LscFQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbGoie76wRQlzMN+kwwg32cX6Nl0o+64u/Yft8e9aTAZYwBOdMQAjq9RETGYyFRenlzrlmmSbG13gXPxhF52gf2zDK7lk5VOCsAXLW5yMXn6jgdinyxyWA23XvIVsms043LQq0IT+qqepePa6skqgIr2BC9pcr39j3hXIhkQZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSJrg03k4z6GDDh;
	Thu, 18 Sep 2025 23:06:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 05067140426;
	Thu, 18 Sep 2025 23:08:35 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 17:08:34 +0200
Date: Thu, 18 Sep 2025 16:08:32 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 20/20] sfc: support pio mapping based on cxl
Message-ID: <20250918160832.00001ed7@huawei.com>
In-Reply-To: <20250918091746.2034285-21-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-21-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

A few trivial things inline.

> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 47349c148c0c..7bc854e2d22a 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 85490afc7930..3dde59003cd9 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -11,16 +11,23 @@
>  
>  #include "net_driver.h"
>  #include "efx_cxl.h"
> +#include "efx.h"
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
>  static void efx_release_cxl_region(void *priv_cxl)
>  {
>  	struct efx_probe_data *probe_data = priv_cxl;
> +	struct efx_nic *efx = &probe_data->efx;
>  	struct efx_cxl *cxl = probe_data->cxl;
>  
> +	/* Next avoid contention with efx_cxl_exit() */
>  	probe_data->cxl_pio_initialised = false;
> +
> +	/* Next makes cxl-based piobus to no be used */
> +	efx_ef10_disable_piobufs(efx);
>  	iounmap(cxl->ctpio_cxl);
> +

Avoid extra white space changes. Perhaps push to earlier patch.

>  	cxl_put_root_decoder(cxl->cxlrd);
>  }
>  
> @@ -30,6 +37,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	resource_size_t max_size;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -133,17 +141,34 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  					    &probe_data);
>  	if (IS_ERR(cxl->efx_region)) {
>  		pci_err(pci_dev, "CXL accel create region failed");
> -		cxl_dpa_free(cxl->cxled);
>  		rc = PTR_ERR(cxl->efx_region);
> -		goto err_decoder;
> +		goto err_dpa;

Why do we now need to call cxl_dpa_free() and didn't previously here? That
seems like a probably bug in earlier patch.

> +	}
> +
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_detach;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		rc = -ENOMEM;
> +		goto err_detach;
>  	}
>  
>  	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;
>  
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  
>  	return 0;
>  
> +err_detach:
> +	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
> +err_dpa:
> +	cxl_dpa_free(cxl->cxled);
>  err_decoder:
>  	cxl_put_root_decoder(cxl->cxlrd);
>  err_release:
> @@ -154,7 +179,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl) {
> +	if (probe_data->cxl_pio_initialised) {
> +		iounmap(probe_data->cxl->ctpio_cxl);
>  		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
>  				   DETACH_INVALIDATE);
>  		cxl_dpa_free(probe_data->cxl->cxled);

