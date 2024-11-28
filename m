Return-Path: <netdev+bounces-147718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DB9DB653
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02E28110F
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0415E5CA;
	Thu, 28 Nov 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NaQ2XkF5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B158531
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792407; cv=none; b=arB0wsNk55Muq2TKydAS3ZSsB/LncJ47cZZ5vk8mVwe9weZ94QkgqU5t0om0ZPy5AJxETprhu/HKcSQLV/OCcL1qzqf13ObPWCkH5q6Miuz+EQfvRglzQoBP4EWhlCdE3PX3Q4vopui0CFhYKupx8Jhe1LLjlrT+ESl7oLRVWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792407; c=relaxed/simple;
	bh=EfDxn3wa4oPc2n3ROsh0C1qP0wN//eIh6SGuU1yaNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ibiZe8PJeVGEP3XmyeP92nDBiqArWtHv5jolzMz7NZERilFRxgTesBE01TEvY38fUaWHAm5Vo3+HCPhyKOiFnf7dbKXQWqhUJzJOhJENKU5T3FHk8IXFDIlgVKHaehmiy15UgwUY6zx9b0MuwezAAW2iH4ZboLUSFB4PSBu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NaQ2XkF5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YZzYJHFWOCvB53qVL1CMWFHtvZovTy2goym6l1eIshw=; b=NaQ2XkF5nVKsgG0VD2caLr7SVD
	tAUrefe9IHfRydu0hnMIV/Em66IFlQfN74QBRW2EWYrtawFDfdSf+4ZKwBde/LimObaWnuWK5/eFm
	U8Zn/lPLvheaEWvUtKvNv0BgaPJu3OINNSpkFTqiXtIWRMn95qHgdIbOLseS3H6YhkEE5MNFdrbCs
	J/RxJzur9MUGKRqKwIbVNjRPtjpnHuR//APtfy/BGunazpHt+vXff7n6UM5+rDs9QorskLrI9ndJF
	O4gZyeoNlhX0qEeh1NJJJXDK+LA3WwaTA6G4/BUrt+ztTQ8gmMrhGxUneGI7iwOyjHhebGyggPpg2
	jZxo9HPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tGcSJ-00025c-2F;
	Thu, 28 Nov 2024 11:13:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tGcSG-00086T-0r;
	Thu, 28 Nov 2024 11:13:04 +0000
Date: Thu, 28 Nov 2024 11:13:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
Message-ID: <Z0hQQONGxPM04EVl@shell.armlinux.org.uk>
References: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
 <bedf2521-dcbf-4b5b-8482-9436a54a614f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bedf2521-dcbf-4b5b-8482-9436a54a614f@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 28, 2024 at 09:44:37AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On 11/23/24 15:50, Russell King (Oracle) wrote:
> > When phy_ethtool_set_eee_noneg() detects a change in the LPI
> > parameters, it attempts to update phylib state and trigger the link
> > to cycle so the MAC sees the updated parameters.
> > 
> > However, in doing so, it sets phydev->enable_tx_lpi depending on
> > whether the EEE configuration allows the MAC to generate LPI without
> > taking into account the result of negotiation.
> > 
> > This can be demonstrated with a 1000base-T FD interface by:
> > 
> >  # ethtool --set-eee eno0 advertise 8   # cause EEE to be not negotiated
> >  # ethtool --set-eee eno0 tx-lpi off
> >  # ethtool --set-eee eno0 tx-lpi on
> > 
> > This results in being true, despite EEE not having been negotiated and:
> >  # ethtool --show-eee eno0
> > 	EEE status: enabled - inactive
> > 	Tx LPI: 250 (us)
> > 	Supported EEE link modes:  100baseT/Full
> > 	                           1000baseT/Full
> > 	Advertised EEE link modes:  100baseT/Full
> > 	                                         1000baseT/Full
> > 
> > Fix this by keeping track of whether EEE was negotiated via a new
> > eee_active member in struct phy_device, and include this state in
> > the decision whether phydev->enable_tx_lpi should be set.
> > 
> > Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> This patch did not apply net cleanly to net tree when it was submitted,
> due to its dependency. As a result it did not went through the CI tests.
> Currently there is little material there phy specific - mostly builds
> with different Kconfigs - but with time we hope to increase H/W coverage.
> 
> AFAICS this patch has no kconfig implication, so my local build should
> be a safe-enough test, but please wait for the pre-reqs being merged for
> future submissions.

I guess there's no way to tell the CI tests that another patch is
required? It would be useful if something like a message-id could
indicate to the CI tests that the patch in that message-id is
required.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

