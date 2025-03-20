Return-Path: <netdev+bounces-176598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B1A6AFD0
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41900189D740
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C842222B6;
	Thu, 20 Mar 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pw5ouzg1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25F21CA07;
	Thu, 20 Mar 2025 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506076; cv=none; b=QdLKQQ7tm4gDhz/24Nm+xfJVKeoNsgzHSlI6y+4+43Ss1MukuFncg3Yhkhmx4J0KCmrkkY4/AlcdHl7F18ptPiEqgdBcEmcFWb2vqvRADT0DRjwKOsf8G4WMNyoFZAAz6P3Yk1Cw/OnJIJwOGQSJwFrmac0ATGzBQLuNRQRK7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506076; c=relaxed/simple;
	bh=lfWQHBAKTui8vW+2zFtRBHl2TxZnvkNb51Zf2FPBj7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU/mxjkeO29/vanHULaU3Z0j/cS0FMqdm1IPQHhUD32RzdoOxDusjMUJmcGT5f2wYxic/cvSLy3X3aTIXS6/KkASJ+4E/bZiOnLFFf2MLc7BNgGwzNsMgR10j3q6Wybcn4l4N59uKIU7dy56rLXry5Kvn2ochHZXiALUw1dU1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pw5ouzg1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8kD/inJPuSfK/H5ln+1uA2/ichXqmAkjJZMOwDlyVqs=; b=pw5ouzg1uRODt752suRZms1d27
	VJXf7IP+ZogICEJPSpy9KSPjXa9ViiyZhveDpdw5awvbostsAYjHtInvkSF9g6JFLUYNhB5OIKCcS
	D9dOYGpT/MPXaexzhRMJiuNyNZYbuGuNZsqvbujQvFMYEqdCRZALCNd9e0s9lLkRk9Co=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvNQY-006W6r-OJ; Thu, 20 Mar 2025 22:27:46 +0100
Date: Thu, 20 Mar 2025 22:27:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 6/7] net: tn40xx: prepare tn40xx driver to
 find phy of the TN9510 card
Message-ID: <b62bd70e-691e-4b2b-a600-720d1f8ad12a@lunn.ch>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
 <20250318-tn9510-v3a-v6-6-808a9089d24b@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-tn9510-v3a-v6-6-808a9089d24b@gmx.net>

On Tue, Mar 18, 2025 at 11:06:57PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
> bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
> 3 is unclear, but may have something to do with the length of the preamble
> in the MDIO communication. If bit 3 is not set, the PHY will not be found
> when performing a scan for PHYs. Use the available tn40_mdio_set_speed
> function which includes setting bit 3. Just move the function to before the
> devm_mdio_register function, which scans the mdio bus for PHYs.

It might also have something to do with the bus speed. 802.3 says the
MDIO bus should be clocked only up to 2.5Mhz. Some MDIO devices do
work faster than that. So it could be the hardware defaults to
something very fast. By setting it to 6MHZ, you might be slowing it
down to speed which the aquantia PHY and board layout supports.

All just speculation, and does not stop getting the patch merged.

    Andrew

