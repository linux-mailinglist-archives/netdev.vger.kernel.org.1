Return-Path: <netdev+bounces-160408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA85A19927
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD381887F89
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED22153F1;
	Wed, 22 Jan 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zgM0Rouz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1FAD4B;
	Wed, 22 Jan 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573951; cv=none; b=Qhj0x54gjNCUjsGq3z/L0CQhHeh5PbAqajy8v8k4BW34043qWOnruXaBp8U9Iq6nX/rkEZpjtqXRMhjiNZTb4XpVLtsSAtFG8omLkCr1IBinR1JTbGoJ+8HZd69sE69vKZ8aFijIefSKEFp3/sEEJNB0hS3qiu4Ng+9UPU+Wmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573951; c=relaxed/simple;
	bh=F1IaxwlgzkyWXV7TDksnuXP1Jqz1CBh4zTlin+l5Hk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwifCzE/gtVJqNXo5fo4nrwx0gcDhibdz1YXGskqXCmw22hWIH91DnpNfHAydPvYZ1boDmbpieM4VF519r6q2fz/SpPb+GxDLHWLP71F5RsjqL+XT/Yi6aSZT5/JXu6fjH7ipo1tKHSdbKk/2NAzKJRsnW+BGZ0kE7o8o4YXRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zgM0Rouz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2W+qfsEAUclS3rHGg1rqVyLJ0A2NtvBKn6a5gu/HE+Q=; b=zgM0RouzKSxSBhQv/D2XkgVoiw
	e8l+KkrofWnaCxW/VswXEPsvHyftp4soRON+mPixqjvrT2AITkMnzKN1rWqrs/Wxp2ezmVGKPkNdu
	cRnsRKEQEhOTsibHhZJqu0ckUkvOO94eOz1ecA+lN7FeJdsyhLkM8gfh64JDVS5eaN6h8D0yD3yEA
	cEFQnGMnIFZFu72GgIkctg9T67YAGC7LJr/Z891SSGX4Od3ZvoVqdBEJuQ0hCFTDxyZSzAvHl0BrE
	Nb1rs8od0pCKYzRUa6KI4B+cqA/Z762ewtE+2piYAXY/y4P7AaVEqDBqM6V7/8yoCfbVhxu3lK+1M
	wVmuLDGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tagMA-0000Cl-1U;
	Wed, 22 Jan 2025 19:25:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tagM6-00059x-00;
	Wed, 22 Jan 2025 19:25:38 +0000
Date: Wed, 22 Jan 2025 19:25:37 +0000
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
Message-ID: <Z5FGMfF1ox-KhFAg@shell.armlinux.org.uk>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
 <20250122174252.82730-2-maxime.chevallier@bootlin.com>
 <Z5E_FUxSZJWRWVAq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5E_FUxSZJWRWVAq@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 22, 2025 at 06:55:17PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 22, 2025 at 06:42:46PM +0100, Maxime Chevallier wrote:
> > When referring to BaseT ethernet, we are most of the time thinking of
> > BaseT4 ethernet on Cat5/6/7 cables. This is therefore BaseT4, although
> > BaseT4 is also possible for 100BaseTX. This is even more true now that
> > we have a special __LINK_MODE_LANES_T1 mode especially for Single Pair
> > ethernet.
> > 
> > Mark BaseT as being a 4-lanes mode.
> 
> This is a problem:
> 
> 1.4.50 10BASE-T: IEEE 802.3 Physical Layer specification for a 10 Mb/s
> CSMA/CD local area network over two pairs of twisted-pair telephone
> wire. (See IEEE Std 802.3, Clause 14.)
> 
> Then we have the 100BASE-T* family, which can be T1, T2, T4 or TX.
> T1 is over a single balanced twisted pair. T2 is over two pairs of
> Cat 3 or better. T4 is over four pairs of Cat3/4/5.
> 
> The common 100BASE-T* type is TX, which is over two pairs of Cat5.
> This is sadly what the ethtool 100baseT link modes are used to refer
> to.
> 
> We do have a separate link mode for 100baseT1, but not 100baseT4.
> 
> So, these ethtool modes that are of the form baseT so far are
> describing generally two pairs, one pair in each direction. (T1 is
> a single pair that is bidirectional.)
> 
> It's only once we get to 1000BASE-T (1000baseT) that we get to an
> ethtool link mode that has four lanes in a bidirectional fashion.
> 
> So, simply redefining this ends up changing 10baseT and 100baseT from
> a single lane in each direction to four lanes (and is a "lane" here
> defined as the total number of pairs used for communication in both
> directions, or the total number of lanes used in either direction.
> 
> Hence, I'm not sure this makes sense.

Looking at patch 2, I don't see why you need patch 1. It's not really
improving the situation. Before the patch, the number of lanes for
some BASE-T is wrong. After the patch, the number of lanes for some
BASE-T is also wrong - just a different subset.

I think you should drop this patch and just have patch 2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

