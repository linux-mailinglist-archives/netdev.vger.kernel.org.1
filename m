Return-Path: <netdev+bounces-176359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2EA69D44
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 01:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98358462255
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CA78F20;
	Thu, 20 Mar 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I+zwFf7l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2E53363;
	Thu, 20 Mar 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430487; cv=none; b=KhYdVhbIZpf9CKfPPcA6RKf1Mjk5ko1loNVrkgfhsAywKpZYX/l+uIaYMKLMcBx1OIxEsv/EEF3QKxwOutoKRvJls6JzFYS1tHjpIELBR+YYUHBrJEepYJoOjZi+T0f726u+LwaY3iyBTBCZbHDMXXiAs48g69+g3/+QFmbbED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430487; c=relaxed/simple;
	bh=Nq/FnDJMZtmSZEJcV8gnGJl0ViwQpBphhoUgrCb2jQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odHYi+uSmN3gjN//khbOiXdwWKoXzaN9KRTiHAp4NA6Aw5LIDeCQCaQ5/mExp2i34694thEAyJgKtdX8/w/cgknBsIclSnMJuz/CR5LwPnoUq0f6vd+muuAvK1oQUwqJQyzSWGPATyRNHB2yMhdrHESLL7D8qiDNdhjrehrJJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I+zwFf7l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QZ8+kxRgHxsg9Lq20FwRg26DNXtx0z83Ab3cGQEjgIQ=; b=I+zwFf7lk9fa4q2LzhSi0cKayA
	6thWCCbUK6nO0b9AVz/GbEbotAhUMSOaXR23IemJpeyeF4BIMaKNq2bl7ycE5P/lgrlpSD8zWC+jJ
	7dZQ4y80OOdRKTUc67fOO3pt+DI43qSdai/4uTj8Eli3g0AT7O+XpI8Cnix3ghC19Tsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tv3lA-006Qcw-CG; Thu, 20 Mar 2025 01:27:44 +0100
Date: Thu, 20 Mar 2025 01:27:44 +0100
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
Message-ID: <ab58c128-f598-4586-a912-0d6128934fcc@lunn.ch>
References: <20250319214415.3086027-1-jonas@kwiboo.se>
 <20250319214415.3086027-6-jonas@kwiboo.se>
 <d53a2119-2650-4a87-af94-1b9c2297cf72@lunn.ch>
 <eabc0fb8-10cc-465c-9434-b0804418dcb6@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabc0fb8-10cc-465c-9434-b0804418dcb6@kwiboo.se>

>   #define RK630_PHY_ID				0x00441400

O.K. different which is good.

>   /*
>    * Fixed address:
>    * Addr: 1 --- RK630@S40
>    *       2 --- RV1106@T22
>    */
>   #define PHY_ADDR_S40				1
>   #define PHY_ADDR_T22				2
> 
> [1] https://lore.kernel.org/all/20250310001254.1516138-2-jonas@kwiboo.se/
> [2] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5/drivers/net/phy/rk630phy.c

The vendor driver is going to need some cleanup before you post it....

    Andrew

