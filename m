Return-Path: <netdev+bounces-137465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A44A9A684B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28573B2206A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C31F4FDC;
	Mon, 21 Oct 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OEnyOhpI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815B1F4FCD;
	Mon, 21 Oct 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513390; cv=none; b=OdUBXRBnEohu62xFQWcVakd65Lye/vrWmI0gjIk618LVCEaTHmAqSRQzo18W8MQ8eFX6qBSfF1SjFIyBk6xaxnZJUbK9jWSPbQ53zUVO7uWb/F9jZ007ZGyiJzLtScZz/S7Y5whmlYFrQcdYhM8uR5y8DqpbxTh9LsBsVwSY4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513390; c=relaxed/simple;
	bh=XVk3ftOgG+0QZvR5MP6WfTJYBHzAAPT1ZVBxz3NRcxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDJ7ALadccUCFrCfI7TVvMnfE42a8nfjKizOt4K645O4tnRs7vjYo42ocuu8e9lKgScSP41/ZrO1RksLDYrjkh2OWvzxQKkndta9U9LJSPchYeplkZi/e8ZmNGaWQgmIvb7PsD+HC8hpTQz1yofnbDQpoSgryKmbA/fRYJNJm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OEnyOhpI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wCZNacVnsn4uhYNBEOtyeQPuRqMb/JOuMBBq3Fhgftk=; b=OEnyOhpI2IM6s9X6FJBNmFxk+w
	4OqDLjt3Oa7VMOP2HqUEkx+9vfhD1lnCgE8tmSlTtSLRyBwXhZDtnxrb9Fja6djO2gjJSUcmpWJK8
	U4TvhRAjV18BpTkOavR+HJ6J8lGgc3iolSqYz/oQ9E007pXWvRMetETkFAkS6obQKBzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2rQt-00AiYl-Hp; Mon, 21 Oct 2024 14:22:47 +0200
Date: Mon, 21 Oct 2024 14:22:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021103617.653386-5-inochiama@gmail.com>

> +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct sophgo_dwmac *dwmac = priv;
> +	unsigned long rate;
> +	int ret;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		rate = 125000000;
> +		break;
> +	case SPEED_100:
> +		rate = 25000000;
> +		break;
> +	case SPEED_10:
> +		rate = 2500000;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +		break;
> +	}

There was a helper added recently for this, since it appears
repeatedly in drivers.

> +	ret = regmap_set_bits(regmap, args[0], DWMAC_SG2044_FLAG_USE_RX_DELAY);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to set the phy rx delay\n");

Please could you explain what this delay is for. Is it the 2ns RGMII
delay?

	Andrew

