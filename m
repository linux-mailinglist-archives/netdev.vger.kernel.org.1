Return-Path: <netdev+bounces-169183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA7A42D5C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6E917747A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75362063F6;
	Mon, 24 Feb 2025 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v29w+S9c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0F157A48
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427612; cv=none; b=j3MDglaLsU0TPzUcEU3gW4F+AIsPlzZE2x3uUEKu4Zp3jUf4sDTkKeO0Lu2xhKcgeKoZU6Z/cEMGDzrgG44TcVeSJLc2IZKZR1cDvxNLzQvioS2sHrOrWxzFeDFSfv3RCCzFIzw9bzNiqBCSQPOW5lRW7DFHPiXbGZHN217w/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427612; c=relaxed/simple;
	bh=OsBHEXoPEcmMQVxveoiBpDwYWqEwuqIVfJlZd32UiiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuAmQz5Y8EZQPqkPuXYj3mPqDx5Lbxyvueb3zZFOWpMjj9zeA+QeKj2b4TOIqyo4aTPaWHtwlBM4LVzLgcHaM7+UG9essRfmYsJvi3kvhI92wMWm8Mb7p7ZItgHBLOUyWlCIsDtUU8dWJuzd/UlNFwVOcbVRivVDFhfMAxP7m3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v29w+S9c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3T0QWPecLBFnadrKf6BCnAp07nURn0bZOEsXJOfVBWw=; b=v29w+S9ch4+ninnLpX1RhMEKjs
	xLgTRZ6xmzNttYmKiCwJhalnT6ZJpAeN2B2z6HP3JchZ8WbxbjQJaEFZF8OYfW+LWvzAyvpfFs4Ho
	rHQUTiBgU7GJVOclEWEGMFFIJBNxgo1o+aWn81bbPPJsgwyFO3O579WdX28cFdDnxmRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmeiw-00HHO7-NE; Mon, 24 Feb 2025 21:06:42 +0100
Date: Mon, 24 Feb 2025 21:06:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: thead: ensure divisor gives
 proper rate
Message-ID: <57036dad-d9b8-4f06-8083-af7ed8c42035@lunn.ch>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
 <E1tlToD-004W3g-HB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tlToD-004W3g-HB@rmk-PC.armlinux.org.uk>

On Fri, Feb 21, 2025 at 02:15:17PM +0000, Russell King (Oracle) wrote:
> thead was checking that the stmmac_clk rate was a multiple of the
> RGMII rates for 1G and 100M, but didn't check for 10M. Rather than
> use this with hard-coded speeds, check that the calculated divisor
> gives the required rate by multplying the transmit clock rate back
> up to the stmmac clock rate and checking that it agrees.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

