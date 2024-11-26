Return-Path: <netdev+bounces-147520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C889D9EC7
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E40283127
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A81DFD89;
	Tue, 26 Nov 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WKGINn2/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558D1DF98E
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655993; cv=none; b=pKEiokB1YsQoYK18WnvXQHQ9AynjUlWP6GNQpiiWmR4mUN99wjQybdDrxfR5ZplwTqOsMRb0mdxxRbcqVNvmqkDgFCGy1ikFCU4tHUKpn9XMkCW13mmqvmD76trbhpugT/qDCIo2tQLh6yWWKAL90OMcYPcOSYTszmGXcfkgnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655993; c=relaxed/simple;
	bh=/uBsSa2IV8kjBe0tkSpdEcPFcsJwXdrV8GMH2QGpLOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+h2ZFoQ/oJT7LifCe+t0q4cbA+ZpOgeLeGaMrgPM9psfkC6x6fC2OUIQo3Zp/U2liRbAUWOqNGiOCZoBWS3Hynf2apGVtM6fVHH0QyiurJNA+2RyeNemcn4lVCsZmFWeJPCjMadr9r2l+UmZOOt0dUizQ9ZCxumynknwKsqCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WKGINn2/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qa0WzQXdZP/FTmz9YLdP10ONBYacrXD2STM6Fg6TPws=; b=WKGINn2//jYQdKbxggItnlyasN
	HnpjhrZMz05n3VC/1GJExdhrBuHi+/87vMbZectf0VcRpod4CffCQGiR94ht7rXJZvTSWNT0HLCVf
	hFC0ins+bvrhe1rt9qh+5BHGMwkQ6BO54JHT2ZFbZbyLVB3/UfhdX1vsIUgz6OvS4Zww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2y8-00EZJ7-It; Tue, 26 Nov 2024 22:19:36 +0100
Date: Tue, 26 Nov 2024 22:19:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 16/16] net: phylink: remove
 phylink_phy_no_inband()
Message-ID: <3810bbd5-610f-4665-9231-b9e2544fd2df@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrpB-005xR8-A6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFrpB-005xR8-A6@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:25:37AM +0000, Russell King (Oracle) wrote:
> Remove phylink_phy_no_inband() now that we are handling the lack of
> inband negotiation by querying the capabilities of the PHY and PCS,
> and the BCM84881 PHY driver provides us the information necessary to
> make the decision.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

