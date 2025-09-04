Return-Path: <netdev+bounces-220075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BBB445F6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD598188C25B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA212641EE;
	Thu,  4 Sep 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a1rNGZzo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA12586C8
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012334; cv=none; b=RrXomiUPMooCRVOaZthCU1E6RGro5HW8MFHJanJgJgvoH3ntrCnGqu5TEBPIJc1czTR/m5PUYR05EOKzq0Sbm1555f9HRfCs8pnqIJpPgXyhOF9JVoRzCXh0QmiXlj0WzQPKHuZXZNiOkU6ZxRJbr+UJbCXVwJiWJHTpJMSrHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012334; c=relaxed/simple;
	bh=XXempzrcMvneuwnKeRtkjXxBA00Ztzp24C+0k3w+73o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv20diKv2hb9QHnjHTEspTCB4pUjavdTGXAD/JOx7r7jYIkNvz2FJZ4wsrCOqvdDzB4GjEBfbSyolylUoKHBa0vJVwf9z51w+pwwmNZrX+wUwYGzltgnTwwukoCviV1XoZIDNnWb1EXHy6ZE56NMAZDA0MsbfaMH0ZoQ7PkkTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a1rNGZzo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rxc+WFScWaMWMshrOaUEfaLNiPNmyIGxiIMV1CB7UL8=; b=a1rNGZzoQR5nHNAhRMsWPrO4Ep
	zsM6tGyCruRbEEuRXTz01MC43O6E43UJ9qJDbLLboGM+/+hIMKfpC3QRtONnpxfls5QaLXaDBcLBD
	5so+8jsQGED0VK32X6QJV5sY5biwZTVsaiKtJLkqehdWBoRky26DFOXgR+1WWuBKqkhU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFAT-007G48-9D; Thu, 04 Sep 2025 20:58:45 +0200
Date: Thu, 4 Sep 2025 20:58:45 +0200
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
Subject: Re: [PATCH net-next v2 04/11] net: stmmac: mdio: move
 stmmac_mdio_format_addr() into read/write
Message-ID: <3e15839e-5bce-496c-82c0-9ac95cbd9b79@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8o7-00000001vom-1pN8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8o7-00000001vom-1pN8@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:15PM +0100, Russell King (Oracle) wrote:
> Move stmmac_mdio_format_addr() into stmmac_mdio_read() and
> stmmac_mdio_write().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

