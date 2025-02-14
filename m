Return-Path: <netdev+bounces-166509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB0A363DE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54D73B24CB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A06266EE4;
	Fri, 14 Feb 2025 17:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6098267B0F;
	Fri, 14 Feb 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552551; cv=none; b=XM4Ugj9dAY7tsmjSZBL1PcMrCPJzQQnrObwZW3sERGnEJgjPYAgjXx0gRV04x26J91Yqj1AbbxBNbg8Ks4boK1WtJG65Wz1cfUtO7X3BCIzai313acUm1jNf81KKKvR1GHnL1CU0S3Pea80QT0kSnoKVugAq5CFhdqbrIcPAcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552551; c=relaxed/simple;
	bh=Na8Voha/kXexWg6Tw3ntWSghbGxtOvW6Jvju9RKpfxU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1FX6wRpyvqVRVak0Jn2j0rNFU01al+oIWqISiKxL47iHwcHCV0U+ZOcpcn2lqSCKHoUrbEDO6vWK7VT4AwkX7/D++ipqzDWIqUv5O21MrLEAVuIrZ27fPaUzAx200+PUsFslYMRW8Mp6QhTrCUb5TB4l4CTilvPHeH5qPERysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvdbz5shxz6HJfJ;
	Sat, 15 Feb 2025 01:01:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A39CB140B55;
	Sat, 15 Feb 2025 01:02:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 18:02:25 +0100
Date: Fri, 14 Feb 2025 17:02:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Message-ID: <20250214170223.00003362@huawei.com>
In-Reply-To: <20250205151950.25268-2-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
	<20250205151950.25268-2-alucerop@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Feb 2025 15:19:25 +0000
alucerop@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 support, change memdev creation making
> type based on argument.
> 
> Integrate initialization of dvsec and serial fields in the related
> cxl_dev_state within same function creating the memdev.
> 
> Move the code from mbox file to memdev file.
> 
> Add new header files with type2 required definitions for memdev
> state creation.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
One passing comment.


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 536cbe521d16..62a459078ec3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2c943a4de0a..bd69dc07f387 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -911,6 +911,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -924,19 +925,20 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		dev_warn(&pdev->dev,
> +			 "Device DVSEC not present, skip CXL.mem init\n");
> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec,
> +				      CXL_DEVTYPE_CLASSMEM);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> -		dev_warn(&pdev->dev,
> -			 "Device DVSEC not present, skip CXL.mem init\n");
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)


> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/cxl/pci.h
Clashes with the cxl reset patch (or should anyway as current version
of that just duplicates these defines) That will move
these into uapi/linux/pci_regs.h.

No idea on order things will land, but thought I'd mention it at least
so no one gets a surprise!

> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif


