Return-Path: <netdev+bounces-194341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8829AC8C30
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EEB7B003E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF621D5B6;
	Fri, 30 May 2025 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MwARftDM"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12221170D
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601311; cv=none; b=mhxJ3tgyKWvhGISr4T2oJvydBIkqfggTHmb6Y/Lf5/chj1zqrQWnN06U25Fy0Gzp4zlkAd97nNoOMdbz2soGYKTkZmJELhjM2PaGwO4nAf3mBD7YRm/fEVvwP4yV84S0xfQTR5Kb9jQMwaJAekcTekdxOMigBdlFUiCzfPQzeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601311; c=relaxed/simple;
	bh=fxgj7OGryMUW5xse7UpmzjvRw2Pg2YEWJ2JQZko7Rlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Nj98c7Ge56Ld1bo/vLvUVu1CDwvN+sHOkUb3Yo/NZitGy/fkCzG/lnB0+CJANmDvp02L4VAqI6tYi9ClrXjE2mVLUYCGzvAaf3/aQQ+284vYbGgVvUzX7kOyl2pNA2UcRiYA1+yWAIM7sPKJrofAn3pYkuoTgkKRStaK2AKlWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MwARftDM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250530103506euoutp01d03cdf0e0d19d28d05fbd18cd04c276e~ER5-BrFNH1455814558euoutp01X
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250530103506euoutp01d03cdf0e0d19d28d05fbd18cd04c276e~ER5-BrFNH1455814558euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748601306;
	bh=SbYTwkei89kqHUuH/tFo5n9/2NU8jJ/5PtLHFg7l9p8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MwARftDMQmUlKrAxg7Q1kGBybF3e/yAW9J6WFbIjYpbMWSFxY4oiNvvbG530u3V/4
	 1iAAEWgCoox1MwTVzQE8KIDF+I7XUIV1SiatNAphPSnhAYw8YPs8SXf6UNW7TTnqkH
	 ulxJIjAucrIjb4kawek3H9g/llCxPimJ5g1o/3aA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009~ER5_rRF6f2628826288eucas1p1T;
	Fri, 30 May 2025 10:35:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [106.210.135.126]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250530103506eusmtip168cfe8100186f39cdf3f515f4e3726b5~ER5_TD_o90378403784eusmtip1N;
	Fri, 30 May 2025 10:35:05 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Date: Fri, 30 May 2025 12:34:56 +0200
Message-Id: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: CA
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucas1p1.samsung.com>

Move xsk completion queue descriptor write-back to destructor.

Fix xsk descriptor management in completion queue. Descriptor
management mechanism didn't take care of situations where
completion queue submission can happen out-of-order to
descriptor write-back.

__xsk_generic_xmit() was assigning descriptor to slot right
after completion queue slot reservation. If multiple CPUs
access the same completion queue after xmit, this can result
in out-of-order submission of invalid descriptor batch.
SKB destructor call can submit descriptor batch that is
currently in use by other CPU, instead of correct transmitted
ones. This could result in User-Space <-> Kernel-Space data race.

Forbid possible out-of-order submissions:
CPU A: Reservation + Descriptor Write
CPU B: Reservation + Descriptor Write
CPU B: Submit (submitted first batch reserved by CPU A)
CPU A: Submit (submitted second batch reserved by CPU B)

Move Descriptor Write to submission phase:
CPU A: Reservation (only moves local writer)
CPU B: Reservation (only moves local writer)
CPU B: Descriptor Write + Submit
CPU A: Descriptor Write + Submit

This solves potential out-of-order free of xsk buffers.

Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Fixes: e6c4047f5122 ("xsk: Use xsk_buff_pool directly for cq functions")
---
 include/linux/skbuff.h |  2 ++
 net/xdp/xsk.c          | 17 +++++++++++------
 net/xdp/xsk_queue.h    | 11 +++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..cc37b62638cd 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -624,6 +624,8 @@ struct skb_shared_info {
 		void		*destructor_arg;
 	};
 
+	u64 xsk_descs[MAX_SKB_FRAGS];
+
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
 };
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..2987e81482d7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -528,24 +528,24 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u64 *descs, u32 n)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+	xskq_prod_write_submit_addr_n(pool->cq, descs, n);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -572,7 +572,9 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool,
+			     skb_shinfo(skb)->xsk_descs,
+			     xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
 
@@ -754,7 +756,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
+
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
+	skb_shinfo(skb)->xsk_descs[xsk_get_num_desc(skb)] = desc->addr;
 	xsk_set_destructor_arg(skb);
 
 	return skb;
@@ -765,6 +769,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
+		skb_shinfo(xs->skb)->xsk_descs[xsk_get_num_desc(xs->skb)] = desc->addr;
 		xsk_set_destructor_arg(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
@@ -807,7 +812,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6..06ce89aae217 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -436,6 +436,17 @@ static inline void xskq_prod_submit_n(struct xsk_queue *q, u32 nb_entries)
 	__xskq_prod_submit(q, q->ring->producer + nb_entries);
 }
 
+static inline void xskq_prod_write_submit_addr_n(struct xsk_queue *q, u64 *addrs, u32 nb_entries)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+	u32 prod = q->ring->producer;
+
+	for (u32 i = 0; i < nb_entries; ++i)
+		ring->desc[prod++ & q->ring_mask] = addrs[i];
+
+	__xskq_prod_submit(q, prod);
+}
+
 static inline bool xskq_prod_is_empty(struct xsk_queue *q)
 {
 	/* No barriers needed since data is not accessed */
-- 
2.34.1


