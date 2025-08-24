Return-Path: <netdev+bounces-216271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA79FB32E1F
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C216657D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4350253F00;
	Sun, 24 Aug 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HeOyQU6W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418020322
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756023093; cv=none; b=PJvYEdmvHUPtstVJBl3w0TkHyLklBbGxMkMyQVc00Ay8x7GwMLqRZVzOszT453kyeCasRpeu16fTgq13Z9G/sOWtLC2UWF/+rUzrkFtc5e5KX0moM6MLCrYw2dZtwVCchcil+MeuPkLChNf087IrzK7agZrrZLPt6ccubGEjrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756023093; c=relaxed/simple;
	bh=dI2dmhFKBKSuu8SXsd8RSLgN1C5YLcijf8g7MQMLNAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crW+GBPCJxcqUd9pjGAbEGMQ5UzNM/rfHMYhOAZ4iFLuCT3Xu9x0z54Q6SdZR1n0MBin4ZHN2g7s4a1E/+Ad7wDl4msRi/MggPZRiXCq2lReHu8NsUz1lFp9aZpZ+ysUQM2a/4wlrApJUegZFDw1ouW2NUxqD/zKamKt13MN1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HeOyQU6W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F4cC3XUzyc3rsSFpq4Koplh7g/xLt2cfDRwi6s4wdy8=; b=HeOyQU6WBkuYeeK6lMlcg2yftE
	f36uqNMh/TSPRgDZKZwDe6RPEpVzg+YWXo2WzK/jxXEDqu11z3oE4N5eQ+FYhcxw1FJUWsZcZQF0J
	NxHkbMxsyHqGYMG/E6a+Cr2ANORdIuv2hVaecpVleptLqmXqqMmmbizss/wSgElBcPpn2cGd0hvSz
	MP4jpN1Yt+RXlfyyw1juSlNCZfAGuNHImb7zFxj4+Y2F5dMgWiq3fdMnxQblsbB2UZeUhUzawbYRF
	7sVUfI1qNPMz2rIcig4toKOKY8hBtnxFmCKOPomzKZ+BoEezbxv6fHUAkJl50afYJvGrnrxH62D0g
	5Krsraow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36376)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uq5ow-000000005N3-3KcA;
	Sun, 24 Aug 2025 09:11:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uq5ou-000000006oI-04KJ;
	Sun, 24 Aug 2025 09:11:20 +0100
Date: Sun, 24 Aug 2025 09:11:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: let fixed_phy_unregister
 free the phy_device
Message-ID: <aKrJJ7xDYSjfd7nz@shell.armlinux.org.uk>
References: <ad8dda9a-10ed-4060-916b-3f13bdbb899d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8dda9a-10ed-4060-916b-3f13bdbb899d@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Aug 23, 2025 at 11:25:05PM +0200, Heiner Kallweit wrote:
> fixed_phy_register() creates and registers the phy_device. To be
> symmetric, we should not only unregister, but also free the phy_device
> in fixed_phy_unregister(). This allows to simplify code in users.
> 
> Note wrt of_phy_deregister_fixed_link():
> put_device(&phydev->mdio.dev) and phy_device_free(phydev) are identical.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

