Return-Path: <netdev+bounces-158353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F2A1177B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04947A069F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054B14D430;
	Wed, 15 Jan 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vu7T6gYc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E132D600;
	Wed, 15 Jan 2025 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909460; cv=none; b=Fh+QrwyimEhBP9u8jkavGd8aoP66rI7TCRoR7ts/evZCB8HpuBkFh1o7xppYnBslPuvVkETEqJYs28zig7zE9l+PktVmjAUT/wWo4guiX8QIaXNKjgyZzbXFilFKoE2ioFHj7yfhL20xAvWtbhz3pC64wDXC8kIotYjdoo9cFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909460; c=relaxed/simple;
	bh=k+VcSSRYDW6G1ONdmDMR75pcGEaFM85covYOckH3vKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5LzUMR2z1kWCm/wcQkpfLBuj0sdDImoQkSI9OxOzHqt2lx/dTSQDghV5z6AfonYcm8HBmAiEqu7Dy2N+habKUZFsQEuLkdx9E9ynCmnpEQCEcQ9syrNvjVGchYTTBm7gH0cKm4G6IyWaaRMKEj3jASvLyDSDMA889hNEqxjBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vu7T6gYc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x5wCmHhsGS0A1OidXlTesaZoOIKeXQZp/eLun9Bsv/I=; b=vu7T6gYc4hXzdL8Iez/4QN7MNs
	fFxXInsV47fKLh9GUknptzB0Q0Tc6qa+ohoSVjvpboq3uJC97AhE+APE1GJDFpBWGOFv3fo+xKEEC
	6Ryr3ScXSXJ7zF9tIBZexgp0pUwYAziH/9j8VmDDw+dLlIx3ZxuzozsxPy7D6J/tNuVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXtUH-004e9t-Pq; Wed, 15 Jan 2025 03:50:33 +0100
Date: Wed, 15 Jan 2025 03:50:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: clear status if link is down
Message-ID: <7dd12859-dd20-4ce1-a877-4c93b335b911@lunn.ch>
References: <229e077bad31d1a9086426f60c3a4f4ac20d2c1a.1736901813.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229e077bad31d1a9086426f60c3a4f4ac20d2c1a.1736901813.git.daniel@makrotopia.org>

On Wed, Jan 15, 2025 at 12:46:11AM +0000, Daniel Golle wrote:
> Clear speed, duplex and master/slave status in case the link is down
> to avoid reporting bogus link(-partner) properties.
> 
> Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index f65d7f1f348e..3f0e03e2abce 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -720,8 +720,12 @@ static int rtlgen_read_status(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!phydev->link)
> +	if (!phydev->link) {
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> +		phydev->speed = SPEED_UNKNOWN;
>  		return 0;
> +	}
>  

I must be missing something here...


rtlgen_read_status() first calls genphy_read_status(phydev);


int genphy_read_status(struct phy_device *phydev)
{
	int err, old_link = phydev->link;

	/* Update the link, but return if there was an error */
	err = genphy_update_link(phydev);
	if (err)
		return err;

	/* why bother the PHY if nothing can have changed */
	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
		return 0;

	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
	phydev->speed = SPEED_UNKNOWN;
	phydev->duplex = DUPLEX_UNKNOWN;
	phydev->pause = 0;
	phydev->asym_pause = 0;

Why is that not sufficient ?

>  	val = phy_read_paged(phydev, 0xa43, 0x12);
>  	if (val < 0)
> @@ -1028,11 +1032,11 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  		return ret;
>  
>  	if (phydev->autoneg == AUTONEG_DISABLE ||
> -	    !genphy_c45_aneg_done(phydev))
> +	    !genphy_c45_aneg_done(phydev) ||
> +	    !phydev->link) {
>  		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> -
> -	/* Vendor register as C45 has no standardized support for 1000BaseT */
> -	if (phydev->autoneg == AUTONEG_ENABLE) {
> +	} else {
> +		/* Vendor register as C45 has no standardized support for 1000BaseT */
>  		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
>  				   RTL822X_VND2_GANLPAR);
>  		if (val < 0)
> @@ -1041,8 +1045,12 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
>  	}
>  
> -	if (!phydev->link)
> +	if (!phydev->link) {
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> +		phydev->speed = SPEED_UNKNOWN;
>  		return 0;
> +	}


rtl822x_c45_read_status() calls genphy_c45_read_link() which again
clears state from phydev.

	Andrew

