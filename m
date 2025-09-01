Return-Path: <netdev+bounces-218706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE0B3DFB9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326FB1A803DA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A130E82D;
	Mon,  1 Sep 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E6h3BwFP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53162E0402
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721166; cv=none; b=rQ6CKbERNmk1R7uw+e9UbzKb6mJBDV9XWo1g8B3tRuO7YF3+YJxpIj7IyvYJUhv/EjWXjmOfMSl92IG8LAXrH+R0VZJnclzkSyjjTrzHniZSbHbCBo5y+L0O25Gef/a3oyDnlcfb85+OpvFxLdNLmWa3MK07gGCrc+UcdOQH35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721166; c=relaxed/simple;
	bh=xNtOD3U1Ets//MfQBdDrw8D9/+Y8XKoiAWD3u8Vu+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRuFsRDkx7hmqv34vzPYkRLB2m4E3y9fmbazZ2pgAycb/rinaqS98KJOf7EC24xct5pTaP+AVdBqqhyKnfIawvXgjQNEKwOKVGEjJQLhtTQTt/TmBzifM+ghL8kwpAKpRRJfm6euXogbB+E1aHTKC7gizeaVru1y1/QtSZ8+qiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E6h3BwFP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XX14nK70MLICWN1TU2yynkZ6LntdcPtCl9EB2sloICo=; b=E6h3BwFPRDE/wgThwj1DZK/FpB
	5//37F4F0XdSDlow5SqYGB/7v+vXfRm3B8xx1xtJxbKOCkp5caRuTI9cNm+9W2F5a5wKR0S9rGh73
	Pvl35uRsvPwfT2la26ieFTDQWpowR8CC7W56Ju/VObJIGbLeSnUQ8srdGymLqbCsquVerorf8c5GA
	4pIh7oQVO9A9rU6lUD2LtlBAoSQRV9KLtZ39kDoIlUhbPQWDpX/hUKpxsuLmqK1Sy7SdyOJRIuD3N
	T5vkvThAHqNh3t+bKttW4p7icoSlpQRCOEWcSvdgVg4+shllpF3rSCOZDStmDnn+qzFp0j+tMlbBQ
	Zg3A+Rfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ut1QC-000000005zC-1c9K;
	Mon, 01 Sep 2025 11:05:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ut1QA-000000006vT-2Pet;
	Mon, 01 Sep 2025 11:05:54 +0100
Date: Mon, 1 Sep 2025 11:05:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <aLVwAn87GhFHMjEE@shell.armlinux.org.uk>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
 <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
 <20250901093530.v5surl2wgpusedph@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901093530.v5surl2wgpusedph@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 01, 2025 at 12:35:30PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 01, 2025 at 10:09:17AM +0100, Russell King (Oracle) wrote:
> > On Mon, Sep 01, 2025 at 11:42:25AM +0300, Vladimir Oltean wrote:
> > > On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> > > > phydev->phy_link_change is initialised by phy_attach_direct(), and
> > > > overridden by phylink. This means that a never-connected PHY will
> > > > have phydev->phy_link_change set to NULL, which causes
> > > > phy_uses_state_machine() to return true. This is incorrect.
> > > 
> > > Another nitpick regarding phrasing here: the never-connected PHY doesn't
> > > _cause_ phy_uses_state_machine() to return true. It returns true _in
> > > spite_ of the PHY never being connected: the non-NULL quality of
> > > phydev->phy_link_change is not something that phy_uses_state_machine()
> > > tests for.
> > 
> > No. What I'm saying is that if phydev->phy_link_change is set to NULL,
> > _this_ causes phy_uses_state_machine() to return true and that
> > behaviour incorrect.
> > 
> > The first part is describing _when_ phydev->phy_link_change is set to
> > NULL.
> > 
> > It is not saying that a never-connected PHY directly causes
> > phy_uses_state_machine() to return true.
> > 
> > I think my phrasing of this is totally fine, even re-reading it now.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> I think the language is sufficiently flexible for us to find a phrasing
> that avoids all ambiguity. What about:
> 
> "It was assumed the only two valid values for phydev->phy_link_change
> are phy_link_change() and phylink_phy_change(), thus phy_uses_state_machine()
> was oversimplified to only compare with one of these values. There is a
> third possible value (NULL), meaning that the PHY is unconnected, and
> does not use the state machine. This logic misinterprets this case as
> phy_uses_state_machine() == true, but in reality it should return false."

Well, having spent considerable time writing and rewriting the damn
commit message, this is what I'm now using, which I think covers the
problem in sufficient detail.

>>>>>>
net: phy: fix phy_uses_state_machine()

The blamed commit changed the conditions which phylib uses to stop
and start the state machine in the suspend and resume paths, and
while improving it, has caused two issues.

The original code used this test:

        phydev->attached_dev && phydev->adjust_link

and if true, the paths would handle the PHY state machine. This test
evaluates true for normal drivers that are using phylib directly
while the PHY is attached to the network device, but false in all
other cases, which include the following cases:

- when the PHY has never been attached to a network device.
- when the PHY has been detached from a network device (as phy_detach()
   sets phydev->attached_dev to NULL, phy_disconnect() calls
   phy_detach() and additionally sets phydev->adjust_link NULL.)
- when phylink is using the driver (as phydev->adjust_link is NULL.)

Only the third case was incorrect, and the blamed commit attempted to
fix this by changing this test to (simplified for brevity, see
phy_uses_state_machine()):

        phydev->phy_link_change == phy_link_change ?
                phydev->attached_dev && phydev->adjust_link : true

However, this also incorrectly evaluates true in the first two cases.

Fix the first case by ensuring that phy_uses_state_machine() returns
false when phydev->phy_link_change is NULL.

Fix the second case by ensuring that phydev->phy_link_change is set to
NULL when phy_detach() is called.
<<<<<<

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

