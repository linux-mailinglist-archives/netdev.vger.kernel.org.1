Return-Path: <netdev+bounces-169173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D1A42CAD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D0B18939AB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C61FCFE2;
	Mon, 24 Feb 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FjydXtq8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35DB674
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425065; cv=none; b=STe+p31cL+Q3cwk2SpcOr1CVO+nEOewnwUvlRwyPD52IM3DlpNLB4e1Ptc8vBdtVsrHyfYE8n8kNEhQxgzYbNvYIjs/cRM+Rm6fzX853645gWmfX6zbEXBLVtSa79ReKTyssJ4ysaMaQZMld43jBWntaoR8NDG6U39TtX/lTQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425065; c=relaxed/simple;
	bh=sijCdm7BK9jNRuk83wOBPOqVRzI55feIjEF9zfy9nJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCSlb1+FUYWSCeG5rPaa1JWURuQQVNUD0Wobg3R2WWXQeqUmzGRqO3B5MsIQwgjnqFgH5qt7H3HHtsUhV6mxyx9UipUXidgahiEn2Q7lHoDpDqdKUctYs2jK8PtZ/D7LCFqn3HuyHHdwuSW1p6JZKXXqAwtXZyQeywAU9J8nTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FjydXtq8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9fNRf84FTtJjHliYcAUhh7w6jjxdbYy6571+0WzKs8U=; b=FjydXtq8/upia+NN3lmp+mKknf
	lL8PdXsnIs4kBH71ncA9vo3jC18J02I8lHXuvCw8olTvs1dr2d4xlZEy/IIfy0tKRFA1N+h4KSKqt
	j0l9RqdLq4S1GDTAvgIb8thmaEiKA5CxmSloYiJmrxmcj5ZT0PecVTcD5RwlC/Cjsyi0+kT8VKa2C
	r6YO6J2VuRfb6yCT5U3Sp08LyWlA+iNQ58K9eUQ3ekGQ2OCGPB9IrY180vVSOEjCoLvQ+1pCF2Q3b
	puAVRKj4x7rFujSibeSUCWJIRdWZZmbkAK5pIKz1O7XGjsThwahg4JjK50UDHQuyi7yWVHIpVJuJ4
	+JQg74ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50622)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tme3p-0007O7-2i;
	Mon, 24 Feb 2025 19:24:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tme3l-0005G0-14;
	Mon, 24 Feb 2025 19:24:09 +0000
Date: Mon, 24 Feb 2025 19:24:09 +0000
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
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <Z7zHWceA9SmtcXPm@shell.armlinux.org.uk>
References: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 21, 2025 at 11:38:25AM +0000, Russell King (Oracle) wrote:
> Clean up the clock initialisation by providing a helper to find a
> named clock in the bulk clocks, and provide the name of the stmmac
> clock in match data so we can locate the stmmac clock in generic
> code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> dwc_eth_find_clk() should probably become a generic helper given that
> plat_dat->clks is part of the core platform support code, but that
> can be done later when converting more drivers - which I will get
> around to once I've got the set_clk_tx_rate() patch series out that
> someone else needs to make progress.

Jakub,

This one can also be removed from patchwork.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

