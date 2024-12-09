Return-Path: <netdev+bounces-150361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4C9E9EBF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62276167EDF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A81990DE;
	Mon,  9 Dec 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nh3ZDZYT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2B14E2CC
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770772; cv=none; b=X+E0ReHEaGvkZtcit4ZHknKbezAdzCnp1anpZGPvIlz3L+wGbHSfESaj4nPOI1VrnOqhslHo2DDXhMCFO88xFPHtJel+2XbsPqG1+u70+jf6MEHxjgEwni0ZFfKepfk7tallDp1ieH7no/OKLKx1RHJ+s9nrDs2lXN+YupF0/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770772; c=relaxed/simple;
	bh=WXe0g6vmvgiWu0ukPpvOiJqEw1stZO4xpza1UicgdGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTZIdHRrXoPz6baIe3LA+eRRt+ArquqDNDU3gs056MeBKCrgmoLd1HYtr1CZ9N+l2w7WT71IqxdUlPwM5OjpQuvylES1gF6Iu/cvnZD1ohM2TXMpSrfRfPm+mRBfbjzDJsaZVsFW6fjViZvU3P5FRITWTGwKz95e6Spy9gY3f3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nh3ZDZYT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YZTwHXbOybt2kub5e/AVd9Csc13PRoI7i1xmuUs3oSQ=; b=Nh3ZDZYTP+Y3hqCLmmOEdCnXRc
	/3Ik+h242LyRQoPGQ6ZEFknvLthpdA5PyNljgOleilWHEfVO4Nx7r9cMXpsQEDHCMvsPLCy0lYoH7
	C4DITHWcmiB7hdkmQ/aSz7ZoXC6dXKc7+dshwLzR2FK35WxnfchojIpZsljD12lBxYvcO5Si9R6H3
	Dk2Lrosh2bAEcaJxavI/vgrDtMyH5+uhnzJmL4egSiuv1PNp+dxVv1pdVNrMf1+fnqS3FPAvw9vw0
	tkxZEyGTNh2Y+gO8ye8a/xLPHK3DEXcIscp2XFyE/6gGJSsSKRK2xsARpmikQOTXaHs7LJabqBit3
	SQ+Xomqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59710)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKiyY-0001Gr-1X;
	Mon, 09 Dec 2024 18:59:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKiyW-0002By-0u;
	Mon, 09 Dec 2024 18:59:20 +0000
Date: Mon, 9 Dec 2024 18:59:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 00/10] net: add phylink managed EEE support
Message-ID: <Z1c-CL5KuwnAeW4G@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <67573861.050a0220.bef7c.e26e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67573861.050a0220.bef7c.e26e@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 09, 2024 at 07:35:11PM +0100, Christian Marangi wrote:
> On Mon, Dec 09, 2024 at 02:22:31PM +0000, Russell King (Oracle) wrote:
> > Hi,
> > 
> > Adding managed EEE support to phylink has been on the cards ever since
> > the idea in phylib was mooted. This overly large series attempts to do
> > so. I've included all the patches as it's important to get the driver
> > patches out there.
> > 
> > Patch 1 adds a definition for the clock stop capable bit in the PCS
> > MMD status register.
> > 
> > Patch 2 adds a phylib API to query whether the PHY allows the transmit
> > xMII clock to be stopped while in LPI mode. This capability is for MAC
> > drivers to save power when LPI is active, to allow them to stop their
> > transmit clock.
> > 
> > Patch 3 adds another phylib API to configure whether the receive xMII
> > clock may be disabled by the PHY. We do have an existing API,
> > phy_init_eee(), but... it only allows the control bit to be set which
> > is weird - what if a boot firmware or previous kernel has set this bit
> > and we want it clear?
> > 
> > Patch 4 starts on the phylink parts of this, extracting from
> > phylink_resolve() the detection of link-up. (Yes, okay, I could've
> > dropped this patch, but with 23 patches, it's not going to make that
> > much difference.)
> > 
> > Patch 5 adds phylink managed EEE support. Two new MAC APIs are added,
> > to enable and disable LPI. The enable method is passed the LPI timer
> > setting which it is expected to program into the hardware, and also a
> > flag ehther the transmit clock should be stopped.
> > 
> >  *** There are open questions here. Eagle eyed reviewers will notice
> >    pl->config->lpi_interfaces. There are MACs out there which only
> >    support LPI signalling on a subset of their interface types. Phylib
> >    doesn't understand this. I'm handling this at the moment by simply
> >    not activating LPI at the MAC, but that leads to ethtool --show-eee
> >    suggesting that EEE is active when it isn't.
> >  *** Should we pass the phy_interface_t to these functions?
> 
> Maybe only to validate?

validate doesn't know what interface will be used - at set_eee() time
we can't know that.

> >  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
> >    support the interface mode?
> 
> I'm a bit confused by this... Following principle with other OPs
> shouldn't this never happen? Supported interface are validated by
> capabilities hence mac_enable_tx_lpi() should never be reached (if not
> supported). Or I'm missing something by this idea?

This question was asked in the RFC, and before I added lpi_interfaces
which now prevents calling this unless the interface bit is set in
lpi_interfaces. However, does it still make sense to pass the
interface in case e.g. the MAC block that needs to be configured is
dependent on it?

Some network interfaces are made up of multiple MACs for different
speeds, and the MAC is selected by interface. E.g. mvpp2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

