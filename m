Return-Path: <netdev+bounces-150883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC19EBF2D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2242916072D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292241CF7B8;
	Tue, 10 Dec 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MozzUGdZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306A2451E6
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872564; cv=none; b=G+PQKUn5AZV5cZFzF/VJw2sIwlOVdg5sez5yrQC5dC3Hc6Hvh0Dtg85BcoV1h1fkbJZTWQaPu7srb8flSQDXOMtwao25FuvDiNQWY2+72tmlfFqz5UfXEKbPElUzEznDJO/fs1Sxvpvvc1o4zR7h9BN61DPVFkEi36doD16yb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872564; c=relaxed/simple;
	bh=Nr7y7BYyw5uw0SomskLvMQvJSopprlWjttjbAO229Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeRS59tpx5Ji/iGai6EV2A0KodhBbWzYvQOStgcE5yGfhQ+Z5VfV7m+bCpnIKmhacU5cex1/IpMUPWdwFvG1wRAEws0rcs3PiY9TJmxcyBKiTGIZVuUG3T+Yz2o9s5FSEmq/P+mwGDIL2ebwMvYqxOI8eRA7WXXY/eIZiR9qytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MozzUGdZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=idRph3ohdNu8NQb3qyt4tOxv4X4DhTJhsrBu3jLBJOc=; b=MozzUGdZacmhddvMFt+LKVfjMd
	8n/kozDG6ckvOOCiqeWvRE1VMB4kmcw8VPb3u2LOgPhLXc8fckWr4qIbY6duI3mSJI/hMF6LxjOHk
	DrQL59gYymavidtvJFifkgeZYwVs+GeFWhPqiyjsd+kMRiw4y8fIADFYlr/lmt1sAAwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL9SP-0001Qz-OM; Wed, 11 Dec 2024 00:15:57 +0100
Date: Wed, 11 Dec 2024 00:15:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 03/10] net: phy: add configuration of rx clock
 stop mode
Message-ID: <da8a3b81-33aa-46a5-b068-cb80c7464cc8@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>
 <fdf1b674-8e47-43ab-9608-e25dde9f3f20@lunn.ch>
 <Z1gPOlBcPIZmXAH6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1gPOlBcPIZmXAH6@shell.armlinux.org.uk>

On Tue, Dec 10, 2024 at 09:51:54AM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 10, 2024 at 04:11:09AM +0100, Andrew Lunn wrote:
> > > @@ -2073,6 +2073,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
> > >  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
> > >  
> > >  int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
> > > +int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
> > 
> > Hi Russell
> > 
> > Do you have patches to MAC drivers using phylib, not phylink, using
> > these two new calls?
> > 
> > We see phylib users get EEE wrong. I'm worried phylib users are going
> > to try to use these new API methods and make an even bigger mess. If
> > we think these should only be used by phylink, maybe they should be
> > put into a header in drivers/net/phy to stop MAC drivers using them?
> 
> If we want to fix the current phylib-using drivers, then we do need
> at minimum phy_eee_rx_clock_stop() to do that - we have drivers that
> call phy_init_eee(..., true) which would need to call this.

phy_init_eee() needs to die, so we need this one. 

But we should consider the other one, do we want to make it private?

	Andrew

