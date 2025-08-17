Return-Path: <netdev+bounces-214389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4A2B293CD
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513817A7AF1
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED362264D6;
	Sun, 17 Aug 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HZBNWgiJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED11D88D7;
	Sun, 17 Aug 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443981; cv=none; b=ajqc0eoLHRghgvqr3il+RX6T9bB8nL9KHOi2cCYefaSZJwYynod7jFDv3E8u4J7qGp5/nlIrKHTiEBajmPgaNQJJHfaerLNJU/Z9eoz6E0EHw2+mSLWjAoLYtjDNsBSECouy7AKRAvjluxNkqOyF7U63TNBLi61DDy89BMGMwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443981; c=relaxed/simple;
	bh=nyEbRNSMRi99pTLr9woqSjRE8oTl9PFAbNar7feqrW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrTrNx/Esvp+3YOx2B1ZvQBn0cus2jyDHZDJQgcgwHGK1AXPcYJty6MiS2kT9fvPiwGe6EyNVmqncyihESdhHH5dxBixG+a1fl3Kbp9X3Dj+DiV6nElLnbsZmD/rPo87T+eWPoguo6OFgpU9Y3I4WFMXsAdR1/4bHcR0PvkkkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HZBNWgiJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=buBUl/cephlI3VgswycpcRH6tzfWehraB7wxwYnAZzQ=; b=HZBNWgiJrLWVZudfvVxdK6pcC0
	keAPxAVAfzmqtE6DxU9ocnQxcyzEyg2QMWTp2gfX/PeABW4A3NYTE7njuhQfnOw9Yjvn4Q4mu81+R
	GHHqq6HvX82avmvJ5fsjk9mOGoMg8U3KEVIi4yMbZ4TTH5B0As0JfaDgfFj4/4J2RO2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfAJ-004yKs-Ra; Sun, 17 Aug 2025 17:19:23 +0200
Date: Sun, 17 Aug 2025 17:19:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 05/23] net: dsa: lantiq_gswip: introduce
 bitmaps for port types
Message-ID: <622cde0e-8ec6-4de1-bbbf-39dedac71046@lunn.ch>
References: <aKDhXWIjk3VYYTQh@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhXWIjk3VYYTQh@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:51:57PM +0100, Daniel Golle wrote:
> Instead of relying on hard-coded numbers for MII ports, introduce
> bitmaps for ports with either built-in PHYs, MII or SGMII.
> This is done in order to prepare for supporting MaxLinear GSW1xx ICs
> which got a different layout of ports, and also support SGMII.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 15 ++++++++++++---
>  drivers/net/dsa/lantiq_gswip.h |  3 +++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 5a8fb358fb59..86e02ac0c221 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -185,14 +185,19 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
>  			       int port)
>  {
> -	/* There's no MII_CFG register for the CPU port */
> -	if (!dsa_is_cpu_port(priv->ds, port))
> -		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
> +	if (!(priv->hw_info->mii_ports & BIT(port)))
> +		return;
> +
> +	/* MII_CFG register only exists for MII ports */
> +	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));

I would probably put the comment before the if (). The comment is
about the if () after all. And it is replacing the current comment and
the presence or not of the register.

> +	.phy_ports = BIT(2) | BIT(3) | BIT(4) | BIT(5),
> +	.mii_ports = BIT(0) | BIT(5),

phy_ports is a bit ambiguous, all ports should be capable of having a
PHY somehow. Maybe internal_phy_ports? or int_phy_ports if that is too
long.

> @@ -217,6 +217,9 @@
>  struct gswip_hw_info {
>  	int max_ports;
>  	unsigned int allowed_cpu_ports;
> +	unsigned int phy_ports;
> +	unsigned int mii_ports;
> +	unsigned int sgmii_ports;

Maybe ass sgmii_ports when you add support for sgmii? This patch does
not need it, i think.

    Andrew

---
pw-bot: cr

