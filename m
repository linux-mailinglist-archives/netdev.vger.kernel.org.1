Return-Path: <netdev+bounces-49484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4817F22E1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0611F1C214A6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04B4A3F;
	Tue, 21 Nov 2023 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5MIvc56r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73CA2;
	Mon, 20 Nov 2023 17:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yf3IvbJ2ih8PxkhZnuDKG2nQzUN38q5GqA8aWK1dmiQ=; b=5MIvc56rLJB6n1nEGpuodLC0uD
	AYXlzVaLRXcvoGTaNesRuW7cx2Lcpi3zLkE5uCJr+l0kiyF+PSmZM/8cbFbU+dXcbgOna4Lm8deWD
	L7A+jM5z5Mbr/SHCQatyJKkpcht9VSJsWijvRniFjzb/4G+KP3Gqz82wE078TF3cAzFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5FFl-000i0l-Gt; Tue, 21 Nov 2023 02:08:37 +0100
Date: Tue, 21 Nov 2023 02:08:37 +0100
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
Subject: Re: [RFC PATCH net-next v2 05/10] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <d7090506-68f9-4935-a0e9-b3143362b838@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162323.626979-6-maxime.chevallier@bootlin.com>

> +	if (dev) {
> +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> +			u32 phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
> +
> +			phydev = link_topo_get_phy(&dev->link_topo, phy_index);

struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex)

We have u32 vs int here for phyindex. It would be good to have the
same type everywhere.


> +			if (!phydev) {
> +				NL_SET_ERR_MSG_ATTR(extack, header, "no phy matches phy index");
> +				return -EINVAL;
> +			}
> +		} else {
> +			/* If we need a PHY but no phy index is specified, fallback
> +			 * to dev->phydev
> +			 */
> +			phydev = dev->phydev;
> +		}
> +	}
> +
> +	req_info->phydev = phydev;

Don't forget to update Documentation/networking/ethtool-netlink.rst.

      Andrew

