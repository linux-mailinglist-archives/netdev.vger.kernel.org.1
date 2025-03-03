Return-Path: <netdev+bounces-171291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776EA4C5F5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E260818941A0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D391DB148;
	Mon,  3 Mar 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ExXigSCm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1D7080D;
	Mon,  3 Mar 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017733; cv=none; b=PqDSYO5I0yO6ZTEVI/T3ZY7RZrHOXDRTm3nx19fWAyCUx+Ed1zmnZm62+EOXWQbMcLd4rKSVmfUXErs3/x7PXxixGl5kLaxJVd3mLvB3YCUc0i4cQdlz0bWwkHtJwtRZOvj11Zv2rNzyyv9XqAgMaWJlR5OHsXZUy79e8ga3aHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017733; c=relaxed/simple;
	bh=IpXNXjNLYnJF1MNTJjYBmJJw52tvl+CUVwSYOJCI5aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGDbgVhaHSiVv5ARbKQTUMK4llUcuSECJA5etrWPIZa3PR+DOvY/45WH0pB6859zyv4nAaAFAx4vFTxxAHUrvFVDNJ00Sasclqf8X9aS5+hrcwxQlxLd9Hhw+DkEeRFy+L1dEnkbUGa7pUPilzRFJ+PcMN04wlG1xKjJpyxgqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ExXigSCm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZL8DvrgJGyhse//wJYi0Bnf1Fs9Yqso9d1y3MPnnH/M=; b=ExXigSCmYFsqs/6TXyUTDrL5p0
	nxS5N/V3nSJPdZdWTq0CRgfJs/2LEGPtwc9ATBOeeUyZSiAOMoT1bKDNnC7Rs9pJIF1La1TI6FZb4
	JFAi8FgelvvARO+Pg4lAQ+XqpO0pnC5LhyBqF31/AdcbPz1avwpgmE0GmfFDrZ4IApws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp8Et-001qxX-Qc; Mon, 03 Mar 2025 17:01:55 +0100
Date: Mon, 3 Mar 2025 17:01:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/2] net: phy: tja11xx: add support for TJA1102S
Message-ID: <6df6cfe9-c6f6-4a1e-ba24-ef4843e356c0@lunn.ch>
References: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
 <20250303-tja1102s-support-v1-1-180e945396e0@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-tja1102s-support-v1-1-180e945396e0@liebherr.com>

On Mon, Mar 03, 2025 at 04:14:36PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> NXPs TJA1102S is a single PHY version of the TJA1102 in which one of the
> PHYs is disabled.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/net/phy/nxp-tja11xx.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> index ed7fa26bac8e83f43d6d656e2e2812e501111eb0..8f3bd27b023b5755c223b6769980aad0b76aad89 100644
> --- a/drivers/net/phy/nxp-tja11xx.c
> +++ b/drivers/net/phy/nxp-tja11xx.c
> @@ -21,6 +21,7 @@
>  #define PHY_ID_TJA1100			0x0180dc40
>  #define PHY_ID_TJA1101			0x0180dd00
>  #define PHY_ID_TJA1102			0x0180dc80
> +#define PHY_ID_TJA1102S			0x0180dc90
>  
>  #define MII_ECTRL			17
>  #define MII_ECTRL_LINK_CONTROL		BIT(15)
> @@ -316,6 +317,8 @@ static int tja11xx_config_init(struct phy_device *phydev)
>  		if (ret)
>  			return ret;
>  		break;
> +	case PHY_ID_TJA1102S:
> +		fallthrough;
>  	case PHY_ID_TJA1101:

You don't need the fallthrough when there are no statements in the
case.


    Andrew

---
pw-bot: cr

