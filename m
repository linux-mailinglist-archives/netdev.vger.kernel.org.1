Return-Path: <netdev+bounces-170371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC16A485D2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60B4176B9D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108061CB9EA;
	Thu, 27 Feb 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ua+UrFDJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754F1D5AC3
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674839; cv=none; b=fQpCjiprabg2dYwpVhVp4pjzwhmC9D9Y9jVS1N71OVVT2EKgYT9DvjK3d8x2V/488fehJxyJ/4zrTteuvPYBsKI14cNcXNi6LDRUovX+QHwBdhUstLA/QS4H71PoGEYuDq0z0FZpmuilPP3+sCHrkg9VkiNV4ONH6g9McEncNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674839; c=relaxed/simple;
	bh=/f0FPF9nqGBlUOqvgfm/v29ntJZz4TISf+rXsQw82ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQubLr1wZtskqbpJIEn28nmyzpyk4TxDkKV1I7LyuphzQlnOmnaOGw6yaqJU6h4pNArqxKLnZw+QETsXhKdT8ne51Jhb36pQJ9bASl2+cWwVrpCzc9VOy08DZwXC6bBUEKD8BlDxQH93CF9kRogBH0GSEbNHkruKWThqcnL/jmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ua+UrFDJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yii92iQAEmxCOP2QDsW+vzITDTXCaT6QnQ8yK7d0FrI=; b=ua+UrFDJfdRtQF05ycPAm1iveg
	9inZXR1uacy2V0yfnuGkr5A96MMUNwHsq9QBhDni36Dz3ofDVe+eSUeYHRy/ZHiBxemcH0gI2wk2y
	Pq+v+JyfhQgMQVAqagztNDsrTwm1iscDZj7RlDTrhs71kh2B1o6644S71Jhvqm6jxdL0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnh2T-000eog-0Q; Thu, 27 Feb 2025 17:47:09 +0100
Date: Thu, 27 Feb 2025 17:47:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 5/5] net: stmmac: fix resume when media is
 in low-power mode
Message-ID: <4a1ecc2e-1feb-4d93-9204-218942e20ee1@lunn.ch>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1c-0056LO-DN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnf1c-0056LO-DN@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 02:38:08PM +0000, Russell King (Oracle) wrote:
> The Synopsys Designwavre GMAC core databook requires all clocks to be
> active in order to complete software reset.
> 
> This means if the PHY receive clock has been stopped due to the media
> being in EEE low-power state, and the PHY being permitted to stop its
> clock, then software reset will not complete.
> 
> Phylink now provides a way to work around this by calling
> phylink_prepare_resume() before attempting to issue a reset. This will
> prepare any attached PHY by disabling its permission to stop the clock.
> phylink_resume() will restore the receive clock stop setting according
> to the configuration passed from the netdev driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

