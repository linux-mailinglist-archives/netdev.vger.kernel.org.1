Return-Path: <netdev+bounces-161944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F8A24BCF
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 21:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3BE3A4FD3
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F053146590;
	Sat,  1 Feb 2025 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bAlT2Tle"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EA2F5E;
	Sat,  1 Feb 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738442170; cv=none; b=J6sFHo690H7WK4t4LHd8omdt6D2JceOJWOUGgIgxVzJq/lL2SBkn7UhCNMfwAwoh/v0syPMrOQyA1e3uJnsIK4r5WP3kLCb45Lf/MUO5xahk3RTLi5iAcOaWxeB5E/qtIU3z/+ZLDTusgsml2tFWqoVq4ZcJvpNA+dDqY8QLZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738442170; c=relaxed/simple;
	bh=5Eg1cP3nSwTPG6XN5B0ZZttBUpy0rGi8WAN+4VyVENI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odl+vDoDLvDy05KmQIrd0GXXZD3aQqpBqUApKQVvkDr5awEFQxElvgPDiPubghRZXOZqDofeiEwq84krekl4Qon0Vta7KX/Oitg49I7bEvvZoM4+BJnbmHyjMbanEDPuSFMIcrDrElQi4PIK+BmSGC/pYLKP6W+Mh5YNbGhwhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bAlT2Tle; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RKlP9KK8eFpczHSul5wq/adIBHhrxNAy/lPBccThvJg=; b=bAlT2TlebZvgHHaS+dcfltW+Uy
	dASNauZetVioj+Ayxi15guTG5iiVCCOajiFuawoCyshtiuVAnSF6ogAk8YCa5haSVHY7xXePMqbnz
	KZIbo0qFEIQG9N1D1oiU7xAQOon+akzsAPQwDhPn3m5Rl9BhYDlRjcaNp7QT51HblcuRc5HM3a07J
	EoJZr9LNKQsJrGLxwaBbk7n81RFTu9AagQjWqD58Os1KcbuR/JhPE5xSFPfYWUyaHhirNimrsPlCg
	Y75kQ6EUJLgZwRw1UmbqPVkI7h+er8k969Il2YuZY8uG+xEKdcDESxhQC16KfLJn9nsq1h6+ol127
	pFVIM20w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50882)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1teKDO-00031o-1L;
	Sat, 01 Feb 2025 20:35:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1teKDI-00077A-0t;
	Sat, 01 Feb 2025 20:35:36 +0000
Date: Sat, 1 Feb 2025 20:35:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
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
Message-ID: <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > When Tx/Rx FIFO size is not specified in advance, the driver checks if
> > the value is zero and sets the hardware capability value in functions
> > where that value is used.
> > 
> > Consolidate the check and settings into function stmmac_hw_init() and
> > remove redundant other statements.
> > 
> > If FIFO size is zero and the hardware capability also doesn't have upper
> > limit values, return with an error message.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This patch breaks qemu's stmmac emulation, for example for
> npcm750-evb. The error message is:
> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size

Interesting. I looked at QEMU to see whether anything in the Debian
stable version of QEMU might possibly have STMMAC emulation, but
drew a blank... Even trying to find where in QEMU it emulates the
STMMAC. I do see that it does include this, so maybe I can use that
to test some of my stmmac changes. Thanks!

> The setup function called for the emulated hardware is dwmac1000_setup().
> That function does not set the DMA rx or tx fifo size.
> 
> At the same time, the rx and tx fifo size is not provided in the
> devicetree file (nuvoton-npcm750.dtsi), so the failure is obvious.
> 
> I understand that the real hardware may be based on a more recent
> version of the DWMAC IP which provides the DMA tx/rx fifo size, but
> I do wonder: Are the benefits of this patch so substantial that it
> warrants breaking the qemu emulation of this network interface ?

Please see my message sent a while back on an earlier revision of this
patch series. I reviewed the stmmac driver for the fifo sizes and
documented what I found.

https://lore.kernel.org/r/Z4_ZilVFKacuAUE8@shell.armlinux.org.uk

To save clicking on the link, I'll reproduce the relevant part below.
It appears that dwmac1000 has no way to specify the FIFO size, and
thus would have priv->dma_cap.rx_fifo_size and
priv->dma_cap.tx_fifo_size set to zero.

Given the responses, I'm now of the opinion that the patch series is
wrong, and probably should be reverted - I never really understood
the motivation why the series was necessary. It seemed to me to be a
"wouldn't it be nice if" series rather than something that is
functionally necessary.


Here's the extract from my previous email:

Now looking at the defintions:

drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_RXFIFOSIZE        GENMASK(4, 0)
drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define XGMAC_HWFEAT_RXFIFOSIZE GENMASK(4, 0)

So there's a 5-bit bitfield that describes the receive FIFO size for
these two MACs. Then we have:

drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_RXFIFOSIZE    0x00080000       /* Rx FIFO > 2048 Bytes */

which is used here:

drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:    dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;

which is only used to print a Y/N value in a debugfs file, otherwise
having no bearing on driver behaviour.

So, I suspect MACs other than xgmac2 or dwmac4 do not have the ability
to describe the hardware FIFO sizes in hardware, thus why there's the
override and no checking of what the platform provided - and doing so
would break the driver. This is my interpretation from the code alone.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

