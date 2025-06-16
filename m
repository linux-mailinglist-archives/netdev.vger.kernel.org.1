Return-Path: <netdev+bounces-198343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC6ADBDC2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE63A65D2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479B2264DB;
	Mon, 16 Jun 2025 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E31EaIDT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986ED2163B2
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117018; cv=none; b=H8RsyI6qaa987GWZ3+MlAYu2+aBgd7Pgnv0yrTXlu/o6BJYSY+M0RHmL1PkKZpMDqrbgiI4lzodEYOA1WBamXETdcbIGNV41JNN8dGjviOzDYHB5gWsCWUV9xc5a9OXe1zGP46GNoJHILafp01m2EDKLvKDkRPPTDz+bleQygt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117018; c=relaxed/simple;
	bh=EjuNgF/vVO+K65YPYw5vfwGSWtBvVncO7MAJJWGEkco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWNxD3y3vj0VdQHm/aG2oRW++sYyqsuxiafw2uEwxQiaZPD8sq6SgxJZpR/HiR4VP8ZkuBE4uJ2hvJBNFU5tsrF3S4YCl4a7VCcnRQE13yQoas4QjI0s9TgqcmXUeatZTa2/kTgwSRVXgQ9mW55e0EZpdoZj8Xux5dGUdLn+7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E31EaIDT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7U66mXwcbciGnG8InnXr7UU0BGV3gljAYw3gTyUi1vE=; b=E31EaIDTvDlv1TkwMeGCVb9Nkb
	V4ra4rjueNOjW03xxRxzHsIIldKw1n858GPIlkDa9wxvZ3fpik88aDiTmkJl7IPlWK/y/iwVArkVq
	7MtgBF9EvvGfKOqyDd7hpcdD4AcpJoZjy6ej6OaFooKahhh12vjDmcbLTSPAWqDisH3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJNe-00G6Xm-SP; Tue, 17 Jun 2025 01:36:46 +0200
Date: Tue, 17 Jun 2025 01:36:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/4] net: stmmac: visconti: make phy_intf_sel
 local
Message-ID: <cb36aa9a-a9ab-48b4-8259-5e31b69deb35@lunn.ch>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
 <E1uRH2G-004UyY-GD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uRH2G-004UyY-GD@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 10:06:32PM +0100, Russell King (Oracle) wrote:
> There is little need to have phy_intf_sel as a member of struct
> visconti_eth when we have the PHY interface mode available from
> phylink in visconti_eth_set_clk_tx_rate(). Without multiple
> interface support, phylink is fixed to supporting only
> plat->phy_interface, so we can be sure that "interface" passed
> into this function is the same as plat->phy_interface.
> 
> Make phy_intf_sel local to visconti_eth_init_hw() and clean up.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

