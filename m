Return-Path: <netdev+bounces-197059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37164AD7700
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B26C3A617E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B1298997;
	Thu, 12 Jun 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N6LsJfoA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAD298981
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743222; cv=none; b=RCjOFWYmdUZtu4enYvTFjpK3MxYi6ZKwKqT68p0wY11Us91fnyjN8K2P3Jszk2WoXwKJLZNn0O1IChth/T799ii7GohPJdQ78ovpC5t4Uz6l/VZbj3RbLxn9zVKkJHiobvPa6tN7c0KgJKjoWBs0JDYxto+RwtJnKtS+p2yUOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743222; c=relaxed/simple;
	bh=JIQiw7cy8I6q8JR+pt3u49lew3yVnFZbHBwL86usDXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtVINkdwD6xRuUaCGsI1uI86BBesD7v8ASVhT0IV9jcoEhuk2xWtX7azrpitZu0FxXXYXvKR+HorKloU6gpITaYphn+Z0HwFxMusa4qGSKxckNxMo179p4iV286l/klbQQN3QtBypSqZOq9+fGi2PCkhXaFfNe6b0N8t1LqVPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N6LsJfoA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u7FNp85AG+1u0PhdELLROSe+8g3+hVzoNaTi8mFP2BU=; b=N6LsJfoAuqu5t+Yb4U6MXGrLfr
	fiuBFzGJCTTlkPke4l4Y/Ak79p/Gs/brc5zSrxlN5aARjY4RbNk9HuYb1FfNV+3ZpeL1pDhDNQt8w
	j1UlF9yUCm0KezJh/nXgre/FrJL8MiVBIjf/m1GyyUNcdOBK9slkcw65o2lV6XazVYVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPk8i-00FZ60-KU; Thu, 12 Jun 2025 17:46:52 +0200
Date: Thu, 12 Jun 2025 17:46:52 +0200
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
Subject: Re: [PATCH net-next 1/9] net: stmmac: rk: add get_interfaces()
 implementation
Message-ID: <d1b624ed-0c9e-4cfa-a632-84430110a605@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk2j-004CF6-Mf@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk2j-004CF6-Mf@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:40:41PM +0100, Russell King (Oracle) wrote:
> RK platforms support RGMII and/or RMII depending on the SoC. Detect
> whether support for a SoC exists by whether the interface specific
> set_to functions have been populated, and set the appropriate bits in
> phylink's bitmap of interfaces.
> 
> This assumes all dwmac interfaces on a SoC have identical support,
> but it should be noted that this is not true for RK3528 which only
> supports RGMII on GMAC1. However, the existing code structure
> permits RGMII to be configured on GMAC0 without complaint, so
> preserve this behaviour even though it is incorrect to avoid
> functional change.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

