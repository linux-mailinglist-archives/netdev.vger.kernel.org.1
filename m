Return-Path: <netdev+bounces-167841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA24A3C855
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138C3A6441
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3021B183;
	Wed, 19 Feb 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LBPbPLYV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557421A457;
	Wed, 19 Feb 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992432; cv=none; b=eRv9zmlZhXazg4hDdhcU+znxfP62Y5Up4o9HPOzg/tvDtFwPtzBsNKnBOI06vkHBmB+6X4zttaXHHMobtkM+CEehllij/DwqOaY//d0si8evsGb1IVeyuhzPPx5kZ5JUi/TxT4S2OSCtxFzE8ohu3sgmn6Jvv6CY4rxx+Jp8m54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992432; c=relaxed/simple;
	bh=QuSZCOPVZYWa9LYtcJiDp8tlKZN9MYKpMLXHtTH29h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6gxu5ZWxPNklMAI94aQLIQygAF8uQP3D05mBI2Z+HEJUuPFqffRyqTBTOkJgXMX+K8kMurU84qNHe3JvhaRvFt1A7bC2JfDLEiPizQalnF0uppaBajeDbHI3VqFya3YWtW8QFhoS8Ogwh9YCXbyEhQVwOHS+ILfxf6rBf6qPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LBPbPLYV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AXdrK0FW7YBCiiP1kX6NoL+0DT8yWctwGO9dXqbApP0=; b=LBPbPLYVfyUVGqIt7OCUrlXrd5
	lIHTDU6Mx3DQRND5VLydjwu3aBm/affJCwLVJn++b0RWN6vGZj3IpBtIg7uRC++gz4TL4PwiVkYkU
	qiNkxSwrxIuWvOYHRkMit1/pf0mLV59aCtp7JQuSzNpGnsvy1jRMD434rxyMNWR3+/0TDBzcV0Uzp
	44/uqEJ46rBpP2qpKbwzunVcpM/Gyj6XWyJtPtkiqViAPKFHLk4on4POUr+EOJJ4nVb69TLcRs98K
	E5wtWMGa+mt4q7QuHVklVtwfJUeaG8K+iKE67srxZPrMY1Bk6DkswRG6fUrKnmz5vOu+xgTtk1RhZ
	M8GtZjXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36382)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkpVm-0006ih-21;
	Wed, 19 Feb 2025 19:13:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkpVi-00009w-2O;
	Wed, 19 Feb 2025 19:13:30 +0000
Date: Wed, 19 Feb 2025 19:13:30 +0000
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
Message-ID: <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 19, 2025 at 05:52:34PM +0000, Jon Hunter wrote:
> On 19/02/2025 15:36, Russell King (Oracle) wrote:
> > So clearly the phylink resolver is racing with the rest of the stmmac
> > resume path - which doesn't surprise me in the least. I believe I raised
> > the fact that calling phylink_resume() before the hardware was ready to
> > handle link-up is a bad idea precisely because of races like this.
> > 
> > The reason stmmac does this is because of it's quirk that it needs the
> > receive clock from the PHY in order for stmmac_reset() to work.
> 
> I do see the reset fail infrequently on previous kernels with this device
> and when it does I see these messages ...
> 
>  dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
>  dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine
>   initialization failed

I wonder whether it's also racing with phylib, but phylink_resume()
calling phylink_start() going in to call phy_start() is all synchronous.
That causes __phy_resume() to be called.

Which PHY device/driver is being used?

> > So, my preference would be to move phylink_resume() later, removing
> > the race condition. If there's any regressions, then we need to
> > _properly_ solve them by ensuring that the PHY keeps the RX clock
> > running by honouring PHY_F_RXC_ALWAYS_ON. That's going to need
> > everyone to test their stmmac platforms to find all the cases that
> > need fixing...
> 
> Thanks for the in-depth analysis and feedback. We have 3 SoCs that use this
> driver and so I will do some testing with this change on all of them.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

