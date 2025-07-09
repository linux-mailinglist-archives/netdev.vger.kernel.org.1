Return-Path: <netdev+bounces-205447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96664AFEBC5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0467B188CA28
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1982E4266;
	Wed,  9 Jul 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DSgRT7ZD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2801482E7;
	Wed,  9 Jul 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070682; cv=none; b=Nx6lUSpIAL+4BT1AGXZ/BXDJs6rWLJDaZrVRyRwvEHBGLhcc0WPOciekvJ22DbqfrLd4OPyWRtuQvWny7XwadrJOu9O5Q61UEiC3cnPZt7sW2wbk/9IKsvenNErR+SvkeEMpaPDy6bT6KGaLWBn0er7FPS0r9He0V7+MCqO200w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070682; c=relaxed/simple;
	bh=3GPtKOUtSTIseNHeCofjHeHZYBz2CDmdTP88RpiaJno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRY0ter/URrfOGSiUxywiRdPjXKj7nQJdz1ENLQFhwhAJHrp2Woh9zvGyNYhQVNS5lyE1KzeF3VEhzTjwhI38ClK8PArW4pVf6yoIG7cDOug3zMa/mjPS4k/TaXwPcqhNnHqHqOgydZS+NKdP08aA34prrEXWKsjCJpoLJwUqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DSgRT7ZD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=99zglpx7L+yZpJYgis1C9cvS9FD00F06Jap26C53nDk=; b=DSgRT7ZDjh8nhXxM8g9IIasnky
	kmYuaFcfFiyBr+qAAhPrcq5iddIwIb4uub6zHDoYsJwSJejUpKG+i8sTJPzktSDvDkBC470g+gUsk
	q9ZQD5KM7DCx2a1UYOmqNATPJjNCNhgZO2CL6tddGOykzE1gJh3hjIzohQEcBDo/dwBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZVcO-000wyz-OX; Wed, 09 Jul 2025 16:17:52 +0200
Date: Wed, 9 Jul 2025 16:17:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 2/2] net: phy: microchip: limit 100M workaround to
 link-down events on LAN88xx
Message-ID: <a6c2059c-487b-4e00-9399-b98d867168b5@lunn.ch>
References: <20250709130753.3994461-1-o.rempel@pengutronix.de>
 <20250709130753.3994461-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709130753.3994461-3-o.rempel@pengutronix.de>

On Wed, Jul 09, 2025 at 03:07:53PM +0200, Oleksij Rempel wrote:
> Restrict the 100Mbit forced-mode workaround to link-down transitions
> only, to prevent repeated link reset cycles in certain configurations.
> 
> The workaround was originally introduced to improve signal reliability
> when switching cables between long and short distances. It temporarily
> forces the PHY into 10 Mbps before returning to 100 Mbps.
> 
> However, when used with autonegotiating link partners (e.g., Intel i350),
> executing this workaround on every link change can confuse the partner
> and cause constant renegotiation loops. This results in repeated link
> down/up transitions and the PHY never reaching a stable state.
> 
> Limit the workaround to only run during the PHY_NOLINK state. This ensures
> it is triggered only once per link drop, avoiding disruptive toggling
> while still preserving its intended effect.
> 
> Note: I am not able to reproduce the original issue that this workaround
> addresses. I can only confirm that 100 Mbit mode works correctly in my
> test setup. Based on code inspection, I assume the workaround aims to
> reset some internal state machine or signal block by toggling speeds.
> However, a PHY reset is already performed earlier in the function via
> phy_init_hw(), which may achieve a similar effect. Without a reproducer,
> I conservatively keep the workaround but restrict its conditions.
> 
> Fixes: e57cf3639c32 ("net: lan78xx: fix accessing the LAN7800's internal phy specific registers from the MAC driver")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

