Return-Path: <netdev+bounces-216867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC9B3590A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8501016DFF1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964AA2FC87E;
	Tue, 26 Aug 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pEsksbH0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCB393DCA;
	Tue, 26 Aug 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200907; cv=none; b=u/BXW6dG46np2loUgOAMG7kgPnyhIqsxDBf8O4Hz0CUAFeAIhn2aE0jj7iLQU6FO/w9nCgV7OCiu2s6Poei2FtzkWKdwZ/Jp10vxHkzEK8D01vjYA4xyMO+sBU4XoTqDqMlHQ4eY68jvKtOOkXMxytCtH7GiNYjxtsbIykdQBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200907; c=relaxed/simple;
	bh=bBbppVx3R7H1M9z+T8beISYQlnn6nidjn5JWunIl9/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afcU4bQEPuAMVBhk6+glNIr5W8EOdkcMjUDIMcyy2op/QmeWd7sPYcfY0rspEia1rFr9GF6CXo8HGBUB4tlGLrTk4bmTM7QktgmAUW30JMuc8CFshvZjRwSXqo5HdOD3ffNQYTQL47WhpVcsZl9ADKdMphX9NCBuH1+vHRu068Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pEsksbH0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0kksXY6qvH1L0tvsp2dKynLeBCUnDrycYEwOgABE3I8=; b=pEsksbH0GWNkC4oxuPMuoDz4Lv
	oEVH+1V0RqTirpkdnQphw4N23fltxzOHWvH4oMWynmB2vQLBFc/NdVgMXBvEWNMdtE/JPZT5abkxZ
	BOLuOh9/uOEFrdX762OF9dTagAm1dx327Z6TS42pJYBD7C1QpphQGmmlv7hMbNRSLY6Q00eVzJ601
	0FUNVVqOOAq2FXvGBmBh4rUv7dMLsiQ/xK9zby1Q7fHSP6Wrgck0rx2dOFJfsOc+moxoDdnFmotar
	6VqZB12dNSXOh9vBdzPrClQBiD795n/HjXDXU97wGRSVBJYYwaL5hzxmwXICYPtU12qsJt0aD1g+z
	lIVGCueQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41130)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqq4r-000000007fR-03bV;
	Tue, 26 Aug 2025 10:34:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqq4o-0000000018h-0Pc0;
	Tue, 26 Aug 2025 10:34:50 +0100
Date: Tue, 26 Aug 2025 10:34:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Chaoyi Chen <kernel@airkyi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
Message-ID: <aK1_uaBpnix4n4eS@shell.armlinux.org.uk>
References: <20250815023515.114-1-kernel@airkyi.com>
 <CGME20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93@eucas1p2.samsung.com>
 <a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
 <d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>
 <809848c9-2ffa-4743-adda-b8b714b404de@samsung.com>
 <aKxnHFSrVeM7Be5A@shell.armlinux.org.uk>
 <8240a3cc-aade-40d8-b2f4-09681f76be68@rock-chips.com>
 <aK19bSmrbXjoVXdO@shell.armlinux.org.uk>
 <ae11b993-5844-4da1-b433-c27b5a73060a@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae11b993-5844-4da1-b433-c27b5a73060a@rock-chips.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 26, 2025 at 05:29:04PM +0800, Chaoyi Chen wrote:
> On 8/26/2025 5:25 PM, Russell King (Oracle) wrote:
> 
> > On Tue, Aug 26, 2025 at 04:08:40PM +0800, Chaoyi Chen wrote:
> > > Hi Russell,
> > > 
> > > On 8/25/2025 9:37 PM, Russell King (Oracle) wrote:
> > > > On Mon, Aug 25, 2025 at 12:53:37PM +0200, Marek Szyprowski wrote:
> > > > > On 25.08.2025 11:57, Chaoyi Chen wrote:
> > > > > > On 8/25/2025 3:23 PM, Marek Szyprowski wrote:
> > > > > > > On 15.08.2025 04:35, Chaoyi Chen wrote:
> > > > > > > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > > > > 
> > > > > > > > For external phy, clk_phy should be optional, and some external phy
> > > > > > > > need the clock input from clk_phy. This patch adds support for setting
> > > > > > > > clk_phy for external phy.
> > > > > > > > 
> > > > > > > > Signed-off-by: David Wu <david.wu@rock-chips.com>
> > > > > > > > Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > Changes in v3:
> > > > > > > > - Link to V2:
> > > > > > > > https://lore.kernel.org/netdev/20250812012127.197-1-kernel@airkyi.com/
> > > > > > > > - Rebase to net-next/main
> > > > > > > > 
> > > > > > > > Changes in v2:
> > > > > > > > - Link to V1:
> > > > > > > > https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
> > > > > > > > - Remove get clock frequency from DT prop
> > > > > > > > 
> > > > > > > >      drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
> > > > > > > >      1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > > > > index ac8288301994..5d921e62c2f5 100644
> > > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > > > > @@ -1412,12 +1412,15 @@ static int rk_gmac_clk_init(struct
> > > > > > > > plat_stmmacenet_data *plat)
> > > > > > > >              clk_set_rate(plat->stmmac_clk, 50000000);
> > > > > > > >          }
> > > > > > > >      -    if (plat->phy_node && bsp_priv->integrated_phy) {
> > > > > > > > +    if (plat->phy_node) {
> > > > > > > >              bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > > > > > > >              ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > > > > > > -        if (ret)
> > > > > > > > -            return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> > > > > > > > -        clk_set_rate(bsp_priv->clk_phy, 50000000);
> > > > > > > > +        /* If it is not integrated_phy, clk_phy is optional */
> > > > > > > > +        if (bsp_priv->integrated_phy) {
> > > > > > > > +            if (ret)
> > > > > > > > +                return dev_err_probe(dev, ret, "Cannot get PHY
> > > > > > > > clock\n");
> > > > > > > > +            clk_set_rate(bsp_priv->clk_phy, 50000000);
> > > > > > > > +        }
> > > > > > I think  we should set bsp_priv->clk_phy to NULL here if we failed to
> > > > > > get the clock.
> > > > > > 
> > > > > > Could you try this on your board? Thank you.
> > > > > Right, the following change also fixes this issue:
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > index 9fc41207cc45..2d19d48be01f 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > > @@ -1415,6 +1415,8 @@ static int rk_gmac_clk_init(struct
> > > > > plat_stmmacenet_data *plat)
> > > > >            if (plat->phy_node) {
> > > > >                    bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > > > >                    ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > > > +               if (ret)
> > > > > +                       bsp_priv->clk_phy = NULL;
> > > > Or just:
> > > > 
> > > > 		clk = of_clk_get(plat->phy_node, 0);
> > > > 		if (clk == ERR_PTR(-EPROBE_DEFER))
> > > Do we actually need this? Maybe other devm_clk_get() before it would fail in advance.
> > Is it the same clock as devm_clk_get()? If it is, what's the point of
> > getting it a second time. If it isn't, then it could be a different
> > clock which may be yet to probe.
> 
> It's not the same clock, but it should be use the same clock controller driver, which is the CRU on the Rockchip platform.

Will it always be the same clock controller, including into the future
Rockchip devices?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

