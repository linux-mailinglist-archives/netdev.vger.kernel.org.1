Return-Path: <netdev+bounces-150452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433B9EA486
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75E718889D7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9D70830;
	Tue, 10 Dec 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PrHYY1z8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672641863E;
	Tue, 10 Dec 2024 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795628; cv=none; b=hQaDOMTdATz4Y1ct5IwL2A02cUwxHRZUPa79Tj3ufvr5XrTRSfdA8xn40tozl6oBkvgBcFcVYn9+vj1swqf7QOqFaPD9D8aubzSaUXi0SIZTB0z1mMSaQGeVjXlOMZCazYlh94A8T/HkwDet9u3ISwjmxexmPGnGyalNBsOfJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795628; c=relaxed/simple;
	bh=0ohP2btiYgvRGCiZ+by5SNw8/jBZ9VC7lNA30/45sQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7UgDsxWOqTL2CkVkRYM8GdwPWgw+ww2SQq4VzrmdP5ImZHT8xXLU1ZhuCibPlH26SrlV44NaLWjF3Wm/D5dkQg1PcjaXx5Q5ET6j5HisU0WjhbNaXNwt+7CRsjxck9nWQTH5umRsj65emA6oHor3Ja0A/7ezKIXGEpTsLvRwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PrHYY1z8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SXp+qtxYbr5cJiQYFPqHbEdcMH4PcZUu6E1u3pNKqeQ=; b=PrHYY1z8LaYBGTRjlMabb+CPuG
	yslmeEFU9rTTL0FCGvDhAUjzexvuxZAG5WSJ/dh4SGH0pXKnkwtnvkPnPzjw33K9/pENQff2qj99/
	vcta6hGz06pCRWoPP7hyhazcKoOzSfovgx4MV8bFzLb8n/sAF2DelRYbaFhPM0BM02S8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpRO-00FjyY-Aq; Tue, 10 Dec 2024 02:53:34 +0100
Date: Tue, 10 Dec 2024 02:53:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 6/9] net: mdio: Add Airoha AN8855 Switch
 MDIO Passtrough
Message-ID: <5aec4a94-3cea-41a4-8500-71472fae51d4@lunn.ch>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-7-ansuelsmth@gmail.com>

> +static int an855_phy_restore_page(struct an8855_mfd_priv *priv,
> +				  int phy) __must_hold(&priv->bus->mdio_lock)
> +{
> +	/* Check PHY page only for addr shared with switch */
> +	if (phy != priv->switch_addr)
> +		return 0;
> +
> +	/* Don't restore page if it's not set to switch page */
> +	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
> +					    AN8855_PHY_PAGE_EXTENDED_4))
> +		return 0;
> +
> +	/* Restore page to 0, PHY might change page right after but that
> +	 * will be ignored as it won't be a switch page.
> +	 */
> +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> +}

I don't really understand what is going on here. Maybe the commit
message needs expanding, or the function names changing.

Generally, i would expect a save/restore action. Save the current
page, swap to the PHY page, do the PHY access, and then restore to the
saved page.

	Andrew

