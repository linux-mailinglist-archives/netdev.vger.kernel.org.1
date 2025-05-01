Return-Path: <netdev+bounces-187236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69589AA5E1F
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D1F1BA4D1A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B3221DAE;
	Thu,  1 May 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FUJDWRTO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7334545
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101458; cv=none; b=kX58bDFXyqj5F9rC2XxD2Q0Z9NXbvAhrldUZSnaVTaxsH80hEC0UCpV8kwi6JnKMKjYaWlXuGLiZHiCiVQlGGq+HawGRB+uTMd7HBxLrTY1VKyPN3ARunOlJ9qMjvkOFqR+oBs4rbdctU6mWm0HXQ02eKmzkY1M0+2Y+nCpjegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101458; c=relaxed/simple;
	bh=ibrBE8S7bEg3Ru8Qb/2M/hfx+D7unnV5KvBTmhCHxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc+Auqpn/64GMn8F9BjKMH2hHGWVYSaVzj/YHImmLbrKRrPYxOcLYMK+JFwRz6QB2+0clHrHuONoqXAYUYBoVPwZqWeMjjBtVQ+KOmh2gUlN4FifY3o8s4vPNU0UFqyltG2U1zHmHsFoYukXFbVczGLFXA0fxwssiDNdj238ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FUJDWRTO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BY6VyFQTDqYBUiElrgJd+s84pkaJp8j2aD+P0x8/zg4=; b=FUJDWRTO8S4kvzxSLuXO7J+XFa
	Z2+1nDfhhE9omxTJoislt9CoErTl1SR020mtKVPqfGAd6HuvkzS6roi/ybX8PB7vfNlilhwX/b5bA
	zB1zSM199AbFiWeWrNkgQolvS9mj5CVbQC3vUhOfjkrMFKLXA+oId9BF0DZWYB9WSqnc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uASkU-00BJGW-1k; Thu, 01 May 2025 14:10:42 +0200
Date: Thu, 1 May 2025 14:10:42 +0200
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
Subject: Re: [PATCH net-next 1/6] net: stmmac: use a local variable for
 priv->phylink_config
Message-ID: <65321b68-ac8a-42b5-94e5-71732ad71d3c@lunn.ch>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <E1uASLd-0021QR-Cu@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uASLd-0021QR-Cu@rmk-PC.armlinux.org.uk>

On Thu, May 01, 2025 at 12:45:01PM +0100, Russell King (Oracle) wrote:
> Use a local variable for priv->phylink_config in stmmac_phy_setup()
> which makes the code a bit easier to read, allowing some lines to be
> merged.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

