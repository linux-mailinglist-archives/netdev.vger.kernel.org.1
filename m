Return-Path: <netdev+bounces-104308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283A90C18F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05DFB22F30
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029615E9B;
	Tue, 18 Jun 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sns5uOLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237910A16;
	Tue, 18 Jun 2024 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675014; cv=none; b=hMlCc9sS29JFqchVOgqwFZtI2NA+xeQU5SxlkuDgJtLvRd+1eGY7FrKTg1Zh4Rbypw+Q5MjJ6ZlNnH3QKuBtBMPEncaT8RhzoKZMeZqt+MqiIeZc48d8ITvCarnSTVfxHgZxVj2S40D4ZzFSVITv1rRtbO3Et83lQuzmOeAnQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675014; c=relaxed/simple;
	bh=lKZVylMEDQkBXztZ/GoU0xvg0FZppHHM24DQfAEF2UA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2RAoiZIBqh+crXJeUXSTu+pK7nkqLpNpJddZ1vGmRzmEjEuSRYhKJhnIN5EQYy64vRaKvHpHec+B4PkJ0aJDyEtfIH3Pf2SxcaR0mK4iq64C243v1asbSihJxNYpor+uQpzitbAuiphLxpzlpIG0KtHFPTJWuYFsmAKfwVmvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sns5uOLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94245C2BD10;
	Tue, 18 Jun 2024 01:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718675013;
	bh=lKZVylMEDQkBXztZ/GoU0xvg0FZppHHM24DQfAEF2UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sns5uOLCBDXtFflQPRb8aI6UDSIcGHeKA44luZnmiuFjkvlwAVPuZ7xRpWqukrkO0
	 hKdJfPQ6LPut2DVolR0sGSnhgCH9eYyQuHrKALPegSHOs0RBPuLsEynd7vig1h7qhC
	 DCB08+wD/EEzIBk0Ut2LXxwCT71i9LHI8NFbEocoGAeezgBdRvR/bq7pOMTnKunJfY
	 TTWv2nwYrmlAzEMe1tibmNSqDt770O+7NhT8koT35ZXfF59ZFL3dYVRNm25QGxKiVA
	 dSSH2EALwv7RLRc4vE/o37kmYB10W3Ks3BsQr2eMFaWrNnCLY2yeXzRCgI5eNcDWBV
	 /lwKRxqrbeofw==
Date: Mon, 17 Jun 2024 18:43:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v15 13/14] net: ethtool: tsinfo: Add support
 for hwtstamp provider and get/set hwtstamp config
Message-ID: <20240617184331.0ddfd08e@kernel.org>
In-Reply-To: <20240612-feature_ptp_netnext-v15-13-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-13-b2a086257b63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 17:04:13 +0200 Kory Maincent wrote:
> Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> network topology and read current hwtstamp configuration.
> 
> Introduce support for ETHTOOL_MSG_TSINFO_SET ethtool netlink socket to
> configure hwtstamp of a PHC provider. Note that simultaneous hwtstamp
> isn't supported; configuring a new one disables the previous setting.
> 
> Also, add support for a specific dump command to retrieve all hwtstamp
> providers within the network topology, with added functionality for
> filtered dump to target a single interface.

Could you split this up, a little bit? It's rather large for a core
change.

>  Desired behavior is passed into the kernel and to a specific device by
> -calling ioctl(SIOCSHWTSTAMP) with a pointer to a struct ifreq whose
> -ifr_data points to a struct hwtstamp_config. The tx_type and
> -rx_filter are hints to the driver what it is expected to do. If
> -the requested fine-grained filtering for incoming packets is not
> +calling the tsinfo netlink socket ETHTOOL_MSG_TSINFO_SET.
> +The ETHTOOL_A_TSINFO_TX_TYPES, ETHTOOL_A_TSINFO_RX_FILTERS and
> +ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS netlink attributes are then used to set the
> +struct hwtstamp_config accordingly.

