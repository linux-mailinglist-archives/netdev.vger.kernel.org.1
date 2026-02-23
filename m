Return-Path: <netdev+bounces-260146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIxDOBecnGmhJgQAu9opvQ
	(envelope-from <netdev+bounces-260146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AEF17B784
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33114305CAB6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FE340287;
	Mon, 23 Feb 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6rghQV/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rXlrkP81"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF6340298
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871239; cv=none; b=BsDJRlr8a2Q9gMESPpuGy22XOAOSt4guKqZ/+WyAb8RuoJYvII7zpvu5zWue2SkZomSEG7qtwTTbAbUwUlcesX95zHENTO8BYAeF62yO5XDsrUWIHXt6sOzeL6mZ+I6kG2oOsAYxW/OCW4B8VFKf/Ow7ZPvIeenw9ceE7J1QGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871239; c=relaxed/simple;
	bh=uJJtaDAcCBKn0LJ8NjqiEs9Nb0mxd4sFxvyOonkjt58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBkublWVdbIx6zgrWMB/4BDV/7N4eSUYpTnroF6qCW83RmPeCgQkh6PVTPtlHa8cAL91jheymoG4Eusp1cak1v8ipFaMRO4AJAcPdC/I3UYS3zAQA/WvkhIEMYM3d+mrLnuhcWIT/w+2RN580hmm9c+iyJe67KeJgwKDwjSDLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6rghQV/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rXlrkP81; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bECP4s++mBRhEZZvhzIxwWGDmcdScRnBqUi00y+mNwk=;
	b=Y6rghQV/GO8QDfgjZa1EScmnvwLejkHUFsZLRSmRBqsOgqT8fiXtnL3QaCm/B9Sw7jXa7x
	pUHBd3boXSQIYocMaCPz77zHiQ98R2SpMQw31DB1zX++le36O+Cjl7AHFYdR20/FXbUBgu
	2mV/+mipvrGNQRdwDRI/tKPT8Z3zrTM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-CWtNnvrLOq6URCyOfWn7tg-1; Mon, 23 Feb 2026 13:27:16 -0500
X-MC-Unique: CWtNnvrLOq6URCyOfWn7tg-1
X-Mimecast-MFC-AGG-ID: CWtNnvrLOq6URCyOfWn7tg_1771871235
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-437681ecd32so4119963f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871234; x=1772476034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bECP4s++mBRhEZZvhzIxwWGDmcdScRnBqUi00y+mNwk=;
        b=rXlrkP81OHnEIk8jwHMzFpZz/GX9odgExjT3PclVfcL08mZpFPrdlGBu3E+O8yyb3S
         lgzuO5x9qMkUzosyMBTz3CqnD3eUHJxZB31J5xo21s6Jg6lncdzAPWx8/J6HD8tgRHex
         WobzONAnLjZlS+np39eEpJVFeg6KcklaOZNe3D3hzQn7E21LXQfX8GaWRFo+9XirgOv1
         TgQDRbQ6NL+8mxcLLlVLB1uQUi6SYEYo+/LI24d/+Z2UvVj2rH/nmyn495H9KeaKCL9e
         6VJ68A5lL1QBUwDleB4EHPXEJg2vu9ZkduB5jEiU/Y+ccd5CXkU6uR3RuyuvRDSe2/9h
         HHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871234; x=1772476034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bECP4s++mBRhEZZvhzIxwWGDmcdScRnBqUi00y+mNwk=;
        b=Sop1FrAPdQmF2T3ah2bcNqsyBK+A8YvqRCiNOEn8AgfYtZ9ODclpXbnIFsIIP4ZVu/
         gxNw7y06pthq/P1wtOM1SX7yq4NBPNFh6S6HSWehQiQfw23Mv5Ha2ODFeqR4VUOt5gPS
         teTUA2MpGFHwrG9UQfR4+Bok6bI4/CkZ5suN5jBsgZDuXklVizQu7B2WT1z7wNG1junW
         Zctave93ajKdwQcVOmObvhYdxOtmpId8zYipag/KWhLiAPvl+WiwIIs2ZDCwkacyvOWT
         0EGtAjpgpIjxBN9J0tBGQ1BknwI+OHJWsxGibfHWWUDv1z7f3UXiSqSTSbnliF6b87Zb
         Xw9A==
X-Gm-Message-State: AOJu0Yz1zJxuwY9nljc+rF7Yh4/jPUkPDo4VPPeYyVirdcm0FhxQgE2z
	gfXig2e5qSW+lK7bBgR/86T3EAuPwTdRY5g5uX8tpPLOJXOBQJB9tn2A/N07b/1xz47GY/XcB0r
	LmllIZwapG+vhgUT4xfjTS6Nhlw+BvAms9vCQfaoz4sO0V224qSKUGOWeH88OmnihrKKiopwL48
	MvZWbIKE2pPaeqy+dXhPjiuet+3392yFrvLqf0l5qGWA==
X-Gm-Gg: ATEYQzytQ45m+vj3QeqPF+9FRun8qSwDNryzTsiPTSMJmvBH+hjICFBY8oc0TR9tMRQ
	aj5RxYsS4wWdSvgDAR4AhgGbu8/fKQu8OeIOBIvb3G8/NSQ6boVzRJP2j2k6itqmWqa0EO5AagR
	A2XZl28Jb2qpPNPQN5YYEt2VmWAOCQzjjz4TciNbYwcnBeOhFWaxNg44ZP7pbisBs1uSOPQ6bym
	057AYFEfp44c0PakXnwZnKbf0SRTuCqa2C8MDvC5ZT51pEg459pnOHqpD7WLsjUpS9GalO0mJ5q
	YzMJstIH3H2WaDEb5CwM7ymkUyK4g4O8vlZxPKQpyWophkDleTfB/+sIJRuWjKgLD0ivk/3CcS0
	1Np0Zd1wqB9RAKSYHSyJahf5ezINlQU4EO/ubxVvgEMkzShaMz5w0yPQqgAc=
X-Received: by 2002:a05:6000:250a:b0:435:9d3f:92eb with SMTP id ffacd0b85a97d-4396f1519a9mr17736284f8f.1.1771871234102;
        Mon, 23 Feb 2026 10:27:14 -0800 (PST)
X-Received: by 2002:a05:6000:250a:b0:435:9d3f:92eb with SMTP id ffacd0b85a97d-4396f1519a9mr17736226f8f.1.1771871233543;
        Mon, 23 Feb 2026 10:27:13 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d40004sm20886025f8f.21.2026.02.23.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:12 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Mon, 23 Feb 2026 19:26:25 +0100
Message-ID: <20260223182632.1681809-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260146-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34AEF17B784
X-Rspamd-Action: no action

From: Théo Lebrun <theo.lebrun@bootlin.com>

mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
up all slots with valid buffers.

gem_rx_refill() is called at link up by
gem_init_rings() == bp->macbgem_ops.mog_init_rings().

Move operation to macb_open(), mostly to allow it to fail early and
loudly rather than init the device with Rx mostly broken.

About `bool fail_early`:
 - When called from macb_open(), ring init fails as soon as a queue
   cannot be refilled.
 - When called from macb_hresp_error_task(), we do our best to reinit
   the device: we still iterate over all queues and try refilling all
   even if a previous queue failed.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 36 ++++++++++++++++++------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..2cb65ec37d44 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1180,7 +1180,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..8cc16f2b4024 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1247,13 +1247,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	unsigned int		entry;
 	struct sk_buff		*skb;
 	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1270,6 +1271,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1319,6 +1321,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1771,7 +1774,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2544,8 +2547,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2557,6 +2558,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2577,11 +2583,13 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp, bool fail_early)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2597,13 +2605,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_rx_refill(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+		}
 	}
 
 	macb_init_tieoff(bp);
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp, bool fail_early)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2620,6 +2639,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -2951,7 +2971,7 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, true);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-- 
2.52.0


