Return-Path: <netdev+bounces-222730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640FB55821
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6151C21985
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8D32BF49;
	Fri, 12 Sep 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zKdZd0GQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA628489B;
	Fri, 12 Sep 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711490; cv=none; b=Zyf6Zwmwr1a0yhU2D9K456v+82K+8z6SUcNyDFxV3uLB+7mFrnsByLGSPQpO1NM0D40i1RI2Udcsv5RTZ5RZJGwIklE+3LKdUr1/9GZHHDEjyknjIFBuYMHHbC3HZjAL4zmpeSu6QTVnyGqnGwcKaoHmYVwP+WVXXUYS6dB0+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711490; c=relaxed/simple;
	bh=D/Cyd1SWByXhnXhlXz5eUp4WAyTJXeELIf5f2DNwVQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSxRtD46pwCJJJ7U8sCV1fg+OTE/VsweIx70gheOtGjvu/0Pp6BifV+EzFM266YAgHNIzXH+P2ORDSliB5He9ixszPo7+jwuiXsctj/bJizwKNj3PUM5S8nUQ0d98wqTfH25ViLQckqJ4Lx3mCLan+Xsh8vN4yHkcaZ53NN7t0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zKdZd0GQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QBCLCLlywXx8YW7RXuqLyrr43UeZ+UsFUs7lNnZijXg=; b=zKdZd0GQBLbpnow2hX0mg4RLTq
	IgzOfcH2SoMMqohYhoOP+iTYzRufSCKI0yoRY30bhcZFvebxzYUMIMRYf0lxbN68kbmIb3/lqh8kC
	dUIwc8WCtQdH+K4F0ooyAVxJZBLfuNczJhEKI5WpqwFGevsxAh5FnJFIzzCyEiADL5qY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxB2h-008G1n-Rx; Fri, 12 Sep 2025 23:10:51 +0200
Date: Fri, 12 Sep 2025 23:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH net-next v11 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <1f2887e4-2644-48a4-8171-98bd310d190f@lunn.ch>
References: <20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn>
 <20250912-net-k1-emac-v11-2-aa3e84f8043b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-net-k1-emac-v11-2-aa3e84f8043b@iscas.ac.cn>

> +static u32 emac_rd(struct emac_priv *priv, u32 reg)
> +{
> +	return readl(priv->iobase + reg);
> +}

> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
> +{
> +	struct emac_priv *priv = bus->priv;
> +	u32 cmd = 0, val;
> +	int ret;
> +
> +	cmd |= FIELD_PREP(MREGBIT_PHY_ADDRESS, phy_addr);
> +	cmd |= FIELD_PREP(MREGBIT_REGISTER_ADDRESS, regnum);
> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
> +
> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
> +
> +	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
> +				 !(val & MREGBIT_START_MDIO_TRANS), 100, 10000);
> +
> +	if (ret)
> +		return ret;
> +
> +	val = emac_rd(priv, MAC_MDIO_DATA);
> +	return val;

emac_rd() returns a u32. Is it guaranteed by the hardware that the
upper word is 0? Maybe this needs to be masked?

	Andrew

