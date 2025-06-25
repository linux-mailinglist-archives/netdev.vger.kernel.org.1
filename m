Return-Path: <netdev+bounces-201259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D54AE8A03
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA5F5A4250
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929802D1F59;
	Wed, 25 Jun 2025 16:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82E2D4B66
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869383; cv=none; b=elwENhtb5OGPuiSdMpoGqHZUs7cqUeasCiSMcS3ax8fgKLt07AgYCXtPpFAnqitlN7wuZxBLw5DbszDymZE60jwqjlXg3HozGB9qXWG0ogkoxMu0veI9Kmmvmv6ltLqB6orZm1bmbb4ZdlCKcpoIDvWhiKv+MHCZD5Xh8FuRM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869383; c=relaxed/simple;
	bh=IM/aGRaqR1Cl7SNtvAEbH/pn4cPa4k49biMzW7+bPIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8+K+UZnAqFBuSOvRPJCw2p1mEuprw+yLzeYqiul7mFv7aMPDmeu5r4G0o9hxeXdNryg4BxAyp36c9pBgULRrnenMMowMLvcBt0PGD2nm5sY0cavKq5yMfpUR2mBwjhwl1vNEbMZbH0c6TU9RoWpcw+cIYjOpui3o3cTxe3/JLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUT6T-0006D8-Kq; Wed, 25 Jun 2025 18:36:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUT6R-005JHO-37;
	Wed, 25 Jun 2025 18:36:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUT6R-00HDwT-2m;
	Wed, 25 Jun 2025 18:36:03 +0200
Date: Wed, 25 Jun 2025 18:36:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <aFwlc6Iwko8UFwa5@pengutronix.de>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
 <20250625173323.37347eb7@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625173323.37347eb7@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jun 25, 2025 at 05:33:23PM +0200, Maxime Chevallier wrote:
> Hi Oleksij,
> 
> On Wed, 25 Jun 2025 14:41:26 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Add support for the Signal Quality Index (SQI) feature on KSZ9477 family
> > switches. This feature provides a relative measure of receive signal
> > quality.
> > 
> > The KSZ9477 PHY provides four separate SQI values for a 1000BASE-T link,
> > one for each differential pair (Channel A-D). Since the current get_sqi
> > UAPI only supports returning a single value per port, this
> > implementation reads the SQI from Channel A as a representative metric.
> > This can be extended to provide per-channel readings once the UAPI is
> > enhanced for multi-channel support.
> > 
> > The hardware provides a raw 7-bit SQI value (0-127), where lower is
> > better. This raw value is converted to the standard 0-7 scale to provide
> > a usable, interoperable metric for userspace tools, abstracting away
> > hardware-specifics. The mapping to the standard 0-7 SQI scale was
> > determined empirically by injecting a 30MHz sine wave into the receive
> > pair with a signal generator. It was observed that the link becomes
> > unstable and drops when the raw SQI value reaches 8. This
> > implementation is based on these test results.
> 
> [...]
> 
> > +/**
> > + * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
> > + * @phydev: the PHY device
> > + *
> > + * This function reads and processes the raw Signal Quality Index from the
> > + * PHY. Based on empirical testing, a raw value of 8 or higher indicates a
> > + * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
> > + * mapped to the standard 0-7 SQI scale via a lookup table.
> > + *
> > + * Return: SQI value (0–7), or a negative errno on failure.
> > + */
> > +static int kszphy_get_sqi(struct phy_device *phydev)
> > +{
> > +	int sum = 0;
> > +	int i, val, raw_sqi, avg_raw_sqi;
> > +	u8 channels;
> > +
> > +	/* Determine applicable channels based on link speed */
> > +	if (phydev->speed == SPEED_1000)
> > +		/* TODO: current SQI API only supports 1 channel. */
> > +		channels = 1;
> > +	else if (phydev->speed == SPEED_100)
> > +		channels = 1;
> 
> I understand the placeholder logic waiting for some improved uAPI, but
> this triggers an unused variable warning :( I think the commit log and
> the comment below are enough to explain that this can be improved later
> on.

Grr.. sorry.. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

