Return-Path: <netdev+bounces-225689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF8B96DF4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD174859CB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C62765E2;
	Tue, 23 Sep 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpAkmH3B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E72727FD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645984; cv=none; b=jmmh9eglgtKkLtfRFkmKFAMgUoznMtVW7NYoUWZztzAs7c453cWcFaPYuXJPM/82MVp0HJfkpZ+P7jpncOh5jG3zBtyxYmA+4mWpVdIcbQ7nNyJSKKUQQdlZGbpGMzV2uir5SUTQYr+Fedp/WR+hJR2iITayV4XDA2ga4m56uw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645984; c=relaxed/simple;
	bh=uPxE2Gjwrase54VfFzFUB65rsLHVA18L16wqIPO/LDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1aqMKITcwJ63IJk5VLAA0cIoUZgqP0Z8Kx2WCe39TsRZleZdWSjmflYzVX9HwJsqkGIg1axabGYr/2prtoJTgimzFDYk9M8dA+Z42CGVwg0mxxO9+t0cxwvS51/cVzMp2LNAe6N2yEI5drLiK0LW9R49Axb8UFIB3Wt71gg7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpAkmH3B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KRNJM4cDVWAVyxUB/yXh+GU1nShKk8wh+0uPbfOZ8bw=; b=hpAkmH3Bgp3e98ZgoCOqkq+7R+
	vwxLOQrUOtsnUhX8AShpNno3oSDPAqRILIgi2NWXoP7bfPU1JTVrFy50Jzln8zjD3uBmaGM7/n9vo
	Mx/bfFi872WdR8Gen/eQs5+0fOgtkr9vIBi1D7fiANiTa2/3zSgOKXMnxbi/FgJv6vLo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v169Y-009HZ9-0I; Tue, 23 Sep 2025 18:46:08 +0200
Date: Tue, 23 Sep 2025 18:46:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm5481x: Fix GMII/MII/MII-Lite selection
Message-ID: <f990710b-dc65-4f03-bece-70dd0ff8f431@lunn.ch>
References: <20250923143453.1169098-1-kamilh@axis.com>
 <4d5f096a-49bd-4a4f-a9b9-d70610d0d1d6@lunn.ch>
 <b296f05c-5cfb-49a8-8eec-09561f8f9368@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b296f05c-5cfb-49a8-8eec-09561f8f9368@broadcom.com>

> > > +	if (!phy_interface_is_rgmii(phydev)) {
> > > +		/* Misc Control: GMII/MII/MII-Lite Mode (not RGMII) */
> > > +		err = bcm54xx_auxctl_write(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
> > > +					   MII_BCM54XX_AUXCTL_MISC_WREN |
> > > +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
> > 
> > This is a bit confusing. If it is NOT RGMII, you set RGMII_SKEW_EN? I
> > could understand the opposite, clear the bit...
> 
> Bit 7 is documented as RGMII Enable

Thanks Florian

However, this still does not explain the
!phy_interface_is_rgmii(phydev).

	 Andrew

