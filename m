Return-Path: <netdev+bounces-109362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E2928277
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BEE1F227EC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECE144D20;
	Fri,  5 Jul 2024 07:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8F13AD2A
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163147; cv=none; b=L9WPejtsNogLEc1IN+VKi7Ar/u5w27BcKUIQRRd1FXnKrOTwDr1d6MLZpsXHp5n+Pmxq66Gk2VuiX5bhFgOzZYG9rKeSlw4bRZWNmvS2wa/WCTYlIKzUMAZLqFdkHITAsm3xfEjna1PXOGE1fSvhoKnm3yMv3CFwAyTSsStIrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163147; c=relaxed/simple;
	bh=3CrW8uCnclJiUqfmiuDDclKNgSX9zdIEWWy3tTIlWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDuxI1p9IMZ37VAYRd2xTS8icoEN2TnOP7gUx4azsXrXsyxLjrHvqJBdN68H62/ue5jpmzQ/gItGHERcIaCgik1M85MBPAFquwjFGHMwl0AojB4bB70S9j18w4xIkNkLdDrMv6rzfBvFv0aUocJfIvVC6dc4KTg3WFE6BHcI+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPd0f-0006NI-Fz; Fri, 05 Jul 2024 09:05:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPd0e-007GvS-1w; Fri, 05 Jul 2024 09:05:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPd0d-00GMlQ-36;
	Fri, 05 Jul 2024 09:05:31 +0200
Date: Fri, 5 Jul 2024 09:05:31 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Kubecek <mkubecek@suse.cz>, Woojung.Huh@microchip.com,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v1 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <ZoebO_i6P33iX4B1@pengutronix.de>
References: <20240704054007.969557-1-o.rempel@pengutronix.de>
 <dbfa3bc1-fff0-4dc7-a9f2-6cd304d4eaf8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbfa3bc1-fff0-4dc7-a9f2-6cd304d4eaf8@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jul 04, 2024 at 04:01:31PM +0200, Andrew Lunn wrote:
...
> >  	ret = linkstate_get_sqi(dev);
> > -	if (ret < 0 && ret != -EOPNOTSUPP)
> > +	if (ret < 0 && ret != -EOPNOTSUPP && ret != -ENETDOWN)
> >  		goto out;
> >  	data->sqi = ret;
> 
> So data->sqi becomes -ENETDOWN 
> 
> 
> > -	if (data->sqi != -EOPNOTSUPP &&
> > +	if (data->sqi != -EOPNOTSUPP && data->sqi != -ENETDOWN &&
> >  	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
> >  		return -EMSGSIZE;
> 
> Thinking about the old code, if the driver returned something other
> than -EOPNOTSUPP, it looks like the error code would make it to user
> space. Is ethtool/iproute2 setup to correctly handle this? If it is,
> maybe pass the -ENETDOWN to user space?

In current state with ethtool v6.5 i'll get following results.
If no -ENETDOWN is returned:
Settings for spe4:
        Supported ports: [ TP ]
        Supported link modes:   100baseT1/Full
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced slave
        master-slave status: unknown
        Port: Twisted Pair
        PHYAD: 6
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

If -ENETDOWN is returned:
Settings for spe4:
        Supported ports: [ TP ]
        Supported link modes:   100baseT1/Fulli
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced slave
        master-slave status: unknown
        Port: Twisted Pair
        PHYAD: 6
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
netlink error: Network is down

Instead of "Link detected: no", we will get netlink error.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

