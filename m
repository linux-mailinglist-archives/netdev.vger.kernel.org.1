Return-Path: <netdev+bounces-182811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C5A89F58
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D778E16A9B2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DC297A42;
	Tue, 15 Apr 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kdfgPC0f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25172DFA2F;
	Tue, 15 Apr 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723504; cv=none; b=JmReVqSjUZe3pbhX2L8Zat8kTrK1ocrXnyTetUCr+xQToFwm/Ebw0lKjd1igeUpDdYHBxUA6Txp4cBBKPxQgRdQmWIK6ihuZPWN1Ted9aVzUMzwD7B1Z3WsFCtUH5ZQmuK4OZgqjDsGv69U1WvGxSm1MMNZB9lqtepDfgLyBg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723504; c=relaxed/simple;
	bh=lilh6DgEHFAJBHveNzZ1DXag1L6JWH5M/of03MZ64Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oscUYVrbtPt2Sz/ountxNt6M/T7UA0W4ana6ZeblIdbmFiuaCWZKX+ifpndUCYiDCCKONQZXGok6820jSqkbLgAqLUXMaHQAK+upr05c/GxXbuNyYU3gE5w31hMiuKg4F+Bbs47AIkrAnt211yPXeBLP0xrV4cu+VkA81oGktpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kdfgPC0f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U3ryYnUUuWttb8wAZUQ51mckx1LM5d+Eo8htRMGH8FA=; b=kdfgPC0fvU1og3EXc20ZYPD++8
	Kvdf22c88XfQwT9AOhEo2ZDiGysNx7CCJGeS0TkwLWCMcliWy5sdwXlUdy7oFEA8iieoQ+I5XwC9Q
	+xKqi+FxES1keawD/gWowr/PDtVadghvBxB/P913eZWbDCqbIsKwT6nu3FMPySScpUs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4gHU-009Rwi-Q0; Tue, 15 Apr 2025 15:24:52 +0200
Date: Tue, 15 Apr 2025 15:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH net] net: phy: microchip: force IRQ polling mode for
 lan88xx
Message-ID: <d0c0af22-6825-48de-8485-ef294c840f6d@lunn.ch>
References: <20250414152634.2786447-1-fiona.klute@gmx.de>
 <24541282-0564-4fb6-8bd1-430f6b1390b0@lunn.ch>
 <db6b47a1-1a6c-476e-a679-aac3e5117c68@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6b47a1-1a6c-476e-a679-aac3e5117c68@gmx.de>

> > Thanks for submitting this. Two nit picks:
> > 
> > It needed a Fixes: tag. Probably:
> > 
> > Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")
> Sure, will add that (and a comment) and resend. I wasn't sure if I
> should add it if I can't pinpoint exactly where the problem was
> introduced, and it looks like the interrupt handling was changed a bit
> after.

If you can prove interrupt handling did actually work to start with,
maybe a later commit could be referenced. But i'm not sure it is worth
the effort.

	Andrew

