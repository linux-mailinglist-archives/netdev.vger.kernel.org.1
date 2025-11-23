Return-Path: <netdev+bounces-241050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05CC7E26F
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218ED3A477A
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0D2D3A70;
	Sun, 23 Nov 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n7ZEnNMi"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B21287503
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911370; cv=none; b=ktAdoChw4do7QKqjIem+qrj40vayry4Ox/OwuzwpOUg/beshTWfMbsfaIokegS+v824/b9ENBlYtIPxwdRLJW7g8XT4NhC6P/j5jVp8sNT3i2G12An7V4X7GpWunaJ7Us8/z6yGqMW0EYDJ0qvDWG8jD4y4aloWbU0mccWwmciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911370; c=relaxed/simple;
	bh=q89lS8EidiOlwgzxNGKjSVvReDwqkctFKR97mMOtEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxVB+w8VV1rv30+eELx1EAv++0cOh9ghBDSTAzn/Pr+MCTB00/p59wVPZL4FerohnR7ROXvTTr59IGkFnRqVPLuuEp28ocgwhMa3Yiae3MoRrPiwx5Jev7UY6g+EoZdPRkXg0KgqH/Rff5fuZS0Oon+ZegZwTxKiJIPajHtcukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n7ZEnNMi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (fs276ed015.tkyc509.ap.nuro.jp [39.110.208.21])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id DB0FE606;
	Sun, 23 Nov 2025 16:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1763911228;
	bh=q89lS8EidiOlwgzxNGKjSVvReDwqkctFKR97mMOtEuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7ZEnNMiw2YT8c7Qi/u4Zrxuu7qj+HqIXy2bArYHbW0z6anjqi/mLIwWZoMFKnwfL
	 g6i2ixRV+FgP3CDB3tjapxwnJfcU+jzW2Z9qLcfrgmK8Ra6fV/8nRp58NIh+VF+NeZ
	 /LFr/W02WTI5v0pKpYVs73QfzEUFGiBeMwP1IJyA=
Date: Mon, 24 Nov 2025 00:22:08 +0900
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Subject: Re: [PATCH] net: stmmac: imx: Do not stop RX_CLK in Rx LPI state for
 i.MX8MP
Message-ID: <20251123152208.GE15447@pendragon.ideasonboard.com>
References: <20251123053518.8478-1-laurent.pinchart@ideasonboard.com>
 <aSLKLYuz0WA2LpFF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSLKLYuz0WA2LpFF@shell.armlinux.org.uk>

Hi Russell,

