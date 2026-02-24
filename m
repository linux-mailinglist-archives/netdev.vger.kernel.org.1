Return-Path: <netdev+bounces-260268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL1+BWHsnGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:10:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D9180257
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E93B30FE618
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA652F88;
	Tue, 24 Feb 2026 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IebXjK7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12D3B2BA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891743; cv=none; b=o9BdCYhDUutkZzD+tUrojhcyr0qbu4skeSY/KJ8OdHJOeH4K4FLPZwCFaGvbjbcC3hc4TRJUdK//duT8zcQA6FSzMkEJfrXRSfZnXn2Akdo6V9xqUjBI6SNRjVbO9D7dXikEoqd7LCZYd5QyjlfV9r9zki4qDY283uso5Bot8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891743; c=relaxed/simple;
	bh=hCbT+RxB2dAHgQXpOwj2rv/LkuTLM80uzjuB6ZOI5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Slglpz0FaR9sD1pvEnE1VjTLmd7cyDgJ3Bow6wghopZjPasNLmHSDZQFlm8tBOzRskR3AzXgkCVvHqE3jhvgOd47jRhN7cZYiPAszjv2iB3UJPLeaPRIMLX/XL4rBpg8xe6HGNtxTolsuScA1s2rBvRZ0AkWVsHpfCTb67RQbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IebXjK7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE49C19421;
	Tue, 24 Feb 2026 00:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891743;
	bh=hCbT+RxB2dAHgQXpOwj2rv/LkuTLM80uzjuB6ZOI5E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IebXjK7kW4rjGyEhRnodOiDOMjSccv8PiaRirEnXpWyTy8TUgKEAilXDHrw9BBnWu
	 FXRP/ft/N9ZZsuUlswy7d+0hIatDImsaLk550mE/xdOd9RCqvTawln3S6N2wtly5s+
	 oDftPHVoCEJNKL+fdHFywuZXeMkz+3s6XngdEzhZqfjpyMBWO/qum/W7bXr3ZbxmX5
	 u3A9+ytIjT/ys2WBLObIF4tzVWzvMCHQ/cI2dX3MWeweEPohhLlFYa96QvbM5B0caF
	 X5x+pxPDFNMviam1dB1jWxOVyyKDm8TakK2ZCzx7vaah81RkNz3LA790c/U3JBNBct
	 hlU//+g5Nyo/w==
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
Subject: Re: [net-next,v2,8/8] net: macb: introduce xmit support
Date: Mon, 23 Feb 2026 16:09:02 -0800
Message-ID: <20260224000902.140599-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223182632.1681809-9-pvalerio@redhat.com>
References: <20260223182632.1681809-9-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260268-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 463D9180257
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: introduce xmit support

This commit adds XDP_TX verdict support and introduces ndo_xdp_xmit
function for redirection. It updates macb_tx_unmap() to handle both
skbs and xdp frames advertising NETDEV_XDP_ACT_NDO_XMIT capability.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 50646ee90672..69392ec0065f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -967,6 +967,17 @@ static int macb_halt_tx(struct macb *bp)
>  					bp, TSR);
>  }
>
> +static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
> +{
> +	if (type == MACB_TYPE_SKB) {
> +		napi_consume_skb(buff, budget);
> +	} else if (type == MACB_TYPE_XDP_TX) {
> +		xdp_return_frame_rx_napi(buff);
                        ^^^^

Can xdp_return_frame_rx_napi() be called in workqueue context?

This function is only safe in NAPI or softirq context because it calls
__xdp_return() with napi_direct=true, which eventually calls
bpf_net_ctx_get_ri() -> bpf_net_ctx_get(), dereferencing
current->bpf_net_context without a NULL check.

In NAPI context, bpf_net_context is set up by bpf_net_ctx_set() in
net_rx_action/napi_poll. In workqueue context, current->bpf_net_context
is NULL.

macb_tx_release_buff() is called from macb_tx_unmap(), which is called
from macb_tx_error_task(). macb_tx_error_task() runs as a workqueue
task, scheduled by:

  macb_interrupt() ->
    schedule_work(&queue->tx_error_task) ->
      macb_tx_error_task() ->
        macb_tx_unmap() ->
          macb_tx_release_buff(ptr, MACB_TYPE_XDP_TX, 0) ->
            xdp_return_frame_rx_napi() ->
              __xdp_return(napi_direct=true) ->
                xdp_return_frame_no_direct() ->
                  bpf_net_ctx_get_ri() ->
                    NULL deref crash

Should this use xdp_return_frame() instead of xdp_return_frame_rx_napi()
when not in NAPI context, similar to how napi_consume_skb() uses the
budget parameter to distinguish contexts (budget=0 means non-NAPI)?

> +	} else {
> +		xdp_return_frame(buff);
> +	}
> +}
> +

