Return-Path: <netdev+bounces-146556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3D9D444E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 00:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58E91F20F7D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17AB42048;
	Wed, 20 Nov 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffhH8gHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE652F2A;
	Wed, 20 Nov 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144038; cv=none; b=OerGcVR6Equppckv0BcLRH4iuSha3hTmKLVbbJsDXC7M21DCm5Hh+dxz2rhuBXcd9d6l94vQftaZMU1+Mrs7usHLgn0nRnmpWGD97ppuuf2aTBn/F2UO+F1G+i8tloNri3uUp0bsr+PF32T87inDqnxqv3Z5REH5OSZG0o3MeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144038; c=relaxed/simple;
	bh=3R8g4k2kcVOALc89vy4pirvETfHloJhI+qLbVBwsLlk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayt7KSeyylDx6pEBMW3KveLo37HNKhU0Jodr/LiqqMFW4Gkq7oh/B8mwdCq4nBOiCDhSRHG/lJ0GFDAvIZM+r1jglWOya/ycDY7bymXgVRUaUr+BPrr9mylwvmNnGRxL+EhTMR+qR6CT1M4vjzQZRcFGn6OffhGHorweQlsIYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffhH8gHt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so261857b3a.1;
        Wed, 20 Nov 2024 15:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732144036; x=1732748836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQLn4ff1ccC4WGEzLKWembbwGF9SVgUFvpPXGmjZk7s=;
        b=ffhH8gHtCQ5HX0JRraxZxcBoZMcSif+BeIpEGSnGGZL2xoRTyXRJCTTD452jSmWi/D
         CsGscTwYr5QADoRwdAbuYQf60ZTnmVWLi64PY81CnJcLl1i/Jj1pOgfwzMloAV6pEe5L
         HCrlKcX6qlYIp0XzAeVCPt5pZi7N1Nqb/XGKKIY39jP2pReVNGxawoiI6QdL42E+hBFO
         CAJbj2VCwZnwxejNWYp4uoOkM9jpMC1bUHrZulpBhpX0/LjqB3Ek/p3NZbUfHsM2rAOy
         2cDxLAOk38J7L50zN6u8fdonWnB0u0XNDpGozw3ix8ohSji2vWQg9r9kaHJi4LbpvDKa
         gk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144036; x=1732748836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQLn4ff1ccC4WGEzLKWembbwGF9SVgUFvpPXGmjZk7s=;
        b=T7/rqKkiqmESHBnYm4TQXNrdik2wUxZm65L5/Qd4/LOweyFihcyd9eQK5BSBft950k
         hBzLk+/kL3EhnUyV8ihYIXzsqLUF2/DmWNMbalJmBi9pg2zmwtF4Pwcl2ZLg98FIUe35
         oxKfYAz62BSMlTVYngM9/XXoiMluPuOv5nI3dmnZf2DPQ5Bensz59Wrs/Wkl0WyGb5qc
         6JxC0n1rm66gw4bEGYumjOn6hHlfjFLwPSeZGib6ImTie9zUFo+SqSyXTJd+JOQovslr
         9Tde3K+GOJvXGLDNKs2qPD5FAqoLLilF2OHx78vmC+VoWrrtGQ3W4iIKERnD40d7DTXu
         JKgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGpfMq5/hySsbyEpZ4Ws460Fe3JiKHn6HPl46Q1UWYyeI9ZybvrHEQe+CUXNoe6lKutWe6VmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqQRhYzumZOZi8iVoLszo5a5rwkfGYbAFVlxHbypSvm3/H/Hy
	Zdh+LB3fqhwuLvWUOgQo9m9s57S7QUTxyEJ6KzLlJ8P1yGGc/k2M
X-Gm-Gg: ASbGncsR/qJGN0ffurRiqqgmJxKG9jldLRNOJcUXGwPYFDU/VRlQNY79SILqduQO5Bl
	D6L22Ok6wfUOYZz5VgoOzqGyasJIkDQW778N3Vz5vISQJ2NWDhFcqZVx95VnYF80cCSy5pGBRjL
	nQc26eVCJWDTu/EnMUA4AiLTSpxC31ik8xVy8aLScJ8NNliUV1erhWc+z4iTHR04CzjOEuO9Imo
	JXy9kBq66U7Y2wmmAU/3txBXkt6HmJBCQxCYAAlR4ZaNvITB26lQQ==
X-Google-Smtp-Source: AGHT+IEjaDpIp6NUbugGWqApYH6rQvaAlO1tPf6W1mdwjM0dLk22Lvq9F6D09pKLaab15orhmlszZw==
X-Received: by 2002:a05:6a00:1805:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-724bedc646dmr6263320b3a.26.1732144036327;
        Wed, 20 Nov 2024 15:07:16 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8da9asm2251576b3a.128.2024.11.20.15.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 15:07:15 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 20 Nov 2024 23:07:13 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Message-ID: <Zz5roZFnva7_t7A0@smc-140338-bm01>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-2-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:08PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
> 
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/cxlpci.h      | 16 ------------
>  drivers/cxl/pci.c         | 13 +++++++---
>  include/cxl/cxl.h         | 21 ++++++++++++++++
>  include/cxl/pci.h         | 23 ++++++++++++++++++
>  6 files changed, 105 insertions(+), 20 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 84fefb76dafa..d083fd13a6dd 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <cxl/cxl.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> +	if (!cxlds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlds->dev = dev;
> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
> +
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial = serial;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
> +
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 420e4be85a1f..ff266e91ea71 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <cxl/pci.h>
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..eb59019fe5f3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -14,22 +14,6 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> -
>  #define CXL_DVSEC_RANGE_MAX		2
>  
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..0b910ef52db7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
>  #include <linux/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
>  
> +	cxl_set_dvsec(cxlds, dvsec);
> +
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..19e5d883557a
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/ioport.h>
> +
> +enum cxl_resource {
> +	CXL_RES_DPA,
> +	CXL_RES_RAM,
> +	CXL_RES_PMEM,
> +};
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/cxl/pci.h
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
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

