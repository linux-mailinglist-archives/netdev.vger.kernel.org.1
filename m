Return-Path: <netdev+bounces-187240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47087AA5E2D
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7CE1891CB2
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3722424E;
	Thu,  1 May 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lmcJ92Ru"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726581D54E2
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101795; cv=none; b=ZLgavtKViRUWRd+OJdXJUf5qBgmrRyIsUP+0Fx1gcSRGjwzh6UcPVBytpCSYKzpCr2HGZ/8nBRiX5nkmQvVNIWyBD0DaLxYl5KHtiJTtKV0x8PVXqj99vpL6U084FejJ1RVrJ/cYJHPxOprYHkN54gL86iTjeFEbHjFIiQ/JLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101795; c=relaxed/simple;
	bh=Tu1GDc4VnJFk9XDjHVOAha6sByjF8Q6HQj54xW9BrNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6HxjVdc/8wHvGCTSZRt01Kmh5NZOQOdmNIf0jmzlm7XunifU2/E3UL1EauMQ38EVER5iQB53SV8bYDyGMpx6R6Jb/N+wKBrMp2UtONtmZLisL5QVEy6uDLP5S7BS41Z7Peh8XeqXrq3g2BdHz2MvWX7qTMJ6tS9buIoY7nFC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lmcJ92Ru; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AzcmqTWiYWWPsLQK7fIAFID7YH7joj6uKn9KeMi97E0=; b=lmcJ92Rum2ysCJj/i2s3znt63E
	1GtXp5QE54AGszG20q5544djNWOtWfH72HRNIBEb6Q64YC/uHLf9KoCCgnLROjYRQ/KlKoeTJ3c3B
	E1xhrKpGQL2gDzXFAr++M+5YxSi3QYkCaacaT/+ZCeNUAQNKDITtWMspoPLB2Z6SH57w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uASq2-00BJLe-Aa; Thu, 01 May 2025 14:16:26 +0200
Date: Thu, 1 May 2025 14:16:26 +0200
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
Subject: Re: [PATCH net-next 6/6] net: stmmac: remove speed_mode_2500() method
Message-ID: <37ba2593-6b65-4ad4-98ff-41c2cf9b7f79@lunn.ch>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <E1uASM3-0021R3-2B@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uASM3-0021R3-2B@rmk-PC.armlinux.org.uk>

On Thu, May 01, 2025 at 12:45:27PM +0100, Russell King (Oracle) wrote:
> Remove the speed_mode_2500() platform method which is no longer used
> or necessary, being superseded by the more flexible get_interfaces()
> method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

