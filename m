Return-Path: <netdev+bounces-147689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18E9DB359
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3469282490
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3E14A4C1;
	Thu, 28 Nov 2024 08:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16145025
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732781253; cv=none; b=Sq0jMeSYNEG83T7F3EYjjFNb9MnqwO1LFgK99A0FNYM7btL4WzcXFYwuZ//4vStGFJRF1AGDrCgZjOtWm20APf3ClpUD9Xlf56eQdWUdtNlckbxDavKIE40LggIB4stGmriKcQmhNYxdfUqt0UoduguX76+RssqoYbMKJ0+Z2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732781253; c=relaxed/simple;
	bh=a+Ni+TpDy5nfatu94WsQaBicx+A7eGS/6y94H6QwwGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocs6LLccn9CUBCuMQJ+9SPTvDfeVWZXEOWLKi4EwfH0DIZmb8tUCEDFafGyPfU/hCggrMVdk3QQDM9Ca1q8HbyzNggj77K3LkiUCueqbSUx0W7ZROSLAUfHhLA36sSM9oinxjqEcle7CCyCzP5S6roVbz8HxqXF6EHqSHQOHXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZYR-00039l-4k; Thu, 28 Nov 2024 09:07:15 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZYP-000a0n-2t;
	Thu, 28 Nov 2024 09:07:14 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZYQ-002pP3-1o;
	Thu, 28 Nov 2024 09:07:14 +0100
Date: Thu, 28 Nov 2024 09:07:14 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC net-next v1 2/2] net. phy: dp83tg720: Add randomized
 polling intervals for unstable link detection
Message-ID: <Z0gksn9nEKJOY5Ul@pengutronix.de>
References: <20241127131011.92800-1-o.rempel@pengutronix.de>
 <20241127131011.92800-2-o.rempel@pengutronix.de>
 <43cceaf2-6540-4a45-95fa-4382ab2953ef@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43cceaf2-6540-4a45-95fa-4382ab2953ef@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Andrew,

On Wed, Nov 27, 2024 at 04:37:49PM +0100, Andrew Lunn wrote:
> On Wed, Nov 27, 2024 at 02:10:11PM +0100, Oleksij Rempel wrote:
> > Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
> > report a stable link state. To handle this, the PHY must be periodically reset
> > when the link is down. However, synchronized reset intervals between the PHY
> > and its link partner can result in a deadlock, preventing the link from
> > re-establishing.
> > 
> > This change introduces a randomized polling interval when the link is down to
> > desynchronize resets between link partners.
> 
> Hi Oleksij
> 
> What other solutions did you try? I'm wondering if this is more
> complex than it needs to be. Could you add a random delay in
> dp83tg720_read_status() when it decides to do a reset?

Yes, this would be possible, but there are multiple reasons I decided to
go this way:
- in link down case, it is better to increase polling frequency, it
  allows to reduce link up time.
- there are PHYs, for example an integrated to LAN9372 which supports
  only link down interrupt. As long as link is down, it should be
  polled.
- i'm working on generic PHY stats support and PHYs need to be polled,
  even with IRQ support, just less frequently.

I can add it to the commit message.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

