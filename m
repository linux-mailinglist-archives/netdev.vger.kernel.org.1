Return-Path: <netdev+bounces-128192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6D9786DF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69651F22B9F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A14F883;
	Fri, 13 Sep 2024 17:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8D1C14;
	Fri, 13 Sep 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248926; cv=none; b=MaMkheZg/LpP2RHLUWq16O3UyYi7JSJIZaVpd1zH20ieFib3h+BmhsBLzCbtxqAhBKtqovX5XkBxgOpxJM3qo0gyI81CrExYLUrA+pQ4F9HuPSydfNhTjfpHYEnYIWPui+7FU5Mdto4DzgeLvPF3BtY3X56w14E7ayypMQpYDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248926; c=relaxed/simple;
	bh=FFd/sKvK40Z5X40R4nuepugWUp9YO/8dZgGP+4r4DjA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsBNHN96WVMwGGr1v2uDGJ4rfswdn8Y8nVUPpkp3n8seCIQXWRhBsiWOiSjhyEEa5KfkH6IrGTwUFC7438J8Y7N3YgUjv7b5nJPeCeN+Sxyklc/oV+3Xs4NLxv6Z1qRh/IxyAuSWM5A0kChW+cFCY7EEeXMu/mm9Ns6YlZ8W26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X51ZQ3lqFz6L6sQ;
	Sat, 14 Sep 2024 01:31:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D6830140A77;
	Sat, 14 Sep 2024 01:35:22 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 19:35:22 +0200
Date: Fri, 13 Sep 2024 18:35:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 06/20] cxl: add functions for resource
 request/release by a driver
Message-ID: <20240913183520.000002be@Huawei.com>
In-Reply-To: <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-7-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:22 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and
> releaseing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 40 ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++
>  include/linux/cxl/cxl.h            |  2 ++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 10c0a6990f9a..a7d8daf4a59b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,46 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_ACCEL_RES_RAM:
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +		break;
> +	case CXL_ACCEL_RES_PMEM:
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +		break;

return request_resource()

> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);

No unknown. We know exactly what it is (DPA) but we don't have it.
Unexpected maybe?

> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_ACCEL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
> +		break;
> +	case CXL_ACCEL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
return ..

> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);

As above. Probably know what we got, it it unexpected not unknown.

> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index fee143e94c1f..80259c8317fd 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -72,6 +72,12 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err;
>  	}
>  
> +	rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL request resource failed");
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	kfree(cxl->cxlds);
> @@ -84,6 +90,7 @@ int efx_cxl_init(struct efx_nic *efx)
>  void efx_cxl_exit(struct efx_nic *efx)
>  {
>  	if (efx->cxl) {
> +		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
>  		kfree(efx->cxl->cxlds);
>  		kfree(efx->cxl);
>  	}
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index f2dcba6cdc22..22912b2d9bb2 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -52,4 +52,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>  			u32 *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif


