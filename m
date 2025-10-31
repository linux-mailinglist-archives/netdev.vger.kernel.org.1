Return-Path: <netdev+bounces-234610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D3C242D2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726EC1A681F8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FE329E54;
	Fri, 31 Oct 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUGSW9sC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DA329E49
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903171; cv=none; b=BF/cU+LkO7l5EM3YhOtoCgZ3qd8Y8WBKdTqm9t+TVu5WjDPlqIDNyLTfB2XTYRiI01rfFIwd+ZqUyxc1zTOQnaO5lt0G0aKahRpmFDDczgOE3HXOxeY7kiIQonfGB9+eLE8Jh4+wABGb4P7aXUTwS1B2oaMAiW6oaq3rQStca3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903171; c=relaxed/simple;
	bh=4vBZCNcED1P5AALOfyM5UXMZPyXxnn/M0/CEqYjWaNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJtRRVR3qg4s1vVcNzmLH/GF1gn2coQ2Y7PDlLV7t/jrfIYEGcj9l5QbX0jxbIEG6Qm/Y5vh7WW8cdkyUuDHvAqy9TM0mLT4lnyy3uqizta6KH2aGEw8n1I9ymgx5F0vJuGe6IiqUyE3uBdaOcA5BILm2jZFb48fGNNlsXJ5aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUGSW9sC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so2407111b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761903169; x=1762507969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBCPEZgsKUQwxZ7RdGlOOoWmvT49/d2ZTo+5TAFWcfU=;
        b=mUGSW9sCrSak12ArT8Yqglr5vNjPaDFQxaA5GX5AOAfVGlkfzYPtxKL/dJQirgwqjJ
         aAYk+aZT3ZSId6zoiDxmGd0WULIm97tR7lqRZIIGTMk2MGrXR0sKLMygWEJCtHDE998F
         qVJJXoctDqPQbgyDd0ybWQ5CANFJyAcHcv/Q13jBblDWX2Wern9WYAN0YvTP9prHCw/V
         ix5fqCm/QsJYAaKYMi7tCSJoU+moMsZG4iR5LQmftIJGvtkRXfipL5pWI0zRYRZxC+Ep
         DiBWPE6LrazsgM6Me/05S2CzLZmcjIhn2kMJmbtykiPHtJALTFuG+SUd4Dxch9GlBE6z
         OiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903169; x=1762507969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBCPEZgsKUQwxZ7RdGlOOoWmvT49/d2ZTo+5TAFWcfU=;
        b=CsJbN8BznJ/oetOE5K8j6KZTVs+gdQ3PdNh4YFW/bj9WXyczvYBazN0pBrGRJKivck
         zu7Uou024n71NTVh7POUdYdJt2j15lS6z+D7RhokAVzjfec7PtU0lekNE1qikOXSVAxo
         rWIQdUM5r49NuqWoDXGtG56tTsJrL8n8ewz8EdM5OjZfyOw3HA/5ZXvyN0tTPZTwBA71
         Bmzx6S7A96qX9f/ihq2EixJdW/IBfm+qTRJlADb8M2XxrwNdLdlclhClUoHO8tnh2gTW
         7vF5st/ierbNW2n5SVnPfKMigw+U4F1+YFNzrlbxiMGVN/ksyyA0SKhrlFQcn3gMhnEx
         VCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC7GJoYy1WjheKDku6NBeQ23Az/BDFdgoAitClqeVsUEIou4m/Wz3TYgZOw9LMHfNusgcMykY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoFc+CYG5yJY5zuoDfIVvNJ4JtrFelecLwHFGKE5TFqrDJsgg
	kvWxwsc6wyjd3nLoVbcfQr6i0PIFewMdctKO82z6ED2Z+TK+iu3TiSJW
X-Gm-Gg: ASbGncvGwNlZBHl299mZ6IhRJXqK0PHzKgbJAOvfEMQyRD2cAxkSP6umfeRz6mLOg9Q
	DDXA6gAeXH3O91VOFHMObCcAVv9wnVZVZEve3kxiJYKqYpFvUMJ0wb/FxO4S5Y1mtvdHFFKkH2Y
	zP9XUcqUWDQAXO56qo4uBpq/88g/LjTl5feU6AdtmOwE8WcFBNxb27wgsptH78pPAcWafiYOWy7
	A8BhMQOFXf7Myix2YiSvHvqueaeiErKsy6mHP5uDBYM0Ds14f2A1uckCBe5BusX+uoKMibKJGsf
	NR7d62V6nYutbx58/BCcqpzBKE0QnffEZx+BbRW+VB0oWs09xZ+rmvUT+atfjUpZaLn5c9ZmcxU
	9clHoXvV7VjzC+7+OvP8LkxIyQQe68+XouioNydrT4cP1qpie7aL6kfdkSZ0Jtlc9i9A3GtjchF
	q4WNrPGGG4pG3C2AekdNvV9F/wgbrnYAmLOTK91aYQkqbmbiWk70kkCqcroQ==
X-Google-Smtp-Source: AGHT+IGOKkRhtqMUN3xf21PPs8lEt9KyfNpnLCRW/yCklpKpZD/L8OqSwREPA+7UDY6uNZO+L9o+XQ==
X-Received: by 2002:a05:6a00:cd2:b0:772:6856:e663 with SMTP id d2e1a72fcca58-7a756e4e2b6mr4029067b3a.8.1761903169059;
        Fri, 31 Oct 2025 02:32:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm1544422b3a.60.2025.10.31.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:32:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com,
	fmancera@suse.de,
	csmate@nop.hu
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to temporarily store descriptor addrs
Date: Fri, 31 Oct 2025 17:32:30 +0800
Message-Id: <20251031093230.82386-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251031093230.82386-1-kerneljasonxing@gmail.com>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
production"), there is one issue[1] which causes the wrong publish
of descriptors in race condidtion. The above commit fixes the issue
but adds more memory operations in the xmit hot path and interrupt
context, which can cause side effect in performance.

This patch tries to propose a new solution to fix the problem
without manipulating the allocation and deallocation of memory. One
of the key points is that I borrowed the idea from the above commit
that postpones updating the ring->descs in xsk_destruct_skb()
instead of in __xsk_generic_xmit().

The core logics are as show below:
1. allocate a new local queue. Only its cached_prod member is used.
2. write the descriptors into the local queue in the xmit path. And
   record the cached_prod as @start_addr that reflects the
   start position of this queue so that later the skb can easily
   find where its addrs are written in the destruction phase.
3. initialize the upper 24 bits of destructor_arg to store @start_addr
   in xsk_skb_init_misc().
4. Initialize the lower 8 bits of destructor_arg to store how many
   descriptors the skb owns in xsk_update_num_desc().
5. write the desc addr(s) from the @start_addr from the cached cq
   one by one into the real cq in xsk_destruct_skb(). In turn sync
   the global state of the cq.

The format of destructor_arg is designed as:
 ------------------------ --------
|       start_addr       |  num   |
 ------------------------ --------
Using upper 24 bits is enough to keep the temporary descriptors. And
it's also enough to use lower 8 bits to show the number of descriptors
that one skb owns.

