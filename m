Return-Path: <netdev+bounces-195742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DADAD2216
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E0E3A1AB5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF861A2C0B;
	Mon,  9 Jun 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MtYyNbCc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BD55E69;
	Mon,  9 Jun 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482000; cv=none; b=JQa5siEZlxVNpVbG85tY/5RssB5Agux43/8pY95KgzcMZHMBiZyGNq82WLqDJmP9HCK5Whh7lXXT3bsJX3LujQhXH32xGkGLPkJatqeumSd9VeYXlzQugYqio2utL8nxr03XHpvioDD67ta1OOuCuE6CneVCdb6V4n6vrhLVJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482000; c=relaxed/simple;
	bh=KuL9QXFnbjP/6dnmbITZhX26APLbHlD5cgbjI49fUGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaNZPGwqWPiwuj5Aal9V27C1CsGxQbPfuL+of40lqRKyHSUTTlJDe62w2fD0SQNKSFpP+Gnp7EwMNWG0/Q6GEhosnXvxyRB/egDI55E+0RB2JEeIhDK1NRjf9Ai36jEP3XRN+7kQbAhkKhVeBtaxFr6z8pC+caXZpj2BaGFojrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MtYyNbCc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqSBvYEPHPitebv2P1vYqvusEdj1tCP+6lQ1cirEEtc=; b=MtYyNbCc0fiTVgvVYWBKHGqS+i
	8JxYiM6H+jVbkkHdygJCAruCGLEUS12pUfUNI4sBp0U1tG4yB6sZ+IUm3DSdE35d8gbJutci6jTxj
	EFtec3cdQ5z5CZGDgKcouSAZmkr7KF47BcvSZuTeARGZvl/7UJ8WFt3+TDvVonkwOx4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOeBG-00F9zg-2A; Mon, 09 Jun 2025 17:12:58 +0200
Date: Mon, 9 Jun 2025 17:12:58 +0200
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
Message-ID: <cfb35f07-7f35-4c1f-9239-5c35cc301fce@lunn.ch>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
 <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
 <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
 <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
 <20250609160346.39776688@kmaincent-XPS-13-7390>
 <0ba3c459-f95f-483e-923d-78bf406554ea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba3c459-f95f-483e-923d-78bf406554ea@nvidia.com>

> I think that in theory the userspace patches need to be posted together
> with the kernel, from maintainer-netdev.rst:
> 
> 	User space code exercising kernel features should be posted
> 	alongside kernel patches. This gives reviewers a chance to see
> 	how any new interface is used and how well it works.
> 
> I am not sure if that's really the case though.

The ethtool Maintainer tends to wait to the end of the cycle to pick
up all patches and then applies and releases a new ethtool binary. The
same applies for iproute2. That means the CI tests are not capable of
testing new features using ethtool. I'm also not sure if it needs a
human to update the ethtool binary on the CI systems, and how active
that human is. Could this be changed, sure, if somebody has the needed
bandwidth.

Using the APIs directly via ynl python is possible in CI, since that
is all in tree, as far as i know. However, ethtool is the primary user
tool, so i do see having tests for it as useful. But they might need
to wait for a cycle, or at least fail gracefully until the ethtool
binary is updated.

	Andrew

