Return-Path: <netdev+bounces-171292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD098A4C651
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBD189891F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E2211261;
	Mon,  3 Mar 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lQnLgtOL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28751DF754;
	Mon,  3 Mar 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017871; cv=none; b=qd6B153JAYcyJsrRxshhY6oo2rmgeN3/XC1zDnCAMiMJul8lfFYwOC/IgahGXP5VdnWGegbPcPORIrwR9BNX0QSNFT9fdnURZDIJvVOH+2hELKa+E/+0pBkAK40Wx5pbZK7N2MDYekNeTmgpFcDjFPEuM6WRpsKr9m0rAD3nDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017871; c=relaxed/simple;
	bh=AYfMTvFM9Oy2fOLuH2dlsx+npGwbaV+gUIDf7/AoLN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyIJRjZPodZ/8HKNjKtl+iSbGVuEyRrdNCjfQtPDgD/Hd6SY+XIwOAVFOhkKqqQz9TYU2agZB74LXqKPDra9Ln7HrITmoq3dxLniHHdUkdP73OkwLxswd9vqpt1oBxnsNyBLI+hSPjYxYwjf9pXbTHLv6b+KwCh9jRs23UMHXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lQnLgtOL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=15fj5t9EBCZ5Augif8pGhVBuKDxtKPL0rSp0HPof3PA=; b=lQnLgtOLYC+sbFxynJrnHRNtbP
	P7YA7/+eM0M6VdcSWOt8nYEuC7ShVColGq+loCdNwIhWXLrw4NuC7qugqTjzndaPil0W5vv8CpcDE
	jMoAUnMIGXTYH6lZDCsiWsGe0XTLz/CyjlDyDvxbyOYdyIJuinxp1gl8XU2ZsAiow3/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp8HG-001r14-3g; Mon, 03 Mar 2025 17:04:22 +0100
Date: Mon, 3 Mar 2025 17:04:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 2/2] net: phy: tja11xx: enable PHY in sleep mode for
 TJA1102S
Message-ID: <a9987a37-1a04-44e6-a070-7b76f237cf43@lunn.ch>
References: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
 <20250303-tja1102s-support-v1-2-180e945396e0@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-tja1102s-support-v1-2-180e945396e0@liebherr.com>

On Mon, Mar 03, 2025 at 04:14:37PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Due to pin strapping the PHY maybe disabled per default. TJA1102 devices
> can be enabled by setting the PHY_EN bit. Support is provided for TJA1102S
> devices but can be easily added for TJA1102 too.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

