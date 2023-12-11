Return-Path: <netdev+bounces-55848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8180C7A1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD72DB20ED2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F912D633;
	Mon, 11 Dec 2023 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LwyAfE0v"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6873BC;
	Mon, 11 Dec 2023 03:06:29 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CA79E0003;
	Mon, 11 Dec 2023 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702292788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oICVaIzyLX4veYGTPgVdKGVij2uuwlXEksldPPnrU2I=;
	b=LwyAfE0vsED69vfVr+PR8Z36qpWG1xB3qQFu2coL+2jOT6jyhTQlKuuMCugZRteUjVvWqU
	B264CQ1BYPDsgy+i/uGIwV6RWOWWa6NpMfFJITUK6aPJsnrng9X98uI9HYqagPUmZz0SD1
	zLop39rjswJEEXedemuouFFw8FQAJ1g4pPjHrk0D09w6UFjqYe6YD0jouTb6uTJ6na9Yek
	KsjpCm9aXkmT2EAfFTrmN6rtaevmJx94MMwRN3RXQjjzYuFR2d0bYC9b8biLo9SRrrkelP
	2nyGax3mc9JlgFNc+GtcflL3ddhClTAtwZeaxuYpUWEgvtyDleKRsz7JFT41VA==
Date: Mon, 11 Dec 2023 12:06:23 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231211120623.03b1ced4@device.home>
In-Reply-To: <20231209170241.GA5817@kernel.org>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
	<20231201163704.1306431-2-maxime.chevallier@bootlin.com>
	<20231209170241.GA5817@kernel.org>
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

Hi Simon,

On Sat, 9 Dec 2023 17:02:41 +0000
Simon Horman <horms@kernel.org> wrote:

> On Fri, Dec 01, 2023 at 05:36:51PM +0100, Maxime Chevallier wrote:
> > Link topologies containing multiple network PHYs attached to the same
> > net_device can be found when using a PHY as a media converter for use
> > with an SFP connector, on which an SFP transceiver containing a PHY can
> > be used.
> > 
> > With the current model, the transceiver's PHY can't be used for
> > operations such as cable testing, timestamping, macsec offload, etc.
> > 
> > The reason being that most of the logic for these configuration, coming
> > from either ethtool netlink or ioctls tend to use netdev->phydev, which
> > in multi-phy systems will reference the PHY closest to the MAC.
> > 
> > Introduce a numbering scheme allowing to enumerate PHY devices that
> > belong to any netdev, which can in turn allow userspace to take more
> > precise decisions with regard to each PHY's configuration.
> > 
> > The numbering is maintained per-netdev, in a phy_device_list.
> > The numbering works similarly to a netdevice's ifindex, with
> > identifiers that are only recycled once INT_MAX has been reached.
> > 
> > This prevents races that could occur between PHY listing and SFP
> > transceiver removal/insertion.
> > 
> > The identifiers are assigned at phy_attach time, as the numbering
> > depends on the netdevice the phy is attached to.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> Hi Maxime,
> 
> some minor feedback from my side.
> 
> ...
> 
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> > index f65e85c91fc1..3cf7774df57e 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for Linux PHY drivers
> >  
> >  libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
> > -				   linkmode.o
> > +				   linkmode.o phy_link_topology.o
> >  mdio-bus-y			+= mdio_bus.o mdio_device.o
> >  
> >  ifdef CONFIG_MDIO_DEVICE
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c  
> 
> ...
> 
> > @@ -265,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
> >  
> >  static struct phy_driver genphy_driver;
> >  
> > +static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
> > +{
> > +	if (phydev->attached_dev)
> > +		return &phydev->attached_dev->link_topo;
> > +
> > +	return NULL;
> > +}
> > +  
> 
> This function is declared static but is unused, which causes
> allmodconfig W=1 builds to fail. Perhaps it could be introduced
> in a latter patch where it is used?

Ah true, thanks for spotting this !

> ...
> 
> > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c  
> 
> ...
> 
> > +void phy_link_topo_init(struct phy_link_topology *topo)
> > +{
> > +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> > +	topo->next_phy_index = 1;
> > +}  
> 
> ...
> 
> > diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h  
> 
> ...
> 
> > +#else
> > +static struct phy_device *phy_link_topo_get_phy(struct phy_link_topology *topo,
> > +						u32 phyindex)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static int phy_link_topo_add_phy(struct phy_link_topology *topo,
> > +				 struct phy_device *phy,
> > +				 enum phy_upstream upt, void *upstream)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void phy_link_topo_del_phy(struct phy_link_topology *topo,
> > +				  struct phy_device *phy)
> > +{
> > +}
> > +#endif  
> 
> nit: functions in .h should be declared static inline

Will do in next version

> ...
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c  
> 
> ...
> 
> > @@ -10832,6 +10833,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  #ifdef CONFIG_NET_SCHED
> >  	hash_init(dev->qdisc_hash);
> >  #endif
> > +	phy_link_topo_init(&dev->link_topo);
> > +  
> 
> I don't think this can work unless PHYLIB is compiled as a built-in.

Inded, I need to better clarify and document the dependency with
PHYLIB.

Thanks a lot for the review,

Maxime

