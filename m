Return-Path: <netdev+bounces-176465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5DA6A704
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A824624A0
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A71DF97F;
	Thu, 20 Mar 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NfN6pSB9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5502AE99;
	Thu, 20 Mar 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476839; cv=none; b=PJGsuCYdKsc3amsoswGblkk/FvwIEweesrAG7jiTYlLaGPkESgUlSglE4ZpvrojSRAaaBXgt16RCSnKTCJMuQcH/1VdVBdSHca89sZwlYXGp9GA3rfkvkGsSqxj8D4wRJ0x3z2J3refb4pguORqU9GeI6v2GWbaCXcpo65GJF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476839; c=relaxed/simple;
	bh=s+5inRnnJWyj20LEfi2ebATkXnpn5nPdD5sUgf/YnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chIGCjS/8stNk3/esoYczvHYS9IrGCePIe2/6Bq9vBMu9wtKDqvMP8tqO7+S92egyYh0crX0JSUga+V5+QQJJfOBioDqnyYye4CO4XNpu9slJyMul1nHT0AxnGXxntjplrB3N++u8/xjGe7h9uRwJXCCU3pzUGWyv30GDvqAqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NfN6pSB9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aRlSKlwPjz5OfI49MqhNhAWG0xXIoHSGK59j5+5+Zr4=; b=NfN6pSB9tndSEmbKrcEDWBQ7VE
	a3rhcdRX6VShAnN3x/dbyLefD+8TJqkLDiXi5d6YzibV36IF2c6QJjdbn+vRxdiDdMqkzE57BAKxH
	SFkwOeDkzh09nnY8wLo63xOnVyl95cGmwf0YSSaPHNK8nI2jvVhqMZh7j38ODwYQjyBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvFot-006TkK-9J; Thu, 20 Mar 2025 14:20:23 +0100
Date: Thu, 20 Mar 2025 14:20:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 5/5] net: stmmac: dwmac-rk: Add initial
 support for RK3528 integrated PHY
Message-ID: <b918b36e-e4d8-48a6-bac8-6aacafe129b6@lunn.ch>
References: <20250319214415.3086027-1-jonas@kwiboo.se>
 <20250319214415.3086027-6-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319214415.3086027-6-jonas@kwiboo.se>

On Wed, Mar 19, 2025 at 09:44:09PM +0000, Jonas Karlman wrote:
> Rockchip RK3528 (and RV1106) has a different integrated PHY compared to
> the integrated PHY on RK3228/RK3328. Current powerup/down operation is
> not compatible with the integrated PHY found in these newer SoCs.
> 
> Add operations to powerup/down the integrated PHY found in RK3528.
> Use helpers that can be used by other GMAC variants in the future.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

