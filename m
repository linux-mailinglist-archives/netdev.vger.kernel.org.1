Return-Path: <netdev+bounces-151858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D39F15BC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99807164714
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6B1E3DE6;
	Fri, 13 Dec 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uG2jIy/F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB817E8F7;
	Fri, 13 Dec 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117720; cv=none; b=KbMNiUXpIQqHnhGgeXzYb5Lp3ZJVYFnZQFPVYjgSQlR7TxU8XYepGDJRe0IuZHo8U2JXD+Q2QS5yEI9Qw0Iw2RNJRJWsGnH12MSGSpaJTPZtpj5Hc+wykLfUz2w1wb+esHeCApEqAZhB8Kpb1D3O+6nS094LiKDSxKNCC0udnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117720; c=relaxed/simple;
	bh=rN7GGJajpeFdP/bs+YUi/+ybh91t28PjIpnoq2jS+1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlcjtpkQWhn4UO6IvqeCkWyJCHaf0dR9GN8RD/b7sBEZHvyTay/XUfwJJve/e+e/Euw5tu+AH6bbmt5Rc2hlnzeVTwX3Xi2t9GizXgVc/FHjqtWlLL1PwjaU/h8cTMukh8T8VB7T/lpbuqS9wVVYsvkoY8Q7oAS9zbhhuU9VL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uG2jIy/F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YqNLrqv94sPI27T0I4ULQ9Lnh8jweJTywCoEGauSK/w=; b=uG2jIy/FH0VmQoAg0RISmoKUnb
	gbHYMYIaaU3K+zaGbslKBLBbZueOEWX2kWQZOzyOVGVE4oYIhjlg0lss+bo2erNZzLyQJnMb6cYlU
	dAJyEGOw6t7MezbbvaCuFzoCMOdiYnJ7fWULj4y9tTxJ+eAJvz0+PA71PZFAd4vwODCVxsg5hMzrC
	Y8IvLpiMUKUvyvgMeOGmNXDTQax96k8ly0At59PXwRX2yU3tnRdH5Xz8NGAxK9PeVrNqokpmX3sXX
	StjLJAe8nIPmJC4K4vpgba7N1hxqzudgZWqV3gw1RowjXLich0fgJldBuyaKYAqXPNARUiapWk6k4
	ljWeS0cA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tMBEO-0007C4-1H;
	Fri, 13 Dec 2024 19:21:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tMBEI-0006Xk-2p;
	Fri, 13 Dec 2024 19:21:38 +0000
Date: Fri, 13 Dec 2024 19:21:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
 <20241213090526.71516-3-maxime.chevallier@bootlin.com>
 <Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
 <20241213182904.55eb2504@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213182904.55eb2504@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 06:29:04PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On Fri, 13 Dec 2024 12:22:45 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Fri, Dec 13, 2024 at 10:05:25AM +0100, Maxime Chevallier wrote:
> > > On Socfpga, the dwmac controller uses a variation of the Lynx PCS to get
> > > additional support for SGMII and 1000BaseX. The switch between these
> > > modes may occur at runtime (e.g. when the interface is wired to an SFP
> > > cage). In such case, phylink will validate the newly selected interface
> > > between the MAC and SFP based on the internal "supported_interfaces"
> > > field.
> > > 
> > > For now in stmmac, this field is populated based on :
> > >  - The interface specified in firmware (DT)
> > >  - The interfaces supported by XPCS, when XPCS is in use.
> > > 
> > > In our case, the PCS in Lynx and not XPCS.
> > > 
> > > This commit makes so that the .pcs_init() implementation of
> > > dwmac-socfpga populates the supported_interface when the Lynx PCS was
> > > successfully initialized.  
> > 
> > I think it would also be worth adding this to Lynx, so phylink also
> > gets to know (via its validation) which PHY interface modes the PCS
> > can support.
> > 
> > However, maybe at this point we need to introduce an interface bitmap
> > into struct phylink_pcs so that these kinds of checks can be done in
> > phylink itself when it has the PCS, and it would also mean that stmmac
> > could do something like:
> > 
> > 	struct phylink_pcs *pcs;
> > 
> > 	if (priv->hw->xpcs)
> > 		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
> > 	else
> > 		pcs = priv->hw->phylink_pcs;
> > 
> > 	if (pcs)
> > 		phy_interface_or(priv->phylink_config.supported_interfaces,
> > 				 priv->phylink_config.supported_interfaces,
> > 				 pcs->supported_interfaces);
> > 
> > and not have to worry about this from individual PCS or platform code.
> 
> I like the idea, I will give it a go and send a series for that if
> that's ok :)

I've actually already created that series!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

