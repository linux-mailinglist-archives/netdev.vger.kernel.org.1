Return-Path: <netdev+bounces-210617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDAB140DD
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F273A95B4
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96F273D65;
	Mon, 28 Jul 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jm8HPHHs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9582AE97
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722261; cv=none; b=QHp76NTd3DzhNDOxU0XiXkkQew7Cqg+ijA4jwu3nQHjuCz/Mi8lvBtjiiai0kCqglOddQgs9xgEURjgJ4aiotxIBGKwqlfmlG4ibaNFQLXarbQMRjwbU15nO47Yl9LHILBduYUGXdjdJ2e5INfl+P8TUFsKEahxW3+1wrdcvvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722261; c=relaxed/simple;
	bh=M7Y5D5yZDHefqZqvAsLvmhCLY/LXvhvyoWqEFrQ5ODY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8UkDg1fbtOZWLKC12cs90cqj3X/3rg9mz8bwE1cxuvhUd7YJz7gpg2nPsJxdWPT6bJZGYEkJ9ROFkwugrmzRZ+R0x7g8UzVm0AAACYo/9CtRSdG4X+lCyKfaXO2epmPm+AMcuOHdhwE7vEgMigpHnaUOPyhHT0xUtNOeebGeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jm8HPHHs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5fnjPwpP6kWSlMo7NwAEaygkBxreQSv5XarBD0mvajs=; b=jm8HPHHs05soq3opiy7Na5xLSK
	URaPKGcQxhFuYCeiWUNf1AZgjvvx1dAxUP1nj4gBaefx8OigLSkaLMll6rhQ8ONS+njivvVUj6qoD
	wUTqIHXl8xF7xrzzLMtog9xsuJo3MciYC3aH7a7BrS4zWro++zZainsm5ZI7qbzF/K5I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugRGX-0037F5-Al; Mon, 28 Jul 2025 19:03:57 +0200
Date: Mon, 28 Jul 2025 19:03:57 +0200
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
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 1/7] net: stmmac: remove unnecessary checks
 in ethtool eee ops
Message-ID: <6582840d-af8f-4fdf-a866-4997f252a412@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ2e-006KCw-7V@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ2e-006KCw-7V@rmk-PC.armlinux.org.uk>

On Mon, Jul 28, 2025 at 04:45:32PM +0100, Russell King (Oracle) wrote:
> Phylink will check whether the MAC supports the LPI methods in
> struct phylink_mac_ops, and return -EOPNOTSUPP if the LPI capabilities
> are not provided. stmmac doesn't provide LPI capabilities if
> priv->dma_cap.eee is not set.
> 
> Therefore, checking the state of priv->dma_cap.eee in the ethtool ops
> and returning -EOPNOTSUPP is redundant - let phylink handle this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

