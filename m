Return-Path: <netdev+bounces-60984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A3822146
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24A1281D8C
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6CB15AE1;
	Tue,  2 Jan 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lgbXZ01Y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CB15AEA
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iEGFthPAZARIOzXlWG62cyirav9AtTJ1XH6PFUFuRTw=; b=lgbXZ01YYfLbU533syf6Zk53N7
	rRZsEC92jsgawNuDHo2+D1oo7jrclZ87/ZTu0o7eMybLvJO5oZ3F79sbhc5YDFV+aPS95svjXbHo0
	4lThEw7yvVQoJ+4poHiaO7gO0Pp99rQmWj/+kMmA/56g3NWq0FWf542iLZZRIIUNJuONvl7RkWkvi
	Q4X1871sJTIfOmW3Nkw6uBZUvtX4oYxR9EpITzG7fF+1WbjsaJrNStoOMJ39mBCPUzNhU6g5/OACp
	QRRbEHLOWau7UNcEdC52ElGQ3WvElRBs7jgoQh6ZGXs8WRpABahQxz3NxRzt/KzUdFMv5Q+mvhUGC
	Zh5wQZeg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52632)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKjlL-0006of-20;
	Tue, 02 Jan 2024 18:45:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKjlN-0005YP-2H; Tue, 02 Jan 2024 18:45:17 +0000
Date: Tue, 2 Jan 2024 18:45:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, davthompson@nvidia.com
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Message-ID: <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
References: <20231226141903.12040-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226141903.12040-1-asmaa@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 26, 2023 at 09:19:03AM -0500, Asmaa Mnebhi wrote:
> +	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
> +	 * Occasionally it fails to complete autonegotiation. The workaround is
> +	 * to restart it.
> +	 */
> +        if (phydev->autoneg == AUTONEG_ENABLE) {
> +		while (timeout) {
> +			if (phy_aneg_done(phydev))
> +				break;
> +			mdelay(1000);
> +			timeout--;
> +		};

Extra needless ;

Also.. ouch! This means we end up holding phydev->lock for up to ten
seconds, which prevents anything else happening with phylib during
that time. Not sure I can see a good way around that though. Andrew?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

