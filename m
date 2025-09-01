Return-Path: <netdev+bounces-218710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868DB3E00A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9474D1A80A19
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E330E82D;
	Mon,  1 Sep 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EOEQiQOY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057B30DD25
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722242; cv=none; b=UHXqzKg7+0AqAR0q/QzTz+GMV0XM5rIYmNydt71tsNBY+QoSSgC/Rpx9EHPqD2PMAObpwi3XUYlnbC9SGPgtqsm+moZJjGv1zkhMuYXYZ2/AKFuWYyyCOBbvjE+73OA61f9n7BErqGF8/D+c+mWW66KDvgA8eLqAmbM0GjW9tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722242; c=relaxed/simple;
	bh=5Sw3YkRkd+8vOolLDFe5X4X5cXLxpTE2YJJm3+WRbik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4zTcLTJne/j220ljPfmWSRZz38GHdUBVCB1xaH28yBZwH9HiHSzBD4o9heFt6+MvpY1yTjPQp0HWWvTHI04HfZxmWIudidO9uY5WrB08pBjAyiihvdhkyH1rS9KJ9J4miS672jbKoVak92R45FJbRaVsdJ4fErlbGQMPR2wkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EOEQiQOY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kVHXJ5zZGDcf2/VHRzAUB2oD1nL+9kIhLTLOLsWJN2g=; b=EOEQiQOYKtPdmtEhtCK1DuTSua
	my9RR00EMxhI2artSKx/7oD/alzmR/clzLMbj/QBkqN11V12XlOaGcFMzjCXFS8fmXTdHfuoi+oR0
	q/pi6ovAUbn00hcH4OBQDddBMcz55Nd4ActkdtIt8FMpgW3qX9ED9drfYDRqIeaxA/V0sDhr5bdFs
	rXuF6cjVhbG4C4nf9KN0FR8VtxgwveRk3BqSTqlIlJmbZPv3amq8yNZAXch1Wq7XP4Qz0k1/0kmm8
	6MeW93QBw5bL/hnzxpef+Sdd8jjKn+WhN1zmvo++ADgEbvNGjpSOCftUU6tNExrwoAWlFmgvoEK5X
	bqdDKFoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ut1hV-0000000060w-27dx;
	Mon, 01 Sep 2025 11:23:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ut1hT-000000006wb-11ER;
	Mon, 01 Sep 2025 11:23:47 +0100
Date: Mon, 1 Sep 2025 11:23:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <aLV0M2EiAnaxTxt2@shell.armlinux.org.uk>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <aLVosUZtXftPC-OY@shell.armlinux.org.uk>
 <20250901093957.qfqnpqme7fms2tbv@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901093957.qfqnpqme7fms2tbv@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 01, 2025 at 12:39:57PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 01, 2025 at 10:34:41AM +0100, Russell King (Oracle) wrote:
> > On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> > > phy_uses_state_machine() is called from the resume path (see
> > > mdio_bus_phy_resume()) which will be called for all devices whether
> > > they are connected to a network device or not.
> > > 
> > > phydev->phy_link_change is initialised by phy_attach_direct(), and
> > > overridden by phylink. This means that a never-connected PHY will
> > > have phydev->phy_link_change set to NULL, which causes
> > > phy_uses_state_machine() to return true. This is incorrect.
> > > 
> > > Fix the case where phydev->phy_link_change is NULL.
> > > 
> > > Reported-by: Xu Yang <xu.yang_2@nxp.com>
> > > Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
> > > Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > > The provided Link: rather than Closes: is because there were two issues
> > > identified in that thread, and this patch only addresses one of them.
> > > Therefore, it is not correct to mark that issue closed.
> > > 
> > > Xu Yang reported this fixed the problem for him, and it is an oversight
> > > in the phy_uses_state_machine() test.
> > 
> > While looking at this after Vladimir's comments, I've realised that
> > phy_uses_state_machine() will also return true when a PHY has been
> > attached and detached by phylink - phydev->phy_link_change remains
> > set to phylink_phy_change after it has been detached. So, there will
> > definitely be a v2 for this.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Good point. Do you plan to modify phy_disconnect() to set
> phydev->phy_link_change = NULL?

No, I've put it in phy_detach() because this sequence:

	phy_attach_direct()
	phylink_bringup_phy()
		phydev->phy_link_change set
		error occurs
	phy_detach()

would result in phydev->phy_link_change remaining set if it was
only cleared in phy_disconnect().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

