Return-Path: <netdev+bounces-162023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32753A255C1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B8918851B0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CCB1FF1B8;
	Mon,  3 Feb 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TZW91go4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99871D5AA7;
	Mon,  3 Feb 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574633; cv=none; b=pdTUKHwEwgDczupcU1oTe6l4nRFrvfZ80EU06ojlEzBZ0FCBb/d0x4bYJbdP9A/uDazrrxxLBcFCPjRfxcOEmg+g5lTMPDfIM1NcGAqQpwHPBIp7RW2sprYI+QTrUqswPqB845Rf+x/sN415CKcrQNBosyK/X2T9bix2KitoqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574633; c=relaxed/simple;
	bh=dDQ5bXMFvIraDFaSI7JVfQHoVaBkW/EmdurEQQ/tck8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlsOeKSpIj2Iup6A9ES0r5bi5odJtv23NzogyPkREhGrdX009bQJ09EQFze2xUadvbOv8TSJ4J5DfCrsnClEjsjAVvKfF1PbA4lPCGVdiN2wCjam4UAJoHHhdlXASuw5cuvm7tM5A6DgAFXccvfDiLvwDrq6G30nUb+w0+XJU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TZW91go4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m5jmdUkGlxQxv9j6TR/kZFsFhMcHmh7F4KYY06PhH2s=; b=TZW91go4bW/NtbN3bRhNdp7b/o
	82lAtW0CuXpeFbZGIS3tutxiyrMWjVgz0QWnNuC7z4TYzv1v0MnIVeOKu4hqQMVUhrCoO04yE4vyF
	8dndEFNWReCrluOSBueXFs8zeQLrhk2zdLRWFopuQZJjIWIk5XQ40V3qQcqZp8Vuw9hJNFoGskmzQ
	7rkwUl92OjOd2XE3dB5bYEiqdUqWxIzsT/pAivvc7LBgMu1eckXz8H2aR9aVeruutrdqoIn1X6Tip
	Sdji9Uy5DFhCG/BtT8mXVuGehwXd3a4h/D4RzGihjQAH//+/VD41gyAe0qYA9PVz9bImo5jsHuYly
	MWQIqLoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41610)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tesfy-00082N-1c;
	Mon, 03 Feb 2025 09:23:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tesfs-0000G4-2j;
	Mon, 03 Feb 2025 09:23:24 +0000
Date: Mon, 3 Feb 2025 09:23:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <Z6CLDJJ21MMml3cD@shell.armlinux.org.uk>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
 <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
 <905127b5-96c8-4866-8f69-d9d8a7091c99@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905127b5-96c8-4866-8f69-d9d8a7091c99@socionext.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 03, 2025 at 11:45:05AM +0900, Kunihiko Hayashi wrote:
