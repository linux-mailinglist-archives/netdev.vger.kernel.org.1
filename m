Return-Path: <netdev+bounces-209878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57468B11281
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701EA583DEF
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B12ECD2B;
	Thu, 24 Jul 2025 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Duo0KgEe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8C2367B1;
	Thu, 24 Jul 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389940; cv=none; b=KOHbPazABYkKUP5XEDGVh3Evm0aATt/T7RffZ5SLuDpJ/VzHazZ58OIgYdp9DgHFAjWGqtFc9wRRnncjOfYwMLznjTTaePcwwoBLeFF9gy4vFCO8exu8VltQ1m/CNfGRyh0bXZ7LvIYeDfDmK21B0s1G+C066OSdfMOjjd4UclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389940; c=relaxed/simple;
	bh=VbkGphOljh69j4+WTfMwbutGfZxf31UieYFVXylWNMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNTziPWcPNMz2m612nvMHn7c8txaH+2Yr3TyRlRd5lSoDWualik0GaE2yLqK9AKuyIa3TFPc1JuSYN6etZ9bGEieOEJuLqsJP6HYTHnW4bXmGwnfvnl0PGdCbMONFShdkcwTeb3UrXC2p2n+AL5canZQziDUNIVVnzYoUmY5LrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Duo0KgEe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=581XQULO5HEeOypxwkhgrMOEGSJ1yPrlxA3FaAHMtiM=; b=Duo0KgEeGWiCx5G39EeM4AR6OL
	Gf8fzj5vXvy60Tasqc5NCtVLgj+tev55RYprBUEMOoi8HW+u+1Ok2M5D7Kc+0s5AEmKZpDfnH0oLn
	hoima0rDSR+CP/dQ2QFIIuzh3O8hXURLGbzK7/aG8L2sBYwS3OWiK9uizkLHGhlOCEFbBbJJsp//j
	/2QGOEmD167qvmxUvbz22vnTqh3CpZZIwugKfeuDU4k04aT5zmrcpqh/lGUVL4PxnjIbbEeXnFRXh
	kEmCYtxZkC12xgccASdwyxdeQD81vBXOlR0X/HuwBdeL0fA2Y9ME68SjeFY2XE6JjoyqyH81ig2ja
	Uc5jVrDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38430)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uf2ol-0003pn-0b;
	Thu, 24 Jul 2025 21:45:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uf2oj-00013k-2o;
	Thu, 24 Jul 2025 21:45:29 +0100
Date: Thu, 24 Jul 2025 21:45:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: micrel: Replace hardcoded
 pages with defines
Message-ID: <aIKbaS8ASndR7Xe_@shell.armlinux.org.uk>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-4-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724200826.2662658-4-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 10:08:25PM +0200, Horatiu Vultur wrote:
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index b04c471c11a4a..d20f028106b7d 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -2788,6 +2788,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
>  	return ret;
>  }
>  
> +#define LAN_EXT_PAGE_0					0
> +#define LAN_EXT_PAGE_1					1
> +#define LAN_EXT_PAGE_2					2
> +#define LAN_EXT_PAGE_4					4
> +#define LAN_EXT_PAGE_5					5
> +#define LAN_EXT_PAGE_31					31

I don't see the point of this change. This is almost as bad as:

#define ZERO 0
#define ONE 1
#define TWO 2
#define THREE 3
...
#define ONE_HUNDRED_AND_FIFTY_FIVE 155
etc

It doesn't give us any new information, and just adds extra clutter,
making the code less readable.

The point of using register definitions is to describe the purpose
of the number, giving the number a meaning, not to just hide the
number because we don't want to see such things in C code.

I'm sorry if you were asked to do this in v1, but I think if you
were asked to do it, it would've been assuming that the definitions
could be more meaningful.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

