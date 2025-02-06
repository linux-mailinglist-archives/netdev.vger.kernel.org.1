Return-Path: <netdev+bounces-163437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB63A2A42C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9424D3A3043
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08684226160;
	Thu,  6 Feb 2025 09:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C81FCCE4
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833931; cv=none; b=uXTtIFXkmHqLi3mJloxhyh5YRyBrpF9p18KnRLrPZ3aFzb/Bz8bXo7vtxc9T2tDeQddl0+hkgcvDowe6eXpJB4odsHEPX3agTFWy1X+dpQG4giaEfwBaG5LbwJWCG0zfgi+viC+Y2+ehdgUnhRCLLgqIa+J1gzJvCJ7ZvZXhi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833931; c=relaxed/simple;
	bh=tE2AYB16+fgBWvhMHWaTL73rEi56eWaSNbgT1CPsE7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2/eZ8edLjlkI8lpgSXIV5/ocPDaMKowfW/daFhMA9yJIGHbEpOem54MiX2pqtCJlvXRA4ZUXflczrtexC7MXTfnV0Un8dYepeonIPsW5Pok7ILKt3sOft6mj8Warv6Zxm9WSpeUbfzyHvnOoJAQiEpzdr49sNaD8YBMhrZYfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A9F12FC;
	Thu,  6 Feb 2025 01:25:51 -0800 (PST)
Received: from [10.1.30.52] (e122027.cambridge.arm.com [10.1.30.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732CC3F63F;
	Thu,  6 Feb 2025 01:25:25 -0800 (PST)
Message-ID: <4ed5b1dc-4f5c-4d2a-97e2-7b1f43dccfdc@arm.com>
Date: Thu, 6 Feb 2025 09:25:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net: stmmac: Specify hardware capability
 value when FIFO size isn't specified"
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2025 12:57, Russell King (Oracle) wrote:
> This reverts commit 8865d22656b4, which caused breakage for platforms
> which are not using xgmac2 or gmac4. Only these two cores have the
> capability of providing the FIFO sizes from hardware capability fields
> (which are provided in priv->dma_cap.[tr]x_fifo_size.)
> 
> All other cores can not, which results in these two fields containing
> zero. We also have platforms that do not provide a value in
> priv->plat->[tr]x_fifo_size, resulting in these also being zero.
> 
> This causes the new tests introduced by the reverted commit to fail,
> and produce e.g.:
> 
> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> 
> An example of such a platform which fails is QEMU's npcm750-evb.
> This uses dwmac1000 which, as noted above, does not have the capability
> to provide the FIFO sizes from hardware.
> 
> Therefore, revert the commit to maintain compatibility with the way
> the driver used to work.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/r/4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested on my Firefly RK3288

Tested-by: Steven Price <steven.price@arm.com>

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++++++----------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d04543e5697b..b34ebb916b89 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2424,6 +2424,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  	u32 chan = 0;
>  	u8 qmode = 0;
>  
> +	if (rxfifosz == 0)
> +		rxfifosz = priv->dma_cap.rx_fifo_size;
> +	if (txfifosz == 0)
> +		txfifosz = priv->dma_cap.tx_fifo_size;
> +
>  	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
>  	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
>  		rxfifosz /= rx_channels_count;
> @@ -2892,6 +2897,11 @@ static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
>  	int rxfifosz = priv->plat->rx_fifo_size;
>  	int txfifosz = priv->plat->tx_fifo_size;
>  
> +	if (rxfifosz == 0)
> +		rxfifosz = priv->dma_cap.rx_fifo_size;
> +	if (txfifosz == 0)
> +		txfifosz = priv->dma_cap.tx_fifo_size;
> +
>  	/* Adjust for real per queue fifo size */
>  	rxfifosz /= rx_channels_count;
>  	txfifosz /= tx_channels_count;
> @@ -5868,6 +5878,9 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  	const int mtu = new_mtu;
>  	int ret;
>  
> +	if (txfifosz == 0)
> +		txfifosz = priv->dma_cap.tx_fifo_size;
> +
>  	txfifosz /= priv->plat->tx_queues_to_use;
>  
>  	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
> @@ -7219,29 +7232,15 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
>  	}
>  
> -	if (!priv->plat->rx_fifo_size) {
> -		if (priv->dma_cap.rx_fifo_size) {
> -			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
> -		} else {
> -			dev_err(priv->device, "Can't specify Rx FIFO size\n");
> -			return -ENODEV;
> -		}
> -	} else if (priv->dma_cap.rx_fifo_size &&
> -		   priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
> +	if (priv->dma_cap.rx_fifo_size &&
> +	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
>  		dev_warn(priv->device,
>  			 "Rx FIFO size (%u) exceeds dma capability\n",
>  			 priv->plat->rx_fifo_size);
>  		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
>  	}
> -	if (!priv->plat->tx_fifo_size) {
> -		if (priv->dma_cap.tx_fifo_size) {
> -			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
> -		} else {
> -			dev_err(priv->device, "Can't specify Tx FIFO size\n");
> -			return -ENODEV;
> -		}
> -	} else if (priv->dma_cap.tx_fifo_size &&
> -		   priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
> +	if (priv->dma_cap.tx_fifo_size &&
> +	    priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
>  		dev_warn(priv->device,
>  			 "Tx FIFO size (%u) exceeds dma capability\n",
>  			 priv->plat->tx_fifo_size);