nit: EHTOOL_A* defines in `` `` quotes?

> +		if (hwtstamp && ptp_clock_phydev(hwtstamp->ptp) == phydev) {
> +			rcu_assign_pointer(dev->hwtstamp, NULL);
> +			synchronize_rcu();
>  			kfree(hwtstamp);

Could you add an rcu_head to this struct and use kfree_rcu()
similarly later use an rcu call to do the dismantle?
synchronize_rcu() can be slow.

> +enum {
> +	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_UNSPEC,
> +	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,		/* u32 */
> +	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER,		/* u32 */
> +
> +	__ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_CNT,
> +	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_MAX = (__ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_CNT - 1)
> +};
> +
>  

nit: double new line

> +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
>  	[ETHTOOL_A_TSINFO_HEADER]		=
>  		NLA_POLICY_NESTED(ethnl_header_policy_stats),
> +	[ETHTOOL_A_TSINFO_GHWTSTAMP] =
> +		NLA_POLICY_MAX(NLA_U8, 1),

I think this can be an NLA_FLAG, but TBH I'm also confused about 
the semantics. Can you explain what it does from user perspective?

> +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER] =
> +		NLA_POLICY_NESTED(ethnl_tsinfo_hwtstamp_provider_policy),
>  };
>  
> +static int tsinfo_parse_hwtstamp_provider(const struct nlattr *nest,
> +					  struct hwtst_provider *hwtst,
> +					  struct netlink_ext_ack *extack,
> +					  bool *mod)
> +{
> +	struct nlattr *tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];

Could you find a more sensible name for this policy?

> +	int ret;
> +
> +	ret = nla_parse_nested(tb,
> +			       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
> +			       nest,
> +			       ethnl_tsinfo_hwtstamp_provider_policy, extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (NL_REQ_ATTR_CHECK(extack, nest, tb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX) ||
> +	    NL_REQ_ATTR_CHECK(extack, nest, tb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER))

nit: wrap at 80 chars, if you can, please

> +		return -EINVAL;
> +
> +	ethnl_update_u32(&hwtst->index,
> +			 tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX],
> +			 mod);
> +	ethnl_update_u32(&hwtst->qualifier,
> +			 tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER],
> +			 mod);
> +
> +	return 0;
> +}

>  static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
>  			       struct ethnl_reply_data *reply_base,
>  			       const struct genl_info *info)
>  {
>  	struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
> +	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
>  	struct net_device *dev = reply_base->dev;
>  	int ret;
>  
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
>  		return ret;
> +
> +	if (req->get_hwtstamp) {
> +		struct kernel_hwtstamp_config cfg = {};
> +
> +		if (!dev->netdev_ops->ndo_hwtstamp_get) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret = dev_get_hwtstamp_phylib(dev, &cfg);
> +		data->hwtst_config.tx_type = BIT(cfg.tx_type);
> +		data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
> +		data->hwtst_config.flags = BIT(cfg.flags);
> +		goto out;

This is wrong AFAICT, everything up to this point was a nit pick ;)
Please take a look at 89e281ebff72e6, I think you're reintroducing a
form of the same bug. If ETHTOOL_FLAG_STATS was set, you gotta run stats
init.

Perhaps you can move the stats getting up, and turn this code into if
/ else if / else, without the goto.

> +int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +	if (ctx->req_info->base.dev) {
> +		ret = ethnl_tsinfo_dump_one_dev(skb,
> +						ctx->req_info->base.dev,
> +						cb);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +			ret = ethnl_tsinfo_dump_one_dev(skb, dev, cb);
> +			if (ret < 0 && ret != -EOPNOTSUPP)
> +				break;
> +			ctx->pos_phcindex = 0;
> +		}
> +	}
> +	rtnl_unlock();
> +
> +	if (ret == -EMSGSIZE && skb->len)
> +		return skb->len;
> +	return ret;

You can just return ret without the if converting to skb->len
af_netlink will handle the EMSGSIZE errors in the same way.