[1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I posted the series as an RFC because I'd like to hear more opinions on
the current rought approach so that the fix[2] can be avoided and
mitigate the impact of performance. This patch might have bugs because
I decided to spend more time on it after we come to an agreement. Please
review the overall concepts. Thanks!

Maciej, could you share with me the way you tested jumbo frame? I used
./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
nic more than 90%, which means I cannot see the performance impact.

[2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
---
 include/net/xdp_sock.h      |   1 +
 include/net/xsk_buff_pool.h |   1 +
 net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
 net/xdp/xsk_buff_pool.c     |   1 +
 4 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..0d90d97e0a62 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -89,6 +89,7 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	struct xsk_queue *cached_cq;
 };
 
 /*
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index cac56e6b0869..b52491f93c7d 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -63,6 +63,7 @@ struct xsk_buff_pool {
 	/* Data path members as close to free_heads at the end as possible. */
 	struct xsk_queue *fq ____cacheline_aligned_in_smp;
 	struct xsk_queue *cq;
+	struct xsk_queue *cached_cq;
 	/* For performance reasons, each buff pool has its own array of dma_pages
 	 * even when they are identical.
 	 */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 05010c1bbfbd..3951c2bc9d97 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -532,25 +532,33 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
+static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr,
+				      u32 *start_addr)
 {
+	struct xdp_umem_ring *ring;
 	unsigned long flags;
 	int ret;
 
+	ring = (struct xdp_umem_ring *)pool->cached_cq->ring;
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	ret = xskq_prod_reserve(pool->cq);
+	if (!ret) {
+		*start_addr = pool->cached_cq->cached_prod++ & pool->cq->ring_mask;
+		ring->desc[*start_addr] = addr;
+	}
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_write_addr(struct xsk_buff_pool *pool, u32 addr)
 {
-	unsigned long flags;
+	struct xsk_queue *cq = pool->cq;
+	struct xsk_queue *ccq = pool->cached_cq;
+	struct xdp_umem_ring * ccqr = (struct xdp_umem_ring *)ccq->ring;
+	struct xdp_umem_ring * cqr = (struct xdp_umem_ring *)cq->ring;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	cqr->desc[cq->cached_prod++ & cq->ring_mask] = ccqr->desc[addr++];
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
@@ -562,9 +570,41 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static u32 xsk_get_num_desc(struct sk_buff *skb)
+#define XSK_DESTRUCTOR_DESCS_SHIFT 8
+#define XSK_DESTRUCTOR_DESCS_MASK \
+	((1ULL << XSK_DESTRUCTOR_DESCS_SHIFT) - 1)
+
+static u8 xsk_get_num_desc(struct sk_buff *skb)
+{
+	long val = (long)skb_shinfo(skb)->destructor_arg;
+
+	return (u8)val & XSK_DESTRUCTOR_DESCS_MASK;
+}
+
+static u32 xsk_get_start_addr(struct sk_buff *skb)
 {
-	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
+	long val = (long)skb_shinfo(skb)->destructor_arg;
+
+	return val >> XSK_DESTRUCTOR_DESCS_SHIFT;
+}
+
+static long xsk_get_destructor_arg(struct sk_buff *skb)
+{
+	return (long)skb_shinfo(skb)->destructor_arg;
+}
+
+static void xsk_cq_submit_locked(struct sk_buff *skb)
+{
+	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
+	u32 addr = xsk_get_start_addr(skb);
+	u8 num = xsk_get_num_desc(skb), i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	for (i = 0; i < num; i++)
+		xsk_cq_write_addr(pool, addr);
+	xskq_prod_submit_n(pool->cq, num);
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -576,23 +616,30 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_locked(skb);
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb)
+static void xsk_update_num_desc(struct sk_buff *skb)
 {
-	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
+	long val = xsk_get_destructor_arg(skb);
+	u8 num = xsk_get_num_desc(skb) + 1;
 
-	skb_shinfo(skb)->destructor_arg = (void *)num;
+	val = (val & ~(XSK_DESTRUCTOR_DESCS_MASK)) | num;
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs)
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			      u32 start_addr)
 {
+	long val;
+
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
+	val = start_addr << XSK_DESTRUCTOR_DESCS_SHIFT;
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -652,7 +699,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
-					      struct xdp_desc *desc)
+					      struct xdp_desc *desc,
+					      u32 start_addr)
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
@@ -674,7 +722,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs);
+		xsk_skb_init_misc(skb, xs, start_addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -713,14 +761,15 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 }
 
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+				     struct xdp_desc *desc,
+				     u32 start_addr)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, desc, start_addr);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			skb = NULL;
@@ -747,7 +796,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs);
+			xsk_skb_init_misc(skb, xs, start_addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -779,7 +828,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
-	xsk_set_destructor_arg(skb);
+	xsk_update_num_desc(skb);
 
 	return skb;
 
@@ -789,7 +838,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_update_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -822,6 +871,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 
 	max_batch = READ_ONCE(xs->max_tx_budget);
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
+		u32 start_addr;
+
 		if (max_batch-- == 0) {
 			err = -EAGAIN;
 			goto out;
@@ -832,13 +883,14 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr,
+						 &start_addr);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, &desc, start_addr);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
@@ -1142,6 +1194,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xskq_destroy(xs->cached_cq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1321,6 +1374,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	/* FQ and CQ are now owned by the buffer pool and cleaned up with it. */
 	xs->fq_tmp = NULL;
 	xs->cq_tmp = NULL;
+	xs->cached_cq = NULL;
 
 	xs->dev = dev;
 	xs->zc = xs->umem->zc;
@@ -1458,6 +1512,10 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		q = (optname == XDP_UMEM_FILL_RING) ? &xs->fq_tmp :
 			&xs->cq_tmp;
 		err = xsk_init_queue(entries, q, true);
+		if (!err && optname == XDP_UMEM_COMPLETION_RING) {
+			q = &xs->cached_cq;
+			err = xsk_init_queue(entries, q, true);
+		}
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..6e170107dec7 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 
 	pool->fq = xs->fq_tmp;
 	pool->cq = xs->cq_tmp;
+	pool->cached_cq = xs->cached_cq;
 
 	for (i = 0; i < pool->free_heads_cnt; i++) {
 		xskb = &pool->heads[i];
-- 
2.41.3


