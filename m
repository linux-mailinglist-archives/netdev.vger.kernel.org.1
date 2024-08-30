Return-Path: <netdev+bounces-123611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C075B9659ED
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4408C1F22584
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FA16D31B;
	Fri, 30 Aug 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nKpJZ+KG"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C81531C1
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005798; cv=none; b=Azcz8JCO1az3NlUHgZ/oDiUJwT8bhE1mwgHx6hAyK3YkF3aKSPLqDlg5KSvh/zoVu3o8C5S3PVK2RBWhTRTgXqRfgcbpkiFT6LL6Pis5cYfQfLPZTd6K66s7+30RAZk73MXyE10U3xC+aEQ2gOg/ipayAJbksBW6sURiRR8q9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005798; c=relaxed/simple;
	bh=30wtD8fAQFKSgNsONkptJW5zxT7Fhd816iqhzcv/lfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwhfXQ1gDvV2s1qcV+VQtlyUekE93jmC4jkIBY9dBszNPGvlx91pqxzrGBZgq2ZN0dOrZIl8yXIukJ72jO/+9rOKdF8mT+gQboB/YMRn2I7oq/tE2uvNvBcnhIQ5NUxGbdFj6Sj5/Pwpfhoi03onZHcDl/pJhEi/cn0Dj2Dy3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nKpJZ+KG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B338E20002;
	Fri, 30 Aug 2024 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725005793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD5eO7mxJrWyfvC0fyIYTA8WQMDBC0Rl9+2GNxL26dg=;
	b=nKpJZ+KGeI/8jVg+K1sVh2EFHc785IJ8hofQ9IhUUNK8SWDWjpDH9efa48AClDmOESzxwb
	HrcF3T23Kj5BiEI+clY/4W/OqcXCK+6TJHqlUza72bBgxnQfM1x+iHBo5GfpI7m4VpFVXd
	R/vgCGQRFKPqC0Roqd7jWmjl8q6XAV2fEAddkgulTWdcGvOLbU+EVOPMxBJ1dAiEOjtBP8
	qt4/sPDn2k3U1zGVsQ2qvTRNNeSe8YR+DZ3yxX+/oBpvIJhph/pYbaZGQzsFFnPW5Mphi7
	2Y/eTxAkDsRR1ibgLKjzvqhENeSDAByIR++ywUmbjNWWCw1Uero+0C5ae9FXmg==
Date: Fri, 30 Aug 2024 10:16:30 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, woojung.huh@microchip.com,
 o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240830101630.52032f20@device-28.home>
In-Reply-To: <20240829174342.3255168-2-kuba@kernel.org>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-2-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Thu, 29 Aug 2024 10:43:41 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Vladimir, I don't understand MM but doesn't MM share the PHY?
> Ocelot seems to aggregate which I did not expect.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[...]

> +static void
> +ethtool_get_phydev_stats(struct net_device *dev,
> +			 struct linkstate_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;

This would be a very nice spot to use the new
ethnl_req_get_phydev(), if there are multiple PHYs on that device.
Being able to access the stats individually can help
troubleshoot HW issues.

[...]

> +static void
> +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;

Here as well, but that's trickier, as the MAC can override the PHY
stats, but it doesn't know which PHY were getting the stats from.

Maybe we could make so that when we pass a phy_index in the netlink
command, we don't allow the mac to override the phy stats ? Or better,
don't allow the mac to override these stats and report the MAC-reported
PHY stats alongside the PHY-reported stats ?

> +
> +	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>  static int stats_prepare_data(const struct ethnl_req_info *req_base,
>  			      struct ethnl_reply_data *reply_base,
>  			      const struct genl_info *info)
> @@ -145,6 +160,10 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
>  	data->ctrl_stats.src = src;
>  	data->rmon_stats.src = src;
>  
> +	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
> +	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		ethtool_get_phydev_stats(dev, data);

I might be missing something, but I think
ETHTOOL_MAC_STATS_SRC_AGGREGATE is a MM-specific flag and I don't really
see how this applies to getting the PHY stats. I don't know much about
MM though so I could be missing the point.

I'm all in for getting the PHY stats from netlink though :)

Thanks,

Maxime

