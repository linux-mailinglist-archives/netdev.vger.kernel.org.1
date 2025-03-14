Return-Path: <netdev+bounces-174991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5BA61D79
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076A81B60B7A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506A18A6C5;
	Fri, 14 Mar 2025 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xC6gYtgI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A5846F;
	Fri, 14 Mar 2025 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986146; cv=none; b=AApmkJU7gYazpgYg7G4bsX9a6gvc2kOPwDK34kna+wZIomVWtOcZ830mra9Yw74fG5ZmvoteJ0KpRFuBRxoCzfp8QmvSa08yGYhBuEswnXFBpo925drpkFFftotpGzqkLREbKsqPCONCVHc0mSMx29pvrHL+kMjWg7gvoQeFCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986146; c=relaxed/simple;
	bh=PBKVY3q4UiyLDTmqpWhJl8RMEu5qRBfVlkz0X8coqPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIwAyJAMrIr6g+X54uQUPEWsxFnNh2RYXnc2ZuYAeOBSehtQBgzaArY/7yzBnZT1DR7UTTg/FipbBnHly3kKAcSpQSCddbDCT8Vqw2pyESUR22mBAGW+i7LL2H2T6QxaLdyUwSaEFACjFqPP0M4Gs0vjqWrBp5Ms3b+358RlMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xC6gYtgI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jQMpACQDEvSJ3LL9uNYMMa8tYX+iwHFV5B8Acn+A7NM=; b=xC6gYtgIocDWFn1aEV572tI1rw
	4fXPLe1O5+oujAN9PJs24k6kXQSQxVEU40H29/f+KYsjCjSZ6xx3V0PYBozfywta9s9hmqdYDNDeY
	ofbtmn+L1Jo3VcD3VRLUdtLwe56mIxxCwLNpOqB4BY19h1NMuqaR9eHd9xslqIKTB9c/JJVJUtEim
	8Svo9GUhQLumK7nMjrtf/SCnxtM9tkCBecoIqgyO8oHkW57zAhKWLz58lU+4f4c54WoPVjYQmgwa4
	P++O7POVC46szY5kYCkAauBaVkOz71R4qEUC0AEPQvQNzLORqBtY6/VeyQHNKjy7fq4I4OZfNIGQj
	GjiXqeuA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45512)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ttCAO-0000r5-0z;
	Fri, 14 Mar 2025 21:02:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ttCAH-0006to-0T;
	Fri, 14 Mar 2025 21:01:57 +0000
Date: Fri, 14 Mar 2025 21:01:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
Message-ID: <Z9SZRDykbTwvGW6S@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
 <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
 <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>
 <0c6cb801-5592-4449-b776-a337161b3326@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6cb801-5592-4449-b776-a337161b3326@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 14, 2025 at 08:41:33PM +0100, Andrew Lunn wrote:
> On Sun, Mar 09, 2025 at 06:45:43PM +0100, Christian Marangi wrote:
> > On Sun, Mar 09, 2025 at 05:36:49PM +0000, Russell King (Oracle) wrote:
> > > On Sun, Mar 09, 2025 at 06:26:52PM +0100, Christian Marangi wrote:
> > > > +/* If a non empty valid_addr_mask is passed, PHY address and
> > > > + * read/write register are encoded in the regmap register
> > > > + * by placing the register in the first 16 bits and the PHY address
> > > > + * right after.
> > > > + */
> > > > +#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
> > > > +#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)
> > > 
> > > Clause 45 PHYs have 5 bits of PHY address, then 5 bits of mmd address,
> > > and then 16 bits of register address - significant in that order. Can
> > > we adjust the mask for the PHY address later to add the MMD between
> > > the PHY address and register number?
> > >
> > 
> > Honestly to future proof this, I think a good idea might be to add
> > helper to encode these info and use Clause 45 format even for C22.
> > Maybe we can use an extra bit to signal if the format is C22 or C45.
> > 
> > BIT(26) 0: C22 1:C45
> > GENMASK(25, 21) PHY ADDR
> > GENMASK(20, 16) MMD ADDR
> > GENMASK(15, 0) REG
> 
> If you look back at older kernels, there was some helpers to do
> something like this, but the C22/C45 was in bit 31. When i cleaned up
> MDIO drivers to have separate C22 and C45 read/write functions, they
> become redundant and they were removed. You might want to bring them
> back again.

I'd prefer we didn't bring that abomination back. The detail about how
things are stored in regmap should be internal within regmap, and I
think it would be better to have an API presented that takes sensible
parameters, rather than something that's been encoded.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

