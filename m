Return-Path: <netdev+bounces-132804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED89933A5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE66B21639
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950AE1DB545;
	Mon,  7 Oct 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jTj7CMPF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FA1D9334;
	Mon,  7 Oct 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319427; cv=none; b=JbvxwoNH8zXmRyCVYYi3qubXHt+kdDMeZTlm/AktJVKLWJAGf10j4F5qxqLnAAXS0MR/ti/pehznRchsXwgfJnlsZon3CJS4QnQDrLfBZTCTsTZ1xqnOnWZYWZr99gw5GCsn+/99hueyrKmipeaIkBHt7cu3RH5iWouCV8sKK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319427; c=relaxed/simple;
	bh=8f3RQB7P4qUomcOQqA3IO4AAy8F3BeamBsISpOXSYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD0dQh9ONVdpU8sA8DgD2ROJkq9/XEVD/2uWTs4HfZ34s+nvBUt3+Q0OSaM2WVTkG4V7LtqQOdaFa3fL+qmev9cVzL9Squtr+uGhEnxFtSjmYAAFPRSO/ivw8DS5vBQaP35DJ/bWMijOENrw8pr/52kNxIiWpmdZXc8PZEbBb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jTj7CMPF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nZn2zBYwD3KVGDJRDwqzdWgsyBsBIG+PSLhrDiYTSkI=; b=jTj7CMPFET8NvqA9jI7csO/LsH
	1L8AL6Z09Tmxzj/S5n6issZjj4VO9EI3QRCynoKwPN+r6+lBPWpX43KiYncp9EKoZJuDOjLF2hNgU
	hDDUlHHPlHbNIH5ts/UvglQ2HQmyGh7X4uVjuFTtjVPbOgIIRucbYUZdnhwQ+f9KK+dw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxqph-009Hvz-RE; Mon, 07 Oct 2024 18:43:41 +0200
Date: Mon, 7 Oct 2024 18:43:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
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
Subject: Re: [PATCH net-next v2 0/9] Allow isolating PHY devices
Message-ID: <025dc294-2d81-4817-8ec6-7939f1dd8827@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
 <20241007122513.4ab8e77b@device-21.home>
 <ZwQD_ByawFLEQ1MZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQD_ByawFLEQ1MZ@shell.armlinux.org.uk>

> Looking at 802.3, there is no support for isolation in the clause 45
> register set - the isolate bit only appears in the clause 22 BMCR.
> Clause 22 registers are optional for clause 45 PHYs.

That was also an observation i had, the code goes straight to C22
operations, without even considering if the PHY has phydev->is_c45 is
set.  I think we need an op for this, which will default to NULL. The
driver can then opt-in by using the genphy function, or its own driver
method.

But lets get the big picture understood first, before we focus on the
details.

	Andrew

