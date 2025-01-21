Return-Path: <netdev+bounces-160102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50051A182A6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BF3A1DF3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854316F851;
	Tue, 21 Jan 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4w3ffF/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F95028C
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479723; cv=none; b=T2JE4c37ZgoDgqTY+DCvm0nI6JQW/v/idnIdq2wqW+vnvlrouKXa8Sj0KD186eDOJz/Hk85CLN6g+msVWzBbOZt/rrH25P3XJJXsGuze0yHXnFyfktOoNUodZ1WxfDPaAHtVS3hRCs+XGi4EMVErxHy+1xtGpnNNnJlIKaNV10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479723; c=relaxed/simple;
	bh=CJIPSkNSikN2lAYs0JfROfc96U7D5shWXZWULnE67LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdBC1V+U4vHJOGX47/xJgg2KtdE3OoncW7Fc2rcgLZAGdG5g3e/FNmOF5PmJf/zAOJT+a+kW9PWOJWL9c7aprb5dz1zL0pXrnC5NLHvwT3dMgyPbIMxH0uvG0DICQrmiuqmFD+QUiNQRZz4/DFSvpGLLwyqdwRLArSF4Hfj2/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4w3ffF/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737479718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXMjBKWbVLp7SlD/7tWrcHQG3OmUUoryMMrbzMjyeUQ=;
	b=w4w3ffF/lMpaxYHjRekgzrjKU6SZ77OpizO03U9SmJKJmy7IpJDGw1cP8JwPRCOyPZUTSu
	wEkK2Au4Xc/VrS5EBOrzxFn0EH8NirULvAJOW+KG5hk8NlGLr7DYYVmaFQ5gFEodkcRdBL
	ZaudTxCY8FYZL6DK0w2ugwIXcSMQMLc=
Date: Wed, 22 Jan 2025 01:14:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/3] net: stmmac: Limit FIFO size by hardware
 capability
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Vince Bridgers <vbridger@opensource.altera.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <20250121044138.2883912-3-hayashi.kunihiko@socionext.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250121044138.2883912-3-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 1/21/25 12:41, Kunihiko Hayashi 写道:
> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> stmmac_platform layer.
> 
> However, these values are constrained by upper limits determined by the
> capabilities of each hardware feature. There is a risk that the upper
> bits will be truncated due to the calculation, so it's appropriate to
> limit them to the upper limit values and display a warning message.
> 
> Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from the devicetree")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 251a8c15637f..da3316e3e93b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7245,6 +7245,19 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>   		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
>   	}
>   

> +	if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {

> +		dev_warn(priv->device,
> +			 "Rx FIFO size exceeds dma capability (%d)\n",
> +			 priv->plat->rx_fifo_size);
> +		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
I executed grep and found that only dwmac4 and dwxgmac2 have initialized 
dma_cap.rx_fifo_size. Can this code still work properly on hardware 
other than these two?


Thanks,
Yanteng

