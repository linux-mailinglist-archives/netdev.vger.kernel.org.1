Return-Path: <netdev+bounces-93423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EA8BBA8A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B8C282472
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA4B17C7C;
	Sat,  4 May 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIlKUOyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E2EEB2;
	Sat,  4 May 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714818885; cv=none; b=NxFbbsJ93z6+0XPakFlpb/Avfj66kQWyq1Yd72o6Q1qM/Um3k38GNnrc4nX3Z6bXhTKcGZ03KV2rGXmlINjjknMkqmS0i84Z2hxXg5+6WdaKrW7i+bVbjMxHt6BmwNIP5PkmZptNx0YntR/+3eEYPrdH7zGf47cRg1p44a+4R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714818885; c=relaxed/simple;
	bh=HV/JCs7Z7tqv/VPFIFyIpdPE4o8/rnvHPB7bkjF3Iko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+ZjpHVFM9CJflcB/6W58BVHqqQe+IhZbuKNFyQi8ehHfPPnvCPM/IShu/T78w4LrSIZ3DWGxX7KHTqK8B+LTfsVQtSc8JzyCOVEwgZTZP7SwEq3sbnRgD+Ay6oeBC/FifmSOgNl5Opx7ApeNEmSX8OEBqNjJANn+wzQO4xv3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIlKUOyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF03BC072AA;
	Sat,  4 May 2024 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714818885;
	bh=HV/JCs7Z7tqv/VPFIFyIpdPE4o8/rnvHPB7bkjF3Iko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIlKUOyJzPbnyCfPM+2Fi61ViHBurhkO0ZxpjLvCTVAMhPLTrRXSq6y0V1goT6C1y
	 zzQoQetoe11khxsBy4ofYVf1/jW4qnuyp28ASFEs0pQdBBufzNB0pkUYzTXcOeq84i
	 cneb/O8Qjnb0isq856Awyptf36mM8x86DN+aWWazdv7PRWPONlUdFhkkGL2Ip6oifd
	 Qh2E+QfuO/oE9zXpy26FfuY7vi7Q9CusgCy47/MXgKyj87duFmYI+/vK/XM0IPGDMK
	 nztCoU4+iFzegmIfF4Xgfbtu6xPnSy9p4i2kHkaJtN+IbijCbjxZc3LCugpae2eNwd
	 r9Sy5ORihw2qg==
Date: Sat, 4 May 2024 11:33:05 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v12 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Message-ID: <20240504103305.GD3167983@kernel.org>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
 <20240430-feature_ptp_netnext-v12-12-2c5f24b6a914@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-feature_ptp_netnext-v12-12-2c5f24b6a914@bootlin.com>

On Tue, Apr 30, 2024 at 05:49:55PM +0200, Kory Maincent wrote:
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
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

...

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index acb0cadb7512..ec6dd81a5add 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -270,10 +270,13 @@ static int dev_eth_ioctl(struct net_device *dev,
>  int dev_get_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg)
>  {
> -	if (dev->hwtstamp) {
> -		struct ptp_clock *ptp = dev->hwtstamp->ptp;
> +	struct hwtstamp_provider *hwtstamp;
>  
> -		cfg->qualifier = dev->hwtstamp->qualifier;
> +	hwtstamp = rtnl_dereference(dev->hwtstamp);
> +	if (hwtstamp) {
> +		struct ptp_clock *ptp = hwtstamp->ptp;
> +
> +		cfg->qualifier = hwtstamp->qualifier;
>  		if (ptp_clock_from_phylib(ptp))
>  			return phy_hwtstamp_get(ptp_clock_phydev(ptp), cfg);
>  
> @@ -340,13 +343,15 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
>  	struct kernel_hwtstamp_config old_cfg = {};
> +	struct hwtstamp_provider *hwtstamp;
>  	struct phy_device *phydev;
>  	bool changed = false;
>  	bool phy_ts;
>  	int err;
>  
> -	if (dev->hwtstamp) {
> -		struct ptp_clock *ptp = dev->hwtstamp->ptp;
> +	hwtstamp = rtnl_dereference(dev->hwtstamp);
> +	if (hwtstamp) {
> +		struct ptp_clock *ptp = hwtstamp->ptp;
>  
>  		if (ptp_clock_from_phylib(ptp)) {
>  			phy_ts = true;

Hi Kory,

A few lines beyond this hunk, within the "if (hwtstamp)" block,
is the following:

		cfg->qualifier = dev->hwtstamp->qualifier;

Now that dev->hwtstamp is managed using RCU, I don't think it is correct
to dereference it directly like this. Rather, the hwtstamp local variable,
which has rcu_dereference'd this pointer should be used:

		 cfg->qualifier = hwtstamp->qualifier;

Flagged by Sparse.

...

> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c

...

> +static int ethnl_tsinfo_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> +				     struct netlink_callback *cb)
> +{
> +	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
> +	struct ptp_clock *ptp;
> +	int ret;
> +
> +	netdev_for_each_ptp_clock_start(dev, ctx->pos_phcindex, ptp,
> +					ctx->pos_phcindex) {
> +		ret = ethnl_tsinfo_dump_one_ptp(skb, dev, cb, ptp);
> +		if (ret < 0 && ret != -EOPNOTSUPP)
> +			break;
> +		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
> +	}
> +
> +	return ret;

Perhaps it is not possible, but if the loop iterates zero times then
ret will be used uninitialised here.

Flagged by Smatch.

> +}

...

