Return-Path: <netdev+bounces-231259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93CBF6B08
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C75A19A54BB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA77334C2A;
	Tue, 21 Oct 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6KzmLHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703A334373
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052353; cv=none; b=u+eAMQI1/US2brjK8YA70PIPXUzDatigi5cbt8S51Bm8FEjhRropZmtc/F+HZSZ8jCzmBAialuQyJAJGlNaUuovodWAYzGWVzsLBZc6vSFYxPiFxYgy/so5ZQ1pr5r785fsR21FUvadnht51DtYhZaFt8koH0GmLaykNbbJgYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052353; c=relaxed/simple;
	bh=x416DJPTmQXTm8XE6ZkVhfdHai2ADq7eJGifrFrmn14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkaUuBz8+a/MizGVr9pBPgUs7/HBp9lCk9z/x2JVcyj2Cu0D9B2Bh7z/91c2qinmqHSBiplXNzLM8R2J8VO0LGgf58ff+B2uISB29+xXuO5Ys2UFPOZYHaWMKuXwqq8ybeucMezHJUs23qJbPffd+F1Y4bMOACNAMyhHAWDTFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6KzmLHy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b57bffc0248so3927824a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052351; x=1761657151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1r4hJXktqrgi/xhdNR7M1d2EmSJ0O1fWXeaj+3yGzA=;
        b=H6KzmLHyE4m3bkZZm2v4jzK8ZP72nwGwlIBL+Ixgxu3BcgC6Gj/ERNoGqvm2Pt6n4p
         o7zHyhUQjN1obU79xjjPzvsiACz0UF4ypLpW29NoiRINrlG1YFHWJZAXRHHTNPRPGLIp
         2+Ikmk22WiPws8CRhYwtW66dbi23O6sol3ZPc8Sen9fAtY6af3Vy78bODSuyj8hmsJ2y
         OqgyU2YtBV78UF+xjebTXZ/98Oc/cFbx5iFrtzGs9rnPYTYvFTF3W6OW4YcCtRLhBIvd
         AsFU+G1jpvJ0i2BbKrzJZnCQjfEpw1RA7UIFQXqsIF9bDyNWcphjehzX4H2aSX7t0TdK
         wnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052351; x=1761657151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1r4hJXktqrgi/xhdNR7M1d2EmSJ0O1fWXeaj+3yGzA=;
        b=EZjp/pyq21yjEDMXiqkxc8ZLHVPgRfc5B73QRg9QUe9BwekX2M3VfFxKVGisxj1S45
         Oz5z8yCUwtPRUR2z4FJgW7xdfDp5bVgfVbeGhpBow6Hbc7kuaMnuv11eiQL4+aWU315N
         CG2D4Z0PdAsiKbYgEN+YQg/8La3NAYeEwohiSKukSBsRdcwHU+W3Pm6E74tL/uG/dSeC
         DrFDdyRUbwfHbDrK6zBiVTGVrG4CT4ejI+a0kTlOs0pSqVeN/zyB8mmzH4bTNs9f/okH
         yYPUEy9eOe3OkUP6Y1JW5eZzN6D1o5tEFXlDj1EyNtkNB6bzdSTMK+Ba8VlCvIg1lVWO
         k/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCULeIflfJssZBFAkd/hRJJGMx/jfFqwQ16kVrIhOdzRkmU0rRu+Nyx7JLVw6HNmt4zr/zrf7fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3iKiM+8uiItw+VY+1+o0xypgTgTzti9GACB5cZI6FRDybbhB
	VDLK8sFW5Nw5TbRMa+8vb5ed1VuGSwpLJIgr+trhoE/WiGa6Lr+Mbj5WHxaZqHXwtyo=
X-Gm-Gg: ASbGncu1V8+DW7NojlNie5ydoetRCmdiyelqXH9qXZNKxj8sxWHDQbZByZL7zz8/VnT
	th29qZbm/+KpfAnnIQisqP7jRLxhyvSH5A6dNsFG/Gm8t7gCPR247a7hEEoMuPRH4hmd090Owrm
	C/pCTxI8MykoB/pyRCkfaiMGNRu4IF9Y2qlShOosed9XPT3NxnpVEhJHs6TCD0I3Pb1z1o996xb
	+tHV9TZV5bmdlmshK77GHniPnDGFBe+XuPlmjCLO2Jl+OEsBT2S+8mR/Y4M6DDPF1bvcxHOHA2x
	J0NhwA4xMDvr0lkrIJDEG/1mg0/rMV8YgmJuoAWcEqIenxfho0rieaXil7YIdScPJwy+/K/SxrF
	3oHBGEmWUNzFuoddLLyzsPoHf11CHx+c1s6afnNWfZzJ0O31z5MsSkw34gF7yBcARb+Iuwqnd69
	aKNCCR/7clRI6rJMn9jF8a61uHJRdmqMLDXeDjK8zXTOMb0cca5JoqF+r8yQ==
