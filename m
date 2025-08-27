Return-Path: <netdev+bounces-217446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B237B38B9C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5B7AFD2B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4269530C623;
	Wed, 27 Aug 2025 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RMJIyHlR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D82C2376
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331215; cv=none; b=q3aELrWxy/W87tHY5ddo0BIQsWwpZ92X9/5eh5qOC+2ytlU9kW5OKcwqzy1+lhZR3z7AayhO1SzUmo7UyY//34zXF6A0TjxxuXV/lW8xW+1l3hd5YbgeGGaU9zET3nAd2u25FbuFY4YNDg6sN36XlCDMegYsbm2NW99P1GYXROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331215; c=relaxed/simple;
	bh=k/uNDM0VZ7cVD/H4BnixGgp05PyR3gl+rvKddJoRrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXxPhlA78lpcCMLsJBjnjRilK5ls7PQ8zPYQzKOkg22G9R9zYNBm6XANTB2WVz2VlktTAAcyjYsqBrRrxHgEz1vR+oP11qr2tU1rGBdwMQIGjEoGcaE+xUGx+2C+PTgACFqbzA8gncdAj8vdMkqMSIpn0JJvUUQh799t6JwV3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RMJIyHlR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QjxgYo5bPuI1cXmlU0LMgzx9/EyRgxvkSnzTkHR89zU=; b=RMJIyHlRIIrUbDoUAMylDR1PVQ
	LDdOdjf2i0qt4LQ3Da8+8MEXKgefrse+y9HTS8J7PdEhkVC0rubUgFwDUoGHH5wIqUK4f99+QscE6
	8bqBv1rOnGRIE5iV9LHG0tX7DqTCxsOLJeEek9KrwigtbYt8wh4GzGintbwGWBLgn2aneQCKSCm6M
	2SIcTsUZXkeMOEhIujChD/SDe8fGui8uDxiF4oclvozJr9lX2nlELZtlvRgypDsklO2lcE9hkxoTp
	u4LkiRVbym5rgKwZmUsq2uEkcmUC6voDJ7Bun+jAN9pnE1r5G7GZtFuzh0nWNSmv15naHcUFoxqRt
	NCqNhYcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urNyh-000000000yL-3Yp2;
	Wed, 27 Aug 2025 22:46:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urNyg-000000002Wd-3BfX;
	Wed, 27 Aug 2025 22:46:46 +0100
Date: Wed, 27 Aug 2025 22:46:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
Message-ID: <aK98xjr5bNDpSFtI@shell.armlinux.org.uk>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
 <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
 <78b5c985-9d48-4383-af34-1f8b09d0243d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b5c985-9d48-4383-af34-1f8b09d0243d@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 11:29:43PM +0200, Heiner Kallweit wrote:
> On 8/27/2025 11:09 PM, Russell King (Oracle) wrote:
> > On Wed, Aug 27, 2025 at 11:02:55PM +0200, Heiner Kallweit wrote:
> >> Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
> >> Easiest fix is to call fixed_phy_del() for each possible phy address.
> >> This may consume a few cpu cycles more, but is much easier to read.
> >>
> >> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> > 
> > Here's a question that should be considered as well. Do we still need
> > to keep the link-gpios for fixed-phy?
> > 
> > $ grep -r link-gpios arch/*/boot/dts/
> > arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 2
> > arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 3
> > 
> > These are used with the mv88e6xxx DSA switch, and DSA being fully
> > converted to phylink, means that fixed-phy isn't used for these
> > link-gpios properties, and hasn't been for some time.
> > 
> Means we can remove all "fixed-link" blocks from vf610-zii-dev-rev-b.dts?

phylink has support for it (because phylink needed to be 100%
compatible to avoid regressions!) Thus, there's no need to remove it,
nor drop it from the DT bindings.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

