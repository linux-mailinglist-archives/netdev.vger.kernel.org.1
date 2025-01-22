Return-Path: <netdev+bounces-160328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD0A19460
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B93D168BF9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101B213E9F;
	Wed, 22 Jan 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ej19VAxc"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE51F91C9
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557450; cv=none; b=cRckFYY91UKdCXDqOukMq14d0ZAmk4tOIqp7lCdHT5veMivEwsBj2d/DJRgGYXYtbTqurgk3j2iImhksusslyUpl+C/DH5xKK5Z7teqPHSZodRpWvXbT7ZfyIxzBz4ubCP0vpNyYUr+xWdtDdLj8N2BFBVmvV+roQvLZcduL4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557450; c=relaxed/simple;
	bh=iFdH7dpM1O1CXxbLyuKzYy9dWZAIWs1K+e4HmsNrue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEQlwtebIvCpXFPN9sdNptRqSO2Yh65b7AdXgL8AG34LEhhUdFHyl2rvMX/iIDcBXBv7Ug0+6tMSOybvnre1B4JIi6LFOVIAVQbY9gV0aAUgr6d/cFL6qgKUI/YXMespRh9NlgMeV8Mx4iC/WAY+hwCz8SG67MqELg9fLbEaFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ej19VAxc; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b812d344-d507-479b-a086-5a36cb6e27a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737557436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVepUB8wNc5o/qy4cZIKZFKgWZyZswKdukCpSAPj37g=;
	b=Ej19VAxcsUvhezxaX0uloN/wcxKKvTXMdPAgfW0IZxhMKvFKxJ6Mnd/U8AZnGMjco7aKLf
	JaC7flAnQsDhg0jT2fF2q9CpeacgMbidm0iPsifRsP0b1+Z3m/zZcRq2QEtOqLK+6mEUIE
	vFzECwFVDwfojEio8AC6gWoY8ZMaUTU=
Date: Wed, 22 Jan 2025 22:49:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Set correct
 {tx,rx}_fifo_size
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chong Qiao <qiaochong@loongson.cn>, linux-arm-kernel@lists.infradead.org,
 fancer.lancer@gmail.com, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <20250121093703.2660482-1-chenhuacai@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250121093703.2660482-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 1/21/25 17:37, Huacai Chen 写道:
> Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> zero. This means dwmac-loongson doesn't support changing MTU, so set the
> correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by channel
> counts).
> 
> Note: the Fixes tag is not exactly right, but it is a key commit of the
> dwmac-loongson series.
> 
> Cc: stable@vger.kernel.org
> Fixes: ad72f783de06827a1f ("net: stmmac: Add multi-channel support")
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Acked-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index bfe6e2d631bd..79acdf38c525 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -574,6 +574,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>   	if (ret)
>   		goto err_disable_device;
>   
> +	plat->tx_fifo_size = SZ_16K * plat->tx_queues_to_use;
> +	plat->rx_fifo_size = SZ_16K * plat->rx_queues_to_use;
> +
>   	if (dev_of_node(&pdev->dev))
>   		ret = loongson_dwmac_dt_config(pdev, plat, &res);
>   	else


