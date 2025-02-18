Return-Path: <netdev+bounces-167309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD2A39B2C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DAA3A6FE9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB923E25F;
	Tue, 18 Feb 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wvk9irEd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9323ED6A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878903; cv=none; b=MHv0+LKGxAelB+3hKkfDZpJh/prbHzU0by5B9w6EvUkiQ+7KbzjYMIgQxbkYrGnt5JaPkg+PVbFRuYcUy+/tncznoHeVsBfXEG7/w6nx8Jwrnk7bopLqtkqPho/d7mUhPqkpa1KrP72AfnL1huoMQ0AgerEmZRMKi2i5E+moQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878903; c=relaxed/simple;
	bh=+JeMf5aBl8g73fc/4axTATaYsguneyWjHXDFDThI3B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2L6k4eHWfnUvzg9E60awix1PIwoj/gm+vlHwH+VA7gH9E8yCEFbfCRTwH41sedP7dn/AiTQZiUrXmmvx0JWFSLKKHmC1nJ6TyUXEdJc3WihOPUgytTBW97afyNYgoVWFFXKOUtoTJe8cOfxsUAKDTUmTorhhAjMHFqVWjo3mSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wvk9irEd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ujQvCQNZoKNKilbwyxTloll25o1U/0BsukcebFRRwI=; b=wvk9irEdCnJm5zqVAKZmmW2efu
	pI4Sn8Kbz4KTGPa1eHSg2k5UZfEz62IQGZSIyYYo1mem2aq7wWLfY6EFrp75rZ4xuMpY2GFYzB/Od
	BWh3C0W+iFSexNDkGJPGWaWh97Xv+3T3Z6n69D9uQmN7hXK29Yq0bj3C00NplKf0UjojfsdUCSOnp
	57Y3w0Okgb+/W15fnImNuNOWDIWbs5H6eCcdVshxfR5oqvNJfjqC0hBZrB5Auorvbvdn/OCO836sn
	smKbwMrklIhGU8Wbccc8O6zxWbMM3E+mjigJJ483hexREyl/dKN/+hFx9Gkj4CxEsft4DTuwYsYDD
	UqYyJUNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkLyf-0001qH-25;
	Tue, 18 Feb 2025 11:41:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkLyZ-0007Ek-2X;
	Tue, 18 Feb 2025 11:41:19 +0000
Date: Tue, 18 Feb 2025 11:41:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 7/7] net: stmmac: imx: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <Z7Rx36FDAJk_yMQl@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZG-004RZb-8Y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tkLZG-004RZb-8Y@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 18, 2025 at 11:15:10AM +0000, Russell King (Oracle) wrote:
> Convert non-i.MX93 users to use the generic stmmac_set_clk_tx_rate() to
> configure the MAC transmit clock rate.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Looking at this again, this patch is not correct - imx does a few
checks before changing the "tx" clock.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

