Return-Path: <netdev+bounces-179855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7751BA7EC1A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB22F18837E3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31C2236EE;
	Mon,  7 Apr 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CRVTW/L3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A00254B12
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051158; cv=none; b=q/kd8RDv7lZVbRe5L/tQv9Z4nAN5dv/nUEdM82qac63xS8p/Blf+0uV3vCbWgIH2TCSw88+SIFsc4yxyq0BereMP9RWKTsnnXB1dfmsxU+jnRNiXGw+aCz+87VOBN6OLIbN6K34YMpqlBA4ZwaaCHGMIrVmQI0vIQxhgMrGVl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051158; c=relaxed/simple;
	bh=YqwJXc6KXmbwxGHGqn0Zics4TpVszC/8XpjyCUy+bos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GES2Euk+Qj6gKDBqZ5Zl5YoUnZJnC7SK1r1+kxZZST/8MFgsny8LKm5FzgW9rUqYER49SoEUU17o6JAe9Qf3fxNRl630DSIBmhXEq9aHPH8DP73x+T7KBakaaDEosLhhwTnBa63oV2fRwQ69cw3dsnXo95NfuJy45OwhWFZ+YJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CRVTW/L3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vgmARS6iCi48GW/CgYcjmbFCRe8AS0AVo3at8RS+ydA=; b=CRVTW/L3XtBMiF8Z11Y9L+CIR6
	R1XFP5YVqcC3nQEgKZltrDV13hDyZQGSCRFh2Gf+AmwoQhRKDw7qwle1EmrzJ0eBMtaoUUVQZGp06
	GefWRU6uKmxH+hzPLypFvZsvuKc9wyy8QpFJPHek1Cc0fNFmc2jOLT8UMkvWaFpeqyzMennAav137
	KdqlJgNtBXAqGuWiS8wHQgIQy2SZnFc2nIlG/DphOOqFdY1NVI/stOXXHhiKR4pZ0ZX9MHRL0lZNT
	9AQP51iQHm19NNIJxeL2d5eZrXXWkiFqyupZgmjLc1hRp8CSDUXBb7Cm2dTUhvgG2qv93qiqXEqyF
	F29JhbTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58606)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u1rN9-0005rO-1A;
	Mon, 07 Apr 2025 19:39:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u1rN5-0000cC-1Y;
	Mon, 07 Apr 2025 19:38:59 +0100
Date: Mon, 7 Apr 2025 19:38:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 0/2] net: stmmac: stmmac_pltfr_find_clk()
Message-ID: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

The GBETH glue driver that is being proposed duplicates the clock
finding from the bulk clock data in the stmmac platform data structure.
iLet's provide a generic implementation that glue drivers can use, and
convert dwc-qos-eth to use it.

 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 14 ++------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h   |  3 +++
 3 files changed, 16 insertions(+), 12 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

