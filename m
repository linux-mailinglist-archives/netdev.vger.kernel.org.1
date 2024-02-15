Return-Path: <netdev+bounces-71970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF9855C33
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34AA1F22BF9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D912B7C;
	Thu, 15 Feb 2024 08:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178512B90
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985105; cv=none; b=HHzeE0IMUusBiJQM0qvGR7UiT1cmstHj5TltOnKXfYIo00RyyQFRteUF/2ZgUSe+rxIo517di78ROMncpK1Sz6KswUbRjUiwPYdgVQIzKBgIepSqu7Axpfdl4v1DETAsLufMFJgDdqa5hXprcShL+uP3FabKFFFa82dOyHvCXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985105; c=relaxed/simple;
	bh=T2XuyeJ06MJPPCxU0//IIk7MVsi0C5XUfXUB6lx/2NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1imxYJvMyGqQS2BPGFI8zh/AWx2RwvI/wzWZ1YDePH+xkfeT61v4Op2eGlAOmMDwrPKqLoI/mxSdbYP09tKjhDjuraGJFfTXZnyMEFKbtvZ1e/dStJr9YnCL/wd9/3v6uApzSB+VTJ6z7Lxq1wqxbYmBkRCA9fbP3RkIK2ij/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1raWwN-0002wJ-5C; Thu, 15 Feb 2024 09:17:55 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1raWwG-000qaq-AJ; Thu, 15 Feb 2024 09:17:48 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1raWwG-009xxI-0d;
	Thu, 15 Feb 2024 09:17:48 +0100
Date: Thu, 15 Feb 2024 09:17:48 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <Zc3IrO_MXIdLXnEL@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
 <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Feb 14, 2024 at 06:41:54PM +0100, Andrew Lunn wrote:
> > Alternative A and B Overview
> > ----------------------------
> > 
> > - **Alternative A:** Utilizes the data-carrying pairs for power transmission in
> >   10/100BaseT networks. The power delivery's polarity in this alternative can
> >   vary based on the MDI (Medium Dependent Interface) or MDI-X (Medium Dependent
> >   Interface Crossover) configuration.
> > 
> > - **Alternative B:** Delivers power over the spare pairs not used for data in
> >   10/100BaseT networks. Unlike Alternative A, Alternative B's method separates
> >   power from data lines within the cable. Though it is less influenced by data
> >   transmission direction, Alternative B includes two configurations with
> >   different polarities, known as variant X and variant S, to accommodate
> >   different network requirements and device specifications.
> 
> Thanks for this documentation.
> 
> It might be worth pointing out that RJ-45 supports up to 4
> pairs. However, 10/100BaseT only makes use of two pairs for data
> transfer from the four. 1000BaseT and above make use of all four pairs
> for data transfer. If you don't know this, it is not so obvious what
> 'data-carrying pairs' and 'spare pairs' mean.

@Kory, can you please update it.

> And what happens for 1000BaseT when all four pairs are in use?

Hm.. good question. I didn't found the answer in the spec. By combining all
puzzle parts I assume, different Alternative configurations are designed
to handle conflict between "PSE Physical Layer classification" and PHY
autoneg.

Here is how multi-pulse Physical Layer classification is done:
https://img.electronicdesign.com/files/base/ebm/electronicdesign/image/2020/07/Figure_5.5f2094553a61c.png

this is the source:
https://www.electronicdesign.com/technologies/power/whitepaper/21137799/silicon-labs-90-w-power-over-ethernet-explained

To avoid classification conflict with autoneg. Assuming, PHY on PD side
will be not powered until classification is completed. The only source
of pulses is the PHY on PSE side (if it is not under control of software
on PSE side or Midspan PSE is used), so aneg pulses should be send on
negative PoE pair? This all is just speculation, I would need to ask
some expert or do testing.

If this assumption is correct, PHY framework will need to know exact
layout of MDI-X setting and/or silent PHY until PSE classification is done.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

