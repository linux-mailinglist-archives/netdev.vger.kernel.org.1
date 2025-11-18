Return-Path: <netdev+bounces-239572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CAC69CB3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AAF842AF05
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0A36404C;
	Tue, 18 Nov 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R9yDETBG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EB3563DF;
	Tue, 18 Nov 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474426; cv=none; b=d+DVmSjwKtmcwKU/Z5oRstdQJBE0A7EYlYN8y08Moq7W1UpITrzCHg2lVWkJAypqClh+sBITUXNUh9DWP7Jp0+zJLXM6Iw/jVXRl6OIHbOOv8dzM897LlALXX6XOq1I3xyvqvxV43UjoTJH/Y5hv2E2wOo+3Pao+pdoQvvftUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474426; c=relaxed/simple;
	bh=fCcU9TyQkKjc5NX25gWINtX0O4+sBExnUHV9jCvCNSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdqMNwb1tD0+swPmJjtowx15x0orar405ngs9SmQn2xNpah8GuV8snOahy7JwN4gxMFVE0EdccNsoQOZum6Bgejc+eg1zr+NOVKqlSp2an0H0s0y36M90qF+gj8hAARcJqCZ6jd5qRnJ8qP6jnP3QnLGvx/PS+IADS/yNy4rY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R9yDETBG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jb/iIbCDTMamWRNRZBPWYkt70gOkuJvH7L/84zgh4M4=; b=R9yDETBGgvAKhKSDOj6qFRZOE9
	U3rYZq0vNSLvu0ftUJsOpxrQkVrR6IvPCbG1jQ/FxMv6YhttLGCbgbk8hv1mOgphJpsxwrglaRise
	wdjnVKm5MYkrpvPA+INbyNS/VlNytRYYK3OHvxuXhFFIAs1Ih2a5unbMZ/cEHcVCrtto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLMFU-00EM6I-SP; Tue, 18 Nov 2025 15:00:00 +0100
Date: Tue, 18 Nov 2025 15:00:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Message-ID: <e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
 <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
 <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>

> > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link
> > > configuration")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > NAK. I give up.
> > 
> 
> Sorry, could you please tell me what the reason is?

I think Russell is referring to the commit message, and how you only
quoted a little section of his explanation. There is no limit to
commit messages, they don't need to be short. It is actually better if
they are long. So you could use his whole explanation. And then you
don't need the link.

	Andrew

