Return-Path: <netdev+bounces-235393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48DC2FB89
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B113AAEE8
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C130F95F;
	Tue,  4 Nov 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wIlEtaBu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380330F941
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242646; cv=none; b=b6Gr+McDBVPOVdt3Kl9FDfDUTdzJebcVxdM7IL2YLH7I8C9eRiX7UvRRvI4AnVTY4uw3X4N7zrfB3/W7LpuO07apVm5/eZvYEdeyC2RvFwSpBNfSC5vxYzx0qrXzjQ19oGJesPcEtzO8GLw7SJ6NUGSNY/ftOpOHQGRHhTjgGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242646; c=relaxed/simple;
	bh=GU8tINezIZBwYjmXb77s/ftwY5/6Rv1NR1MiD1k6+tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2lbc5DbK7Z9fPCCy1UFSFBiQuL+eY4zc7sF63Pe1COAfhcdY4um6G0p6MjKP2B81jisevRwZq6JX2T9zK0piI8cmXMAtGKlv9RvKo/lquIjtZUCFCB7CoCQQnaa3UnjwiUrD+cW9NO33IJqK/3z+mVYgnpXJzG61YTIgnZcL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wIlEtaBu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zFX01VJY+mONJhtkTUSxkKaT0H5G139ZB0xMXIf93pU=; b=wIlEtaBuc6pk0JydqUtkiAPcMk
	HwzT8yrzhnGYhaJ77ceqr0R1uX6nmiTza8Ew6/zLqvmB9oGEK/a5xbrMUJZ6+g8Ie6ZhiPnWChxJT
	3Ay5bztyapqiwUL8TY2VBasG5z9rfn0o++CpnI9WgkcrAm9BOB5UsaULfBdapeSSuL4/5zUZ4NYRT
	Z8c/7ki/T4w/hXf598eUAbvxyE0Xg2pQmiYfUy1MfRANUr7nnvQlGrGYT5/GoX6OPzP3KrU5ORlwz
	HN8tuTD9OVq2t830RD2CIAPUHoUzcw05FHEToxxkO6gvSUAS4sYKRNgGt+aQBDVaF/DOk12yX3xcD
	kaqsOJ9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGBoE-000000001p2-3uhA;
	Tue, 04 Nov 2025 07:50:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGBoB-000000004b2-0Cf4;
	Tue, 04 Nov 2025 07:50:27 +0000
Date: Tue, 4 Nov 2025 07:50:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: imx: use phylink's interface mode
 for set_clk_tx_rate()
Message-ID: <aQmwQoxn5CwS9988@shell.armlinux.org.uk>
References: <E1vEn1W-0000000CHoi-2koP@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vEn1W-0000000CHoi-2koP@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 31, 2025 at 11:10:26AM +0000, Russell King (Oracle) wrote:
> imx_dwmac_set_clk_tx_rate() is passed the interface mode from phylink
> which will be the same as plat_dat->phy_interface. Use the passed-in
> interface mode rather than plat_dat->phy_interface.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

While checking patchwork this morning, this patch was unexpectedly
marked as superseded. It appears I accidentally posted it as part of
the multi-interface stmmac series. This should not have happened.
Please apply _this_ patch as it has Maxime's attributations on,
whereas the mistakenly reposted patch does not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

