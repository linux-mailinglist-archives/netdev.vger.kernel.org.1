Return-Path: <netdev+bounces-154202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDE9FC0E9
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6DA7A1B49
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257D19995A;
	Tue, 24 Dec 2024 17:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362031D79B3;
	Tue, 24 Dec 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061143; cv=none; b=LwkBmK+gd7ZIG3IZAbuU2YXKqHi5MS8xop8YOn3qWBMeEgr2XOamtbpuYbvmb5r2vWFM0Ra4LfJB/f2dcSFcNq5zCW1/1B7wj01G8y6mWBcZS0D9WgzxmElEkNuR2eQJIpfUmDf7A8iCf9OIqe/hatIYT1NO7DSfyfF264bi6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061143; c=relaxed/simple;
	bh=pqpBHK/bjWJR3T0pSQY4RenePWXuIhUfG8j+5OsuUAM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVQyC0lvXG0eqn92WlkY2n9BQ+96Tl4UoVF56YPeKsmpNYTinGaIT181AemW/JTSqZtgJWBdtdbmz2FxGan000TQyIZ2gtfomkUXBbg4lo8HU2cV7S4+e2LyIUSs4H2QeWOmnTVsOFV6FxVhVoDBbChQooGJ7KF/XD0wlfLqWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhWs4Mzpz6K5pk;
	Wed, 25 Dec 2024 01:21:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DCD2140AE5;
	Wed, 25 Dec 2024 01:25:39 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:25:38 +0100
Date: Tue, 24 Dec 2024 17:25:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 08/27] cxl: add functions for resource
 request/release by a driver
Message-ID: <20241224172535.000019e4@huawei.com>
In-Reply-To: <20241216161042.42108-9-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-9-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:23 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and releasing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
Hi Alejandro,

Minor comment inline. Either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c | 45 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 99f533caae1e..c414b0fbbead 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,51 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for ram with size 0\n");
> +			return -EINVAL;
> +		}
> +
> +		return request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +	case CXL_RES_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for pmem with size 0\n");
> +			return -EINVAL;
> +		}
> +		return request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +	default:
> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, "CXL");
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
		return release_resource() unless a later
patch add something that happens after this...

> +		break;
> +	case CXL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
same

> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
With above, this isn't needed.
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 18fb01adcf19..44664c9928a4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif


