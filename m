Return-Path: <netdev+bounces-49490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284E7F2328
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0520282257
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B46FC9;
	Tue, 21 Nov 2023 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ynCgLiPM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FD10CE;
	Mon, 20 Nov 2023 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Am/1to/V8gkq755Qh9tO2gkpYjOcdKhlEYTmnGsC1fw=; b=ynCgLiPMN+NFUNWiq84dU/mY51
	2JQeUI/TsS98fJ3QddRjeKyF5NQpjXlYkJhHw8LZHPnHnJt311d6eVQawVRZlQ4u/G+A40iXdFy5B
	ToH5wvAyxJQm3oSf7EN38KERrYFpeP4syJJa2R5e7bUznCnEa9KuRaQPprbj+QjjiGJU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5Ff6-000i5g-W8; Tue, 21 Nov 2023 02:34:49 +0100
Date: Tue, 21 Nov 2023 02:34:48 +0100
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
Subject: Re: [RFC PATCH net-next v2 06/10] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <fcb77cb3-e57d-4b66-bb55-63d3b1410e8f@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162323.626979-7-maxime.chevallier@bootlin.com>

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 2540c70952ff..29ef675f45c0 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -57,6 +57,7 @@ Structure of this header is
>    ``ETHTOOL_A_HEADER_DEV_INDEX``  u32     device ifindex
>    ``ETHTOOL_A_HEADER_DEV_NAME``   string  device name
>    ``ETHTOOL_A_HEADER_FLAGS``      u32     flags common for all requests
> +  ``ETHTOOL_A_HEADER_PHY_INDEX``  u32     phy device index
>    ==============================  ======  =============================
>  
>  ``ETHTOOL_A_HEADER_DEV_INDEX`` and ``ETHTOOL_A_HEADER_DEV_NAME`` identify the
> @@ -81,6 +82,12 @@ the behaviour is backward compatible, i.e. requests from old clients not aware
>  of the flag should be interpreted the way the client expects. A client must
>  not set flags it does not understand.
>  
> +``ETHTOOL_A_HEADER_PHY_INDEX`` identify the ethernet PHY the message relates to.
> +As there are numerous commands that are related to PHY configuration, and because
> +we can have more than one PHY on the link, the PHY index can be passed in the
> +request for the commands that needs it. It is however not mandatory, and if it
> +is not passed for commands that target a PHY, the net_device.phydev pointer
> +is used, as a fallback that keeps the legacy behaviour.

O.K, you did document it :-)

But i would make this part of the previous patch.

> +Kernel response contents:
> +
> +  =================================     ======  ==========================
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, that can
> +                                                be used for phy-specific requests
> +  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
> +  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
> +  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this phy is
> +                                                connected to
> +  ``ETHTOOL_A_PHY_UPSTREAM_PHY``        nested  if the phy is connected to another
> +                                                phy, this nest contains info on
> +                                                that connection
> +  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
> +                                                the name of the sfp bus
> +  ``ETHTOOL_A_PHY_ID``                  u32     the phy id if the phy is C22

Maybe a future extension. We could make phy_bus_match() set
phydev->phy_id to the ID it matched to the driver when doing C45. We
would then always have a value here.

> --- a/include/linux/ethtool_netlink.h
> +++ b/include/linux/ethtool_netlink.h
> @@ -118,5 +118,10 @@ static inline bool ethtool_dev_mm_supported(struct net_device *dev)
>  	return false;
>  }
>  
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	return -EOPNOTSUPP;
> +}

This is a header file, so should probably be static inline.

     Andrew

