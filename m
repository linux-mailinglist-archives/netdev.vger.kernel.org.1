Return-Path: <netdev+bounces-278703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O/3AQ1M32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92643401F25
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D68309930C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814D3CC9E6;
	Wed, 15 Apr 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaTXpYle"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA43CE48A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241647; cv=none; b=GEHcKCnYf30kjvOvadf7KTWz8QmaTLlxLwuwonvKWHLrLR9K3s7Mg9kkyYVJspL2rXx4al2/O4SPQ+F8fVDI5C159Ab+KGWnj3lF/3f59CVhfigP0U9Jq5oZux3HW8f43m216evb//k8Va2iIcmiYyzZtt9Dd4CAHp/hrWv+mP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241647; c=relaxed/simple;
	bh=ssYHrGn+a7n9S52P2+6nPHQRnVP+OUA5wKpSU3REoRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3VxEuTYTQK8wWwzBZdP4SaL/ac2EPw7minMyFV7Gk04gTR/nG3NlTSprcdKV4TGkYm2nh2Sq0fEHZJUX+NbbDf9OuT/bzeVZKf9dcmEvYPKRTuxli8NvxW41w6iO4UfqY86TTo3ZWvEbv/fIeD253Jd3rp7RCBC9ifj3oVGXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaTXpYle; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b299b3c739so28005205ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241644; x=1776846444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAZbJp+IhFF4A64f6LPVjeeM4XK+lI0NETlZJk9Rujg=;
        b=YaTXpYle7F5kCgkWU6kApC/NFZjCCi2A9xq3NePiXBzmKCLJEgL4bPdCixl4wQmm4n
         PmnZZOAUh/FpBqFs+fJgYKfa9Wi4Omz9bGr1aciVjGrFqR83L51GvaLes8EKagxXKO5j
         4cOMHSH7Wffd9gCZ9IKOv3TKQILCRGXRqatNLo+FJgecnQnL8cUY+IPtCjD/IfJVZqAl
         DvY2YoXY4pQLOduMglsYB/9AXzSlDbtokwKH1sDG1xIIqNUyjwYEZjcGzn1VxVQl1zyJ
         w/YSEYcY7CzQMcpyYNxCFODxEgiivhf6NurKCwoiZ+v7lvGioxvgVI4KOHCgQeEcDeDE
         otDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241644; x=1776846444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rAZbJp+IhFF4A64f6LPVjeeM4XK+lI0NETlZJk9Rujg=;
        b=Fix89dloyilHXfOSyo1g0IQcvJ16B7iq5aR65Yp+PxnHBAXnDMw9yP0D0tNssXysWM
         Ujhzxr4JqdcrOZTG+MVmr1myVyNgQlVVGwXb0VaH8qlH4/6RPpEO7j8RxrJy65ay+69a
         /8WGfb4nlWtPRlLtRzh1L6JpXjC/8sqprMX5ArHYpRXNb74s0Y4ZBhLVFrlzULCmzLhU
         h4d1znRPbeDCJ0i+o/oO+V14+5d/+5sxdId+VvMsCd3IC/zIAZJLv80czyNxBl8N/yw5
         LbzRRGZlQ9B1GOkCDKFDb11lmYDQdx01TrEy/zXV1akSIB+Job8oodxk80UBW+hNhMAh
         CsEA==
X-Forwarded-Encrypted: i=1; AFNElJ9p7YFD3FQQtOHCApuZa14qR5J24JywnIZVBUkDhJHxnFDcSGImT5c86N55GoIogFo5m856jac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+8EhQPb9CcndgFAKpgiThl1T+KgOi21It4j/NCyUri5bBOjk
	K5V92pjtRNgsceChu0Ee0OdC1Y+l4fLxKh3WV/ldFzoponw1pNzEsfk4
