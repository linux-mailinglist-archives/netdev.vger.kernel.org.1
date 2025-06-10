Return-Path: <netdev+bounces-196070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14441AD36EA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2728E17982F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03652298259;
	Tue, 10 Jun 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZnxpDKS1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6729825A;
	Tue, 10 Jun 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558991; cv=none; b=nf3mKklsQZRpPKJMWiP1bx0x9icSq4iePbdhLiOHsX96ofgY/LNIfQBxVAcaFsebl12OAeCubuofIVWP6Vuq+RbhOwlXmK10jOFfQ6iSEQl9i4+PHn7Zzk87pOszXvrB7eGR79gj2ch9DyjjC0VKMKo/9LqZwGvmZoNGfX3Zhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558991; c=relaxed/simple;
	bh=eb78fjp8O59KlG+tYk+l3V8QOJEcFRCWcHwDZA9xSp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7Lc76qO8JiOGH7n2ajST3kyl47g6jFFbQkkxxTEzOW46R0azj1UeJlEo6ry6g2DtUGML6MCaqX0qx3PGPb9gQZ1ROk4wnxDIw2tpyQUGJ68+ZnuGBBc0URFN2ejlVj3cPaBjefRPFRHYcU+QeCGCrdjvLCi+yefFymUWPfQAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZnxpDKS1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zae5DDEfWQ2jhoUpOo4fsJWUq416KZg0lCS/OrSRA1c=; b=ZnxpDKS1meMC/Bbkof7RKRlORU
	AbL7MuoMDJRz6IS65M8b94uiB9LbBiHxtFDy8FsC8YijVz47W/xs0uB/5CT9JvWW7jEeYCLzrW1UB
	9vI4VEmkKAVx8XejaRV7lvuPZU1mfwcDJGRGEwXexxIoGVPUV/N2h4U0GsxY3TO2CrOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOyDF-00FGHX-WF; Tue, 10 Jun 2025 14:36:22 +0200
Date: Tue, 10 Jun 2025 14:36:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/3] net: phy: micrel: Add RX error counter
 support for KSZ9477 switch-integrated PHYs
Message-ID: <f8f953d5-a35a-4054-a853-3b04ae9b2c67@lunn.ch>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
 <20250610091354.4060454-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610091354.4060454-3-o.rempel@pengutronix.de>

On Tue, Jun 10, 2025 at 11:13:53AM +0200, Oleksij Rempel wrote:
> Add support for tracking receive error statistics from PHYs integrated
> into the KSZ9477 family of Ethernet switches.
> 
> The integrated PHYs expose a receive error (RXER) counter in register 0x15.
> This counter increments when the PHY detects one or more symbol errors
> on a received frame. The register is cleared upon reading.
> 
> Changes include:
> - `kszphy_update_stats()` to accumulate the RX error count.
> - `kszphy_get_phy_stats()` to expose this count via ethtool PHY stats.
> - Addition of a private `rx_err_pkt_cnt` field in the driver.
> - Registration of `.update_stats` and `.get_phy_stats` callbacks in the
>   KSZ9477 PHY driver structure.
> 
> The functionality of this counter was confirmed by physically disturbing
> the signal lines - specifically by wiggling exposed twisted pair wires and
> intentionally shorting between pairs. These actions triggered RXER
> increments, validating the counter's behavior.
> 
> This RXER counter is confirmed for KSZ9477 and likely applicable to
> other related PHYs like those in KSZ9313.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

