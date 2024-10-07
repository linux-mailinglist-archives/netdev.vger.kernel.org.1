Return-Path: <netdev+bounces-132690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84215992C7B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C71F239EF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EA1D2B0F;
	Mon,  7 Oct 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oQ+J5Tuw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE81D27BF;
	Mon,  7 Oct 2024 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306117; cv=none; b=IzJuTwYTvxhVUf9/7ZjtAxnv34ZISV/x5yfQ4s4LbcTFZjPt9/wpBxJ7CZba8McAo7kBJBjVTPIt7emWM1EMxaZDXLaITENyAFPF1q3NXqQ2ASWFsFMgf3t4UzzP0bpVIigyK3CYPuqysa6J572eEPhPasWo9XJUZRy/StJcmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306117; c=relaxed/simple;
	bh=VRoIVYavvWEQ/zjPpxRTJx/tHkOU8kaWQGlvqYSDb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYvtbqTPnFJ9tiC46rKa7CpERuxR40+wTTjlZHaUjQLAuYfq0JoyB7Rug+E42joRYBsdIt07ZXj/rAQPf0WvOuy8pEERzKFeT1NXWbQeiL13HGlmTgGN/xEorYIb2VBfvMtlkEARUaVsCy3ksfJm2/AKpk4AmXqwBQrDzrWCV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oQ+J5Tuw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9vsE/JZpOUgZS9rfiGMJoEt1zwSQezxy7A2bI0xxF/k=; b=oQ+J5Tuwf3kpgn8LsbwVlXAvBR
	YUKy2CedCNSIcOt5tGut5WmtyFri7L3K1P3X1DN7S3QYAXkNl78t3vHjd9e2jFYVfRuTR/Dn0KbQ1
	FwsAjeeQ3w4OEQgJJIS9FoIEu8XNoo+u/MQszHVKhL5JxIqPiEG861jNrRlKtabnjhlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxnN0-009GJL-IW; Mon, 07 Oct 2024 15:01:50 +0200
Date: Mon, 7 Oct 2024 15:01:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007123751.3df87430@device-21.home>

> It seems I am missing details in my cover and the overall work I'm
> trying to achieve.
> 
> This series focuses on isolating the PHY in the case where only one
> PHY is attached to the MAC.

I can understand implementing building blocks, but this patchset seems
to be more than that, it seems to be a use case of its own. But is
isolating a single PHY a useful use case? Do we want a kAPI for this?

> I have followup work to support multi-PHY
> interfaces. I will do my best to send the RFC this week so that you can
> take a look. I'm definitely not saying the current code supports that.
> 
> To tell you some details, it indeed works as Russell says, I
> detach/re-attach the PHYs, ndev->phydev is the "currently active" PHY.
> 
> I'm using a new dedicated "struct phy_mux" for that, which has :
> 
>  - Parent ops (that would be filled either by the MAC, or by phylink,
> in the same spirit as phylink can be an sfp_upstream), which manages
> PHY attach / detach to the netdev, but also the state-machine or the
> currently inactive PHY.
> 
>  - multiplexer ops, that implement the switching logic, if any (drive a
> GPIO, write a register, this is in the case of real multiplexers like
> we have on some of the Turris Omnia boards, which the phy_mux framework
> would support)
> 
>  - child ops, that would be hooks to activate/deactivate a PHY itself
> (isoalte/unisolate, power-up/power-down).

Does the kAPI for a single PHY get used, and extended, in this setup?

> I'll send the RFC ASAP, I still have a few rough edges that I will
> mention in the cover.
> 
> > However, I still want to hear whether multiple PHYs can be on the same
> > MII bus from a functional electrical perspective.
> 
> Yup, I have that hardware.

Can you talk a bit more about that hardware? What PHYs do you have?
What interface modes are they using?

	Andrew

