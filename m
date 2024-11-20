Return-Path: <netdev+bounces-146444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C339D3744
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EE9282875
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D619CC20;
	Wed, 20 Nov 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="igZMxffb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31A19C561;
	Wed, 20 Nov 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095797; cv=none; b=cWewRz1MyE4l3qhq4av0iSDEzdEEA0tBd+pPnWUW4zbw6JP0eA1Sv9udUaf0rgobWUZ67fi4W+DRdon8vVF8v1QPtQc4uKEcKh2mKP1zZucalIOh/ZDAWJT5fLW20M/jTU6Swbneu1GKTJibFHokTuFqeoxbLvDPq0brMn46B38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095797; c=relaxed/simple;
	bh=VaKOt6vvu3wOap6Yra2kLT6E5D+cKAsIU7jD3uNxLao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUCdBQZIC8r0dkZSzyuX4LBhrfC30vPiosFsQCSV5TBhp3xXH+vJkD60EVPLlH+vkzRf6WeC6UnbPkQ/5/es/CBEUKbHVSOtrTSR4UzdMx28l5XBthlSbWhax3rlkOQzOz6KTyFTE95rwDjZFrfmYW1mrwXnYIok7+oUyhRlotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=igZMxffb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kZTawVyREwEbEOOkp3Rqm/v6gSKb/kMRQbLscX9yHuw=; b=igZMxffbTRUyD8L+1EoUfrdzky
	RSCaES81zeNcd2+z6BGEANUnUTKU4IfjdGt+u85jLekbR7U1rsHoncYLr4zg5cR1nKwjoKFdG6/ZC
	Qx1umwuHGU1wHui6vx5IHTK9UBcFgRWsI0n1SAEWTnn1X1jXAcTFRL0C5pnH9XXUKpIfyWrRfpzry
	66FUMXQBG2L1hvu0eYY+ZzUPvAe1h6j3tzVaDsT7lFo+FrDcVo3WgPrkzuiMEfWkTrd001NvRabRJ
	Ewjn/XKISUqt3m0EGepTbsEloWWyFSGQBTDbYsE57tavrghZxu5A4lu+kEOy8NcKfOSmKvCWETIyW
	oYTXeekg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41692)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDhEg-0005D4-0P;
	Wed, 20 Nov 2024 09:42:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDhEb-0006zB-1H;
	Wed, 20 Nov 2024 09:42:53 +0000
Date: Wed, 20 Nov 2024 09:42:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	joel@jms.id.au, andrew@codeconstruct.com.au, f.fainelli@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <Zz2vHWLYTRKIG7GK@shell.armlinux.org.uk>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 05:51:41PM +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is not
> arrived to MDIO controller immediately. On software, the driver issues a
> write command to the command bus does not wait for command complete and
> it returned back to code immediately. But a read command will wait for
> the data back, once a read command was back indicates the previous write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected timeout.
> 
> Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new subdirectory")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index c2170650415c..373902d33b96 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
>  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
>  
>  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +	/* Add dummy read to ensure triggering mdio controller */
> +	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);

I'd change that comment to:

	/* The above write could be posted, causing the timeout below to
	 * be inaccurate. Ensure the controller starts before we start the
	 * timeout.
	 */

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

