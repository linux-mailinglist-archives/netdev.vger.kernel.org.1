Return-Path: <netdev+bounces-170276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67589A4807E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9133B7E54
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B575232792;
	Thu, 27 Feb 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KUbLhr+V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B252356BF
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664976; cv=none; b=bDLtpNbXFFCXF9Xaum0DGoxUSe0THmMe1LnrxefudFYjZJ2Izd3UzdlOPs9T7HxDz/AEjNwRaJBv0teszT3WWSo+IhsHPjWbN3upu09zdDxJvBBb/JFJHi4aQprJmhI1zm+HY8VhV0XyTuDJYFcqVuil52gxzOX+bWcqDK9XVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664976; c=relaxed/simple;
	bh=RYU8S5nd1jBfNB8WmEsJuS2nbav+R4Jn0dFBQ9TeQDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbpXtnXBG4iqvgeLJqynijsslRtLF6p4uPC4eCxUycSAa3EOVXNGt6q5faAHOmwEukM/QZBJJTn0/Cdr/bVhRpWnm3VV06FuzppAmd5PKeIVfYiXs92Gk60R5qlGyAjPvEId0WmdVJTKAUzba6pkpEkR39qyYfPxVK6qjxXiYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KUbLhr+V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ScUAY0cVN3AiCj1Pv3Q9M56FbP0eZiiumkcl17a6prk=; b=KUbLhr+V4K7WYfSP7M+gQiKTwC
	B0QXrCN1ruVMwYesbOVb1+GeRTGWR6/lgCs1sf/TsC5IyvAKulZNOBqv/2SnnGigAeMljOpf0NRb1
	Aa5LMcaM3jIqrAsYXJA2udZ7IwG6PQm2zYW7jb15ig+TxArIULFgduSH72qnzIvYwFTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneTO-000bzh-0J; Thu, 27 Feb 2025 15:02:46 +0100
Date: Thu, 27 Feb 2025 15:02:45 +0100
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
Subject: Re: [PATCH net-next 09/11] net: stmmac: ipq806x: switch to use
 set_clk_tx_rate() hook
Message-ID: <4f3b032c-6a29-42f3-a72b-c6c6c57fd2c8@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0u-0052tH-KQ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0u-0052tH-KQ@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:17:04AM +0000, Russell King (Oracle) wrote:
61;7803;1c> Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> manage the transmit clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

