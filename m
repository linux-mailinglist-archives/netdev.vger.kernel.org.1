Return-Path: <netdev+bounces-236134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BDC38C05
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF57B4E2FF3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819AF221FC6;
	Thu,  6 Nov 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JmIY1pv7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734A2144CF
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394145; cv=none; b=KbGVCQsbE/gzWebdZ8j6sEYj15N4dCkqtKjGbBoGXkmV/k/Tapstjh6vGoM9w2SaRmt3w8re3loQUX+FSifdoo6/rnjdhQfl/PGsFtkhOHLQaOVJWgbXP5YeJkqgFllRrc3FNqjCsQ1/TyrRYZmO+i+Y9H5s6u2fB1Ms8/3ls5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394145; c=relaxed/simple;
	bh=0rypb6YAyNvULRWv3clzohmKlcHOWJcOAzcMHrJfum0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eviXWhcXMaPHWBFftIyhNJK43T1f7WAiZ7vw5tmFtpN6Dy99FxZloWfG7ZPezXnj+iQMWP4RScwMp0drW64wsz/KJMF40ENLcBSMdpCxcAV9sAT0zlIyTSi/8g1sQ8ZMjn3AdPvIkFIygeEYy3b7bz6kuxwD+T9YIezRXI7WG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JmIY1pv7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4ITqPQA8fRrbxRLD4xqri1t/q83422DhMqqq3jEbapI=; b=JmIY1pv7Y602Ue9TRGVE3iKkZr
	DKbXWpfFusF2yAM32fugEYoHzHzcxqyC+23jOYx24+5PYnR197hQEHICzt3WQGW7S0WTuctCbXefr
	2RvsZtddE+47OH/HpaMwbQLva9BqWsHiTz4zqgS8sNIQaYN78oNqvhGTp3R88WOSLIufjCtmtTjm6
	ob+etum/3S4QYnsXf3Hx4h8NBTtUpnl6xU3iZd1V9JwHxVyP1SZMbRdUU8dlHz91NFQCxvNvQfV3g
	NTpSwbRgkE4QJVhb5lEYenP0gQzClSIkI3R802GYHb90y8UX/AQomKuxlxi8q8Jj0rxISdK/MYwNc
	efmGaPyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49948)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGpDq-000000004A9-1LiQ;
	Thu, 06 Nov 2025 01:55:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGpDn-000000006Ch-1KZs;
	Thu, 06 Nov 2025 01:55:31 +0000
Date: Thu, 6 Nov 2025 01:55:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 09/11] net: stmmac: ingenic: simplify x2000
 mac_set_mode()
Message-ID: <aQwAExA7bAgwNkdI@shell.armlinux.org.uk>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
 <E1vGdXJ-0000000CloA-3yVc@rmk-PC.armlinux.org.uk>
 <20251105171848.550f625a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105171848.550f625a@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 05, 2025 at 05:18:48PM -0800, Jakub Kicinski wrote:
> On Wed, 05 Nov 2025 13:26:53 +0000 Russell King (Oracle) wrote:
> > As per the previous commit, we have validated that the phy_intf_sel
> > value is one that is permissible for this SoC, so there is no need to
> > handle invalid PHY interface modes. We can also apply the other
> > configuration based upon the phy_intf_sel value rather than the
> > PHY interface mode.
> 
> clang sayeth:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:128:13: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>   128 |         } else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Clang can't know that phy_intf_sel will only ever be one of
PHY_INTF_SEL_RMII or PHY_INTF_SEL_RGMII here (its already been
validated as such by the only caller of this function.)

I guess the way around this warning is to move:

        val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);

up and make it a simple assignment, and make the others |=.

That's the code I originally had before I attempted to minimise the
noise in the patches. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

