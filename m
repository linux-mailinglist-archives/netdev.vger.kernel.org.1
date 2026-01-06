Return-Path: <netdev+bounces-247252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E457CF6493
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3127A3062B29
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DD16A956;
	Tue,  6 Jan 2026 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd1+att0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086541C71
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 01:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663091; cv=none; b=pQTcMrzUYXBJoz0Cl2q3iOdeGufiWC8OAqziMYKLmRnrCm8FTabZ5slksZB2LqQ+LHjUZgv8rR2XSheJ2AyHDMXDhsQ9flxkKODr8Y+uhHlVhUehJO+MGES8JpejJ0FbdyPHdautzu09NMoJNgOhLk1jizhlN/rz+Cv/E1WRRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663091; c=relaxed/simple;
	bh=Rc6/oQoxZDax1rvAgQnxYm352/isUEQIexKQK+5iEk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niRLmcSD+e61kMEAlZKtJTQl5AKrXTru2mGt6B+zekHyaaX9XUCa9g+XE1mqVQDDCux/J6V0Hq6V2+7G1YgMWAnvP7gZ2T2EIHX+xOIOqxdrcvhei/6pCjprhyLMTIn6i2jElEatwNpv+Yttf6gdUTNkG04jPrsasIcFn/gG3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd1+att0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so535614a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 17:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767663089; x=1768267889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSr22v9VsM4lMSeMepcWO61p/GBw5X2LkZ2xLfKSMBs=;
        b=Wd1+att0LIh0TeUKyqZ/JCGNPkNx41pUa7Vm22eN1JYNQpI7XmOty2/tVQW8kkPLlX
         RkfOLHYkkono/VbMOUyYOJz1ol33aP/l+rSCBHmtzm/6OR/NaUar6Gk8MPK0zQhBRgva
         H4UzY3Bn/amAiu6OjEqFiP7OaqXj7pie9WJJvKKJopoDgie9JulDoRhFBoML/D+jSI0Q
         0AwroXOnxnnqArhCdxX6SO+gYrUKONK1bT1EP38E2PGkHka2ayLFZgo38VERj8ra46Nv
         RSA+O70OunJOi7xDkx9Fm2naesr++FX/vJdnIjdXVSxjM8x6eIX+FI/N0/wz2Vb/PgQ6
         9xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767663089; x=1768267889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSr22v9VsM4lMSeMepcWO61p/GBw5X2LkZ2xLfKSMBs=;
        b=CO1uESgwhJD7JTCTZiFCktnQ8w1RvQfBahCyrJEN44c7PTzHYC038fSwAXX6o9wBYg
         50tXHoVLJGPxlOUB7SIt4KSknT8GjHRjGc0LagydRmMrbN+HKjKKXvc9KalRCB4QM5NF
         rNuQ0EZRxbFlePmJCJm3wsmV4VUsgbieWeCffUFbsfcWTu6aDKW49n7Tw2hrsxtIDXYd
         zkS0xBed+PQF2mV3GvTjJjpq6zvGtOP8Q4eNX4Sswcmvuk6hF7qTSiRa0oGoKN8KDZCx
         R64UqBsr38qnqanxrfdo3JWyVX8Fj10VJony7IflORClJWKim5/+WJ5Z+DnuIG/NIwLX
         Sesg==
X-Forwarded-Encrypted: i=1; AJvYcCVwbNrFvJBOlth5z19nWBup0Va3ClIyTizz6X4ZLwDHdGnE0Bb7wG1cYZE3tpVLShaY2OxcXLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQtP6R4BWWa2m065NFBzhUtjfiUfYdRdeMmw0Ykw3qTFIumDu
	8yEEM3/qwEn4A5mhKLfvzNbgDYmPIRbkzTnGr8OWZSs68zPAdjZ0CUel
X-Gm-Gg: AY/fxX5sK+fH52S3Q5y7UQGdyI8IXj31duPj2fM5i/b1fRuHMOfw5uRQBgulUGd7z55
	nCgCvOyOjGRAK7Ug9h+CK6VUIM2ci0rA2mmzJ1S1LGtxdZmFKF/7Z8cgeFH2UEwidfP8FghjEhK
	EoIWwjL2XwIVT3TO+TPMANlWgfVRszbH9C5KAG9M89lsfSlI/lvi92t4hvMpR7105QoDPC5gWhg
	sbW+d2VvfiIs6JF5HQYyUjDL3aEUo0WIRACO/CcjOipWgRs3Px5lUqTGBIzo3YLAYiDpARdCbGx
	4rg0A7i84LYiRHBYGVpx8OUF1ex189sSP73GENfGJ9uIPNmriWMLJlb+3CXi4AjdRebMdFz6sUj
	FL79C0El42NnI9nXtUXadD8voJt45rh0jjBgI3Al8JUgm7jdYhRK9/CFE8/58OXBOsDmoj65GeS
	1Qmc5PxgUkSYakAeKKCkXkFah8vktlOW2oRWuQXYILgtYeAUG2VmVkUi1HbKZtZ9DvP3sg
