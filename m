Return-Path: <netdev+bounces-240004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98605C6F1CA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C172C50483D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78503361DBE;
	Wed, 19 Nov 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip/NWCvH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzUHhlvu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649713659E8
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560462; cv=none; b=Xan5zetv157c4NBqUohH0b1tuuRWVrhC/cYKodfafg+SZtChH0C02X/gFfpjTwU/pYaoOCSSSyIxA3y9YlAotrZWcaSfTZGZ8KMXrsgYJY4BkLILT61eMEmybtU/uzSSalRUyjmI/wIJ1hNW59AvSacpq/lq98qSBJvNX1VjIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560462; c=relaxed/simple;
	bh=djUbXYZTxH7lPAv/B8gIGyMJ003GunQ5SMkrFCb4trg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAoNIKIe1C5XYIwE4JyhfhXYJohMRMFZLQj2vXvdK1iR8UtGI6ytyR5zjROWICxeYCtAaw/TVxhp5VvE0MLEav7zzHoBc8+UtVIR7E5tyIrQwKrqcRpLI8rWuBxbsT/1laVUn8s/iY8NKZQUE8lKE5iHRzWPsTSIW32AtY3i8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip/NWCvH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzUHhlvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbrIZK8eK9zHgiAj+G/sNx9eZ3fQLEiz0MiFqMAdXG8=;
	b=ip/NWCvH6GmH5u9VS804ET4+iMYIgol8VKepn7TR0IOhV7xd/EleOsrLM592sNvzjTygzi
	82+/VoO2QTOxHmC6/wXQOVWJFSDJUztnoqYF7KXT6AGcSvBKTfDFcru8qFYQ2X0YIl5++Y
	2lTfPjZObw2cy252LId2VlmmyEAYPLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-S86jzPvZPZa75-XzuPs_NA-1; Wed, 19 Nov 2025 08:54:18 -0500
X-MC-Unique: S86jzPvZPZa75-XzuPs_NA-1
X-Mimecast-MFC-AGG-ID: S86jzPvZPZa75-XzuPs_NA_1763560457
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso43294925e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560456; x=1764165256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbrIZK8eK9zHgiAj+G/sNx9eZ3fQLEiz0MiFqMAdXG8=;
        b=BzUHhlvueCHy9dC3i53YrnnG+PqUjRT2b16z9u8lGKN8eh0WHE23Mm/u2vGZg0Nn+2
         TENj9QNIlNGHkwrq3ShytZ5J2UzwhSZHr6osyBi7yWOl61wsUqfRQBMItNmoGW1oztjH
         l2KRjykpsn9C+HXCS2VKSaWIMsTJT5cGk0kbAMSiTHMdj4N1GJD8veTGv6n6F5D2k4d9
         i7efyz6buEkorQn87UgufLjezJvfwrwdTngGX2XGaO8mcQvXss3P2610cCovBnd/uxBC
         yT40wQvz94JrDWYfUBFDxCIs3W7TdFSvDdXr6bYvzz3p1ULHaG9ERUD8zcFfF2v2iwev
         KDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560456; x=1764165256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbrIZK8eK9zHgiAj+G/sNx9eZ3fQLEiz0MiFqMAdXG8=;
        b=SbdNTjm6rLWuB8bjDuvsdvJcvcROQyfHOWcA3sdpkzaMulT0FXWtIzRO6/a9KKhtE9
         qWepgOdkNEumDPudEpjjP4+VamhoYSDqfItE1WqBlva+W9fnz8ElzBYb+YMFkenwf4zG
         ZFcbMzGOT47FeKx/I9EyxDhWoZ43JEibfn13hFWhQqL9a6abm48JS5xRJVm/juJshwo7
         6jMWKIGX8zZ1BEnXpC9hhPfTFVuIxLKxGaWKdcXBL9h+uvBQ4zKutdX475i7lZptoP3n
         jQDPqYEw+0+KcQNQr4CyP4wqlKv4Rg3Ma0TcV2KZumikf7wYCZHdgq8LRZFrzOQ57r7r
         Dp9Q==
