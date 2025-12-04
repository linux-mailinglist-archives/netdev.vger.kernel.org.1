Return-Path: <netdev+bounces-243489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C86CA2130
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 02:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1347301DB84
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40561A317D;
	Thu,  4 Dec 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ywEKReCN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C38142E83;
	Thu,  4 Dec 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764810026; cv=none; b=FgRw/eniQXS8abKNvBWNHt4x8YMuLJX2Bz98lqqszG5AZStT0FLZc9hNgzdESDYS1NKfVr5zEtno0XTjnZXcNRvu+7HpDlt9OfEfKfGN7xA1FGzXLVwNhQx1LJRSwVsa87su0b3u2k0u0GEyJ8B51DLPqbgutKvQHi/tndlddFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764810026; c=relaxed/simple;
	bh=bGZk8WqfEg/McbsI3aL0aGdK/lxrVujdq53rnuD2qy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw8nPgF6/W4tW0jmWeoCRRIrAYZNIrDru+ncOyQlim871QcUu/V0dSIL1qMeRWFhAdMdtrVRdN9Dp7d5twdk13uVv6ZXYXL+NysR0kubUjFb7yLKkGE5yRUjtpBcHUk+0FsmNNFP25nbtD0U4xjUyIfXwrIm9iY61v3x7/Ub+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ywEKReCN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oqc4S5MNoJlL1SElB8hnjLgSsglPrGJqJNIMuDSndMI=; b=ywEKReCN2DEzV1HIh7wCnN30AP
	4nT4ywEfNpDmMOhyYPsu6zFZ4bqHerByz3zuRBA+RUoqXNplp8fC75s64XMSDaDh5658h5Sh8B+kt
	OJMLqRyPY6CFzkbtJsQP7+EV9tjrTTmzX/84o6jmXfd3UBbsXMMP6hYuu+oS5WP0JuIxMmxSFf1S9
	fRXCWF+m4Ynnd7B+2vSsjp1jHOnEA/zUuq74ibgPWRJifVKq+/8PFQjsOgPskfNYl1zBl8qZl4TK6
	fhrgl3EhfURMFJCLSA2/rB5Wbk+qKqka9IHIah2inomF9WKa83sVF12cebANKD+9PiR4etpAsugO6
	yNsxuMWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQxhQ-0000000031S-2EdE;
	Thu, 04 Dec 2025 01:00:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQxhM-000000000Vy-2NL0;
	Thu, 04 Dec 2025 00:59:56 +0000
Date: Thu, 4 Dec 2025 00:59:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aTDdDOCNgSX8PGfu@shell.armlinux.org.uk>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 02, 2025 at 11:38:05PM +0000, Daniel Golle wrote:
> +/* Phylink integration */
> +static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +				      struct phylink_config *config)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> +				   MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	if (port < priv->hw_info->phy_ports)
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	else
> +		__set_bit(PHY_INTERFACE_MODE_NA,
> +			  config->supported_interfaces);

What's the purpose of PHY_INTERFACE_MODE_NA here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

