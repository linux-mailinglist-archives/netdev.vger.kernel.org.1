Return-Path: <netdev+bounces-155966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF6A0467E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB50B3A1124
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74C1F12E9;
	Tue,  7 Jan 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xdTmUK86"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088A74059
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267671; cv=none; b=IDDhfClok5LSa31uDUlEunK2rO8D3YDiw+0hkSv0YVT2vMR5eF8/dTlsxN2KbDnPwP5/THcQd4lLNResTZII9q5W+RPr9Y7No/2jEAK0IkF8bAa8vkJKzxiZuZ7A9cxgLn1fgUMpYmsG4KJLYug+bM4KNhOAFyHU/t2fK3Z1HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267671; c=relaxed/simple;
	bh=5pkmWXsWIQRkEOBiVDswUrb3llqk2rGKK0bQ6eYBe0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB74R9nlpxtLnGL9vuN9Dr1xljYpYwxKWK2cogLg34kCG9MAn6qqoqd3pMDdkZ04YavKF2c5dB/DQspBxnCBFmTtMZrVvwTZjmZq88kJrO6WgBm/8Gq9YkYGZ0LkpiFU2WCdhOalWcTWhDb9gaqbMUimPb7e7Q6+3+nEL/39ycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xdTmUK86; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dW89n42NmkpEIRJUxQQno3eIDg8+CSGSrGgZHeTnpZo=; b=xdTmUK86AuLgBEOEBUTvAmAlUS
	4hvp7u8bGFejhTcWLPu+4flofsd5I/4UF7vfEmaZ+xN789xk38q6zobdEC/ZyycSIZ2GWN+fxzHWJ
	yRS2PNIjrS7uInj/vcMppd2eCmcX6p9xpExcZg9fPYkiIuh4x1FeLy1v+7Vr9BaGKJbyVY/pHVP/H
	4hUkduFB2Ik5nsbO5xvemxojrWYvRoHBi20zT0vNJcuf78Vczy3mN5tjq3F8Lzj+YupAh5WgIOxb0
	1DSSFsCyjEfvznhijkpj/9OxrwfRrS8lTiVZiTYWK9tXJtMebuyxtkOx50D0Dked4yj8gm0/t1Qm8
	97f2+Tog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVCX3-0007qV-0K;
	Tue, 07 Jan 2025 16:34:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVCX0-0005R5-28;
	Tue, 07 Jan 2025 16:34:14 +0000
Date: Tue, 7 Jan 2025 16:34:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/17] net: stmmac: use correct type for
 tx_lpi_timer
Message-ID: <Z31XhoshqSd-a6pS@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
 <0cf7eacd-6834-47d8-b370-cac5a7395d44@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf7eacd-6834-47d8-b370-cac5a7395d44@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 06, 2025 at 05:45:37PM +0100, Andrew Lunn wrote:
> On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> > The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> > Use u32 to store this internally within stmmac rather than "int"
> > which could misinterpret large values.
> > 
> > Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> > should be unsigned to avoid a negative number being interpreted as a
> > very large positive number.
> > 
> > Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> > rather than int, which is derived from tx_lpi_timer, even though
> > masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> > value argument type for writel().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

FYI, because of splitting this patch, I've dropped your r-b when
posting v3.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

