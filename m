Return-Path: <netdev+bounces-78473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEE875421
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753DCB21D35
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A912F593;
	Thu,  7 Mar 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vdiknhx0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AF83CAD
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828556; cv=none; b=M5gQRjcensYQmJEuOYpSSjZ5fFXcxe8+2wE0RhPZBbh8eqIWIGNwUZs9ea2rg0wW25rfX2FPi7yXurtKSgiOPSLxrOLl64CCNYPTbQ38LBizBcpezuIV+VGu9uxXYksSoyDlzUY3yLh06zjG0bL8GEQhNrJoREg9KfY4SaU3RvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828556; c=relaxed/simple;
	bh=QUE7z2MxArFhVxmlOACQcSmq5txWjfQB6wj+HZzYcEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/jfv+FRHHm16Vy8pgsbJraAAfcM/oKQrLMuZaYj2qplPipVaKgdgChGnXLzEuZdv+cADPJuTAtu0y0PXe+1Dy2nC6tEA/FJqNLkOcTfPkNwtbuK16lA/Y/m/WSfwMaKSNk9N5QMW5C8XXwDH0qcZ7oy5hp6YNXUlPIeJg2PkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vdiknhx0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K2xrB7zZjamNwhoMEeeZkyZGWpu5h0rZLfg8zzQ/9fk=; b=Vdiknhx0NfYE8OHlxLjxK1pxh9
	w3cQTw7vkJqsUrzNC7UeHBmEZBwn6WHt84StqgXPtaSC0odydFrczKBSUjiaYRZAL6sE9BusOsPdB
	u2qi7CTqFRlrTux9lpUdfoCwYFgcBxrYLuc3F1s8Det4p2tL5KlssACd1EQNGZ8R7jF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riGWH-009bNN-RE; Thu, 07 Mar 2024 17:22:57 +0100
Date: Thu, 7 Mar 2024 17:22:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next] net: phy: Don't suspend/resume device not
 in use
Message-ID: <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
References: <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>

> Because such device didn't go through attach process, internal
> parameters like phy_dev->interface is set to the default value, which
> is not correct for some drivers. Ie. Aquantia PHY AQR107 doesn't
> support PHY_INTERFACE_MODE_GMII and trying to use phy_init_hw()
> in mdio_bus_phy_resume() ends up with the following error caused
> by initial check of supported interfaces in aqr107_config_init():
> 
> [   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: error -19']
> 
> Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>
> ---
>  drivers/net/phy/phy_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3611ea64875e..30c03ac6b84c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -311,6 +311,10 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  {
>         struct phy_device *phydev = to_phy_device(dev);
> 
> +       /* Don't suspend device if not in use state */
> +       if (phydev->state <= PHY_READY)
> +               return 0;
> +
>         if (phydev->mac_managed_pm)
>                 return 0;

If nothing is using it, suspending it does however make sense. It is
consuming power, which could be saved by suspending it. It makes the
code asymmetrical, but i would throw this hunk away.

> 
> @@ -344,6 +348,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>         struct phy_device *phydev = to_phy_device(dev);
>         int ret;
> 
> +       /* Don't resume device which wasn't previously in use state */
> +       if (phydev->state <= PHY_READY)
> +               return 0;
> +

This is the real fix to your problem. phy_attach_direct() also does a
phy_resume(), so if the device does come along and claim the PHY after
the resume, it looks like this should work, without the matching
suspend.

	Andrew