X-Gm-Gg: AeBDievK6dTm19jjuHRji2nF6DqdvBwdBTG/v6pBhskFJ+yo0bVj8okRB6233Xbr0rH
	Ml2RJIjzy/c8CO+slGOLQOqWXehnDXrCiBfmQ8eRLt9VW6etdzFT6xAcWE7fqQPgRqhY+vkx1js
	tTvf5Vog3AShAlTCwrWUWRX3zhf8PMlBF9+stKmzzcjqVvHIRarQXrQ4efIgSNicecXp0I2+08n
	nqXHiGNqp4WcZOzeM2VIUk5o9YFcqS1SM1tMzBFfr3F36UPPwkLKq7P6UYqstW/j221owFXfAYM
	tTMYfJJUGDYetntRGWe1QY5kXsFloQafelKrlRDrzLPEdU2hNYEh9WtaWYOTGPX2EkilcjL+IkX
	lv31EU1kve6ii7VLseeGdpmnWJFoxU0wwiGmtbFDIh7kFJbVb3MQimEll5k5BgjhfNZHEc/ve6L
	qgn2eHzhbTBmpovu+Sm4ZkzTCfY6fiHwHZ7aKKbYvH12CanP/6xGRSWNd5LYUKe8xhTSNu+oiOJ
	uqTXcvA
X-Received: by 2002:a17:902:da82:b0:2b4:6470:75f4 with SMTP id d9443c01a7336-2b4647078femr91789535ad.28.1776241643898;
        Wed, 15 Apr 2026 01:27:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:23 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 03/14] xsk: add xsk_alloc_batch_skb() to build skbs in batch
Date: Wed, 15 Apr 2026 16:26:43 +0800
Message-Id: <20260415082654.21026-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 92643401F25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Support allocating and building skbs in batch.

There are three steps for one batched allocation:
1. Reserve the skb and count the skb->truesize. It provides a way
   that for later patch to speed up small data transmission by
   diminishing the impact of kmalloc_reserve().
2. Add the total of truesize to sk_wmem_alloc at one time. The load and
   store of sk_wmem_alloc is time-consuming, so this batch process makes
   it gain the performance improvement.
3. Copy data and then finish initialization of each skb.

This patch uses kmem_cache_alloc_bulk() to complete the batch allocation
which relies on the global common cache 'net_hotdata.skbuff_cache'. Use
a xsk standalone skb cache (namely, xs->skb_cache) to store allocated
skbs instead of resorting to napi_alloc_cache that was designed for
softirq condition.

After allocating memory for each of skbs, in a 'for' loop, the patch
borrows part of __alloc_skb() to initialize skb and then calls
xsk_build_skb() to complete the rest of initialization process, like
copying data and stuff. To achieve a better result, the allocation
function only uses the function we need to keep it super clean, like
skb_set_owner_w() that is simplified into two lines of codes.

Add batch.send_queue and use the skb->list to make skbs into one chain
so that they can be easily sent which is shown in the subsequent patches.

