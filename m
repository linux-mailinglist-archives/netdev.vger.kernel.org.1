Return-Path: <netdev+bounces-264003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMWcBFh7qGm4uwAAu9opvQ
	(envelope-from <netdev+bounces-264003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:35:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761112066FE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E16130C8398
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D763D5235;
	Wed,  4 Mar 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0r+XExvA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBD3E123F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648701; cv=none; b=ImGkZWlvE0mdF6JHi8j3VwF1dnm4/T/J9As8D1djylhf6iF1JUXOo6Zbk15SvodyKlITLzHcFIhouFdvQbsH55+1kYMMWtnQSd6fZ0EbHPy3kEBjfzhjRz/xHYzQYrbQKahzDYAq179MiU/ilIPAgzjHyXCeqnGBaXviBc4JtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648701; c=relaxed/simple;
	bh=acX1lwKxA/kpYia2Nfc2aehMaCwtHIEVvKb6m9g4pOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5t6DR+EmuPZHTwknOatjVprz+nOOaSjdOI19zVVJTB+vQk4CqQs6hKK0YzFtZdCgA36jvqYQJng2e9Aus2q6IFz53jEB4MRKqdlr5E+AxeZX+xW56GoCkHPPWz2QAvPtNn3UuvSx9Bxk0vJy4sTon/htWYRaMItozGNF6AepDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0r+XExvA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 175191A2C77;
	Wed,  4 Mar 2026 18:24:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DFCEF5FF5C;
	Wed,  4 Mar 2026 18:24:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2522B10369606;
	Wed,  4 Mar 2026 19:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wdbgnZgPQID9OhTHaefDAPkKPH6Py0SmgPx68VwD8t4=;
	b=0r+XExvAHvGglakxWoa1Iifi5N3oBg8pcIxp+LN5u1kuWPMutlc3bGS5VgfajbukFVG3tk
	EUczG3WCzGj+zvzsOLMCb9iTIavAVxUV5HvTmZJ8ZDlKzDNt5xMkfLPgKjA86eCLIE5XWi
	RD542kpRPzgGOwJIi69ezL7mbz/NsoRzjdXjTOklzz9KilXrmAdsTSHblPPnYFimgFe2Gc
	A3KwjAE2alXQSuiDldUFMwG4aA4yxXdX0aDlYuSlSDbVDY3IbhtAJfGKOv7AHmcKrkqz+F
	qHDWvU+yNOpdrXW51u8fTYw6LxPSN69D8hQYwCsc41w6eXy+6GNOU2ZuKj32qA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:30 +0100
Subject: [PATCH net-next 7/8] net: macb: add Rx zero-copy AF_XDP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-7-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 761112066FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264003-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,xdp.data:url]
X-Rspamd-Action: no action

The Rx direction uses a page_pool instance as allocator created at open.
If present, exploit our new xsk_buff_pool located at queue->xsk_pool.
Allocate `struct xdp_buff` inside each queue->rx_buff[] slot instead of
raw pointers to the buffer start. Therefore, inside gem_rx() and
gem_xdp_run(), we get handed XDP buffers directly and need not to
allocate one on the stack to pass to the XDP program.

As this is a fresh implementation, jump straight to batch alloc rather
than the xsk_buff_alloc() API. We need two batch alloc calls at
wrap-around.

--

At open, in gem_create_page_pool() renamed to gem_init_pool():
 - Stop creating a page_pool if we have an XSK one.
 - Report proper values to xdp_rxq.

While running, in gem_rx(), gem_rx_refill() and gem_xdp_run():
 - Refill buffer slots using one/two calls to xsk_buff_alloc_batch().
 - Support running XDP program on a pre-allocated `struct xdp_buff`.
 - Adjust buffer free operations to support XSK. xsk_buff_free()
   replaces page_pool_put_full_page() if XSK is active.
 - End gem_rx() by marking the XSK need_wakeup flag.
 - When needed, wakeup is triggered by activating an IRQ from software,
   allowed by the hardware in the per-queue IMR register.

