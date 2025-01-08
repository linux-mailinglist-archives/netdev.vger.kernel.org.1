Return-Path: <netdev+bounces-156219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB8A0596C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FAC3A5D41
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F01F76C3;
	Wed,  8 Jan 2025 11:14:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179761F8EF1
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334876; cv=none; b=nH8/9khIcwMEXoVEclsEf+hn/OMvR43AxUXrg3NjDvYVtAzuEWq55H0MywK0hgdTXkn/4I0/Y/JJnIA27Y4+2qyN4hdytV/9Vz/Io1Wj7quBzS8i/FuGPqTMLlxoFZBD1p+ptggaSWW1/NiSGXfNUg8LhH5N2GJeDf/ol9WgR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334876; c=relaxed/simple;
	bh=zRd199j9xnbEJ005wwsTxmCSUVzh1H0rEIdYNJE4RtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlSChdS5MGOSaeypIcmZC9UZmAN91Uec64FjIWWkEBchopdtTg5O4DsaoqS8U2VicO+hILkmur8gqq2IOqzcyzrVmjYbbIoXuzKF15KNgMu/Emn/9wQaTiOtrq2tcsz/jd7je1EJq+HWsk4x4YhyemWwpufGp5fyIwh6SDm7oXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVU11-0006vf-KT; Wed, 08 Jan 2025 12:14:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVU10-007VYY-1m;
	Wed, 08 Jan 2025 12:14:23 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVU11-00BTrZ-0e;
	Wed, 08 Jan 2025 12:14:23 +0100
Date: Wed, 8 Jan 2025 12:14:23 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 02/14] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Message-ID: <Z35eD2ykGkohQZuK@pengutronix.de>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
 <20250104-b4-feature_poe_arrange-v1-2-92f804bd74ed@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-2-92f804bd74ed@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jan 04, 2025 at 11:27:27PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Setting the max_uA constraint in the regulator API imposes a current
> limit during the regulator registration process. This behavior conflicts
> with preserving the maximum PI power budget configuration across reboots.
> 
> Instead, compare the desired current limit to MAX_PI_CURRENT in the
> pse_pi_set_current_limit() function to ensure proper handling of the
> power budget.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

