Return-Path: <netdev+bounces-132159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7D9909A6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F581F21E22
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4C1C3037;
	Fri,  4 Oct 2024 16:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F41E3789
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060389; cv=none; b=mAuBVCX0CsZT03EFwQfIdu9bwxyCmSOd9ZVFqN5QFAA6/p+2e0OB3ikILybpPByb9XvhjFL3SLOiJZyrKusjUUWzDVu5jJaqsJSk6MXK2gDcxKC6R1cb4Vuy1TdA9cMvdFaqv6gzOHXClBcpzLsu4op6ajIYUamY0cDjmRYoR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060389; c=relaxed/simple;
	bh=ylnnfKvetf93g2DUN//euZqD3scWcX/30/I9+Vkfp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Qo8K9TnZeMAqM4Yo4QAVYmWSscIwUQW0fUVpu3FZ4QNTdueIwx/ZTQCWaXynqGdpdMzN4xa0GP00u+9q+OXefDWkNy+HKake3rvGKYLSn6EqNNWjMpIRn2qjVy6WwMOj8KkJrVCwQ0UUuFi1uO9+gH+K82vi+f2z8ItOYkpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRf-0000as-FV; Fri, 04 Oct 2024 18:46:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRc-003daH-BK; Fri, 04 Oct 2024 18:46:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swlRc-00AkA7-0n;
	Fri, 04 Oct 2024 18:46:20 +0200
Date: Fri, 4 Oct 2024 18:46:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report
 isolation support
Message-ID: <ZwAb3DNWYl0ykRBl@pengutronix.de>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004161601.2932901-4-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Oct 04, 2024 at 06:15:53PM +0200, Maxime Chevallier wrote:
> Some PHYs have malfunctionning isolation modes, where the MII lines
> aren't correctly set in high-impedance, potentially interfering with the
> MII bus in unexpected ways. Some other PHYs simply don't support it.

Do we have in this case multiple isolation variants like high-impedance
and "the other one"? :)  Do the "the other one" is still usable for some
cases like Wake on LAN without shared xMII?

I'm just curios.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

