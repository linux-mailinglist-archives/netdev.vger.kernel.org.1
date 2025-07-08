Return-Path: <netdev+bounces-204945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD67AFCA22
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B331704E9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4C2D373A;
	Tue,  8 Jul 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xMNeP4Pb"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C61A23AC
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976871; cv=none; b=ZiSFwKbY2kM5H4X4cRhagNcQbz9U1Ui/8p1ZAzBgXSfMB457MzYQ8/W0hPKrBb/qZC1vL+GHwej+2+jvdI7zIyZ0SYisOiKwwDv/BbVf9UuVTiTEGaWRzUTMFzZwLL2Nn3ap8E4gwfbzyJBK7x7KoZOvKhkGT/YsTg+2mtHxwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976871; c=relaxed/simple;
	bh=vW5wPnVcXHXN6WXW0FYslYnJUIPrI2rdMrBvlyZoq4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpmcfcEvxk9s8QHRWsznPnGAa0ayUjPyDARS52vWOEmeJTUDO4CFOPmNLAz6OsfSfgs5Jvraft7KvyCaRMaXyX0AGT58MXrvU8bwQj22S33k1Tdf02NnX153zyPCvpOEae9WprOqnBRrnlBMigDv+4VY4gJUnLaGs+492zSahaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMNeP4Pb; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e8d7862-3f77-4716-a655-b4dea11492b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751976865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcJCQul1ZSmG75NEMbOAmoAtWpJB0FxmoOIZKYFCPko=;
	b=xMNeP4Pbr4YJnLJWYjPuhlZ6SGXbwMb1v4zHhs4bgzXGH2abNjYbcrdsQqZfdQ5ZKguGpr
	3mmSHKPAzeyIXpWmcEddoC5KRrcjkKlDXc7GBdb7OhpIju12jjTEz2jkbPyD8A07Sr04Yt
	M8Hjr3JJCa2g1rrBQMrNn1mGjEad0Bs=
Date: Tue, 8 Jul 2025 13:14:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v12 01/14] xsc: Add xsc driver basic framework
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
 weihg@yunsilicon.com, wanry@yunsilicon.com, jacky@yunsilicon.com,
 horms@kernel.org, parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
 geert@linux-m68k.org
References: <20250703075341.3488773-1-tianx@yunsilicon.com>
 <20250703075341.3488773-2-tianx@yunsilicon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250703075341.3488773-2-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/07/2025 08:53, Xin Tian wrote:
