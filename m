Return-Path: <netdev+bounces-242335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87039C8F57B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AC564EAFB0
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E3337B9E;
	Thu, 27 Nov 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="To+/2/5G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5A337BB0;
	Thu, 27 Nov 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258553; cv=none; b=NE0oPTgYRBmHbN513sMlWEtyLf8Z1G6HXta73lHHKlDtJM8pJv7rWtvqK9Aj0TGMQjrCxNj+j2EkHgH4oHHuUXN6HTaWj/qhMTE+MHO6IsbqZjPh0c8cdklOhREpoCZqTC6Xd+GT8ydmEEFgPGnhMyyMy4hMAAUcFmlG8NDoMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258553; c=relaxed/simple;
	bh=eDMbpAVf9tv0cALYXqKdJIMQtTPrM2/t2PPnB3VGjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olbfB/5ji+dHGMpIFF6UyCnWOjiv6QJbYIkV2XQ/0ZJ8klduwtxApmLPE2aosnxUKYdTx9jayiv3qRRx0OkORJOMu5zHLPYpEvdCXJPlP5E3EaQQkRZ3NuMUi+B8nw4neXh0gTcOS7ab4LUXIS6Q4miAQadEqDy4BpGq2zOR2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=To+/2/5G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZCrpEUs2sWevEnbP0A8mu55IH+2DaUU1JZqTRZR1rvc=; b=To+/2/5G8oK9aOOXY4ZIOjQwuo
	wc7925gbfnff24uCjR/iGtAb0teUTEmjsmJ/IjcZnyMB8yJ30LwgZpzom688pC1PLdPFBE19cvlTe
	BHesTODBUqYZlot+qblmOmnDRzd/wgGNpL3YbxoaIRuq4kOi4UC+4vA8uUGreMcEUKbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOeEc-00FHCp-Ve; Thu, 27 Nov 2025 16:48:42 +0100
Date: Thu, 27 Nov 2025 16:48:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
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
Message-ID: <b4ae88a8-3db7-434a-92d8-90734f6d7682@lunn.ch>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org>
 <aSgX9ue6uUheX4aB@pengutronix.de>
 <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
 <c14b1dae-142e-4038-92a9-cfcad492f4e2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14b1dae-142e-4038-92a9-cfcad492f4e2@bootlin.com>

On Thu, Nov 27, 2025 at 04:31:50PM +0100, Maxime Chevallier wrote:
> Hi Andrew
> 
> I am sorry, I have a bit of sidetracking...
> 
> >> State Persistence and Toggling When toggling autoneg (e.g., autoneg on -> off
> >> -> on), should the kernel or driver cache the previous advertisement?
> > 
> > This has been discussed in the past, and i _think_ phylink does.
> > 
> > But before we go too far into edge causes, my review experience is
> > that MAC drivers get the basics wrong. What we really want to do here
> > is:
> > 
> > 1) Push driver developers towards phylink
> 
> Is it something we should insist on in the review process ? Can we make
> it a hard requirement that _new_ MAC drivers need to use phylink, if the
> driver plans to interact with a PHY ?
> 
> phylink has long outgrown the original use-case of supporting SFPs by
> abstracting away the MAc to [PHY/SFP] interactions, it's now used as a
> an abstraction layer that avoids MAC drivers making the same mistakes
> over and over again on a lot of cases that don't have anything to do
> with SFP.

This is something i've been considering for a while.

Maybe for the last year, when i have seen broken pause, i've been
reporting the problems but also pushing developers towards
phylink. phylink also does all the business logic for EEE, and is
starting to get WoL support. So we really should be pushing developers
in that direction.

Is it time to deprecated direct phylib access?

I think the answer is Yes.

	Andrew

