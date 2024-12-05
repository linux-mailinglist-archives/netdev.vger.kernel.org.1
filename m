Return-Path: <netdev+bounces-149378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026959E5534
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D0E1881F49
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26C218E84;
	Thu,  5 Dec 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TmBQ7r1p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EC218AD1;
	Thu,  5 Dec 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400931; cv=none; b=jN1kZ4JKkYZb896EAsqkulamEuVG3D9ciNACD03zHLR6L2wIlx/Zh+mZzS26AlrbfhUSfuw371gQBhR3ic4VpHFGTWrMZIH04YSROaVrm6czDKD6az7Zm6ozUjJCA+S35aHrbWPbq807nUagnL8OMpAGneBptkUxYgc9fF5MN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400931; c=relaxed/simple;
	bh=/29uYNfB4jsLibyobe2nNI/2TzDkendtERkhqweYv+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZewc7zVw9bh9pCIF4owCXoaUB53GA1HM92PddlJjjRibafIoB/hngifnfeVsOAEBvd31sdnWu0K4yIDOaMpyBJOG6Lbt7kYZy1OSBa2ZsOy1SWj0BQn47pZTYG4Ouxrpa9fuoCepWi9THNQrN1OCHNIEzSs5ex4kckWVp5jEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TmBQ7r1p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c2uRpWQzrgsevOGntiKGOMAAWqRJBifNOKZIBOx/xX0=; b=TmBQ7r1pewYBgLyGRI3YeehQf3
	8XCeKdAYF++k8YWHUnLn0LFIFBOOVKPeOaaJtK8b1ZkiZ+GVvLUZZvlzGlUOG2uKwubbDfS5ehoqB
	n/slnEBsqCHkDn20CrQ0DC+734SXz1s795git2wBOl16lJ4NU5MRuJ3kHwjHVqblHHJ0nW7Yj1HMv
	VU8DxCz5npDfHRH30WNphV5WM9UXY3h3fw/nfZQJLM+Jq1Ns7rvSGZTgMolmBdnqECwgrL5K4qqwm
	QF+R0jF4a9zP9ZQlwrTVz+5Y9nwxVRfgpkOcQxQH3Euy4etYXvjPwGDlIwdbJPXXpg4cW65339uTt
	Y6oPUmHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAlL-0004m7-04;
	Thu, 05 Dec 2024 12:15:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAlJ-0006Y7-1G;
	Thu, 05 Dec 2024 12:15:17 +0000
Date: Thu, 5 Dec 2024 12:15:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 6/7] phy: dp83td510: add statistics support
Message-ID: <Z1GZVf7R9AYeRJAF@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-7-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 08:56:20AM +0100, Oleksij Rempel wrote:
> Add support for reporting PHY statistics in the DP83TD510 driver. This
> includes cumulative tracking of transmit/receive packet counts, and
> error counts. Implemented functions to update and provide statistics via
> ethtool, with optional polling support enabled through `PHY_POLL_STATS`.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83td510.c | 98 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> index 92aa3a2b9744..08d61a6a8c61 100644
> --- a/drivers/net/phy/dp83td510.c
> +++ b/drivers/net/phy/dp83td510.c
> @@ -34,6 +34,24 @@
>  #define DP83TD510E_CTRL_HW_RESET		BIT(15)
>  #define DP83TD510E_CTRL_SW_RESET		BIT(14)
>  
> +#define DP83TD510E_PKT_STAT_1			0x12b
> +#define DP83TD510E_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_2			0x12c
> +#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_3			0x12d
> +#define DP83TD510E_TX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_4			0x12e
> +#define DP83TD510E_RX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_5			0x12f
> +#define DP83TD510E_RX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_6			0x130
> +#define DP83TD510E_RX_ERR_PKT_CNT_MASK		GENMASK(15, 0)

I'm not sure I like this pattern of _MASK here. Why not call these
registers e.g. DP83TD510E_RX_PKT_CNT_31_16 ? Given that the full
register value is used, I don't see the need for _MASK and the
FIELD_GET()s, which just add extra complexity to the code and
reduce readability.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

