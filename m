Return-Path: <netdev+bounces-154198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC99FC0E2
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A07A188172A
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF5F1D6DA3;
	Tue, 24 Dec 2024 17:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6426ACB;
	Tue, 24 Dec 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060542; cv=none; b=lNGuV/RM//uuc5pL4nGAG8JVlHvz7s/O2WrQeoN3RpDFBPKEPk8kB6LwjT+RLYzECU4N4KTJaOqFT2e+FTsp5hJb9jHj97beItzuW3hDQxKwX+RRgcECcdyQD2WmDVYcMduhOMRdO1bYHymUlkXUfuWrkfo240bqCiSgaD8LdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060542; c=relaxed/simple;
	bh=ZG1TnXnSOkVKkqJsLGveGBj2vPsPZ2PThv37saGzdxY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dza+yVrd5PhGNEJ2eeJFryTA/2Ha742i5kKViDqDZY9Lz+0LBlirotS08UsmeoTfYQ4WLmaLVk1aV0b60qwkGulsArGKMTrhZWjBkCykAZD819LnaigGwfEa0IfAXYVoA2B+qYGGYt0E231PD4cfx/iRHX+y2lFKgF6rPfpjAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhJJ1Rdrz6K5rR;
	Wed, 25 Dec 2024 01:11:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B702140391;
	Wed, 25 Dec 2024 01:15:37 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:15:36 +0100
Date: Tue, 24 Dec 2024 17:15:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 04/27] cxl/pci: add check for validating capabilities
Message-ID: <20241224171533.000055b4@huawei.com>
In-Reply-To: <20241216161042.42108-5-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-5-alejandro.lucero-palau@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:19 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>

Some follow on comments in how to handle bitmaps.

Jonathan


> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dbc1cd9bec09..1fcc53df1217 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);

set_bit()  - see comments in bitmap.h, these are fine applied to bitmaps
and make more sense for setting a single bit.


> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MEMDEV, 1);
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
> +			*expected, *found);
There are printk formats for bitmaps that should be used here. %*pb



> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f656fcd4945f..05f06bfd2c29 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps);
>  #endif


