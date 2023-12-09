Return-Path: <netdev+bounces-55562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9E80B55C
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8141F21175
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEEA17722;
	Sat,  9 Dec 2023 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuW3s/gq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B5187C
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 17:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9783C433C7;
	Sat,  9 Dec 2023 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702141504;
	bh=23L3WN6QiOepynHV4/l1rgY8ayFp8shdyR9qFwIfo4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuW3s/gq4XmvI+zazP8ZslY+PEh1eN/BTZsf9FuLTCy32Wy27zQJQDo+9kpSkce3w
	 z36SwtpUkKPn35Wgp/vZK0KiGYpa4onEEzFdybM0ipkJlaz0x/jCIqga5fMvFx44SJ
	 IWSwlPu/c84PKciUaUW/SOuUBj5p9kxhCWB2ImoSdTDP42v5W5rhUqrf/27jXDyS6n
	 0nqwiHIsmRP3hsU/nzMGz0hBqRo5ogqw71a8gCh7KPRy2v2Itk6+FqUjQ34oIBokQW
	 k7OjDpgnPDDvxBSXWIMCGGQg2adV8tUHfv36S2tuQf/JwF7Jm0m0zJZfBhlg7Cw08u
	 wvHZh7zjxuItA==
Date: Sat, 9 Dec 2023 17:04:57 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 07/13] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <20231209170457.GB5817@kernel.org>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
 <20231201163704.1306431-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201163704.1306431-8-maxime.chevallier@bootlin.com>

On Fri, Dec 01, 2023 at 05:36:57PM +0100, Maxime Chevallier wrote:
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

...

> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c

...

> +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> +				  struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct phy_req_info *pri = ctx->phy_req_info;
> +	struct phy_device_node *pdn;
> +	unsigned long index = 1;
> +	void *ehdr;
> +	int ret;
> +
> +	pri->base.dev = dev;
> +
> +	xa_for_each(&dev->link_topo.phys, index, pdn) {
> +		ehdr = ethnl_dump_put(skb, cb,
> +				      ETHTOOL_MSG_PHY_GET_REPLY);
> +		if (!ehdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = ethnl_fill_reply_header(skb, dev,
> +					      ETHTOOL_A_PHY_HEADER);
> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		memcpy(&pri->pdn, pdn, sizeof(*pdn));
> +		ret = ethnl_phy_fill_reply(&pri->base, skb);
> +
> +		genlmsg_end(skb, ehdr);
> +	}
> +
> +	return ret;

Hi Maxime,

I am unsure if this can happen (or if I flagged this before)
but if the loop runs zero times then ret is uninitialised here.

Flagged by Smatch

> +}

...

