Return-Path: <netdev+bounces-117505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC294E238
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609D41F2136C
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702A14F9DD;
	Sun, 11 Aug 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B5NVfOT7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956C1494AF
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392840; cv=none; b=pv3xLOQ8+51XBNapO90/9O0LRtVtRR+Jl7GvCyDbICsRp3PFD8ueqBDu0yYUNImF0wE2Sgm1PThioqdrOJ8WxtMWhKws4bJHEyO9TelJyPTL6rGpwh7viUjU/nr7raGylbbXdGUNjGYrHmtZl04JLjxwYJwqMulbWQ/adU+zhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392840; c=relaxed/simple;
	bh=AkyVHTbcrU5bI6gtBD/MD3p4SjVEkuzcw9umO54GrcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6yCS/ZD1+HekP13OafSG6PEUkQOrFyS6HKlVKrRIu4lyKf/hsQiycyBSkleXRI884ZB0fS6m1Bxf0xEgySPuQVDMqBZPOdfkYZaQXnH7Gy1Gue3DKengGAIOGV7pEg0pBZ+M2J7rfB4/MhZwD7F0edYloQk0ze/llsScP8e5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B5NVfOT7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JcIaPzAoUWoiWjk9sXSznBOEK529EY8v2GXQL+vcOsw=; b=B5NVfOT7TdnAGQAO7qQRqRJBzl
	qtCfvYuB4pCTXol9z2gezHGPyr7yxJA8PYCYVqs4KvswqQUMtjheyP/76fmEGN6WtNb8gAXUzG14l
	QRTqIFP29NqmobGrT5XlXFWEmyPKDW1UwiDAzKHnBCgqRhduZUaDjGOTPzxoWkVfYZ5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdBCa-004Vd1-Ge; Sun, 11 Aug 2024 18:13:52 +0200
Date: Sun, 11 Aug 2024 18:13:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: phylib: do not disable autoneg for
 fixed speeds >= 1G
Message-ID: <e8b4ae1d-de5b-4f6e-a94c-0e0e3a4bd643@lunn.ch>
References: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
 <E1sc1WE-002Fuk-6Z@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sc1WE-002Fuk-6Z@rmk-PC.armlinux.org.uk>

On Thu, Aug 08, 2024 at 12:41:22PM +0100, Russell King (Oracle) wrote:
> We have an increasing number of drivers that are forcing
> auto-negotiation to be enabled for speeds of 1G or faster.
> 
> It would appear that auto-negotiation is mandatory for speeds above
> 100M. In 802.3, Annex 40C's state diagrams seems to imply that
> mr_autoneg_enable (BMCR AN ENABLE) doesn't affect whether or not the
> AN state machines work for 1000base-T, and some PHY datasheets (e.g.
> Marvell Alaska) state that disabling mr_autoneg_enable leaves AN
> enabled but forced to 1G full duplex.
> 
> Other PHY datasheets imply that BMCR AN ENABLE should not be cleared
> for >= 1G.
> 
> Thus, this should be handled in phylib rather than in each driver.
> 
> Rather than erroring out, arrange to implement the Marvell Alaska
> solution but in software for all PHYs: generate an appropriate
> single-speed advertisement for the requested speed, and keep AN
> enabled to the PHY driver. However, to avoid userspace API breakage,
> continue to report to userspace that we have AN disabled.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

