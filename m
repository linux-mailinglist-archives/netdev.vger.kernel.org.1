Return-Path: <netdev+bounces-102094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D9901649
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F201F20FED
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C76AC0;
	Sun,  9 Jun 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NGe2szpT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085363C7
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717940932; cv=none; b=bc8jGG7oN5ELAGRmi5+d1Ag63kuluQfaZAi00m4VcAMp+eEYMIWxFpEZ2L84SImsGVJpyAWIsjT11E1cuuT3Kid8MfZJVL4mVnKq5VR7BKrZEMIIeKtdw7bJlG7Va0kQ5rRYidDebW9jlexkivaBjla+bRGNKA/U1npTOsT3aQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717940932; c=relaxed/simple;
	bh=XTw88jV2qbvmRrobXjjz2+BJ57Rxi/8g2xEjK4KLvbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X28L0um8GE5moDkhpCveg2iDg71t1Vv6ObaWKQ3rTJUfQOACaj2XFM9jwJ3V0A7FvRBE4x94enqJWX0kUhvCl2+y8W3IpTd5EPOy9z+5F6PfiiXb4ZcdGXs7NeOe9LoTRAVjgY/IgHO5EQ1Q4YaK1b0mNSmISGHh6JS0SjfPEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NGe2szpT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TReKwmOu0YYWw4kiU5LHEAhtAfp2hz2Q03SY8LvgGmw=; b=NGe2szpTBLRli/pCjjCmp5aU6u
	xLh9yXhXaiIxgreE52MYex0LhSX9h0JbU5fEIrAx6eFtKtpD3J6hmnLAqCyDCVQV9u68taUquAB5n
	a9WpEtFRnTNuO8leHhEvj4BNGjoa398pjhNDj/ORjVLroXQ5eJcZafGYlHNjwikVEbQE2ObAq/dhy
	UuOfsP6bTDu8qWAavxiHDzui4NPGaTZg6SfB9TBMlEx8ovQZQX8oEwVSEzZwJ3NydWe6Xg0sL6ZGK
	HbnMJKZwNhp2cSTZ5w6yVxgfFJSRYd7rRGksJXgCesyEwt/K85H9vEw8NtxwhgnwaFzyJZMIPOgg7
	gs4muaoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44406)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGIuW-0000Yx-2A;
	Sun, 09 Jun 2024 14:48:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGIuX-0005zi-5M; Sun, 09 Jun 2024 14:48:41 +0100
Date: Sun, 9 Jun 2024 14:48:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <ZmWyufzdM9vKjBDc@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
 <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
 <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jun 09, 2024 at 02:40:03PM +0200, Hans-Frieder Vogt wrote:
> --- a/drivers/net/ethernet/tehuti/tn40_phy.c    2024-06-06
> 06:43:40.865474664 +0200
> +++ b/drivers/net/ethernet/tehuti/tn40_phy.c    2024-06-06
> 18:57:01.978776712 +0200
> @@ -54,6 +54,8 @@ int tn40_phy_register(struct tn40_priv *
>                 return -1;
>         }
> 
> +       __set_bit(PHY_INTERFACE_MODE_XAUI, phydev->host_interfaces);
> +
>         config = &priv->phylink_config;
>         config->dev = &priv->ndev->dev;
>         config->type = PHYLINK_NETDEV;

This shouldn't be done - host_interfaces is really only for SFPs, and
it suggests that the 88x3310 isn't properly configured with pinstrapping
for the correct MAC type (which determines the interface mode to be used
to communicate with the MAC.)

I'm not sure what to suggest here, other than further debug (e.g. what
interface mode is the 88x3310 trying to use without this?)

> I have to mention, though, that the phy-drivers for x3310 and aqr105 are
> not yet ready and will also need some changes related to the firmware
> loading, because for most (all?) of the Tehuti-based cards the phy
> firmware has to be uploaded via MDIO.

That's problematical - as I understand it, the 88x3310 firmware at least
is not freely redistributable (we've run into this with other
platforms that do not program the SPI flash attached to the 88x3310
and been told my Marvell that the firmware can't be made available as
part of e.g. linux-firmware.)

So quite what we do with the 88x3310 based boards that don't have
firmware, I'm not sure, but it seems given the non-distributable
firmware issue, that's going to be hard.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

