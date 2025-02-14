Return-Path: <netdev+bounces-166381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B6A35C76
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E103B1726
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB652638BE;
	Fri, 14 Feb 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZqwoGD7z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68482627FB;
	Fri, 14 Feb 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532125; cv=none; b=mWCaROpJSOFbV2P3DJTbqb3aDWnRiutzgmm+ERQh/1SCp9oKxdj723Dsh+B013RKNzt9Qrn9op95nxmLxBVz6PywnBP3ez8roDaPqgFs/VA0Hv6gmzuvcuAlxCRyQQtPY27NKoHyzgmr/z9ppBRE5A+LOerQLFKLDPwr3qvCYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532125; c=relaxed/simple;
	bh=p/tvgyRTAO1erproUoKnB9xObhXdJUOSTKz24T3lqTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4mM4wxZVxHHNPGoM4hvMeKrEz7rsPaEhp5+zDrtu/w7d5ZeMfTuyQPxwCE5DgTwY3ShcFGkV29HUAtcw6NKc+6U0Qi3CFwuPmI2d5wodO8Aspk67ICIGK7beTFluxYDcwJV6y/r7p9rz91JoXJcNbJy1rh/c5ucAyw7micRTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZqwoGD7z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RHsXfurBVo9Ce74LImjTzy7g4TxkHm2re9qA247p8t0=; b=ZqwoGD7zEhypQ51Pi4psu8Fb13
	/M062gsF/RpRU603avscdnXAaIUmLMynxoJXCkG97ZPu+jDU9lvsApZ2pUI9la2K8wcp5/qJqqkfC
	nVQ+Ou1d5c8c51byR5HVr3qBSKtZAqPgd7jT28SJJxLYnMeLbhTHo5lDsGzD7GY7bB6slaYEyYDpg
	DXSoP8mAuIKvlRTFstoju/rha43m1qGWx+5rvSHnoA6sjS9nXn7sUu6mmnRdSlHCn35AMYu/4g/jZ
	n9jGMmun594EzdICsIBCyRRB2EYIjL0e5iAI16AwW0JvmbVcLmO/J2SxY4QuyUwSQ2JQjTeUMlYlh
	v/DVqI1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1titlU-0004px-3D;
	Fri, 14 Feb 2025 11:21:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1titlQ-00037F-2R;
	Fri, 14 Feb 2025 11:21:44 +0000
Date: Fri, 14 Feb 2025 11:21:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
Message-ID: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 14, 2025 at 10:58:55AM +0000, Jon Hunter wrote:
> Thanks for the feedback. So ...
> 
> 1. I can confirm that suspend works if I disable EEE via ethtool
> 2. Prior to this change I do see phy_eee_rx_clock_stop being called
>    to enable the clock resuming from suspend, but after this change
>    it is not.
> 
> Prior to this change I see (note the prints around 389-392 are when
> we resume from suspend) ...
> 
> [    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0

This is a bug in phylink - it shouldn't have been calling
phy_eee_rx_clock_stop() where a MAC doesn't support phylink managed EEE.

> [    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> [    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1

Presumably, this is when the link comes up before suspend, so the PHY
has been configured to allow the RX clock to be stopped prior to suspend

> [  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> [  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1

Presumably, as this is after resume, this is again when the link comes
up (that's the only time that stmmac calls phy_eee_rx_clock_stop().)

> After this change I see ...
> 
> [    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> [    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> [  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode

To me, this looks no different - the PHY was configured for clock stop
before suspending in both cases.

However, something else to verify with the old code - after boot and the
link comes up (so you get the second phy_eee_rx_clock_stop() at 7s),
try unplugging the link and re-plugging it. Then try suspending.

The point of this test is to verify whether the PHY ignores changes to
the RX clock stop configuration while the link is up.



The next stage is to instrument dwmac4_set_eee_mode(),
dwmac4_reset_eee_mode() and dwmac4_set_eee_lpi_entry_timer() to print
the final register values in each function vs dwmac4_set_lpi_mode() in
the new code. Also, I think instrumenting stmmac_common_interrupt() to
print a message when we get either CORE_IRQ_TX_PATH_IN_LPI_MODE or
CORE_IRQ_TX_PATH_EXIT_LPI_MODE indicating a change in LPI state would
be a good idea.

I'd like to see how this all ties up with suspend, resume, link up
and down events, so please don't trim the log so much.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

