Return-Path: <netdev+bounces-237785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5DC50344
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72B83A6031
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335E22370D;
	Wed, 12 Nov 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOjNiGhC"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368ED157A5A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910606; cv=none; b=aJN/GzR09AmsnEGpEy1mhCVVSiFJpSS0JMRefnZNQy4DJQFeBYbZPDNf6emNeok0SMuMRG2Rz9BLMcS3bOT0j7EBmj8++swJgTfr5DXaAfRD79fmcHTn7z9Jj3QyESLzfgxBldd9kP0DbF+/MU+ILiw0f7BdryfBs886uuO2Tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910606; c=relaxed/simple;
	bh=eb59ZBdzPpkWztnSqNI543MNTQy4aGK0FmzrifKY6vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXj8+XeTEL9i89PKslfsvckvX87XfQnRYyK2R5x9h/JQ8qKh0gDlphrKvx3GGNJzuMPYLDOsonN+SQqm0NJxvkCQlXzjYdU+cctM0964wCjAnoSgiPBmGO/h6zmlIIWbDUEPbneLxSQIrcwNb9MKxhemlFrZlYOtyVCM/QCqP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOjNiGhC; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <583585ca-8e89-4a61-93dc-6c47a0362830@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762910602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPzCxjxe5J1GDeScUD6n8MBfZxRthziBKpPa2z7X1A8=;
	b=ZOjNiGhCSfvxPt+yQNNqK/k3HhKqt+oiylSncEM2UaOJDcRebArFle09KwDyDMaP39lRTw
	HYdVQ/h/bzAejYvUtbe9/UyPCBaJSjX8tPLf38iEzMADZmXZTRv+N3Ncb6ipR4J6lSkpqY
	jT4FZMeKxviGOrpgpNVJ0F9XUP6etFA=
Date: Wed, 12 Nov 2025 09:23:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111100727.15560-4-ziyao@disroot.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20251111100727.15560-4-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/11 18:07, Yao Zi 写道:
> Convert glue driver for Loongson DWMAC controller to use the generic
> platform suspend/resume routines for PCI controllers, instead of
> implementing its own one.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Yanteng Si <siyanteng@cqsoftware.com.cn


Thanks,

Yanteng
> ---
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 +++-
>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
>   2 files changed, 8 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 1350f16f7138..d2bff28fe409 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -367,15 +367,19 @@ config DWMAC_INTEL
>   	  This selects the Intel platform specific bus support for the
>   	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
>   
> +if STMMAC_LIBPCI
> +
>   config DWMAC_LOONGSON
>   	tristate "Loongson PCI DWMAC support"
>   	default MACH_LOONGSON64
> -	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> +	depends on MACH_LOONGSON64 || COMPILE_TEST
>   	depends on COMMON_CLK
>   	help
>   	  This selects the LOONGSON PCI bus support for the stmmac driver,
>   	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
>   
> +endif
> +
>   config STMMAC_PCI
>   	tristate "STMMAC PCI bus support"
>   	depends on STMMAC_ETH && PCI
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 2a3ac0136cdb..584dc4ff8320 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -8,6 +8,7 @@
>   #include <linux/device.h>
>   #include <linux/of_irq.h>
>   #include "stmmac.h"
> +#include "stmmac_libpci.h"
>   #include "dwmac_dma.h"
>   #include "dwmac1000.h"
>   
> @@ -525,37 +526,6 @@ static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioad
>   				  10000, 2000000);
>   }
>   
> -static int loongson_dwmac_suspend(struct device *dev, void *bsp_priv)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -
> -	ret = pci_save_state(pdev);
> -	if (ret)
> -		return ret;
> -
> -	pci_disable_device(pdev);
> -	pci_wake_from_d3(pdev, true);
> -	return 0;
> -}
> -
> -static int loongson_dwmac_resume(struct device *dev, void *bsp_priv)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -
> -	pci_restore_state(pdev);
> -	pci_set_power_state(pdev, PCI_D0);
> -
> -	ret = pci_enable_device(pdev);
> -	if (ret)
> -		return ret;
> -
> -	pci_set_master(pdev);
> -
> -	return 0;
> -}
> -
>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct plat_stmmacenet_data *plat;
> @@ -600,8 +570,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>   	plat->bsp_priv = ld;
>   	plat->setup = loongson_dwmac_setup;
>   	plat->fix_soc_reset = loongson_dwmac_fix_reset;
> -	plat->suspend = loongson_dwmac_suspend;
> -	plat->resume = loongson_dwmac_resume;
> +	plat->suspend = stmmac_pci_plat_suspend;
> +	plat->resume = stmmac_pci_plat_resume;
>   	ld->dev = &pdev->dev;
>   	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>   

