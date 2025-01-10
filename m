Return-Path: <netdev+bounces-157230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6049A098E7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C886D188D736
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8028205E3F;
	Fri, 10 Jan 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PTiHvN0a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F018C928;
	Fri, 10 Jan 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531549; cv=none; b=JqNSwZAzGvgR/A+PM2oyj7qOo1qVm4LGZYBy/TjtkphJbnkBslRrd8oeG0Ju0zTwJp4JQIUxv+To6jk+jOyF0AQ89R0hENxYV9o0A87bQGcEg+yQbchs0NvRwGbn1mhVtpYP+lV0XT5tP0b0ExHbBeO+d3Donn2C31qx+kn+VXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531549; c=relaxed/simple;
	bh=XsZ9q6Ohxk1fK3Gf+zMVJQAQl816y2l1xTqrhGL1EM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duID9gtwRPJwMn4HNRucLsf+eB1hjPMdvmRpZd6Y4TimgTU7/JIv/hZMFUf8lrd5fWv2U0kkz9fDwpPl/S9yAx0J5f5W1Notdjk8pX1rY7p42T47Rb/zz56i8coCfcXB3F7/dg23QwrgrnxsDPEtHujwXCNjLZQkyQIsHQn7m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PTiHvN0a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3asnPk9PT+ic0Yh3saQbypRUCzXdg7vO0+5C9vU21wI=; b=PTiHvN0a+v49KBrKYe+XTdzcPi
	IssAzZAtqw0FQasHIRRYSAkR9gjm2sTRClfaIa3s4RbJ4TzY5Njk00PUmYVjChFAQMN7S4J0YE8fB
	d4ePIA6M+Dx+FDOmCyiMMcJvhvOo05ZR8PxD9/991B8vL/dkNc6+tlg59H8Jg1jvN444=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWJB9-003JFB-9J; Fri, 10 Jan 2025 18:52:15 +0100
Date: Fri, 10 Jan 2025 18:52:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <07b158b8-b745-4886-aa48-3b5be90fd2d9@lunn.ch>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FYjw596FQE4RMP@eichest-laptop>

> > +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > +			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> > +						 MDIO_MMD_PCS_MV_RESET_CTRL,
> > +						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> 
> If I understand it correctly, this switches the function of the pin from
> TX_DISABLE to GPIO? Can you maybe add a comment here?

What is TX_DISABLE used for? I know it from SFPs, where it will
disable the laser. But here we are talking about a T1 PHY.

Do we have to be careful of use cases where the TX_DISABLE pin is
being used for TX_DISABLE?

	Andrew

