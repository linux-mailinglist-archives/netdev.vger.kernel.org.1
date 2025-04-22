Return-Path: <netdev+bounces-184699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309CBA96F1B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16EB3AA60F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D128CF60;
	Tue, 22 Apr 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LNDMR9KG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B728C5C5;
	Tue, 22 Apr 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332846; cv=none; b=VmoetwgB6NtQHn7EH/9oG08jp+TFRE2NKLewYTyfa/Z1MO7+d4I+CpEQwH3nzebgHE3QJjl59mGWBvi+YBXcKS53iPP2ryLL2AbYDFJK1mAZ4lWW9gHAFkGFjrglk8dAId/o7GygeAfJ8bn+uft7dKCLKvNNG5wiEcjcb2I+mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332846; c=relaxed/simple;
	bh=M9Zr7hxLPheS12ZSZNWK5qMbOtisljKEvNuI/iEukEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlIEiEMb9l14rdR/cwvLq9yosAgSfbmVz/9v8x4ekioyMGmh2ZznPzGPRYmybkBHrfBN9I2kPygN7ZANGjjGFz6EKJG1LbVjBzbfOIeSuEXgQh4rDJ2D3CGoQuWeo71FTLugIU0dy1VvgjdbaErz/HJEb8FoHy2yWQEP/BASIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LNDMR9KG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W0S8t/6FGxg47c0LEtOaE/CH+Zrp13P24zwNFo5jGGw=; b=LNDMR9KGZUOWw2nq8JndcvNeF/
	UlrAChAS6n9brfhMKUvxfErkEiAKWZfUakTgo1Kkbz1sy/lTjGFy4FUuQ/j1f6howOfcfwKPT3E3w
	xIqAYCKilAfznPhLUM091UBTLzpjpG4jgH+P8NwnhBhr/88g68aCbnmxfY71+QOETvkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7EnR-00ADBy-Ka; Tue, 22 Apr 2025 16:40:25 +0200
Date: Tue, 22 Apr 2025 16:40:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <d79ed229-f0b7-441a-b075-31fd2b2f8fe6@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
 <cd483b43465d6e50b75f0b11d0fae57251cdc3db.camel@ew.tq-group.com>
 <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
 <b53fba84c8435859a40288f3a12db40685b8863a.camel@ew.tq-group.com>
 <aAdZoMge_CKtqokU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAdZoMge_CKtqokU@shell.armlinux.org.uk>

> I'm hoping that Andrew will read my email form yesterday and reconsider
> because to me this is a backwards step

I will get back to that in a minute.

> > On Linux, there currently isn't a way for the MAC driver to query from the PHY
> > whether it could include the delays itself. My assumption is that most PHYs
> > either don't have internal delays, or the delays are configurable.
> 
> motorcomm, dp83tg720, icplus, marvell, dp 838678, adin, micrel, tja11xx,
> vitesse, dp83822, mscc, at803x, microchip_t1, broadcom, dp83869,
> intel-xway, realtek all do handle internal delays. I haven't checked
> whether there are PHYs that don't - that's harder because we don't know
> whether PHYs that don't mention RGMII in the driver actually support
> RGMII or not.

I did look through this once. There are no PHYs with Linux drivers
which support any of the RGMII without supporting all 4 RGMII
modes. So we should just assume all RGMII PHYs can add the delays.

If i remember the history correctly, Renesas built an RDK with a PHY
which did not support RGMII delays. So they where forced to do the
delays in the MAC. But it seems like mainline support for that PHY
never happened.

> 
> > If this is
> > the case, having the MAC add them in internal-delay modes and not adding them on
> > the PHY side would be the best default (also for PHY-less/fixed-link setups,
> > which should be handled like a PHY without internal delay capabilities.)
> 
> See my "advanced" use case above. We do have drivers doing that.

I agree with Russell here, it is the worse default, not the best
default. It makes it different to nearly every other MAC driver. It
needs extra work in the MAC, which most MAC drivers get wrong. They
also tend not to call out they have done it different to every other
MAC driver in Linux, and so it does not get the needed extra review,
and so is broken. I also think there is some 'vendor SDK' mentality
here. Our MAC can do this, our SDK allows it, the Linux driver must
have it and use it. Pretty much all hardware has features which never
get used, but vendors sometimes have issues with just leaving it
unused.

	Andrew

