Return-Path: <netdev+bounces-170304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5004A481B4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1417A5383
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A922F166;
	Thu, 27 Feb 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EUBjmHVy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE9231A22
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666956; cv=none; b=FiWnq+/QHs25ELiABRzVVl/3QsGTbNm5VlDeiuvf+y58L3OmOyL+P7P/UOU/7u1iPhWOsMu+ZwoJt6yJwqGUII4658l3SoRYrFIEz0ArGolJD3guRLEuWKkFA7N/aIbvYXpIqvgzxGLPrltFACgkWVtWgg1fi1HHQNui68oG+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666956; c=relaxed/simple;
	bh=VQ+yd9H+5oC+qgMVwVsaxA2tegcINTRJo7qCovio5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHGrrvMxtfJt9CO62/oLFFlc4/SxzQIbEEDQTSLQEHAKBQI7+jVgtab/xJ5HCxKd7/5H/pRZOFql3XY4gSXpA/C/a/6H+d6sW9sVTZ3SDUGAQU69fphHctDutRnEqvMSlaIy7606Ij0LuVO11co9d/5zVlXu+09AWoe4GBDMuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EUBjmHVy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o9wElEWBovJvOOf1DvUI+RjsvvE8ShscrWbjfNUv3Nk=; b=EUBjmHVycWo358s88/CMaHaIer
	03vE5WlQfhXVEt9GP/CTjr8AI/Mx0NieqpqmHndaK8PVimd4ABy/Msw8Wj+xZ5GIeb00TWp5CPG0T
	E0Eku+bOI/E7I+Ksbxi25HhMETqDi7FPNuxYfol6DySV97otcVlQ1Oc/XMxWi5EKGbgBAbMHh3sJ6
	pg4+VHeZQO0++SQqOLVeKKKeBYPz5xRgbw3p9AJVcBEZ5fw5eKs6CoUA1m8sMcsxh90MrFTRxaPp6
	9TGnDSYrxp9APRvo8mI2RLY9yGBawG0FbVfVKXvzeF9YQrp7H28U+hPX2zWI2lkjrTXI/trTHnnXl
	BR+XUHsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnezF-0007PU-0U;
	Thu, 27 Feb 2025 14:35:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnezB-0008CU-1N;
	Thu, 27 Feb 2025 14:35:37 +0000
Date: Thu, 27 Feb 2025 14:35:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 10/11] net: stmmac: meson: switch to use
 set_clk_tx_rate() hook
Message-ID: <Z8B4OSbY954Zy37S@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
 <2198e689-ed38-4842-9964-dca42468088a@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2198e689-ed38-4842-9964-dca42468088a@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:18:22PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 27/02/2025 10:17, Russell King (Oracle) wrote:
> > Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> > manage the transmit clock.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > index b115b7873cef..07c504d07604 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > @@ -22,9 +22,10 @@ struct meson_dwmac {
> >   	void __iomem	*reg;
> >   };
> > -static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
> > +static int meson6_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> > +					phy_interface_t interface, int speed)
> 
> You can keep priv as first argument name and remove the next changes

I *can* but I don't want to. Inside the bulk of the stmmac driver,
"priv" is used with struct stmmac_priv. "plat_dat" is used with
struct plat_stmmacenet_data.

Having different parts of the driver use the same local variable
name for different structures is confusing, and has already lead to
errors. Consistency is key. This is called "bsp_priv" in
struct plat_stmmacenet_data, and therefore it should be referred to
as "bsp_priv".

I am not yet going to be doing a big rename, but it *will* come in
time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