[ ... ]

> @@ -1069,6 +1080,10 @@ static void macb_tx_error_task(struct work_struct *work)
>  		desc = macb_tx_desc(queue, tail);
>  		ctrl = desc->ctrl;
>  		tx_buff = macb_tx_buff(queue, tail);
> +
> +		if (tx_buff->type != MACB_TYPE_SKB)
> +			goto unmap;
> +
>  		skb = tx_buff->ptr;

Does macb_tx_error_task() hold the necessary locks when accessing the TX
ring?

macb_tx_error_task accesses queue->tx_head (loop boundary in line 1077)
and queue->tx_tail without holding queue->tx_ptr_lock. It only holds
bp->lock.

The new macb_xdp_submit_frame modifies queue->tx_head (line 1461) under
tx_ptr_lock but BEFORE acquiring the nested bp->lock (line 1464).

macb_tx_error_task only calls napi_disable(&queue->napi_tx), so RX NAPI
(which calls gem_xdp_run -> macb_xdp_submit_frame for XDP_TX) remains
active. netif_tx_stop_all_queues does not stop ndo_xdp_xmit (gem_xdp_xmit
-> macb_xdp_submit_frame).

The race can occur:

  CPU 0: macb_tx_error_task
    - holds bp->lock
    - iterates ring using tx_head as boundary

  CPU 1: macb_xdp_submit_frame
    - acquires tx_ptr_lock
    - submits a frame
    - updates tx_head
    - blocks on bp->lock

  CPU 0:
    - sees updated tx_head
    - iterates into newly submitted frame
    - frees its buffer via macb_tx_unmap
    - resets tx_head=0, tx_tail=0

  CPU 1:
    - acquires bp->lock
    - kicks TSTART on reset ring

This results in a freed DMA buffer in an active ring, and inconsistent
tx_head/tx_tail state.

[ ... ]

> @@ -1184,6 +1200,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>  	head = queue->tx_head;
>  	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
> +		void			*data = NULL;
>  		struct macb_tx_buff	*tx_buff;
>  		struct sk_buff		*skb;
>  		struct macb_dma_desc	*desc;

[ ... ]

> @@ -1206,11 +1223,16 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  		for (;; tail++) {
>  			tx_buff = macb_tx_buff(queue, tail);
>
> -			if (tx_buff->type == MACB_TYPE_SKB)
> -				skb = tx_buff->ptr;
> +			if (tx_buff->type != MACB_TYPE_SKB) {
> +				data = tx_buff->ptr;
> +				goto unmap;
> +			}
>
>  			/* First, update TX stats if needed */
> -			if (skb) {
> +			if (tx_buff->type == MACB_TYPE_SKB && tx_buff->ptr) {
                    ^^^^

This isn't a bug, but could the type check here be simplified?

At line 1226, non-SKB types are filtered out with 'if (tx_buff->type !=
MACB_TYPE_SKB) goto unmap'. At line 1232, the condition checks the type
again with 'if (tx_buff->type == MACB_TYPE_SKB && tx_buff->ptr)', but at
this point the type is always MACB_TYPE_SKB.

The condition could be simplified to 'if (tx_buff->ptr)' for clarity.

> +				data = tx_buff->ptr;
> +				skb = tx_buff->ptr;
> +

[ ... ]

