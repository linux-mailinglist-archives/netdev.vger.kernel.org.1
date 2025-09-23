Return-Path: <netdev+bounces-225586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B2B95ABD
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662BB19C2DC2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6D302748;
	Tue, 23 Sep 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V2Xf7M/4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BA2566DD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627095; cv=none; b=p0SE3rBpIRgb13hEXo3q9U/EyY9h7YSJeHQmdR887Tr7SZUI0xrvcCYjwrdy1JJ1jekLWKKDGfcuob3h2HrkyfBWPJEOqw4nQyWyti2HYm6qw2og/FgSl3CXlXuoxcr/aJuKTrsB8P+v5sxpaBzjSqlSR5T8+0d9s3C4MjoRUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627095; c=relaxed/simple;
	bh=RMOWqrl/Ki35ImGxMv03acL/JyY7dv7EcjF/8Ea40O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXgZmjlG8bbvDfZ30eOsOen86YNx4nXZmoJIGZUvzQxDnVaul1Qqafq3hOJReBXCYQDD0p3nvFUtGR+FERod9NIGSldb/Kk80h7+3tYOKXlt+mDX6jW/Ac+DOAntiysPAOTTaORWpfKA5ysCC4vnYTnxJTzpjxDdiWVptIZPmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V2Xf7M/4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FqqitcQCkxhV32rTsJ+uCNxHvhC6YeG2qjPkLgt2EmY=; b=V2Xf7M/44Zue2oMyR0jrB+6qMg
	7ZAh961BrfLS0ajhseeoLhfyHCGNfHPNryrtiAnligon5imjUELBnAYYeYvGEq8HyMCjvXGG18NeR
	xX45bLWzxrnwcB0j2Yuoglb08+J7TKgm0LM9hQOtYHtqGNt/4LLi/I5MvXUR0NQgnNiUhEG5hUbCb
	JDYoTT3RoUIm3MA855yGNesZCF5JUQgQT8BS9MXHIxnoViLqZaISaVBU/hb0hizZXSiz2+qH5qEXO
	pgg/MesL/bYJCJJnAnbqqg0IgZRGp7D8trqHGNCTboXfcIhzp4fb1h7R3YigLmTnbHn8DxIhHllQS
	q3C2v+Fg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v11F2-000000007BP-0BY1;
	Tue, 23 Sep 2025 12:31:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v11Ez-0000000066T-3bkC;
	Tue, 23 Sep 2025 12:31:25 +0100
Date: Tue, 23 Sep 2025 12:31:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/6] net: stmmac: yet more cleanups
Message-ID: <aNKFDW_aaSZl2NFE@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 23, 2025 at 12:25:30PM +0100, Russell King (Oracle) wrote:
> Building on the previous cleanup series, this cleans up yet more stmmac
> code.
> 
> - Move stmmac_bus_clks_config() into stmmac_platform() which is where
>   its onlny user is.
> 
> - Move the xpcs Clause 73 test into stmmac_init_phy(), resulting in
>   simpler code in __stmmac_open().
> 
> - Move "can't attach PHY" error message into stmmac_init_phy().
> 
> We then start moving stuff out of __stmac_open() into stmmac_open()
> (and correspondingly __stmmac_release() into stmmac_release()) which
> is not necessary when re-initialising the interface on e.g. MTU change.
> 
> - Move initialisation of tx_lpi_timer
> - Move PHY attachment/detachment
> - Move PHY error message into stmmac_init_phy()
> 
> Finally, simplfy the paths in stmmac_init_phy().
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 111 ++++++++-------------
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  32 ++++++
>  3 files changed, 73 insertions(+), 71 deletions(-)

Should've added: tested on nVidia Jetson Xavier NX.

However, observed a failure changing the MTU with the link down - our
old friend, failure to complete the DMA reset.

Once that's been triggered, taking the interface down or changing the
MTU again results in more problems, with the thread spinning in
napi_disable_locked() with RTNL held (as we effectively end up calling
napi_disable() twice on the same napi struct.)

This basically makes the platforms networking unusable - and needs to
be hard-reset.

These issues pre-exist all my cleanups.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

