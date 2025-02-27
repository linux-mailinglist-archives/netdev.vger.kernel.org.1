Return-Path: <netdev+bounces-170320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5AA4822E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31593A769E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DB25E828;
	Thu, 27 Feb 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZH5nw2Hm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFB25E834
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668187; cv=none; b=TLVJUlIemHrAiENEZUHAfk8k+6x4cQXMHn7F1JXH6hd1LkFLoiE5/CUmVrcaMVxmH8yJlgHt797kMU4Os4T751jEfrtpnN06b5q11+8VJCBQ1t2+X5K9jgCdB3VclexqenD1XkCr3vaGw9mJ8rE9dTemLvKza6T6K1xD8QeboEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668187; c=relaxed/simple;
	bh=K5nG0KeFbFew0xl//ZEBCHt+dzwaJNKp2itJxE+tTOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1IQBXHAHNZMq741/7Auy9AeeYEc6ot8Akizjz0sFsKcc66kL4nl7EFt944SJ11R26gXdYO+kcbI2SVx2zafgZ5liLsf6IgdOTq00QSKhY8e5ZFZ6zTPxc7KEQwlxCurXcl0lhyqw1OTm5mWDUOX61KX8lONdPyZhBGef5w+A3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZH5nw2Hm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JZ0rC//sE06hPYVngKetF+Xs1DKrHPyHj2XylN4/E1I=; b=ZH5nw2HmODeAQoGF5DwatfyRge
	+AUj4ZofsP5hrrQshUdx0NTfcOTcd0tqxPCrtp8XyTAidSTzSozayjo2LiC0BN9fB8BWk8CY8ZHKs
	11tHep8i8RET06cu+C1Bi7sMZ4F9/O2toXvO+0tdoGMg8QPJYBQOe1FYgQW3zvab1IPI363kK57TP
	kPC3nL/5VU1GGO8Ur+zAH0nT0pp3kB16gwYYMR2YEUHWeZalIO3BovKycBe+bkMg3XKVwynxoSw1v
	E+IAuGrytIT/0lY/KRfWfujqysevSnma6znK3JlmuO0u3z0kPf/CWLKPTpBHhN6DWuHYCmnEWKPJJ
	J6IIAaYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnfJ8-0007Un-1W;
	Thu, 27 Feb 2025 14:56:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnfJ5-0008Dz-0M;
	Thu, 27 Feb 2025 14:56:11 +0000
Date: Thu, 27 Feb 2025 14:56:10 +0000
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
Message-ID: <Z8B9Cie3nFVY7mMS@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
 <2198e689-ed38-4842-9964-dca42468088a@linaro.org>
 <Z8B4OSbY954Zy37S@shell.armlinux.org.uk>
 <f21edb2c-e49d-4448-a25d-fb75f44c902a@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21edb2c-e49d-4448-a25d-fb75f44c902a@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:38:53PM +0100, Neil Armstrong wrote:
> On 27/02/2025 15:35, Russell King (Oracle) wrote:
> > On Thu, Feb 27, 2025 at 03:18:22PM +0100, Neil Armstrong wrote:
> > > Hi,
> > > 
> > > On 27/02/2025 10:17, Russell King (Oracle) wrote:
> > > > Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> > > > manage the transmit clock.
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > >    drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 9 ++++++---
> > > >    1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > > > index b115b7873cef..07c504d07604 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> > > > @@ -22,9 +22,10 @@ struct meson_dwmac {
> > > >    	void __iomem	*reg;
> > > >    };
> > > > -static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
> > > > +static int meson6_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> > > > +					phy_interface_t interface, int speed)
> > > 
> > > You can keep priv as first argument name and remove the next changes
> > 
> > I *can* but I don't want to. Inside the bulk of the stmmac driver,
> > "priv" is used with struct stmmac_priv. "plat_dat" is used with
> > struct plat_stmmacenet_data.
> 
> Right, it's still an unrelated change in this case.

This is a new method, even though it happens to have mostly the same
body. All instances of this new method use "bsp_priv" for this argument,
therefore it is consistent.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

