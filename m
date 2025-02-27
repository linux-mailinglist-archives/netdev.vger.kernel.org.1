Return-Path: <netdev+bounces-170271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09427A48067
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F313A2112
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D6214222;
	Thu, 27 Feb 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lgISJFit"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00421323B
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664947; cv=none; b=tokmgG5H7C0PvAZRMTVoPaTBOPnDEDNMvtlJemYd3X7ucTjBItWVLiCYN99xjv58rXr7axw/gFTUhiH9phfOvma235Zk9ZL1b+NPqmO7l4Gz52nQEro1YpbhxmOAPNri8WH4tEzb2wzA5QnXXV4cY4Oj8q50WtF/0QopCrByxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664947; c=relaxed/simple;
	bh=c6Ob7W5xSmYOdSk+FKVIEv/asNAKIzgQod4Ms9k4nKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBgmngLGO2NZoT5dg6NmaXP0tO86ATdb58A5Quk5/wRT7+dZDHWwFCwnILXdGaCnyTGSSCmXiZ2uOsA8BfP4Y4EJNSm9Gv6WzI5BsBPL+PhSuKeQAeEncJHbOFRpjlRwJGscSPAj4qMxvRy+2qBJq0tbnFoo3gn+sonH2TeV2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lgISJFit; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JXo/gwQcHIzjTzOx3CIOMAATJASGHIlvjB+ltGLd90w=; b=lgISJFitMArp1pyFbmmz7qXrym
	cYJMCGJZ1iOqhPso3y+jmxfwI6EQoFxD0MRfJZB76SC2Ejis7hJm6VZqIMjG2T0Yn4UyHAV/dUOOW
	CS9s2M1gaWN5QgTBiXR8S9HpbhqFMNck5XhhwHZr4Acg6ArJf6Z35H3YRJNwUNdlyegM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneSw-000bxn-0G; Thu, 27 Feb 2025 15:02:18 +0100
Date: Thu, 27 Feb 2025 15:02:17 +0100
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
Subject: Re: [PATCH net-next 08/11] net: stmmac: rk: switch to use
 set_clk_tx_rate() hook
Message-ID: <1e7b72d2-b2f1-4ec4-90ba-5b712edf8f0b@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0p-0052t8-Gn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0p-0052t8-Gn@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:59AM +0000, Russell King (Oracle) wrote:
> Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> manage the transmit clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

