Return-Path: <netdev+bounces-238939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29031C617C9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96CD4E7CC5
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E130C61F;
	Sun, 16 Nov 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="06M4OCH5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB11FD4
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308553; cv=none; b=hvGo/vKgSZHVOH3oqS7TRksxKv2UJpeOdR/JVIzXaeilpnKpMI22lwhEE5tgfaaDgupoh96EN6Taj1zxj7TGMhtHdMDHhesMPE3w/qdEUIIkVJASh+7XXFqvE5/HFEff/kX9OY7SzzIHKDL822CcSReKUBH8GwxoaurioNGgal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308553; c=relaxed/simple;
	bh=wyrysQw+6xujPu8ldxBC4sbv1zVVl4mFMqfr81rv/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltjMNXgkPKSRnsqii7bN8bD4TZ4WsxpwRxQd8lGnmKwkYfhQMJ+E2HyjoubqTZFSjuqgJvclIC15sLJDh0PaUqyJ+3HWW3YcN+ndz3E9YA2+xTxObqHMHwSaN1BYmGMVf+1cNY8WUkTxurLMYlaf3Rzqjek/LF+PQR8oQ4bCmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=06M4OCH5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=reCXznXPWVe+fpdCc0ENGuBf45fg0AyEa0pS84WHo44=; b=06
	M4OCH573b/ZA6nZjHCLRkdhjOFGR67nhkaLs9uISj8LmeMAWaYf/T2gFkfTqEtWEk50KHWe+jbru0
	zTAkiDO4taHnVS6nkZsG+tevcAepQ/4S13QBRz0pIzF3Apn49+C5xA3Pxp5m6mpVEwrgVltH5NlWx
	yoJ15RGVx+ZaFnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKf6Q-00E9mC-5S; Sun, 16 Nov 2025 16:55:46 +0100
Date: Sun, 16 Nov 2025 16:55:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
Message-ID: <ca42d0de-404f-4ea5-b65d-5fe9d8813d64@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
 <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <aRjytF103DHLnmEQ@shell.armlinux.org.uk>
 <CAOMZO5DfK1kxhtbYR3bDbwinpCKotBgHnY-B+YUknnHivUPYDA@mail.gmail.com>
 <CAOMZO5BgfiM13hc=jYiouFSe5D_d71kFrr=66-CjLE-xuffHPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BgfiM13hc=jYiouFSe5D_d71kFrr=66-CjLE-xuffHPw@mail.gmail.com>

On Sat, Nov 15, 2025 at 11:14:33PM -0300, Fabio Estevam wrote:
> On Sat, Nov 15, 2025 at 9:57 PM Fabio Estevam <festevam@gmail.com> wrote:
> 
> > I have also tried describing it inside the ethernet-phy node with:
> > reset-assert-us; reset-deassert-us; and reset-gpios, but it did not help.
> 
> Ok, what do you think about the change below?
> 
> It will work when reset-gpios is described inside the ethernet-phy node.
> 
> It will not work when the reset GPIO is specified within the FEC node
> via the phy-reset-gpios property.
> 
> This is OK as 'phy-reset-gpios' is marked as deprecated in
> Documentation/devicetree/bindings/net/fsl, fec.yaml.
> 
> --- a/drivers/net/phy/smsc.c
> +++ b/drivers/net/phy/smsc.c
> @@ -147,9 +147,19 @@ static int smsc_phy_reset(struct phy_device *phydev)
>                 /* set "all capable" mode */
>                 rc |= MII_LAN83C185_MODE_ALL;
>                 phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
> +               /* reset the phy */
> +               return genphy_soft_reset(phydev);
>         }
> 
> -       /* reset the phy */
> +       /*
> +        * If the reset-gpios property exists, a hardware reset will be
> +        * performed by the PHY core, so do NOT issue a soft reset here.
> +        */
> +       if (phydev->mdio.dev.of_node &&
> +           of_property_present(phydev->mdio.dev.of_node, "reset-gpios"))
> +               return 0;
> +
> +       /* No reset GPIO: fall back to soft reset */
>         return genphy_soft_reset(phydev);

We are still missing the "Why?". Why does a combination of a hard and
soft reset mess up the PHY?

It would be good to understand this before accepting the patch. Or
extend the patch and the commit message to say that we have no idea
why this works, but testing suggests it does. That will help anybody
who comes later and has problems here to know this is a magical
workaround, not a fix.

	Andrew

