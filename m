Return-Path: <netdev+bounces-109016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FC92688F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7740B1C223C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09364187353;
	Wed,  3 Jul 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1UUf+8XU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9A17A5B0;
	Wed,  3 Jul 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032526; cv=none; b=lnw0Y1sC+2edQM35DHqdrsX7p5CL+TLJ0+3nQRGrODEazCyDqD6/OXqFg+bvmOSQ1WpUJGXUxTk4n58jkgArkXn92NaPk5L3PdMYBgcZtBwHbSjCuIOplh8OU01gj54ZV8CRSRgLYK/GrIbW+IBFgTSSWeynY5Yip8CWsyPLiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032526; c=relaxed/simple;
	bh=N9+slwo6VV6sFpPSkyuZITuZfbr6x6sZUha2Kt1ruCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpCC2D/YVTKEBJfpaEjrJ5zB9t5qNc3ePm6YsBsxGFIj+5A6kRBrtnnTYjCGXIa6iqdd5PKoOEMKyxM0+BCTy2BWw//ft7V4pfJfebDAnvLWP7GJRCvOV13a32V4c9vz1jPUHC7uj7E5Im+Ond5atpvmCM4vEhlYEqeIYNlNock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1UUf+8XU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5FKbXW05GBpGZuyZea5TqNBmmnVr3vaHPEG8vaezhFQ=; b=1UUf+8XUgTemlzb5ex3ZEZiIEH
	nzhR6iCuJ8KOB2n0xeue9uQ5qEJDBrqUeldnYaiOIFq+9VDvkWTXQ6y+Ht+z2Y4Bwh+ofAwEPY3hB
	h4sVSFY+B4IKza8oUuhtlNu+85gKRWp0ouBz7hEWIuoGCgSeWHF2TOWiaEwfR4YxBb0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sP51o-001l9I-8V; Wed, 03 Jul 2024 20:48:28 +0200
Date: Wed, 3 Jul 2024 20:48:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/2] net: phy: microchip: lan87xx: reinit PHY
 after cable test
Message-ID: <eb08bbbb-449a-4dee-857f-a0ebad7e8df3@lunn.ch>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703132801.623218-1-o.rempel@pengutronix.de>

On Wed, Jul 03, 2024 at 03:28:00PM +0200, Oleksij Rempel wrote:
> Reinit PHY after cable test, otherwise link can't be established on
> tested port. This issue is reproducible on LAN9372 switches with
> integrated 100BaseT1 PHYs.

Since this is a patchset, a cover letter would be normal.

> 
> Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

