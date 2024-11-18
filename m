Return-Path: <netdev+bounces-145973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A39D173C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB76282E67
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F11C1AB3;
	Mon, 18 Nov 2024 17:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4C13B297
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951443; cv=none; b=o3NXhq7PQhN9hNta+n+NKorMwThYpejNBjIpBQWKPQlJhOo4psGM79ipRsObu96Y3PgXKyxLwG1QYl1l1uvBdOw6rBo3WzGJe4M2/+fcl06U2JfnpUyA7tI96XiG+jzhcr4MUAqxq13BKSDe6hUsRik2mV7Bk3HiqTLbVk8xJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951443; c=relaxed/simple;
	bh=Yo0gB4ek0uFbneWNFNJ+hEqTULdzuIhAy5RBWMXlMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgbridYWRveC/Jc7R+wra8/wldNAQKqwoabpAl0DDqqRoJTRqnppd4jVaeBh3OkNZGcfvbQhZB2O0e384/BK8n7Eu45nl8x1VRdjDvAJmnWy9cGVFfrmEnyNdGY3wQbrJE08T2MT0NwKMd6udrEY1nhohUxyruZvAGFUPBopjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gQ-0004GK-48; Mon, 18 Nov 2024 18:37:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gO-001Qvh-0F;
	Mon, 18 Nov 2024 18:37:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tD5gN-001V9N-36;
	Mon, 18 Nov 2024 18:37:03 +0100
Date: Mon, 18 Nov 2024 18:37:03 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/1] net: phy: microchip: Reset LAN88xx PHY to
 ensure clean link state on LAN7800/7850
Message-ID: <Zzt7P6KklGzgrtob@pengutronix.de>
References: <20241117102147.1688991-1-o.rempel@pengutronix.de>
 <20241118174849.5625064f@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118174849.5625064f@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Nov 18, 2024 at 05:48:49PM +0100, Maxime Chevallier wrote:
> Hi Oleksij,
> 
> On Sun, 17 Nov 2024 11:21:47 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Fix outdated MII_LPA data in the LAN88xx PHY, which is used in LAN7800
> > and LAN7850 USB Ethernet controllers. Due to a hardware limitation, the
> > PHY cannot reliably update link status after parallel detection when the
> > link partner does not support auto-negotiation. To mitigate this, add a
> > PHY reset in `lan88xx_link_change_notify()` when `phydev->state` is
> > `PHY_NOLINK`, ensuring the PHY starts in a clean state and reports
> > accurate fixed link parallel detection results.
> > 
> > Fixes: 792aec47d59d9 ("add microchip LAN88xx phy driver")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This looks like the issue in the Asix AX88772A, but your patch has
> better error handling :)

It was my code in Asix. Need to add proper error handling too. It is not
nice if device is detached but kernel is continuing executing things and
printing a lot of errors.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

