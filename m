Return-Path: <netdev+bounces-140824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5729B85D2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2261C21A94
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E51C2DA4;
	Thu, 31 Oct 2024 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6aHHFGgs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBB13AA41;
	Thu, 31 Oct 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412065; cv=none; b=PaVD0bparIxiYxzyDOL6rA5MpN8IdcLx0AynZEX+BsVX8a33NGpOg5zsX8vsxQe42AFk/jcgm2K0TBEksTLqVdrIETHb6GBk4/NGcm0Sa6Xvp3aTAsmC9rP1N3rW6njh5CyFgpVLMumdWmNVnetj5k5X6ai93GyzmqqbYHx04K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412065; c=relaxed/simple;
	bh=mli1Atw6PyXuvECUxOl9Z+txoGCag/Z+uJErvLmuJCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4IbjYQCEv+aliqtAJ+sE5vTn0zkP15OFS6SxB/r/A+Bm/0Cx1m81WG8ApwFuK5LUlbK0rwx88s9FGXCWgX+rb7Ib3kexDpogqS4msSgpORf1cbFOmws0dVkjF69pceYzAmTFZDlSG/lDrKp64g97CHD0KAyv6L28rY5rzlkQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6aHHFGgs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GwToQwxM8kx7q3+HzuWGhIps5K52U+9AhM85wKa6nTo=; b=6aHHFGgsFHmGujFuTpmy4m85ty
	PXAJmHSysIhatnVT8OXmx2HmlFs13uWO1i9UtTZ/ICdlbtTDErRH2SmxdzGA1pt6XVDLVIw5LLmNn
	OvK+nKs3trl5ni9W1L2dFEUACSWnOPJRog9O5oQ1iT534oxmxLQYwtIkthGhWcPoRJEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6dDk-00Bp7o-Tu; Thu, 31 Oct 2024 23:00:48 +0100
Date: Thu, 31 Oct 2024 23:00:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 08/18] net: pse-pd: Add support for
 reporting events
Message-ID: <1ce06df3-e092-47a8-bec6-8829eeb826bc@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>

> +static unsigned long pse_to_regulator_notifs(unsigned long notifs)
> +{
> +	switch (notifs) {
> +	case ETHTOOL_C33_PSE_EVENT_OVER_CURRENT:
> +		return REGULATOR_EVENT_OVER_CURRENT;
> +	case ETHTOOL_C33_PSE_EVENT_OVER_TEMP:
> +		return REGULATOR_EVENT_OVER_TEMP;
> +	}
> +	return 0;
> +}


https://elixir.bootlin.com/linux/v6.11.5/source/include/uapi/regulator/regulator.h#L36

 * NOTE: These events can be OR'ed together when passed into handler.

ETHTOOL_C33_PSE_EVENT_OVER_* are also bits which could be OR'ed
together, so is this function correct?

	Andrew

