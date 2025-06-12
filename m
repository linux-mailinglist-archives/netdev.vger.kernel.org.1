Return-Path: <netdev+bounces-197060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EEAD76EB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E41888DEE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75861298CB1;
	Thu, 12 Jun 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TIMPOeB3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B6298981
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743233; cv=none; b=CWgGG6WeZr/9H8753SvhAgYzSGNLtv5e+4L8uITonL1/Qj1gUziIXBSweKm9ADBUmj4JYHbPp2GhbTTmI93q4LFNEZJu60Ir0D0D+ZnH0Iff1l4Pji03DN2CALUDpzCBo3o6flebbwd1SMQG80eWIuN+cXzVQZcpA06JcfPcPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743233; c=relaxed/simple;
	bh=W5CO22vReIOGjyDg8zfJ5WXC2CufwAKVPHAumh0+zXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMLkLG48udBKHZUw954iW24Bns9+pnVWwjmRUFMasiLDvoMpqYx5EZc6//+MuqhcZw3TDjOFLGlvG0XCKqj3n8Raa4O9xyFfTcUBioYf/01/oXcscov389hVUWgef55E/+Swq63UB3Xu5jDNGkd0GkbvsOmIcfq1WalGHObBknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TIMPOeB3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1+P+sojjLRcmgnA9DaQn0t78DpFrljTsKd9E6p6Gpww=; b=TIMPOeB3bSk5ZvSSmbNkej2lM+
	KzhtwYWgY9H0BOuBUYHfO1zutgGWdyBG5u2W26lEu+FavEFZpeBnnYJLn5+YVMWk/AkOxX5QQuME3
	hUAANh859OHjPPPSADGxoVNwaldlJaWjptlyFuNsDAQofkIT2y21xXvmA8QqR0JVqez4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPk8s-00FZ6s-DV; Thu, 12 Jun 2025 17:47:02 +0200
Date: Thu, 12 Jun 2025 17:47:02 +0200
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
Subject: Re: [PATCH net-next 2/9] net: stmmac: rk: simplify set_*_speed()
Message-ID: <52f1a387-9161-437f-a5b3-95c9308846bb@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk2o-004CFH-Q4@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk2o-004CFH-Q4@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:40:46PM +0100, Russell King (Oracle) wrote:
> Rather than having lots of regmap_write()s to the same register but
> with different values depending on the speed, reorganise the
> functions to use a local variable for the value, and then have one
> regmap_write() call to write it to the register. This reduces the
> amount of code and is a step towards further reducing the code size.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

