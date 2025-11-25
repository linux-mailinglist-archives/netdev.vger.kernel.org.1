Return-Path: <netdev+bounces-241662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EBC8751B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E04E023B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847422EDD64;
	Tue, 25 Nov 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LCjZZPNN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3923EAAB;
	Tue, 25 Nov 2025 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110000; cv=none; b=F8vAAihbRyw32C1HpG6oY+htZSBx97j5vrwUvH95cibBU3yzwBq7bhieke/D6DmnBdLVcIRQXMZIwQlKV7cleCfIkMjgeoWYsCInbQLTFFGAjN31uMYCtOmhTMLXMq2nHQKnt2FiVX3Qfcc1mDQQGtKyhQFVpS0ItmXBuI64LxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110000; c=relaxed/simple;
	bh=iHUHSpUALceRH7ctkYwwvR40VU2nqvVWdDJqkD/9SEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asJw8LMIm3+D8QsZyZ9c497Ev3L7jrou6Y1cEgZmVePZHrDd9rlx6ys/PE4e9MZ+2T/Fd1jCqFjWT9HjgqbN+ydRzm3Ugr+NR2TRbmUTQ/knjRLBKfUDyOMDFHUl95XDXlMEEi1Tf9XOxl1nAZZWUVsG0KoNbR6HJayUNn0f4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LCjZZPNN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H7pG8R0U/pnahoXJymPcP4KNsItn4TlRtbOwE4F9lRw=; b=LCjZZPNNMiWvKKVuIMq+NBWWVY
	kj2//mzyNplsQdeFC+RyOKTf8t+MwaN0S14WCYwwiiI6YBOR6mPugvwt510BaAjc+urPg8HVK+ndP
	jLLDH1e55AnEW9hdS6pnP/NPCWj63lVW1n+gslTWIa975faElFKixJwNT78z9QYPIPog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vO1av-00F46S-5T; Tue, 25 Nov 2025 23:33:09 +0100
Date: Tue, 25 Nov 2025 23:33:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125214450.qeljlyt3d27zclfr@skbuf>

> Yeah, although as things currently stand, I'd say that is the lesser of
> problems. The only user (mv88e6xxx) does something strange: it says it
> wants to configure the TX amplitude of SerDes ports, but instead follows
> the phy-handle and applies the amplitude specified in that node.
> 
> I tried to mentally follow how things would work in 2 cases:
> 1. PHY referenced by phy-handle is internal, then by definition it's not
>    a SerDes port.
> 2. PHY referenced by phy-handle is external, then the mv88e6xxx driver
>    looks at what is essentially a device tree description of the PHY's
>    TX, and applies that as a mirror image to the local SerDes' TX.
> 
> I think the logic is used in mv88e6xxx through case #2, i.e. we
> externalize the mv88e6xxx SerDes electrical properties to an unrelated
> OF node, the connected Ethernet PHY.

My understanding of the code is the same, #2. Although i would
probably not say it is an unrelated node. I expect the PHY is on the
other end of the SERDES link which is having the TX amplitudes
set. This clearly will not work if there is an SFP cage on the other
end, but it does for an SGMII PHY.

I guess this code is from before the time Russell converted the
mv88e6xxx SERDES code into PCS drivers. The register being set is
within the PCS register set.  The mv88e6xxx also does not make use of
generic phys to represent the SERDES part of the PCS. So there is no
phys phandle to follow since there is no phy.

	Andrew


