Return-Path: <netdev+bounces-130445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A798A8CE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC53B28E75
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238D194083;
	Mon, 30 Sep 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjkCG+dq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA738192D65;
	Mon, 30 Sep 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710727; cv=none; b=L81aUCA0kSv+Ah7E/I6P3OWR9ORuahY3+5KO+OzLeR7WbRRaPP06F0SpR0wFrAPV4qM5YBw427nDjUW8tRImfT0l5ifeSOn6rvPue6wNVxRh6EUi+kRdY1dirvc/zJ8DDin7QnKzjBgCo1TXSRo6G+zlzjePiljridjOVmBDKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710727; c=relaxed/simple;
	bh=ljKsVqRBvEkM+olNY3fXUkhkclqocYdk/0qMOp/1jrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOxz6rjsDQYdO0I4dA5b6+stLdaCZk60rz60ltG0UF3cV6LW5fgNJfqPP+Ev+1J2B/Kk3XK/ThktE60Xk3wKyA3o1ZGrxTOj3UarI9gFonOBFOAql3wojUAJDB8NHwMJzF+Ix97nu+mMwvxphkxfKa6gUrWRdfP4rIu8fSN6zQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjkCG+dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB1BC4CEC7;
	Mon, 30 Sep 2024 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710726;
	bh=ljKsVqRBvEkM+olNY3fXUkhkclqocYdk/0qMOp/1jrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjkCG+dqklP7pWLF42/5Py/n8kCrcWqGEpHb0rNQcoMnKUemB9VBigVqAzPldBb94
	 HjZElfHM+MmvR5/naiyhvjz7GAahD0xKpduP+B9PT1uYxheDwR0IXhjNsY7gqVvgoL
	 7c/QxJabUl34XZLDVrWXjt8PnXMaJwsF8tIzEw8PpA+ZDfIZ8tdhNHwJZXaYjtLWmU
	 sKxv4D7Ja/UNhHv+xU9aYXfEZ16oby6RRuQAOkciPKmmekiz49Nr6lPh1PvX94co+V
	 Q2i42o80HUISj8qyDSJqFqx/TCFFTKbuViVAtPm/+vDZLYeUfaPIp5Rl+eIyUebk4s
	 zk5d13l7Jf5Sg==
Date: Mon, 30 Sep 2024 16:38:41 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Bauer <mail@david-bauer.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: mxl-gpy: add basic LED support
Message-ID: <20240930153841.GD1310185@kernel.org>
References: <55a1f247beb80c11aa7c8a24509dd77bcf0c1338.1727645992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a1f247beb80c11aa7c8a24509dd77bcf0c1338.1727645992.git.daniel@makrotopia.org>

On Sun, Sep 29, 2024 at 11:02:16PM +0100, Daniel Golle wrote:
> Add basic support for LEDs connected to MaxLinear GPY2xx and GPY115 PHYs.
> The PHYs allow up to 4 LEDs to be connected.
> Implement controlling LEDs in software as well as netdev trigger offloading
> and LED polarity setup.
> 
> The hardware claims to support 16 PWM brightness levels but there is no
> documentation on how to use that feature, hence this is not supported.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/mxl-gpy.c | 212 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
> 
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c

...

> +static int gpy_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				  unsigned long rules)
> +{
> +	int ret;
> +	u16 val = 0;

nit: Please consider arranging local variables in reverse xmas tree order -
     longest line to shortest.

	u16 val = 0;
	int ret;

> +
> +	if (index >= GPY_MAX_LEDS)
> +		return -EINVAL;

...

