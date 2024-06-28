Return-Path: <netdev+bounces-107641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFE91BCB0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C6B20FE8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781B15351C;
	Fri, 28 Jun 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MDIu1v3S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD31103
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570816; cv=none; b=Y0o5uQJe8HjsTCuGhQmr2ego1PxdvWDUhvrgp/6qm6BHj2eq/iyt46erafCfE88nOTL8VYI3R/56ToBYPLjWFFre+9WBuKBW2O+NV7hA20MI2rbqytXWztH0R/SS0Jqq9tzRaCJdt7Ehhznnecz4WR4Yf8VelhYKccqw2bHFc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570816; c=relaxed/simple;
	bh=Hp3YcWlRZTflFhqmQetv3mHKStLi5TRDROYNoEG+L4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkHhtRqFM7eNrHBl+2zjgat2bUnjeUPq6vXjSpNS6G+kdBIue0NeFEpVD2rUMTbp0gBK8Zl/gYMJCZD1/pbnUk2bBEqYTinyRpw7lvTPa/gtfhT8s80/ri0l2VQI/iwSDBN5qDYMGz2KhZ0zrzHLJ1N9Owe6Ur/fPBQGNDHzhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MDIu1v3S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZLTiaXFh5+l2jBDrHncJ3gZ4zuebp2+gRne9WpgDdPQ=; b=MDIu1v3SNsQWoDZU8ddo1W2Ohs
	xiJ0NrUe7WtcpDXYcRq60p4T4nzxhMebUzR2DTwu7MGnujMpJH4fcJYNgilKJq4vK7UTMsfTFeegh
	78BbKqd1iZqsc16+XsYOO845gsg2NH7zS0XgNxtXjS+06Oq/j/HDytdNF2xIIp/PluUInw9+6fKog
	2YV0yvHt5OHOKdiKmK4pqMMG6RixDwJiUKHmXHBzKIqIODjxYXOpKQ5oeUYvGmebmtALfgz1r2wVG
	FRsOk3rvgcS5cOeJSBpNC7oleMKidELuXr4ziRDvTL5tAvaKqFSTMkPdkoTAAplA3UWStwgBhlZR+
	F134Gj9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37180)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sN8uy-0006Ml-1I;
	Fri, 28 Jun 2024 11:33:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sN8v0-0006RM-Jr; Fri, 28 Jun 2024 11:33:26 +0100
Date: Fri, 28 Jun 2024 11:33:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix potential use of NULL pointer in
 phy_suspend()
Message-ID: <Zn6Rdnq9bW2WP5Sh@shell.armlinux.org.uk>
References: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 11:32:11AM +0100, Russell King (Oracle) wrote:
> phy_suspend() checks the WoL status, and then dereferences
> phydrv->flags if (and only if) we decided that WoL has been enabled
> on either the PHY or the netdev.
> 
> We then check whether phydrv was NULL, but we've potentially already
> dereferenced the pointer.
> 
> If phydrv is NULL, then phy_ethtool_get_wol() will return an error
> and leave wol.wolopts set to zero. However, if netdev->wol_enabled
> is true, then we would dereference a NULL pointer.
> 
> Checking the PHY drivers, the only place that phydev->wol_enabled is
> checked by them is in their suspend/resume callbacks and nowhere else
> (which is correct, because phylib only updates this in phy_suspend()).
> 
> So, move the NULL pointer check earlier to avoid a NULL pointer
> dereference. Leave the check for phydrv->suspend in place as a driver
> may populate the .resume method but not the .suspend method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Note - I don't believe anyone has hit this condition, so maybe we want
the patch for net-next rather than net? For now I have the patch
against both trees so let me know which you'd prefer.

>  drivers/net/phy/phy_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6c6ec9475709..19f8ae113dd3 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1980,7 +1980,7 @@ int phy_suspend(struct phy_device *phydev)
>  	const struct phy_driver *phydrv = phydev->drv;
>  	int ret;
>  
> -	if (phydev->suspended)
> +	if (phydev->suspended || !phydrv)
>  		return 0;
>  
>  	phy_ethtool_get_wol(phydev, &wol);
> @@ -1989,7 +1989,7 @@ int phy_suspend(struct phy_device *phydev)
>  	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
>  		return -EBUSY;
>  
> -	if (!phydrv || !phydrv->suspend)
> +	if (!phydrv->suspend)
>  		return 0;
>  
>  	ret = phydrv->suspend(phydev);
> -- 
> 2.30.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

