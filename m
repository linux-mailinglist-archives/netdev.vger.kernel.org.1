Return-Path: <netdev+bounces-187594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B419AA7F8B
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 11:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37C317C9E7
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C921CCEC8;
	Sat,  3 May 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L4PVO49l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E031C84DD
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746262804; cv=none; b=cRe+CF2SzuD0A2RSPpOqUhMyRvlxln5hGE9W4KI11IN0AWxz4uZeRK37jW+oqr/eFU39xhAS2zdhBYxYOHXXYwMdIbMiuNaiPAORAvKjf4MUx+fHptTDli13v5DF4QaSzbQHwOqxh99IYe8zwMZyZFIh/+oSeVaXbT9sfwTpUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746262804; c=relaxed/simple;
	bh=o5LtxiMg0ObNSfpEr1Rz9biuCUwINf/MpGY8QVn3VIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw0HfV11tFMvnecdR+g04lPKNhiM7dC7ZepxWPRq9PFk6nQf0k6o5+wjZeuOSNB205FaYujz58bWjmafenBF9nKOI3ZqM3+/Wz/WJhU9psSynrcKir98EpGxkHrI2FnWq8lUJM2YsjQhwVF0kPQ6Y8YHk6OI7BvamnGeLGTkw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L4PVO49l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PkVXK7clTpydmjQPzKigib/TbsUCWoUyU4IFnzv0iUc=; b=L4PVO49lZrRMhwpLmEJ8TPgPBW
	kZ7gEZ9THS6C9iiDSGvSZ2OGi9ZgcCSjt1eBoN4iSKujni3GzA8j2doqCR6n3W7QD7pNQiZIiVxYH
	1e5ZAfPD60B1fUYD7pdq07K6dswCQ0OxVHoS32c/BgarvodZWD4SCI9hTzFY4Ap/aB9tkIyykFk95
	ZblsIKyxwEBPnNu3gVXD6UCxN6ci2wFf5Fde+4BL3LnSViNnQgEHi7+nTP/9a3+KAQZe2DuVPjyte
	QD2oFkPj/yVhDtFJIAch37FXqEKff8gTxiBpzit/XgMscAPFXq1DJHd0c9Kgbu5z8LKXLR4h01GfF
	6FEML5fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uB8it-0002HF-2W;
	Sat, 03 May 2025 09:59:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uB8ip-0001Zw-37;
	Sat, 03 May 2025 09:59:47 +0100
Date: Sat, 3 May 2025 09:59:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+netdevbpf@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/6] net: stmmac: replace speed_mode_2500()
 method
Message-ID: <aBXbAwMC4V_3cmj6@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <174623583625.3773265.4045311227752993763.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174623583625.3773265.4045311227752993763.git-patchwork-notify@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Err, I sent v2 a couple of days ago, did patchwork not see it?

On Sat, May 03, 2025 at 01:30:36AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 1 May 2025 12:45:21 +0100 you wrote:
> > Hi,
> > 
> > This series replaces the speed_mode_2500() method with a new method
> > that is more flexible, allowing the platform glue driver to populate
> > phylink's supported_interfaces and set the PHY-side interface mode.
> > 
> > The only user of this method is currently dwmac-intel, which we
> > update to use this new method.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,1/6] net: stmmac: use a local variable for priv->phylink_config
>     https://git.kernel.org/netdev/net-next/c/5ad39ceaea00
>   - [net-next,2/6] net: stmmac: use priv->plat->phy_interface directly
>     https://git.kernel.org/netdev/net-next/c/1966be55da5b
>   - [net-next,3/6] net: stmmac: add get_interfaces() platform method
>     https://git.kernel.org/netdev/net-next/c/ca732e990fc8
>   - [net-next,4/6] net: stmmac: intel: move phy_interface init to tgl_common_data()
>     https://git.kernel.org/netdev/net-next/c/0f455d2d1bbe
>   - [net-next,5/6] net: stmmac: intel: convert speed_mode_2500() to get_interfaces()
>     https://git.kernel.org/netdev/net-next/c/d3836052fe09
>   - [net-next,6/6] net: stmmac: remove speed_mode_2500() method
>     https://git.kernel.org/netdev/net-next/c/9d165dc58055
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

