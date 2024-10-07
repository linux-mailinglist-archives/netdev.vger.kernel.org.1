Return-Path: <netdev+bounces-132785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C019932DC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60136B27722
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D91DD545;
	Mon,  7 Oct 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rwm+tfbY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91041DCB1E;
	Mon,  7 Oct 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317469; cv=none; b=gJRWFBjudVYARr/Oj46h/h4aeauWpcmjJ/KveIHNBfoa7XWU1bvBInl4IoSXLu6zplPPNxbClFtr/Euve7hT64siqsvVLops+UX2XA6VP0cX+udfEgImXRCqaEgSLobRtzY8MKSINHVjfd80cORsKyW8Rr0OSpeKhxiaHmlMaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317469; c=relaxed/simple;
	bh=Fedxb/DmY1awdPWpVP8ZyZlPsG6FVbglrT5wRXNoYVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE1BlYbRx6u0yTonmhEyE4qhRJciHZvGdiKsMFis5JirnvGSWdEU8u3CkEOYybxoagvYef+ZIdOoEoILexD40usJQrEJjNRoVpSd/YfIGA8xTnw+B13xfW2shUc0vzzcEz5AaLiH9A0/ueaDNAVFgPY2JdP+qekiDgdSlb6yOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rwm+tfbY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tOIWOo9QQODjzaxMqM3UFZVHDTlN3XAQg5QyI1UoT+8=; b=rwm+tfbYKoATZHUThmBlYrHhVo
	RKvrKxKAFA1ek+CFZ5UWHLUqfbcSQjq/AezsoSwL5H1CMo0xCTMCMkxj5tDcrqzAcyb8ygsgeU5S2
	pFe+BbW98E1RY0B/MtZ00aS4mOeH9rV98n0qm23PnjPtURuJzH5G9s+eiuYV7fXKuCABzf5i/ohVQ
	/FIN7HxXaxtf+/HEfwyNh/MKcAVEIat+GNg5R6AJ44Es6KeWEhzgpkDLKLg8kyphasi9pjcTYWg+V
	9jzM9rqLeDRyGKJZTFunmosIsULh+StBly/D3oOzILNbxq9Ho3MNd8mxTlvK6H/4UxrkHPo8cB8eS
	6mCcakTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46640)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sxqK4-00062G-1L;
	Mon, 07 Oct 2024 17:11:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sxqK0-0004LE-1f;
	Mon, 07 Oct 2024 17:10:56 +0100
Date: Mon, 7 Oct 2024 17:10:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <ZwQIEDkWQZzglbAq@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007154839.4b9c6a02@device-21.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 07, 2024 at 03:48:39PM +0200, Maxime Chevallier wrote:
> Sure thing. There are multiple devices out-there that may have multiple
> PHYs accessible from the MAC, through muxers (I'm trying to be generic
> enough to address all cases, gpio muxers, mmio-controlled muxers, etc.),
> but let me describe the HW I'm working on that's a bit more problematic.
> 
> The first such platform I have has an fs_enet MAC, a pair of LXT973
> PHYs for which the isolate mode doesn't work, and no on-board circuitry to
> perform the isolation. Here, we have to power one PHY down when unused :
> 
>                 /--- LXT973
> fs_enet -- MII--|
>                 \--- LXT973
> 
> 
> The second board has a fs_enet MAC and a pair of KSZ8041 PHYs connected
> in MII.
> 
> The third one has a pair of KSZ8041 PHYs connected to a
> ucc_geth MAC in RMII.
> 
> On both these boards, we isolate the PHYs when unused, and we also
> drive a GPIO to toggle some on-board circuitry to disconnect the MII
> lines as well for the unused PHY. I'd have to run some tests to see if
> this circuitry could be enough, without relying at all on PHY
> isolation :
> 
>                    /--- KSZ8041
>                    |
>       MAC ------ MUX
>                  | | 
>   to SoC <-gpio--/ \--- KSZ8041
> 
> 
> One point is, if you look at the first case (no mux), we need to know
> if the PHYs are able to isolate or not in order to use the proper
> switching strategy (isolate or power-down).
> 
> I hope this clarifies the approach a little bit ?

What I gather from the above is you have these scenarios:

1) two LXT973 on a MII bus (not RMII, RGMII etc but the 802.3 defined
   MII bus with four data lines in each direction, a bunch of control
   signals, clocked at a maximum of 25MHz). In this case, you need to
   power down each PHY so it doesn't interfere on the MII bus as the
   PHY doesn't support isolate mode.

2) two KSZ8041 on a MII bus to a multiplexer who's exact behaviour is
   not yet known which may require the use of the PHYs isolate bit.

I would suggest that spending time adding infrastructure for a rare
scenario, and when it is uncertain whether it needs to be used in
these scenarios is premature.

Please validate on the two KSZ8041 setups whether isolate is
necessary.

Presumably on those two KSZ88041 setups, the idea is to see which PHY
ends up with media link first, and then switch between the two PHYs?

Lastly, I'm a little confused why someone would layout a platform
where there are two identical PHYs connected to one MAC on the same
board. I can see the use case given in 802.3 - where one plugs in
the media specific attachment unit depending on the media being
used - Wikipedia has a photo of the connector on a Sun Ultra 1 -
but to have two PHYs on the same board doesn't make much sense to
me. What is trying to be achieved with these two PHYs on the same
board?

It's got me wondering whether the platform you have is some kind of
development board, and the manufacturer feels the need to provide a
network socket on either end of the board because folk don't have a
long enough ethernet cable to reach the other end! :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

