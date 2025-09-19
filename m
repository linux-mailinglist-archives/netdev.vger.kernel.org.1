Return-Path: <netdev+bounces-224797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18436B8A9B6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D058189F959
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C6272805;
	Fri, 19 Sep 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4j8vOwtm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E926D4C0
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300051; cv=none; b=SN7Rb5D2ArOzxMMdBmTCB9fTt+8zA3hwIYxnvpvcAPXk3jYgd7bZT84dTHCWa8F5v1zvvVBVl7wCQ+aUJ6otuzU0Gf91b0MDzmHxanMDdR5243J/6fVNhnMb4+xTfLlDD+KQWSZrycbhdM2bMR2W+OLglVSZCau+lRv4PFThgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300051; c=relaxed/simple;
	bh=Es0khwTU7bmAoQkhVHubIjajJxmzrKZlXOSyDcMQ4xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyBhG5LNUUC5vCJC2Bpj5Szi6X+LiAas8dMQlxXxx9iQ+BG+iRXWcId/5HVmmkpi0h0MtbWxn9TUssDweh5yipztobvLPAhK3nnGSR7PTlnxpaS8+oP8scaAY9rR7vTQHHdNpnGv8TXR4nz1+gNpPpCc08F4kSAYA/NH/Fua4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4j8vOwtm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QZmlv8EC8903WR50ZlL3jvT/RmH0iO8cdJ54F7yHoj0=; b=4j8vOwtm3E1o58Mc7E9YiEkXyQ
	VMQHFay7pWXyWjU/ioHYzbAVckv2QwPEmY6V//FDPVKn4ZFNp4Ap/upC7zHwm9RzRkWLl8le0S2Gy
	4lumDU9DuNcu1xkx0vQWzi8sf2H6VdP+95TCeRJOtydrgMHHS7P10kfoHvJNyWj4tD8k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzeAB-008xSY-LB; Fri, 19 Sep 2025 18:40:47 +0200
Date: Fri, 19 Sep 2025 18:40:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <03aa2085-bc5a-486f-ae61-3c66179d6823@lunn.ch>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>

> +void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u64 packets, bytes;
> +	u32 start;
> +	int i;
> +
> +	if (enet->rx) {
> +		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +			struct enet_rx *rx = enet->rx[i];
> +
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

Why would enet->rx and/or enet->tx not be set?

> +		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> +			struct enet_tx *tx = &enet->tx[i];

What prevents them from going away while in this loop?

	Andrew

