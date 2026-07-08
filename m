Return-Path: <netdev+bounces-305755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKmjI/knTmoBEQIAu9opvQ
	(envelope-from <netdev+bounces-305755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2C724629
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:35:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cbvY2dAn;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305755-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658C130B3CC0
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80562420E7C;
	Wed,  8 Jul 2026 10:29:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABB40245A
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:29:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506550; cv=none; b=tbedXWaC+hKV/LiRH7qyX/h4i5CXNfI1jp8qGr85hW3HoaWF399u1WDfQKq+4aLaiSdcEvFHoVp+DVjzxNB4IRnw99KNmDhhyAifqKVygQq+OcOKw7Cs75a4ZhPtdDDfxbdq2jAChst9UwNjEW1juRWPEdDUBysGqfsN/75+9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506550; c=relaxed/simple;
	bh=2t3E1/0xS0XXOKRO6cCSiH4uZyYW+8gF84n/unnSMRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTVQd95kKTm+Omwd5wGxhTvOt4uS44IT3ReaBG2C4jQmoHK24p5ES0wJwVIhkpxeSA3zk4vTjYuIgGoBh9tFST29Rz1SWqRtr0MZx28LLyiBJb3LIfaR/sWrSERqY70TX8WzbgHwVdVDo56R4tk2GxSYDLY5H4TO/SDie12QlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbvY2dAn; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccaL/aUC9kUBKct9kVBnzfixSBmhgaadjyvZzfo3xN4=;
	b=cbvY2dAn2TGpYUpYDoIpGF7pAgpE3lDrb1ul3gaJfhmbLC2+CEUEmBG8iw6SXsqERtdJhi
	HjwynMnmMCvTlTQlyA0IilLmvLgcRr20issEZ+0TfYJG/2L6avhDXfwgiExII4uyRKsB6o
	/pESYfeEoJcEDuqMmjuyQUmeEOEemh4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-UlnjUOy7NbKmTa4BUgMvaA-1; Wed,
 08 Jul 2026 06:27:32 -0400
X-MC-Unique: UlnjUOy7NbKmTa4BUgMvaA-1
X-Mimecast-MFC-AGG-ID: UlnjUOy7NbKmTa4BUgMvaA_1783506449
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 704151800651;
	Wed,  8 Jul 2026 10:27:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB1C418005B9;
	Wed,  8 Jul 2026 10:27:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	pvalerio@redhat.com,
	nb@tipi-net.de,
	vladimir.kondratiev@mobileye.com,
	gregory.clement@bootlin.com,
	benoit.monin@bootlin.com,
	tawfik.bayouk@mobileye.com,
	thomas.petazzoni@bootlin.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v3 07/15] net: macb: introduce macb_context struct for buffer management
Date: Wed,  8 Jul 2026 12:27:16 +0200
Message-ID: <20260708102716.169767-1-pabeni@redhat.com>
In-Reply-To: <20260701-macb-context-v3-7-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-7-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-305755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0F2C724629

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: macb: introduce macb_context struct for buffer management

This patch moves per-queue ring buffers and ring-size parameters out of
struct macb / struct macb_queue into a new struct macb_context that is
allocated on open and freed on close, so future patches can swap in a
new context while the interface is running.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 951a7f080225..dfb1d49d841c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1257,6 +1288,7 @@ static void macb_tx_error_task(struct work_struct *work)
>  	struct macb_queue *queue = container_of(work, struct macb_queue,
>  						tx_error_task);
>  	unsigned int q = queue - queue->bp->queues;
> +	struct macb_txq *txq = macb_txq(queue);
>  	struct macb *bp = queue->bp;

[High]
Can macb_tx_error_task() dereference a freed context?

macb_tx_error_task is scheduled from macb_interrupt():

    schedule_work(&queue->tx_error_task);

After this patch, the very first thing the worker does is:

    struct macb_txq *txq = macb_txq(queue);

which expands to &bp->ctx->txq[q] and dereferences bp->ctx.

Looking at macb_close():

    macb_reset_hw(bp);
    ...
    macb_free(bp);
    kfree(bp->ctx);
    bp->ctx = NULL;

There is no cancel_work_sync(&queue->tx_error_task), and macb_reset_hw()
does not drain the workqueue. If an interrupt scheduled the work just
before close, or the work was already pending, the worker can run after
kfree(bp->ctx) and hit a NULL dereference (and a use-after-free if
macb_open() re-allocates ctx concurrently via ethtool ring reconfig).

