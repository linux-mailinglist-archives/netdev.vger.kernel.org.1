Return-Path: <netdev+bounces-241746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF81C87E87
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70BDC353C99
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3030C347;
	Wed, 26 Nov 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pjy23bop"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6C3C1F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126641; cv=none; b=rlMYWPp3jAby+4anpB7ajSCEr2g549ncb4upAXp3//zokL7B/vKPHYtV8de0a8LydC+g3kxz1Rtw6kt8FQDXuVUTFpUMqNgHDcy4+Ht/k2aug8FA7/o+Zb6B3mZnyZGk/M6gpFxmkC2De0Rddnv386rXd6E1YZs3xV96UN1fiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126641; c=relaxed/simple;
	bh=3KQSOm3PsKH+7E60hD2sqZCD7X8/SSsI5BLubHVvXQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph+m0Ptjevt0XxfanxJTbBil6bwtymeGGl5+wQgdSWRtJIz2zWUqnyppMpOisNRNvuY6gzgEp5APIQUyIAG1mQPvtAq68IeSagTpwojoA9nSDEPKNzFLR7tOuFX+B9nIyvdDJErsISfUKWybBne0unirUxk9QibuqGGxLTk4AwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pjy23bop; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6603d8fa-fd29-4f6c-8150-36fd02e78d22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764126637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPxYchtA3LlQBIyM4sbAoBBeiS3Y+iz/9LUrcGhYuDA=;
	b=Pjy23bopm6HONRhf4vHK6jq4+LVYe/jlld/GHSNvnzUWTW/HIjYX3j9rEOEeNUHkRJlhKw
	1l7y266fyUbpC+HasHDLdAC8YYo1UROqEJEg5dCqykQ7CH537B2POdYZOcThP6pD/AUgEe
	gvEKwazQoHUIuX0Zpir28ipM4RA1Wvk=
Date: Wed, 26 Nov 2025 11:10:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
To: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Philipp Stanner <phasta@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20251124160417.51514-1-ziyao@disroot.org>
 <20251124160417.51514-2-ziyao@disroot.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20251124160417.51514-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/25 00:04, Yao Zi 写道:
> Most glue driver for PCI-based DWMAC controllers utilize similar
> platform suspend/resume routines. Add a generic implementation to reduce
> duplicated code.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Yanteng Si<siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng

> ---
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  5 ++
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
>   .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
>   .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
>   4 files changed, 66 insertions(+)
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 87c5bea6c2a2..15ed5c1d071a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -349,6 +349,11 @@ config DWMAC_VISCONTI
>   
>   endif
>   
> +config STMMAC_LIBPCI
> +	tristate
> +	help
> +	  This option enables the PCI bus helpers for the stmmac driver.
> +
>   config DWMAC_INTEL
>   	tristate "Intel GMAC support"
>   	default X86
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 1681a8a28313..7bf528731034 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_DWMAC_VISCONTI)	+= dwmac-visconti.o
>   stmmac-platform-objs:= stmmac_platform.o
>   dwmac-altr-socfpga-objs := dwmac-socfpga.o
>   
> +obj-$(CONFIG_STMMAC_LIBPCI)	+= stmmac_libpci.o
>   obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>   obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>   obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
> new file mode 100644
> index 000000000000..5c5dd502f79a
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCI bus helpers for STMMAC driver
> + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +
> +#include "stmmac_libpci.h"
> +
> +int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	ret = pci_save_state(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_disable_device(pdev);
> +	pci_wake_from_d3(pdev, true);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stmmac_pci_plat_suspend);
> +
> +int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	pci_restore_state(pdev);
> +	pci_set_power_state(pdev, PCI_D0);
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stmmac_pci_plat_resume);
> +
> +MODULE_DESCRIPTION("STMMAC PCI helper library");
> +MODULE_AUTHOR("Yao Zi <ziyao@disroot.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
> new file mode 100644
> index 000000000000..71553184f982
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> + */
> +
> +#ifndef __STMMAC_LIBPCI_H__
> +#define __STMMAC_LIBPCI_H__
> +
> +int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv);
> +int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv);
> +
> +#endif /* __STMMAC_LIBPCI_H__ */

