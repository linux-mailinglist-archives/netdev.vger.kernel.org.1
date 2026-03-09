Return-Path: <netdev+bounces-265571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBXNCH3drmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:47:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C04A23AD35
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD003087D09
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2B3D3CF5;
	Mon,  9 Mar 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMzey5Jz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9z+qI1j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833463D34BE
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067454; cv=none; b=NWIY6spZGiqRBfyUtPF1aBCs/KtRbOjzWFdTlKzqbik9dqIJZKnfT4lJ4niPVq/oBiUH4Em9mW9z9+eYZpEvz6WjxwiD8IjSLRU1F+1uFRvcEBGaslvAwyz/ozRx3iK734BlCS9b0uJnJvS6HtaqOWgCt/yeLGjZ1kl1v1tIZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067454; c=relaxed/simple;
	bh=fcDvW4yt+Op5qp0AbFdXqIURFc0Cgllpgsht3aOL/B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkPhbXJcePaZmNrKzE3PFqT65rd5Bb1clYR1oo4UhlOBFydQnWdNbag0w9wlj+pCW/46TV3ubUkseEy3dwa2e0B2h1tgNKhOYiMP++vgtxSoekSeGa4n9P5IcVX/uHZAGUNzhuOTBoV16nAIP2T7pAHtZu/Ds8W29CgGDN0NuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMzey5Jz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9z+qI1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm38gnpTTPjD6L6iAyGXFO45XYn8+GCrfG1pgyyjuHw=;
	b=hMzey5Jz5rNOky6YUK7i8+lTjcBpHChGXI9dx+TcctERJwRS7cm6lge7J/pywUupixQoWo
	TzzPBJ6OOM7uYAyStzh5fmSps3nmu9hLDUrlik+pu+/4CXnUUfd5P6sslBHCBilZuFhgfN
	M4rTAQlOoF1a/5/vy2Q+6LTBfSiPn9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-JVY6kZndObKdhz8kP0uh8A-1; Mon, 09 Mar 2026 10:44:10 -0400
X-MC-Unique: JVY6kZndObKdhz8kP0uh8A-1
X-Mimecast-MFC-AGG-ID: JVY6kZndObKdhz8kP0uh8A_1773067448
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439ca6a7506so6178020f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067447; x=1773672247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm38gnpTTPjD6L6iAyGXFO45XYn8+GCrfG1pgyyjuHw=;
        b=H9z+qI1je+35YNIHET0jXhO4xBT0qREAslIjveI48MnRbhP1MqZpedWCSgsEqSSO/X
         syGL3LOFoEMlzViCS+9b5t2WFpK+RaCkFEODTS4TX3mmz333a5HAsztCi2HAsxd6zq2N
         duQkpQiL/T8nNQzFITmM/MUnCFJtkYrkgPXvXsu9cG9FEh25526KwAELIwyBWI9l7aOn
         6iaOX4/h6y9hJSAWnEW7064joE4+R6FWE1T69DgyKocUshJJLm0Nhjs9r2rjjYflDeIF
         sdPCDP1EgAiG4sTsEDHMjUQ3rVG4YEo3rcxzwCWEQSqhsvRh+sq648NUnreCGuWoxZER
         Qt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067447; x=1773672247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cm38gnpTTPjD6L6iAyGXFO45XYn8+GCrfG1pgyyjuHw=;
        b=C0XG4uqqYXbgKIwC7zXz2e/jR9ZjqIC3Htusxx+eeq1ofYBy6EEqjuodli2AZV5oTZ
         Z1iKi6SxqaobfNFyGnHtuyik2BYvVR7lZ/Rgfc76YNmgqJ5pjd09SHKTBy7vohgz5z+K
         bHy/NmB5QVUrx9+ZHZprRDy0Yg8KhJFMl3wgetZBPayBFntYwer9PKaINSDo34ntaown
         hif3oLWxItu7sVHUP0VhUygMhQjVcRFqBcBfuVIGq1RH/ZFkiG+hobaPcziw0NfsXveK
         o2kK7yrtc9M4iYnxLNOtKFXQHYXnub5+Or0Hn3YcSYowPMutuY3jYffumWcOXTAng8VG
         79Kg==
X-Gm-Message-State: AOJu0Yw6qBk4SF7gKHsKYgmVS0fejxXnBjKbaF7WxlK6HNHEwKujB6Vy
	WpufAkY4QyJLcg5jxLqPh/y1yEini7sgCrU5LpKVq6sk+oA8CWZMYvoQ1Q22XhTJ10bMdqafZtC
	WOz9KBT4/R/0nWd+hA/naKJmOyOx4FsWmzqAJPl+T2+21fQ00mtFXydDKS5Yg+5De9pVDO+yI/x
	p035vmLMv3psBqV9zuhIHhUG6lcayw4R/7tBSi0+u94w==
X-Gm-Gg: ATEYQzx3tW6fI1eQAdgzUk+CMGQFSipm4UDCbm2ZIl3AvHT43Nnq4yzPfs94MB0p6FC
	iA3iH2bAHwrXmYGRZpG3bEENLaoXOIUDZ4WZ47ICv3q5gLcpOBaFkCqN0iUeox2LSkb0fxbHdtI
	/SfyQbCOE5hNpdTwDYU8dRDK/M0wICY1rqhXN7UWvRGeF4cvxGKCaTfHsUy+gCLu24Kki9kHWvD
	rKs+NYi9+C53Au1BswSNd5yp9TTaLAr31ZL5jpFgeJ4JCbo61LzJ4Zl0OhwsDV6jaPiJjX0v1SX
	H9aDX7aBxED108ovG5SSZK6DI3ktzaj5BRgCf6OLk0fY999nrbVE6vdzSAWLS/EoUaaOHTlpkj7
	2AGaRuapWwTq7jKH+0o3SOEJPIb+UavH8RMW+vS7HESeWK+x3azJGZRRr15o=
X-Received: by 2002:a5d:5f93:0:b0:439:b3d2:3768 with SMTP id ffacd0b85a97d-439da65729amr20979053f8f.21.1773067447565;
        Mon, 09 Mar 2026 07:44:07 -0700 (PDT)
X-Received: by 2002:a5d:5f93:0:b0:439:b3d2:3768 with SMTP id ffacd0b85a97d-439da65729amr20978982f8f.21.1773067446984;
        Mon, 09 Mar 2026 07:44:06 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2bdf8sm28285215f8f.25.2026.03.09.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Mon,  9 Mar 2026 15:43:46 +0100
Message-ID: <20260309144353.1213770-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144353.1213770-1-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C04A23AD35
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
	TAGGED_FROM(0.00)[bounces-265571-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
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
index c69828b27dae..0acc188fe547 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1195,7 +1195,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3dcae4d5f74c..d59588ef2f3f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1382,13 +1382,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
@@ -1405,6 +1406,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1454,6 +1456,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1906,7 +1909,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2680,8 +2683,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2693,6 +2694,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2713,11 +2719,13 @@ static void macb_init_tieoff(struct macb *bp)
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
@@ -2733,13 +2741,24 @@ static void gem_init_rings(struct macb *bp)
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
@@ -2756,6 +2775,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -3087,7 +3107,6 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-- 
2.53.0


