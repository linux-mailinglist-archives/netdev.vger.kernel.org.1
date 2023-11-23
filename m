Return-Path: <netdev+bounces-50527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D17F6084
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D781C21026
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF192555D;
	Thu, 23 Nov 2023 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XLzvxMc3"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D2D42;
	Thu, 23 Nov 2023 05:40:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A03BB1BF210;
	Thu, 23 Nov 2023 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700746849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNsWgng4IthX8Dyj2PdimJwFQSUwFngI8Cl8W1jSZbY=;
	b=XLzvxMc3JyA80XZ7DzFZE1c/zFyrU9gpu/UfROvpF+Y+didEbBGxAASiVYnFOhD4SJ4ioJ
	oI4+F4Q+dITEq9ItZgKaeUgagzezayOpdaQHHwA6CswlCjApW5djMeUSGuQyDD56RuejtM
	FWUQufdGb4K+DfcvnvulPNrwWy+BXIRar+/uz4T+nB38Jnqu8PW7QGCOD41Ur/WoEThVs3
	/vzwN/rs0Hi4P/R+t0cxm6AkaNKkIM9GxqO4Zc5+ISUPe/453+DF8ljyHJfCHq6V8IOceT
	LIMkt4PSQy/Qgemzx7pOVlPO8Qum4RmdYFqeOWjG4zfm6o+3/Ux9h6urN/7JfQ==
Date: Thu, 23 Nov 2023 14:40:45 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 06/10] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <20231123144045.57574132@device.home>
In-Reply-To: <97c04999-c3fe-421e-a8eb-642aff647536@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
	<20231117162323.626979-7-maxime.chevallier@bootlin.com>
	<97c04999-c3fe-421e-a8eb-642aff647536@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 21 Nov 2023 02:40:27 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> > +		     struct netlink_ext_ack *extack)
> > +{
> > +	struct phy_device_node *pdn;
> > +	struct phy_device *phydev;
> > +	struct link_topology *lt;
> > +	unsigned long index;
> > +	size_t size;
> > +
> > +	lt = &req_base->dev->link_topo;
> > +
> > +	size = nla_total_size(0);
> > +
> > +	xa_for_each(&lt->phys, index, pdn) {
> > +		phydev = pdn->phy;
> > +
> > +		/* ETHTOOL_A_PHY_INDEX */
> > +		size += nla_total_size(sizeof(u32));
> > +
> > +		/* ETHTOOL_A_DRVNAME */
> > +		size += nla_total_size(strlen(phydev->drv->name));
> > +
> > +		/* ETHTOOL_A_NAME */
> > +		size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)));
> > +
> > +		/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> > +		size += nla_total_size(sizeof(u8));
> > +
> > +		/* ETHTOOL_A_PHY_ID */
> > +		size += nla_total_size(sizeof(u32));
> > +
> > +		if (phy_on_sfp(phydev)) {
> > +			/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> > +			if (sfp_get_name(pdn->parent_sfp_bus))
> > +				size += nla_total_size(strlen(sfp_get_name(pdn->parent_sfp_bus)));  
> 
> Have you tried a modular build?

Now that you mention it, no. I did try with CONFIG_SFP disabled, but
not as a module, I'll add it to my test suite.

> 
> sfp_get_name() could be in a module, and then you will get linker
> errors. It is all a bit messy calling into phylib from ethtool :-(
> 
> This might actually be the only function you need? If so, its small
> enough you can move it into a header as a static inline function.

It's the only one indeed, so as add it as a header function then.

Thanks,

Maxime

>        Andrew


