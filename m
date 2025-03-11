Return-Path: <netdev+bounces-173990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDEA5CD2F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5BB189CB2B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108B262D16;
	Tue, 11 Mar 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3D8qMqzI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B982620C3;
	Tue, 11 Mar 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716389; cv=none; b=uIVO5mY407xFIUjMN3Hn4jb1WjH5f9IWsTUoWkRo+/rkGB+cTng69Tq1tbK5V8rGOrnBoNQvhhXhP3Xus60t7BVxIJnG0sSJj1bVzWVYkgq0xiX5DDVjlQblpsZi6jBQ0i/AB/msFJ9TaH4P/NewnCPT+Tiow8N8nXG79Si/SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716389; c=relaxed/simple;
	bh=DippBqC0BBU0qH1E5vSEMORAFTY5N4fiUMqRFBzB8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+kEAc1lA3DDFhRSC2stkZHm7/p/V32oIibUZDZ2bTmzw4j1eGxCGKUGlCZOWv9Ce51lh3J+/5vESWivRV9PMyv8TYITPDEDyqCgBuuFxycFCZFLDBJYRLjqc2uEuIyXmCa6n9RQDj/9J8pbtBroXx806+HwlyEXix2ETRbkNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3D8qMqzI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3OLyNSn1WdzXXSydJk+U4Xqnh9AkjR3NtHdm4uHlg2I=; b=3D8qMqzI2hLyJ4OmXTqaru27Sj
	yuWdbwj4lnjwq0ZZyrOZmsml2cahvtrLvdfCwPVJf+fO//6p/cWAEJwc+Mm80x2NsDSdInA99QL6b
	HEydjaVzn9+FbbYMbYCpHs6cAC2QFKgEF6jtqplLpjylWi09wQVpS/aSaQSpH2BkjSd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ts3zV-004Ppo-Ho; Tue, 11 Mar 2025 19:06:09 +0100
Date: Tue, 11 Mar 2025 19:06:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: ethernet-phy: add
 property mac-series-termination-ohms
Message-ID: <de68ea7e-1ca5-4983-9824-3fb432b00e82@lunn.ch>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
 <20250307-dp83822-mac-impedance-v1-1-bdd85a759b45@liebherr.com>
 <20250311173344.GA3802548-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311173344.GA3802548-robh@kernel.org>

On Tue, Mar 11, 2025 at 12:33:44PM -0500, Rob Herring wrote:
> On Fri, Mar 07, 2025 at 11:30:01AM +0100, Dimitri Fedrau wrote:
> > Add property mac-series-termination-ohms in the device tree bindings for
> > selecting the resistance value of the builtin series termination resistors
> > of the PHY. Changing the resistance to an appropriate value can reduce
> > signal reflections and therefore improve signal quality.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 824bbe4333b7ed95cc39737d3c334a20aa890f01..4a710315a83ccf15bfc210ae432ae988cf31e04c 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -238,6 +238,11 @@ properties:
> >        peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
> >        will be left as is.
> >  
> > +  mac-series-termination-ohms:
> 
> A property of the MAC (or associated with it) should be in the MAC's 
> node.

But it is the PHY which uses the property, and the PHY which is
implementing the resistor.

Also, a PHY has two sides, one towards the MAC and a second media side
to the network peer via the Ethernet cable. Both sides need
termination resistors. So we need something in the name to make it
clear which side of the PHY we are talking about. So we might end up
with something like mac-termination-ohms and media-termination-ohms,
in the PHY node.

> Also, sounds like either either end could have a property.

True, the MAC could also need a similar property, since the outputs
from the MAC to the PHY needs termination resistors.  For the MAC,
termination-ohms is probably sufficient, or phy-termination-ohms to
indicate it is towards the PHY?

	Andrew

