Return-Path: <netdev+bounces-139098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3C9B033A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2AB21EF9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD92064FE;
	Fri, 25 Oct 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kp6vq3UE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B202064FA;
	Fri, 25 Oct 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860978; cv=none; b=TBUIZ0B2wMG4T3JGXlyTH9683Q//Kb9cbYxI4rpbDI8JLsP53J2Y1y66TxfjCyxWCEVWSaph7Y56dcr4QZ+0izXdODq95KSoVY0EKoYl7YU1uZ3WjHqxDs+jaBINF/8SewC8Hbkm1dyZMtsE/6P3gVYtrhRtQh6aArTJI5vrwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860978; c=relaxed/simple;
	bh=ZidkkjieQcwUdRKG7VyolW5l5HLB/fwWuo/XI+VVKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMdWgpeGSb/VC+zNe1dz/b7bjpZ5/t38mNKwlAoIN2CEB2rLLfT3PSl5lpaf80nYCnGyPznRrAbjbs2YPzTw53HFfTGNjgeTk3K2Kt12ghjznjMsU9zT7XEYHJBACIHIfI0j2Piocs3KgWDDwgESHf+zis77ONUI79hTRH9Fj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kp6vq3UE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uaLzS2qaJigWNLOldFetiqs+rgYiakfBQHgJpJQH0ok=; b=kp6vq3UEPeK6nUfz/w8v2v2WhE
	Lq8d+/sHZntmUJ1c0EywObGbYOcK1hIlBIGXEV4iTq9kTQbMCedm2lXASJq7uMv9yj1nWDSTNbiP+
	M+PgdGgfT0stpFbABjORFWF70lBaytRFHY/8X0N9d+Dc6WJ6dw6J0328StxxzbtmCvXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t4JrJ-00BFG4-9v; Fri, 25 Oct 2024 14:56:05 +0200
Date: Fri, 25 Oct 2024 14:56:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <a8f9a6ba-b33f-4f78-97c4-757a15895104@lunn.ch>
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
 <87aad5ff-4876-4611-8cf8-5c20df3559b3@lunn.ch>
 <671b7a2e.050a0220.4431c.03f5@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671b7a2e.050a0220.4431c.03f5@mx.google.com>

On Fri, Oct 25, 2024 at 12:59:54PM +0200, Christian Marangi wrote:
> On Wed, Oct 23, 2024 at 06:53:14PM +0200, Andrew Lunn wrote:
> > > +	/* Enable Asymmetric Pause Capability */
> > > +	ret = phy_set_bits(phydev, MII_ADVERTISE, ADVERTISE_PAUSE_ASYM);
> > > +	if (ret)
> > > +		return ret;
> > 
> > The PHY driver alone does not decide this. The MAC driver needs to
> > indicate it supports asym pause by calling phy_supports_asym_pause().
> >
> 
> Sorry for the stupid question, I couldn't find this OPs. Any hit how to
> handle this?

For phylink, set MAC_ASYM_PAUSE | MAC_SYM_PAUSE in the capabilities in
phylink_config.

For phylib, call phy_support_asym_pause(phydev) after connecting to the PHY.

	Andrew

