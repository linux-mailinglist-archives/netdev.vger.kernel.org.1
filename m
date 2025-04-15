Return-Path: <netdev+bounces-182893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06EA8A48D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B41C7A4598
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D23163;
	Tue, 15 Apr 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ClKU8vnT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A02820B7
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735978; cv=none; b=duUw4gThQmAc08aTZBoG+YTU4PlRlM+hQK6JOhXo7etSrcq7T59yohAohnI2hU1kMJ0k5qOXEYz3Dm2vXUboIyLgVA2S5oD0drKak8zSVUWNmbfEIv9ZogXRhOMgBUHqCF137yZC8yff0mHNGOfIL3opI/tPBhR88G+G4vP8EoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735978; c=relaxed/simple;
	bh=K3CVnpnowyfgA2Bwwok34RgCXSy6Lt0R5jhusu/13X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgJ/DkT+j1ywDcuNJjv7aBAKvPWGh2kqX7NzJStJNeXr46EQHyLrJl2fxayyJcKTSWt6jrCi7mNT4kiVVxWhQfM1L2SMgq7/JQRQhXWInT9itcAu1o+267ep1FVfA+3Mwkh4EBJoEarIIZdfhMhMn0Nrz5KQifmdRrp4EZCcugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ClKU8vnT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DSL23HcZL6KoCpUIDVQFu+IE7Bha2qwSLBwjMyfH8eY=; b=ClKU8vnTzlxOX7pHD6XKJIbhgf
	Bh7R1xCKtAzahWbm0vUqK8Y7kAbk4s1/OT1ii4znynJo1CeKJSkVx+8OdGL/Xr3B5ikXUZgsHk6x0
	XCAPNOkyoPIHTTvpifSVVtxW5U5EsplQ2yVXKY/ve/n+XAHUjRaY3fZfyyB1usdeTR5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4jWh-009UTx-Pd; Tue, 15 Apr 2025 18:52:47 +0200
Date: Tue, 15 Apr 2025 18:52:47 +0200
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
Subject: Re: [PATCH net-next 2/3] net: stmmac: sti: convert to
 devm_stmmac_pltfr_probe()
Message-ID: <45094035-3d11-4e1b-ae38-5c4f688cb988@lunn.ch>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
 <E1u4jMj-000rCM-31@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4jMj-000rCM-31@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 05:42:29PM +0100, Russell King (Oracle) wrote:
> Convert sti to use the generic devm_stmmac_pltfr_probe() which will
> call plat_dat->init()/plat_dat->exit() as appropriate, thus
> simplifying the code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

