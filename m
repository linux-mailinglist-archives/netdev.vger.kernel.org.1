Return-Path: <netdev+bounces-177764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C4A71A2A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5524216B3D4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C984E1E1E0D;
	Wed, 26 Mar 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LvhZHxxP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940818B0F;
	Wed, 26 Mar 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002682; cv=none; b=nODA94GPReMffpO8Q6nJf3oEBjWisSq0s9ULuB2j6Tq61zeFbLGYnabUsBNjY92X+jxE4NKO0tvN/JlfgM+QXerzrVEQrpQCEGj4toNJ1zgUfJ6znGeQriu6PPk+9bsOx2US43e3aIDC7BPC99cp9dslrRZVsJzYxyi5BCWybWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002682; c=relaxed/simple;
	bh=QmVEMWC5i2pBLpyMpgVj9i2Xeeobc0j6hPI9i00YqGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6okKRUnPwEJdJamMObUB5OIEdY3JCF76LjTQbBkeYKcRoKElMHTNUr0UhCyHNxVGJQ6HfBQkbjL5uJg+ruM/pzIdiKKQ40Dsu1I0MP/Xq/bWBZe4VxqhhdXvJFlCa8XgKuExpSFCN99x7h4TlAo7HqVYgXoodx5mx9TH6xWQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LvhZHxxP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MXUNQ3qwLDG8TCGsRA0HZ7ccSxkq0b8zwwJm6HgvBOc=; b=LvhZHxxP4PkL3vrUPyY8fcGEbb
	8Kx5bTCmCSWT51Rbgcs3/unQVAE0hmuEmtn9rI4u2kH+ni6xLmDttEX5Yrr1tvj6QYrh538SD9Ofw
	tuUGDNrXIzDFlZ6MN/FvWO4UKsFh99mWPfyZ1/dicPLsOnH0uBTVJ+dJckbLDIvO5VA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txScK-007BQt-CA; Wed, 26 Mar 2025 16:24:32 +0100
Date: Wed, 26 Mar 2025 16:24:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
Message-ID: <4297e9ae-bb10-4d0d-b750-96256ab573f3@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-3-lukma@denx.de>
 <2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
 <20250326144316.2ca252f7@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326144316.2ca252f7@wsk>

On Wed, Mar 26, 2025 at 02:43:16PM +0100, Lukasz Majewski wrote:
> Hi Andrew,
> 
> > > +  phy-reset-gpios:
> > > +    deprecated: true
> > > +    description:
> > > +      Should specify the gpio for phy reset.  
> > 
> > It seem odd that a new binding has deprecated properties. Maybe add a
> > comment in the commit message as to why they are there. I assume this
> > is because you are re-using part of the FEC code as is, and it
> > implements them?
> > 
> 
> In the case of MTIP L2 switch, the reset gpio line (in my case, but
> also on e.g. imx28-evk, and vf610) is single for both PHYs.

So this is known as an MDIO bus reset, not a PHY reset.

Documentation/devicetree/bindings/net/mdio.yaml

  reset-gpios:
    maxItems: 1
    description:
      The phandle and specifier for the GPIO that controls the RESET
      lines of all devices on that MDIO bus.

We have moved the handling of such reset lines into core code, which
is why per driver properties are deprecated, and you should use the
properties defined in the core.

	Andrew

