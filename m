Return-Path: <netdev+bounces-177562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887BA70918
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E55189153A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E71A83EE;
	Tue, 25 Mar 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lsfzlgQc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799B19AA56;
	Tue, 25 Mar 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927706; cv=none; b=PhX3fwjw2CoVPQJM+wYw13hgD5kLlWT1Ss6uhfD1gLnqCHT+3OCNa1Lpe/yqiCcsH3yfMYVB+1hMx8FM2QhaLUh/KoqoDDWmY1BvbBhVwnevCmhLfQ5pj0ExKLNnZDOrDwIa5cdQ8m+udk3eYBd6IEOtDRUBvvbkqH3vSoBNZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927706; c=relaxed/simple;
	bh=TOauyI8xFEXS/sGMrKEVJ4dnfjywQ64iJTKnxTwebgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkShpBGS51HOWyd6CFkAww2EldcyDAQATD+YPtodJunooAxbzISBv+AFKEOlg7zaQyC3cekNA/KRwpILofiJhP5nrABmOVt+3SumOZR71aw1E7getwR/ZvBdfMx9B2VCu825AvbC157JKhdebvNu58tfEEuU7mbMyWfGZ7Ahtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lsfzlgQc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8PfMnHO9Jr/5p3LhcxmDnjH01NR00rn1zMezuF9k4Fc=; b=lsfzlgQcngfqocAuSOnkdfNuHE
	ozY1MQv8GQucMbiTiyJqAOqpmRwPg3iSQA2T9MbvKGoSDz1MaPjMCqE1yJUohC8aROuxmNtmfN2bq
	bKZfcjteDlv3e6cLHpq99hb9wsUzDk5C4WP3K4sow0d1UdB6pjucFSrTrwhZLTDBeqb7AagDTUoAg
	bCThj2Kr4lquWOfRFTFQ8GIKoj4vIM1Ls5ClcRE+pIjis6voPQtGHdDjM5MycM2reZJrfKPcPEQic
	o4pGvXTodI7eCNSRbRRXSNME/MqJ4QSgCdRTub4Oa/j1CM10xCWjOI3XEJi49cQCguW2nSKATGW6b
	qU7h0r1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tx970-0005Ax-0R;
	Tue, 25 Mar 2025 18:34:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tx96x-0003Wu-2H;
	Tue, 25 Mar 2025 18:34:51 +0000
Date: Tue, 25 Mar 2025 18:34:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Rengarajan.S@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, Thangaraj.S@microchip.com,
	Woojung.Huh@microchip.com, pabeni@redhat.com,
	o.rempel@pengutronix.de, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v5 5/6] net: usb: lan78xx: Integrate EEE support
 with phylink LPI API
Message-ID: <Z-L3S78A1WBbGIf4@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-6-o.rempel@pengutronix.de>
 <7e362f545ac58f35a88f29a3ca36009f7c97090b.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e362f545ac58f35a88f29a3ca36009f7c97090b.camel@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 25, 2025 at 05:51:05PM +0000, Rengarajan.S@microchip.com wrote:
> Hi Oleksij,
> 
> On Wed, 2025-03-19 at 09:49 +0100, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx
> > driver to
> > fully integrate with the phylink Low Power Idle (LPI) API. This
> > includes:
> > 
> > - Replacing direct calls to `phy_ethtool_get_eee` and
> > `phy_ethtool_set_eee`
> >   with `phylink_ethtool_get_eee` and `phylink_ethtool_set_eee`.
> > - Implementing `.mac_enable_tx_lpi` and `.mac_disable_tx_lpi` to
> > control
> >   LPI transitions via phylink.
> > - Configuring `lpi_timer_default` to align with recommended values
> > from
> >   LAN7800 documentation.
> > - ensure EEE is disabled on controller reset
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v5:
> > - remove redundant error prints
> > changes v2:
> > - use latest PHYlink TX_LPI API
> > ---
> >  drivers/net/usb/lan78xx.c | 111 +++++++++++++++++++++++-------------
> > --
> >  1 file changed, 67 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 9ff8e7850e1e..074ac4d1cbcb 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > 
> > +static int lan78xx_mac_eee_enable(struct lan78xx_net *dev, bool
> > enable)
> > +{
> > +       u32 mac_cr = 0;
> > +
> > +       if (enable)
> > +               mac_cr |= MAC_CR_EEE_EN_;
> > +
> > +       /* make sure TXEN and RXEN are disabled before reconfiguring
> > MAC */
> > +       return lan78xx_update_reg(dev, MAC_CR, MAC_CR_EEE_EN_,
> > mac_cr);
> 
> Is it possible to add a check to make sure TXEN and RXEN are disabled
> before updating the MAC. Is it taken care by phylink itself?

I suspect this is not true.

On link up, the order of calls that phylink makes is:

	pcs_link_up()
	mac_link_up()
	pcs_enable_eee()
	mac_enable_tx_lpi()

From what I can see, TXEN and RXEN are set by lan78xx_start_tx_path()
and lan78xx_start_rx_path(). These are called from lan78xx_open(),
which *might* happen way before the link comes up. Given the placement
of phy_start() (now phylink_start()) then the above sequence can happen
at *any* moment from that call to phy*_start() onwards, maybe midway
through these two functions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

