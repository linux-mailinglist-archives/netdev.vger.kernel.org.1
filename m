Return-Path: <netdev+bounces-242626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6193C93201
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 21:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CF004E17EC
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5062D249A;
	Fri, 28 Nov 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zli/wAC/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1182DC77F;
	Fri, 28 Nov 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362349; cv=none; b=mc9Q8XZhqDufuA2OTMIr+CvL8ria9vvDDrByVvBuTaWL6AQvoOkATY/m9Y2htJD+4CBpHSMvEr1XRV/bGQTs2ng/jcxawhv9nNYZkMDLfMzxqai0BUu9uc0/v7gUy/olEIj867KiAaSAWeAzLSJiKGlzontEBJ/gfIOKfM6XUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362349; c=relaxed/simple;
	bh=i6YCKnT4456ULC0TOq8QP4LrrJ2DGjGsAE3ZDOdQnoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3SODJc9Y2lbMtGVrM+mwrzv1SsIfJhkinGxvYiE5o0i1sqAu0Gf2wC79CwUmTFKOhBfGxcd/UWfA/O3arSYAXLF2qihBLd9WlhVMNaJv6Fr08X1OS26r96FRBkSdslm7nhqkbDxEx/YG4AA52DCX8xXjgqEK3rVUWOMBN8M7bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zli/wAC/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4SqRJzI2Gohny4zVfWkfoaWufiOVWnzLfXSrgmIu/lU=; b=zli/wAC/d6JA53S/zZ/lglmNiT
	sLSF12WLDjoNnYSekUdnEDJHvazsvbH0HGDUfbtSKWQcH0cFS8FNIIydxU+2Ajb6e9lTvQL16cool
	6hUK2tWCv+3liuh8d4SGJFI638vyjMtn/D/Zsss4nwFHu0Nf0XUC6pvQVu+Nf3zTQHfqtiRRmk/WR
	ZoKenQ8M2CPicuQXqyd8D9zFusBMjKHYfDd+6jRN0D1DsRfZ2C1LIGf1ABUoviOiQkvCxXHRGULLI
	2VxlzMF6w10zoppR811MLu+TC5kfThhndgJWNhpzdZYn9c84vXmBTumvx/vkEkCxvHhplEsH49knR
	/rcwH7fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vP5Eg-000000007JO-17HQ;
	Fri, 28 Nov 2025 20:38:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vP5Ea-000000003uv-1Vmu;
	Fri, 28 Nov 2025 20:38:28 +0000
Date: Fri, 28 Nov 2025 20:38:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aSoIREdMWGeygnD_@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
 <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
 <aSljeggP5UHYhFaP@pengutronix.de>
 <20251128103259.258f6fa5@kernel.org>
 <63082064-44b1-42b0-b6c8-a7d9585c82f5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63082064-44b1-42b0-b6c8-a7d9585c82f5@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 09:16:24PM +0100, Andrew Lunn wrote:
> > Can you please tell me what is preventing us from deprecating pauseparam
> > API *for autoneg* and using linkmodes which are completely unambiguous.
> 
> Just to make sure i understand you here...
> 
> You mean make use of
> 
>         ETHTOOL_LINK_MODE_Pause_BIT             = 13,
>         ETHTOOL_LINK_MODE_Asym_Pause_BIT        = 14,
> 
> So i would do a ksettings_set() with
> 
> __ETHTOOL_LINK_MODE_LEGACY_MASK(Pause) | __ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)
> 
> to indicate both pause and asym pause should be advertised.
> 
> The man page for ethtool does not indicate you can do this. It does
> have a list of link mode bits you can pass via the advertise option to
> ethtool -s, bit they are all actual link modes, not features like TP,
> AUI, BNC, Pause, Backplane, FEC none, FEC baser, etc.

I see the latest ethtool now supports -s ethX advertise MODE on|off,
but it doesn't describe that in the parameter entry for "advertise"
and doesn't suggest what MODE should be, nor how to specify multiple
modes that one may wish to turn on/off. I'm guessing this is what you're
referring to.

The ports never get advertised, so I don't think they're relevant.

However, the lack of the pause bits means that one is forced to use
the hex number, and I don't deem that to be a user interface. That's
a programmers interface, or rather a nightmare, because even if you're
a programmer, you still end up looking at include/uapi/linux/ethtool.h
and doing the maths to work out the hex number to pass, and then you
mistype it with the wrong number of zeros, so you try again, and
eventually you get the advertisement you wanted.

So no, I don't accept Jakub's argument right now. Forcing people into
the nightmare of working out a hex number isn't something for users.
That's a debug tool at best.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

