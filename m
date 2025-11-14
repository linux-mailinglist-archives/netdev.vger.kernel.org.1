Return-Path: <netdev+bounces-238711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F54C5E196
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162B03AD28D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3633556C;
	Fri, 14 Nov 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KRmLISRO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11748335544;
	Fri, 14 Nov 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134963; cv=none; b=QWRdlaK0i2Pz/y0l72D0EYwk9v/TEztuBCfQcrW+/qXQvus4Iaj0v60C58TFj8ZO3WfLcRrfZfZ+B0siGnrGn6T57Vv6HlKXOF6K7VINjIQdJIbxqJSESx9TmCBPsVta8Y1+bEhJg7Ep/DVyRjBOhbHnJJof710Cr5PWPnzq6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134963; c=relaxed/simple;
	bh=76dQDYrxFlZYTWgBOCAcsW5pKpLVkooxKOviGeLe+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkUuOOvvBnEtPl9Uyazze1O9/vBStAaHSaSyERN1MSL5htbPJby/7z6sGn1ncs0dlUfFEmyvIDsQ4l39WT79xf5IVYglpd8DOvbSn62s6SJuPv4e3XoBiS40DbPwojX7Zh+JmNBWK+sAA42uX9FVxg+4S17tU9Nj4V9MBDMSceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KRmLISRO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eC6OGBRTA7nrYJUx7cUDBT/GbqIp+1YhpGa3vb0UIMs=; b=KRmLISROn8hRZcvjcjKpulIlrW
	Xo5h9tKze6hdE6/Rh3wvUuSvIqBGlEx46xK4LQm+9hd0xWdhfe5ys1T3mnbrKyRVEd2gf6RoehCgW
	qUyH5vK2eA4HEFxtUEKkMA8J8aLRpPa5tOYSt8ReHZzJu4ZTqEEe1oVqVIXGK7SEGRZ8xGF0Uz1+T
	YbLwskNkclJZx0INHuLJg4Dp3g+7Z5MsvqHtyXofUrWWuyGPLwAPDnikP7FlPD9+SYp/Bkq3HBhtt
	SQJPUv+Wch4bosb3K8aF2EOamMjjuJuYqU0SNu5YSN1DmsE4pasBhdsad2/JdogGbhU1OzAI5D6ew
	zUwxknNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJvwc-000000007BU-2XjE;
	Fri, 14 Nov 2025 15:42:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJvwb-000000005xb-0ex6;
	Fri, 14 Nov 2025 15:42:37 +0000
Date: Fri, 14 Nov 2025 15:42:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: fix doc for rgii_clock()
Message-ID: <aRdN7B64g8VJVDlj@shell.armlinux.org.uk>
References: <20251114-rgmii_clock-v1-1-e5c12d6cafa6@gocontroll.com>
 <aRclKDeHzfJSzpQ3@shell.armlinux.org.uk>
 <7ecd1c96-a039-4b4a-887e-10f01d5fbc68@gocontroll.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecd1c96-a039-4b4a-887e-10f01d5fbc68@gocontroll.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 14, 2025 at 03:10:23PM +0100, Maud Spierings wrote:
