Return-Path: <netdev+bounces-169185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D8A42D6A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0B51892E0E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6C209F41;
	Mon, 24 Feb 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H0oe1Vzn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0D207A3A
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427766; cv=none; b=jZfYgJeIJi1Wd+DaeP899bFuotbGtqRxvon+l2rn+6OdP7OtZQMYQLK7Und3t3RiRmAdNZQXCv035UYtAhwdo02CMxTdPdvqjGNyiDuD4gE+Xoynx2Pa43/lWBeM4qOdV3If4WvUUXfgN6eLzMeahX6mGjJnD0R5jWXN1w8/kM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427766; c=relaxed/simple;
	bh=v937hxY2x3FQ1W81T8XP5WNBq1w6GfDfxZYgXHbtEGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cac6BPJnRGpmJL6z5p5LvlYSI8G0IPDXJ/0x44i1vu3M3QoMj56aR47aD3AVMfOY/RTBcj2aI08W0Hv/J9fO8KpyxeBd2b17PmoUiwTbOEzd87cmDbsA1+USHDd0WawzFFC6eoudGQM7u2wSBTmGCxlED6O7TNuJGbSb45gjQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H0oe1Vzn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CIpOtzexZO/dRH67+AhOoCDsO/RGYxRqqj3n0timC8g=; b=H0oe1VznxZ+3gZ7FcXbrYJTeo7
	yxeBZIA8motT+W/P4u64SIUSjzce8cPrIyeQqmAkDzU9aBb/w9DMOFHMBL6avSS0mIeD4JzcQve2Y
	KFFOhpSctHVsh5mel5IYWbydPI8jcIUAJv/NxpnGfcc2X/4aHStGLZHtAQrdVzTUipAw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmelQ-00HHSc-4g; Mon, 24 Feb 2025 21:09:16 +0100
Date: Mon, 24 Feb 2025 21:09:16 +0100
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
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <aa8e3e8a-0999-471a-826b-c1b5886866e1@lunn.ch>
References: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
 <E1tmbhj-004vSz-Pt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tmbhj-004vSz-Pt@rmk-PC.armlinux.org.uk>

On Mon, Feb 24, 2025 at 04:53:15PM +0000, Russell King (Oracle) wrote:
> Clean up the clock initialisation by providing a helper to find a
> named clock in the bulk clocks, and provide the name of the stmmac
> clock in match data so we can locate the stmmac clock in generic
> code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

