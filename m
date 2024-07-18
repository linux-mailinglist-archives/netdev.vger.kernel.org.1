Return-Path: <netdev+bounces-112135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE7937106
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 01:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA26F1C21734
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3971146598;
	Thu, 18 Jul 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icQuaz3/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D04145A1C;
	Thu, 18 Jul 2024 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344352; cv=none; b=a/30WU9BfE8kIXxQk6V2kB5fL/UqpSC368p7g4Lv8NY8R+NIVgUE1o0oT5lhPxzHkeggN0i8pe7r/AvxCwtKm6h15MwJzPeHV546UPq6GoepENSP3WaM8RgnbZ2q9fOgBWnPqSj/0xmiCcW26SR+yoDX/pHjgGnYla4PduVuxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344352; c=relaxed/simple;
	bh=vW1p0Rkqd6tUlF+S/3y/oWhnFBHM8+eaOf6HiZXXmCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFzhbend6GKgp/wnvjOU8bKAQU/FJMVpt7OjYWzZTKLGy9CbKtpgqzsK7DtEI+JTksK18YqIBb+ayJFMBe9KerB2+4aDOQx3VAQcicHNU/iW33lIKG55NDdfJ0/3mYC0yWc2O6AaDNlxD8C0hHVyCuXmxo5cNUP6oUXS5d3BKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icQuaz3/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721344350; x=1752880350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vW1p0Rkqd6tUlF+S/3y/oWhnFBHM8+eaOf6HiZXXmCE=;
  b=icQuaz3/zC5Z3dDNu6AYeWpXcc+Z2derkplPm5QfrK1eKK/5qW/6eDSf
   KOnm9zqwBc/ASbmYS8KdL6M9WIUgI9SzpPVPFjhOxom+IFVH9AWhP02K/
   ULbbnGZjDIofkYo3IiTjpjmI0U7sXc8ox9wAYbeNXc/W5rvZlSVBCb+xA
   h4hcmvl6X92tKGHqDDfCRzwn/msR2mPxa1kPydkiLQk5gc74p/CffICVH
   b2Vj3q2OUgEzUa5cwO28J/0MXmdmwgULMoFrQVDTPPs29RaUtYaWH6jxv
   Efzyv6hyukT7FYlknmpufT1BqyeOpxJ2mG3AzdlIG9UYYzQpzhVprl8Vu
   Q==;
X-CSE-ConnectionGUID: oL7+gE76SceOHKZPyfhR/Q==
X-CSE-MsgGUID: fK4p23+YSQK6lHmlziV7Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="41467618"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="41467618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:12:30 -0700
X-CSE-ConnectionGUID: zPFmW2snSpyKYG2kXfhp9g==
X-CSE-MsgGUID: qKjTw1cJSlaJX5vLN9WzuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="81557677"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.184]) ([10.125.108.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:12:29 -0700
Message-ID: <936eecad-2e98-4336-b775-d28fa1d87d76@intel.com>
Date: Thu, 18 Jul 2024 16:12:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create opaque struct to be used by accelerators relying on new access
> functions in following patches.
> 
> Add SFC ethernet network driver as the client.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        |  4 ++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  4 ++
>  include/linux/cxl_accel_mem.h         | 22 +++++++++++
>  include/linux/cxl_accel_pci.h         | 23 ++++++++++++

Maybe create an include/linux/cxl and then we can put headers in there.

>  8 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/linux/cxl_accel_mem.h
>  create mode 100644 include/linux/cxl_accel_pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..61b5d35b49e7 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -8,6 +8,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include <linux/cxl_accel_mem.h>
>  #include "trace.h"
>  #include "core.h"
>  
> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);

Naked cxlds. Do you think you'll need an accel_dev_state to wrap around cxl_dev_state similar to cxl_memdev_state in order to store accel related information? I also wonder if 'struct cxl_dev_state' should be a public definition. Need to look at the rest of the patchset to circle back. 

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

I do wonder if we should have a common device state init helper function to init all the common bits:
int cxlds_init(struct *dev, enum cxl_devtype devtype)


> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +
> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
> +
> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial= serial;

Missing space before '='
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
> +
> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +			    enum accel_resource type)
> +{
> +	switch (type) {
> +	case CXL_ACCEL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return;
> +	case CXL_ACCEL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return;
> +	case CXL_ACCEL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return;
> +	default:
> +		dev_err(cxlds->dev, "unkown resource type (%u)\n", type);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..e80c713c3b0c 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
>  			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>  			   ef100.o ef100_nic.o ef100_netdev.o \
>  			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
> -			   efx_devlink.o
> +			   efx_devlink.o efx_cxl.o
>  sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>  sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index e9d9de8e648a..cb3f74d30852 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,7 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#include "efx_cxl.h"
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -899,6 +900,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +

stray blank line

>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	efx_cxl_init(efx);

No error checks? Does the device expect to work whether CXL is setup or not?

> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..4554dd7cca76
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +
> +#include <linux/pci.h>
> +#include <linux/cxl_accel_mem.h>
> +#include <linux/cxl_accel_pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
> +
> +void efx_cxl_init(struct efx_nic *efx)
> +{
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl = efx->cxl;
> +	struct resource res;
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec)
> +		return;
> +
> +	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");

Seem like unnecessary kern log emission

> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_info(pci_dev, "CXL accel device state failed");

pci_err()? or maybe pci_warn() given it's ignoring error returns. 
> +		return;
> +	}
> +
> +	cxl_accel_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> +}
> +
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..76c6794c20d8
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +#define EFX_CLX_H
> +
> +#include <linux/cxl_accel_mem.h>
> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	cxl_accel_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +void efx_cxl_init(struct efx_nic *efx);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index f2dd7feb0e0c..58b7517afea4 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -814,6 +814,8 @@ enum efx_xdp_tx_queues_mode {
>  
>  struct efx_mae;
>  
> +struct efx_cxl;
> +
>  /**
>   * struct efx_nic - an Efx NIC
>   * @name: Device name (net device name or bus id before net device registered)
> @@ -962,6 +964,7 @@ struct efx_mae;
>   * @tc: state for TC offload (EF100).
>   * @devlink: reference to devlink structure owned by this device
>   * @dl_port: devlink port associated with the PF
> + * @cxl: details of related cxl objects
>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1148,6 +1151,7 @@ struct efx_nic {
>  
>  	struct devlink *devlink;
>  	struct devlink_port *dl_port;
> +	struct efx_cxl *cxl;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> new file mode 100644
> index 000000000000..daf46d41f59c
> --- /dev/null
> +++ b/include/linux/cxl_accel_mem.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#include <linux/cdev.h>

Don't think this header is needed?

> +
> +#ifndef __CXL_ACCEL_MEM_H
> +#define __CXL_ACCEL_MEM_H
> +
> +enum accel_resource{
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};
> +
> +typedef struct cxl_dev_state cxl_accel_state;
Please use 'struct cxl_dev_state' directly. There's no good reason to hide the type.

> +cxl_accel_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
> +void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +			    enum accel_resource);
> +#endif
> diff --git a/include/linux/cxl_accel_pci.h b/include/linux/cxl_accel_pci.h
> new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl_accel_pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
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
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)

This looks like a copy/paste of drivers/cxl/cxlpci.h definition. I suggest create a include/linux/cxl/pci.h and stick it in there and delete the copy in cxlpci.h. Also update the CXL spec version to latest (3.1) if you don't mind if we are going to move it. 
> +
> +#endif

