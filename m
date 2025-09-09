Return-Path: <netdev+bounces-221321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD50B50248
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22D97B1559
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7CA33472A;
	Tue,  9 Sep 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yFYNWH5i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FA273D92
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434577; cv=none; b=IqEwipAa3z9hmGrd2b2Z3tydD8Q7mJqn5dwKukqQL5Dm1t/Nbf1sTdHHc4sUbw2G81RtUikI5/nIPuhhfIjuFVcWmMnjxfaWxeZ3QN7yCmHFWP8ryyR79yyzu7Om0i0SRiU1j8zCXYS+OUQxLJ3+QpWSHyeBPaIWvM2r8adqSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434577; c=relaxed/simple;
	bh=QPByW1KMLroKILRR3SWWH+ap1Alq5hpjxKJNw0Pe4PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNCMRW6xvHIFwyPXdd0j7zaTrphy+Z915BRPgo4935m2PNS/wiK4LVCz7P6FCwU484UJCSy1Hn+qJY43SMyt6s8sWJMFT5yu8KUQWXX8dIiqh+Oes615qICuVqzj9LOf0oBshuxNeBp8cpHlIGaY7sirWpZjbMsgSqJfsZibSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yFYNWH5i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rVN6e9/gMIu0hHHQf3JvYRaMhSi/eSM2Lfync7IeAQQ=; b=yFYNWH5iwzs0JKw/mdBpnsuOtj
	8Z29eY8pDLH4SvwUR8ENLWzW4aL2f/wHvAq3ZH5jHZrq0bdq7V+eeEowZhAAp/83CT2NeUsOASmnR
	/etpnhjiRIus+3Bl4Nv1h0DkycxGTwuLfLtZrXqYEoadHSDmMNaN0XAPuA1Bv3r6R/5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw10m-007ow0-MI; Tue, 09 Sep 2025 18:16:04 +0200
Date: Tue, 9 Sep 2025 18:16:04 +0200
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
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: use PHY WoL
Message-ID: <5bf7489f-1256-4c22-8c8f-f1aa32eae810@lunn.ch>
References: <E1uw0ff-00000004IQJ-3AMp@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uw0ff-00000004IQJ-3AMp@rmk-PC.armlinux.org.uk>

On Tue, Sep 09, 2025 at 04:54:15PM +0100, Russell King (Oracle) wrote:
> Mark Tegra platforms to use PHY's wake-on-Lan capabilities rather than
> the stmmac wake-on-Lan.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