> Hi Russel,
> 
> Thanks for the response!
> 
> On 11/14/25 13:48, Russell King (Oracle) wrote:
> > On Fri, Nov 14, 2025 at 12:39:32PM +0100, Maud Spierings via B4 Relay wrote:
> > > From: Maud Spierings <maudspierings@gocontroll.com>
> > > 
> > > The doc states that the clock values also apply to the rmii mode,
> > > "as the clock rates are identical". But as far as I can find the
> > > clock rate for rmii is 50M at both 10 and 100 mbits/s [1].
> > 
> > RGMII uses 2.5MHz, 25MHz and 125MHz (ddr) for its RXC and TXC.
> > 
> > RMII uses 50MHz for the reference clock. The stmmac RMII block requires
> > a 50MHz clock for clk_rmii_i. However, the transmit (clk_tx_i) and
> > receive (clk_rx_i) clocks are required to be /2 or /20 depending on the
> > speed, making the 2.5MHz or 25MHz, as these clocks control data paths
> > that have four lanes whereas the external RMII interface is two lanes.
> > 
> > MII uses a 4 lanes, has TX_CLK and RX_CLK which are required to be
> > 2.5MHz for 10M and 25MHz for 100M.
> > 
> > So yes, for RMII the comment is a little misleading. Maybe it should
> > state that it can be used for 4-lane data paths for 10M, 100M and 1G.
> > 
> > > Link: https://en.wikipedia.org/wiki/Media-independent_interface [1]
> > > 
> > > Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> > > ---
> > > This patch is also part question, I am working on an imx8mp based device
> > > with the dwmac-imx driver. In imx_dwmac_set_clk_tx_rate() and
> > > imx_dwmac_fix_speed() both rmii and mii are excluded from setting the
> > > clock rate with this function.
> > > 
> > > But from what I can read only rmii should be excluded, I am not very
> > > knowledgable with regards to networkinging stuff so my info is
> > > coming from wikipedia.
> > 
> > It depends how iMX8MP wires up the clocks. From what I see in DT:
> > 
> >                                  clocks = <&clk IMX8MP_CLK_ENET_QOS_ROOT>,
> >                                           <&clk IMX8MP_CLK_QOS_ENET_ROOT>,
> >                                           <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
> >                                           <&clk IMX8MP_CLK_ENET_QOS>;
> >                                  clock-names = "stmmaceth", "pclk", "ptp_ref", "tx";
> > 
> >  From include/dt-bindings/clock/imx8mp-clock.h:
> > #define IMX8MP_CLK_ENET_QOS           129
> > #define IMX8MP_CLK_ENET_QOS_TIMER     130
> > #define IMX8MP_CLK_QOS_ENET_ROOT      225
> > #define IMX8MP_CLK_ENET_QOS_ROOT      237
> > 
> >  From drivers/clk/imx/clk-imx8mp.c:
> > IMX8MP_CLK_ENET_QOS is controlled by ccm_base + 0xa880
> > IMX8MP_CLK_ENET_QOS_TIMER ... ccm_base + 0xa900
> > IMX8MP_CLK_ENET_QOS_ROOT ... ccm_base + 0x43b0
> > IMX8MP_CLK_QOS_ENET_ROOT ... ccm_base + 0x42e0
> > 
> > Referring to the iMX8MP documentation:
> > IMX8MP_CLK_ENET_QOS is root clock slice 81, and is known as
> > ENET_QOS_CLK_ROOT in the documentation.
> > IMX8MP_CLK_ENET_QOS_TIMER is root clock slice 82, and is known as
> > ENET_QOS_TIMER_CLK_ROOT in the documentation.
> > IMX8MP_CLK_ENET_QOS_ROOT is CCM_CCGR59 and is known as ENET_QoS in the
> > documentation.
> > IMX8MP_CLK_QOS_ENET_ROOT is CCM_CCGR46 and is known as QoS_ENET in the
> > documentation.
> > 
> > So, we end up with this mapping:
> > 
> > driver:			iMX8MP:
> > stmmaceth		ENET_QoS
> > pclk			QoS_ENET
> > ptp_ref			ENET_QOS_TIMER_CLK_ROOT
> > tx			ENET_QOS_CLK_ROOT
> > 
> > Now, looking at table 5-2, CCM_CCGR59 affects five clocks provided to
> > the QOS:
> > 
> > enet_qos.aclk_i - derived from ENET_AXI_CLK_ROOT, this is the dwmac
> > application clock for AXI buses.
> > enet_qos.clk_csr_i - derived from ENET_AXI_CLK_ROOT, this is the dwmac
> > CSR (for registers).
> > enet_qos.clk_ptp_ref_i - derived from ENET_QOS_TIMER_CLK_ROOT, this
> > clocks the PTP section of dwmac.
> > enet_qos_mem.mem_clk and enet_qos_mem.clk_ptp_ref_i - I'm guessing
> > are to do with the memory that's provided to dwmac.
> > 
> > For CCM_CCGR46, no useful information is given in the iMX8MP
> > documentation in terms of what it corresponds to with the dwmac.
> > 
> > Looking at AN14149, this also doesn't give much information on the
> > RGMII clock setup, and claims that RGMII requires a 125MHz clock.
> > While true for 1G, it isn't true for slower speeds, so I'm not sure
> > what's going on there.
> > 
> > For RMII, we get a bit more information, and figure 1 in this
> > document suggests that the 50MHz RMII clock comes from slice 81, aka
> > IMX8MP_CLK_ENET_QOS, and "tx" in DT. This uses the ENET_TD2 for the
> > clock, which states ENET_QOS_INPUT=ENET_QOS_TX_CLK,
> > OUTPUT=CCM_ENET_QOS_REF_CLK_ROOT.
> > 
> > This doesn't make sense - as I state, dwmac requires a 2.5MHz or 25MHz
> > clock for clk_tx_i in RMII mode, but if ENET_TD2 is RMII refclk, it
> > can't be fed back to clk_tx_i without going through a /2 or /20
> > divider, controlled by signals output from the dwmac depending on the
> > speed.
> > 
> > So... not sure what should be going on in the iMX glue driver for
> > this clock, how it corresponds with clk_tx_i for the various
> > interface modes.
> > 
> > However, I think calling the slice 81 clock "tx" in DT is very
> > misleading.
> > 
> > Maybe someone can shed some light.
> > 
> 
> maybe for some extra info, the device is the imx8mp-tx8p-ml81.dtsi som:
> 
> &eqos {
> 	assigned-clocks = <&clk IMX8MP_CLK_ENET_AXI>,
> 			  <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
> 			  <&clk IMX8MP_CLK_ENET_QOS>;
> 	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
> 				 <&clk IMX8MP_SYS_PLL2_100M>,
> 				 <&clk IMX8MP_SYS_PLL2_50M>;
> 	assigned-clock-rates = <266000000>, <100000000>, <50000000>;

This sets IMX8MP_CLK_ENET_QOS to use the 50MHz at the root mux. I
understand that this provides the RMII 50MHz clock to the TD2 pin, but
I still question whether this clock should be labelled in DT as "tx"
when it _isn't_ clk_tx_i.

Also, the above looks over-engineered. Surely assigning the parents
of these clocks as specified should result in their clock rates
automatically being set, thus making the "assigned-clock-rates"
redundant? Don't know, binding documentation for these properties
do not appear to be part of the kernel tree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

