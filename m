Return-Path: <netdev+bounces-184313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC05A94A20
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC8C3AF0F1
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D82A8D0;
	Mon, 21 Apr 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3CB4m9P"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D006179BD
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745198539; cv=none; b=Fy6vYav3Q9SSKbOLMtTmGVvdXaVDCgt604Yu2mNdBUsvNvwv+LUO1OjKmf/usG/2TxHzJpbPke5xOw3wfwaH7/U87VJ0kwHalbALOZ9kMeEaFSMmLyU5KcdGq6KLoynwRZwLO0S4TDXOeQQtPNCXdICRZqnJvXULRbLm55WJkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745198539; c=relaxed/simple;
	bh=SFE0MJRfjYH4OGtYcClVp9vSMnQJgeOEqGG4xlve4Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqYfhc7quQRXPtVlMfu5hwiBtCsyr0jpYsbs7yoqUZNaUBpgC1yggfO3BWYMdrgcrp9r2v7WcFV7An4sW6T5jzaMXLfTXZe+fzZ8D88VUj2y1QvGnLIaXNnU5w0oruN3F/IkVLnfD6Ryeli94nsuSk3W4t/44RYfxQm4AUcfZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3CB4m9P; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <329a7e1e-d3dc-4dcc-9599-828b6ff1a0f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745198525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56eepAxGX2u61o56/SlW6FxmYQZ28USspOPPNVGSEvY=;
	b=D3CB4m9PWee+iZiVHLBxgU7qhe0ehupvlmj0ZU3ayFyo6x2E+QpcZ9lkCHu9OfELc4+3ap
	2tHCRLBdLArKgAINFexKPVKcbaml/JEyxzp6JNmXX3bVlIoKzQbKCwk14IgWKwOVL7em/T
	RDCVoew9eE6PTnGIZaNDVVYLnNjFn/I=
Date: Mon, 21 Apr 2025 09:21:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V2 1/3] net: stmmac: dwmac-loongson: Move queue
 number init to common function
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Chen <chenx97@aosc.io>, Biao Dong <dongbiao@loongson.cn>,
 Baoqi Zhang <zhangbaoqi@loongson.cn>
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-2-chenhuacai@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250416144132.3857990-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 4/16/25 10:41 PM, Huacai Chen 写道:
> Currently, the tx and rx queue number initialization is duplicated in
> loongson_gmac_data() and loongson_gnet_data(), so move it to the common
> function loongson_default_data().
>
> This is a preparation for later patches.
>
> Tested-by: Henry Chen <chenx97@aosc.io>
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 54 ++++++-------------
>   1 file changed, 16 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 1a93787056a7..2fb7a137b312 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -83,6 +83,8 @@ struct stmmac_pci_info {
>   static void loongson_default_data(struct pci_dev *pdev,
>   				  struct plat_stmmacenet_data *plat)
>   {
> +	struct loongson_data *ld = plat->bsp_priv;
> +
>   	/* Get bus_id, this can be overwritten later */
>   	plat->bus_id = pci_dev_id(pdev);
>   
> @@ -116,32 +118,27 @@ static void loongson_default_data(struct pci_dev *pdev,
>   
>   	plat->dma_cfg->pbl = 32;
>   	plat->dma_cfg->pblx8 = true;
> +
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> +		plat->rx_queues_to_use = CHANNEL_NUM;
> +		plat->tx_queues_to_use = CHANNEL_NUM;
> +
> +		/* Only channel 0 supports checksum,
> +		 * so turn off checksum to enable multiple channels.
> +		 */
> +		for (int i = 1; i < CHANNEL_NUM; i++)
> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
> +	} else {
> +		plat->tx_queues_to_use = 1;
> +		plat->rx_queues_to_use = 1;
> +	}
>   }
>   
>   static int loongson_gmac_data(struct pci_dev *pdev,
>   			      struct plat_stmmacenet_data *plat)
>   {
> -	struct loongson_data *ld;
> -	int i;
> -
> -	ld = plat->bsp_priv;
> -
>   	loongson_default_data(pdev, plat);
>   
> -	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> -		plat->rx_queues_to_use = CHANNEL_NUM;
> -		plat->tx_queues_to_use = CHANNEL_NUM;
> -
> -		/* Only channel 0 supports checksum,
> -		 * so turn off checksum to enable multiple channels.
> -		 */
> -		for (i = 1; i < CHANNEL_NUM; i++)
> -			plat->tx_queues_cfg[i].coe_unsupported = 1;
> -	} else {
> -		plat->tx_queues_to_use = 1;
> -		plat->rx_queues_to_use = 1;
> -	}
> -
>   	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>   
>   	return 0;
> @@ -172,27 +169,8 @@ static void loongson_gnet_fix_speed(void *priv, int speed, unsigned int mode)
>   static int loongson_gnet_data(struct pci_dev *pdev,
>   			      struct plat_stmmacenet_data *plat)
>   {
> -	struct loongson_data *ld;
> -	int i;
> -
> -	ld = plat->bsp_priv;
> -
>   	loongson_default_data(pdev, plat);
>   
> -	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> -		plat->rx_queues_to_use = CHANNEL_NUM;
> -		plat->tx_queues_to_use = CHANNEL_NUM;
> -
> -		/* Only channel 0 supports checksum,
> -		 * so turn off checksum to enable multiple channels.
> -		 */
> -		for (i = 1; i < CHANNEL_NUM; i++)
> -			plat->tx_queues_cfg[i].coe_unsupported = 1;
> -	} else {
> -		plat->tx_queues_to_use = 1;
> -		plat->rx_queues_to_use = 1;
> -	}
> -
>   	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
>   	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
>   	plat->fix_mac_speed = loongson_gnet_fix_speed;

