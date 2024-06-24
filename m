Return-Path: <netdev+bounces-106108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B08914DE1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9329E285057
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030513D52C;
	Mon, 24 Jun 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JNp8fFva"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB813D51D;
	Mon, 24 Jun 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234339; cv=none; b=BCaL9dEmWhsZ5vBRZAqRgHeor+L2cW8qkSco2Po/KP/gf124Df2fMZwMHNFfpzLnEUqea+/a/+cMkurP96sHdh57GlATakwaPr0WI7gRLnDR34iwbKhLcY0I9LsfZQQ1+ziAy2g9V7LwD7zxU1iXX/M+YGgH55pCFeUGjrQthuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234339; c=relaxed/simple;
	bh=XubHluMUetbsqVcqSe1xjdc8HQcoEAft3CSnyTemeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjxCHvJaxStNaziRH/s0jzRKsFrhNBTEv6VcorwvuLHIYUbEmL3BabnCLqFIrM/TfpUg+re6uZ2yuK6GR/DTz3VWJUHFTwaEW3DFj+aixSL5ufVqnK9MumVpH8ffniAMrc81sm5I6KZx/FGtYD2Ss0B8sDXNEIsqF3ZgvN9dajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JNp8fFva; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ES+o6uth+0UfsJo/siXuwMApIvXtCBkdQt4vYTqMIQ=; b=JNp8fFvao7URJrbqwOlBwYn6y5
	GozdC3Q9Nrb5gnrzF4Uxv6hObi5gbCsruYtj5HjBBYcVDlzEPQsOL1fhTXLVLvp1+kYfvAKd7guSq
	UeSQhCJ6Sud3rVD/qveoZGlrwPRjJj29XYM/XwBT8Olk2f8EnHfMKG7gK77RB1rzWpcs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLjNo-000qj1-KU; Mon, 24 Jun 2024 15:05:20 +0200
Date: Mon, 24 Jun 2024 15:05:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <e9ae143c-e72f-419b-b4da-2f603a4ccec0@lunn.ch>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <Zni13uFslHz5R6Ns@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zni13uFslHz5R6Ns@lore-desk>

> > > +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> > > +{
> > > +	int i;
> > > +
> > > +	/* hw misses PPE2 oq rsv */
> > > +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> > > +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> > > +
> > > +	for (i = 0; i < PSE_PORT0_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> > > +	for (i = 0; i < PSE_PORT1_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> > > +
> > > +	for (i = 6; i < PSE_PORT2_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> > > +
> > > +	for (i = 0; i < PSE_PORT3_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);
> > 
> > Code like this is making me wounder about the split between MAC
> > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > pure switchdev driver?
> 
> airoha_eth driver implements just MAC features (FE and QDMA). Currently we only
> support the connection to the DSA switch (GDM1). EN7581 SoC relies on mt7530 driver
> for DSA (I have not posted the patch for mt7530 yet, I will do after airoha_eth
> ones).
> 
> > 
> > If there some open architecture documentation for this device?
> > 
> > What are these ports about?
> 
> airoha_fe_oq_rsv_init() (we can improve naming here :) is supposed to configure
> hw pre-allocated memory for each queue available in Packet Switching Engine
> (PSE) ports. PSE ports are not switch ports, but SoC internal ports used to
> connect PSE to different modules. In particular, we are currently implementing
> just the two connections below:
> - CDM1 (port0) connects PSE to QDMA1
> - GDM1 (port1) connects PSE to MT7530 DSA switch
> 
> In the future we will post support for GDM2, GDM3 and GDM4 ports that are
> connecting PSE to exteranl PHY modules.

I've not looked at the datasheet yet, but maybe add some ASCII art
diagram of the architecture in the commit message, or even a .rst file
somewhere under Documentation. It is hard to get the big picture
looking at just the code, and only the MAC driver without all the
other parts.

> > > +static int airoha_dev_open(struct net_device *dev)
> > > +{
> > > +	struct airoha_eth *eth = netdev_priv(dev);
> > > +	int err;
> > > +
> > > +	if (netdev_uses_dsa(dev))
> > > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > > +	else
> > > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > 
> > Does that imply both instances of the GMAC are not connected to the
> > switch? Can one be used with a PHY?
> 
> The check above is used to support configuration where MT7530 DSA switch module
> is not loaded (I tested this configuration removing the MT7530 DSA switch from
> board dts and resetting the switch). Since for the moment we just support GDM1
> port (PSE port connected to the switch) we can probably assume it is always the
> case and remove this check. In the future we will need this configuration to support
> GDM2 or GDM3 (PSE port connected to external phy modules). Do you prefer to
> always set GDM1_STAG_EN_MASK for the moment?

If it will be needed, then keep it. But it is the sort of thing which
raises questions, so its good to explain it, either in the commit
message, or in the code.

	Andrew