At close, in gem_free_rx_buffers():
 - Adjust the buffer free operation.
 - Don't destroy the page pool if we were in XSK mode.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 223 ++++++++++++++++++++++---------
 1 file changed, 161 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a72d59ffd1cf..ea1b0b8c4fab 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1398,18 +1398,39 @@ static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
 {
-	gfp_t gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
 	struct macb *bp = queue->bp;
+	struct xdp_buff **xdp_buffs = (struct xdp_buff **)queue->rx_buff;
+	gfp_t gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
+	struct xsk_buff_pool *xsk = queue->xsk_pool;
+	unsigned int size = bp->rx_ring_size;
 	struct macb_dma_desc *desc;
+	unsigned int offset;
 	unsigned int entry;
 	struct page *page;
 	dma_addr_t paddr;
 	int err = 0;
-	void *data;
-	int offset;
 
-	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
-			  bp->rx_ring_size) > 0) {
+	if (xsk) {
+		u32 head, tail, space_to_end, space_from_start, first_alloc;
+
+		/* CIRC_SPACE_TO_END() requires wrapping head & tail. */
+		head = macb_rx_ring_wrap(bp, queue->rx_prepared_head);
+		tail = macb_rx_ring_wrap(bp, queue->rx_tail);
+		space_to_end = CIRC_SPACE_TO_END(head, tail, size);
+		space_from_start = CIRC_SPACE(head, tail, size) - space_to_end;
+
+		first_alloc = xsk_buff_alloc_batch(xsk, xdp_buffs + head,
+						   space_to_end);
+
+		/*
+		 * Refill in two batch operations if we are wrapping around and
+		 * the first alloc batch gave us satisfaction.
+		 */
+		if (head + first_alloc == size && space_from_start)
+			xsk_buff_alloc_batch(xsk, xdp_buffs, space_from_start);
+	}
+
+	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail, size) > 0) {
 		entry = macb_rx_ring_wrap(bp, queue->rx_prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1417,26 +1438,38 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 
 		desc = macb_rx_desc(queue, entry);
 
-		page = page_pool_alloc_frag(queue->page_pool, &offset,
-					    gem_total_rx_buffer_size(bp),
-					    gfp_alloc | __GFP_NOWARN);
-		if (!page) {
+		if (xsk) {
+			/* Remember xdp_buffs is an alias to queue->rx_buff. */
+			if (xdp_buffs[entry])
+				paddr = xsk_buff_xdp_get_dma(xdp_buffs[entry]);
+		} else {
+			page = page_pool_alloc_frag(queue->page_pool, &offset,
+						    gem_total_rx_buffer_size(bp),
+						    gfp_alloc | __GFP_NOWARN);
+			if (page) {
+				queue->rx_buff[entry] = page_address(page) +
+							offset;
+				paddr = page_pool_get_dma_addr(page) +
+					gem_rx_pad(bp) + offset;
+				dma_sync_single_for_device(&bp->pdev->dev,
+							   paddr,
+							   bp->rx_buffer_size,
+							   page_pool_get_dma_dir(queue->page_pool));
+			}
+		}
+
+		/*
+		 * In case xsk_buff_alloc_batch() returned less than requested
+		 * or page_pool_alloc_frag() failed.
+		 */
+		if (!queue->rx_buff[entry]) {
 			dev_err_ratelimited(&bp->pdev->dev,
 					    "Unable to allocate rx buffer\n");
 			err = -ENOMEM;
 			break;
 		}
 
-		paddr = page_pool_get_dma_addr(page) + gem_rx_pad(bp) + offset;
-
-		dma_sync_single_for_device(&bp->pdev->dev,
-					   paddr, bp->rx_buffer_size,
-					   page_pool_get_dma_dir(queue->page_pool));
-
-		data = page_address(page) + offset;
-		queue->rx_buff[entry] = data;
-
-		if (entry == bp->rx_ring_size - 1)
+		if (entry == size - 1)
 			paddr |= MACB_BIT(RX_WRAP);
 		desc->ctrl = 0;
 		/* Setting addr clears RX_USED and allows reception,
@@ -1569,6 +1602,7 @@ static int gem_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue = &bp->queues[qid];
+	u32 irqs = 0;
 
 	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
@@ -1578,7 +1612,12 @@ static int gem_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 		     !queue->xsk_pool))
 		return -ENXIO;
 
-	/* no-op, until rx/tx implement XSK support */
+	if ((flags & XDP_WAKEUP_RX) &&
+	    !napi_if_scheduled_mark_missed(&queue->napi_rx))
+		irqs |= MACB_BIT(RCOMP);
+
+	if (irqs)
+		queue_writel(queue, IMR, irqs);
 
 	return 0;
 }
@@ -1587,10 +1626,11 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 		       unsigned int *len, unsigned int *headroom,
 		       dma_addr_t addr)
 {
-	struct net_device *dev;
+	struct xsk_buff_pool *xsk = queue->xsk_pool;
+	struct net_device *dev = queue->bp->dev;
+	struct xdp_buff xdp, *xdp_ptr;
 	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
-	struct xdp_buff xdp;
 
 	u32 act = XDP_PASS;
 
@@ -1600,25 +1640,35 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 	if (!prog)
 		goto out;
 
-	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
-	xdp_prepare_buff(&xdp, buff_head, *headroom, *len, false);
-	xdp_buff_clear_frags_flag(&xdp);
-	dev = queue->bp->dev;
+	if (xsk) {
+		/*
+		 * It was a lie all along: buff_head is not a buffer but a
+		 * struct xdp_buff that points to the actual buffer.
+		 */
+		xdp_ptr = buff_head;
+		xdp_ptr->data_end = xdp_ptr->data + *len;
+	} else {
+		/* Use a stack-allocated struct xdp_buff. */
+		xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
+		xdp_prepare_buff(&xdp, buff_head, *headroom, *len, false);
+		xdp_buff_clear_frags_flag(&xdp);
+		xdp_ptr = &xdp;
+	}
 
-	act = bpf_prog_run_xdp(prog, &xdp);
+	act = bpf_prog_run_xdp(prog, xdp_ptr);
 	switch (act) {
 	case XDP_PASS:
 		*len = xdp.data_end - xdp.data;
 		*headroom = xdp.data - xdp.data_hard_start;
 		goto out;
 	case XDP_REDIRECT:
-		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
+		if (unlikely(xdp_do_redirect(dev, xdp_ptr, prog))) {
 			act = XDP_DROP;
 			break;
 		}
 		goto out;
 	case XDP_TX:
-		xdpf = xdp_convert_buff_to_frame(&xdp);
+		xdpf = xdp_convert_buff_to_frame(xdp_ptr);
 		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
 							     dev, false, addr)) {
 			act = XDP_DROP;
@@ -1635,8 +1685,12 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 		break;
 	}
 
-	page_pool_put_full_page(queue->page_pool,
-				virt_to_head_page(xdp.data), true);
+	if (xsk)
+		xsk_buff_free(xdp_ptr);
+	else
+		page_pool_put_full_page(queue->page_pool,
+					virt_to_head_page(xdp.data), true);
+
 out:
 	rcu_read_unlock();
 
@@ -1647,14 +1701,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	unsigned int packets = 0, dropped = 0, bytes = 0;
+	struct xsk_buff_pool *xsk = queue->xsk_pool;
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	struct xdp_buff *xsk_xdp;
 	bool xdp_flush = false;
 	unsigned int headroom;
 	unsigned int entry;
 	struct page *page;
 	void *buff_head;
+	int refill_err;
 	int count = 0;
 	int data_len;
 	int nr_frags;
@@ -1686,6 +1743,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		count++;
 
 		buff_head = queue->rx_buff[entry];
+		xsk_xdp = buff_head;
 		if (unlikely(!buff_head)) {
 			dev_err_ratelimited(&bp->pdev->dev,
 					    "inconsistent Rx descriptor chain\n");
@@ -1701,10 +1759,14 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (data_len < 0)
 			goto free_frags;
 
-		dma_sync_single_for_cpu(&bp->pdev->dev,
-					addr + (first_frame ? bp->rx_ip_align : 0),
-					data_len,
-					page_pool_get_dma_dir(queue->page_pool));
+		if (xsk) {
+			xsk_buff_dma_sync_for_cpu(xsk_xdp);
+		} else {
+			dma_sync_single_for_cpu(&bp->pdev->dev,
+						addr + (first_frame ? bp->rx_ip_align : 0),
+						data_len,
+						page_pool_get_dma_dir(queue->page_pool));
+		}
 
 		if (first_frame) {
 			if (unlikely(queue->skb)) {
@@ -1813,10 +1875,13 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
-		if (buff_head)
+		if (buff_head && xsk) {
+			xsk_buff_free(xsk_xdp);
+		} else if (buff_head) {
 			page_pool_put_full_page(queue->page_pool,
 						virt_to_head_page(buff_head),
 						false);
+		}
 
 		dropped++;
 		queue->rx_buff[entry] = NULL;
@@ -1829,10 +1894,26 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	bp->dev->stats.rx_bytes += bytes;
 	queue->stats.rx_bytes += bytes;
 
+	if (!count) /* short-circuit */
+		return 0;
+
 	if (xdp_flush)
 		xdp_do_flush();
 
-	gem_rx_refill(queue, true);
+	refill_err = gem_rx_refill(queue, true);
+	if (refill_err)
+		count = budget;
+
+	if (xsk && xsk_uses_need_wakeup(xsk)) {
+		unsigned int desc_available = CIRC_SPACE(queue->rx_prepared_head,
+							 queue->rx_tail,
+							 bp->rx_ring_size);
+
+		if (refill_err || !desc_available)
+			xsk_set_rx_need_wakeup(xsk);
+		else
+			xsk_clear_rx_need_wakeup(xsk);
+	}
 
 	return count;
 }
@@ -2816,9 +2897,16 @@ static void gem_free_rx_buffers(struct macb *bp)
 			if (!data)
 				continue;
 
-			page_pool_put_full_page(queue->page_pool,
-						virt_to_head_page(data),
-						false);
+			if (queue->xsk_pool) {
+				struct xdp_buff *xdp = data;
+
+				xsk_buff_free(xdp);
+			} else {
+				page_pool_put_full_page(queue->page_pool,
+							virt_to_head_page(data),
+							false);
+			}
+
 			queue->rx_buff[i] = NULL;
 		}
 
@@ -2831,8 +2919,10 @@ static void gem_free_rx_buffers(struct macb *bp)
 		queue->rx_buff = NULL;
 		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
 			xdp_rxq_info_unreg(&queue->xdp_rxq);
-		page_pool_destroy(queue->page_pool);
-		queue->page_pool = NULL;
+		if (!queue->xsk_pool) {
+			page_pool_destroy(queue->page_pool);
+			queue->page_pool = NULL;
+		}
 	}
 }
 
