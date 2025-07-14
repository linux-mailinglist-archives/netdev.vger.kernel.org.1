Return-Path: <netdev+bounces-206673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC8AB04038
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE7718841C3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23421F3FC6;
	Mon, 14 Jul 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qPYqJaoS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BE2F22;
	Mon, 14 Jul 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500100; cv=none; b=k0ClVnX5bI62Mkc1XEc7Jjaqbs/k/mbDUKxJ5mTnBtp8ujpweCTXzfKNmBJLxumwvhPgS8ulyFEO3OZsT3zWJF5wavF8yyT0153SA1rZpJfSnax8NBpXscYp5UMSBtSqCjNDFut3qXGysNf+uhZR+iaYAMOZaA6FFD/PGAMWYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500100; c=relaxed/simple;
	bh=CEkKa/aikU/CDzdfcPAjOT99jNpHypxstJjnFfoQF3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5VF5/nClZzIYxlJba8mqM+mGtULo4d9jEqZ8IsOB47QZWqc6EK1g1gy4DAc4KfZ8PiQrRSJXW91a8QPZBmK5JZIdRKEgpt6HaiBI2tyfAouFNSqy7I3q04Bzvtihi4cqUTfAIxw2pmhaHxPrO1s/icfBKMMuF9c82QFHvoL7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qPYqJaoS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rkKA5JFXkaqeIgKnZeTRvq/H+eMfFQ7tSAFHadzv+i4=; b=qPYqJaoStTW6WZY8E3xsfppAcV
	GciwfhUoAIxtaUx5hRVyOQZL595Nutl12IeZGQ+2QwMLot/GFSllOAsMkFzzwfSJiTKTwqNREFIWM
	u1tdKdG9gNKJ9cvGzr99Z+DlXIe3rzBruOF4Hcro7UHi3k4oDscE48rIsYpUmNuaWcqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubJKR-001SkI-Ao; Mon, 14 Jul 2025 15:34:47 +0200
Date: Mon, 14 Jul 2025 15:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: xgmac: Disable RX FIFO
 Overflow interrupts
Message-ID: <bef4d761-8909-4f90-8822-8c344291cb93@lunn.ch>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-1-c34092a88a72@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-xgmac-minor-fixes-v1-1-c34092a88a72@altera.com>

On Mon, Jul 14, 2025 at 03:59:17PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Enabling RX FIFO Overflow interrupts is counterproductive
> and causes an interrupt storm when RX FIFO overflows.
> Disabling this interrupt has no side effect and eliminates
> interrupt storms when the RX FIFO overflows.
> 
> Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO
> overflow interrupts") disables RX FIFO overflow interrupts
> for DWMAC4 IP and removes the corresponding handling of
> this interrupt. This patch is doing the same thing for
> XGMAC IP.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

This appears to be a fixed, so the Subject: line should indicate this.
Please also include a Fixes: tag, and Cc: stable.

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 5dcc95bc0ad28b756accf9670c5fa00aa94fcfe3..7201a38842651a865493fce0cefe757d6ae9bafa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -203,10 +203,6 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	}
>  
>  	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
> -
> -	/* Enable MTL RX overflow */
> -	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
> -	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));

What is the reset default? Would it make sense to explicitly disable
it, rather than never enable it? What does 8a7cb245cf28 do?

    Andrew

---
pw-bot: cr



