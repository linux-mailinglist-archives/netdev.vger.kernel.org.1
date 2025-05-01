Return-Path: <netdev+bounces-187237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27EAA5E21
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D49B464D25
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF09221DAE;
	Thu,  1 May 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vyd34Keu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8333086
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101499; cv=none; b=Bg0m5g7WT6yc9nWjT498VNwP+coiYUHrZQxdNuPVAWbonv07GpNFO51ukImH4H0XBb0b12cbNyekkCv/wAvK6HoXyXS5OuQyvW+sDKfA0c2/zlH1jndv7xYJLzCw8+IvuTXR9oK1TijUL9iBYDJjoJfSzjVGkvaVOo0ARHQ5I1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101499; c=relaxed/simple;
	bh=qh9UVNNA0hF2anXLQASMstuwKRy7JMegIc5MfWPmRpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw1qMDAT5C4HzZkRKj83ZEyJMkMTKij8HL9K4+lJ4AuhEOHf/aEi50bkssWwxmfNonW29qcdOr1RqCVKXcPoWumiTfEGohrsi8o2jJpu2HqabN2Tt4ZqXel/Sq3c86wbqob1jxp/4Xol7w8zx7CRBvn93HnM/IusQpmSltStts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vyd34Keu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f0Uj9ZZUL+FKVpqLFNOIr8Jb3Mu6vK8+69E20t3mLDQ=; b=vyd34KeuDfKZKBmjTPsUEGaLgs
	KX8GXjMKdLgMuTiNrHiI3GIfh/Cnd1ebe6C0f9tPOYXOumnGjUtYOi0Yb+jo8xyDAsDzbdk+wf/58
	1HQ4/N2ZfHoeVNopeaSsHr3AKb8g2A/aQfYF6DPbjZHmx9VOPvYnLqxoHkcOvGLp13FM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uASlE-00BJHP-Hm; Thu, 01 May 2025 14:11:28 +0200
Date: Thu, 1 May 2025 14:11:28 +0200
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
Subject: Re: [PATCH net-next 2/6] net: stmmac: use priv->plat->phy_interface
 directly
Message-ID: <9149286b-0959-420f-9b37-d693a8836028@lunn.ch>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <E1uASLi-0021QX-HG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uASLi-0021QX-HG@rmk-PC.armlinux.org.uk>

On Thu, May 01, 2025 at 12:45:06PM +0100, Russell King (Oracle) wrote:
> Avoid using a local variable for priv->plat->phy_interface as this
> may be modified in the .get_interfaces() method added in a future
> commit.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

