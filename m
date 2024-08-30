Return-Path: <netdev+bounces-123802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725E9668F2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF551F242FD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2EB1BBBD8;
	Fri, 30 Aug 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk/WeAi5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536C1B86D6
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042649; cv=none; b=gkHYispX4HdFyHgqpnoVrZlHxiHp0lGpqYh/3WxPpZI2XReVWi/y9NzPWBrHlgjemlzHMNRvP2WfmTu3/hdYP4wmCdoydij7QAOAzqroSfMUajQMwdmstzKCWzu4oqUIIqxAKz3NzwLirN93ird/lwq0T08ktrot2Hj/f+QdLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042649; c=relaxed/simple;
	bh=Lc8pVvcNoaixHXv9lqB33GJTMTAvhb/u1XvKe0pvUi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK7RSr5ytoxe5puKSHgJZSIYcJ+qS/KoZjqNdNqurYCOgdIOou+gCMcZ3hfMbi784/vtI/hZNeZlLz9goUUG+iZ+1Jm5PUOt81ZgnbSOtnxKqWsJ70msl4MJBLovsadzmgzOCYCFuhlJE1s373gTBUY5e/VpT2Ghzx+WcIZxzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk/WeAi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79353C4CEC2;
	Fri, 30 Aug 2024 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042648;
	bh=Lc8pVvcNoaixHXv9lqB33GJTMTAvhb/u1XvKe0pvUi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gk/WeAi5h1saxAOA3fLQ9QJypg3JYYMaGEyj7pKIEPHgAZvsz/AkfcWeo/0DM5q02
	 iJdBPRI8GdRSJCDLbkZ/MsGUMaYrLYpypNRM3K8un941sHrnSdIk8enDyfJw/70mF6
	 YsWgy6mVWS5Ky9SL4gR8WqDAjS+cLI7ditZlqzS9+M+9SrNgtlpZmHHiOKgnON4QhN
	 sMiM0Cb0XwmyKul5+05PgNb+oTGgh/r6F7usgAWjqsiE/SDnVk0czVL7VQh+I3k9dK
	 7IeUjHwzEyFbjZNDnwif9E2XoNU6RuJZFSWTOPzuUWWwLqRKWPY3iD4P5mZ8YjwQft
	 LGUT5iPwUD49Q==
Date: Fri, 30 Aug 2024 11:30:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, woojung.huh@microchip.com,
 o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240830113047.10dcee79@kernel.org>
In-Reply-To: <20240830101630.52032f20@device-28.home>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-2-kuba@kernel.org>
	<20240830101630.52032f20@device-28.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 10:16:30 +0200 Maxime Chevallier wrote:
> > +static void
> > +ethtool_get_phydev_stats(struct net_device *dev,
> > +			 struct linkstate_reply_data *data)
> > +{
> > +	struct phy_device *phydev = dev->phydev;  
> 
> This would be a very nice spot to use the new
> ethnl_req_get_phydev(), if there are multiple PHYs on that device.
> Being able to access the stats individually can help
> troubleshoot HW issues.
> 
> > +static void
> > +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> > +{
> > +	struct phy_device *phydev = dev->phydev;  
> 
> Here as well, but that's trickier, as the MAC can override the PHY
> stats, but it doesn't know which PHY were getting the stats from.
> 
> Maybe we could make so that when we pass a phy_index in the netlink
> command, we don't allow the mac to override the phy stats ? Or better,
> don't allow the mac to override these stats and report the MAC-reported
> PHY stats alongside the PHY-reported stats ?

Maybe we can flip the order of querying regardless of the PHY that's
targeted? Always query the MAC first and then the PHY, so that the
PHY can override. Presumably the PHY can always provide more detailed
stats than the MAC (IOW if it does provide stats they will be more
accurate).

> > +	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
> > +		return;
> > +
> > +	mutex_lock(&phydev->lock);
> > +	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
> > +	mutex_unlock(&phydev->lock);
> > +}
> > +
> >  static int stats_prepare_data(const struct ethnl_req_info *req_base,
> >  			      struct ethnl_reply_data *reply_base,
> >  			      const struct genl_info *info)
> > @@ -145,6 +160,10 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
> >  	data->ctrl_stats.src = src;
> >  	data->rmon_stats.src = src;
> >  
> > +	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
> > +	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> > +		ethtool_get_phydev_stats(dev, data);  
> 
> I might be missing something, but I think
> ETHTOOL_MAC_STATS_SRC_AGGREGATE is a MM-specific flag and I don't really
> see how this applies to getting the PHY stats. I don't know much about
> MM though so I could be missing the point.

We need expert insights from Vladimir on that part :)

> I'm all in for getting the PHY stats from netlink though :)

Great! FWIW I'm not sure what the status of these patches is.
I don't know much about PHYs.
I wrote them to help Oleksij out with the "netlink parts".
I'm not sure how much I convinced Andrew about the applicability.
And I don't know if this is enough for Oleksij to take it forward.
So in the unlikely even that you have spare cycles and a PHY you can
test with, do not hesitate to take these, rework, reset the author 
and repost... :)

