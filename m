Return-Path: <netdev+bounces-193767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371ACAC5DBD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B133A4FE5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A238217F34;
	Tue, 27 May 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OIEzCcHs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE491D5145;
	Tue, 27 May 2025 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748387923; cv=none; b=nFqaLsQ7EOQ5dWha3mBGLjy7LbYKzhWn0SmFjf697LtL5diYugkIzLIYd30ajtf6CdpJknZnHPNoaXNaTo6Eom7z5NclzE74Z9i06vpraZ6DstJAU1cQPACK0COig9kD6FUGHLTe8YPaWwbFyNtsYnNCA0wfgqgHNuEwx0D3iG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748387923; c=relaxed/simple;
	bh=6SsMt8kv8bB9+DxdMnJRB0CnbK4lJ2b+4OehbD0omzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBmCyrLu1lmqT788+Hbxgg5ewCGLbxN2kZHGTR4YBropZ356/cIHQFyWQuAAykCclsXt32/ICxHW7iCOBhSZO+T3xrRqGyeZJsfJ+tnbadZVdLZXdWggMc6vDiSoBswDYIWuWRgfYML8kRTXCrFrdo+b2nSMkemt3qzxg0YFHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OIEzCcHs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7uNa+E5E1Fz2rSYeLmBtivbWjxVm5r8CjbbWJNdovR8=; b=OIEzCcHshhevfPGrJRPuYwDYYn
	8iXyQC76t4Wfu/2IX3lgZKMRkiDoqAs/Z1tBPRvonm6i8VnqjeaiLgkGQ1wc7ADu0v3YQLM7kOyv1
	csS2sXr2Eeo/LDU/fGxaScGrLkt7OGh0RY0Ht5Ytipc70Je1ODGslRrGZ9OHqFjNsYY0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK3Yz-00E7FI-Iu; Wed, 28 May 2025 01:18:29 +0200
Date: Wed, 28 May 2025 01:18:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 2/2] net: mdio: Add MDIO bus controller for
 Airoha AN7583
Message-ID: <922a7c99-8acf-4b88-8e1a-b7c952e50811@lunn.ch>
References: <20250527213503.12010-1-ansuelsmth@gmail.com>
 <20250527213503.12010-2-ansuelsmth@gmail.com>
 <e289d26e-9453-45f5-bfa6-f53f9e4647af@lunn.ch>
 <68363f34.050a0220.351f97.06f7@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68363f34.050a0220.351f97.06f7@mx.google.com>

On Wed, May 28, 2025 at 12:39:45AM +0200, Christian Marangi wrote:
> On Wed, May 28, 2025 at 12:36:46AM +0200, Andrew Lunn wrote:
> > > +#define AN7583_MDIO_PHY				0xd4
> > > +#define   AN7583_MDIO1_SPEED_MODE		BIT(11)
> > > +#define   AN7583_MDIO0_SPEED_MODE		BIT(10)
> > 
> > Is there any documentation about what these bits do? The bus should
> > default to 2.5Mhz.
> >
> 
> No but I can ask. In theory tho these MDIO controller are used for 10g
> or 2.5g PHY that all require a firmware to load so 2.5MHz makes the boot
> time of 2+ minute.
> 
> The documentation say...
> 
> 1: fast mode
> 0: normal mode
> 
> Very useful I guess :D

Can you put an oscilloscope on the clock line and measure it?

We have the DT property:

  clock-frequency:
    description:
      Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
      defined 2.5MHz should only be used when all devices on the bus support
      the given clock speed.

It would be good to default to normal mode, but allow fast to be
selected, once we know what it actually is.

	Andrew

