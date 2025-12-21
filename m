Return-Path: <netdev+bounces-245656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0427CD45A3
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0966630056E1
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8D23D7F0;
	Sun, 21 Dec 2025 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OGZZ/Drc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBF23C8C7;
	Sun, 21 Dec 2025 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766349761; cv=none; b=mvfAQIOccm45ekomD3/osXOJJ5lWJLL3GYfPJThfkMuFETxRFYn51ui+Q3hka6Esr6yc6pxm9a/UzKf9AVPdv7ZrU2jM+vrjmEPbwtRSkTRxf2zV+kxxEl22pZLIXLT39cKVNGci5rttnmTSudFX8XstPGzw5L6EmLIhKThO6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766349761; c=relaxed/simple;
	bh=DrAbw5+cSf4kHXSekg/6dnJ6qsWzOO86vNbOOL4jUos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY1t7MbRIyis72p/s08XJqLh3UEawWEBz6VSxsQVq568idqkgG1cU7Gxn0PPxseHEsinLwgyPUGAa99l7ebMOxxLdl8qVH2cuDHxGaXx83QYv1VtzFPqgtcLzzsHFrqG7FFx/6jZn6cQbs3RM4TsrBi24Kg/fYLwCyi9qSe6WvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OGZZ/Drc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B3ra9k/QRHqlZWeluAGFEmUoSmChFoDZ++tRFEuZSjw=; b=OGZZ/DrcSW6Y4hnDDsoITw9HvC
	QaxJMBToKn79QjxxnXta7fTWMwKfnUKMZr6gQE+wWotJyrQbwdyM/ysCqoNDxuUQipSX3T+yL8kcA
	uh37zwgrRFd0rDcfv/L8mWm9h4is/XZ4B04ADiHeFbTlF5qvBe+lEgB9VvboMHLIlueY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXQFw-0006oA-NS; Sun, 21 Dec 2025 21:42:20 +0100
Date: Sun, 21 Dec 2025 21:42:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [RFC PATCH net-next v4 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <36d87587-d40d-4258-a05f-b7923aea7982@lunn.ch>
References: <20251216180331.61586-1-me@ziyao.cc>
 <20251216180331.61586-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216180331.61586-3-me@ziyao.cc>

> +static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv *priv,
> +				      u8 index,
> +				      struct motorcomm_efuse_patch *patch)
> +{
> +	u8 buf[sizeof(*patch)], offset;
> +	int i, ret;
> +
> +	for (i = 0; i < sizeof(*patch); i++) {
> +		offset = EFUSE_PATCH_REGION_OFFSET + sizeof(*patch) * index + i;
> +
> +		ret = motorcomm_efuse_read_byte(priv, offset, &buf[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	memcpy(patch, buf, sizeof(*patch));

Why do you write it into a temporary buffer and then copy it to patch?
Why not put it straight into patch?

> +	ret = motorcomm_efuse_read_mac(priv, res.mac);
> +	if (ret == -ENOENT) {
> +		dev_warn(&pdev->dev, "eFuse contains no valid MAC address\n");
> +		dev_warn(&pdev->dev, "fallback to random MAC address\n");
> +
> +		memset(res.mac, 0, sizeof(res.mac));

It is not clear how setting this to zero results in a random MAC
address. Maybe actually call eth_random_addr()?

	 Andrew 

