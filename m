Return-Path: <netdev+bounces-194333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1442AC8BCC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2D74E65D9
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03154223705;
	Fri, 30 May 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n4pFlyZg"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE42222C7
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599263; cv=none; b=kRE6MCqLV3ZPpjKVf5LXctOZtLgZU8f26t4AfBTHkApLZ37kz5/pYC6DvWwm1ChynYJmOEH9aS7gknzD0TsbBAMzDEjP7O+O+R6DyBtf5Wnc3ffgSY78mLi40MrUn+sDUMucLc/mEMuOg2pT3Pj9gp4T0nI+nbhNEEsxmHfzVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599263; c=relaxed/simple;
	bh=NorrkePffBzwUUGIvwnAem9aujHkQ+vw9WO/qgC8D/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QN7mqLpSfWQHUZdV5KxOzWH6QTCw5y2HHENhR4xh+TfgAU9iudRX5PEiV/9VHghe+z1/066pXFbJcAexAkC79mCuX6dw6K6DRpyzZgAnkI6AsqoA7DD5/U2IJf+pc4AwnBnFx7A6iUDcuKu/uYURUStFVOa9mY8oF3gMKqcCR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n4pFlyZg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250530100058euoutp02e9f316f27846c0e650ed365414320e07~ERcLqEIE01314313143euoutp02a
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250530100058euoutp02e9f316f27846c0e650ed365414320e07~ERcLqEIE01314313143euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748599258;
	bh=fnfYVNxfL0DHQ1U8EdAdmg35bYdFSv3S7ReuuQVXUXA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=n4pFlyZgXMvspCg1s+71PlK18cKVuR0wWjpkzwQqYYtrBJWZR7LlYILS06QKmwbNf
	 Dna38vSGIUllRaa6REhLCjWjQmvefmZAFq6AJWcWVjYWyLc94hx6agDl02WXd+wMKi
	 WK32BEaUPlwM3wnnk0zAFKTmnmnyCPDYge5XzP5E=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250530100058eucas1p18554bf19ac9f302a8c3636d091448582~ERcLWn2781752417524eucas1p1B;
	Fri, 30 May 2025 10:00:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [106.210.135.126]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250530100058eusmtip24f64e7b8835dcc02dd4e605e2b87339b~ERcK-Bwjr1946319463eusmtip2i;
	Fri, 30 May 2025 10:00:58 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH bpf] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Date: Fri, 30 May 2025 11:59:57 +0200
Message-Id: <20250530095957.43248-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250530100058eucas1p18554bf19ac9f302a8c3636d091448582
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530100058eucas1p18554bf19ac9f302a8c3636d091448582
X-EPHeader: CA
X-CMS-RootMailID: 20250530100058eucas1p18554bf19ac9f302a8c3636d091448582
References: <CGME20250530100058eucas1p18554bf19ac9f302a8c3636d091448582@eucas1p1.samsung.com>

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
index bb2b751d274a..6785faec0699 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -622,6 +622,8 @@ struct skb_shared_info {
 		void		*destructor_arg;
 	};
 
+	u64 xsk_descs[MAX_SKB_FRAGS];
+
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
 };
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a2249fd2048a..f822393907da 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -526,24 +526,24 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
 
@@ -570,7 +570,9 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool,
+			     skb_shinfo(skb)->xsk_descs,
+			     xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
 
@@ -749,7 +751,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
+
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
+	skb_shinfo(skb)->xsk_descs[xsk_get_num_desc(skb)] = desc->addr;
 	xsk_set_destructor_arg(skb);
 
 	return skb;
@@ -760,6 +764,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
+		skb_shinfo(xs->skb)->xsk_descs[xsk_get_num_desc(xs->skb)] = desc->addr;
 		xsk_set_destructor_arg(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
@@ -802,7 +807,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		if (xsk_cq_reserve_addr_locked(xs->pool, desc.addr))
+		if (xsk_cq_reserve_locked(xs->pool))
 			goto out;
 
 		skb = xsk_build_skb(xs, &desc);
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


