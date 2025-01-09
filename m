Return-Path: <netdev+bounces-156859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB1DA08096
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1432316926D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD291A83FC;
	Thu,  9 Jan 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZiYQh6HH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2542F43;
	Thu,  9 Jan 2025 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451200; cv=none; b=i0jMvUwsSjZID6YFYxPSO+pyOq5FyNjQ+1aKCQ0TgKIvBAb/3b2BQUVgdiHnJkch30Y53xXmnC31hBF4l4ea+ZvbIhsDyzvuFKBUaCCzypLUxY3/lvB7Z3kO4ECfEyjxKJ67/NjX7cw3dUJcmsZb4Xmbjw/inSszDbAzVITmzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451200; c=relaxed/simple;
	bh=xDfIeuilozy0gMsIGf96mqB8aqXDLKOQxqGPQV5aL9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUUrprJY5NBWr8JnIAwz8egXEuHcX2m+lWckssNbE7FWJaP8QddA8qtlASpEjMr1BUpvTY+ebBTpOYIQjCvaj71yKnCrJWLPh9Zcv44u61XRxvuCNtFNWg/zyR1YAZYMW+anXVV/XuLbCJ4hRm0D62+ITAhBMjSrh8T+q7g5rA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZiYQh6HH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z9szmVsKB6YsdPy9yMIeVDU3Ds7AJIvmljQzpNRPhF0=; b=ZiYQh6HHgpi1GZjvd4FS/FUWmS
	ARhtdh9JLKiTbFs+oEli46k27fyfncmiTxG+2KKEPrwdLxPj9PfJHwS105WTTpq46QexCf5eEjxy9
	21lqd1qoruvpHbrDqYE0hj0/39+nEceB9sY1k1ENaQwnvwL0AK+SH483HUMCpfsMxu7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVyHD-002znH-D9; Thu, 09 Jan 2025 20:33:07 +0100
Date: Thu, 9 Jan 2025 20:33:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>

> Andrew had a large patch set, which added the phylib core code, and
> fixed up many drivers. This was taken by someone else, and only
> Andrew's core phylib code was merged along with the code for their
> driver, thus breaking a heck of a lot of other drivers.

As Russell says, i did convert all existing drivers over the new
internal API, and removed some ugly parts of the old EEE core code.
I'm not too happy we only got part way with my patches. Having this in
between state makes the internal APIs much harder to deal with, and as
Russell says, we broke a few MAC drivers because the rest did not get
merged.

Before we think about extensions to the kAPI, we first need to finish
the refactor. Get all MAC drivers over to the newer internal API and
remove phy_init_eee() which really does need to die. My patches have
probably bit rotted a bit, but i doubt they are unusable. So i would
like to see them merged. I would however leave phylink drivers to
Russell. He went a slight different way than i did, and he should get
to decide how phylink should support this.

    Andrew