> Hi all,
> 
> On 2025/02/02 5:35, Russell King (Oracle) wrote:
> > On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > > > When Tx/Rx FIFO size is not specified in advance, the driver checks if
> > > > the value is zero and sets the hardware capability value in functions
> > > > where that value is used.
> > > > 
> > > > Consolidate the check and settings into function stmmac_hw_init() and
> > > > remove redundant other statements.
> > > > 
> > > > If FIFO size is zero and the hardware capability also doesn't have
> > upper
> > > > limit values, return with an error message.
> > > > 
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > 
> > > This patch breaks qemu's stmmac emulation, for example for
> > > npcm750-evb. The error message is:
> > > 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> 
> Sorry for inconvenience.
> 
> > Interesting. I looked at QEMU to see whether anything in the Debian
> > stable version of QEMU might possibly have STMMAC emulation, but
> > drew a blank... Even trying to find where in QEMU it emulates the
> > STMMAC. I do see that it does include this, so maybe I can use that
> > to test some of my stmmac changes. Thanks!
> > 
> > > The setup function called for the emulated hardware is
> > dwmac1000_setup().
> > > That function does not set the DMA rx or tx fifo size.
> > > 
> > > At the same time, the rx and tx fifo size is not provided in the
> > > devicetree file (nuvoton-npcm750.dtsi), so the failure is obvious.
> > > 
> > > I understand that the real hardware may be based on a more recent
> > > version of the DWMAC IP which provides the DMA tx/rx fifo size, but
> > > I do wonder: Are the benefits of this patch so substantial that it
> > > warrants breaking the qemu emulation of this network interface >
> > Please see my message sent a while back on an earlier revision of this
> > patch series. I reviewed the stmmac driver for the fifo sizes and
> > documented what I found.
> > 
> > https://lore.kernel.org/r/Z4_ZilVFKacuAUE8@shell.armlinux.org.uk
> > 
> > To save clicking on the link, I'll reproduce the relevant part below.
> > It appears that dwmac1000 has no way to specify the FIFO size, and
> > thus would have priv->dma_cap.rx_fifo_size and
> > priv->dma_cap.tx_fifo_size set to zero.
> > 
> > Given the responses, I'm now of the opinion that the patch series is
> > wrong, and probably should be reverted - I never really understood
> > the motivation why the series was necessary. It seemed to me to be a
> > "wouldn't it be nice if" series rather than something that is
> > functionally necessary.
> > 
> > 
> > Here's the extract from my previous email:
> > 
> > Now looking at the defintions:
> > 
> > drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_RXFIFOSIZE
> > GENMASK(4, 0)
> > drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define
> > XGMAC_HWFEAT_RXFIFOSIZE GENMASK(4, 0)
> > 
> > So there's a 5-bit bitfield that describes the receive FIFO size for
> > these two MACs. Then we have:
> > 
> > drivers/net/ethernet/stmicro/stmmac/common.h:#define
> > DMA_HW_FEAT_RXFIFOSIZE    0x00080000       /* Rx FIFO > 2048 Bytes */
> > 
> > which is used here:
> > 
> > drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:
> > dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
> > 
> > which is only used to print a Y/N value in a debugfs file, otherwise
> > having no bearing on driver behaviour.
> > 
> > So, I suspect MACs other than xgmac2 or dwmac4 do not have the ability
> > to describe the hardware FIFO sizes in hardware, thus why there's the
> > override and no checking of what the platform provided - and doing so
> > would break the driver. This is my interpretation from the code alone.
> > 
> 
> The {tx,rx}_queus_to_use are referenced in stmmac_ethtool.c, stmmac_tc.c,
> and stmmac_selftests.c as the number of queues, so I've thought that
> these variables should not be non-zero.

Huh? We're talking about {tx,rx}_fifo_size, not _queues_to_use.

> However, currently the variables are allowed to be zero, so I understand
> this patch 3/3 breaks on the chips that hasn't hardware capabilities.
> 
> In hwif.c, stmmac_hw[] defines four patterns of hardwares:
> 
> "dwmac100"  .gmac=false, .gmac4=false, .xgmac=false, .get_hw_feature = NULL
> "dwmac1000" .gmac=true,  .gmac4=false, .xgmac=false, .get_hw_feature = dwmac1000_get_hw_feature()
> "dwmac4"    .gmac=false, .gmac4=true,  .xgmac=false, .get_hw_feature = dwmac4_get_hw_feature()
> "dwxgmac2"  .gmac=false, .gmac4=false, .xgmac=true , .get_hw_feature = dwxgmac2_get_hw_feature()
> 
> As Russell said, the dwmac100 can't get the number of queues from the hardware
> capability. And some environments (at least QEMU device that Guenter said)
> seems the capability values are zero in spite of dwmac1000.

Huh? I mentioned dwmac1000, not dwmac100.

> Since I can't test all of the device patterns, so I appreciate checking each
> hardware and finding the issue.
> 
> The patch 3/3 includes some cleanup and code reduction, though, I think
> it would be better to revert it once.

I'm not sure you're discussing the same issue as the rest of us.
You seem to be talking about a different pair of structure members
(queues_to_use) whereas your patches and the problem at hand is with
the changes made to {tx,rx}_fifo_size.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

