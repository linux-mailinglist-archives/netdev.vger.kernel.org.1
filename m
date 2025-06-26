Return-Path: <netdev+bounces-201518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B2AE9B0C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ED517C4AF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878021CA1D;
	Thu, 26 Jun 2025 10:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F016A94A
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933125; cv=none; b=N23uGZFOfDI4oB1cqNlSIDWVxSua+Yl5uojc7aK4NEKzgX6JQKLUZRFxY0g/3Crp6B729sVHZFhzI4X8FGI0KgQ1UMRnFPosEZKai0GRICKnSc0IhuaeCfmepvNwd/KGVkBSPMq7SlFG7MJmcB/Zgyr3UJBgnuGtBSN4F4PbUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933125; c=relaxed/simple;
	bh=CGKx2EBTVnGnZ/Rsc5Qxm6HBGZtC8OudMU3a2sjLxUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIyyNGeVlbedRETbDedRoblEl7zyZ7HA/4xI9g6OHIM8cN8TnQejoAkukdiHLQBKFmiQ87dIKB11YdXps3R2HYCUtaDN8CmQ911waOjWW4/JDuZtgUFNtssSGXTc4rdAMvECYj4bKO8D3LyQLg/Wy/harFR225xCn9TBpDvGbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUjgc-0003YM-Rf; Thu, 26 Jun 2025 12:18:30 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUjgb-005Qny-19;
	Thu, 26 Jun 2025 12:18:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUjgb-001XrH-0k;
	Thu, 26 Jun 2025 12:18:29 +0200
Date: Thu, 26 Jun 2025 12:18:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: fix WARN in
 __netif_napi_del_locked on disconnect
Message-ID: <aF0edQRJAXSps5CV@pengutronix.de>
References: <20250620085144.1858723-1-o.rempel@pengutronix.de>
 <20250623165537.53558fdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623165537.53558fdb@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jun 23, 2025 at 04:55:37PM -0700, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 10:51:44 +0200 Oleksij Rempel wrote:
> > A WARN may be triggered in __netif_napi_del_locked() during USB device
> > disconnect:
> > 
> >   WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350
> > 
> > This occurs because NAPI remains enabled when the device is unplugged and
> > teardown begins. While `napi_disable()` was previously called in the
> > `lan78xx_stop()` path, that function is not invoked on disconnect. Instead,
> > when using PHYLINK, the `mac_link_down()` callback is guaranteed to run
> > during disconnect, making it the correct place to disable NAPI.
> > 
> > Similarly, move `napi_enable()` to `mac_link_up()` to pair the lifecycle
> > with actual MAC state.
> 
> Stopping and starting NAPI on link events is pretty unusual.
> The problem is the disconnect handling, unregistering netdev
> removes the NAPIs automatically, I think all you need is to
> remove the explicit netif_napi_del() in lan78xx_disconnect().
> Core will call _stop (which disables the NAPI), and then
> it will del the NAPI.

ack.

> > This patch is intended for `net-next` since the issue existed before the
> > PHYLINK migration, but is more naturally and cleanly addressed now that
> > PHYLINK manages link state transitions.
> 
> And repost that for net, please.. :)

It will be not compatible with the PHYlink migration patch in the
net-next. Should i wait until PHYlink patch goes to the net and then
send different patch variants for stable before PHYlink migration and
after?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

