Return-Path: <netdev+bounces-140819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468249B85A7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B08280F6C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FD1D0157;
	Thu, 31 Oct 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="md9d82xq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7B1CCEF9;
	Thu, 31 Oct 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411105; cv=none; b=OcBIUp6ruEjQTZTUFAP9fVZMAdXPCct7bH7oFdmUS6i5xLh8tijcOaigicLa5IBvq6mTFnppZW8Xtt21ebkB6SmXTUbgV+mLGwGR40II/OoxgfUz4aNvNxxm77cp8RqH+GQubzqHMvJV7smTEA4g9zexYZ65EYx/aGUTBP7vuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411105; c=relaxed/simple;
	bh=iSo1D8Pj/jyexUbyfEfnPTgq2C4d2h279m/d6sxC5Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrMg19wWg80UFsXXS9jGE0SQy5NyTZPcJ377pqTCSnewqVTVnRwWnEJzBdjd1MciymJowgPVTacDrU+It96zLKyOYBzLU8ylxoaFrvHM3jaoXkqrLa5vh99ICq01qYJRV16KeYYqFMUqNC4NydoVyTtweRZYt9kjgio0jb2rgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=md9d82xq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tySRmZGJw/vD2lMiU+wQxIP8x/x9B4RXNFjb6NquLNU=; b=md9d82xqwYVz4eePKkBld77KdT
	yl9TbA1JWeNQAjS6oUzaCtvIeBTHZ3vzOFxT5Ipp04+kRcyxibJNrQxHR+S+fyrlOcBalH5ggu8/8
	O4tnca+Pdn51/EUoVH0oluoV5LPQZGvkPCgmxTAxhuVrh+y9c79IOpifp6SZO/BJOKVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6cyJ-00Bp37-CF; Thu, 31 Oct 2024 22:44:51 +0100
Date: Thu, 31 Oct 2024 22:44:51 +0100
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
Subject: Re: [PATCH RFC net-next v2 07/18] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Message-ID: <3a2a2b15-cbda-45b5-ab09-8a783e9f48aa@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-7-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-feature_poe_port_prio-v2-7-9559622ee47a@bootlin.com>

On Wed, Oct 30, 2024 at 05:53:09PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Introduce support for the ethnl_info_init_ntf helper function to enable
> initialization of ethtool notifications outside of the netlink.c file.
> This change allows for more flexible notification handling.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> changes in v2:
> - new patch.
> ---
>  net/ethtool/netlink.c | 5 +++++
>  net/ethtool/netlink.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index e3f0ef6b851b..808cc8096f93 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -805,6 +805,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
>  typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
>  				       const void *data);
>  
> +void ethnl_info_init_ntf(struct genl_info *info, u8 cmd)
> +{
> +	genl_info_init_ntf(info, &ethtool_genl_family, cmd);
> +}
> +

I've not looked at the users yet. Does this need EXPORT_SYMBOL_GPL()?

	Andrew

