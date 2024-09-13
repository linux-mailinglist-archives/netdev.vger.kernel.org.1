Return-Path: <netdev+bounces-128119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74D97815D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E51F217A1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7E1DA63A;
	Fri, 13 Sep 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bOQlm1wO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A51DA313;
	Fri, 13 Sep 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234836; cv=none; b=irqHrqXYOilNqks1Y4uYx9KA06eSt+3hErU5hKPNKcri9bVU5U5BxSG1f9Gp/2aM6VxavDikK1inXyPQa+0I8YiMWxrKh7X9BTryTZum6O+TsyAOalDHicuiN69dmNB8nTeK0KDdY4u1LaEwwbXr3N0jva2gKpMiMFeZ9DA41Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234836; c=relaxed/simple;
	bh=GwqNWtgSAfwhVL1PGDJn96EYuazBb/NxsQZM2bDXl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TugL3qsRf/NyL1z7QMt3cUpnrR+BHkCVYpDs277LrAMhEX5qSVrOZbS6JGk/cMdLkKck304hFvJ/k+0CSN3rtm125rWWSpCUcIcw043llu8jEFCk5DlTGSlDTTldhY3kXXXEl95iT+070pczeFDhrT9uVF8XztltKXT1XpwttbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bOQlm1wO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dd/M2sQ+n4X121m4YxqzlkNWGkjUh6yL8ADLqSfBv1E=; b=bOQlm1wOdJrJDU52KTANe+QxYr
	8tSjTPZHK8Nmmd3zjztTybESuKXq8F1goZk7XCyHxoVRSDKjqwis7zMIkvSZLIOFwapoaCULc1y+H
	KuAvXd2nT+A0mnUYqe2BRlw5M7lgai6wA9CIkIux3Akmv3SgHZxkCvjviRIqtr/Vfxxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp6XG-007OfV-7D; Fri, 13 Sep 2024 15:40:30 +0200
Date: Fri, 13 Sep 2024 15:40:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate
 modes
Message-ID: <749884b8-9588-4666-8862-e7895cda3d39@lunn.ch>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
 <aae18d69-fc00-47f2-85d8-2a45d738261b@lunn.ch>
 <8372fe02-110a-4fca-839a-a4fa6a2dea74@gmail.com>
 <20240913093453.30811cb3@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913093453.30811cb3@fedora.home>

> With that being said, is it OK if I split the loopback part out of that
> series ? From the comments, it looks like a complex-enough topic to be
> covered on its own, and if we consider the loopback as a NIC feature,
> then it doesn't really fit into the current work anymore.
> 
> I am however happy to continue discussing that topic. Using loopback
> has proven to be most helpful several times for me when bringing-up
> devices.

I agree Loopback is a useful facility, and is something we should
support. But i see it as being a topic of its own. So please do split
it out of this patchset.

	Andrew