X-Google-Smtp-Source: AGHT+IHYFGhUmZxyysQHFil1L0K9sDArAoc0iH+PkiIhYFFUVEN7aFnAht9Gz/xLbgin2jX4tsmrbw==
X-Received: by 2002:a17:902:f541:b0:292:9ac7:2608 with SMTP id d9443c01a7336-2929ac72697mr101761965ad.8.1761052350711;
        Tue, 21 Oct 2025 06:12:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:30 -0700 (PDT)
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
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build skbs in batch
Date: Tue, 21 Oct 2025 21:12:03 +0800
Message-Id: <20251021131209.41491-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Support allocating and building skbs in batch.

This patch uses kmem_cache_alloc_bulk() to complete the batch allocation
which relies on the global common cache 'net_hotdata.skbuff_cache'. Use
a xsk standalone skb cache (namely, xs->skb_cache) to store allocated
skbs instead of resorting to napi_alloc_cache that was designed for
softirq condition.

After allocating memory for each of skbs, in a 'for' loop, the patch
borrows part of __allocate_skb() to initialize skb and then calls
xsk_build_skb() to complete the rest of initialization process, like
copying data and stuff.

Add batch.send_queue and use the skb->list to make skbs into one chain
so that they can be easily sent which is shown in the subsequent patches.

In terms of freeing skbs process, napi_consume_skb() in the tx completion
would put the skb into global cache 'net_hotdata.skbuff_cache' that
implements the deferred freeing skb feature to avoid freeing skb one
by one to improve the performance.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |   3 ++
 net/core/skbuff.c      | 101 +++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk.c          |   1 +
 3 files changed, 105 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 8944f4782eb6..cb5aa8a314fe 100644
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
@@ -130,6 +132,7 @@ struct xsk_tx_metadata_ops {
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0..5b6d3b4fa895 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,8 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
+#include <net/xsk_buff_pool.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -615,6 +617,105 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err)
+{
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct sk_buff **skbs = batch->skb_cache;
+	gfp_t gfp_mask = xs->sk.sk_allocation;
+	struct net_device *dev = xs->dev;
+	int node = NUMA_NO_NODE;
+	struct sk_buff *skb;
+	u32 i = 0, j = 0;
+	bool pfmemalloc;
+	u32 base_len;
+	u8 *data;
+
+	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		base_len += dev->needed_tailroom;
+
+	if (batch->skb_count >= nb_pkts)
+		goto build;
+
+	if (xs->skb) {
+		i = 1;
+		batch->skb_count++;
+	}
+
+	batch->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+						  gfp_mask, nb_pkts - batch->skb_count,
+						  (void **)&skbs[batch->skb_count]);
+	if (batch->skb_count < nb_pkts)
+		nb_pkts = batch->skb_count;
+
+build:
+	for (i = 0, j = 0; j < nb_descs; j++) {
+		if (!xs->skb) {
+			u32 size = base_len + descs[j].len;
+
+			/* In case we don't have enough allocated skbs */
+			if (i >= nb_pkts) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			if (sk_wmem_alloc_get(&xs->sk) > READ_ONCE(xs->sk.sk_sndbuf)) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			skb = skbs[batch->skb_count - 1 - i];
+
+			prefetchw(skb);
+			/* We do our best to align skb_shared_info on a separate cache
+			 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
+			 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
+			 * Both skb->head and skb_shared_info are cache line aligned.
+			 */
+			data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
+			if (unlikely(!data)) {
+				*err = -ENOBUFS;
+				break;
+			}
+			/* kmalloc_size_roundup() might give us more room than requested.
+			 * Put skb_shared_info exactly at the end of allocated zone,
+			 * to allow max possible filling before reallocation.
+			 */
+			prefetchw(data + SKB_WITH_OVERHEAD(size));
+
+			memset(skb, 0, offsetof(struct sk_buff, tail));
+			__build_skb_around(skb, data, size);
+			skb->pfmemalloc = pfmemalloc;
+			skb_set_owner_w(skb, &xs->sk);
+		} else if (unlikely(i == 0)) {
+			/* We have a skb in cache that is left last time */
+			kmem_cache_free(net_hotdata.skbuff_cache,
+					skbs[batch->skb_count - 1]);
+			skbs[batch->skb_count - 1] = xs->skb;
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
+		i++;
+		__skb_queue_tail(&batch->send_queue, skb);
+	}
+
+	batch->skb_count -= i;
+
+	return j;
+}
+
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f9458347ff7b..cf45c7545124 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1906,6 +1906,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	INIT_LIST_HEAD(&xs->map_list);
 	spin_lock_init(&xs->map_list_lock);
+	__skb_queue_head_init(&xs->batch.send_queue);
 
 	mutex_lock(&net->xdp.lock);
 	sk_add_node_rcu(sk, &net->xdp.list);
-- 
2.41.3


