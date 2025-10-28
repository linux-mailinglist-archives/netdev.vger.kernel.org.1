Return-Path: <netdev+bounces-233379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C84C12913
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42C2B3425B6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135F2472A4;
	Tue, 28 Oct 2025 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw+IDt+O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2015246788
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615477; cv=none; b=sN66CT09onF9Nl75wV6B5IAl99OhzZQltCdDDmpX3o2UqHiFTMbP5GvxSO5IHxgpa+DQnz3p25P7ZOQnG97GB6o0iUiseifX3wJu4wKX/IvcZ8QvWGjW4svU4jHv8ki546gW9OQ97Q64BJsvJkmX6rWf+srbDBK9V50eDXV+gCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615477; c=relaxed/simple;
	bh=Cwh7QtHmCjKKQhqGRQf26GaeRl8/yTyzezv3aHkMCeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHfV6ZmxmVY9oBtELbvE1FUoXFZ1orCOigSdOvvXfsyxu4gFowB2WEvkMXffRV1gGvjEYOMUHzSTOSdj37VFr0Mtg/agHCZuDZni6r5srQhVvwGYIHyAvicFDwp9UuetGL3sY7VtL4xE1dTjGAlF5uNlwT+xkpazscWr0Pqi2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw+IDt+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF42C116B1;
	Tue, 28 Oct 2025 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615476;
	bh=Cwh7QtHmCjKKQhqGRQf26GaeRl8/yTyzezv3aHkMCeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yw+IDt+OTSI5NnWIdLkDeQkki9cJaVeDHuxpTOR6HEk4HcdUJH7KQj+zV1NhcbON9
	 8kCj2YEP/cb+p2POlozcJNofndnbDGGFHFexeORLA/XXLECETVHkayWUVdwll6Cc/h
	 AnN0Th35wGNj8X7uawkSe7RqMKDboDLhhd2Eok8vAs5/uKOQ4DI1VMDe11eQyOBQIp
	 NwbDFPKoIZTj8+FaIuuz9/IByJYnvvidJ9Q/O5v4nthwtWChP71ofZZiavd/2c98Xw
	 Vyq+iXxs3fN6ntlf2hXpjhfGj0sDbxh/38hhiehu3uLGMA9gt8A0wqoFDjwuVpqLRQ
	 Y2O8d5eEtFKsg==
Date: Mon, 27 Oct 2025 18:37:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v8 5/5] eea: introduce ethtool support
Message-ID: <20251027183754.52fe2a2c@kernel.org>
In-Reply-To: <20251023055239.89991-6-xuanzhuo@linux.alibaba.com>
References: <20251023055239.89991-1-xuanzhuo@linux.alibaba.com>
	<20251023055239.89991-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 13:52:39 +0800 Xuan Zhuo wrote:
> +static const struct eea_stat_desc eea_rx_stats_desc[] = {
> +	EEA_RX_STAT(descs),
> +	EEA_RX_STAT(drops),
> +	EEA_RX_STAT(kicks),
> +	EEA_RX_STAT(split_hdr_bytes),
> +	EEA_RX_STAT(split_hdr_packets),
> +};
> +
> +static const struct eea_stat_desc eea_tx_stats_desc[] = {
> +	EEA_TX_STAT(descs),
> +	EEA_TX_STAT(drops),
> +	EEA_TX_STAT(kicks),
> +	EEA_TX_STAT(timeouts),
> +};

Please don't expose via ethtool -S what can be exposed via standard
stats (drop -> qstats). FWIW you can add the split_hdr_bytes / pkts
to qstat too, IIRC mlx5 maintains that too.

> +static int eea_set_ringparam(struct net_device *netdev,
> +			     struct ethtool_ringparam *ring,
> +			     struct kernel_ethtool_ringparam *kernel_ring,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_init_ctx ctx;
> +	bool need_update = false;
> +	struct eea_net_cfg *cfg;
> +	bool sh;
> +
> +	enet_init_ctx(enet, &ctx);
> +
> +	cfg = &ctx.cfg;
> +
> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "not support rx_mini_pending/rx_jumbo_pending");
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending > enet->cfg_hw.rx_ring_depth) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) > max (%d)",
> +				       ring->rx_pending,
> +				       enet->cfg_hw.rx_ring_depth);
> +		return -EINVAL;
> +	}
> +
> +	if (ring->tx_pending > enet->cfg_hw.tx_ring_depth) {

Core already validates against max, I think the 3 ifs above are
pointless.

> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) > max (%d)",
> +				       ring->tx_pending,
> +				       enet->cfg_hw.tx_ring_depth);
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending != cfg->rx_ring_depth)
> +		need_update = true;
> +
> +	if (ring->tx_pending != cfg->tx_ring_depth)
> +		need_update = true;
> +
> +	sh = kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
> +	if (sh != !!(cfg->split_hdr))
> +		need_update = true;
> +
> +	if (!need_update)
> +		return 0;
> +
> +	cfg->rx_ring_depth = ring->rx_pending;
> +	cfg->tx_ring_depth = ring->tx_pending;
> +
> +	cfg->split_hdr = sh ? enet->cfg_hw.split_hdr : 0;
> +
> +	return eea_reset_hw_resources(enet, &ctx);
> +}
> +
> +static int eea_set_channels(struct net_device *netdev,
> +			    struct ethtool_channels *channels)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u16 queue_pairs = channels->combined_count;
> +	struct eea_net_init_ctx ctx;
> +	struct eea_net_cfg *cfg;
> +
> +	enet_init_ctx(enet, &ctx);
> +
> +	cfg = &ctx.cfg;
> +
> +	if (channels->rx_count || channels->tx_count || channels->other_count)
> +		return -EINVAL;

ditto

> +	if (queue_pairs > enet->cfg_hw.rx_ring_num || queue_pairs == 0)
> +		return -EINVAL;

Pretty sure core checks that at least 1 queue is configured

> +	if (queue_pairs == enet->cfg.rx_ring_num &&
> +	    queue_pairs == enet->cfg.tx_ring_num)
> +		return 0;

And I think netlink will not call you without any updates either.

> +	cfg->rx_ring_num = queue_pairs;
> +	cfg->tx_ring_num = queue_pairs;
> +
> +	return eea_reset_hw_resources(enet, &ctx);
> +}
> +
> +static void eea_get_channels(struct net_device *netdev,
> +			     struct ethtool_channels *channels)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	channels->combined_count = enet->cfg.rx_ring_num;
> +	channels->max_combined   = enet->cfg_hw.rx_ring_num;
> +}

> @@ -321,6 +341,10 @@ void eea_tx_timeout(struct net_device *netdev, unsigned int txqueue)
>  	struct eea_net *priv = netdev_priv(netdev);
>  	struct eea_net_tx *tx = &priv->tx[txqueue];
>  
> +	u64_stats_update_begin(&tx->stats.syncp);
> +	u64_stats_inc(&tx->stats.timeouts);
> +	u64_stats_update_end(&tx->stats.syncp);
> +

core maintains and reports timeouts already
-- 
pw-bot: cr

