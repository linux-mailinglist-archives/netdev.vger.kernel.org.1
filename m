Return-Path: <netdev+bounces-218666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5CB3DDAD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33B18942D3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92A304BC4;
	Mon,  1 Sep 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RsrJFg+K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6A307482
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717775; cv=none; b=ImH4q/QAN0P7kFZFn+26DcMhVUaVTvItcjrdoYNxUu2ZwjdA6jJcZHlbyjKtj5JmVohJp2QypX4JcIXbXC0VgDSsgjFBZKOxYVjPKjNXutuiZz0iVPyxyGBasgN9aouQMECIdYz6TgZE574Z0vhUjIlMqQqb/hF5UQNe2r8wVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717775; c=relaxed/simple;
	bh=I5b8D0GdAZMDVlDz0GQJl8d0IIpFPKyALN5Gl4CLH/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmN3njncTPZX3AAJvftYtZd3PI/61fAToYRpTVIBotjVAfJ7ej6ayO+ErUhmQX2BsHW6g0k1le6LVnokUm5vR0e8PnSlTH7CFCyKmYhHXwLM0HrpvZowdvoWClnWpMCarCR7NC06weg+zcgWY33CMFufc0aNIW6EiId+Ieqj6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RsrJFg+K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4EoKJaje4rOK95X+Pl3q/RbauYYMDscRw8oP35k7rJk=; b=RsrJFg+KnbSa0ouMj3A3t3JrrO
	qz0ygsCounR6YdLhQ23jfcl7Tiu3i9Hxz2PQwC8ahDMlRzkwdBIcKCzjX51SyYCHwfr1GLE5xNFHU
	KpyMgyNGXTvPrN5hyLEHQ2G+4V2Deh7ae4nlLSnpCscshVwU9BmhORS/Z8nFuplNbPsBhi3uDqtZY
	yFNeR+2rB1r0wu2oSHl7w2Ukcm6HawZKDK4gWwC/ZcrMTV6kf+p6v3Uycu8Gul4dEw5SGJDrDeGo5
	rtC1c4cgRbm1/sTWo2SpeCG12c+0E/Fj2Q6EyGZcrIGdStqBIJMPpTbixZ+GN2CfOokc3lZH54dx1
	FwCseCKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ut0XV-000000005st-24Ao;
	Mon, 01 Sep 2025 10:09:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ut0XO-000000006tL-0yL7;
	Mon, 01 Sep 2025 10:09:18 +0100
Date: Mon, 1 Sep 2025 10:09:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901084225.pmkcmn3xa7fngxvp@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 01, 2025 at 11:42:25AM +0300, Vladimir Oltean wrote:
> On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> > phydev->phy_link_change is initialised by phy_attach_direct(), and
> > overridden by phylink. This means that a never-connected PHY will
> > have phydev->phy_link_change set to NULL, which causes
> > phy_uses_state_machine() to return true. This is incorrect.
> 
> Another nitpick regarding phrasing here: the never-connected PHY doesn't
> _cause_ phy_uses_state_machine() to return true. It returns true _in
> spite_ of the PHY never being connected: the non-NULL quality of
> phydev->phy_link_change is not something that phy_uses_state_machine()
> tests for.

No. What I'm saying is that if phydev->phy_link_change is set to NULL,
_this_ causes phy_uses_state_machine() to return true and that
behaviour incorrect.

The first part is describing _when_ phydev->phy_link_change is set to
NULL.

It is not saying that a never-connected PHY directly causes
phy_uses_state_machine() to return true.

I think my phrasing of this is totally fine, even re-reading it now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

