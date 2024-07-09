Return-Path: <netdev+bounces-110095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1688392AF91
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D6F1F221CF
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E937147;
	Tue,  9 Jul 2024 05:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6872537FF
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504161; cv=none; b=fxij+nj8jogvZz/6nz8puHc260Sa5Qs0n7xDUFK+HEjS8u9nF5jgyaJqGeMuBZaflqZTkUc9xqeX68UbVmxfHPGYGeu6bk5ZXwf+HZMav2fGjxW4E0pRHzryMoITmyY0qyhckEa3zecjWKdV/mcMDireQWePq1WEl+DVwxrUho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504161; c=relaxed/simple;
	bh=It03ltIjjO9lEvQ29pwF5UNKmsPsL/vaE5d/+86fbTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Ls+uGQ9cbbgNYFf6Qcy3xcOqDvUm/Ak4+wbRscE0tkySd06k0pGrvRlVPGHtB1LHYwlobrfjEzdQgZgpD1C0a1ftSlOQg2p3Oah5Y8lchV8P/ucZv2AkWc55ykEd/Gfyh3bZUoj2H/b5v05YX4ZoiRXMjjoa/ztQxKUam3Tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sR3in-0002au-3M; Tue, 09 Jul 2024 07:49:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sR3ik-008D9L-Fz; Tue, 09 Jul 2024 07:48:58 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sR3ik-006RHF-1E;
	Tue, 09 Jul 2024 07:48:58 +0200
Date: Tue, 9 Jul 2024 07:48:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung.Huh@microchip.com
Cc: mkubecek@suse.cz, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	vladimir.oltean@nxp.com, andrew@lunn.ch,
	Arun.Ramadoss@microchip.com, kernel@pengutronix.de,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <ZozPSl6opHYYdO-A@pengutronix.de>
References: <20240706054900.1288111-1-o.rempel@pengutronix.de>
 <BL0PR11MB29139867F521F90347B6904EE7DA2@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR11MB29139867F521F90347B6904EE7DA2@BL0PR11MB2913.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Woojung,

On Mon, Jul 08, 2024 at 04:31:53PM +0000, Woojung.Huh@microchip.com wrote:
> Hi Oleksij,
> 
> > diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> > index b2de2108b356a..4efd327ba5d92 100644
> > --- a/net/ethtool/linkstate.c
> > +++ b/net/ethtool/linkstate.c
> > @@ -37,6 +37,8 @@ static int linkstate_get_sqi(struct net_device *dev)
> >         mutex_lock(&phydev->lock);
> >         if (!phydev->drv || !phydev->drv->get_sqi)
> >                 ret = -EOPNOTSUPP;
> > +       else if (!phydev->link)
> > +               ret = -ENETDOWN;
> >         else
> >                 ret = phydev->drv->get_sqi(phydev);
> >         mutex_unlock(&phydev->lock);
> > @@ -55,6 +57,8 @@ static int linkstate_get_sqi_max(struct net_device *dev)
> >         mutex_lock(&phydev->lock);
> >         if (!phydev->drv || !phydev->drv->get_sqi_max)
> >                 ret = -EOPNOTSUPP;
> > +       else if (!phydev->link)
> > +               ret = -ENETDOWN;
> >         else
> >                 ret = phydev->drv->get_sqi_max(phydev);
> >         mutex_unlock(&phydev->lock);
> > @@ -62,6 +66,16 @@ static int linkstate_get_sqi_max(struct net_device *dev)
> >         return ret;
> >  };
> > 
> > +static bool linkstate_sqi_critical_error(int sqi)
> > +{
> > +       return sqi < 0 && sqi != -EOPNOTSUPP && sqi != -ENETDOWN;
> > +}
> > +
> > +static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
> > +{
> > +       return data->sqi >= 0 && data->sqi_max >= 0;
> 
> If PHY driver has get_sqi, but not get_sqi_max, then data->sqi could have
> a valid value, but data->sqi_max will have -EOPNOTSUPP.
> In this case, linkstate_sqi_valid() will return FALSE and not getting 
> SQI value at all.

SQI without max will not able to describe quality of the link, it is
just value saying nothing to the user.

> If both APIs are required, then we could add another condition of
> data->sqi <= data->sqi_max in linkstate_sqi_valid()

Ack. I was thinking about it, but was not sure if it is a good idea. This
will silently filer our a bag. Passing a baggy value to the users space
is not good too. I'll fix.

> And, beside this, calling linkstate_get_sqi and linkstate_get_sqi_max
> could be moved under "if (dev->flags & IFF_UP)" with setting default 
> value to data->sqi & data->sqi_max.

IFF_UP is administrative up state, it is not the link/L1 up. sqi_max and
sqi should be initialized anyway, otherwise we will show 0/0 if
interface is in admin down.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