X-Google-Smtp-Source: AGHT+IFzuww/Xy/80uK91kbswO6so7QmHeLpyHjOX26IsNI5nbM4P7dx16W4aBV+8htiz9bwAwtjLQ==
X-Received: by 2002:a17:90b:58d0:b0:340:fb6a:cb4c with SMTP id 98e67ed59e1d1-34f5f2fb2camr974435a91.30.1767663088463;
        Mon, 05 Jan 2026 17:31:28 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa947ecsm544110a91.6.2026.01.05.17.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:31:28 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v4 2/2] xsk: introduce a dedicated local completion queue for each xsk
Date: Tue,  6 Jan 2026 09:31:12 +0800
Message-Id: <20260106013112.56250-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260106013112.56250-1-kerneljasonxing@gmail.com>
References: <20260106013112.56250-1-kerneljasonxing@gmail.com>
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

Based on the existing infrastructure, this patch tries to propose
a new solution to fix the problem by using a pre-allocated memory
that is local completion queue to avoid frequently performing memory
functions. The benefit comes from replacing xsk_tx_generic_cache with
local cq.

The core logics are as show below:
1. allocate a new local completion queue when setting the real queue.
2. write the descriptors into the local cq in the xmit path. And
   record the prod as @start_pos that reflects the start position of
   skb in this queue so that later the skb can easily write the desc
   addr(s) from local cq to cq addrs in the destruction phase.
3. initialize the upper 24 bits of destructor_arg to store @start_pos
   in xsk_skb_init_misc().
4. Initialize the lower 8 bits of destructor_arg to store how many
   descriptors the skb owns in xsk_inc_num_desc().
5. write the desc addr(s) from the @start_addr from the local cq
   one by one into the real cq in xsk_destruct_skb(). In turn sync
   the global state of the cq as before.

The format of destructor_arg is designed as:
 ------------------------ --------
|       start_pos        |  num   |
 ------------------------ --------
Using upper 24 bits is enough to keep the temporary descriptors. And
it's also enough to use lower 8 bits to show the number of descriptors
that one skb owns.

