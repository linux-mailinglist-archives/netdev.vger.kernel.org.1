Return-Path: <netdev+bounces-212746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE6B21BC3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A81F19064F7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC291DF27F;
	Tue, 12 Aug 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NbYqq15F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4232D9EDD;
	Tue, 12 Aug 2025 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970371; cv=none; b=B1VrKQXdIYIThtOnm77gmhVvsgB/13hF0OBa0GG1okbedZag5Lp2h6mqAonFyWbppluP1TnzRI5YA9zRNt6/dR0AM4I4xmW/bpmHuiKY2PC3st9eL7CwivGSekM85AH5tMwLjzhB5z65E/4qmRDjHFskNie4aVAhhi8jBfhLR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970371; c=relaxed/simple;
	bh=QKrhEizsg0N1zg4M61hvf6ECAUH4usaiehJgLk+LSYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgqciquRsZ7KpGmJZx+GH2WSBvWqp0LxxLd83fOHaow7Uez3nCwAKHcy7L7Mf6EmDVp2OIc2JYCUQkM25PhqvESkC7oCqt6U0w7p4AsggnkRcLSbiAlcnm/hJMtYP8Lr5Ah/hMByuiSb8MpK/hAz1YQnNPxn2HyysslYheMo2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NbYqq15F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NIC/wkT8xDaIY7MD6UsDmD8NMUh6b3J8xBtXrNsXYKo=; b=NbYqq15F+k0PaYhFy5Hc5uGO1C
	F7j6cSoP/whS4817YNAeQ66fdIUeTNQC5RhDl3Pn2Jkb/dJBC2qkppaK48DJ9uxXASz28fYUHgXWy
	gKaqh24ZdeiIwvrmcSyoigBz47PTJ39VEZOCcGj6Fe050vKSBFjjU3uGdFI1pW5XiSuY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulfxA-004PNl-P9; Tue, 12 Aug 2025 05:45:36 +0200
Date: Tue, 12 Aug 2025 05:45:36 +0200
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
Message-ID: <ac9cce0b-d29e-499b-8a86-28979cd12fb5@lunn.ch>
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

> +static void emac_get_pause_stats(struct net_device *dev,
> +				 struct ethtool_pause_stats *pause_stats)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	struct emac_hw_tx_stats *tx_stats;
> +	struct emac_hw_rx_stats *rx_stats;
> +
> +	tx_stats = &priv->tx_stats;
> +	rx_stats = &priv->rx_stats;
> +
> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +		emac_stats_update(priv);
> +
> +		pause_stats->tx_pause_frames = tx_stats->tx_pause_pkts;
> +		pause_stats->rx_pause_frames = rx_stats->rx_pause_pkts;
> +	}
> +}

You have pause statistics, but not actual configuration of pause.

> +static void emac_adjust_link(struct net_device *dev)
> +{
> +	struct emac_priv *priv = netdev_priv(dev);
> +	struct phy_device *phydev = dev->phydev;
> +	u32 ctrl;

Normally the adjust_link callback you configure the hardware with the
result of pause negotiation.

> +/* Called when net interface is brought up. */
> +static int emac_open(struct net_device *ndev)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
> +
> +	int ret;

Extra blank line.


    Andrew

---
pw-bot: cr

