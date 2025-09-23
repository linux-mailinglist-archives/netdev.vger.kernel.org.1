Return-Path: <netdev+bounces-225653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3EB96816
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A60F3A39E0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726E25EF97;
	Tue, 23 Sep 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gO6kBQXR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A3258EF3
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640289; cv=none; b=sBz50ZebDkVRk7wxx2Vzvh8mctyHBtBdcHhwqA6W6TJ+el6/aKlry0UYWzPtEY3X5W44PNySDFT8wxRSWUa9g1V2WTIZYLWnI/ejtx7Q6UiksUytHFOGgmWwWPskNzfVkwiWeob47F4wKxdT97nxCAbqmGRVZS0wHrROqghJIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640289; c=relaxed/simple;
	bh=2xalF+7m57ElEXdS0zB4aMSONbCWcx/4NGwn1BHQCFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuW2fBFaoM6O77lmoLtGg7mCHoSkUes/PUKdUICOQet6WqfnwDFrdnMPXaIVIE57T57brjzrWimDPbriz+ewgzrzWDyQQgLz78VoLm3b0DLLH+/c1waQKGsutn/C+dO4JHSBPzbxGgJfiP6YPhzvhRfy85oqTqaAgBFqfCQI8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gO6kBQXR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=c0YBBI16LtLHGKkRM0lt84oqLrwr5eDKv4Sp7gkWX5U=; b=gO
	6kBQXRMsiOlsb9B4pkwiiV5gncAxI/fhrWL10zkXcueSHkzCTEqYRf3Z8B6EF/DFqbYz75yhVlQXl
	bXP5GhqsKeJjzryPwj5SirQwoCuRlR6JHBm6iZphSjAQTa7o2pYnA8CeSnmyiahKPSVBlB4sS80Db
	AtR7yYA2sn7VTGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v14fg-009HBC-CF; Tue, 23 Sep 2025 17:11:12 +0200
Date: Tue, 23 Sep 2025 17:11:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm5481x: Fix GMII/MII/MII-Lite selection
Message-ID: <4d5f096a-49bd-4a4f-a9b9-d70610d0d1d6@lunn.ch>
References: <20250923143453.1169098-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923143453.1169098-1-kamilh@axis.com>

On Tue, Sep 23, 2025 at 04:34:53PM +0200, Kamil Horák - 2N wrote:
> The Broadcom bcm54811 is hardware-strapped to select among RGMII and
> MII/MII-Lite modes. However, the corresponding bit, RGMII Enable in
> Miscellaneous Control Register must be also set to select desired RGMII
> or MII(-lite)/GMII mode.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>  drivers/net/phy/broadcom.c | 10 ++++++++++
>  include/linux/brcmphy.h    |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index a60e58ef90c4..492fbf506d49 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -436,6 +436,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
>  	if (err < 0)
>  		return err;
>  
> +	if (!phy_interface_is_rgmii(phydev)) {
> +		/* Misc Control: GMII/MII/MII-Lite Mode (not RGMII) */
> +		err = bcm54xx_auxctl_write(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
> +					   MII_BCM54XX_AUXCTL_MISC_WREN |
> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |

This is a bit confusing. If it is NOT RGMII, you set RGMII_SKEW_EN? I
could understand the opposite, clear the bit...

> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);

>  #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
>  #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
> +#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060

Does RSVD mean reserved? Are you saying these two reserved bits need
to be set? They must be more than reserved if they need setting.

	Andrew

