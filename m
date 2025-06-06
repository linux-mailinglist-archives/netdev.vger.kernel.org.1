Return-Path: <netdev+bounces-195450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BAAAD038A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA4A7A83A0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76345289353;
	Fri,  6 Jun 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T5NhYSjd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F938288C23;
	Fri,  6 Jun 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218147; cv=none; b=OvygGauS/slV3QDhV37pSTzk55W3sktwT7wagLr0UcxaB1MLaqcBNyddko+NmjaFUW+PpQa7PKAf5aAZ5IPAHdrj3p3mLfEQG4KHJ5oZL1mcnNQ1TQ7oKkHfxfiq9ovnnIQLD+EQ158SPHK0qz+LF3/vI/4CATKBDfW5AU8aC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218147; c=relaxed/simple;
	bh=qKrYyKmHvECRvbUNso07tTqZkuOyB6ZTHzexI+wUNgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2z/ePelIQWk/4Ts/kzxwPFZoR9xUKsDyI6/OZqtImasU4vBo+1IVuUviJxmZvbUKmXoRakbPQpQOAn+sxC8WE0tZrrbD2RqcYHs12GroV6PA7x/BHs+8qFhSCc7TTzyLBR+RrrLcor3ugJSGJYnzhFIMi+WgzIB3js7E8RUFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T5NhYSjd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6dFmZYMvFnPKz7ElX5mkKo2Zv+TMRgVK23txlUfoVfY=; b=T5NhYSjd2nnhmPpsffbFUfP6uC
	eAPdvN5/SN0+W8vn/INqTew/+ATLDf1rR3/RBPDbaRm6mjXIyOyP8HLGEvFR+3FQV+Vo9iFNGWN/h
	QJmBgqQOEOoBeJ+/6okvzyJNd9Gu+bHs4IM1KDGCQ0ncCsGduFLMHl54xvqJ7OEgqzrM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNXXZ-00EuDg-89; Fri, 06 Jun 2025 15:55:25 +0200
Date: Fri, 6 Jun 2025 15:55:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartlomiej Dziag <bartlomiejdziag@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Change the busy-wait loops timing
Message-ID: <9f5f87d6-c7c2-4288-8c02-e57b0d943881@lunn.ch>
References: <20250606102100.12576-1-bartlomiejdziag@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606102100.12576-1-bartlomiejdziag@gmail.com>

On Fri, Jun 06, 2025 at 12:19:49PM +0200, Bartlomiej Dziag wrote:
> After writing a new value to the PTP_TAR or PTP_STSUR registers,
> the driver waits for the addend/adjust operations to complete.
> Sometimes, the first check operation fails, resulting in
> a 10 milliseconds busy-loop before performing the next check.
> Since updating the registers takes much less than 10 milliseconds,
> the kernel gets stuck unnecessarily. This may increase the CPU usage.
> Fix that with changing the busy-loop interval to 5 microseconds.
> The registers will be checked more often.
> 
> Signed-off-by: Bartlomiej Dziag <bartlomiejdziag@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index e2840fa241f2..f8e1278a1837 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -144,11 +144,11 @@ static int config_addend(void __iomem *ioaddr, u32 addend)
>  	writel(value, ioaddr + PTP_TCR);
>  
>  	/* wait for present addend update to complete */
> -	limit = 10;
> +	limit = 10000;
>  	while (limit--) {
>  		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSADDREG))
>  			break;
> -		mdelay(10);
> +		udelay(5);

I would actually suggest rewriting this using the macros from iopoll.h.

    Andrew

---
pw-bot: cr

