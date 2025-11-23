Return-Path: <netdev+bounces-241046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92734C7DE70
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E2F3A99A4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BF204F93;
	Sun, 23 Nov 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l5u7xl+Y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4113AF2
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763887683; cv=none; b=jilBp+8UJBOEPNOjHH4YSoqEycxKCHsV+WsVlFtZhHeibqlQethA4ACgPczKvDEzEpTkgRx7jHpHX1vfFX9lFbwJEr5t94FRBCjW6HOLfxxvCL3h8f7xJ27C6UADmx35eg/IWxj1a31yCFEKkIeExDm6GSbVLQJIyNBgC97zKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763887683; c=relaxed/simple;
	bh=h4SQyosY1eGTJ/rRlYmy3ASX2LGqAIsKmFB9HLfnu+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxqn+xiEKRF2CHTk2arIcgG0LRJ1qNgpPtr53IQAz0WwnP+HeMgoOVPPm8VgW2ViKh7gV4lNgJ08ZNfTI7/YuRssW/L84XqYNccXA0M1/l8e1Viejw7lhC5Ide3ZcIm3lN8z8dHHd1OG8OEb1IjBG3fium5AFAGoJb+enFiFi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l5u7xl+Y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5w9TBs6f6PMZqeUvDfvd2Z0K+crtpRu8aQyOxCYaiZg=; b=l5u7xl+Yu9iPwjJFyG0AppFlU4
	6j18KQ4AwQbDMUxqx84liBAXmoa0/rR6HkMtEHcwJuudnDIvsqlzWtX44F7tAi33rbWaGKs6YBwT5
	qWYuPmwZDoKSAIwbOs9HtOYUy0tQNEn+N7GjJE26bPRDR3drhvvASoQ6NI00WACObGKyne8ttAxer
	vsMlujQasbu2PlG7uAoxpE8M+kCWyw0zO5Wy7036XiaqlPa9zGMxo12Qb2anYU88wDd8JmptbUcpr
	xFJyN3pNn/pMFtLUlh4Y17jt1e6wGu4OoLD2rFTjW+4Niem1D2Ctea1X3Y7JMHJWN+j++nAiM+2XZ
	w2pdvC2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58278)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vN5l5-000000000kk-0c8N;
	Sun, 23 Nov 2025 08:47:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vN5l0-0000000079D-0EuB;
	Sun, 23 Nov 2025 08:47:42 +0000
Date: Sun, 23 Nov 2025 08:47:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <aSLKLYuz0WA2LpFF@shell.armlinux.org.uk>
References: <20251123053518.8478-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123053518.8478-1-laurent.pinchart@ideasonboard.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 23, 2025 at 02:35:18PM +0900, Laurent Pinchart wrote:
> The i.MX8MP-based Debix Model A board experiences an interrupt storm
> on the ENET_EQOS IRQ (135) when connected to an EEE-enabled peer.
> 
> Setting the eee-broken-1000t DT property in the PHY node solves the
> problem, which confirms that the issue is related to EEE. Device trees
> for 8 boards in the mainline kernel, including the i.MX8MP EVK, set the
> property, which indicates the issue is likely not limited to the Debix
> board, although some of those device trees may have blindly copied the
> property from the EVK.
> 
> The IRQ is documented in the reference manual as the logical OR of 4
> signals:
> 
> - ENET QOS TSN LPI RX Exit Interrupt
> - ENET QOS TSN Host System Interrupt
> - ENET QOS TSN Host System RX Channel Interrupts, Logical OR of
>   channels[4:0]
> - ENET QOS TSN Host System TX Channel Interrupts, Logical OR of
>   channels[4:0]
> 
> Debugging the issue showed no unmasked interrupt sources from the Host
> System Interrupt (GMAC_INT_STATUS), Host System RX Channel Interrupts or
> Host System TX Channel Interrupts (MTL_INT_STATUS, MTL_CHAN_INT_CTRL and
> DMA_CHAN_STATUS) that was flagged at an unexpected high rate. This
> leaves the LPI RX Exit Interrupt as the most likely culprit.
> 
> The reference manual doesn't clearly indicate what the interrupt signal
> is, but from its name we can reasonably infer that it would be connected
> to the EQOS lpi_intr_o output. That interrupt is cleared when reading
> the LPI control/status register. However, its deassertion is synchronous
> to the RX clock domain, so it will take time to clear. It appears that
> it could even fail to clear at all, as in the following sequence of
> events:
> 
> - When the PHY exits LPI mode, it restarts generating the RX clock
>   (clk_rx_i input signal to the GMAC).
> - The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
>   the ENET_EQOS interrupt.
> - Before the CPU has time to process the interrupt, the PHY enters LPI
>   mode again, and stops generating the RX clock.
> - The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
>   registers. This does not clear lpi_intr_o as there's no clk_rx_i.
> 
> The ENET_EQOS interrupt will keep firing until the PHY resumes
> generating the RX clock when it eventually exits LPI mode again.
> 
> As LPI exit is reported by the LPIIS bit in GMAC_INT_STATUS, the
> lpi_intr_o signal may not have been meant to be wired to a CPU
> interrupt. It can't be masked in GMAC registers, and OR'ing it to the
> other GMAC interrupt signals seems to be a design mistake as it makes it
> impossible to selectively mask the interrupt in the GIC either.
> 
> Setting the STMMAC_FLAG_RX_CLK_RUNS_IN_LPI platform data flag gets rid
> of the interrupt storm, which confirms the above theory.
> 
> The i.MX8DXL and i.MX93, which also integrate an EQOS, may also be
> affected, as hinted by the eee-broken-1000t property being set in the
> i.MX8DXL EVK and the i.MX93 Variscite SoM device trees. The reference
> manual of the i.MX93 indicates that the ENET_EQOS interrupt also OR's
> the "ENET QOS TSN LPI RX exit Interrupt", while the i.MX8DXL reference
> manual doesn't provide details about the ENET_EQOS interrupt.
> 
> Additional testing is needed with the i.MX8DXL and i.MX93, so for now
> set the flag for the i.MX8MP only. The eee-broken-1000t property could
> possibly be removed from some of the i.MX8MP device trees, but that also
> require per-board testing.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> I have CC'ed authors and maintainers of the i.MX8DXL, i.MX8MP and i.MX93
> device trees that set the eee-broken-1000t property for awareness. To
> test if the property can be dropped, you will need to
> 
> - Connect the EQOS interface to an EEE-enabled peer with a 1000T link.
> - Drop the eee-broken-1000t property from the device tree.
> - Boot the board and check with `ethtool --show-eee` that EEE is active.
> - Check the number of interrupts received from the EQOS in
>   /proc/interrupts. After boot on my system (with an NFS root) I have
>   ~6000 interrupts when no interrupt storm occurs, and hundreds of
>   thousands otherwise.
> - Apply this patch and check that EEE works as expected without any
>   interrupt storm. For i.MX8DXL and i.MX93, you will need to set the
>   STMMAC_FLAG_RX_CLK_RUNS_IN_LPI in the corresponding imx_dwmac_ops
>   instances in drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c.

Hang on... also check 100M connections, as I indicated, the lpi_intr_o
is slow to clear even when the receive clock is running (it takes for
receive clock cycles - 160ns for 100M, 32ns for 1G.)

So, I suspect you still get a storm, but it's not as severe.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

