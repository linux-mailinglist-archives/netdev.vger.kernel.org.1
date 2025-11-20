Return-Path: <netdev+bounces-240418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB713C74A23
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 63CB624552
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9633C18C;
	Thu, 20 Nov 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uPo/mO0b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAB305E27;
	Thu, 20 Nov 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649840; cv=none; b=M/WJnWy3GF5EIliSfBhG7teHmaFzIcKhwJPQ0nG1dY6AMUd+Uax4v3lUNoVndfpt9Jjy0ahWNtbrhvNazM0YlcWgBNn8yt+57JfrYhb9OJhnu0ogHNBhm+iMmkoCeG33C9DbCRjLhYsCgNw9SHG1uajEhgaQKvgrYlhmpxt9mY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649840; c=relaxed/simple;
	bh=Qv4NOVW2iJ9k/XijLn1fXaxhchgqOT9JuzrNS6gD7zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWa0IFXa2z8bvqDVxMUP1w/VcYFYG1vXLMwN8ZfRAliDKQFGXKPCo2C5sN8GPEzVnvqU3xAANbSXlnsIo4d6fbQm493KwtZBOC3Lpb8uKpMLEDfnb2r1DapeTCjJyqXl78p/+UUBFnS4iFQ8/Nwi6ae7Xrh2cz0VaWh0/D9eSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uPo/mO0b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e3mxGCDpFv/dKTonGheXJIKLyPa6ZZKgxs3o/yte++0=; b=uPo/mO0buBLZquJkmANWkUViM7
	D9Ic7oflRPaR4woOvlpQGA2QMndf1j7vzRgBOnzTOd4PX5qnPYvH4VQ+Q0HDNw8CN2k71BAw0n+HL
	aPpn+2ucXG5c2i9GSGDgUhkigZ8x9/9eQ9xVdAmff03bO8B35rbO53H70Y1kTc6qVgDv3MK/zgrae
	d0i0We2YMWjGr/9qSbvRiiShaBucaUa8WnQNzQI0bo1pNO8EUckjn5roGbkWy4aBO5HfS6WS8oXBK
	8DM2N2aXDmeiaDa70whumWSpUrgd9h7yuD1C5xD51z4tBb+UCloMCS8warT9HwWGIlpt4lWGxsE4+
	YEl7cSyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42930)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vM5sv-000000006M3-33tl;
	Thu, 20 Nov 2025 14:43:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vM5ss-000000004Sy-1dhb;
	Thu, 20 Nov 2025 14:43:42 +0000
Date: Thu, 20 Nov 2025 14:43:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mxl-gpy: fix bogus error on USXGMII and
 integrated PHY
Message-ID: <aR8pHpceYe16L9Ey@shell.armlinux.org.uk>
References: <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 20, 2025 at 02:17:13PM +0000, Daniel Golle wrote:
> As the interface mode doesn't need to be updated on PHYs connected with
> USXGMII and integrated PHYs, gpy_update_interface() should just return 0
> in these cases rather than -EINVAL which has wrongly been introduced by
> commit 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface()
> function return type"), as this breaks support for those PHYs.

I think there's more problems here. gpy_update_interface() does more
than just updating the interface, it also reads the master/slave and
mdix state at the end of the function. Returning early for interfaces
we don't means that we don't wish to update the interface for means
these don't get read. Since these are media-side and are irrespective
of the host-side interface, this seems buggy.

So, while this patch is correct, I think it would make sense to also
fix the other problems here.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

