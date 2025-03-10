Return-Path: <netdev+bounces-173463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C5A590DD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352DC7A5266
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5722652D;
	Mon, 10 Mar 2025 10:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D422617F
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601783; cv=none; b=PUjohESwkxoUhd3r/evxwiDIwHtPSdc/TKm+FaIM/ZvmCxSKtrQPdVJ9Jgzyg8quQYXLSI/Zt7J/pX7geP/K/8WoDBbrxePhIewB0TgCB0d+mVRcK7stw1p5C4R3gDCtiQ0b5Ks9CpheYpa82RKurgSlU8d0+Xn2Zs4eh6tAc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601783; c=relaxed/simple;
	bh=AVuAqitwovQZSGVEAsVCuCuAKA9myIFwPMi1B/0NumI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihFINLH3YrGvsHAFw9GqARuC0H3F2wJX+VEW6yE/Da5Z1LQkT07Gp+iBP574fZhmgKLlFdljdvL+vYmV9t7oKX/TDNEsJcoYKDSZ9D5vG2FWrbwof9tUJzj1YldVDDlzSSbvQjXemlRuQBzV3kP0kjgfOyL+LBK9A6YKJ1PFUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1traB9-0001LQ-A4; Mon, 10 Mar 2025 11:16:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traB8-004ypp-25;
	Mon, 10 Mar 2025 11:16:10 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traB8-005ra3-1d;
	Mon, 10 Mar 2025 11:16:10 +0100
Date: Mon, 10 Mar 2025 11:16:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thangaraj.S@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	Rengarajan.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z8676rcaq6h4X8To@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
 <20250307182432.1976273-2-o.rempel@pengutronix.de>
 <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
 <Z863zsYNM8hkfB19@pengutronix.de>
 <Z8660bKssi3rX_ny@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8660bKssi3rX_ny@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 10, 2025 at 10:11:29AM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 10, 2025 at 10:58:38AM +0100, Oleksij Rempel wrote:
> > Hi Thangaraj,
> > 
> > On Mon, Mar 10, 2025 at 09:29:45AM +0000, Thangaraj.S@microchip.com wrote:
> > > > -       mii_adv_to_linkmode_adv_t(fc, mii_adv);
> > > > -       linkmode_or(phydev->advertising, fc, phydev->advertising);
> > > > +       phy_suspend(phydev);
> > > > 
> > > 
> > > Why phy_suspend called in the init? Is there any specific reason?
> > 
> > In my tests with EVB-LAN7801-EDS, the attached PHY stayed UP in initial
> > state.
> 
> Why is that an issue?

The local interface was in the administrative DOWN state, but link was up:
- port LEDs are on
- link partner sees the link is UP.

It is not a big deal, but for me it looks inconsistent.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

