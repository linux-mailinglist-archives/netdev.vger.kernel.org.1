Return-Path: <netdev+bounces-172922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A41A567BB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1107A3AE3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB521884B;
	Fri,  7 Mar 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4wbIWD+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00E184E;
	Fri,  7 Mar 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350085; cv=none; b=bdmUODprUfQjNV6ytpKPdcaIHFG6PxSYQ2X0dnvlyysb7SV3TjiuPbojyEnZaGJhmxklkHeZaE2BzwqGE8pVeo1SfufVreLcHwI5sW1ydcf2SHqEPyd1fSBsrvLuPQj0tOGwmkbosamcSOVye/WLQ+ju3JPCRT9r7gyLztaIUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350085; c=relaxed/simple;
	bh=n/rX2T7XWYNEB5c47vZqkTQcbFk1cEn+IsmwsxMI8H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhTi47U/GUHzmFuMpjObMeJzVwAqLJYqItYwLQTvp4Vp+qfpl6voA73dpR1+WSh3DAQ7RFTefpOblOWT82S/5wro+F0Nvdm/iFWIufRQh8qE615lsrG2VE2VOKIov5Ofxgkmu2fnEliGtA8uN4I/+z4cLl/B1yPxSUuido7te70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4wbIWD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A9C4CED1;
	Fri,  7 Mar 2025 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741350084;
	bh=n/rX2T7XWYNEB5c47vZqkTQcbFk1cEn+IsmwsxMI8H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4wbIWD+eQgi9iSzdRuy9RPG1IVOA0kvWKjOcAZWjQyfpCe1oTP0d4AyYJJkMI7bx
	 mV+L+WG/USp4nL+oyGB5fWGwSSXGW+joQxc4Bbmx1VlWr4gw2SPnkAy1uCUAZaT3ud
	 WR4TQYjFo6KYOLRepnzgHLP1eNhxmRAnTZ27rx98jQMeqWTeyjqF9f8H4hzQ7ESZSJ
	 QnVzxO2KXa2NJHk3hRPoge4TW4gy0ueua3MjM+7e80Q0cFznNkNf3RZdcNFhPP60cJ
	 37IY+Bpo6V+lW1w4Xfbma4zKAV0ek411E0sfBy0MH/7n7JlWIIMDfAXZijxfw2xceO
	 1QmGPueKe804g==
Date: Fri, 7 Mar 2025 12:21:19 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next 1/7] net: ethtool: netlink: Allow per-netdevice
 DUMP operations
Message-ID: <20250307122119.GE3666230@kernel.org>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
 <20250305141938.319282-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141938.319282-2-maxime.chevallier@bootlin.com>

On Wed, Mar 05, 2025 at 03:19:31PM +0100, Maxime Chevallier wrote:
> We have a number of netlink commands in the ethnl family that may have
> multiple objects to dump even for a single net_device, including :
> 
>  - PLCA, PSE-PD, phy: one message per PHY device
>  - tsinfo: one message per timestamp source (netdev + phys)
>  - rss: One per RSS context
> 
> To get this behaviour, these netlink commands need to roll a custom
> ->dumpit().
> 
> To prepare making per-netdev DUMP more generic in ethnl, introduce a
> member in the ethnl ops to indicate if a given command may allow
> pernetdev DUMPs (also referred to as filtered DUMPs).
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
>  net/ethtool/netlink.h |  1 +
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 734849a57369..0815b28ba32f 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -578,21 +578,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  	int ret = 0;
>  
>  	rcu_read_lock();
> -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> -		dev_hold(dev);
> +	if (ctx->req_info->dev) {
> +		dev = ctx->req_info->dev;
>  		rcu_read_unlock();
> -
> -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> -
> +		/* Filtered DUMP request targeted to a single netdev. We already
> +		 * hold a ref to the netdev from ->start()
> +		 */
> +		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
> +						 genl_info_dump(cb));

Hi Maxime,

ethnl_default_dump_one_dev() is called here but it doesn't exist
until the following patch is applied, which breaks bisection.

>  		rcu_read_lock();
> -		dev_put(dev);
> -
> -		if (ret < 0 && ret != -EOPNOTSUPP) {
> -			if (likely(skb->len))
> -				ret = skb->len;
> -			break;
> +		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +			dev_hold(dev);
> +			rcu_read_unlock();
> +
> +			ret = ethnl_default_dump_one(skb, dev, ctx,
> +						     genl_info_dump(cb));
> +
> +			rcu_read_lock();
> +			dev_put(dev);
> +
> +			if (ret < 0 && ret != -EOPNOTSUPP) {
> +				if (likely(skb->len))
> +					ret = skb->len;
> +				break;
> +			}
> +			ret = 0;
>  		}
> -		ret = 0;
>  	}
>  	rcu_read_unlock();
>  

...

> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index ec6ab5443a6f..4db27182741f 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -388,6 +388,7 @@ struct ethnl_request_ops {
>  	unsigned int		req_info_size;
>  	unsigned int		reply_data_size;
>  	bool			allow_nodev_do;
> +	bool			allow_pernetdev_dump;

nit: allow_pernetdev_dump should also be added to the Kernel doc for
     struct ethnl_request_ops

     Flagged by ./scripts/kernel-doc -none

     There also appear to be similar minor issues with subsequent
     patches in this series.

>  	u8			set_ntf_cmd;
>  
>  	int (*parse_request)(struct ethnl_req_info *req_info,
> -- 
> 2.48.1
> 

