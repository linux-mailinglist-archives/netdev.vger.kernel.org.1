Return-Path: <netdev+bounces-232393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D6C05445
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D09AD4EF74B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835ED308F2A;
	Fri, 24 Oct 2025 09:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C93090D2
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297075; cv=none; b=t8aB0kUFoefP7SENqDSgtO/hxoPD0bTsPJpTWmy8+NtQBTBHpK/dbtF+FWa86NLO+JkrHnkucBWRTczxZtwHNiLqVf1JOjq9VUdA0hxQzqzqQunFZ6O32miCG825fVeQUT7YrJRrGMceqXaun1NvY5g8phZDA3Mu+cEH/DfpTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297075; c=relaxed/simple;
	bh=PUrfg4uGr+Oo/Ca7SJXLcnhod6KTFMtdEP9m1BKO36A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+oM8w+bhUMhfAITTQcAnwTkjiyjxjFvutV4bjgA7hACO0oqrFoG7ajEiyQ3syADVol46o3PLuAAu5fOzFTKBoJWf3XjyV1UE2Eup8KWzwPHDQl/IOotLvTzRcBd6Qm0x5UNSxWQDkt739GPQmENZiytgudt5P6nr7Gyl01qyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vCDpI-0000nP-3w; Fri, 24 Oct 2025 11:11:12 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCDpF-005Ca4-31;
	Fri, 24 Oct 2025 11:11:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCDpF-00F7An-2b;
	Fri, 24 Oct 2025 11:11:09 +0200
Date: Fri, 24 Oct 2025 11:11:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next] net: loopback: Extend netdev features with new
 loopback modes
Message-ID: <aPtCrc6EPpn_hcYp@pengutronix.de>
References: <20251024044849.1098222-1-hkelam@marvell.com>
 <e9aa0470-2bd2-4825-8333-ad9dbc7f40a0@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9aa0470-2bd2-4825-8333-ad9dbc7f40a0@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Oct 24, 2025 at 10:46:14AM +0200, Maxime Chevallier wrote:
> Hi,
> 
> +Russell +Oleksij
> 
> On 24/10/2025 06:48, Hariprasad Kelam wrote:
> > This patch enhances loopback support by exposing new loopback modes
> > (e.g., MAC, SERDES) to userspace. These new modes are added extension
> > to the existing netdev features.
> > 
> > This allows users to select the loopback at specific layer.
> > 
> > Below are new modes added:
> > 
> > MAC near end loopback
> > 
> > MAC far end loopback
> > 
> > SERDES loopback
> > 
> > Depending on the feedback will submit ethtool changes.
> 
> Good to see you're willing to tackle this work. However as Eric says,
> I don't think the netdev_features is the right place for this :
>  - These 3 loopback modes here may not be enough for some plaforms
>  - This eludes all PHY-side and PCS-side loopback modes that we could
>    also use.
> 
> If we want to expose these loopback modes to userspace, we may actually
> need a dedicated ethtool netlink command for loopback configuration and
> control. This could then hit netdev ethtool ops or phy_device ethtool
> ops depending on the selected loopback point.
> 
> If you don't want to deal with the whole complexity of PHY loopback, you
> can for now only hook into a newly introduced netdev ethtool ops dedicated
> to loopback on the ethnl side, but keep the door open for PHY-side
> loopback later on.

Ack, I agree. I would be better to have information and configuration
for all loopbacks in one place.
Will it be possible to reflect the chain of components and level of
related loopbacks? I guess, at least each driver would be able to know
own loopback levels/order.

Please add me in CC if you decide to jump in to this rabbit hole :D

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

