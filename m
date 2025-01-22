Return-Path: <netdev+bounces-160405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2FA198DA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B51C16BA87
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8A21576D;
	Wed, 22 Jan 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wbw8FXVS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A0215166;
	Wed, 22 Jan 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572138; cv=none; b=oiyND39lx36jEdzIqtii6p87gbX9eQv5o40orW6qOpTVv5b07DIsg+tGw9gK/BEif/f2UlMpDnwRL9PxDkhsJz8IxQkn3U98+IU4gl0ADb22aQ7EOVqF8vcRZgATCqX/LBD64378P5nWljWPIGKz+lMeOCx2aiukWkDl1EFesqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572138; c=relaxed/simple;
	bh=GqH+cjixCHm6pFPgJISgiNmXiquyMt+xgoCU9S/YstQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHsmbAlTnQpor+tWrCWPqwUprtqMQ2X41XVT4D9zyLgoZd1r8cEZ9QXyvQGuPDpntjVjBh72SjlggOyRUwZBteTT565/wfidlyy+LJgYjP0y/jlVJ/6JzUjO4Q/vlAwOo++4gp2ronw1fSNW8SXTqMsluN9c0S/UBq+R3BYGKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wbw8FXVS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hCpKDdKg4rdX1fCkNUFQGWyQg+xKmQk23jdejo83T+A=; b=wbw8FXVSTVYJs6N8NQRDei+kf6
	WhboiXTxBHYWqR43xrZcxr76M1+HrYgItDRbn7sdkVbRhzuGIjvZfG9UWajqYcyVnjIxGPVPzRAzg
	e1c1qx2eV5Wp822RD8Qq03WJFckWovLhpZVWwKwE2FpyNILvpIjqgZA+3ziUYuMNKsA/T6N6hnEwi
	ElC4MioxwSWGsODlYGMPJg+8msO2fkUvf36hQ923+6RXdVwx/U6wZ7ycldajzITiFhwW+wmgqxIkO
	jDQN1Ut68J4I76GTic1c9RFytpUQ6BKVfW41d56RqwKgzGbQWR1HU+ta3tz2wpLUbuG0WJIweeMZd
	YrjstVLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tafso-0000Ax-17;
	Wed, 22 Jan 2025 18:55:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tafsj-00058Q-3C;
	Wed, 22 Jan 2025 18:55:18 +0000
Date: Wed, 22 Jan 2025 18:55:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 1/6] net: ethtool: common: Make BaseT a
 4-lanes mode
Message-ID: <Z5E_FUxSZJWRWVAq@shell.armlinux.org.uk>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
 <20250122174252.82730-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122174252.82730-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 22, 2025 at 06:42:46PM +0100, Maxime Chevallier wrote:
> When referring to BaseT ethernet, we are most of the time thinking of
> BaseT4 ethernet on Cat5/6/7 cables. This is therefore BaseT4, although
> BaseT4 is also possible for 100BaseTX. This is even more true now that
> we have a special __LINK_MODE_LANES_T1 mode especially for Single Pair
> ethernet.
> 
> Mark BaseT as being a 4-lanes mode.

This is a problem:

1.4.50 10BASE-T: IEEE 802.3 Physical Layer specification for a 10 Mb/s
CSMA/CD local area network over two pairs of twisted-pair telephone
wire. (See IEEE Std 802.3, Clause 14.)

Then we have the 100BASE-T* family, which can be T1, T2, T4 or TX.
T1 is over a single balanced twisted pair. T2 is over two pairs of
Cat 3 or better. T4 is over four pairs of Cat3/4/5.

The common 100BASE-T* type is TX, which is over two pairs of Cat5.
This is sadly what the ethtool 100baseT link modes are used to refer
to.

We do have a separate link mode for 100baseT1, but not 100baseT4.

So, these ethtool modes that are of the form baseT so far are
describing generally two pairs, one pair in each direction. (T1 is
a single pair that is bidirectional.)

It's only once we get to 1000BASE-T (1000baseT) that we get to an
ethtool link mode that has four lanes in a bidirectional fashion.

So, simply redefining this ends up changing 10baseT and 100baseT from
a single lane in each direction to four lanes (and is a "lane" here
defined as the total number of pairs used for communication in both
directions, or the total number of lanes used in either direction.

Hence, I'm not sure this makes sense.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

