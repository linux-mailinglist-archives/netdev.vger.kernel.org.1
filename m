Return-Path: <netdev+bounces-170791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7BA49E9D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C724A189AA96
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7026FD90;
	Fri, 28 Feb 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FWoQPC9/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B427424C;
	Fri, 28 Feb 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759667; cv=none; b=YMXuDAamy+KU/8GxBRO0SmXGRtfTWqEywq9bDbq0AV3iFos+1DrdhgJSvqVD2aVAgaghcqjFPdul0F7CjtRii26z9H5hiJ7a3okUdpj3iK82atcmxh7GLNq60Z8IMS3QbG73k+5prgPS/p+d4ywSBqSTyp4PFP8pnB7Y3LBuCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759667; c=relaxed/simple;
	bh=wbDlZs83q9nSJBcspWE8sY3NN7ghhsdeyh2OCYDmE3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/bB7+GQM75/hmT0sMYK2WqxOPskf6iewWjhn7Fyy1czIVcbnlKgVx+0hdhPtGE9el7BFCPy3iB/isHynKWYRwL72/K/hFcwWw+J8ueDwVOAM5QqDGttFjLFtT9GEA35uvgQ6qCtKpOv8CJ/2XTW+mgrzZlmlt2nSwDwSXt2UyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FWoQPC9/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oR07+ur7lR44DlmDxnBOEhptZ0qh61GqcpjU+2E4Clc=; b=FWoQPC9/BSHpE+CDHKOSEiEyaV
	gGMRbdkpgy5zx1Vv0PvZeWkM+f9kzH4A6KNW9P2pgGMTKGv+cflMsancxgoW8Y1g61xPVuvI3qppo
	a3H8x+wb+LxuQeffrrBmJZ9EdbUdNxPEa8cLNNhPzYun0M5Ayy3oBoONars22+rO+jho/CVR+qTsu
	Bx2Q9H1BuZEg66jk/81Vb2mc6mQKEop/cd979oPWgx8aDgON84Tueuqu2h+Mr7hUFSemOXYZcUf08
	GABNqxPi1MLomYpaXXdmDdWaLYALkmWONnrPug9TZtyfEN3l6coyuc849rKkxqPlpfArF2OLeaLaB
	6FwBcLMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47038)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1to36e-0002NQ-2G;
	Fri, 28 Feb 2025 16:20:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1to36c-0000sw-1y;
	Fri, 28 Feb 2025 16:20:54 +0000
Date: Fri, 28 Feb 2025 16:20:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v3 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <Z8HiZpxPLy9YKTsf@shell.armlinux.org.uk>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
 <20250228145540.2209551-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228145540.2209551-10-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 03:55:34PM +0100, Maxime Chevallier wrote:
>  	adv = pl->link_config.advertising;
>  	linkmode_zero(adv);
> -	linkmode_set_bit(s->bit, adv);
> +	linkmode_and(adv, pl->supported, c->linkmodes);

There is no need for linkmode_zero() with linkmode_and() immediately
after. linkmode_and() writes to its entire destination.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

