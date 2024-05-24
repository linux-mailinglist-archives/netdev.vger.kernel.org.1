Return-Path: <netdev+bounces-97993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E28CE795
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F071F2198F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CE212D762;
	Fri, 24 May 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lgbs4UWG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB412C559;
	Fri, 24 May 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563534; cv=none; b=kKNFgL/wUhbJC6ZcSwDZbuCfEMf0NQy6rdY8C35sueKVrBkpuNPaZi2suXA/aLu/6vxqAuvxEdu7JEEgqYpDiYxDH2ZbT52Vdy94dIje+IK3nw9fvQjQh+hnLN3RbqvMzY+6f/WqNQvApyyH6RTQQssKRlz44W6aYeNQeRexshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563534; c=relaxed/simple;
	bh=SVI3WhlLExOoWKwGPl5ap9cOpfECIdAMOgdQmpUFK+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfj7Sq0ht/M8fT2hclIXnrSR3AAalxQsXStr8+YODEWZ3jQJ8wUKngTCrrGt9cyXbsSThQpHdh3q8av3LqmBLJDhnA7WuKlcCcDtqbzqdcF5fi/bs3vYAwKIPK/W/wRVXL/6jECjae9Wc7LrLHLBH0YFBVBWkSj+3I/87JCMgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lgbs4UWG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2X44s7jUXHqpi4aq2fwiihAgByLF7GEFK84JVQQEeII=; b=Lgbs4UWGrCt4ZRKtqr0/1q7vy1
	tFeE9uZFTSb/s//CBJ1g+68JwxlrkrPIVczSnO5CTND53Ukb67GUF92VtEEUMOq1EjnfRLaEe7mcq
	Ps2+EMYn7cDN57BLx92ElE57ElmjuVPJmPvuOCR56lJERMuxDkluPNmIcDqs4hq55OJh4dzo8NKRu
	bHLls/Nrc2UBjI8afk63VzP1TVGCyycG+OLgS7YUKUMzWTRuZ+TFt8favgcYgpXdUiSGbMRbqWDC7
	3Hxnn6Wzwy63UZ2+agDkG+IKZshrzawF54Jiu2aMfY6D3oEBLx1OpU/CF7sEmh97cmWf4b7DBcyqm
	Wr0oZWnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sAWaG-0005NO-2m;
	Fri, 24 May 2024 16:11:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sAWaF-000834-RO; Fri, 24 May 2024 16:11:51 +0100
Date: Fri, 24 May 2024 16:11:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com
Subject: Re: [PATCH 1/1] net: phy: microchip_t1s: enable lan865x revb1
Message-ID: <ZlCuNxe65D3QPeA1@shell.armlinux.org.uk>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
 <20240524140706.359537-2-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524140706.359537-2-ramon.nordin.rodriguez@ferroamp.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 24, 2024 at 04:07:06PM +0200, Ramón Nordin Rodriguez wrote:
> +/* this func is copy pasted from Parthibans ongoing work with oa_tc6
> + * see https://lore.kernel.org/netdev/20240418125648.372526-7-Parthiban.Veerasooran@microchip.com/
> + */

Oh dear...

> +static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
> +				u16 regnum)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return bus->read_c45(bus, addr, devnum, regnum);
> +}
> +
> +/* this func is copy pasted from Parthibans ongoing work with oa_tc6
> + * see https://lore.kernel.org/netdev/20240418125648.372526-7-Parthiban.Veerasooran@microchip.com/
> + */
> +static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
> +				 u16 regnum, u16 val)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return bus->write_c45(bus, addr, devnum, regnum, val);
> +}

So you need both of these to (dangerously) read and write the C45
address using a devnum with bit 31 set. Please at the very least
take the MDIO bus lock so the locking of these operations remains
consistent.

I'm not sure that abusing the interface by setting bit 31 in the
device address, which is supposed to be between 0 and 31 is
something we're prepared to entertain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

