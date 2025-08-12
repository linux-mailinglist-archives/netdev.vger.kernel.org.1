Return-Path: <netdev+bounces-212732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEFB21AAB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B6176033
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF332D3A88;
	Tue, 12 Aug 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kNTKg67v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C813D8A4;
	Tue, 12 Aug 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965065; cv=none; b=MfdcxOQPQ54KA5/0yk6ZDoy2/LoBDCN9N7dCotk4qY2dLXibc8MS+QxTB7/7gJS9q+N3JqNEfbQwpZO4e2/KRwnAv6cFYV4vPo7Zh4jYptFU5/9agWPUlj+LwN9J/7nvaOCJHWVn9xMYdq+P5YHlCACu1ODdmovp2oiGiRnClt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965065; c=relaxed/simple;
	bh=9hyw2ZamaVKPucYdpchYgL0a3W1CoFD/HweVTzEnR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhxONekxmKgornFROa+mFXTwYPR4j2+n6xPvtcSFCVqSoLYj5Wa6qH4UFIHP4WW/zSM7bXKvyE75x5qKe3NbOP7tzIDV0oOHHPGmiiqzi4oWG3cPlSqpZ8FJ+ySbohvqDi/vPqUgg30XGrOCXfMLYzufZQANvsZ3/6gvVxIL1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kNTKg67v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xg2zz37NQZwnjzW1ZVhxRl064ST3U4ZE4dYyZIQGosE=; b=kNTKg67vzA9dT0L+K3+eNJMYni
	rT9ZgJZnmhoczgL6neUKbWK45YwYXHRH/IM+y/EVuL9eLuaRBQrBJHnbkps8pAKA0aZHmkJzlbFPV
	w3CYg4sdSFpso53dUjGSDPsSgmW7BsHxU4m6kkailW8+fdZUyDBDoE2xS30d3zci/Jl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uleZa-004P2G-1f; Tue, 12 Aug 2025 04:17:10 +0200
Date: Tue, 12 Aug 2025 04:17:10 +0200
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <5c32fde3-0478-4029-9b71-e46a60edf06b@lunn.ch>
References: <20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn>
 <20250812-net-k1-emac-v5-2-dd17c4905f49@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-net-k1-emac-v5-2-dd17c4905f49@iscas.ac.cn>

> +/* Caller must hold stats_lock */
> +static void emac_stats_update(struct emac_priv *priv)
> +{
> +	u64 *tx_stats_off = (u64 *)&priv->tx_stats_off;
> +	u64 *rx_stats_off = (u64 *)&priv->rx_stats_off;
> +	u64 *tx_stats = (u64 *)&priv->tx_stats;
> +	u64 *rx_stats = (u64 *)&priv->rx_stats;
> +	u32 i, res;

Rather than the comment, you could do:

	assert_spin_locked(priv->stats_lock);

	Andrew

