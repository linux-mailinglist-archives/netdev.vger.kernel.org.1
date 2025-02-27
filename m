Return-Path: <netdev+bounces-170267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95FA48089
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DED164120
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B82231A3F;
	Thu, 27 Feb 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xw3EMLPy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B422309AF
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664800; cv=none; b=MCH/y++AmRwU1CFZpkMtfszJZVqp2gwqWV0sqqm+3c8N1G48P43X9ciJQ76Z45NLTvjZI5UccO4ZW/TRf0ZRSSIAGbG4MDkg515OdX8eeJiid2t6GCmO9Uz1YFvTo4q8xbBxLX4YsJDBxEeyeo/XeK+O5jhmopqgu+xVZ9w7PC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664800; c=relaxed/simple;
	bh=YiW4WPE9abTWOj4wbua9K/wLjzFtkOu8bVs9lj4YC8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFvv24mD+PWAuMyQcm6Tka7MgclA6zaFdbX+eLiW6BkD2V3sITEHATbwO1ha43MY5s+khw7PwV6OfDAWCrRAcMYx+wMEbhfd4hHHmc7lugMh/P8qeSB5rqeT2pzjhGDqt+qR7bQLLToZ/ODDfvEeOEveMfSqzqAOQ2/NtaWwLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xw3EMLPy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PnsVUwZvLtZEZe84Ekk1jKFmKSz1fM8ls2BhK6vT+ys=; b=xw3EMLPy1GGXcjd7EVpv0sio7Q
	2cStZWCMmg8+9ADM12w+gVPULhWf+j+zWgt+PiGk73ncIo/d6Hb8P+88+NjOj+93LnZpGdpf5hXLR
	WUEI/Er49qDzUbvQ+xq1tvuT92bTGu5weALXt/nJ5Fb/KJpf1TrbSvMvh1yNoCgSDKv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneQT-000bsO-4n; Thu, 27 Feb 2025 14:59:45 +0100
Date: Thu, 27 Feb 2025 14:59:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 04/11] net: stmmac: starfive: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <8bbdbad8-b6cb-4ef4-ae32-0661d85aa412@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0V-0052sk-1L@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0V-0052sk-1L@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:39AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

