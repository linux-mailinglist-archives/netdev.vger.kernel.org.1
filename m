Return-Path: <netdev+bounces-242115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E545C8C7D8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 570BE4E15AF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0926B973;
	Thu, 27 Nov 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVQzL+YA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BF264F96
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204913; cv=none; b=eXsdJCY5aP6h0BOYc6gO6Nmc5JBdjQijt8vCDQrq3tQLnu5gS+T5vEEMSfjIb36pmj9XOojxyhDlE7snK2GToL7G0lyTXaM/wkTAGYUf7BXM5P7dKyT4KDqtRYXJySX3fh6OnQ9PZ8T+FF7fFL57yOEccAZe33mICGx4tRpHQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204913; c=relaxed/simple;
	bh=Lr0IL5GUBl8JeaumNMfsybl97Xs01U/j66crVexoXAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1N6GfUH+Nom/YUybyP9MyMU7aX+oCjKpkHiG8xM7tTzjXLaXF4C1yJyIDgwMY661pszzV6g8xLg0YtegvZHgPcd2CpVN15iOkSGv2axeLLFgnGJNEccwne2o6H5VPeMTA83dS0Nc2hSesalbL3danlX8qSU1LupYS80ncGmaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVQzL+YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F15C4CEF7;
	Thu, 27 Nov 2025 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204912;
	bh=Lr0IL5GUBl8JeaumNMfsybl97Xs01U/j66crVexoXAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JVQzL+YA05gxHzaR7OTuLBSq6ybnd/8kYp2FalDf48hMul6nfdwC2p4jlZKKPtFx0
	 I6+3Hdu4pmY9zHDxAa0tZPCgWjzgfJcG0yDQAZrKe+D0ZyqMCKebN1SpSF+OJ/dsm5
	 hgmi1iGyTbXRZiUMwolBRCw7bvuqLJN6YpQrLkg+Pg/U2JyUw918F+kNvil7pUe1f2
	 Bg2YGLvAhpXtwXuBdNZrnvlkrG1xEF99GI7DqlO3rnzrNX5DiV8BRs3ThxZCYj61gT
	 Jrch/2pgMVfEu9TvEixOe0PNH3yUqNcy/eXpf3sTBw6Ew9mt6XLAzE10IdtXsFPF3W
	 7z29+TfsshD5g==
Date: Wed, 26 Nov 2025 16:55:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Vivian Wang <wangruikang@iscas.ac.cn>, MD Danish
 Anwar <danishanwar@ti.com>, Dust Li <dust.li@linux.alibaba.com>, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v16 5/5] eea: introduce ethtool support
Message-ID: <20251126165510.34698f35@kernel.org>
In-Reply-To: <20251124014251.63761-6-xuanzhuo@linux.alibaba.com>
References: <20251124014251.63761-1-xuanzhuo@linux.alibaba.com>
	<20251124014251.63761-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 09:42:51 +0800 Xuan Zhuo wrote:
> +void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)

..ethtool.c is not a great place for an ndo, I missed this in previous
reviews

> +	struct eea_net *enet = netdev_priv(netdev);
> +	u64 packets, bytes;
> +	u32 start;
> +	int i;
> +
> +	if (enet->rx) {
> +		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +			struct eea_net_rx *rx = enet->rx[i];

Could you document here what prevents enet->rx from getting swapped /
going away half way thru the iteration? The implicit RCU sync in
netif_napi_del() ?

ndo get_stats runs under RCU and without rtnl_lock if read via profcs
(tools/testing/selftests/drivers/net/stats.py has a test case for it
FWIW)

> +			do {
> +				start = u64_stats_fetch_begin(&rx->stats.syncp);
> +				packets = u64_stats_read(&rx->stats.packets);
> +				bytes = u64_stats_read(&rx->stats.bytes);
> +			} while (u64_stats_fetch_retry(&rx->stats.syncp,
> +						       start));
> +
> +			tot->rx_packets += packets;
> +			tot->rx_bytes   += bytes;
> +		}
> +	}
> +
> +	if (enet->tx) {
> +		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> +			struct eea_net_tx *tx = &enet->tx[i];
> +
> +			do {
> +				start = u64_stats_fetch_begin(&tx->stats.syncp);
> +				packets = u64_stats_read(&tx->stats.packets);
> +				bytes = u64_stats_read(&tx->stats.bytes);
> +			} while (u64_stats_fetch_retry(&tx->stats.syncp,
> +						       start));
> +
> +			tot->tx_packets += packets;
> +			tot->tx_bytes   += bytes;
> +		}
> +	}
> +}