The same reasoning applies to bp->hresp_err_bh_work, which is queued
from macb_interrupt() and whose handler calls
mog_init_rings()/macb_init_buffers() that read bp->ctx->tx_ring_size and
bp->ctx->{tx,rx}q[q]. cancel_work_sync(&bp->hresp_err_bh_work) is only
called from macb_remove(), not macb_close().

Pre-patch these fields lived inside the embedded struct macb_queue so a
late worker would touch stale-but-addressable memory; post-patch the
first indirection through bp->ctx faults.

Would adding cancel_work_sync(&queue->tx_error_task) per queue and
cancel_work_sync(&bp->hresp_err_bh_work) before kfree(bp->ctx) in
macb_close() close this window?

[ ... ]

> @@ -3690,8 +3778,8 @@ static int macb_set_ringparam(struct net_device *netdev,
>  		macb_close(bp->netdev);
>  	}
>  
> -	bp->rx_ring_size = new_rx_size;
> -	bp->tx_ring_size = new_tx_size;
> +	bp->configured_rx_ring_size = new_rx_size;
> +	bp->configured_tx_ring_size = new_tx_size;
>  
>  	if (reset)
>  		macb_open(bp->netdev);

[Medium]
Should the return value of macb_open() be checked here?

This patch adds a new failure point inside macb_open():

    bp->ctx = kzalloc_obj(*bp->ctx);
    if (!bp->ctx) {
        err = -ENOMEM;
        goto pm_exit;
    }

On failure, bp->ctx remains NULL and the interface stays down, but
macb_set_ringparam() ignores the return value and reports success to
userspace. The commit message says the motivation is to improve
reliability under memory pressure, but this caller silently swallows the
new allocation failure.

[ ... ]

> @@ -5039,6 +5125,12 @@ static int at91ether_open(struct net_device *netdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	bp->ctx = kzalloc_obj(*bp->ctx);
> +	if (!bp->ctx) {
> +		ret = -ENOMEM;
> +		goto pm_exit;
> +	}
> +
>  	/* Clear internal statistics */
>  	ctl = macb_readl(bp, NCR);
>  	macb_writel(bp, NCR, ctl | MACB_BIT(CLRSTAT));

[Low]
Should bp->ctx->rx_ring_size, tx_ring_size and rx_buffer_size be
initialized on this path?

macb_open() sets them from configured_{rx,tx}_ring_size and calls
macb_init_rx_buffer_size(), but at91ether_open() leaves them at zero
after kzalloc_obj().

Helpers such as macb_rx_ring_wrap() compute:

    return index & (bp->ctx->rx_ring_size - 1);

which becomes index & 0xFFFFFFFF when rx_ring_size is 0. It happens to
be harmless today because the at91ether path constrains indices to
[0, AT91ETHER_MAX_RX_DESCR-1] independently and macb_get_regs() reports
zeroed head/tail for the tx-less at91ether, but pre-patch macb_init_dflt()
unconditionally set bp->rx_ring_size = DEFAULT_RX_RING_SIZE.

Any future shared helper that used tx_ring_size as a stride or divisor
would misbehave on at91ether.

[ ... ]

> @@ -5076,6 +5171,9 @@ static int at91ether_close(struct net_device *netdev)
>  
>  	at91ether_stop(bp);
>  
> +	kfree(bp->ctx);
> +	bp->ctx = NULL;
> +
>  	pm_runtime_put(&bp->pdev->dev);
>  
>  	return 0;

[High]
Is there IRQ synchronization missing before freeing bp->ctx on this
path?

at91ether_stop() disables MAC RX/TX and writes IDR to mask further
interrupts, but does not synchronize with a handler already running or
already dispatched on another CPU. at91ether_interrupt() calls
at91ether_rx(), which after this patch does:

    struct macb_rxq *rxq = &bp->ctx->rxq[0];
    ...
    desc = macb_rx_desc(queue, rxq->tail);
    ...
    p_recv = rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;

If the handler is in flight when kfree(bp->ctx); bp->ctx = NULL runs,
the next access through bp->ctx faults. The macb_open()/macb_close()
path is somewhat protected by napi_disable() before macb_free(), but
at91ether does not use NAPI and has no equivalent barrier.

Would a synchronize_irq(bp->netdev->irq) between at91ether_stop() and
kfree(bp->ctx) close this?
-- 
This is an AI-generated review.


