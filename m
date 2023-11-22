Return-Path: <netdev+bounces-50197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33777F4E60
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DE31C209E4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686155B5D1;
	Wed, 22 Nov 2023 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fBw6CDmp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC511F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D23WXbOODdzRIc/W/0yHlqOLuVRoofONjuWgATAJKnY=; b=fBw6CDmpreoauoEMykNXovHv9T
	khtTrwXVDTohw+FVifE4o1Kh4YX+3RYnZOhEOXUfK3ZkIeKToLPrPsD6chdNalaiVTSZqooflEDs2
	Mi+sDFvDCZrsDvUgKZjALDNcRLz228ThIbQ7YND4s2G6xWFoOufhEjdzyJv9fqhoaVbfqBDucUzhc
	jVSBuXSPFFdu2gmZ1RSBBufsmdyzArbVcUPhZgg8lw3SuleI2qQ/Uznc9jefaBXzLpXR7T3Phw8/o
	eJwzSrdLR1IGsIuKHzk5u62cBd043YeBMEMbiU7KZTSBOCpmR8k7L2AUCVhoqL9PK0AsmEEfOntfa
	mDlA7lew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47648)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5qzl-0000XK-0i;
	Wed, 22 Nov 2023 17:26:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5qzm-0005My-0v; Wed, 22 Nov 2023 17:26:38 +0000
Date: Wed, 22 Nov 2023 17:26:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/5] net: wangxun: add flow control support
Message-ID: <ZV45zcqA88rcNy7G@shell.armlinux.org.uk>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-2-jiawenwu@trustnetic.com>
 <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
 <ZV4ssdbQyxtYgURN@shell.armlinux.org.uk>
 <7b82a7a0-3882-4c6c-903e-1b43d8a7fc34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b82a7a0-3882-4c6c-903e-1b43d8a7fc34@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 22, 2023 at 06:24:22PM +0100, Andrew Lunn wrote:
> > However, if autoneg is supported, but pause autoneg is disabled, there
> > is still the need to update the PHY's advertisement so the remote end
> > knows what's going on, as documented in the user API:
> > 
> > " * If the link is autonegotiated, drivers should use
> >   * mii_advertise_flowctrl() or similar code to set the advertised
> >   * pause frame capabilities based on the @rx_pause and @tx_pause flags,
> >   * even if @autoneg is zero. ... "
> > 
> > You are correct that when !pause->autoneg, tx_pause/rx_pause are to be
> > used in place of the negotiated versions.
> > 
> > Also... when getting the pause parameters, tx_pause/rx_pause _should_
> > reflect what was set for these parameters via the set function, *not*
> > the current state affected by negotiation.
> 
> All good reasons to just use phylink which handles all this for you.

Indeed... consistent implementation and therefore behaviour (assuming
users of phylink are implemented correctly!) :)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

