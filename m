Return-Path: <netdev+bounces-177812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5299A71DF3
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278C43B0C26
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB624E001;
	Wed, 26 Mar 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wi1rPvAf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8524DFEC;
	Wed, 26 Mar 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012150; cv=none; b=NvOt7x14146JlVs9006IgjLedDLVJs0GqDulM6nlTnt3dLCGWqaMCgB501yjRBLuiKFxM6NX2pL4y+eSmG9/IDMV7GLF8Z8jh9yrxjZ2+P6oOgn/h4/wEP5lBQUGVa7+f39MsM6T+9W8ZxG7VzKg6fqHZjS2SiCerlA7rrdyj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012150; c=relaxed/simple;
	bh=RhuNbGaP4hTzjjx1FURD/5AKxX7bFuR492ohfbODc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvU+D6jxyTBP5YunFufeFwJ/0RZH0EZpOU+P9YZV222DfIlRkB9g1EsrjrWiuIzKVEPb+I+KNE80QYPn3K34G8hDfyNdXU8vH0uvK+ox0GtUvUT475Q3NkFxy5CRmspbbrikmBttIgcOTeZtywLAXRl4n81k7u6lt3v7ulI7uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Wi1rPvAf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o5J0QNqSSAC9ykc4TNP4ChNUEJr5RFdpsbJKSino8Xg=; b=Wi1rPvAfBMebX2u+gER9qnurCD
	vqil77x3IHbiFGyalK1aoCoIIgDWbinoLJBN837vbPwNGhoFuSgw+U0x3ROxMFtX3mmRnscWFWtGY
	uckbbOaYZmSoG6RI4Ek65nncEN1H1u2rbqEBWE8miJmIf15tNQ2moXsfXl/E0WVWwtpWLgdZphL+Y
	3B3fM53f0thtbgv68P4YkFw6HsB+JPdElspevaY6VjGpMWrj6ZIhHHNhnTqDgJmtRcYRKXuN1plzy
	h8Hgqxza4jsRihNl+V3yuSl+RuiVX4z+4SsXsaDK6bpWzWJAZ2vsscpFl6EKOrBep4eXSV+Wl/ouK
	OZ7lT5iw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45352)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txV4v-0006QK-00;
	Wed, 26 Mar 2025 18:02:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txV4r-0004c0-0o;
	Wed, 26 Mar 2025 18:02:09 +0000
Date: Wed, 26 Mar 2025 18:02:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z-RBIZSdySXhQzra@shell.armlinux.org.uk>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>
 <67e412a5.5d0a0220.28146a.e91b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e412a5.5d0a0220.28146a.e91b@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 26, 2025 at 03:43:47PM +0100, Christian Marangi wrote:
> On Wed, Mar 26, 2025 at 01:53:39PM +0000, Russell King (Oracle) wrote:
> > This probe function allocates devres resources that wil lbe freed when
> > it returns through the unbinding in patch 1. This is a recipe for
> > confusion - struct as21xxx_priv must never be used from any of the
> > "real" driver.
> > 
> > I would suggest:
> > 
> > 1. document that devres resources will not be preserved when
> >    phydev->needs_reregister is set true.
> > 
> > 2. rename struct as21xxx_priv to struct as21xxx_fw_load_priv to make
> >    it clear that it's for firmware loading.
> > 
> > 3. use a prefix that uniquely identifies those functions that can only
> >    be called with this structure populated.
> > 
> > 4. set phydev->priv to NULL at the end of this probe function to ensure
> >    no one dereferences the free'd pointer in a "real" driver, which
> >    could lead to use-after-free errors.
> > 
> > In summary, I really don't like this approach - it feels too much of a
> > hack, _and_ introduces the potential for drivers that makes use of this
> > to get stuff really very wrong. In my opinion that's not a model that
> > we should add to the kernel.
> > 
> > I'll say again - why can't the PHY firmware be loaded by board firmware.
> > You've been silent on my feedback on this point. Given that you're
> > ignoring me... for this patch series...
> > 
> > Hard NAK.
> > 
> > until you start responding to my review comments.
> >
> 
> No I wasn't ignoring you, the description in v1 for this was very
> generic and confusing so the idea was to post a real implementation so
> we could discuss on the code in practice... My comments were done before
> checking how phy_registration worked so they were only ideas (the
> implementation changed a lot from what was my idea) Sorry if I gave this
> impression while I was answering only to Andrew...
> 
> The problem of PHY firmware loaded by board firmware is that we
> introduce lots of assumption on the table. Also doesn't that goes
> against the idea that the kernel should not assume stuff set by the
> bootloader (if they can be reset and are not part of the core system?)
> 
> From what I'm seeing on devices that have this, SPI is never mounted and
> bootloader doesn't provide support for this and the thing is loaded only
> by the OS in a crap way.
> 
> Also the PHY doesn't keep the FW with an hardware reset and permit the
> kernel to load an updated (probably fixed) firmware is only beneficial.
> (there is plan to upstream firmware to linux-firmware)
> 
> I agree that the approach of declaring a "generic" PHY entry and "abuse"
> the probe function is an HACK, but I also feel using match_phy_device
> doesn't solve the problem.
> 
> Correct me if I'm wrong but match_phy_device will only give true or
> false, it won't solve the problem of the PHY changing after the FW is
> loaded.
> 
> This current approach permit to provide to the user the exact new OPs of
> the PHY detected after FW is loaded.
> 
> Is it really that bad to introduce the idea that a PHY family require
> some initial tuneup before it can correctly identified?

It's fragile, really fragile.

phy_device_register() can complete before the module loads, and thus
setting the flag has no effect.

Try building the PHY driver as a module with the code that registers
the PHY built-in...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

