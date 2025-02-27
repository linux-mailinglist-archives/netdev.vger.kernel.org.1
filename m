Return-Path: <netdev+bounces-170435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1372A48B8B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA77218912E6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7172777F2;
	Thu, 27 Feb 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Uo6ERNsT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB32777EE
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695168; cv=none; b=hqkM9lxoSDPZOsfy2673Y00F/sODu9D711oNcSIQ1Zyf6liBEg8enEWrfREBIZjOYrJ8p7EFuEm24y22OmjDozqf/DeApGE6JPuRSsZ2y69zcDOU0ds821nGFkvKGXFe/VtUthAm5RC065VRcBxV8a9aourEeTaMsCrSEaczwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695168; c=relaxed/simple;
	bh=hhoyNkU/rd1GAyKdaGn3TvBfuOZCSnBiwlVod+UMyRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKkLeCzN6AINE+rjvUt2s4RRX8kRwzIOyzY6tgi4O08Ik7TTFT87ueps9NInEdnfsQbZb0QGNfW+7VfCP/wjjP/Lm8LlJQPN/j41QKUjLboiIu1ghMuu1axftcm+Xo4WY+ORgqSrEA5QmUcP3Tl8pdvYdO+EkahU3zgZBkuhh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Uo6ERNsT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JAD5gaqK7x1cnVYR5Z+IhayFxmM2nS7DFCjvFomea9U=; b=Uo6ERNsTacLNPhNTLfvb3Pb5RC
	ztc4m+/t8mZnDvkf4wue8gMYY3mp1h/f6Lfc7rxrcAHBUrIbgnE638keqw/gCcdx6LQvGwkkMJIbM
	9wLOi/DfsoCgtJS7tX+LsGlFGDpI8GUoamHF2SMIrTQI8OYOgiKDDSqR653uzm4+6IK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnmKK-000jtD-TS; Thu, 27 Feb 2025 23:25:56 +0100
Date: Thu, 27 Feb 2025 23:25:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 4/5] net: stmmac: remove _RE and _TE in
 (start|stop)_(tx|rx)() methods
Message-ID: <166e33f3-1602-4d12-853d-0744f6dd4ce6@lunn.ch>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRt-0057SR-Hx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnfRt-0057SR-Hx@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:05:17PM +0000, Russell King (Oracle) wrote:
> Remove fiddling with _TE and _RE in the GMAC control register in the
> start_tx/stop_tx/start_rx/stop_rx() methods as this should be handled
> by phylink and not during initialisation.

Maybe the commit message could be extended. 'by phylink', i think you
actually mean via the stmmac_mac_link_up() and stmmac_mac_link_down()
callbacks which call stmmac_mac_set().

Bit of a nitpick, so:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

