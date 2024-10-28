Return-Path: <netdev+bounces-139553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC19B2FEA
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460971F2184F
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA61D54C1;
	Mon, 28 Oct 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1UgOiFca"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644017C61;
	Mon, 28 Oct 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117754; cv=none; b=GYhePQWtxL4iVlCBoDeex/dBkLsSYzoOC1CQJnMoN4xEUzvU4e6rgonz6DeBBREhRpVW8FUtm9BCqreJwRrG9TdFRuAzzvMhDWJz3T8HYY7hIC4wcVF+nXw2EnIDtSt7fsWqvgF0N6z9fKI587KuKzVfrOZ03/hRfB63EsBEev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117754; c=relaxed/simple;
	bh=O2LI6GeA7bzWum/HwFra02rf1RZdoj9wHSd/1i5tG8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF35owyp/xw0OSxvFOMUryWIqNkvDOG7qxTHuZTX+AJx27WX2+Hk4sc7x1o6iGN70SuWqJPDfJg2aoinu+saD7NG9O0Aee0Rtl3cpk0MfJCVyYrWtgYtM7J5MTPBhfPVNUpxwfFZnBPQyy1ijlPnjWrrzpRu2UYOcBH5V+XRXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1UgOiFca; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bc8wK16jbYKvsClA+UMWH5S2LIjpv7VI3qWUGCUGwD8=; b=1UgOiFcajg15LCQ9mREvnXk7um
	jD03OyPm5yFSJMy/zMRL3kLI1y3VOtTs7z5vyByxQHBP9LsKfePnpOGcrIUbuCptIQ/o4VwbYwEhc
	NeynBQZTwLaqdKhIWL9INlT7DBNpkhPoYffOHAfxTYsSvjMYc95iRbNWiOxgQW2bAju0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5Oes-00BRTp-1E; Mon, 28 Oct 2024 13:15:42 +0100
Date: Mon, 28 Oct 2024 13:15:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: dsa: microchip: add support for
 side MDIO interface in LAN937x
Message-ID: <20c0ed0f-712d-46d4-8a49-e92835f47f9e@lunn.ch>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-6-o.rempel@pengutronix.de>

> +static const u8 lan9370_phy_addr[] = {
> +	[0] = 2, /* Port 1, T1 AFE0 */
> +	[1] = 3, /* Port 2, T1 AFE1 */
> +	[2] = 5, /* Port 3, T1 AFE3 */
> +	[3] = 6, /* Port 4, T1 AFE4 */
> +	[4] = U8_MAX, /* Port 5, RGMII 2 */
> +};

I think it would be good to add a #define for U8_MAX which gives a
hint at its meaning.


> +	for (i = 0; i < dev->info->port_cnt; i++) {
> +		if (phy_addr_map[i] == U8_MAX)
> +			dev->phy_addr_map[i] = phy_addr_map[i];
> +		else
> +			dev->phy_addr_map[i] = phy_addr_map[i] + offset;
> +	}

My first guess was that U8_MAX means the PHY is external, so could be
on any address depending on strapping. Looking at this code, i'm not
sure it does actually mean that.


    Andrew

---
pw-bot: cr

