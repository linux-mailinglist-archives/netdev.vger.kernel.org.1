Return-Path: <netdev+bounces-271684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPTCHqcfxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD51A32A15A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D35E300C037
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E7407104;
	Wed, 25 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaW1Roma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062A30F548
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460732; cv=none; b=J5ZuPQT7acEvpmrqsbK0NvBsJQB7Vp9mEpXK9UhfvY5H7LmURD5HVGRi0tW5v36ZJGy++PeSjoeEUPyN5iPZIcIQvnOKHwDSgVsETC2h5u3riqy6eQxRT3EBYeO8KEqmyQfvSpIWRCVoNgNVbm2n/i+2VMQbcPOf3j/e4wPwgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460732; c=relaxed/simple;
	bh=G8gZmrgydL6oZ4QqLh5ZZiDwq2SmBhx8hBCagxRpaZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWQLBdsb6wi0O8rx44qyf8rzmfJsaJoLzL+1t1FrrUx+y79v7kyvttvPMNBeW4o8Yy/mkwfpwFl1hBFBXtwrHBdopx5ZdSOsMBCtSJfWn3l0QQ2QQIx9x6FtzzMk8ZyVOKunHzSVfpaoSbF6yuFJFmIJH9I3tK+CAK68ECwm8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaW1Roma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91186C19423;
	Wed, 25 Mar 2026 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774460732;
	bh=G8gZmrgydL6oZ4QqLh5ZZiDwq2SmBhx8hBCagxRpaZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaW1Roma+GSHv7CyWs5dDNriNTvqEX/qGq6xtzAKBqiTEcxiAto/JvpX5zJzFr8UA
	 a17aviTGd5m/u0NnBJZOsPBCAH/2mSZnnAbi7cu2/bMeVbXvwLTqka5Uwf1Hl3OOtP
	 yjWk/9k4Y2t/PsHF6d73Iep0Sbt1b79OtsR3ovS11d60VkZAXrPApPTwL2mJADiyrv
	 dFwbgh3zGKsaXZhjPGsBpwml78UHDzRLcqSRHx8DO8V0tv2VEQhYY3wDIu2IfglD5g
	 NudobHWypgV9JTok1KdN5Fgob0lELzaRv1pXcL8xbMw/EgWw6EQDifwlDzyY7Tgzay
	 Ir0SvhIRJHqyQ==
From: Simon Horman <horms@kernel.org>
To: pvalerio@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	claudiu.beznea@tuxon.dev,
	nb@tipi-net.de,
	theo.lebrun@bootlin.com,
	lorenzo@kernel.org,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/7] net: macb: Add page pool support handle multi-descriptor frame rx
Date: Wed, 25 Mar 2026 17:45:25 +0000
Message-ID: <20260325174525.340041-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-4-pvalerio@redhat.com>
References: <20260323221047.2749577-4-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: CD51A32A15A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: Add page pool support handle multi-descriptor frame rx

This commit adds page pool support for the Cadence MACB/GEM Ethernet
driver and enables multi-descriptor frame reception. It replaces
netdev_alloc_skb() with page pool allocation and removes the limitation
that frames must fit in a single descriptor.

> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
> index 5b2a461dfd28..ae500f717433 100644
> --- a/drivers/net/ethernet/cadence/Kconfig
> +++ b/drivers/net/ethernet/cadence/Kconfig

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fca7b9c6b670..84989ff0c3a9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -2600,12 +2700,22 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return ret;
>  }
>
> -static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
> +static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
>  {
> +	unsigned int overhead;
> +	size_t size;
> +
>  	if (!macb_is_gem(bp)) {
>  		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
>  	} else {
> -		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
> +		size = mtu + ETH_HLEN + ETH_FCS_LEN;
> +		bp->rx_buffer_size = SKB_DATA_ALIGN(size + bp->rx_ip_align);
> +		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
> +			overhead = bp->rx_headroom +
> +				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +			bp->rx_buffer_size = rounddown(PAGE_SIZE - overhead,
> +						       RX_BUFFER_MULTIPLE);
> +		}
>
>  		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
>  			netdev_dbg(bp->dev,

Can this overflow the hardware register field? The old code clamped size
against RX_BUFFER_MAX (16320), but the new code only guards against
PAGE_SIZE. Looking at the RXBS field in the hardware (GEM_RXBS_SIZE=8 bits
at macb.h:356), it can only represent values 0-255, encoding buffer sizes
0-16320 (value * RX_BUFFER_MULTIPLE where RX_BUFFER_MULTIPLE=64).

On systems with large page sizes (e.g., ARM64 with CONFIG_ARM64_64K_PAGES),
the PAGE_SIZE guard doesn't trigger for jumbo MTU values. If rx_buffer_size
reaches 16384 (SKB_DATA_ALIGN(16320+2)), then buffer_size = 16384/64 = 256,
which overflows the 8-bit field to 0 when written via GEM_BF(RXBS,
buffer_size) in macb_configure_dma():

drivers/net/ethernet/cadence/macb_main.c:macb_configure_dma() {
	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
	...
	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
		if (q)
			queue_writel(queue, RBQS, buffer_size);
		else
			dmacfg |= GEM_BF(RXBS, buffer_size);
	}
}

This would cause the hardware to use an incorrect (zero) buffer size.

Should the code clamp rx_buffer_size to ensure buffer_size stays within
0-255 after the division?

