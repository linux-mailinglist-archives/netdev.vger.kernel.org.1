Return-Path: <netdev+bounces-210400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1BFB1317B
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785BF1897B77
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F21A2643;
	Sun, 27 Jul 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eLSaEq0J"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE92E36EC;
	Sun, 27 Jul 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753643776; cv=none; b=W7JFYNIIA6t9bx02ZHc7kf8GP1830ETwwIvthMmEPU/tF2sZQd74yxeFiQVOkFt36+cEgyw1eG5LpYtdY+g0Euh3duf+vSfGD96JyoemIS9RDhoitgZV4H9Ay/ZYQA3X3baREVS06fBjWp/zSa0dotOe1BwE9G0qQTmh/6u5RVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753643776; c=relaxed/simple;
	bh=DkmoMV2oxAuHVXFk4uPg+oprpG7tPjX0e31Nv5ysqwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHjqSW7YPN6s/BurwSLKgwlAY/QRpIy8YhiguaXTJ0k/doNw9cchzCBsiaOiuKyzhi3TmX4KEu5gRLDRUre5gIfYj8yk2FoWoNb7EjLMW6qHIVJ0nulEfb/coAb/escjmxZw4Vg7IVBhgLR0rbPG1THunEvOwcaZi0fYrHBOy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eLSaEq0J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w9NhXYJcH+yY6nJX1iUsIHJhpbBG7niwyYpMLRWPFrc=; b=eLSaEq0Jrz4esE4zAy9u21ruJf
	oXLyBz8ySedtBGAgdrfqENddXD4olmduDyjzQayWmSB4r/9pQYvNR0Xq2e4wXesnqM3m/uvArkiGL
	EFnKEtlSRCfOGwxJ/gTK+7RLEvrxOFWhWCLq4iCBTEDtg4G/VWxyzX941K/Dxzl9b8zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug6qn-0031Oc-2o; Sun, 27 Jul 2025 21:16:01 +0200
Date: Sun, 27 Jul 2025 21:16:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
Message-ID: <be508398-9188-4713-800a-4d2cd630d247@lunn.ch>
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727180305.381483-4-jonas@kwiboo.se>

On Sun, Jul 27, 2025 at 06:03:00PM +0000, Jonas Karlman wrote:
> The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
> and is connected using a fixed-link to GMAC1 on the RK3528 SoC.
> 
> Add an ethernet-switch node to describe the RTL8367RB-VB switch.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
> and only around ~1-2 Mbits/sec in the other direction.
> 
> The RK3528 hardware design guide recommends that timing between TXCLK
> and data is controlled by MAC, and timing between RXCLK and data is
> controlled by PHY.
> 
> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
> seem to resolve this speed issue, however dropping snps,tso seems to fix
> that issue.

It could well be that the Synopsis TSO code does not understand the
DSA headers. When it takes a big block to TCP data and segments it,
you need to have the DSA header on each segment. If it does not do
that, only the first segment has the DSA header, the switch is going
to be dropping all the other segments, causes TCP to do a lot of
retries.

> Unsure what is best here, should MAC or switch add the delays?

It should not matter. 2ns is 2ns...

	Andrew

