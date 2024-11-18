Return-Path: <netdev+bounces-145965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4BC9D15D7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D820CB29945
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29751C1F27;
	Mon, 18 Nov 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kH36CJex"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B31C07C6;
	Mon, 18 Nov 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948537; cv=none; b=ZFZk9nLNx69ktgtQ1jzBGMxPHXZrAzyTBdE+WvRuKdW8ad8WGJyVh2QvtdZ1hRRLrK4ngeZ0MDqvY1NqftHyPzCOcj50llw0HL4t7t0YTuRJyUmdRjf1TtdyfQ9LmvS++K3NYFjQM+5vGVzNdsKMmVk43cKLR6OacnQ3OQy4OZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948537; c=relaxed/simple;
	bh=zIQeWwJ+pfS9DFKK3RoUNLwGyQDKX2H45Zh+d447qhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtpsH4bUhc/9Y9swG6pUMeknqMw4tFZtuxPJxOeZ/HN3eTfzk4Z9oDBjO/zA1DZdXA97m0IYtkpmaHPNQBrL0WxwbOGbI/p5ePqPEv2o5HQ432DfT8axYThtf3n4S02keKkLGsy5XccJ0Cx+DE6THziugB/wqQE/cGrrVS/1JuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kH36CJex; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84B08FF804;
	Mon, 18 Nov 2024 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731948532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVJqH9n/jJwlvCP9b5z3vYbe7PNTT4pmvW1puNDkeyY=;
	b=kH36CJexIfTu6JSm/wcRdyWnStbBINE+QSDP80P+q+FDc46VzjkqLWfzAjMe8g97MoS+ni
	NDaCfoquskzKNcln8+epbgANKt8YEKQdrC6MeYoZC/Tj8r4FDyoMJxkmeOEV/smcv93uJc
	N2SIV6lQBJch4wZJR5HaWVGa7kB2ASLArBA52MkyepmmyEIjcjovzHdgtFjohAX0OYD0c2
	b+jxrHwcAhv9xje43WasohKAHv+FysMAwFZl7OiOd8ZrNaFjSNImwdrhopDKmNtsZkLzk9
	1BshxjCQ0hGQivMgjteATbd9as0CrN9/auQGAFKCQexjD/kAvJAQ4LpoCbEVwg==
Date: Mon, 18 Nov 2024 17:48:49 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Yuiko Oshino
 <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/1] net: phy: microchip: Reset LAN88xx PHY to
 ensure clean link state on LAN7800/7850
Message-ID: <20241118174849.5625064f@fedora.home>
In-Reply-To: <20241117102147.1688991-1-o.rempel@pengutronix.de>
References: <20241117102147.1688991-1-o.rempel@pengutronix.de>
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

Hi Oleksij,

On Sun, 17 Nov 2024 11:21:47 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Fix outdated MII_LPA data in the LAN88xx PHY, which is used in LAN7800
> and LAN7850 USB Ethernet controllers. Due to a hardware limitation, the
> PHY cannot reliably update link status after parallel detection when the
> link partner does not support auto-negotiation. To mitigate this, add a
> PHY reset in `lan88xx_link_change_notify()` when `phydev->state` is
> `PHY_NOLINK`, ensuring the PHY starts in a clean state and reports
> accurate fixed link parallel detection results.
> 
> Fixes: 792aec47d59d9 ("add microchip LAN88xx phy driver")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks like the issue in the Asix AX88772A, but your patch has
better error handling :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

