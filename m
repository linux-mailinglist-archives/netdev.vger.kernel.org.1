Return-Path: <netdev+bounces-242467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92541C90878
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3483F3A9BBA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9D214812;
	Fri, 28 Nov 2025 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zqkhiRpQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E713C8E8;
	Fri, 28 Nov 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294485; cv=none; b=WxQTeZxjYvcfNbOPB+Ju3XcRf1IPuoQXm02FPkYfBT+MvNOf6KXcgikp9ENuTA++zwUDtcbOi+/UaGYgcFmb0V/B3y6+UVvF0MYJhzNqV+HtE7C2uK4jBKVD7sXboKvoWYuR3t630t1Zf9avtLMFoklpAxnQ0fPcO98JoHEYpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294485; c=relaxed/simple;
	bh=V6lI1JVwKXCMHmaUc0dB1+uWIjhd4RW2n3BkZ+0Frqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxyyKCbFiMCg8750pftaJPbXAuP8WjrE6+qKJj313/oNKwYfC1vL8Myx45EJklrtrVaYPXcgw8bJrqpBRLtQbFtLzPyRyyj9ySLzJUQa1xuRWrCtnrLHVieympQyVg55dCAQKZyZyVBUxCA5YyPMIkwEdKSioV0cchVIkqpWOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zqkhiRpQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pHLsiH1VFTtJlaUZdyhPXPu2r2R1hZjtg6HKAHrxOJo=; b=zqkhiRpQ2GycAt6XjhaGYNy37t
	Jdfwet9hMxPsP6nPFyVLKvkMepSdw8Mn7UfEIP6Wbd4RAtT27h23OdHgUFbfQeO2nr1efC11aS5md
	GJv3pSrR5RtQCXymfcbotpD+uKIkHkCmQNdxaOVWdmllbTOTXmI3Ib0FD00Hpe208QDFlZxeOpaw1
	PUtEMnkIwi+19De3es+496rMaN+TuF7IzYQrkUGcc6jVhOGld3DPvbRHUvriypz4EgMm2NctnaiJ/
	wb8R62HztRuq2PI7Neoxp9cjpNGn/Ga0PyaESo5etfOi9JEcWZsOhsXDywkgsLEZq73A/y+UwJFtZ
	13fpwu7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39806)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOnaI-000000005rJ-1avS;
	Fri, 28 Nov 2025 01:47:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOnaF-000000003C8-2ooc;
	Fri, 28 Nov 2025 01:47:39 +0000
Date: Fri, 28 Nov 2025 01:47:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 01:27:29AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 26, 2025 at 09:36:42AM +0100, Oleksij Rempel wrote:
> > My current understanding is that get_pauseparam() is mainly a
> > configuration API. It seems to be designed symmetric to
> > set_pauseparam(): it reports the requested policy (autoneg flag and
> > rx/tx pause), not the resolved MAC state.
> > 
> > In autoneg mode this means the user sees what we intend to advertise
> > or force, but not necessarily what the MAC actually ended up with
> > after resolution.
> > 
> > The ethtool userspace tool tries to fill this gap by showing
> > "RX negotiated" and "TX negotiated" fields, for example:
> > 
> >   Pause parameters for lan1:
> >     Autonegotiate:  on
> >     RX:             off
> >     TX:             off
> >     RX negotiated:  on
> >     TX negotiated:  on
> > 
> > As far as I can see, these "negotiated" values are not read from hardware or
> > kernel. They are guessed in userspace from the local and link partner
> > advertisements
> 
> They are not "guessed". IEEE 802.3 defines how the negotiation resolves
> to these, and ethtool implements that, just the same as how we resolve
> it in phylib.
> 
> Whether the MAC takes any notice of that or not is a MAC driver problem.
> 
> > , assuming that the kernel follows the same pause resolution
> > rules as ethtool does. If the kernel or hardware behaves differently, these
> > values can be wrong.
> 
> If it doesn't follow IEEE 802.3 resolution, then it's quite simply
> broken. IEEE 802.3 requires certain resolution methods from the
> negotiation in order for both link partners to inter-operate.
> 
> Don't make this more complex than it needs to be!

Also note that there is hardware out there which can't tell us "the
hardware enabled transmission of pause frames" and "the hardware will
respect received pause frames". One example is some of the Marvell
DSA switches which only have a single status bit. Whether that means
they only support symmetric pause, I'm not certain, the docs don't
say.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

