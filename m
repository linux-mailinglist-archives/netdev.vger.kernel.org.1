Return-Path: <netdev+bounces-145019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705EB9C91BA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C894B2CDB5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462918CBF8;
	Thu, 14 Nov 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jZ/ZyQLp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB91714B4;
	Thu, 14 Nov 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609196; cv=none; b=c2DpMzp5U6/Lof7fGQUURik/MkUOvg/dQaSAHhJlnKcnf9VXVeYuXsvdfW+285sUZYwGYNMrly9g9nZbNTxlpvOYY61pXotNpGKJ+5TVDsdRKsWjtrWwFXmqEJ75FbNskcPCKOCBePlEcNvXaHTf6TtpCvLGtzVd8U3hVHbXGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609196; c=relaxed/simple;
	bh=eG2qmjWNcxUCAG5MDlFmfLnO1Mw2SxC7yXRvuaEBYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWdTY0ZJ9C2ykw0i4MQEv+MXWNoTXPq/Jg/Rg9A7tfbSB6BMCgkIYr+smC/BOFwbrYFvG9uHKCS4mxQKUob039ZeEfpIhf5wTNsrS5ZWLdef8I9nYFB0Ya+DKsDRK0bnz6Ju1VP+JuyMHgCpVdT44dHHmCmhqOu4llTW9SuDWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jZ/ZyQLp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JtKnks9DzDC3hPxhz35TtP4N/YQTUQpjlTCfulkDlaE=; b=jZ/ZyQLpy5y5yGP+Y/QjdP4zgz
	kXn9YAQjxGCOnQsRnCnpUB/j+XrSVnvIe0+1fhrRbqdFXoTEezZTLVf26YnLS/AqxSJ2g4J6KvpkK
	dy5WSFUBjRKzSed+iN6Nd/JKL75ou7t84+a2uvw57LcrcCPxyzfmdc6lWDYFNSg/CPjgsYvzpNvsg
	a2z9dRgEH+JkCrbJ2P5MIlvtDi3j1Yun0uP+dMWerw2WLeOMj9U+i5oEkhgxVBA6z/loJhshC3YCR
	PTM242qtRlduHwgO8diZlGIwafFQCYqkNcRAuDx9iMuIfm1qmJ0r+Bhedyt+K6EfKVH0BJ77hP4c/
	YzPfxsTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46176)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBeeN-00005k-1E;
	Thu, 14 Nov 2024 18:33:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBeeK-0001Ij-2B;
	Thu, 14 Nov 2024 18:33:00 +0000
Date: Thu, 14 Nov 2024 18:33:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <ZzZCXMFRP5ulI1AD@shell.armlinux.org.uk>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
 <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 14, 2024 at 06:38:13PM +0100, Andrew Lunn wrote:
> > [   64.738270] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
> > [   64.769731] sfp sfp: sfp_add_phy failed: -EINVAL
> > 
> > Of course, there may be other reasons due to which phydev->supported is
> > empty, thus the use of the word "maybe", but I think the lack of a
> > driver would be the most common.
> 
> I think this is useful.
> 
> I only have a minor nitpick, maybe in the commit message mention which
> PHY drivers are typically used by SFPs, to point somebody who gets
> this message in the right direction. The Marvell driver is one. at803x
> i think is also used. Are then any others?

bcm84881 too. Not sure about at803x - the only SFP I know that uses
that PHY doesn't make the PHY available to the host.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