X-Gm-Message-State: AOJu0YzUFTLpZx0pDetjNel3T17RK+XeXwVFXQD/q/pHLBUJ2GY3DpaX
	PWJWJoGVMvMkQgHq/dxukNwYsb9WYxhRNt+7lWAYX+TrrItbCMNo1+p+/odJo7Fz+jf8LGFTJRF
	R2pF0iIRi34nTBnk6XfRHJ9fvMFkzuv3UQna4h9N5NB/B0OnQPeYQSFOWgcAQxB3zX8j4Kx7o7M
	Xmv2V7WMbK1FXQ9WWVqwGmCP3fKuHmMiXambSFDNKv4sB7
X-Gm-Gg: ASbGncsn5SZHhtbkMHnYYmwRBRBmm1k8nV6rFwju05uMM3+43794BGPMsjvGpmZ0qTR
	wxPjuOGA9BV34kcIAtjmi59EitYGGRk49QTIcMlWOHLT7vXDRfz0PQncY/5FE0IU7NYEZ8P5SKq
	vwcJNZApCHlTkvWDybdxM8U5rJ9kyVeDuzXGhTUnyg0ypGbncRNcaQ/73d+oNNeHtd46oyOu/Ec
	Dg2+dvOD4RGowGadGaoGqN0Tlgx/RIGv5yaZkOg9WohEQeid0S2NYDeQSo3cS9gAqsxm/SmYtyQ
	1kKrHe7QKpd05jU7SYTmEsV0mkMbMhXEydZk95Oc9fcgFnT1HvuMmkS5idQ5cdEKuA3iGhJ7Y5o
	UYl6GPLNoJQWSVZtalAnXCmYiCkUcvmM/SVndLp4gxrboRKgB8w==
X-Received: by 2002:a05:600c:1f12:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-4778fe9afc3mr167211035e9.26.1763560455980;
        Wed, 19 Nov 2025 05:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVFNonzmiR93YJ14uF1uxgfi1ghZN7nn6DIsh504iOZP1EOyPszRCAyikVAswsBi7YA8rcrg==
X-Received: by 2002:a05:600c:1f12:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-4778fe9afc3mr167210605e9.26.1763560455466;
        Wed, 19 Nov 2025 05:54:15 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10763a9sm49036645e9.12.2025.11.19.05.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:13 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC net-next 4/6] cadence: macb/gem: add XDP support for gem
Date: Wed, 19 Nov 2025 14:53:28 +0100
Message-ID: <20251119135330.551835-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119135330.551835-1-pvalerio@redhat.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce basic XDP support for macb/gem with the XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   4 +
 drivers/net/ethernet/cadence/macb_main.c | 161 +++++++++++++++++++++--
 2 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index e2f397b7a27f..2f665260a84d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <linux/bpf_trace.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -961,6 +962,7 @@ struct macb_dma_desc_ptp {
 
 /* The buf includes headroom compatible with both skb and xdpf */
 #define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
+#define MACB_MAX_PAD		(MACB_PP_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 /* struct macb_tx_skb - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
@@ -1273,6 +1275,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_q;
 };
 
 struct ethtool_rx_fs_item {
@@ -1372,6 +1375,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5829c1f773dd..53ea1958b8e4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1344,10 +1344,51 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
+		       struct net_device *dev)
+{
+	struct bpf_prog *prog;
+	u32 act = XDP_PASS;
+
+	rcu_read_lock();
+
+	prog = rcu_dereference(queue->bp->prog);
+	if (!prog)
+		goto out;
+
+	act = bpf_prog_run_xdp(prog, xdp);
+	switch (act) {
+	case XDP_PASS:
+		goto out;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(dev, xdp, prog))) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	page_pool_put_full_page(queue->page_pool,
+				virt_to_head_page(xdp->data), true);
+out:
+	rcu_read_unlock();
+
+	return act;
+}
+
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
+	bool			xdp_flush = false;
 	unsigned int		len;
 	unsigned int		entry;
 	void			*data;
