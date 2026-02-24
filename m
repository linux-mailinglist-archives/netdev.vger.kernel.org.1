Return-Path: <netdev+bounces-260265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAuHNirsnGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A8180241
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9093304D271
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FB3B2BA;
	Tue, 24 Feb 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhtdOzjW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384EC288AD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891731; cv=none; b=inCbjm9Q/NyKf0Ml2UMVooILSER28LmeqvnvqLG1CMI3MyuUNIDzrxoj+VF9DXt6oyuzb0XuQfVNWR3WwsHw+pso2kE4fGDOhxqaIPteOnaLqVEHm3/Nk/iMmSAn5d5mDP6zaj2o5j78MGtm7x+EAD8mkdSCfuwS29T5zff8Cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891731; c=relaxed/simple;
	bh=pa+SU9lNeb8yTs+hPUAIX2h2PO3bJVsFfm9H2FFbxdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amR4kxzjjJVi9GwqUDa6WueNucncts/yXJM/CBhVy1h842I2AmOSgn6Jqq6NtTr5AMtXKRS2/ZO/YcltVGarU709uUduoAqNsW/I1TEodS733RsaHrhkZhq4h8CrQKBA/Vp922P6oVEsZe4jbAHV/3iSxfNxt82j94W4qofD9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhtdOzjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F1DC116C6;
	Tue, 24 Feb 2026 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891731;
	bh=pa+SU9lNeb8yTs+hPUAIX2h2PO3bJVsFfm9H2FFbxdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhtdOzjWFoYBVVOOjWR83jInB6cpt1EmHykFDQEEb1PdQP4p05FfQ+E6Re691FTES
	 QSWwTgHqs4VNuVvMxqc04VN4tLkaa7j7F4cW3iqX/eSN1rbCoKC3YEdwZtZRmK4apj
	 A731l9tlIZAYM7C6KPW8Lx1Qr5pzbTXehwqCJ6Py6wpIsP0YBoMWrbM7sgFjaro2J6
	 xl0b+7QO4u9QwLBoTm9UDBYvP7cMpI9fa9hTs9iLeodL3B9h3VuHkp7Mn6Xf+zzsse
	 ibnwkl4TJKqHharL7SZnXLqHwkTYTIxsd2v9Jn7xmt8VRh/S+LpeNvGAHkEleQrLbk
	 W9+CD72boCh5A==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	edumazet@google.com,
	pabeni@redhat.com,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,5/8] net: macb: add XDP support for gem
Date: Mon, 23 Feb 2026 16:08:44 -0800
Message-ID: <20260224000844.140431-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223182632.1681809-6-pvalerio@redhat.com>
References: <20260223182632.1681809-6-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260265-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3F4A8180241
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: add XDP support for gem

This patch introduces basic XDP support for the macb/gem driver with
XDP_PASS, XDP_DROP, and XDP_REDIRECT verdict support.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index a78ad00f53b1..33a963b6dd4d 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -15,6 +15,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/workqueue.h>
>  #include <net/page_pool/helpers.h>
> +#include <net/xdp.h>

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 708107e47ae3..26b517ed251c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1247,9 +1248,27 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	return packets;
>  }
>
> +static unsigned int gem_rx_headroom(struct macb *bp)
> +{
> +	if (rcu_access_pointer(bp->prog))
> +		return XDP_PACKET_HEADROOM;
> +
> +	return NET_SKB_PAD;
> +}
> +
> +static unsigned int gem_max_rx_data_size(int base_sz)
> +{
> +	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
> +}
> +
> +static unsigned int gem_max_rx_buffer_size(int data_sz, struct macb *bp)
> +{
> +	return SKB_HEAD_ALIGN(data_sz + bp->rx_headroom);
> +}

[ ... ]

