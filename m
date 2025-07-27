Return-Path: <netdev+bounces-210409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A328AB13230
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ACB1892E71
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B682417F0;
	Sun, 27 Jul 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a3JWWBbg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6AA93D;
	Sun, 27 Jul 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753654214; cv=none; b=YbqajX0d5imikimqzTV3S20ndoiV1FjeGNsVx+cEmJqQ8y+cMTNPCEnJNXvHHdL2f8kVoCApcbwqxLUw9SPhFXdMsIE5IUN9A17RYq5a4fVz4s8kFq26ywWZ28rpVb7WYpr9jY2tReMSe8lsAHmhDFVQui4nfATMPRWcY+mgc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753654214; c=relaxed/simple;
	bh=3kyG1IazvV/8Ec/Gj7W75f8I8wq+hLT89q5Ubaeyhp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nww00t7Uid2IZRAiTlxcVHZg+7Rbfy3sd3yk7vloTYWbjqQHBwt0GnAdLVsQ+TcrJ9/Ynf++AjkoLAo5clLrdfK1fobolMolP/3YRFgb/FN2r24AyQjqA6vDTWXHU4c1Vh6Ul2yARK9QA5hsXamSPAyaKBPWsWsjZsGnh3IQ7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a3JWWBbg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t/jnNvXwMwP/wlxBr4uBLC+uY9MAFOThnol22yK/3c8=; b=a3JWWBbg9YFowWswUBsk6pUvX3
	Rh4dPuNeU9H5G40l+UPMxX00OBxVa3l9v4CiBzUGLb93SYCbfPUecKsarml8MMQT9W7QZxzC+KgCv
	Ab9aWaBJCc8YLWUEXDhdfAIQuMwCNpV+U7Q/RvZ+q52cuWMKzmOFh9HsSZAG1JAUGlwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug9Yw-0031rJ-Aq; Mon, 28 Jul 2025 00:09:46 +0200
Date: Mon, 28 Jul 2025 00:09:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of
 an optional mdio node
Message-ID: <9702f3da-f755-4392-bf2b-28814ee0a8c7@lunn.ch>
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
 <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
 <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>

> Something like above does not seem to work, I get following:
> 
>   mdio_bus stmmac-0: MDIO device at address 0 is missing.
>   mdio_bus stmmac-0: MDIO device at address 1 is missing.
>   mdio_bus stmmac-0: MDIO device at address 2 is missing.
>   mdio_bus stmmac-0: MDIO device at address 3 is missing.

O.K, So i was wrong.

> And without an explicit 'mdio' child node the driver currently fails to
> load and the switch is never registered:
> 
>   rtl8365mb-mdio stmmac-0:1d: found an RTL8367RB-VB switch
>   rtl8365mb-mdio stmmac-0:1d: no MDIO bus node
>   rtl8365mb-mdio stmmac-0:1d: could not set up MDIO bus
>   rtl8365mb-mdio stmmac-0:1d: error -ENODEV: unable to register switch

So, not having an MDIO node was a long time ago seen as a short cut
for when there was a clear 1:1 mapping between port number and PHY bus
address. It still works, but it is somewhat deprecated. It also seems
like it is become more normal to need additional properties, like what
interrupt the PHY is using, the LEDs it has, etc.

> 
> With a 'mdio' child node 'make CHECK_DTBS=y' report something like:
> 
>   rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
>         from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#
> 
> So something should probably be changed, the driver, dt-bindings or
> possible both.

I think you should allow an MDIO node in DT. This is the only DSA
driver that i know of which does not allow it.

	Andrew

