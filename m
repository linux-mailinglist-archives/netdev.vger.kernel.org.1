Return-Path: <netdev+bounces-220073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A533B445E5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0E561F5A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86939267F59;
	Thu,  4 Sep 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SL9h4ZKK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED106244670
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012196; cv=none; b=HGaXvkT4Tye3i6tb6hiNV9sZ60GpXrc30tvdxbSE7lhNJjy7o+tJ7KHIAJGCSFZ3wR0K9W2wWEbYiA1C7SX3xtGE0NOU/rotxFNqsBKYn+uI8VnYndwBAQbfP/bak70scwTisi4vtEbxwiNHSFx4ELIGb6wogjrpKQeNWywbqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012196; c=relaxed/simple;
	bh=Z2HR1EekC5f6R/MZNQSxkFBrs7/hvTg3rEKSOejUgbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kscEn2FTiSqhE/XaCbzB9N7MWwSt6xdcTM4vPv0raalKJrWvOXmS9qEXWO7Bz3tRLd4LSD+ecWfttJTLs63Ljjqkh/wdPh5BXjXA0JqktlXHOxadq2sFn0x2hWNfwiqeB7DJ6N1sbMDP+XRoKUmBxY+MN/e6c4xJX3fe2gZS1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SL9h4ZKK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hZcXvnUxZ9WwZU+v3rNVmIX53fawzGgpE8MkePJBJ50=; b=SL9h4ZKKlQ3xcdvwGycKclzwYP
	eXRa2gzUfRoxgMtfbuMQy9QapsvIi4+yFgm1dVpPOzC+pmC1okGHpzld7OLOcT04khq45kb5HEosm
	EsZm4ZSOQk0HLd7/4yk5cGq5CybH0CoOKxfWM3zUcEk7pJi7DRZWcxjevSj48cQN7rZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuF8E-007G1C-Ti; Thu, 04 Sep 2025 20:56:26 +0200
Date: Thu, 4 Sep 2025 20:56:26 +0200
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
Subject: Re: [PATCH net-next v2 02/11] net: stmmac: mdio: provide
 stmmac_mdio_wait()
Message-ID: <f95b34b6-2c58-4263-bc4f-cc604e928c66@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8nx-00000001voa-0tJ0@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8nx-00000001voa-0tJ0@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:05PM +0100, Russell King (Oracle) wrote:
> All the readl_poll_timeout()s follow the same pattern - test a register
> for a bit being clear every 100us, and timeout after 10ms returning
> -EBUSY. Wrap this up into a function to avoid duplicating this.
> 
> This slightly changes the return value for stmmac_mdio_write() if the
> second readl_poll_timeout() fails - rather than returning -ETIMEDOUT
> we return -EBUSY matching the stmmac_mdio_read() behaviour.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

