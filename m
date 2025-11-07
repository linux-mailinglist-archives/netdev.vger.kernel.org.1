Return-Path: <netdev+bounces-236839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA07C40993
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8253BB91D
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EA328B5D;
	Fri,  7 Nov 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fWkvLxd4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45665239E7F;
	Fri,  7 Nov 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529620; cv=none; b=irEZ31YcHU/iaFyrABY6uPYbjEjBOTRpKCwD4ous/lKvoG+q2Cxt56ahgx+CBAbGshOIgwYIFMUxR7yR8iV3Dy+RCnjuCMHq2GggMorxlDr3t9Kv266WD2CwmeBfZQ+p2PnagXgpI+CkvSClfGhRqGhp5mtExRIcHOq27B2KFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529620; c=relaxed/simple;
	bh=P3ab668+SgsSZopmzQ6luLdGMiRFYv+zhm5ze83iYCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/t1MM8DarFQf21O7g6DNG6xL0mU/HQzrpnjXnqSdcPfiva2wpaTzv5/T+QKqHCapyABzRmxAT70GuUuTcmbJVmR0Qsu+ohssr9FwBn2aXXfsy7w8dyKx7T3dIpkKqRod6KXmIDg05enapNUYVSImseCp7gAqYP+I3ZtwVazsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fWkvLxd4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HD/Q7fVnxSxfev0yk/VhBnw0ldUa9+lYqYF4QzV4RV4=; b=fWkvLxd49Wjnh2n2/9JPLxpAgH
	W4EX+IEXmwmxM1+0Yy5nVbc5Yjnd7ibQMKQQ2sMOC0AFZ9vFDDtTulhJ8kN0tm0Y56n8RvyXlQQWG
	zjH4oYaw47mbN5y7l4fjzbHTCYXzyMm7wDR3QbrAv90Bd5Q0DQJ8oAwSXoG4yUx3Z8qvPfeIKPDh3
	D4rckrNiQ2S53gGU82Fc6+RtX4QF5am4NAgvgIo7F0I7O6hwEvTYY0POkoqsgbTVid+Org/zkDWzD
	L4dnPOs3iHy1dFnUUs5knxxWRQiUuQPwJyiqV27pXJMC7FHmez4BQ09NkWHWBVHJ+ts/8xLfuAm2t
	jdEJMxoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49970)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vHOSw-000000006pZ-1u8J;
	Fri, 07 Nov 2025 15:33:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vHOSt-000000007gr-2tdD;
	Fri, 07 Nov 2025 15:33:27 +0000
Date: Fri, 7 Nov 2025 15:33:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
Message-ID: <aQ4RR4OQI9f2bBOG@shell.armlinux.org.uk>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
 <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
 <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>
 <ec456ae4-18ea-4f77-ba9a-a5d35bf1b1fd@lunn.ch>
 <20251107144515.ybwcfyppzashtc5c@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144515.ybwcfyppzashtc5c@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 07, 2025 at 04:45:15PM +0200, Vladimir Oltean wrote:
> On Fri, Nov 07, 2025 at 03:07:48PM +0100, Andrew Lunn wrote:
> > > There is allwinner/sun7i-a20-lamobo-r1.dts, which uses "rgmii-txid",
> > > which is untouched by this patch. The ethernet interface uses "rgmii".
> > 
> > Which is odd, but lets leave it alone.
> > 
> > > And there is arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts,
> > > where a comment says that it has a BCM53134, but there is no such
> > > node. The ethernet node uses "rgmii".
> > 
> > aspeed pretty much always get phy-mode wrong. So i would not worry too
> > much about this.
> > 
> > > So one doesn't define one, one uses rgmii-id on the switch / phy side
> > > and rgmii on the ethernet mac side, and one only defines the ethernet
> > > mac side as rgmii.
> > 
> > That is reasonable. It is a lot less clear what is correct for a
> > MAC-MAC connection. For a MAC-PHY connection we do have documentation,
> > the preference is that the PHY adds the delays, not the MAC. If the
> > switch is playing PHY, then having it add delays is sensible.
> > 
> > > > I would maybe add a dev_warn() here, saying the DT blob is out of date
> > > > and needs fixing. And fix all the in kernel .dts files.
> > > 
> > > Sure I can add a warning.
> > 
> > Great, thanks.
> > 
> > 	Andrew
> 
> +Russell

As this is discussing the applicability of RGMII delays for DSA
switches, I've long held out that the situation is a mess, and
diverges from what we decide to do for MACs - so I'd prefer not
to get involved in this, except to say...

> Since there is no 'correct' way to apply RGMII delays on a MAC according
> to phy-mode, my advice, if possible, would be to leave sleeping dogs lie
> and fix broken setups by adding the explicit device tree properties in
> the MAC, and adding driver support for parsing these.

Indeed - let's not break existing working setups. If there is a
problem with them, then that's the time to start thinking about
changing them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

