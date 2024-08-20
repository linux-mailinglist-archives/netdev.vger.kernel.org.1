Return-Path: <netdev+bounces-120292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF01958DB2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883272830F3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA81C4624;
	Tue, 20 Aug 2024 17:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444601C2334
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176764; cv=none; b=DMT1IYtUo4LpEuXhmdRG85i2VFXo6HjA0ZdxiYXtjT7RQoPd3+NSz4Ea9zSXkpnzILzyJbAUgLXCU5pgS68ISMIjlLr+GvdkwXyx7jP15OXy6MokP88VMvuH77QgzLgGrm89iPnL4WwEM2jQ0enjGlhUdnqOxeUPHI74SsxDWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176764; c=relaxed/simple;
	bh=7Hac1aUiPKCXSTl46nGmc6RX478GnP3EynB21btfunA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUKzsmcFUF5v64sOxXbbdokCMVlcPdCHw45wFt6dH4rolnu68Q10XHavu7UD04UcPVcdMgKZ0mDeWL0/HSm7V2thiy4kWMgHqRuwNnyEd35hbw/Z/zMvqe+PnoHVpWkJCSyROa/TuisZs3Gwg8B6TQvdJcnf1psG6RV5wXUK+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgT8R-0006Uq-03; Tue, 20 Aug 2024 19:59:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgT8N-001pCX-Ax; Tue, 20 Aug 2024 19:59:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgT8N-00DiEr-0i;
	Tue, 20 Aug 2024 19:59:07 +0200
Date: Tue, 20 Aug 2024 19:59:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 3/3] phy: dp83td510: Utilize ALCD for cable
 length measurement when link is active
Message-ID: <ZsTZa5EsK9y32Yl3@pengutronix.de>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
 <20240820101256.1506460-4-o.rempel@pengutronix.de>
 <a02698f3-94b6-4e6c-b13a-7fbeba2ce42f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a02698f3-94b6-4e6c-b13a-7fbeba2ce42f@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Aug 20, 2024 at 06:49:00PM +0200, Andrew Lunn wrote:
> > +static int dp83td510_cable_test_get_status(struct phy_device *phydev,
> > +					   bool *finished)
> > +{
> > +	*finished = false;
> > +
> > +	if (!phydev->link)
> > +		return dp83td510_cable_test_get_tdr_status(phydev, finished);
> > +
> > +	return dp83td510_cable_test_get_alcd_status(phydev, finished);
> 
> Sorry, missed this earlier. It seems like there is a race here. It
> could be the cable test was started without link, but when phylib
> polls a few seconds later link could of established. Will valid ALCD
> results be returned?

Hm.. probably not. In this case the best option I have is to store
results in the priv. Will it be acceptable?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

