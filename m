Return-Path: <netdev+bounces-195244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222DDACF041
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A6188351E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28922D9F7;
	Thu,  5 Jun 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DWO8+mjR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80231E5B95;
	Thu,  5 Jun 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129661; cv=none; b=lsFTcGBbeXZcfF8tcyQZp3qS2f1H2nFY0GTBc7qkjCZxI7CEmHNYmy62VesA46WPtKorGTD6YOhMcki3AIjQmR0mFdCl90Jv4pSa97mIafmBsvBNlOtuaQZTHwHq3VPdejjc3xe4nNbyVmifQMj8MYgjeZCoZvVoMscV4oA2/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129661; c=relaxed/simple;
	bh=IbVjDlJ1LhjKgB3WqYIBNmH2O1Kjjxb8PtBFxfYMhYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRizQXJhh9+luT5fsiOxSpGNZIoJP9iBDPByn8iKqhfGXw1wPBSmcxGXanoIa5IuU/XmD33ZVg/ly+HVp64WHbep6kGC+RXZVe8xCQq8PVFlsGAZx3TsJ7AGtTX1PBlCoC0Qgzwar7EfSa2bEmkqFcUlCVZqDENrYBhN0POE1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DWO8+mjR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4Gx+44VNAwh2nJ7uA+08Jgl1iBxYZsQ6aOzwSW1WEA0=; b=DWO8+mjRZ/4bKNTzzBrVD7UrHe
	xCFH6vd6BJF/G33XVCTybt05IuKx97iMEzGm1kZ14NLJJ22ap9H8IIzdC+QqblOp1AntUpFarqMii
	cDtE78R1CeYPneuS3hRjSaUXMcOd3C5qtvM8quWAfO/1j5QvzX5tPG34djXX9aKMF+hE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNAWN-00ElxD-7O; Thu, 05 Jun 2025 15:20:39 +0200
Date: Thu, 5 Jun 2025 15:20:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <e0e468af-dc5d-4a27-b0b4-dddfef1e7405@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>

> > > If you want the kernel to not touch the PHY, use
> > > 
> > > phy-mode = 'internal'
> > 
> > This sounds weird, and may introduce side effect on the MAC side.
> > 
> > Well we might need to allow PHY to have phy-mode property in addition
> > to MAC, in this case MAC phy-mode='rgmii*' and PHY phy-mode='internal'
> > might work?
> 
> I'm not convinced that adding more possibilities to the problem (i.o.w.
> the idea that phy=mode = "internal" can be used to avoid the delays
> being messed with) is a good idea - not at this point, because as you
> point out MACs (and PHYs) won't know that they need to be configured
> for RGMII mode. "internal" doesn't state this, and if we do start doing
> this, we'll end up with "internal" selecting RGMII mode which may work
> for some platforms but not all.
> 
> So, IMHO this is a bad idea.

I agree, and if actually see a MAC/PHY pair doing this, i will ask
why. Using "internal" like is currently mostly hypothetical, i don't
actually know of any real users. Those DT blobs which do use
"internal" actually are internal interfaces within a SoC and it is
some vendor proprietary interface which does not need any
configuration. That is the original meaning for "internal", but it has
been noticed it can be used to side step RGMII delay configuration.

It _might_ play a role when developers decide to clean up a mess with
RGMII delays, and decide to just go with the strapping resistors
rather than try to figure out what is actually happening vs what DT
says should be happening, and issue warning the DT blob is out of
date. But still, i would consider "internal" a lazy hack, not a proper
fix.

	Andrew

