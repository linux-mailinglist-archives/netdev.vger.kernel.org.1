Return-Path: <netdev+bounces-243659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E8CA4D16
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59F09301EAE0
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB135C196;
	Thu,  4 Dec 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="clNCBxml"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036A35C184;
	Thu,  4 Dec 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870351; cv=none; b=BLy2VvwHvWVm10k5J3txgjulEtX+cffnGtENPP+n0rgzCMTO0GXm2gVvipEAFjqUkAesei7zuS+DTM5jSL+c3QxmJuoAKcv66HeRKHSw/dBQ33+BObkGGUK6Wja+w2W1UjbxQW1VrVm5k5XG+YEuzoSe4eUfl7hSkiL1P7FEYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870351; c=relaxed/simple;
	bh=F83CT1MN5BnIhpYqSVtdH0LKIjgyrzN4gdVGxMPAVj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BycVVlmpUPZxv3zJAYlrWTF8NX/GOkwhjahxxIoXNTk2sO+spzQo/lGt6SrSek2T2e1ZL5qDtC14vIaW/iqM7V8MpZ6tDDP5ECqPE+cXujK4WgS++rkFc9qyCzYYCmT6xYHcWwC803WWiJRu1d7bAZYtMuAbSN/8EwaHIcfMKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=clNCBxml; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0cO2qwM6L3EPg2vfelggnZUt0s+FxmVDVs3kFBnU6uc=; b=clNCBxmlCGM0HhVh2VXZ6icmP8
	oSueq0dvBIE8BP/3TBBtZAk/K5txk6BEEGPKYY/bXlHpfq2KC9clh7nn73sM3vfETZTKhjsTAZ4Uf
	D8lqN2jU7y69GN5VKxNPnlu/KZ35AHRbI6fAF5AXYcUfNsdnsR0630NGuURekT72+JgCXbR+XdFF5
	r3aJyzswnAO80rLfQ5E8bLFPOS+XXuuPbIOmNCrYeUGYkqp1qYItS73dQGvSRZemCyp+Owp6SFWQi
	F4LCpmxxu34p50oXIVGxODtuBPeW2/PRjGX3ktdwx9fGf0+5xGw1RnTTZfa+bKU2zhTXD7KGKaiJ0
	595XM0kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRDOa-000000003qK-1dCp;
	Thu, 04 Dec 2025 17:45:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRDOU-000000001Ca-302V;
	Thu, 04 Dec 2025 17:45:30 +0000
Date: Thu, 4 Dec 2025 17:45:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frankwu@gmx.de>, Andrew Lunn <andrew@lunn.ch>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <aTHIulPW055AyLW_@shell.armlinux.org.uk>
References: <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
 <20251204160247.yz42mnxvzhxas5jc@skbuf>
 <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>
 <20251204171159.yy3nkvzttxecmhfo@skbuf>
 <178afbeb-168f-4765-bb0b-fad0bcd29382@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178afbeb-168f-4765-bb0b-fad0bcd29382@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 04, 2025 at 06:23:48PM +0100, Krzysztof Kozlowski wrote:
> On 04/12/2025 18:11, Vladimir Oltean wrote:
> > You two are *not* talking about the same thing. I dismissed the
> 
> It's the same thing. NOT gate is just pulling some pin down or up.
> 
> > probability of there being a NOT gate in the form of a discrete chip on
> 
> We do not describe NOT gates as discreet chips. I don't think anyone
> actually places something as NOT gate. It's logical NOT gate, but on
> circuit it is just pull up/down as I said multiple times. The pull +
> resistor is the "NOT gate".

You can get SOT-23 packages that are NOT gates. E.g.
https://www.ti.com/lit/ds/symlink/sn74ahc1g04.pdf?ts=1764851465989

This is a real NOT gate - it's absolute max ratings state that it
can source/sink up to 25mA through its output. So no external
resistor required.

What you describe sounds to me more like a normal transistor though.

Irrespective of this, the exact nature of a device that inverts the
level of a reset signal in the path between a GPIO pin and a device
is irrelevant. What matters is whether there is or is not such a
device.

So, can we stop splitting hairs about what a NOT gate is in this
discussion? It's irrelevant.

> It's so easy and that's why it is potentially so common design.

Do you have any real evidence of this when used with a GPIO pin for
a reset input?

It would make sense if a single GPIO pin is used for resetting
several devices, some of them with an active-high reset input and
others with active-low.

What matters for a GPIO pin used to source a reset signal is "what
is the active level at the GPIO pin for the reset to be asserted to
the connected device(s)."

If we have a device that requires an active-low reset input, but there
is some form of inversion in the path to that input from a GPIO, then
the GPIO _should_ be marked active-high. If the same active-low reset
input is connected directly to a GPIO, the GPIO _should_ be marked as
active-low. Thus, to assert reset, writing '1' through
gpiod_set_value() _should_ assert the reset input on the target device
in both cases.

This is why gpiolib supports software inversion - so software engineers
can think in terms of positive non-inverted logic when programming
GPIOs.

Sadly, we keep having people mark active-low signals as "active high"
in DT, and then have to write '0' to assert the signal. These people
basically don't understand electronics and/or our GPIO model.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

