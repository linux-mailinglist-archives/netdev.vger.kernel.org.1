Return-Path: <netdev+bounces-272988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB0kNPuByWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3D353D3C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD603300B44B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2C2727F3;
	Sun, 29 Mar 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxeGo2bF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1924BBEB
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813666; cv=none; b=pFQX3vaJwd082pnBCgIUP6XxMnYUbMdr1BdBDDsYLCGfiiAS9TMWqux9jriRqwv050CaVdS9b9WbMr/QbEbiCXzwgarduar9/+llJ3pg6JViJsS+UfhPDMPpa/AFV9lta7jrZbVQZLq5eHmm7Dqox5IU+MzG6mqk0Qoqb6jcTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813666; c=relaxed/simple;
	bh=4p2/oUKUC2tXpS7crQb/gg9zdAui4JHMymTbJvWUraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZvzaCxUUgwZQWhWRw+HDHL7tS8CaGhSnOpdkGnihIY87U3Y2xavW6Fbk5fgGYrefBqW4C9kBto2O0LfU23kU7pKr5pUxgZtctigl/k+zvdAhbNTmsz+QLD/+PVW4khYeubZL5MvZq8aieAN5DnG9kzCyaXk9n19CKhb+ZXD2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxeGo2bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DBEC19423;
	Sun, 29 Mar 2026 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813666;
	bh=4p2/oUKUC2tXpS7crQb/gg9zdAui4JHMymTbJvWUraM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxeGo2bFRdWntHqO5k4flMxvveVLQbbxCJv9JxR8ppzDS9v83kAz28whJRPS79siA
	 616lzOOAImslkgb7Z4iwNNemRkoQXEUiNvVZDs0W+NmN2hcJQdVOovuL1DEAE3eQ1p
	 Bkbt8sJpgSJKDSVWhbTlFa7sXmvk8cWVt3A4josNY85cSTv4eki7KOnUlZQv+mPWpP
	 I/9rI3NeLjFNR61s1CQX/NeznAF34+PMu2dGV1hIRPjMI6g0RY3U/gXQv5/8AmZakN
	 XQhS8wkFBp3whP30dJOIdefkO4TUrVi9B/cYmioXWKEFjgmBEHSZsUD+S4FfxD7QX0
	 M5OynQCRSSu5w==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	theo.lebrun@bootlin.com,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 3/7] net: macb: Add page pool support handle multi-descriptor frame rx
Date: Sun, 29 Mar 2026 12:47:44 -0700
Message-ID: <20260329194744.2781381-1-kuba@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39B3D353D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: macb: Add page pool support handle multi-descriptor frame rx

This patch adds page pool allocator and skb recycling support for the data
buffers in the Cadence MACB/GEM Ethernet driver. It also adds support for
receiving network frames that span multiple DMA descriptors.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
[ ... ]
> +static unsigned int gem_total_rx_buffer_size(struct macb *bp)
> +{
> +	return SKB_HEAD_ALIGN(bp->rx_buffer_size + NET_SKB_PAD);
> +}

When calculating the size for napi_build_skb(), does this code account
for the skb_shared_info overhead?

napi_build_skb() places the shared info at the end of the provided fragment
size (frag_size - sizeof(skb_shared_info)). Without adding
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) to the total size, the shared
info could overlap with the DMA buffer space. This could overwrite packet
data and cause an skb_over_panic() on skb_put() for large frames.

[ ... ]
> @@ -1500,25 +1543,26 @@ static int gem_rx_refill(struct macb_queue *queue)
>  		desc = macb_rx_desc(queue, entry);
>  
>  		if (!queue->rx_buff[entry]) {
> -			/* allocate sk_buff for this free entry in ring */
> -			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
> -			if (unlikely(!skb)) {
> -				netdev_err(bp->dev,
> -					   "Unable to allocate sk_buff\n");
> +			gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
> +			page = page_pool_alloc_frag(queue->page_pool, &offset,
> +						    gem_total_rx_buffer_size(bp),
> +						    gfp_alloc | __GFP_NOWARN);

Can gem_rx_refill() be called concurrently by both the NAPI poll loop and
the error recovery workqueue?

The page pool allocator uses a lockless fast-path that requires execution
from a single context. Looking at the driver, macb_hresp_error_task() is a
workqueue that calls gem_init_rings() which in turn calls gem_rx_refill().

If the workqueue path calls gem_rx_refill() without first stopping NAPI
(via napi_disable()), does this risk concurrent access and memory corruption
in the page pool ring?

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

Could this calculation result in a page pool allocation request that
exceeds PAGE_SIZE?

Because the check for gem_total_rx_buffer_size(bp) > PAGE_SIZE happens
before bp->rx_buffer_size is rounded up to RX_BUFFER_MULTIPLE (which occurs
just below this block), specific MTU values might pass the initial check but
exceed PAGE_SIZE after rounding.

Since the page pool is initialized with order = 0, requests larger than a
page will unconditionally fail.

