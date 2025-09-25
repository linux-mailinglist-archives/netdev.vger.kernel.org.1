Return-Path: <netdev+bounces-226192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADEB9DBDC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E0F19C67ED
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE90219A7D;
	Thu, 25 Sep 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u6urTpiu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4751CAA92
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783712; cv=none; b=j1L5Sx6a+hrhy8hfA9QE9Ghy4Rf2KPMo9CrCGxlxoVRcDGrEwll//slMVEGbxJr7kVspO0uqC5XqMuaJ6LnOIbMIfjaiaAJ6JF8wXtB1OXevNT2YaVBc3R8GutfMKHi4X1JN3pShfPL1TrsxXcyqfVBzWrxY41yNGECPATgZ/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783712; c=relaxed/simple;
	bh=xed37mU+OQDbRXT/TJ1tRE4CZdeEMdmOMAUo2IoW2AU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=INEAJ/l4TiNGamEE696l1VdgEwVzowqSNvfqdR4Ia/j4fRy2pJtbup5S1NAjxo+jMLNLwqftkiqMIAFnh0PZ4NBB+Lb0dfIosZSFeOq4HPWsxfWjLvc7XxORcSlwEsc4XwnNbdIQjdj5Gccnmdpyf+n7103z0AYH6QLsQXebLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u6urTpiu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758783704; h=Message-ID:Subject:Date:From:To;
	bh=n1FqL32WUFd8ddfUHCqRT7zlHcZqNMx0fMjo8+1HUmA=;
	b=u6urTpiuCetr7zlCI36Ybes0tbcnWjSuP9p6/PKOpbXwgvTqSAU2ypsb7llovzbWIy6C8nOU8GBL0Upj2ExfBxYNzwQLueHQh2x7p5nCAlgC9VBaGLQnQ+v81VliT9eQmbth7xKZEXgK2Vi5clicBimnUbP8aAc7V62eELNAvCU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WomepQ0_1758783702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:01:42 +0800
Message-ID: <1758783617.5882711-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 25 Sep 2025 15:00:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <03aa2085-bc5a-486f-ae61-3c66179d6823@lunn.ch>
In-Reply-To: <03aa2085-bc5a-486f-ae61-3c66179d6823@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 19 Sep 2025 18:40:47 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > +void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
> > +{
> > +	struct eea_net *enet = netdev_priv(netdev);
> > +	u64 packets, bytes;
> > +	u32 start;
> > +	int i;
> > +
> > +	if (enet->rx) {
> > +		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> > +			struct enet_rx *rx = enet->rx[i];
> > +
> > +			do {
> > +				start = u64_stats_fetch_begin(&rx->stats.syncp);
> > +				packets = u64_stats_read(&rx->stats.packets);
> > +				bytes = u64_stats_read(&rx->stats.bytes);
> > +			} while (u64_stats_fetch_retry(&rx->stats.syncp,
> > +						       start));
> > +
> > +			tot->rx_packets += packets;
> > +			tot->rx_bytes   += bytes;
> > +		}
> > +	}
> > +
> > +	if (enet->tx) {
>
> Why would enet->rx and/or enet->tx not be set?


We allocate enet->rx, tx only when the driver is open.


>
> > +		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> > +			struct enet_tx *tx = &enet->tx[i];
>
> What prevents them from going away while in this loop?

rtnl_lock


Thanks.


>
> 	Andrew

