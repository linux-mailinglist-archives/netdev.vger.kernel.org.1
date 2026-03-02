Return-Path: <netdev+bounces-262627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULzZHhN6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DF1D7E2F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDEBA300D910
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015E363C62;
	Mon,  2 Mar 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aufUzV9O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOQ6bbEY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77809332916
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452362; cv=none; b=n61jIJyfughmb/HNBFhInlesqNkAbqP4fADeXA992bSsxbKKIjbsBkTAF4pOarXazQfgzZUKeUSHhDCNtohCwnGpk0B9taL4PKMcKJrND2Mz5WOlbbZSuYLWXvlaPShTPPkxc5SWzcRGlf+CvEPBkk52JyhVQYf8HIP8gGfxe2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452362; c=relaxed/simple;
	bh=NAo8WbkQhQlvoF9NAPZlhjIkkbXHboA/iYGe9Opk9bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQ8+9YcxIjSY51L1ECFz9gFYEPXOH37SryxgMCJmJnbZGNsKkpTRFnH9QHEp6IJYGPD2g7VHLraNRmfnZ1WSnNuXMj/xL1QiW7zPFR4jftrjIqfmIeaYxLpi5U7m1h3iHTW6DzOoQuNG2zRUH/BYmJpedhUSdNMN4aroR91EiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aufUzV9O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOQ6bbEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPXzaqYHVOdQI/EmldXUl2eV5QyUkc40ihgDPEjYWTY=;
	b=aufUzV9OYi9Dv6stEG28veDaL51IL/JEYmZpZC94WdpqZYxMHNFOgvPzFnwWKvbvCePrlT
	3LozVzT+G+CLgBu+uS7iuGOkDeiWaDviPKY/EvfGCf9cDS6ioOiH142uOGsUhYaYLJOHtC
	TS2LWWSp4hNsV4PuXSGZASSYl3whUPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-CmHthmZrPcy7tCUI3CTzLA-1; Mon, 02 Mar 2026 06:52:39 -0500
X-MC-Unique: CmHthmZrPcy7tCUI3CTzLA-1
X-Mimecast-MFC-AGG-ID: CmHthmZrPcy7tCUI3CTzLA_1772452358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48069a43217so42864575e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452357; x=1773057157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPXzaqYHVOdQI/EmldXUl2eV5QyUkc40ihgDPEjYWTY=;
        b=jOQ6bbEYeZ4nlMXYqOGBm9Urv8FmHqfNMYsS6TV8HH2jozxfbssqvX/DcPfNSAWLfh
         u4E65guYjdcJrJV+DcMrznAAtvN0r9u/2AqIG/xhZiPsccekBXIqUo07glGiQD6uHwIO
         abJ7Ou89tNGdwDJo0z40aBImvMwNz8jS8qcDrH21zqFHvqVpRovzynwvEXb32UT1dRge
         Fy5mP9xtr3zRQumBZR+lpuvRFrU1xNpiXAyyMYVrT6O3VDOrtLanyGCPievZSXQKJOSJ
         npjhVxeiBxh9KrrwmILSDidBBRVUO3/LE94qXY+4EJn0GGIt/QP86OVSmJ8WbIlPbZnR
         KLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452357; x=1773057157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPXzaqYHVOdQI/EmldXUl2eV5QyUkc40ihgDPEjYWTY=;
        b=EXD3Liv2fzJTmKzuLGIHDIHDj/D9C1MnmBaq8rPjI0GhuEKBG+SwNuuKpF800hx29j
         rshAFrPmC3AdzpPE1MhrKlqYcnBPkbMEYuVw1guoEmkass0zY5Q+kZ/dnhiNHfeQm2MR
         fMT6Ct8xy/eH8C0B/Z8h/+te4UjKGDxZ8SqysvFGXqZyloV+jOQaL1UM3VJJEFRYOYBH
         N8RdCFvwQA3I08ZfT/Dr+5WTXQK4t8E/Lc7BOxzhfFE3Vcyz2aXIDaEjFG14m+RUPCCe
         ROwEa+059qx3DX8TgeJmTI3K7e7kEaWQxClnt4v0wygzdIp+itEpvN0b/P9lICbUa0ae
         a6qQ==
X-Gm-Message-State: AOJu0YzQaY64dwQME0VtffTe0DUKhJa8MDNU7MX2z/+zaXLi/eY14Imx
	u6WSyzVf1rWnEOtMvqIO1wKv6jhkmfmVTNb6i+zzcbAGL+Y0n69yOV+yJYeGcNxoBl9+qoeXE6s
	IBTpPXK8Az1kso1JFTUBbvpjx/MKeVbor6rvKE7blm38y7fwWfuYU80P3GUMAiyC7DhznJZjNV8
	YwtkDMRJ8bUTei8P4rc38FjvZKs8WA+67OMPAOFeWivQ==
X-Gm-Gg: ATEYQzwvYsoDTSS1jfau465ZiGL+vb9vIUyvnnNTMp/y53fLHXaYfhwTW0azV99L6XI
	SY0S88YZaUMYcbQr6GB3UrxrMFUPf0Zwkf2BaRroRc4+deQNhIdqn3jn/pQXxLkG4NifNOcudX0
	Xw2pXgz4TbUdISu1YEP5k3zsV3B+th6Tzq49Z5GpvAW5xraeaIlnaL3Jrnl/bkvy1ooiIMivyXF
	QY+vpeP9ag9UFpnhIVV2IJ1+2CZoAkl09+yPrHPB9/0tFiDLk0lkDVJtjuqRK05l4eQO0Z7CDaS
	1mArWZSIJfdytfEoVLirF5sTbYhVrJcON3UYx/hr44U1ZAo1CEyyUVn6hOzd8vjJlKZt8fG/zup
	MQwLU+rrys+t0sjk0A13FTaScSa20oUWa3vtSwrA4kj00nugp4EboCEeGtFg=
X-Received: by 2002:a05:600c:3509:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-483c9b9d9admr191259595e9.9.1772452357071;
        Mon, 02 Mar 2026 03:52:37 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-483c9b9d9admr191258955e9.9.1772452356507;
        Mon, 02 Mar 2026 03:52:36 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm240210935e9.2.2026.03.02.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:36 -0800 (PST)
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
Subject: [PATCH net-next v3 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Mon,  2 Mar 2026 12:52:25 +0100
Message-ID: <20260302115232.1430640-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E53DF1D7E2F
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
 drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

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
index 02eab26fd98b..347b510c0c25 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1263,13 +1263,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
@@ -1286,6 +1287,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1335,6 +1337,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1787,7 +1790,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2560,8 +2563,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2573,6 +2574,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2593,11 +2599,13 @@ static void macb_init_tieoff(struct macb *bp)
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
@@ -2613,13 +2621,24 @@ static void gem_init_rings(struct macb *bp)
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
@@ -2636,6 +2655,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -2967,7 +2987,6 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-- 
2.52.0