> @@ -1340,12 +1360,61 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
>  	 */
>  }
>
> +static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
> +		       unsigned int len)
> +{
> +	struct net_device *dev;
> +	struct bpf_prog *prog;
> +	struct xdp_buff xdp;
> +
> +	u32 act = XDP_PASS;
> +
> +	rcu_read_lock();
> +
> +	prog = rcu_dereference(queue->bp->prog);
> +	if (!prog)
> +		goto out;
> +
> +	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
> +	xdp_prepare_buff(&xdp, buff_head, queue->bp->rx_headroom, len, false);
> +	xdp_buff_clear_frags_flag(&xdp);
> +	dev = queue->bp->dev;
> +
> +	act = bpf_prog_run_xdp(prog, &xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		goto out;
> +	case XDP_REDIRECT:
> +		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
> +			act = XDP_DROP;
> +			break;
> +		}
> +		goto out;
> +	default:
> +		bpf_warn_invalid_xdp_action(dev, prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(dev, prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		break;
> +	}

Does this function need to handle XDP_TX? The driver advertises
NETDEV_XDP_ACT_BASIC (set in macb_probe() below), which declares support
for XDP_ABORTED, XDP_DROP, XDP_PASS, and XDP_TX per the UAPI definition
in include/uapi/linux/netdev.h. An XDP program returning XDP_TX will fall
through to the default case, call bpf_warn_invalid_xdp_action(), and
treat it as XDP_DROP. The packet won't be transmitted; it will be dropped
with a warning instead.

[ ... ]

> @@ -2641,21 +2724,23 @@ static int macb_alloc_consistent(struct macb *bp)
>  	return -ENOMEM;
>  }
>
> -static int gem_create_page_pool(struct macb_queue *queue)
> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>  {
>  	struct page_pool_params pp_params = {
>  		.order = 0,
>  		.flags = PP_FLAG_DMA_MAP,
>  		.pool_size = queue->bp->rx_ring_size,
>  		.nid = NUMA_NO_NODE,
> -		.dma_dir = DMA_FROM_DEVICE,
> +		.dma_dir = rcu_access_pointer(queue->bp->prog)
> +				? DMA_BIDIRECTIONAL
> +				: DMA_FROM_DEVICE,
>  		.dev = &queue->bp->pdev->dev,
>  		.netdev = queue->bp->dev,
>  		.napi = &queue->napi_rx,
>  		.max_len = PAGE_SIZE,
>  	};
>  	struct page_pool *pool;
> -	int err = 0;
> +	int err;
>
>  	/* This can happen in the case of HRESP error.
>  	 * Do nothing as page pool is already existing.
>  	 */
>  	if (queue->page_pool)
>  		return err;
                       ^^^

Does this return an uninitialized value? The patch changed 'int err = 0'
to 'int err' without initialization. The early-return path for HRESP error
recovery returns err when the page pool already exists.

gem_init_rings() calls this function during HRESP error recovery:

drivers/net/ethernet/cadence/macb_main.c:gem_init_rings()
	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
		...
		err = gem_create_page_pool(queue, q);
		if (err) {
			last_err = err;
			if (fail_early)
				return err;
			continue;
		}

When err is non-zero, gem_init_rings() skips gem_rx_refill() for that
queue via continue, potentially leaving the RX queue without buffers.

The unmodified macb_hresp_error_task() calls mog_init_rings(bp, false)
which calls gem_init_rings() to recover from HRESP errors. During
recovery, page pools already exist from the initial open, so the
early-return is taken. If err happens to be non-zero, gem_init_rings()
skips gem_rx_refill(), breaking packet reception on affected queues after
HRESP error recovery.

[ ... ]

> @@ -3167,11 +3275,27 @@ static int macb_close(struct net_device *dev)
>  	return 0;
>  }
>
> +static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
> +{
> +	int max_frame_size;
> +
> +	max_frame_size = gem_max_rx_buffer_size(gem_max_rx_data_size(mtu), bp);
> +
> +	return max_frame_size <= PAGE_SIZE;
> +}

Looking at the XDP setup flow, is this MTU validation using the correct
headroom value?

When gem_xdp_setup() calls gem_xdp_valid_mtu():

drivers/net/ethernet/cadence/macb_main.c:gem_xdp_setup()
	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
		return -EOPNOTSUPP;
	}

	running = netif_running(dev);
	need_update = !!bp->prog != !!prog;
	if (running && need_update)
		macb_close(dev);

	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());

The validation happens before bp->prog is updated. gem_max_rx_buffer_size()
uses bp->rx_headroom, which is cached during macb_init_rx_buffer_size().
At validation time, bp->rx_headroom still holds the non-XDP value
(NET_SKB_PAD, typically 64 bytes) rather than the XDP value
(XDP_PACKET_HEADROOM = 256 bytes). This makes the validation 192 bytes too
permissive.

An MTU close to the PAGE_SIZE limit could pass validation but then cause
gem_total_rx_buffer_size() to exceed PAGE_SIZE once the correct XDP
headroom is applied in macb_open()->macb_init_rx_buffer_size().

[ ... ]

> @@ -5744,13 +5911,9 @@ static int macb_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_out_phy_exit;
>
> -	if (macb_is_gem(bp)) {
> -		bp->rx_headroom = NET_SKB_PAD;
> -		if (!(bp->caps & MACB_CAPS_RSC)) {
> -			bp->rx_ip_align = NET_IP_ALIGN;
> -			bp->rx_headroom += NET_IP_ALIGN;
> -		}
> -	}
> +	if (macb_is_gem(bp))
> +		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> +				    NETDEV_XDP_ACT_REDIRECT;

Is NETDEV_XDP_ACT_BASIC accurate here? Looking at gem_xdp_run() above,
XDP_TX falls through to the default case and is treated as XDP_DROP with
a warning. NETDEV_XDP_ACT_BASIC includes XDP_TX support per the UAPI
definition, but the driver doesn't implement it.

