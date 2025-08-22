Return-Path: <netdev+bounces-216008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D222B31741
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF57D168420
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C22FB60B;
	Fri, 22 Aug 2025 12:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB825BEF2
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864790; cv=none; b=gNSzgkQGkmYHZ4MkBC9tOMa9jZRvlXyCgLMctSDxbp5T7WFGAfmCaOZgFMUXqcLiTyBgWW53J0ojzZnbT4txVCqCAnxg9XkLSt6tU37aovJD6O3k19d720e9jmHCxIONB3yWGDlo5/xQif8F+1ng0pKa6wkcKVgYoft0f6+I3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864790; c=relaxed/simple;
	bh=zl3fBfFYqpvYyjZtF0IJRHUpHtolahh+GBfvrNKUNZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQWTQ48fBhzo9xjsaN3Tcjy9zsefJ14AFtChrh1fJzi/5O5Hgj8KbGRYPU1TPYIoVsDm3Fu8DdY2E8/+AgqVeqqB8EHeJUaRNwcZjTZ60YoIvxO/ue52jqzuLJElC9icgr9Sn97H/GzfeTtUHYrtStPRy4cr8axq6egVTvb+iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upQdC-0007ru-7h; Fri, 22 Aug 2025 14:12:30 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upQd9-001ZgO-0K;
	Fri, 22 Aug 2025 14:12:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upQd8-00A84v-2z;
	Fri, 22 Aug 2025 14:12:26 +0200
Date: Fri, 22 Aug 2025 14:12:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 3/3] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aKheqhfqht1Cx31M@pengutronix.de>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
 <20250820131023.855661-4-o.rempel@pengutronix.de>
 <20250822113519.y6maeu4ifoqx4mxe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822113519.y6maeu4ifoqx4mxe@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Aug 22, 2025 at 02:35:19PM +0300, Vladimir Oltean wrote:
...
> > +
> > +* **Who uses it**: Any full-duplex link, from 10 Mbit/s to multi-gigabit speeds.
> > +
> > +The MAC (Media Access Controller)
> > +---------------------------------
> > +The MAC is the hardware component that actually sends and receives PAUSE
> > +frames. Its capabilities define the upper limit of what the driver can support.
> > +For link-wide PAUSE, MACs can vary in their support for symmetric (both
> > +directions) or asymmetric (independent TX/RX) flow control.
> > +
> > +For PFC, the MAC must be capable of generating and interpreting the
> > +priority-based PAUSE frames and managing separate pause states for each
> > +traffic class.
> > +
> > +Many MACs also implement automatic PAUSE frame transmission based on the fill
> > +level of their internal RX FIFO. This is typically configured with two
> > +thresholds:
> > +
> > +* **FLOW_ON (High Water Mark)**: When the RX FIFO usage reaches this
> > +  threshold, the MAC automatically transmits a PAUSE frame to stop the sender.
> > +
> > +* **FLOW_OFF (Low Water Mark)**: When the RX FIFO usage drops below this
> > +  threshold, the MAC transmits a PAUSE frame with a quanta of zero to tell
> > +  the sender it can resume transmission.
> > +
> > +The optimal values for these thresholds depend on the link's round-trip-time
> > +(RTT) and the peer's internal processing latency. The high water mark must be
> > +set low enough so that the MAC's RX FIFO does not overflow while waiting for
> > +the peer to react to the PAUSE frame. The driver is responsible for configuring
> > +sensible defaults according to the IEEE specification. User tuning should only
> > +be necessary in special cases, such as on links with unusually long cable
> > +lengths (e.g., long-haul fiber).
> 
> How would user tuning be achieved?

Do you mean how such tuning could be exposed to user space (e.g. via
ethtool/sysfs), or rather whether it makes sense to provide a user
interface for this at all, since drivers normally set safe defaults?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

