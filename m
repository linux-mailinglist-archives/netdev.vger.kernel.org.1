Return-Path: <netdev+bounces-49480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827B7F221B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C63B21618
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178FE7FB;
	Tue, 21 Nov 2023 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L7BwsBkX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3FBA;
	Mon, 20 Nov 2023 16:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9vlgy8wfHdl3PYwUVlmm+Im+7f3OcAa0y0Xf8fqzxVQ=; b=L7BwsBkXDv6yE5ugjFsPF6yKSj
	jTqghU9sCbh/qP3kYQo+fDvDxqqLcFcwt3XdLqdMHA3GEPhDDHoJnIQWpqRRAUk52zeEHwXE0UoPx
	Dq9d1JjI57DARF73zid/0LBEJzurXPf5b4yYEAi3yfYuUxkzZRFCa0Iu5kDoTVVaC71o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5EZL-000hsQ-Pb; Tue, 21 Nov 2023 01:24:47 +0100
Date: Tue, 21 Nov 2023 01:24:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: phy: Introduce ethernet link
 topology representation
Message-ID: <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162323.626979-2-maxime.chevallier@bootlin.com>

> +int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
> +		      enum phy_upstream upt, void *upstream)
> +{
> +	ret = xa_alloc_cyclic(&lt->phys, &phy->phyindex, pdn, xa_limit_32b,
> +			      &lt->next_phy_index, GFP_KERNEL);
> +	if (ret)
> +		goto err;
> +
> +	return 0;

It looks like that could be just return xa_alloc_cyclic(...);

> diff --git a/include/linux/link_topology.h b/include/linux/link_topology.h

I think this filename is too generic. Maybe phy_link_topology.h, or
move it into include/net.

> +struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex);
> +int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
> +		      enum phy_upstream upt, void *upstream);
> +
> +void link_topo_del_phy(struct link_topology *lt, struct phy_device *phy);

What is the locking for these functions? Are you assuming RTNL? Maybe
add ASSERT_RTNL(); into them to make this clear.

> diff --git a/include/linux/link_topology_core.h b/include/linux/link_topology_core.h

Again, i think this filename is too generic.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index a16c9cc063fe..7021a0d3d982 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -40,7 +40,6 @@
>  #include <net/dcbnl.h>
>  #endif
>  #include <net/netprio_cgroup.h>
> -
>  #include <linux/netdev_features.h>

Whitespace change.

>  #include <linux/neighbour.h>
>  #include <uapi/linux/netdevice.h>
> @@ -52,6 +51,7 @@
>  #include <net/net_trackers.h>
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> +#include <linux/link_topology_core.h>
>  
>  struct netpoll_info;
>  struct device;
> @@ -2405,6 +2405,7 @@ struct net_device {
>  #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
>  	struct netprio_map __rcu *priomap;
>  #endif
> +	struct link_topology	link_topo;
>  	struct phy_device	*phydev;
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3cc52826f18e..d698180b1df0 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -543,6 +543,8 @@ struct macsec_ops;
>   * @drv: Pointer to the driver for this PHY instance
>   * @devlink: Create a link between phy dev and mac dev, if the external phy
>   *           used by current mac interface is managed by another mac interface.
> + * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
> + *	      from userspace, similar to ifindex. It's never recycled.
>   * @phy_id: UID for this device found during discovery
>   * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
>   * @is_c45:  Set to true if this PHY uses clause 45 addressing.
> @@ -640,6 +642,7 @@ struct phy_device {
>  
>  	struct device_link *devlink;
>  
> +	int phyindex;

Is this int, or unsigned int? Is a negative value possible and legal?

> +enum phy_upstream {
> +	PHY_UPSTREAM_MAC,
> +	PHY_UPSTREAM_SFP,
> +	PHY_UPSTREAM_PHY,
> +};

Please document what these actually mean.

       Andrew

