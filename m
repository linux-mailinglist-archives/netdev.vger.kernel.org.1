Return-Path: <netdev+bounces-198325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDDADBDAC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468A4175B8D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A302264A4;
	Mon, 16 Jun 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4K/Qv6b1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4B2163B2
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116861; cv=none; b=icMfdG0d2vKCORbbxNigzGmj78KQeyuA6r/zEH+WHeEP55nFOm73nWLVprvdhIRdU4qXgxusf3M2JxQ01KEOQZfPWK/MQe62i9Yia6NEHupEAmrpX5l+/z2ELAaZCrD381gKmo6HD3loB+r2mv+o3SA2dLCbEZRSgEz8UWeoK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116861; c=relaxed/simple;
	bh=G2jNNENMvxxxt979xS958u5QrXauhEJJM5kjaBw6DJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbs+WbqQSZJv9wDsdJTJHH6NQ4lb/Wl9JCklK4LFS3+wXNI5DPTT2n9vmGAoCdhhhJ09TUXtub2oQTBNncQQh+tqZAVLzNGI93aOE2N2yaxQzwilLz8y8cwgnRTftkfIR/bl7HpwZph8V9cA4Dcu8z+UwKq0S4M1sHpS8/obI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4K/Qv6b1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BePOfiT7npLQIY5e20eiRynStUObeSDrh0xh71pFI4w=; b=4K/Qv6b1b3GEbTeV2sQRtrnU2V
	eEsya342v4+qD6FVDHNiwm0z4u8w3j8k5VDSO4wK4gTr7WJDqas1z9HDgeeM21RJS3BrKJTbs9xzw
	CZevoSDzGj6ja+r01OJXsEu3vU82AI+5/2sZZQLnMfQfzyB2rxS18K+hqnGrRsyT0IeY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJL6-00G6SN-VL; Tue, 17 Jun 2025 01:34:08 +0200
Date: Tue, 17 Jun 2025 01:34:08 +0200
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
Subject: Re: [PATCH net-next 2/4] net: stmmac: visconti: reorganise
 visconti_eth_set_clk_tx_rate()
Message-ID: <48941356-d75a-4fca-88c9-c5925d79a993@lunn.ch>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
 <E1uRH26-004UyM-9G@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uRH26-004UyM-9G@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 10:06:22PM +0100, Russell King (Oracle) wrote:
> Rather than testing dwmac->phy_intf_sel several times for the same
> values in this function, group the code together. The only part
> which was common was stopping the internal clock before programming
> the clock setting.
> 
> This further improves the readability of this function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

