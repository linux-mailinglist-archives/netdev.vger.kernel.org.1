Return-Path: <netdev+bounces-218773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C7B3E6CD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AA93A4E12
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6D33473F;
	Mon,  1 Sep 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O/qQyl8b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E871804A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736099; cv=none; b=nHbFVO8NLBKNZNoL+fv+zLXXL73ocCDsCdlPgRr8nM9yBumv0ZdfdgvUgWb26iWKV95O+ShTVjtL2TcV0yD+ziAz9SVN4loy1Tk3Fw7ER+6rdJvz5y1UCL+M9SVGC8RZd2qXYUWQjWg8eOihl2FZLdO9EfPKal9fpe7sprQkbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736099; c=relaxed/simple;
	bh=WJd1d0ozqelvwBWSHYqQw6AXIUOmZm82i+1EiZVa6lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwucOs5QWw5izYk4ZUbkE957pXuloM3qlA0jonHlbIUmhDlpfDtu5m+fw2r6pSYf7Oo/oWgc+l/Xsl67gYnfqL1k9DF9rcZhCyI2LmG0y1YdF+B8IgfxroZ7BcjsJ16O/6NR1dsjCuKymccfAfKHbOqdECI27hWKKj4oTjNU5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O/qQyl8b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1H0uzd6F2YSADdaSftGj8QWFN4zX/cc6y8qh7y/LanA=; b=O/qQyl8bdest4WFrfD0J44yw7K
	+/GaurcUz6c0BGoY0JwYsROQ7KU60eLeA7b2k/ayHNfUSiUVVuKTlUCREqjtPiWN0im8mli3yogiS
	NstIGq/GLTp3rlyKWVhVNMMTRWyUfpdZbXCosuG3IRy3bIzsfcEg7Ac5muKCjSCX2tRflG1ccvP7F
	1RpJaJFksht9N17JGKRWPpIKTnUv8mONqTnyWZFI3DVm7JZ951e1N3jD4hA2ySA6WSF//qwf59/vm
	LONsq6OjkZwyxi9E/pkWNMSIRk94crC7kFKywrkczCuEo1P8AOqzRsuZT1YJUJRFZBpjlVWcHZyFw
	b5LveN6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53706)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ut5J5-000000006Lt-3LrV;
	Mon, 01 Sep 2025 15:14:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ut5J3-0000000075B-3Byf;
	Mon, 01 Sep 2025 15:14:49 +0100
Date: Mon, 1 Sep 2025 15:14:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <aLWqWeGvMM350dB2@shell.armlinux.org.uk>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
 <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
 <20250901093530.v5surl2wgpusedph@skbuf>
 <aLVwAn87GhFHMjEE@shell.armlinux.org.uk>
 <20250901103624.hv3vnkhjxvp2ep7r@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901103624.hv3vnkhjxvp2ep7r@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 01, 2025 at 01:36:24PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 01, 2025 at 11:05:54AM +0100, Russell King (Oracle) wrote:
> > Well, having spent considerable time writing and rewriting the damn
> > commit message, this is what I'm now using, which I think covers the
> > problem in sufficient detail.
> > 
> > >>>>>>
> > net: phy: fix phy_uses_state_machine()
> > 
> > The blamed commit changed the conditions which phylib uses to stop
> > and start the state machine in the suspend and resume paths, and
> > while improving it, has caused two issues.
> > 
> > The original code used this test:
> > 
> >         phydev->attached_dev && phydev->adjust_link
> > 
> > and if true, the paths would handle the PHY state machine. This test
> > evaluates true for normal drivers that are using phylib directly
> > while the PHY is attached to the network device, but false in all
> > other cases, which include the following cases:
> > 
> > - when the PHY has never been attached to a network device.
> > - when the PHY has been detached from a network device (as phy_detach()
> >    sets phydev->attached_dev to NULL, phy_disconnect() calls
> >    phy_detach() and additionally sets phydev->adjust_link NULL.)
> > - when phylink is using the driver (as phydev->adjust_link is NULL.)
> > 
> > Only the third case was incorrect, and the blamed commit attempted to
> > fix this by changing this test to (simplified for brevity, see
> > phy_uses_state_machine()):
> > 
> >         phydev->phy_link_change == phy_link_change ?
> >                 phydev->attached_dev && phydev->adjust_link : true
> > 
> > However, this also incorrectly evaluates true in the first two cases.
> > 
> > Fix the first case by ensuring that phy_uses_state_machine() returns
> > false when phydev->phy_link_change is NULL.
> > 
> > Fix the second case by ensuring that phydev->phy_link_change is set to
> > NULL when phy_detach() is called.
> > <<<<<<
> 
> The new explanation and the placement of the function pointer clearing
> make sense, thanks. Maybe add one last sentence at the end: "This covers
> both the phylink_bringup_phy() error path, as well as the normal
> phylink_disconnect_phy() path."

Is it really necessary to add that level of detail? phy_attach() sets
phydev->phy_link_change, so it's natural that phy_detach() should undo
that action, especially as phy_detach() is phy_attach()'s complement.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

