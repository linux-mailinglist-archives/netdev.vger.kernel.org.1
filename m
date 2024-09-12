Return-Path: <netdev+bounces-127738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF4976424
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39D0B21F0E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5D18E764;
	Thu, 12 Sep 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z5Jsz3Mj"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229F339BC;
	Thu, 12 Sep 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128923; cv=none; b=d+R/0CeaGXAuJgtefMYWn8Jsfx9psuvES/YraFjGWXRWaBbOSVMgWhqevUbT94VTMx97B0ZauW90LizPRjkHRGvTmTb6j2hfVk9zy/UWcIXfNuqiTmIpdE1MVqXhtgqRDPqJEeXrveFgRbpSyVnox0aD66ngYzJevXfcXSSyLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128923; c=relaxed/simple;
	bh=ePG45YEm1FarOCnJBfW0BOh4vtu3CccfI/l+E4sys6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8YbPl/i2vgf5UqXk7CLH5UxYae3F91d92Jcnbrk69tAND/S17vV963ZAgJmWkBooTKdeDd/OCuZpU2LXVuq4boeu8FYut25B6dhFKHBkepnARQ9qRmbt4nSLJBGP57R+8fFU7jnuYucOxcgfI+4ioDdxoxjMcq6/ot6u8g0Ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z5Jsz3Mj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED6201BF205;
	Thu, 12 Sep 2024 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726128919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhi1nnvn70H7OcO5v9lRE1g1qsUgFUHYEvrguwUMnsE=;
	b=Z5Jsz3MjcfDVKF1S6rrgjTSMYhysRHst3Yg3TBKEjXc78YPg2PmofKuu3n49MryzykKHfN
	jjrU2BOElDqPFVp75uQ3lwuPAP7DEAZpKEeLcA/oykI3j1HI6ouC/DM+BGiYUWu8ZUUaQZ
	Hx+78b3am6KVoijrbT4Fk2RmwLSOpxlRUozjrJCCrrlzVkfubhSQd4gAaixPFxd7rjE2n1
	+8G07KlZ5XaY/2yC/hQkmDbtUydZOH/IAlaXOMUdIF7PmeUGbT+JBgGinRUk+LoNmeXMFO
	JN6gTUZJ+lRN8oX9MIUQbYzG5YievGi7Tv8gx8GRAHbTXbBRHwu0vvB4NOGl+A==
Date: Thu, 12 Sep 2024 10:15:12 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate
 modes
Message-ID: <20240912101512.5d33335d@fedora.home>
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 11 Sep 2024 23:27:04 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello everyone,
> 
> This series brings support for controlling the isolation and loopback
> modes for PHY devices, through a netlink interface.
> 
> The isolation support work is made in preparation for the support of
> interfaces that posesses multiple PHYs attached to the same MAC, on the
> same MII bus. In this configuration, the isolation mode for the PHY is
> used to avoid interferences on the MII bus, which doesn't support
> multidrop topologies.
> 
> This mode is part of the 802.3 spec, however rarely used. It was
> discovered that some PHYs don't implement that mode correctly, and will
> continue being active on the MII interface when isolated. This series
> supports that case, and flags the LXT973 as having such a broken
> isolation mode. The Marvell 88x3310/3340 PHYs also don't support this
> mdoe, and are also flagged accordingly.
> 
> The main part needed for the upcomping multi-PHY support really is the
> internal kernel API to support this.
> 
> The second part of the series (patches 5, 6 and 7) focus on allowing
> userspace to control that mode. The only real benefit of controlling this
> from userspace is to make it easier to find out if this mode really
> works or not on the PHY being used.
> 
> This relies on a new set of ethtool_phy_ops, set_config and get_config,
> to toggle these modes.
> 
> The loopback control from that API is added as it fits the API
> well, and having the ability to easily set the PHY in MII-loopback
> mode is a helpful tool to have when bringing-up a new device and
> troubleshooting the link setup.
> 
> The netlink API is an extension of the existing PHY_GET, reporting 2 new
> attributes (one for isolate, one for loopback). A PHY_SET command is
> introduced as well, allowing to configure the loopback and isolation.

One thing I forgot to mention is that the phy-tunable API could also
possibly be a place to set these parameters instead of this new command.

Maybe this would be the preferred way ?

Thanks,

Maxime

