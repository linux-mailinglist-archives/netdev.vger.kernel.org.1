Return-Path: <netdev+bounces-166814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30931A37628
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4754B7A270C
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F51922DD;
	Sun, 16 Feb 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B8uFo8Lw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C93A1DB;
	Sun, 16 Feb 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725647; cv=none; b=HAO9nqal0ZmiyghHCVUMm0ypLHHfX6uRWUdpIX8G69jrI/KT7rcZzud7ss2IZsoLxauc9Z+hWgKCPDfxpDNPNSwsr8PoqKvC+baXa8YCPMV+1EzcYeiHuc6nVqz6MVUT00/sD/3VeF8kTGzqBvEfyPzVN9S+bWgywJrZaFA3IDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725647; c=relaxed/simple;
	bh=VTFXIGwapkjlOdIp4WRhTQfD70mAJDYBz/TQyMO7S6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzXvuJXnZLqOSUC0aE9hhtzX46rdADIWuJ65GwrX6eoHsOuuKOnB1cfYVTPFZBqF6a4ucReWSfIeo7qYl0z1pcjgTlfkct/ao3kJ6pq6+YtwxKVzwe4dVl3DeU2JyGJ0v6hxQO1RFLEIaPvmzyvAaDCdsyVWa8MSsWUFx8E1+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B8uFo8Lw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7hZ1fSExpzVyKpRFgU6VF7mxJS6w1IMWmpYoUWdP8zU=; b=B8uFo8Lw1gxr7PSjRioQ8WDC7M
	RB4rvTQkIiL+FxUZ/tl2g/b8/c8gA69f6BVQgjHWJDfZt1svMu4dwCcCywlxvzTi4QV7K91m9XQvu
	7Mx6JqYWdHVCF8qDfYC5MdDw7siI5bws4rdjL42azaIOwmkrGk0oZ7JGDtqruXvdmrBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tji6j-00Ei2d-C0; Sun, 16 Feb 2025 18:07:05 +0100
Date: Sun, 16 Feb 2025 18:07:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>

On Sun, Feb 16, 2025 at 03:47:18PM +0000, Russell King (Oracle) wrote:
> On Sun, Feb 16, 2025 at 08:39:51PM +0800, Inochi Amaoto wrote:
> > +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> > +{
> > +	struct sophgo_dwmac *dwmac = priv;
> > +	long rate;
> > +	int ret;
> > +
> > +	rate = rgmii_clock(speed);
> > +	if (rate < 0) {
> > +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > +		return;
> > +	}
> > +
> > +	ret = clk_set_rate(dwmac->clk_tx, rate);
> > +	if (ret)
> > +		dev_err(dwmac->dev, "failed to set tx rate %ld: %pe\n",
> > +			rate, ERR_PTR(ret));
> > +}
> 
> There are a bunch of other platform support in stmmac that are doing
> the same:
> 
> dwmac-s32.c is virtually identical
> dwmac-imx.c does the same, although has some pre-conditions
> dwmac-dwc-qos-eth.c is virually identical but the two steps are split
>   across a bunch of register writes
> dwmac-starfive.c looks the same
> dwmac-rk.c also
> dwmac-intel-plat.c also
> 
> So, I wonder whether either this should be a helper, or whether core
> code should be doing this. Maybe something to look at as a part of
> this patch submission?

Inochi, please could you look at the datasheet for this IP. Is the
transmit clock a part of the IP? Can we expect all devices integrating
this IP to have such a clock? That would be a good indicator the clock
handling should be moved into the core.

	Andrew

