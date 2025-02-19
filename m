Return-Path: <netdev+bounces-167775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67CA3C395
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEAF173AB1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3001F4608;
	Wed, 19 Feb 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HKtUq0ZO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8B1F4176;
	Wed, 19 Feb 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978795; cv=none; b=jOmHIHq/gqC4R/Km7UB5AJDMl1Ys6bZlBiHPGv2DL+9TuWlUOMxC9jn+NcobtbJ8ALO3GpBSHw3g+L7RKKpHbElBvMjNO9ew6fEfVjd0Nn9e4yJgCFwKmk0th3k2CZeEalmPaTS/rT80qLrFDPGD3kY1bQk6E4TbaJ/d6+SRtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978795; c=relaxed/simple;
	bh=8apiONi99fXvMDRH2eeNd9IQwb835Yp5HgLrSXlXpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRJnEddTYmL124no/VaaBjFFrD7kMb37GL3iAB14nrvGM0lLctgWdzlbj4RUXKR2RG5jJwyZSLjth2wqVFjrTPIJDCrH6jALn+Hl7EmrHhxP6DmFp33uVrALAY/pA78WT7uY7AOa5KgwsCZi8gChXo0EdV8g3w5xVBGk2qkjbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HKtUq0ZO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tg7WHOAZGiU5dJu6jDHMgp0FljLb6BYbmKgb+ORJsg=; b=HKtUq0ZO7pExPTjALnTNPXAK9R
	8Lk2t3+G1MDU+xg5LRpPzK16CZXpvFqL7utNDW0VzyBDS1s+SKkaS2oI2CABREUp4oq36eIuSKOze
	xU1d/7W08c5tQRPW3amux848+o0e7wHsUhiNC4x+8gek6Bl0ImGgXIRoYudCgoCt92uw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tklxt-00FfQp-IQ; Wed, 19 Feb 2025 16:26:21 +0100
Date: Wed, 19 Feb 2025 16:26:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Message-ID: <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>

> +description: |
> +  MediaTek Built-in 2.5G Ethernet PHY needs to load firmware so it can
> +  run correctly.
> +
> +properties:
> +  compatible:
> +    const: "mediatek,2p5gphy-fw"
> +
> +  reg:
> +    items:
> +      - description: pmb firmware load address
> +      - description: firmware trigger register
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phyfw: phy-firmware@f000000 {
> +      compatible = "mediatek,2p5gphy-fw";
> +      reg = <0 0x0f100000 0 0x20000>,
> +            <0 0x0f0f0018 0 0x20>;
> +    };

This is not a device in itself is it? There is no driver for this.

It seems like these should be properties in the PHY node, since it is
the PHY driver which make use of them. This cannot be the first SoC
device which is both on some sort of serial bus, but also has memory
mapped registers. Please look around and find the correct way to do
this.

	Andrew

