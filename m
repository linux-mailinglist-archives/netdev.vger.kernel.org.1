Return-Path: <netdev+bounces-180841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8671A82AC7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E68A276E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20A267395;
	Wed,  9 Apr 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j9uL2eh2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5795265626;
	Wed,  9 Apr 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212899; cv=none; b=p+fDQn4caJ+D1sr/wUhWbED+aXRqxI7C5LnAOv8jbVEVRU9x5z2Kw9sgpZlceoYV/+gngE+dgYu4KHLUAcai+PXjkEWsjxzEp0+0Wr5axwIZZhyk+VPVfKiwstNx5X8qQq94tC4aY+7EwqIdQZmFp9PYJ6exgvzqiEAwomsSu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212899; c=relaxed/simple;
	bh=2F9ePwMOxedJqYbn7dmyp4HRv06kb5YhvYQjEyOtXTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrXU8jmxp1YHFtcfmkilzBDPe/z3bCBQP93g/TaJCwG2beOTr89SRy71141mCS/gRbPpy63eaooaJB77ZoDTyQPZ1HnyUCmxEMGs0D2AfYG448/g7eibO7TkEIFVetuRyyRmY5KJ/x/+IVuvD1zqlCPBJemjz332eqoN/G//d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j9uL2eh2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7+t1ge5BiFrWMuX3el6edD85lJu9VSjsiGni54gW/Hw=; b=j9uL2eh2kAvrnoa8WvjGKPX4Aq
	smp8i/JKeRZJsGJvIxVHP60lQYjYV1f0T6Zqj77+x4Tm14zLFFZ66Z9FCDztWevX9SPCR9YXQHm6/
	mXX7r4TjW9DsOIfNl2+b4jJPScglD1CRH43pYHPmIicyuIJLr8t4DtVKfy7+STaNjyMRBV0i8pUA9
	nUMyXLGm+n23kFpFRI1kHvsk10ZW4OQCPRhur54+q7CsnLTBHOne3/hFKiFMj8XHIyGH7W/+I3GNw
	TgmdS1HZUXxDl2QQ+wtwzPKEk+RjPcq4axQU37Ybc9O8Pgux+bx8bmeWfrMdy4Zo8+aGrm1uDX63C
	lJj1ABcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37870)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2XRo-0000jA-1R;
	Wed, 09 Apr 2025 16:34:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2XRk-0002g8-2k;
	Wed, 09 Apr 2025 16:34:36 +0100
Date: Wed, 9 Apr 2025 16:34:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_aTjBrUw79skcAg@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> timestamping the egress and ingress of packets, but does not support
> any packet modification.
> 
> The PHYs support hardware pins for providing an external clock for the
> TAI counter, and a separate pin that can be used for event capture or
> generation of a trigger (either a pulse or periodic).  This code does
> not support either of these modes.
> 
> The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> drivers.  The hardware is very similar to the implementation found in
> the 88E6xxx DSA driver, but the access methods are very different,
> although it may be possible to create a library that both can use
> along with accessor functions.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add support for interruption.
> Fix L2 PTP encapsulation frame detection.
> Fix first PTP timestamp being dropped.
> Fix Kconfig to depends on MARVELL_PHY.
> Update comments to use kdoc.

Would you mind forwarding me the changes you actually made so I can
integrate them into the version I have (which is structured quite
differently from - what I assume - is a much older version of my
patches please?

The PTP IP is re-used not only in Marvell PHY drivers but also their
DSA drivers, and having it all in drivers/net/phy/ as this version
has does not make sense.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

