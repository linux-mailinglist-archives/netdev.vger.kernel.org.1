Return-Path: <netdev+bounces-242590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C267C925FD
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B794E1181
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B53093C1;
	Fri, 28 Nov 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lbJbalB2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173671FECCD
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341835; cv=none; b=p9zyiDIUjYV1cUlJB3bj780dupnY151mV/xvn0G6AwRi0R6GyPOGbCL0UFjS+f6hChucywyUVUz9HUSE5P+rdPygasWDO6x9XkKfnV2gxTm3Ls+bT0Hc9ztUa3lL3pAu9Au5TvDZN/VBAwg/5W0oXwCyq2ITpUycXlPnBuGDpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341835; c=relaxed/simple;
	bh=aELHQl8K1HKjCIXX40jXNZBMmMkYahSK6M/I7JQG/Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpCb0rAySeSRo4wncGKa12+lcfWWITbX3m+oHzMIxRZAWPR6H1u9F41sElLbDSAgUf+S/QRPuqsUf4wtHQ/x0YHpfNgsdf+3POhQKST/wXllsNEewu/PjkKC3762azr5eSt2rKD1dS2/R7PGcFw7HpsH1N8WXKksmUz5jSQFujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lbJbalB2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AyRbPVnjabNqxyJEQWBCuEGPJ7CqQLz5zTMyLbptNUw=; b=lbJbalB27uiBuUCCwGQtBPn6Kf
	lkSV7FNxwaGc9t1d9IRi4CLBf4FDdaZOIkxPKaarjg/XhCc/0bwycfBpwTAMmVvYuDwcYbj+7bgBe
	Pcr6cyDfwuuIWB7xLHaeQFi262vEDzs5T6JKgDpWJbdGePu3Od1EPmwCfVx06q4E2D7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOzuF-00FLwL-8l; Fri, 28 Nov 2025 15:57:07 +0100
Date: Fri, 28 Nov 2025 15:57:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: thunderbolt: Allow reading link
 settings
Message-ID: <e4f3eefa-9a01-413d-9ba6-ec9ebc381061@lunn.ch>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
 <20251127131521.2580237-4-mika.westerberg@linux.intel.com>
 <3ac72bf4-aa0e-4e3f-b6ef-4ed2dce923e1@lunn.ch>
 <20251128072351.GB2580184@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128072351.GB2580184@black.igk.intel.com>

