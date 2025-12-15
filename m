Return-Path: <netdev+bounces-244757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDACBE279
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99AE03018953
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD62EC0AA;
	Mon, 15 Dec 2025 13:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C62EE5FD;
	Mon, 15 Dec 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807044; cv=none; b=PBire5kKwr0P6VgqeVSdtZsaxhPhnbOaDb+pRdd5zVdXE5tLBeWuOaCOGWXtUh3xdI5VMaBWF2GQxCUNavJ2iS57MR0ahiXdtn/39/eMNYOnxKJszkmvhBwE4WmpbSnkWHoLl6Xl3zHfQQEY5RBbbesufTs3hRn15OtrpszNHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807044; c=relaxed/simple;
	bh=fgVfPyib0XC0iSs3VOivIP886sNc9dUXVmYJsdgOUt0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy53lh8RcxDLQjyR52OI2qXzPi5L1ZoHAly4xwyWa4Ay40lmpP49NZOjBgWHqHwnyY4JNbYG8bYPPh/BUpS1gF4m9aLwSaHMR5tkMiIj9b1jMlKCpEm4Z87DXOxUNaYhu+Mbp1qYmEFUDGzahvi1gTpqIldsn9hWiNyXxpcLpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVM784hdszJ46kj;
	Mon, 15 Dec 2025 21:56:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CFA2E40565;
	Mon, 15 Dec 2025 21:57:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 13:57:16 +0000
Date: Mon, 15 Dec 2025 13:57:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v22 14/25] sfc: obtain decoder and region if committed
 by firmware
Message-ID: <20251215135715.00001ee7@huawei.com>
In-Reply-To: <20251205115248.772945-15-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
	<20251205115248.772945-15-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 5 Dec 2025 11:52:37 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
I'm confused.  If this only occurs if there is a committed decoder,
why is the exist cleanup unconditional?

Looks like you add logic around this in patch 16. I think that should be
back here for ease of reading even if for some reason this isn't broken.

Jonathan

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index f6eda93e67e2..ad1f49e76179 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -90,6 +91,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
> +	if (cxl->cxled) {
> +		if (!cxl->efx_region) {
> +			pci_err(pci_dev, "CXL found committed decoder without a region");
> +			return -ENODEV;
> +		}
> +		rc = cxl_get_region_range(cxl->efx_region, &range);
> +		if (rc) {
> +			pci_err(pci_dev,
> +				"CXL getting regions params from a committed decoder failed");
> +			return rc;
> +		}
> +
> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +		if (!cxl->ctpio_cxl) {
> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -97,6 +118,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +	cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0, DETACH_INVALIDATE);
> +	unregister_region(probe_data->cxl->efx_region);
>  }
>  
>  MODULE_IMPORT_NS("CXL");


