Return-Path: <netdev+bounces-155518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1CDA02E21
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097E718827EC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB291DE897;
	Mon,  6 Jan 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BSbpdryC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5541DC046
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181868; cv=none; b=rKOySgJOn8ZZulRJ27dwU8W7W2xHRG0a9ozZ7zKS+zDp5GADi6qIo2P96GoupUyGGV3b84zWF38fefS0CNiZvMu4nRVcqzamB+UX0YI3SSjGobcqDzroP/JgzQeo0SFp0eD/vEd+eSOK1xDh4J3ybBe3nNw2X3tIFIH3sULEvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181868; c=relaxed/simple;
	bh=10OWkYca7BONwVU37bDjRDjfbAzRBqExAXe1J6zm+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSrZOnQRAQIzgk/CsKOJhh/2JzEfrupcSk9eBOmV55SZEoWgJqKpRIYCsyh4JByMqQ7aBTIqmtTmEJqVVHc3Y45gyRQ9ba3lxPAxolEFwID9dXexEqLe9RYdC38QOgZgRdP5FavJPs8I3bwGQGOinV8XVIRk4RLOxvXRP6noOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BSbpdryC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TD6yN+jo75z7qtPClbof5z7Gv2ezQi6FSb5vBI7Z6ZM=; b=BSbpdryCv/lo3YrLHmdTg8Qrkn
	2CK7Yir7PfaW48ipgkehD4tlnyP1xsgYCVEanO4FfUS3VRiuUriPmDxq7bT0TzJdDctO+kr9XwO/2
	lBNK/cEWQQWW7aN2/SIItnjHiJ76y0WIcZPXHi4myYFLAQwAAVaRl4Qd4fYmZW15YFyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqD0-001vqo-K3; Mon, 06 Jan 2025 17:44:06 +0100
Date: Mon, 6 Jan 2025 17:44:06 +0100
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
Subject: Re: [PATCH net-next v2 02/17] net: stmmac: move tx_lpi_timer
 tracking to phylib
Message-ID: <fc17707e-83c8-4bb3-9be4-bf583bc4c07b@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmA9-007VWp-Pg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmA9-007VWp-Pg@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:24:53PM +0000, Russell King (Oracle) wrote:
> When stmmac_ethtool_op_get_eee() is called, stmmac sets the tx_lpi_timer
> and tx_lpi_enabled members, and then calls into phylink and thus phylib.
> phylib overwrites these members.
> 
> phylib will also cause a link down/link up transition when settings
> that impact the MAC have been changed.
> 
> Convert stmmac to use the tx_lpi_timer setting in struct phy_device,
> updating priv->tx_lpi_timer each time when the link comes up, rather
> than trying to maintain this user setting itself. We initialise the
> phylib tx_lpi_timer setting by doing a get_ee-modify-set_eee sequence
> with the last known priv->tx_lpi_timer value. In order for this to work
> correctly, we also need this member to be initialised earlier.
> 
> As stmmac_eee_init() is no longer called outside of stmmac_main.c, make
> it static.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