@@ -2987,7 +3077,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static int gem_create_page_pool(struct macb_queue *queue, int qid)
+static int gem_init_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
@@ -3002,24 +3092,32 @@ static int gem_create_page_pool(struct macb_queue *queue, int qid)
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
-	struct page_pool *pool;
-	int err;
+	struct xsk_buff_pool *xsk = queue->xsk_pool;
+	enum xdp_mem_type mem_type;
+	void *allocator;
+	int err = 0;
 
-	/* This can happen in the case of HRESP error.
-	 * Do nothing as page pool is already existing.
-	 */
-	if (queue->page_pool)
-		return 0;
+	if (xsk) {
+		mem_type = MEM_TYPE_XSK_BUFF_POOL;
+		allocator = xsk;
+	} else {
+		/* This can happen in the case of HRESP error.
+		 * Do nothing as page pool is already existing.
+		 */
+		if (queue->page_pool)
+			return 0;
 
-	pool = page_pool_create(&pp_params);
-	if (IS_ERR(pool)) {
-		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
-		err = PTR_ERR(pool);
-		goto clear_pool;
+		queue->page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(queue->page_pool)) {
+			netdev_err(queue->bp->dev, "cannot create rx page pool\n");
+			err = PTR_ERR(queue->page_pool);
+			goto clear_pool;
+		}
+
+		mem_type = MEM_TYPE_PAGE_POOL;
+		allocator = queue->page_pool;
 	}
 
-	queue->page_pool = pool;
-
 	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
 			       queue->napi_rx.napi_id);
 	if (err < 0) {
@@ -3027,8 +3125,7 @@ static int gem_create_page_pool(struct macb_queue *queue, int qid)
 		goto destroy_pool;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 queue->page_pool);
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, mem_type, allocator);
 	if (err) {
 		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
 		goto unreg_info;
@@ -3039,9 +3136,11 @@ static int gem_create_page_pool(struct macb_queue *queue, int qid)
 unreg_info:
 	xdp_rxq_info_unreg(&queue->xdp_rxq);
 destroy_pool:
-	page_pool_destroy(pool);
+	if (!xsk)
+		page_pool_destroy(queue->page_pool);
 clear_pool:
-	queue->page_pool = NULL;
+	if (!xsk)
+		queue->page_pool = NULL;
 
 	return err;
 }
@@ -3084,7 +3183,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure. In case of HRESP error
 		 * recovery we always reuse the existing page pool.
 		 */
-		last_err = gem_create_page_pool(queue, q);
+		last_err = gem_init_pool(queue, q);
 		if (last_err)
 			break;
 

-- 
2.53.0


