Return-Path: <netdev+bounces-183514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EEA90E24
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223AC1893164
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B323E337;
	Wed, 16 Apr 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NT3H4zDA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882A21ABC5;
	Wed, 16 Apr 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840739; cv=none; b=grIo0rkeRPvNUMzWgXnODpBdrc3nvU7cfEvvQcRPboeRdq+wsq8v7f3V40vpL4NO2COjFrU1J+ID2xHlFLWq27w8Wo92B4fmqbmsB/QHabLQCATNkfZ+N9/Kx/elzNylFF/0ND8DipjequucvvRktlBem0qYP/9H/fhokvT97lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840739; c=relaxed/simple;
	bh=up3bjPp0OgCeJJ0w7pPtgoDYLs4d/inRFsmF3gxyFQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeAdmQp4Qzv9IX/VRS3jw6EDvnYFx9fFldGAaeXrihqhujfhxDeWS0w/xNJn94mwkcmbDawldQxahDuqGLv2t/3UlonFzacJ+sUNk7jqV+HdpD28m6Oj2aN8RjquEh9zIuWEh9Yrhlnzy+d7kon2De3SVfZrDJiolo5jPUbPjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NT3H4zDA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vv7BpdqbrC4MIJGIoyaCveI8US7dxRJU75TQa1FCYWA=; b=NT3H4zDAb3vOVqUUyDgEmkwU9n
	pvPgcGIqiVzK4o8M5YI4G/C8hwYJPfzV4/S54epdX+OQhaL0Dx2z9T0K64QX0GPD8SHQlsSxh9652
	pIq8tf5KvaUfHe9ltDsx3EtN31ZmxU8oIatReKyLyh9zdL7xVFN5Nqq2gpjavK+SXyVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5AmI-009hQk-EE; Wed, 16 Apr 2025 23:58:42 +0200
Date: Wed, 16 Apr 2025 23:58:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [net-next v5 2/6] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2
 switch description
Message-ID: <2c9a5438-40f1-4196-ada9-bfb572052122@lunn.ch>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-3-lukma@denx.de>
 <06c21281-565a-4a2e-a209-9f811409fbaf@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c21281-565a-4a2e-a209-9f811409fbaf@gmx.net>

> > -		eth_switch: switch@800f8000 {
> > -			reg = <0x800f8000 0x8000>;
> > +		eth_switch: switch@800f0000 {
> > +			compatible = "nxp,imx28-mtip-switch";
> > +			reg = <0x800f0000 0x20000>;
> > +			interrupts = <100>, <101>, <102>;
> > +			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> > +			clock-names = "ipg", "ahb", "enet_out", "ptp";
> >   			status = "disabled";
> from my understanding of device tree this file should describe the hardware,
> not the software implementation. After this change the switch memory region
> overlaps the existing mac0 and mac1 nodes.
> 
> Definition in the i.MX28 reference manual:
> ENET MAC0 ENET 0x800F0000 - 0x800F3FFF 16KB
> ENET MAC1 ENET 0x800F4000 - 0x800F7FFF 16KB
> ENT Switch SWITCH 0x800F8000 - 0x800FFFFF 32KB
> 
> I'm not the expert how to solve this properly. Maybe two node references to
> mac0 and mac1 under eth_switch in order to allocate the memory regions
> separately.

I get what you are saying about describing the hardware, but...

The hardware can be used in two different ways.

1) Two FEC devices, and the switch it left unused.

For this, it makes sense that each FEC has its own memory range, there
are two entries, and each has a compatible, since there are two
devices.

2) A switch and MAC conglomerate device, which makes use of all three
   blocks in a single driver.

The three hardware blocks have to be used as one consistent whole, by
a single driver. There is one compatible for the whole. Given the
ranges are contiguous, it makes little sense to map them individually,
it would just make the driver needlessly more complex.

It should also be noted that 1) and 2) are mutually exclusive, so i
don't think it matters the address ranges overlap. Bad things are
going to happen independent of this if you enable both at once.

      Andrew

