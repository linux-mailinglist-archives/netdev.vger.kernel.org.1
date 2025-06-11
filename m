Return-Path: <netdev+bounces-196579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EAAD5754
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7E87A7EC5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FA29AAF0;
	Wed, 11 Jun 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVgMGJU0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34528C037;
	Wed, 11 Jun 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648994; cv=none; b=C5zjstb2lidWxf94a/8mvFvB/jn7k+ss+PLHIbTbINsswgrzSsWr4pxxW61/f7Xzx7Wxd9wYj0O37NYRqCxZPFv6ddzqHGYHfo6+O5EiNS2sY1Pf+NemYapINXkMf3PFcWGlEh/NgeInd8iFivhrjFwBHzw2qKUiAZMEAOKmO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648994; c=relaxed/simple;
	bh=qxeEX+fpLYiFMxZjd8T8WFKqd8/tarfK/1nXUbP+oow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3j494GdEfFM+myfAyp1KgSww09c9Std2z4DlzRW+FVccuPOL8zPMBIBCkX1nQwzKGfxOVWxIptZA8Sjx0kqUPBrDXbITh9irD/WVft2V/24ysPIM1FojuaPgbNE07+8Sy8jDkWMkp2JuBov0mQEuqbiZ7EtG9VSaUvTXLA6JMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DVgMGJU0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vVK1lv1eg0ugU/Wlcq0qw8RSX2k3WrhR6fk/iNeFFPc=; b=DVgMGJU05gH/oIK5E5D9B47wVC
	GIR3UdOd8V+Wd5k0QiTngzWgSaDshWYZqcxKeXPOgRgvN7NV/q6mfkM2faOnAzMEBNdMRH/wAYIvp
	dZxers4Mp06vL74YaphTtZ+8PSeLS76pFIIro7UzfXnc0Ong0p1ps2qiJrDJOOtQYGcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPLcV-00FOq5-P6; Wed, 11 Jun 2025 15:35:59 +0200
Date: Wed, 11 Jun 2025 15:35:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gal Pressman <gal@nvidia.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
Message-ID: <78daedb4-afe7-429d-9447-a3f76ea65e16@lunn.ch>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
 <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
 <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
 <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
 <20250609160346.39776688@kmaincent-XPS-13-7390>
 <0ba3c459-f95f-483e-923d-78bf406554ea@nvidia.com>
 <cfb35f07-7f35-4c1f-9239-5c35cc301fce@lunn.ch>
 <b1b7b052-ceac-4119-9b72-ed8f4c1fbfe2@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b7b052-ceac-4119-9b72-ed8f4c1fbfe2@nvidia.com>

On Wed, Jun 11, 2025 at 09:05:01AM +0300, Gal Pressman wrote:
> On 09/06/2025 18:12, Andrew Lunn wrote:
> >> I think that in theory the userspace patches need to be posted together
> >> with the kernel, from maintainer-netdev.rst:
> >>
> >> 	User space code exercising kernel features should be posted
> >> 	alongside kernel patches. This gives reviewers a chance to see
> >> 	how any new interface is used and how well it works.
> >>
> >> I am not sure if that's really the case though.
> > 
> > The ethtool Maintainer tends to wait to the end of the cycle to pick
> > up all patches and then applies and releases a new ethtool binary. The
> > same applies for iproute2. That means the CI tests are not capable of
> > testing new features using ethtool. I'm also not sure if it needs a
> > human to update the ethtool binary on the CI systems, and how active
> > that human is. Could this be changed, sure, if somebody has the needed
> > bandwidth.
> > 
> > Using the APIs directly via ynl python is possible in CI, since that
> > is all in tree, as far as i know. However, ethtool is the primary user
> > tool, so i do see having tests for it as useful. But they might need
> > to wait for a cycle, or at least fail gracefully until the ethtool
> > binary is updated.
> 
> Thanks Andrew, so I interpret this as selftests should be added when the
> userspace patches get accepted (or released?)? Not part of the original
> kernel submission?

I personally would submit the tests at the same time, but make them
gracefully fail when the ethtool binary is too old. As a reviewer,
seeing the tests as well and the ethtool patches and the kernel code
gives me a warm fuzzy feeling the overall quality is good, the new
code is actually tested, etc and the code should be merged.

     Andrew

