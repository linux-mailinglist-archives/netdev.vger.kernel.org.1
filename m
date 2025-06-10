Return-Path: <netdev+bounces-196111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C5AD3891
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317921E045E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0D25B308;
	Tue, 10 Jun 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A7TRHe/W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE025B303;
	Tue, 10 Jun 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560561; cv=none; b=aqnKs++N1LOZgsw5IIVxuQkhZHmyw8FRMD5wwDXgQyaV39izNxvL3k2Vec4qZVrcR737COUw7q9L2q52+lP7W7+NFyHwUO21HV5csPUHpGozJ3Ql5NdgLucPRhBZoA7K20/L0ON5Z45SCE98Kt4eMc+peN2qm2YhWF0fqk1XhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560561; c=relaxed/simple;
	bh=/jatg1ZWDAzcSUBqpB64o17uf0USP4p9QCqlP8pmvHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2hg9AASKvm28SWktE39XDfi12brMjvwHZ/PxJhBQ8M5dbef+kP9aeiNkFSe0L4miwmrGBILv7wTqDIKmEey6i6O1EH9IH9/0tKuJQRXfJKtPPD7psUANX7mUgNqkGADYeX/KWa4paNo6n7MJPQen7ZzUDa/ncYGlmRdfev5xoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A7TRHe/W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwxW4h5f3CkdkNw+Db5HyK4+JuDrbGxxAbNIATvH60g=; b=A7TRHe/WbobrAi05hTAuC8C+DA
	CMnkX2g6TYDWBF64pgaKaf8uWr0LsptEoUXjpvJqdnSNxc7pj78erXJf+XqkR9uEA9A56UdAwpGSt
	J5kTaR0+xl3Fx/GqaGMsIOibN7hPJMxKGPG46TVIMZMqxeFkMfyMkcWedCTXatWTTAmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOycV-00FGmy-Dh; Tue, 10 Jun 2025 15:02:27 +0200
Date: Tue, 10 Jun 2025 15:02:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: dp83tg720: implement soft
 reset with asymmetric delay
Message-ID: <ef433d7f-ff57-4ae4-af27-a005a3080a1d@lunn.ch>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
 <20250610081059.3842459-2-o.rempel@pengutronix.de>
 <534b3aed-bef5-410e-b970-495b62534d96@lunn.ch>
 <aEgm25HcomOxE8oX@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgm25HcomOxE8oX@pengutronix.de>

> > > + *
> > > + * 1. Unreliable Link Detection and Synchronized Reset Deadlock
> > > + * ------------------------------------------------------------
> > > + * After a link loss or during link establishment, the DP83TG720 PHY may fail
> > > + * to detect or report link status correctly. To work around this, the PHY must
> > > + * be reset periodically when no link is detected.
> > > + *
> > > + * However, in point-to-point setups where both link partners use the same
> > > + * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
> > > + * This leads to a deadlock, where both PHYs reset at the same time and
> > > + * continuously miss each other during auto-negotiation.
> > > + *
> > > + * To address this, the reset procedure includes two components:
> > > + *
> > > + * - A **fixed minimum delay of 1ms** after issuing a hardware reset, as
> > > + *   required by the "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with
> > > + *   SGMII and RGMII" datasheet. This ensures MDC access timing is respected
> > > + *   before any further MDIO operations.
> > > + *
> > > + * - An **additional asymmetric delay**, empirically chosen based on
> > > + *   master/slave role. This reduces the risk of synchronized resets on both
> > > + *   link partners. Values are selected to avoid periodic overlap and ensure
> > > + *   the link is re-established within a few cycles.
> > 
> > Maybe there is more about this in the following patches, i've not read
> > them yet. Does autoneg get as far as determining master/slave role? Or
> > are you assuming the link partners are somehow set as
> > prefer_master/prefer_slave?
> 
> This PHY do not support autoneg (as required for automotive PHYs),
> master/slave roles should be assigned by strapping or from software to
> make the link functional.

O.K, please extend the documentation to include this.

If they are incorrectly configured, both have the same role, do they
fail to get a link because of that? So it does not matter they both
have the same delays, it is not going to work whatever...

    Andrew

---
pw-bot: cr