> 1. Add yunsilicon xsc driver basic compile framework, including
> xsc_pci driver and xsc_eth driver
> 2. Implemented PCI device initialization.
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>   MAINTAINERS                                   |   7 +
>   drivers/net/ethernet/Kconfig                  |   1 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/yunsilicon/Kconfig       |  26 +++
>   drivers/net/ethernet/yunsilicon/Makefile      |   7 +
>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  43 ++++
>   .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  17 ++
>   .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  14 ++
>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/main.c    | 214 ++++++++++++++++++
>   11 files changed, 348 insertions(+)
>   create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b827049..19664829b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26630,6 +26630,13 @@ S:	Maintained
>   F:	Documentation/input/devices/yealink.rst
>   F:	drivers/input/misc/yealink.*
>   
> +YUNSILICON XSC DRIVERS
> +M:	Honggang Wei <weihg@yunsilicon.com>
> +M:	Xin Tian <tianx@yunsilicon.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/yunsilicon/xsc
> +
>   Z8530 DRIVER FOR AX.25
>   M:	Joerg Reuter <jreuter@yaina.de>
>   L:	linux-hams@vger.kernel.org
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 0baac25db..aa6016597 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>   source "drivers/net/ethernet/ibm/Kconfig"
>   source "drivers/net/ethernet/intel/Kconfig"
>   source "drivers/net/ethernet/xscale/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>   
>   config JME
>   	tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index c03203439..c16c34d4b 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
>   obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
>   obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
>   obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) += yunsilicon/
>   obj-$(CONFIG_JME) += jme.o
>   obj-$(CONFIG_KORINA) += korina.o
>   obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethernet/yunsilicon/Kconfig
> new file mode 100644
> index 000000000..e66ab4376
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config NET_VENDOR_YUNSILICON
> +	bool "Yunsilicon devices"
> +	default y
> +	depends on PCI
> +	depends on 64BIT || COMPILE_TEST
> +	help
> +	  If you have a network (Ethernet) device belonging to this class,
> +	  say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Yunsilicon cards. If you say Y, you will be asked
> +	  for your specific card in the following questions.
> +
> +if NET_VENDOR_YUNSILICON
> +
> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
> +
> +endif # NET_VENDOR_YUNSILICON
> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
> new file mode 100644
> index 000000000..05aa35c3c
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Makefile for the Yunsilicon device drivers.
> +#
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> new file mode 100644
> index 000000000..0673e34fe
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef __XSC_CORE_H
> +#define __XSC_CORE_H
> +
> +#include <linux/pci.h>
> +
> +#define XSC_PCI_VENDOR_ID		0x1f67
> +
> +#define XSC_MC_PF_DEV_ID		0x1011
> +#define XSC_MC_VF_DEV_ID		0x1012
> +#define XSC_MC_PF_DEV_ID_DIAMOND	0x1021
> +
> +#define XSC_MF_HOST_PF_DEV_ID		0x1051
> +#define XSC_MF_HOST_VF_DEV_ID		0x1052
> +#define XSC_MF_SOC_PF_DEV_ID		0x1053
> +
> +#define XSC_MS_PF_DEV_ID		0x1111
> +#define XSC_MS_VF_DEV_ID		0x1112
> +
> +#define XSC_MV_HOST_PF_DEV_ID		0x1151
> +#define XSC_MV_HOST_VF_DEV_ID		0x1152
> +#define XSC_MV_SOC_PF_DEV_ID		0x1153
> +
> +struct xsc_dev_resource {
> +	/* protect buffer allocation according to numa node */
> +	struct mutex		alloc_mutex;
> +};
> +
> +struct xsc_core_device {
> +	struct pci_dev		*pdev;
> +	struct device		*device;
> +	struct xsc_dev_resource	*dev_res;
> +	int			numa_node;
> +
> +	void __iomem		*bar;
> +	int			bar_num;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> new file mode 100644
> index 000000000..b2f95370f
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config YUNSILICON_XSC_ETH
> +	tristate "Yunsilicon XSC ethernet driver"
> +	depends on YUNSILICON_XSC_PCI
> +	depends on NET
> +	select PAGE_POOL
> +	help
> +	  This driver provides ethernet support for
> +	  Yunsilicon XSC devices.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_eth.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> new file mode 100644
> index 000000000..53300be3c
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
> +
> +xsc_eth-y := main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> new file mode 100644
> index 000000000..b707da28b
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon PCI configuration
> +#
> +
> +config YUNSILICON_XSC_PCI
> +	tristate "Yunsilicon XSC PCI driver"
> +	help
> +	  This driver is common for Yunsilicon XSC
> +	  ethernet and RDMA drivers.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_pci.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> new file mode 100644
> index 000000000..709270df8
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
> +
> +xsc_pci-y := main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..b8fc25679
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include "common/xsc_core.h"
> +
> +static const struct pci_device_id xsc_pci_id_table[] = {
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
> +	{ 0 }
> +};
> +
> +static int xsc_set_dma_caps(struct pci_dev *pdev)
> +{
> +	int err;
> +
> +	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (!err)
> +		dma_set_max_seg_size(&pdev->dev, SZ_2G);
> +
> +	return err;
> +}
> +
> +static int xsc_pci_init(struct xsc_core_device *xdev,
> +			const struct pci_device_id *id)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +	void __iomem *bar_base;
> +	int bar_num = 0;
> +	int err;
> +
> +	xdev->numa_node = dev_to_node(&pdev->dev);
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		pci_err(pdev, "failed to enable PCI device: err=%d\n", err);
> +		goto err_out;
> +	}
> +
> +	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
> +	if (err) {
> +		pci_err(pdev, "failed to request %s pci_region=%d: err=%d\n",
> +			KBUILD_MODNAME, bar_num, err);
> +		goto err_disable;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = xsc_set_dma_caps(pdev);
> +	if (err) {
> +		pci_err(pdev, "failed to set DMA capabilities mask: err=%d\n",
> +			err);
> +		goto err_clr_master;
> +	}
> +
> +	bar_base = pci_ioremap_bar(pdev, bar_num);
> +	if (!bar_base) {
> +		pci_err(pdev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME,
> +			bar_num);
> +		err = -ENOMEM;
> +		goto err_clr_master;
> +	}
> +
> +	err = pci_save_state(pdev);
> +	if (err) {
> +		pci_err(pdev, "pci_save_state failed: err=%d\n", err);
> +		goto err_io_unmap;
> +	}
> +
> +	xdev->bar_num = bar_num;
> +	xdev->bar = bar_base;
> +
> +	return 0;
> +
> +err_io_unmap:
> +	pci_iounmap(pdev, bar_base);
> +err_clr_master:
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, bar_num);
> +err_disable:
> +	pci_disable_device(pdev);
> +err_out:
> +	return err;
> +}
> +
> +static void xsc_pci_fini(struct xsc_core_device *xdev)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +
> +	pci_iounmap(pdev, xdev->bar);
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, xdev->bar_num);
> +	pci_disable_device(pdev);
> +}
> +
> +static int xsc_dev_res_init(struct xsc_core_device *xdev)
> +{
> +	struct xsc_dev_resource *dev_res;
> +
> +	dev_res = kvzalloc(sizeof(*dev_res), GFP_KERNEL);
> +	if (!dev_res)
> +		return -ENOMEM;
> +
> +	xdev->dev_res = dev_res;
> +	mutex_init(&dev_res->alloc_mutex);
> +
> +	return 0;
> +}
> +
> +static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
> +{
> +	kfree(xdev->dev_res);

dev_res is allocated with kvzalloc(), you must not use kfree() in
this case. kvfree() is appropriate here

> +}
> +
> +static int xsc_core_dev_init(struct xsc_core_device *xdev)
> +{
> +	int err;
> +
> +	err = xsc_dev_res_init(xdev);
> +	if (err) {
> +		pci_err(xdev->pdev, "xsc dev res init failed %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
> +{
> +	xsc_dev_res_cleanup(xdev);
> +}
> +
> +static int xsc_pci_probe(struct pci_dev *pci_dev,
> +			 const struct pci_device_id *id)
> +{
> +	struct xsc_core_device *xdev;
> +	int err;
> +
> +	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xdev->pdev = pci_dev;
> +	xdev->device = &pci_dev->dev;
> +
> +	pci_set_drvdata(pci_dev, xdev);
> +	err = xsc_pci_init(xdev, id);
> +	if (err) {
> +		pci_err(pci_dev, "xsc_pci_init failed %d\n", err);
> +		goto err_unset_pci_drvdata;
> +	}
> +
> +	err = xsc_core_dev_init(xdev);
> +	if (err) {
> +		pci_err(pci_dev, "xsc_core_dev_init failed %d\n", err);
> +		goto err_pci_fini;
> +	}
> +
> +	return 0;
> +err_pci_fini:
> +	xsc_pci_fini(xdev);
> +err_unset_pci_drvdata:
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +
> +	return err;
> +}
> +
> +static void xsc_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
> +
> +	xsc_core_dev_cleanup(xdev);
> +	xsc_pci_fini(xdev);
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +}
> +
> +static struct pci_driver xsc_pci_driver = {
> +	.name		= "xsc-pci",
> +	.id_table	= xsc_pci_id_table,
> +	.probe		= xsc_pci_probe,
> +	.remove		= xsc_pci_remove,
> +};
> +
> +static int __init xsc_init(void)
> +{
> +	int err;
> +
> +	err = pci_register_driver(&xsc_pci_driver);
> +	if (err) {
> +		pr_err("failed to register pci driver\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit xsc_fini(void)
> +{
> +	pci_unregister_driver(&xsc_pci_driver);
> +}
> +
> +module_init(xsc_init);
> +module_exit(xsc_fini);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Yunsilicon XSC PCI driver");


