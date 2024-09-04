Return-Path: <netdev+bounces-124863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9096B3EB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FDAB220BE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01D17BEB0;
	Wed,  4 Sep 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o8ZnfW1w"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C452F70
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437357; cv=none; b=c/ht7cTvAbUBidznpBP24FWQqIWMSbXSKh6AnZZ7aEk3PbsIfYv//YWQWNGNCSFK5gc/NoTc5Zv3f7p50LxUUpl9HNsWk6ntNtGgHIg7OOn9f6NBlDS4SNUGEWkDgb9eEYp3ppXo9iiWJ1rJo+wbWvkzEgjxK2tVVUpaD2MIVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437357; c=relaxed/simple;
	bh=1JCG1KHcZ4KKVgZYGip3xZCAZyTDx5yEH+NhC+UdKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbmJy4L6OfE6lw6ED9svW4t1FPI/BKsf4gsH6398uWwJT/2pzQgQ5qPJmJBs1XzPaTPIJjkeAwQimN2FtLPrwbMvfIwVo133jC6GXbwIt+3X0lobWs1LkNRMFR+oOvFP9d4v4WqUKhMU92g5M5TPNIScoJpLiP7oJIh69/6VHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o8ZnfW1w; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55766E000B;
	Wed,  4 Sep 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725437346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kzMBrmbvEMVyXqIRbkDUjk3meg06SmXZo8vLbQNa4I=;
	b=o8ZnfW1wLruExRgoKsc9wCjQk1KUdQ9on74qFtAVU0rvVWr/1GHHx00a1fcpPDlYO3LMax
	/hmux2qGNr9SpzidbpgzJrdtvfXksseAKbJvA3M0MIwi8goqAobNsDVPXGUQ4wesmyqIae
	72zvHe5mzfFmWqtZ9JfcARhxj+KjcTzB96vTHd2McGCxJmNGrVf0OiwHbpivmpHEh0fhFJ
	8lM062qCnzymFbqini1N1G0bUfJYqK6/oJbX3I8VtqoF9kGcb3C1CvbDeKgM+QEx9GBTjX
	ueS7qmZX4ZHxbnLXCNc2sxjVjeAOI++PgWZBC/GHO8z+UsQjtk26IjpKYzeeIQ==
Date: Wed, 4 Sep 2024 10:09:04 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Vladimir
 Oltean <olteanv@gmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240904100904.14e382c1@fedora.home>
In-Reply-To: <ZtgUthjSJYgJEMmH@pengutronix.de>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-2-kuba@kernel.org>
	<20240830101630.52032f20@device-28.home>
	<20240830113047.10dcee79@kernel.org>
	<20240904092024.530c54c3@fedora.home>
	<ZtgUthjSJYgJEMmH@pengutronix.de>
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

On Wed, 4 Sep 2024 10:05:10 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi all,
> 
> On Wed, Sep 04, 2024 at 09:20:24AM +0200, Maxime Chevallier wrote:
> > Hi Jakub,
> > 
> > On Fri, 30 Aug 2024 11:30:47 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > On Fri, 30 Aug 2024 10:16:30 +0200 Maxime Chevallier wrote:  
> > > > > +static void
> > > > > +ethtool_get_phydev_stats(struct net_device *dev,
> > > > > +			 struct linkstate_reply_data *data)
> > > > > +{
> > > > > +	struct phy_device *phydev = dev->phydev;      
> > > > 
> > > > This would be a very nice spot to use the new
> > > > ethnl_req_get_phydev(), if there are multiple PHYs on that device.
> > > > Being able to access the stats individually can help
> > > > troubleshoot HW issues.
> > > >     
> > > > > +static void
> > > > > +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> > > > > +{
> > > > > +	struct phy_device *phydev = dev->phydev;      
> > > > 
> > > > Here as well, but that's trickier, as the MAC can override the PHY
> > > > stats, but it doesn't know which PHY were getting the stats from.
> > > > 
> > > > Maybe we could make so that when we pass a phy_index in the netlink
> > > > command, we don't allow the mac to override the phy stats ? Or better,
> > > > don't allow the mac to override these stats and report the MAC-reported
> > > > PHY stats alongside the PHY-reported stats ?    
> > > 
> > > Maybe we can flip the order of querying regardless of the PHY that's
> > > targeted? Always query the MAC first and then the PHY, so that the
> > > PHY can override. Presumably the PHY can always provide more detailed
> > > stats than the MAC (IOW if it does provide stats they will be more
> > > accurate).  
> > 
> > I think that could work indeed, good point.
> > 
> > [...]
> >   
> > > > I'm all in for getting the PHY stats from netlink though :)    
> > > 
> > > Great! FWIW I'm not sure what the status of these patches is.
> > > I don't know much about PHYs.
> > > I wrote them to help Oleksij out with the "netlink parts".
> > > I'm not sure how much I convinced Andrew about the applicability.
> > > And I don't know if this is enough for Oleksij to take it forward.
> > > So in the unlikely even that you have spare cycles and a PHY you can
> > > test with, do not hesitate to take these, rework, reset the author 
> > > and repost... :)  
> > 
> > I do have some hardware I can test this on, and I'm starting to get
> > familiar with netlink :) I can give it a try, however I can't guarantee
> > as of right now that I'll be able to send anything before net-next
> > closes. I'll ping here if I start moving forward with this :)  
> 
> I reserved some time for this work. I hope it will be this year.
> 
> In case some one else will start working on it, please let me know :)

Ah perfect then :) Let me know if you ever need some extra testing, I
can run this on the hardware I have on hand if that can help.

Best regards,

Maxime