On Fri, Nov 28, 2025 at 08:23:51AM +0100, Mika Westerberg wrote:
> On Thu, Nov 27, 2025 at 08:20:53PM +0100, Andrew Lunn wrote:
> > > +static int tbnet_get_link_ksettings(struct net_device *dev,
> > > +				    struct ethtool_link_ksettings *cmd)
> > > +{
> > > +	const struct tbnet *net = netdev_priv(dev);
> > > +	const struct tb_xdomain *xd = net->xd;
> > > +	int speed;
> > > +
> > > +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> > > +	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> > > +
> > > +	/* Figure out the current link speed and width */
> > > +	switch (xd->link_speed) {
> > > +	case 40:
> > > +		/* For Gen 4 80G symmetric link the closest one
> > > +		 * available is 56G so we report that.
> > > +		 */
> > > +		ethtool_link_ksettings_add_link_mode(cmd, supported,
> > > +						     56000baseKR4_Full);
> > > +		ethtool_link_ksettings_add_link_mode(cmd, advertising,
> > > +						     56000baseKR4_Full);
> > > +		speed = SPEED_56000;
> > 
> > Please add SPEED_80000.
> 
> Sure. One additional question though. Comment on top of SPEED_ definitions
> suggest changing __get_link_speed() of the bonding driver accordingly but
> it basically converts from SPEED_ to AD_LINK_SPEED_ which I think we need
> to add too. However, these are user-facing values so should I add the
> AD_LINK_SPEED_80000 entry to the end of that enum to avoid any possible
> breakage?

Are they user facing? They should be define in include/uapi if they
were. I would keep the list sorted, and Cc: the bonding driver
Maintainer, Jay Vosburgh <jv@jvosburgh.net> (maintainer:BONDING DRIVER).

Also:

cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   61) enum ad_link_speed_type {
cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   62)      AD_LINK_SPEED_1MBPS = 1,
cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   63)      AD_LINK_SPEED_10MBPS,
cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   64)      AD_LINK_SPEED_100MBPS,
cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   65)      AD_LINK_SPEED_1000MBPS,
424c3232b04ac (Jianhua Xie                 2014-11-19 16:48:59 +0800   66)      AD_LINK_SPEED_2500MBPS,
c7c550670afda (Thibaut Collet              2017-06-08 11:18:11 +0200   67)      AD_LINK_SPEED_5000MBPS,
424c3232b04ac (Jianhua Xie                 2014-11-19 16:48:59 +0800   68)      AD_LINK_SPEED_10000MBPS,
3fcd64cfa0e9c (Nicolas Dichtel             2017-06-08 11:18:12 +0200   69)      AD_LINK_SPEED_14000MBPS,
424c3232b04ac (Jianhua Xie                 2014-11-19 16:48:59 +0800   70)      AD_LINK_SPEED_20000MBPS,
19ddde1eeca1e (Jarod Wilson                2017-03-14 11:48:32 -0400   71)      AD_LINK_SPEED_25000MBPS,
424c3232b04ac (Jianhua Xie                 2014-11-19 16:48:59 +0800   72)      AD_LINK_SPEED_40000MBPS,
c7c550670afda (Thibaut Collet              2017-06-08 11:18:11 +0200   73)      AD_LINK_SPEED_50000MBPS,
3952af4d50343 (Jiri Pirko                  2015-12-03 12:12:05 +0100   74)      AD_LINK_SPEED_56000MBPS,
3952af4d50343 (Jiri Pirko                  2015-12-03 12:12:05 +0100   75)      AD_LINK_SPEED_100000MBPS,
ab73447c38e4f (Nikolay Aleksandrov         2021-02-10 22:43:31 +0200   76)      AD_LINK_SPEED_200000MBPS,
138e3b3cc0bbb (Nikolay Aleksandrov         2021-02-10 22:43:32 +0200   77)      AD_LINK_SPEED_400000MBPS,
41305d3781d70 (Amit Cohen                  2022-10-20 17:20:05 +0200   78)      AD_LINK_SPEED_800000MBPS,
cb8dda90c28e2 (Jianhua Xie                 2014-11-19 16:48:58 +0800   79) };

suggests you can insert in the middle:

commit c7c550670afda2e16f9e2d06a1473885312eb6b5
Author: Thibaut Collet <thibaut.collet@6wind.com>
Date:   Thu Jun 8 11:18:11 2017 +0200

    bonding: fix 802.3ad support for 5G and 50G speeds
    
    This patch adds [5|50] Gbps enum definition, and fixes
    aggregated bandwidth calculation based on above slave links.
    
    Fixes: c9a70d43461d ("net-next: ethtool: Added port speed macros.")
    Signed-off-by: Thibaut Collet <thibaut.collet@6wind.com>
    Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
    Acked-by: Andy Gospodarek <andy@greyhouse.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index b44a6aeb346d..d1b09be63ba4 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -90,10 +90,12 @@ enum ad_link_speed_type {
        AD_LINK_SPEED_100MBPS,
        AD_LINK_SPEED_1000MBPS,
        AD_LINK_SPEED_2500MBPS,
+       AD_LINK_SPEED_5000MBPS,
        AD_LINK_SPEED_10000MBPS,
        AD_LINK_SPEED_20000MBPS,
        AD_LINK_SPEED_25000MBPS,
        AD_LINK_SPEED_40000MBPS,
+       AD_LINK_SPEED_50000MBPS,
        AD_LINK_SPEED_56000MBPS,
        AD_LINK_SPEED_100000MBPS,


	Andrew

