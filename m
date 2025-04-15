Return-Path: <netdev+bounces-182897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF0A8A4C8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5937A5F5B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58DD29B20D;
	Tue, 15 Apr 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j5McAd8o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAF1E1E1C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736339; cv=none; b=g2oWoJh0g6KLTwKKsCU1CTyr21faePyw9R5uVPIJPSGgoT1a1G3ome4Dk23MAc0bJAirj0n82VcvZl0sAqHAHxYA3fdwaSYlN0dJJxVldTjFDQ9irDraJH1+iasmVVuozE9oFhDhn+QFSAF9/btrYtA8zgYg+IT1aOGaBfDzOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736339; c=relaxed/simple;
	bh=zYQG/gMfEXn8PxRTTI7ZT3MD1hgf985NNexSJSENi/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO3vP1bhTvYfCn5XAX04WPV+V47WV397VKcEbhwfHr+ZOym7agxiZ9IlLQyvWf2ozUDObOCKe19JU6EIqeKklrnIwlgHB5beZ8yZmaYaXE97+b557hWUH2sFYntuGbWqeOyVLt9YeQ0IGNYkZT0ilD56Ii4yg7R7rN+c+1kwI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j5McAd8o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3yDNLlIaCsPoNcTI2Eq8mEXgCwKrmdSj9j9g1YyQCMY=; b=j5McAd8oFKrJxA64MwIKJ4EALh
	ydc3qI7rgY9Nmjd22BtY1F15JsLY3EJE7Wo1aNQmPMlPTd/KALLh06wud7GpsCfIoTFYJVrjlEy8M
	/CXyBmj58IG2sVfsZpY3n3xOmeZV5EnqUN6Wp1EYR9XnBeJIvFFpRQnc91/Cq/KzCqEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4jcS-009UZf-NY; Tue, 15 Apr 2025 18:58:44 +0200
Date: Tue, 15 Apr 2025 18:58:44 +0200
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
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
Message-ID: <48bc68b6-d415-46ba-8192-5cbc4b8d263a@lunn.ch>
References: <E1u4jWi-000rJi-Rg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4jWi-000rJi-Rg@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 05:52:48PM +0100, Russell King (Oracle) wrote:
> Convert visconti to use the set_clk_tx_rate() method. By doing so,
> the GMAC control register will already have been updated (unlike with
> the fix_mac_speed() method) so this code can be removed while porting
> to the set_clk_tx_rate() method.
> 
> There is also no need for the spinlock, and has never been - neither
> fix_mac_speed() nor set_clk_tx_rate() can be called by more than one
> thread at a time, so the lock does nothing useful.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

