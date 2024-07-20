Return-Path: <netdev+bounces-112293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355B938156
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941C91C213BF
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B577E0FC;
	Sat, 20 Jul 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WU4TZjUm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E581B86DD;
	Sat, 20 Jul 2024 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721478963; cv=none; b=TIBPcv0YpJFIVFDLyn4bTpD96sKXjQEJ8NfSJxikyNIkJYajCGgz//fTxVX032y/a5HfrxEZruJ7HSRd9Yy5ImIk2J24Tdk8OgMpfGSB1XmvtQtqZ9NE+JFkC1GvDlyBxF0IiqTXjj0Q7nA3GC3Vvn3r/hy9rg6V4D/F0cXGzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721478963; c=relaxed/simple;
	bh=wZWGcfCwuvLPkZK8gloKNZXCfUB43TB3Hov3xCYN9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBpI2ajBJFwQjQJhn/xM3rDKs1giZLkZWh9pYB3WYm7EWAD17786Xl/U6GlHa31YjCH5N5pWXgMpISx/aYFFZkoKGI3VEThWL5PmXy+MIrxDayNgWTy7Y7BWp/zfXadgphV2GtdceXIvoljoxlc4qAI46r27z26ldnVKf3zXwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WU4TZjUm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rfT+wKS03QStuvsuw2Ht5YxWdDs9N54bvyBHm404z5w=; b=WU4TZjUm0bIk6ItpC+MpNQFEM9
	TZXiGliWrbvUMBLpGi5W6q7W31VrLCwMq0U4hsYt0AVFJ3Ar5G/nVIjMeuSYQwevUR9KqHh4kEnRg
	g0Qm4nW8G0JmJxnQrDJbRdXFSqHJRuWorLKdVJX9DGSTHW7bofogfD1J/gPMVV6LyVIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sV9J8-002tkI-JM; Sat, 20 Jul 2024 14:35:26 +0200
Date: Sat, 20 Jul 2024 14:35:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
	mcoquelin.stm32@gmail.com, linus.walleij@linaro.org,
	martin.blumenstingl@googlemail.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"zhili.liu" <zhili.liu@ucas.com.cn>,
	wangzhiqiang <zhiqiangwang@ucas.com.cn>
Subject: Re: [PATCH] net: stmmac: fix the mistake of the device tree property
 string of reset gpio in stmmac_mdio_reset
Message-ID: <0c5f35c1-cf3a-4759-ac17-54e6f8c22c69@lunn.ch>
References: <20240720040027.734420-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720040027.734420-1-zhouzhouyi@gmail.com>

On Sat, Jul 20, 2024 at 04:00:27AM +0000, Zhouyi Zhou wrote:
> From: "zhili.liu" <zhili.liu@ucas.com.cn>
> 
> According to Documentation/devicetree/bindings/net/snps,dwmac.yaml,
> the device tree property of PHY Reset GPIO should be "snps,reset-gpio".
> 
> Use string "snps,reset-gpio" instead of "snps,reset" in stmmac_mdio_reset
> when invoking devm_gpiod_get_optional.

Have you found the current code does not work on a board you have, or
is this by code inspection?

https://elixir.bootlin.com/linux/v6.10/source/drivers/gpio/gpiolib-of.c#L687
https://elixir.bootlin.com/linux/v6.10/source/drivers/gpio/gpiolib.h#L93

See how it appends -gpio and -gpios to the name.

I also randomly check a few users of devm_gpiod_get_optional() and non
of them include the -gpio in the name, leaving the GPIO core to do it.

	Andrew