In terms of freeing skbs process, napi_consume_skb() in the tx completion
would put the skb into global cache 'net_hotdata.skbuff_cache' that
implements the deferred freeing skb feature to avoid freeing skb one
by one to improve the performance.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |   3 +
 net/core/skbuff.c      | 121 +++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk.c          |   7 +++
 3 files changed, 131 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 90c709fd1239..84f0aee3fb10 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -47,8 +47,10 @@ struct xsk_map {
 
 struct xsk_batch {
 	u32 generic_xmit_batch;
+	unsigned int skb_count;
 	struct sk_buff **skb_cache;
 	struct xdp_desc *desc_cache;
+	struct sk_buff_head send_queue;
 };
 
 struct xdp_sock {
@@ -136,6 +138,7 @@ INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4045d7c484a1..f29cecacd8bb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/psp/types.h>
 #include <net/dropreason.h>
 #include <net/xdp_sock.h>
+#include <net/xsk_buff_pool.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -647,6 +648,126 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
+#ifdef CONFIG_XDP_SOCKETS
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err)
+{
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct sk_buff **skbs = batch->skb_cache;
+	u32 alloc_descs, base_len, wmem, sndbuf;
+	gfp_t gfp_mask = xs->sk.sk_allocation;
+	u32 skb_count = batch->skb_count;
+	struct net_device *dev = xs->dev;
+	unsigned int total_truesize = 0;
+	struct sk_buff *skb = NULL;
+	int node = NUMA_NO_NODE;
+	u32 i = 0, j, k = 0;
+	bool need_alloc;
+	u8 *data;
+
+	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		base_len += dev->needed_tailroom;
+
+	if (xs->skb)
+		nb_pkts--;
+
+	if (skb_count >= nb_pkts)
+		goto alloc_data;
+
+	skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+					   gfp_mask,
+					   nb_pkts - skb_count,
+					   (void **)&skbs[skb_count]);
+	if (skb_count < nb_pkts)
+		nb_pkts = skb_count;
+
+alloc_data:
+	/*
+	 * Phase 1: Allocate data buffers and initialize SKBs.
+	 * Pre-scan descriptors to determine packet boundaries, so we can
+	 * batch the sk_wmem_alloc charge in Phase 2.
+	 */
+	need_alloc = !xs->skb;
+	wmem = sk_wmem_alloc_get(&xs->sk);
+	sndbuf = READ_ONCE(xs->sk.sk_sndbuf);
+	for (j = 0; j < nb_descs; j++) {
+		if (need_alloc) {
+			u32 size = base_len;
+
+			if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+				size += descs[j].len;
+
+			if (i >= nb_pkts) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			if (wmem + size + total_truesize > sndbuf) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			skb = skbs[skb_count - 1 - i];
+			skbuff_clear(skb);
+			data = kmalloc_reserve(&size, gfp_mask, node, skb);
+			if (unlikely(!data)) {
+				*err = -ENOBUFS;
+				break;
+			}
+			__finalize_skb_around(skb, data, size);
+			/* Replace skb_set_owner_w() with the following */
+			skb->sk = &xs->sk;
+			skb->destructor = sock_wfree;
+			total_truesize += skb->truesize;
+			i++;
+			need_alloc = false;
+		}
+		if (!xp_mb_desc(&descs[j]))
+			need_alloc = true;
+	}
+	alloc_descs = j;
+
+	/*
+	 * Phase 2: Batch charge sk_wmem_alloc.
+	 * One refcount_add() replaces N per-SKB skb_set_owner_w() calls,
+	 * which gains much performance improvement.
+	 */
+	if (total_truesize)
+		refcount_add(total_truesize, &xs->sk.sk_wmem_alloc);
+
+	/* Phase 3: Build SKBs with packet data */
+	for (j = 0; j < alloc_descs; j++) {
+		if (!xs->skb) {
+			skb = skbs[skb_count - 1 - k];
+			k++;
+		}
+
+		skb = xsk_build_skb(xs, skb, &descs[j]);
+		if (IS_ERR(skb)) {
+			*err = PTR_ERR(skb);
+			break;
+		}
+
+		if (xp_mb_desc(&descs[j])) {
+			xs->skb = skb;
+			continue;
+		}
+
+		xs->skb = NULL;
+		__skb_queue_tail(&batch->send_queue, skb);
+	}
+
+	/* Phase 4: Reclaim unused allocated SKBs */
+	while (k < i)
+		kfree_skb(skbs[skb_count - 1 - k++]);
+
+	batch->skb_count = skb_count - i;
+
+	return j;
+}
+#endif
+
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ecd5b9c424b8..f97bc9cf9b9a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
+#include <net/hotdata.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
@@ -1230,10 +1231,15 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 static void xsk_batch_reset(struct xsk_batch *batch, struct sk_buff **skbs,
 			    struct xdp_desc *descs, unsigned int size)
 {
+	if (batch->skb_count)
+		kmem_cache_free_bulk(net_hotdata.skbuff_cache,
+				     batch->skb_count,
+				     (void **)batch->skb_cache);
 	kfree(batch->skb_cache);
 	kvfree(batch->desc_cache);
 	batch->skb_cache = skbs;
 	batch->desc_cache = descs;
+	batch->skb_count = 0;
 	batch->generic_xmit_batch = size;
 }
 
@@ -1946,6 +1952,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	INIT_LIST_HEAD(&xs->map_list);
 	spin_lock_init(&xs->map_list_lock);
+	__skb_queue_head_init(&xs->batch.send_queue);
 
 	mutex_lock(&net->xdp.lock);
 	sk_add_node_rcu(sk, &net->xdp.list);
-- 
2.41.3


