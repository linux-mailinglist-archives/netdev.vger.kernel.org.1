Return-Path: <netdev+bounces-155523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E94A02E31
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201051885AFE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB170824;
	Mon,  6 Jan 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yvf2PkxZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73338F9C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182127; cv=none; b=Dn0rlrD6z8nIke4BWEyEM0VTvxybZNveJGScOuPIyF+ONdT02u3QoXvT7rxal4yidgv0uisU7F16osLTyZdKKv9D2wYA4+DFbLN0xTcXC4B1hGy1KLN5seNn8QJSj6eT3jjYk4AuOtY+lnwjxRvG45BB1laS8VyIrgvGyPgsUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182127; c=relaxed/simple;
	bh=W2gY8zjN1yXK2SjxiBemwsm5QZIl9rzMkFAnqqB6uNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gShfOgvEByYzVbEiwaiKrY4Y6zpSaCVzo5SAZrjUhC1TfR6OImdNpgrMtb8b2JWehVJx4PnvoEf+/a/z1vZhstLz2cNHNxbu9y+VmoOLIEh8gMZWLSkwCxMkOJJLx8xX0AxLrvQO4Dgn6R4d5hjHLI+42poWpgiUcDsv29wxeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yvf2PkxZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OUWR+zB34gQucD9TutxNRjsruuEg8bng53IkXPVvSQE=; b=yvf2PkxZLIL2hq1wmUMNlSKchr
	ybXJsLCgxPzKgLpg2XTtyD4D6s5RzYLfEJUiXlGs3Vz9wRcF6AiYrB1iY0Ust1sTfH0Ohfnk2FWts
	v27nV5JBNvC6AuTTNvtFngJ2yOFJAn6JAdVx8fpUQX3HPya5zrcWTji/TjA4Ld8ckVy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqHK-001vx2-PC; Mon, 06 Jan 2025 17:48:34 +0100
Date: Mon, 6 Jan 2025 17:48:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 04/17] net: stmmac: make EEE depend on
 phy->enable_tx_lpi
Message-ID: <435a1b40-12f5-4eca-a9d8-030c0661a9b3@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAK-007VX1-2Q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAK-007VX1-2Q@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:04PM +0000, Russell King (Oracle) wrote:
> Make stmmac EEE depend on phylib's evaluation of user settings and PHY
> negotiation, as indicated by phy->enable_tx_lpi. This will ensure when
> phylib has evaluated that the user has disabled LPI, phy_init_eee()
> will not be called, and priv->eee_active will be false, causing LPI/EEE
> to be disabled.
> 
> This is an interim measure - phy_init_eee() will be removed in a later
> patch.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

