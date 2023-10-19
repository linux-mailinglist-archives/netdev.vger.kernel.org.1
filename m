Return-Path: <netdev+bounces-42775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADEA7D013F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCDD1C20C91
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0737CB5;
	Thu, 19 Oct 2023 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YkSHs/c6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0338DD3;
	Thu, 19 Oct 2023 18:17:51 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E730121;
	Thu, 19 Oct 2023 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uxwGnWen6+9j+YrnXgkstw0OS38g943IHLCh1byhVXQ=; b=YkSHs/c6vw0CI2h0ml3QB50utc
	KZ/evPEkt1PQ0DcvCfPoqbqzZWcz5sRY/XQ7IWqN6c6TDLE2HlovDg/Gsh91OYA/znrvzCBlmldsv
	CoRtxHDccp+vF75IMLCl+pQSJlNca7p9iLJxD1KM/5hN4tL3FgLzwZ+iJ2bzf4l/0FIZ95vvBIGkQ
	pk2qm2LMWhjbndq/NXPt53vI6BAedGUDi8yAXHKPbQEpAbND5O7uO6iPTxwM3QufJ0rMrGkUHwsDP
	eoetCQKUb2bBOMNdE3m81R87zukgw3fen/Dh7OxY2JrIqAXUyyNRP5lV7ZZZTgbK2wtRRbOTHx2rC
	VE58zs7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtXaO-0007gD-1r;
	Thu, 19 Oct 2023 19:17:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtXaO-0000f1-Bm; Thu, 19 Oct 2023 19:17:32 +0100
Date: Thu, 19 Oct 2023 19:17:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <ZTFyvDLgmaTy2Csx@shell.armlinux.org.uk>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019172953.ajqtmnnthohnlek7@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 19, 2023 at 02:28:46PM +0200, Oleksij Rempel wrote:
> > Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> > driver.
> > 
> > Major changes include:
> > 
> > 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
> >    Packet wake events alongside existing wake reasons.
> > 
> > 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
> >    handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
> >    program the switch's MAC address register accordingly when Magic
> >    Packet wake-up is enabled. This change will prevent WAKE_MAGIC
> >    activation if the related port has a different MAC address compared
> >    to a MAC address already used by HSR or an already active WAKE_MAGIC
> >    on another port.
> > 
> > 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
> >    address changes on ports with active Wake on Magic Packet, as the
> >    switch's MAC address register is utilized for this feature.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/dsa/microchip/ksz9477.c    | 60 ++++++++++++++++++++++++--
> >  drivers/net/dsa/microchip/ksz_common.c | 15 +++++--
> >  drivers/net/dsa/microchip/ksz_common.h |  3 ++
> >  3 files changed, 71 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> > index b9419d4b5e7b..bcc8863951ca 100644
> > --- a/drivers/net/dsa/microchip/ksz9477.c
> > +++ b/drivers/net/dsa/microchip/ksz9477.c
> > @@ -81,7 +81,8 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
> >  	if (!pme_status)
> >  		return 0;
> >  
> > -	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s\n", port,
> > +	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s %s\n", port,
> > +		pme_status & PME_WOL_MAGICPKT ? "\"Magic Packet\"" : "",
> >  		pme_status & PME_WOL_LINKUP ? "\"Link Up\"" : "",
> >  		pme_status & PME_WOL_ENERGY ? "\"Enery detect\"" : "");
> 
> Trivial: if you format the printf string as %s%s%s and the arguments as
> "\"Magic Packet\" " : "", then the printed line won't have a trailing
> space at the end.

Sadly, it still will. The best solution is to prepend the space
character to each entry in the "list" and remove the space characters
after the : in the format string thusly:

	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