On Sun, Nov 23, 2025 at 08:47:41AM +0000, Russell King (Oracle) wrote:
> On Sun, Nov 23, 2025 at 02:35:18PM +0900, Laurent Pinchart wrote:
> > The i.MX8MP-based Debix Model A board experiences an interrupt storm
> > on the ENET_EQOS IRQ (135) when connected to an EEE-enabled peer.
> > 
> > Setting the eee-broken-1000t DT property in the PHY node solves the
> > problem, which confirms that the issue is related to EEE. Device trees
> > for 8 boards in the mainline kernel, including the i.MX8MP EVK, set the
> > property, which indicates the issue is likely not limited to the Debix
> > board, although some of those device trees may have blindly copied the
> > property from the EVK.
> > 
> > The IRQ is documented in the reference manual as the logical OR of 4
> > signals:
> > 
> > - ENET QOS TSN LPI RX Exit Interrupt
> > - ENET QOS TSN Host System Interrupt
> > - ENET QOS TSN Host System RX Channel Interrupts, Logical OR of
> >   channels[4:0]
> > - ENET QOS TSN Host System TX Channel Interrupts, Logical OR of
> >   channels[4:0]
> > 
> > Debugging the issue showed no unmasked interrupt sources from the Host
> > System Interrupt (GMAC_INT_STATUS), Host System RX Channel Interrupts or
> > Host System TX Channel Interrupts (MTL_INT_STATUS, MTL_CHAN_INT_CTRL and
> > DMA_CHAN_STATUS) that was flagged at an unexpected high rate. This
> > leaves the LPI RX Exit Interrupt as the most likely culprit.
> > 
> > The reference manual doesn't clearly indicate what the interrupt signal
> > is, but from its name we can reasonably infer that it would be connected
> > to the EQOS lpi_intr_o output. That interrupt is cleared when reading
> > the LPI control/status register. However, its deassertion is synchronous
> > to the RX clock domain, so it will take time to clear. It appears that
> > it could even fail to clear at all, as in the following sequence of
> > events:
> > 
> > - When the PHY exits LPI mode, it restarts generating the RX clock
> >   (clk_rx_i input signal to the GMAC).
> > - The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
> >   the ENET_EQOS interrupt.
> > - Before the CPU has time to process the interrupt, the PHY enters LPI
> >   mode again, and stops generating the RX clock.
> > - The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
> >   registers. This does not clear lpi_intr_o as there's no clk_rx_i.
> > 
> > The ENET_EQOS interrupt will keep firing until the PHY resumes
> > generating the RX clock when it eventually exits LPI mode again.
> > 
> > As LPI exit is reported by the LPIIS bit in GMAC_INT_STATUS, the
> > lpi_intr_o signal may not have been meant to be wired to a CPU
> > interrupt. It can't be masked in GMAC registers, and OR'ing it to the
> > other GMAC interrupt signals seems to be a design mistake as it makes it
> > impossible to selectively mask the interrupt in the GIC either.
> > 
> > Setting the STMMAC_FLAG_RX_CLK_RUNS_IN_LPI platform data flag gets rid
> > of the interrupt storm, which confirms the above theory.
> > 
> > The i.MX8DXL and i.MX93, which also integrate an EQOS, may also be
> > affected, as hinted by the eee-broken-1000t property being set in the
> > i.MX8DXL EVK and the i.MX93 Variscite SoM device trees. The reference
> > manual of the i.MX93 indicates that the ENET_EQOS interrupt also OR's
> > the "ENET QOS TSN LPI RX exit Interrupt", while the i.MX8DXL reference
> > manual doesn't provide details about the ENET_EQOS interrupt.
> > 
> > Additional testing is needed with the i.MX8DXL and i.MX93, so for now
> > set the flag for the i.MX8MP only. The eee-broken-1000t property could
> > possibly be removed from some of the i.MX8MP device trees, but that also
> > require per-board testing.
> > 
> > Suggested-by: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > I have CC'ed authors and maintainers of the i.MX8DXL, i.MX8MP and i.MX93
> > device trees that set the eee-broken-1000t property for awareness. To
> > test if the property can be dropped, you will need to
> > 
> > - Connect the EQOS interface to an EEE-enabled peer with a 1000T link.
> > - Drop the eee-broken-1000t property from the device tree.
> > - Boot the board and check with `ethtool --show-eee` that EEE is active.
> > - Check the number of interrupts received from the EQOS in
> >   /proc/interrupts. After boot on my system (with an NFS root) I have
> >   ~6000 interrupts when no interrupt storm occurs, and hundreds of
> >   thousands otherwise.
> > - Apply this patch and check that EEE works as expected without any
> >   interrupt storm. For i.MX8DXL and i.MX93, you will need to set the
> >   STMMAC_FLAG_RX_CLK_RUNS_IN_LPI in the corresponding imx_dwmac_ops
> >   instances in drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c.
> 
> Hang on... also check 100M connections, as I indicated, the lpi_intr_o
> is slow to clear even when the receive clock is running (it takes for
> receive clock cycles - 160ns for 100M, 32ns for 1G.)
> 
> So, I suspect you still get a storm, but it's not as severe.

Of course you're right, I rejoiced too fast :-/

The numbers are getting low enough to not be suspicious, so the
measurements are less precise. I've compared the number of interrupts
right after reaching the login prompt with and without the
eee-broken-100tx and eee-broken-1000t DT properties:

100TX link, eee-broken-* set: 7000 interrupts
1000T link, eee-broken-* set: 2711 interrupts
100TX link, eee-broken-* unset: 9450 interrupts
1000T link, eee-broken-* unset: 6066 interrupts

-- 
Regards,

Laurent Pinchart

