Return-Path: <netdev+bounces-60931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB349821E92
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3811F21963
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6F134DD;
	Tue,  2 Jan 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RhqWzeST"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E414007
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kpgEbbnV64L4OrY798Otsio5dBe8NpkV0AHt8BZku6w=; b=RhqWzeSTp5NjyKXNpJfs7QGsN2
	2SY7XMa3TZr4pmF8n3W3rqZRIrExFmJ1vUwkRMFPodjKMLmwHijqy/2zDi4/l0u0GhMjp+qnDPnB4
	ZbHe/cJmjleAiYQFcgsRgfu/NlLH5l5VXICDXa4bicH0oe3fRWHj5ZEllMDApP8Mx6a0/KE564tP0
	dZEZpWR4u1dRSePcUARe/WZ1bkqzONn9LAs6QQKSosgiuiFyCeKdHng7qI+O22hfaAJzf+Cz9Od9g
	iO3Bm2Sjot0f/8JlDEeExZ2rcOp0OdG+hsWQ/xE05eKp2Lh759rVoljWl1oRCnMUh+5BfuXVev4Xw
	XaiPAlyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40392)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKgWn-0006fD-1a;
	Tue, 02 Jan 2024 15:18:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKgWq-0005PQ-0j; Tue, 02 Jan 2024 15:18:04 +0000
Date: Tue, 2 Jan 2024 15:18:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] net: mdio_bus: make check in
 mdiobus_prevent_c45_scan more granular
Message-ID: <ZZQpK9Uw72qhxA6l@shell.armlinux.org.uk>
References: <c379276f-2276-4c15-b483-7379b16031f7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c379276f-2276-4c15-b483-7379b16031f7@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 03:38:05PM +0100, Heiner Kallweit wrote:
> Matching on OUI level is a quite big hammer. So let's make matching
> more granular.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> This is what I'm thinking of. Maybe the problem of misbehaving
> on c45 access affects certain groups of PHY's only.
> Then we don't have to blacklist all PHY's from this vendor.
> What do you think?
> ---
>  drivers/net/phy/mdio_bus.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 6cf73c156..848d5d2d6 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -621,19 +621,27 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
>   */
>  static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
>  {
> -	int i;
> +	const struct {
> +		u32 phy_id;
> +		u32 phy_id_mask;
> +	} id_list[] = {
> +		{ MICREL_OUI << 10, GENMASK(31, 10) },
> +	};

Do we need a new structure? Would struct mdio_device_id do (which
actually has exactly the same members with exactly the same names in
exactly the same order.)

Also, as this is not static, the compiler will need to generate code
to initialise the structure, possibly storing a copy of it in the
.data segment and memcpy()ing it onto the kernel stack. I suggest
marking it static to avoid that unnecessary hidden code complexity.

> +		for (j = 0; j < ARRAY_SIZE(id_list); j++) {
> +			u32 mask = id_list[j].phy_id_mask;
> +
> +			if ((phydev->phy_id & mask) == (id_list[j].phy_id & mask))

			if (phy_id_compare(phydev->phy_id, id_list[j].phy_id,
					   id_list[j].phy_id_mask))

Or it could be:

			const struct mdio_device_id *id = id_list + j;

			if (phy_id_compare(phydev->phy_id, id->phy_id,
					   id->phy_id_mask))

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

