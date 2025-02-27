Return-Path: <netdev+bounces-170270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53942A48071
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9F01887279
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43D1E7C12;
	Thu, 27 Feb 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jFuaSenf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143B14B950;
	Thu, 27 Feb 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664906; cv=none; b=OcADP3pxCVUdZlSDYODHnqLqBQ1GDcYmTSIXBSNCyj8MnWnAzo7L6+AF2JvpTVgFtY+T1p4++yhL+WHdeTsDRQL4g4CBPSNVSATbznzUa6kZDZcJ58s+ixGP3CZB0iZrqhW20xnFDvARt2Xqg26fa9CvohojdZDJE4r4Ro7y6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664906; c=relaxed/simple;
	bh=g3YZ6f7bx1/7Yfl44NhYE9+t7VQTj4wLsri2zPsrpCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADv+/VBz8fDSuBGk59sCGoi1Wf7tSZZLGGurBeM4idLlkwufwj+MCWqxX8VQ0ZFUuB1bEJrSAA+udSY8kGtUNGquIqZTO9PN/w4YA1Ng7wOf/RIcXv+0CQKQrXXlejXy3ZfYPsAut0hh2VksEMg62QZxW6IfXxB36lDCIssG06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jFuaSenf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xgAg3JM8CZiG7u98pcAWeS5QXuN+a22FjBOlCQaI+Jw=; b=jFuaSenfpj6WCde/Q2Qj7OSPzm
	slERq0tCjrkrPTNXzIAr9WcQ1AbRe83M7fZ1D/8YzX3nJ8Xn2eiDqUJb/u4diLA4ATgUX0j5dDUyw
	q8wlboTqUtnToAhroOwm3KGv+RTLMW+aioBayBs1Cb9r5TAt1oUdUS45rpB53/h4Sywk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneSJ-000bwl-NJ; Thu, 27 Feb 2025 15:01:39 +0100
Date: Thu, 27 Feb 2025 15:01:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 07/11] net: stmmac: imx: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <021f1ba7-739d-403e-960e-f0b0363f0f28@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0k-0052t2-Cc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0k-0052t2-Cc@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:54AM +0000, Russell King (Oracle) wrote:
> Convert non-i.MX93 users to use the generic stmmac_set_clk_tx_rate() to
> configure the MAC transmit clock rate.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

