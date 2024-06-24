Return-Path: <netdev+bounces-106194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9B9152CB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ACD1F230DA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF5143C5C;
	Mon, 24 Jun 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dcQ8TEPx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33D1D53C;
	Mon, 24 Jun 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243934; cv=none; b=gBS5jQj+F4QoBduGBeWy9jE9sUGWSaoqBANBM5ZX1/vSPsHheEBs1QZ4c5mr5Vf0/k3HXPjprXkM4RQkKkfouS0QEk+oUT5ph46Hjj86au6sTolZqBuEVi+2Uc8GbZ83qPWDROcCnOfrtdEYzOmBXBq7Ou0Wro1L4G92eA6am9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243934; c=relaxed/simple;
	bh=799YMxd9vz4cMeKpJH6A+kUY4JEBuJNS62CFJsW+cE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFN0XJ29OGNMgArek536SeiV2v03bw22lAvDhY0REw+SNfZVsttZrEyg1FnQxRf00lGXpnmQuEPixtzdroOvk3hXkKBCPPl8Ls3pXJ0BY+xBQrDweqj5WnV31U/SrZhbxwErlo5uDuZL+z6ahPe691pGY3Hf8j+wQNoQabshKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dcQ8TEPx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MG4bQ1XP6apgYZwLIAFbYd1TLI/2JMcgF2WW1hKHj48=; b=dcQ8TEPxd5poTH/Oldi1Q3J6Db
	9ZUYqPRncRD0Mxb8f7roUFt5ZbyazEa4Q07b0vi7v2FReTGlNEc+lQVUaet7Jk1RP9dctvwHMwE1r
	xBqhFLyCHUJXqsrCMYDDNkNf085VkoRG8zNsgYIyv6yI1vaisIET8zyU0WsnKb0Aa+8I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLlse-000rdp-68; Mon, 24 Jun 2024 17:45:20 +0200
Date: Mon, 24 Jun 2024 17:45:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	nbd@nbd.name, lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <4a39fa50-cffc-4f0c-a442-b666b024ba34@lunn.ch>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <b023dfb3-ca8e-4045-b0b1-d6e498961e9c@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b023dfb3-ca8e-4045-b0b1-d6e498961e9c@genexis.eu>

On Mon, Jun 24, 2024 at 01:01:44AM +0200, Benjamin Larsson wrote:
> Hi,
> > Code like this is making me wounder about the split between MAC
> > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > pure switchdev driver?
> > 
> > If there some open architecture documentation for this device?
> > 
> > What are these ports about?
> > 
> > > +static int airoha_dev_open(struct net_device *dev)
> > > +{
> > > +	struct airoha_eth *eth = netdev_priv(dev);
> > > +	int err;
> > > +
> > > +	if (netdev_uses_dsa(dev))
> > > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > > +	else
> > > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > Does that imply both instances of the GMAC are not connected to the
> > switch? Can one be used with a PHY?
> > 
> > 	Andrew
> 
> https://mirror2.openwrt.org/docs/MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf
> 
> page 107 (text for 9.1.1 is relevant but not a complete match). In the
> EN7581 case there is a 5 port switch in the place of GMAC1 (one switch port
> is connected to GDM1).

The typical DSA architecture is that the SoC MAC is connected to a
switch MAC port. You say here, the switch is directly connected to the
GGM1. So there is no GMAC involved? If there is no MAC, you don't need
a MAC driver.

It seems more likely there is a GMAC, and the SGMII interface, or
something similar is connected to the switch?

	Andrew


