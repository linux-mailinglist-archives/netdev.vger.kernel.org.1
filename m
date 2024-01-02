Return-Path: <netdev+bounces-60866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29018821B4F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF28FB21D9F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EEEAD7;
	Tue,  2 Jan 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dH9bTIgW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96326FBE7
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mj6gQvujRTMncV33YCEuODTiExck21D9xEZVwX4eDPU=; b=dH9bTIgWAUtnGIQvjTluc3f+0q
	B2aDj4q6QgP6NJJmy8ItywKX55plCCW1KPM4Nrfpf+hOTmCx2cQZswT9VSYyyE/+0u+8Ax+1aF3dL
	PEyM+O8fzav7/Gp4DkZnuv0tUk7FQirNJwa29v9XqXMBhZHHSmYMQBHxbQ2lcZu4TZ5c0PZWFXIVR
	v7dftK8Yw8mSBnn9I1IJZTVxGyVQxNHbhg3dA/CnPOKx+qdGAmkb+yd+IDDEqRerG31M1kYpYihDs
	MSTAM3lfOYmdmV1I0+FK5cXQF9g0EAu0c1Kd6boZSzZhnyx6EIbqT1xfimDcPyxSMQw2RcX+E31Fz
	SRQiU0+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKdTD-0006Vr-18;
	Tue, 02 Jan 2024 12:02:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKdTF-0005Gc-8T; Tue, 02 Jan 2024 12:02:09 +0000
Date: Tue, 2 Jan 2024 12:02:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ezra@synergy-village.org, Andrew Lunn <andrew@lunn.ch>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <ZZP7QQqScrq6JDg6@shell.armlinux.org.uk>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 01, 2024 at 11:44:38PM +0100, Heiner Kallweit wrote:
> On 01.01.2024 22:31, Ezra Buehler wrote:
> > Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
> > capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
> > Gateway will no longer boot.
> > 
> > Prior to the mentioned change, probe_capabilities would be set to
> > MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
> > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > least with our setup) considerably slow down kernel startup and
> > ultimately result in a board reset.
> > 
> > AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
> > "Clause 45 protection" feature (e.g. LAN8830) and others like the
> > LAN8804 will explicitly state the following in the datasheet:
> > 
> >     This device may respond to Clause 45 accesses and so must not be
> >     mixed with Clause 45 devices on the same MDIO bus.
> > 
> 
> I'm not convinced that some heuristic based on vendors is a
> sustainable approach. Also I'd like to avoid (as far as possible)
> that core code includes vendor driver headers. Maybe we could use
> a new PHY driver flag. Approaches I could think of:
> 
> Approach 1:
> Add a PHY driver flag to state: PHY is not c45-access-safe
> Then c45 scanning would be omitted if at least one c22 PHY
> with this flag was found.
> 
> Approach 2:
> Add a PHY driver flag to state: PHY is c45-access-safe
> Then c45 scanning would only be done if all found c22 devices

Anything based on PHY driver flags isn't going to work - the scan
happens _before_ we know what is on the bus and _before_ we have
any devices to even think about probing drivers (which could even
be in a module on a filesystem that has yet to be mounted.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

