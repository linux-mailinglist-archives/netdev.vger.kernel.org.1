Return-Path: <netdev+bounces-142969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950AD9C0D0D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5551F2411C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF37216A00;
	Thu,  7 Nov 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MSHN4Og8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CB21315C;
	Thu,  7 Nov 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001059; cv=none; b=nUcC/KeU6ACGWG+sXvpac16Z6ANA2ivj8tFdAfnIY+8VxxJ16EdeispZifK7/DDvQ5JSUG+6HGqfxse5yJxDUH4QtXWz90DlA5s29rgGP7ySrPAyJ0Ic/KxMsu+SsPskiU5DCsvJ6q5wOxYMB6Yoi2Efh5loc+VH1fTEX8Ohzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001059; c=relaxed/simple;
	bh=BuoWM0rKt34y/djzPWsyouqoCAMIW1F3mlI5yt2wJnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp4s3epysgkFztwNmxxCinLdTz8zIaGL7wG30e5RzyGLWIV8P86pnD1Q77Qwi26Lx0e6DpZMIy58+BGHP9LViIukj+KDV1WiO1k4U4kLmJzO1DqbtVNp5hOroURn/UME1rbdjdgp22sAChQ5FsBRZp3s+sKL9ub445F1QQpdkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MSHN4Og8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Harpu3+5qMJGSyUBRu25o6KYVujf3CPupoBCeHNxWs8=; b=MSHN4Og8FOWIB9wDfdwXJ1RBb0
	Q7VoO/3ibduRLziuHpPV7uXMID2XWqlhDBMf7Qw83W7ZcKUnfrae5mHF0/XwRzt1LuJFRWjf2Fj2T
	IkxPoAgAH2O2mhQM9aeFQIvn1fRVQD42Xpwr3au32YGa2IzCyGDwf2lgfAp/T1ZABbw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96Rk-00CURs-Os; Thu, 07 Nov 2024 18:37:28 +0100
Date: Thu, 7 Nov 2024 18:37:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 3/7] net: freescale: ucc_geth: Use
 netdev->phydev to access the PHY
Message-ID: <f1cbac0e-cd52-4c04-ada0-b359d97aec24@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-4-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:50PM +0100, Maxime Chevallier wrote:
> As this driver pre-dates phylib, it uses a private pointer to get a
> reference to the attached phy_device. Drop that pointer and use the
> netdev's pointer instead.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

