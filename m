Return-Path: <netdev+bounces-108610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A389248A3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A444B20D94
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553C1BF30B;
	Tue,  2 Jul 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zC3meLCN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC384084E;
	Tue,  2 Jul 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950128; cv=none; b=U3aspHysgDjFguoLOt12Y1Am7JxDFSIV5pK/Vw8+//eM3t0r1gpE+nsU0/zqNefvAtMJkWPEICyOQcaxr3qVjuHrfrGOAACrA8KULNVBm8lL1vt9ONxXDz6j6BLPGOAWaWs06js2LI5V3n5Sp/u/xgOUUnW/U0+Z+UwHZTbBZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950128; c=relaxed/simple;
	bh=DYQzU9mLmqMY5MwJkjrPsB32iGb2jaHpxakRgbP3D1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy6pEUz8NBLEczVZbItHyfGE63P3hqXJKtmR2UCVlyvfcGbM+Yk3UvzINUuaD9IzymJknW0z8vXz1uo8s0FD3MDfu//kEywGzAHRPW6g+6wdAaY1FdE7TBcRd6jT61rGMzX/hcyfCh0s3jjulTt6u1ZNNaawdjXM1boQ7AyS5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zC3meLCN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0aFPpcTE3yikrnw+fNhJl3nzvBnfs8+kSJz+WiTm5zI=; b=zC3meLCNci+F/kPQ4zn9MSw+vk
	d/cH3v58/sXnfNPTqKT8yRoWVp4KwYpgu+OZlD7913rqLrMzhrYQ7CT28MDtf6mwjc/G7P6R3COZy
	ykgqR/nWmoh3PrIv6v+6Nz3QfILFOn5LyrPrD8dPj7GbTvOjcHMpZRz2IRTWmLznkFB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOjau-001fSU-6Q; Tue, 02 Jul 2024 21:55:16 +0200
Date: Tue, 2 Jul 2024 21:55:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Message-ID: <ea532586-6b6b-4acc-b733-9a09ca2c7054@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
 <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
 <2273795.iZASKD2KPV@fw-rgant>
 <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
 <20240702165628.273d7f11@fedora-5.home>
 <ZoRDXvO/4sxJuotC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoRDXvO/4sxJuotC@shell.armlinux.org.uk>

On Tue, Jul 02, 2024 at 07:13:50PM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 02, 2024 at 04:56:28PM +0200, Maxime Chevallier wrote:
> > But I do agree with you in that this logic should not belong to any
> > specific PHY driver, and be made generic. phylink is one place to
> > implement that indeed, but so far phylink can't manage both PHYs on the
> > link (if I'm not mistaken).
> 
> This is not a phylink problem, but a phy*lib* implementation problem.
> It was decided that phy*lib* would take part in layering violations
> with various functions called *direct* from the core networking layer
> bypassing MAC drivers entirely.
> 
> Even with phy*link* that still happens - as soon as netdev->phydev
> has been set, the networking core will forward PHY related calls
> to that phydev bypassing the MAC driver and phylink.
> 
> If we want to start handling multiple layers of PHYs, then we have
> to get rid of this layering bypass.

Or at least minimise them.

SQI values probably don't cause an issue in this situation, that seems
to be mostly automotive which is unlikely to have multiple PHYs.

link_down_events probably should be cleaned up and set as part of
ethtool_ops->get_link_ext_stats.

All the plca is more automotive, i doubt there will be two PHYs
involved there.

PHY tunabled we need the work bootlin is doing so we can direct to
towards a specific PHY. Going through the MAC does not help us.  The
same is true for PHY statistics.

There are no PHY drivers which implement module_info, so that bypass
can be deleted.

Work is being done on tsinfo, etc.

Cable test ideally wants to be run on the outer PHY, but again, the
bootlin work should solve this.

PSE and multiple PHYs also seems unlikely.

So i don't think the problem is too big.

	Andrew