[1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 169 ++++++++++++++++++--------------------------------
 1 file changed, 61 insertions(+), 108 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f41e0b480aa4..f80721165fdc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -41,8 +41,6 @@ struct xsk_addrs {
 	u64 addrs[MAX_SKB_FRAGS + 1];
 };
 
-static struct kmem_cache *xsk_tx_generic_cache;
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -539,89 +537,100 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
+static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
 {
+	struct xsk_buff_pool *pool = xs->pool;
+	struct local_cq *lcq = xs->lcq;
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock(&pool->cq_cached_prod_lock);
+	if (!ret)
+		lcq->desc[lcq->prod++ & lcq->ring_mask] = addr;
 
 	return ret;
 }
 
-static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
+#define XSK_DESTRUCTOR_DESCS_SHIFT 8
+#define XSK_DESTRUCTOR_DESCS_MASK \
+	((1ULL << XSK_DESTRUCTOR_DESCS_SHIFT) - 1)
+
+static long xsk_get_destructor_arg(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	return (long)skb_shinfo(skb)->destructor_arg;
 }
 
-static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
+static u8 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
+	long val = xsk_get_destructor_arg(skb);
+
+	return (u8)val & XSK_DESTRUCTOR_DESCS_MASK;
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+/* Record the position of first desc in local cq */
+static void xsk_skb_destructor_set_addr(struct sk_buff *skb,
+					struct xdp_sock *xs)
 {
-	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	long val;
+
+	val = ((xs->lcq->prod - 1) & xs->lcq->ring_mask) << XSK_DESTRUCTOR_DESCS_SHIFT;
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
+/* Only update the lower bits to adjust number of descriptors the skb
+ * carries. We have enough bits to increase the value of number of
+ * descriptors that should be within MAX_SKB_FRAGS, so increase it by
+ * one directly.
+ */
 static void xsk_inc_num_desc(struct sk_buff *skb)
 {
-	struct xsk_addrs *xsk_addr;
+	long val = xsk_get_destructor_arg(skb) + 1;
 
-	if (!xsk_skb_destructor_is_addr(skb)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		xsk_addr->num_descs++;
-	}
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
-static u32 xsk_get_num_desc(struct sk_buff *skb)
+static u32 xsk_get_start_addr(struct sk_buff *skb)
 {
-	struct xsk_addrs *xsk_addr;
+	long val = xsk_get_destructor_arg(skb);
 
-	if (xsk_skb_destructor_is_addr(skb))
-		return 1;
+	return val >> XSK_DESTRUCTOR_DESCS_SHIFT;
+}
 
-	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
+{
+	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
+	u32 idx, pos = xsk_get_start_addr(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+	u64 addr;
 
-	return xsk_addr->num_descs;
+	idx = xskq_get_prod(pool->cq) + desc_processed;
+	addr = xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mask];
+	xskq_prod_write_addr(pool->cq, idx, addr);
 }
 
-static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
-				      struct sk_buff *skb)
+static void xsk_cq_submit_addr_locked(struct sk_buff *skb)
 {
-	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addrs *xsk_addr;
-	u32 descs_processed = 0;
+	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
+	u8 i, num = xsk_get_num_desc(skb);
 	unsigned long flags;
-	u32 idx, i;
 
 	spin_lock_irqsave(&pool->cq_prod_lock, flags);
-	idx = xskq_get_prod(pool->cq);
-
-	if (unlikely(num_descs > 1)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-
-		for (i = 0; i < num_descs; i++) {
-			xskq_prod_write_addr(pool->cq, idx + descs_processed,
-					     xsk_addr->addrs[i]);
-			descs_processed++;
-		}
-		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
-	} else {
-		xskq_prod_write_addr(pool->cq, idx,
-				     xsk_skb_destructor_get_addr(skb));
-		descs_processed++;
-	}
-	xskq_prod_submit_n(pool->cq, descs_processed);
+	for (i = 0; i < num; i++)
+		xsk_cq_write_addr(skb, i);
+	xskq_prod_submit_n(pool->cq, num);
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
-static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_cancel_locked(struct xdp_sock *xs, u32 n)
 {
+	struct xsk_buff_pool *pool = xs->pool;
+
 	spin_lock(&pool->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
 	spin_unlock(&pool->cq_cached_prod_lock);
+	/* Keep align with cq->cached_prod */
+	xs->lcq->prod -= n;
 }
 
 INDIRECT_CALLABLE_SCOPE
@@ -634,33 +643,26 @@ void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
+	xsk_cq_submit_addr_locked(skb);
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs)
 {
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	xsk_skb_destructor_set_addr(skb, xs);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addrs *xsk_addr;
-
-	if (unlikely(num_descs > 1)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
-	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, num_descs);
+	xsk_cq_cancel_locked(xs, num_descs);
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -734,33 +736,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		xsk_skb_init_misc(skb, xs);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
 				return ERR_PTR(err);
 		}
-	} else {
-		struct xsk_addrs *xsk_addr;
-
-		if (xsk_skb_destructor_is_addr(skb)) {
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-						     GFP_KERNEL);
-			if (!xsk_addr)
-				return ERR_PTR(-ENOMEM);
-
-			xsk_addr->num_descs = 1;
-			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-		} else {
-			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		}
-
-		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
-		 * would be dropped, which implies freeing all list elements
-		 */
-		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 	}
 
 	len = desc->len;
@@ -828,7 +809,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			xsk_skb_init_misc(skb, xs);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -837,25 +818,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addrs *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
-			if (xsk_skb_destructor_is_addr(skb)) {
-				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-							     GFP_KERNEL);
-				if (!xsk_addr) {
-					err = -ENOMEM;
-					goto free_err;
-				}
-
-				xsk_addr->num_descs = 1;
-				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-			} else {
-				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-			}
-
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -873,8 +838,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
@@ -893,7 +856,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-		xsk_cq_cancel_locked(xs->pool, 1);
+		xsk_cq_cancel_locked(xs, 1);
 	}
 
 	return ERR_PTR(err);
@@ -931,7 +894,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
+		err = xsk_cq_reserve_addr_locked(xs, desc.addr);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1988,18 +1951,8 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
-	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
-						 sizeof(struct xsk_addrs),
-						 0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!xsk_tx_generic_cache) {
-		err = -ENOMEM;
-		goto out_unreg_notif;
-	}
-
 	return 0;
 
-out_unreg_notif:
-	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
-- 
2.41.3