@@ -1356,9 +1397,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int			count = 0;
 
 	while (count < budget) {
-		u32 ctrl;
-		dma_addr_t addr;
 		bool rxused, first_frame;
+		struct xdp_buff xdp;
+		dma_addr_t addr;
+		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1403,6 +1446,22 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			data_len = SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
 		}
 
+		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF)))
+			goto skip_xdp;
+
+		xdp_init_buff(&xdp, bp->rx_buffer_size, &queue->xdp_q);
+		xdp_prepare_buff(&xdp, data, bp->rx_offset, len,
+				 false);
+		xdp_buff_clear_frags_flag(&xdp);
+
+		ret = gem_xdp_run(queue, &xdp, bp->dev);
+		if (ret == XDP_REDIRECT)
+			xdp_flush = true;
+
+		if (ret != XDP_PASS)
+			goto next_frame;
+
+skip_xdp:
 		if (first_frame) {
 			queue->skb = napi_build_skb(data, bp->rx_buffer_size);
 			if (unlikely(!queue->skb)) {
@@ -1452,10 +1511,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (ctrl & MACB_BIT(RX_EOF)) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1477,6 +1532,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1490,6 +1547,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		}
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2471,6 +2531,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_q))
+			xdp_rxq_info_unreg(&queue->xdp_q);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2625,19 +2687,22 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void gem_create_page_pool(struct macb_queue *queue)
+static void gem_create_page_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = rcu_access_pointer(queue->bp->prog)
+				? DMA_BIDIRECTIONAL
+				: DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
+	int err;
 
 	pool = page_pool_create(&pp_params);
 	if (IS_ERR(pool)) {
@@ -2646,6 +2711,28 @@ static void gem_create_page_pool(struct macb_queue *queue)
 	}
 
 	queue->page_pool = pool;
+
+	err = xdp_rxq_info_reg(&queue->xdp_q, queue->bp->dev, qid,
+			       queue->napi_rx.napi_id);
+	if (err < 0) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
+		goto destroy_pool;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_q, MEM_TYPE_PAGE_POOL,
+					 queue->page_pool);
+	if (err) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
+		goto unreg_info;
+	}
+
+	return;
+
+unreg_info:
+	xdp_rxq_info_unreg(&queue->xdp_q);
+destroy_pool:
+	page_pool_destroy(pool);
+	queue->page_pool = NULL;
 }
 
 static void macb_init_tieoff(struct macb *bp)
@@ -2681,7 +2768,7 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_create_page_pool(queue);
+		gem_create_page_pool(queue, q);
 		gem_rx_refill(queue, false);
 	}
 
@@ -3117,9 +3204,18 @@ static int macb_close(struct net_device *dev)
 
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
+	int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + MACB_MAX_PAD;
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *prog = bp->prog;
+
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (prog && frame_size > PAGE_SIZE) {
+		netdev_err(dev, "MTU %d too large for XDP", new_mtu);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -3137,6 +3233,49 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	int frame = ETH_HLEN + ETH_FCS_LEN + MACB_MAX_PAD;
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	bool need_update, running;
+
+	if (prog && dev->mtu + frame > bp->rx_buffer_size) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	running = netif_running(dev);
+	need_update = !!bp->prog != !!prog;
+	if (running && need_update)
+		macb_close(dev);
+
+	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (running && need_update)
+		return macb_open(dev);
+
+	return 0;
+}
+
+static int macb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!macb_is_gem(bp))
+		return 0;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	default:
+		return -EINVAL;
+	}
+}
+
 static void gem_update_stats(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -4390,6 +4529,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= macb_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5693,6 +5833,9 @@ static int macb_probe(struct platform_device *pdev)
 		bp->rx_offset = MACB_PP_HEADROOM;
 		if (!(bp->caps & MACB_CAPS_RSC))
 			bp->rx_offset += NET_IP_ALIGN;
+
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.51.1


