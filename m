Return-Path: <netdev+bounces-278704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNJLJRpM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5A401F33
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E1A130A50E8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1913CF02D;
	Wed, 15 Apr 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIdLgQTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A93CF020
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241650; cv=none; b=R3f8GvMVNNyAvt59n6c1TBN17KtZ2Dyii2ZkwzDEqT5IR5Sv1AyJyx02LQwvpeiKTxCmJCZijL488i7Gqsi2da4tRrk4dKu1W4jVUTq6zpFUiIXmnO+ro16myfTRYyiJvV58eACryIYAFIFyQUAgSs9W5e9YDq3RxnFtkdBJgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241650; c=relaxed/simple;
	bh=Vc79RT/MbkG5ZKWo1KckWKV8kTJS7NNt2rnqW0KmxjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J18IWhFLT8FPJ/HLSMS4GNqoKp1y2U5oIs+3/omgRbl1oqrQlfWBlBztlBa6B6JX2iTtV4AftDlCS3C/q+AeaGSNOpUnHkH1ogWZO3YJMGEmscrOceKzXy8SAXP5J1JLYZWs1CLfut6pFZM/Mfqnrq4B8uqk01Q4sWdnjBgEVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIdLgQTA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fba3f769so29576115ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241649; x=1776846449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x78Ky5Ro4yhFj7Z+oKIQ0GQBczDEQvkM6QMGsDNo2XA=;
        b=iIdLgQTAAXS/f4HLEdap/blWh3ABudtVt+sspSoBGkUeM6ByTjiByrCpMTfc2f2hwn
         6ULfhTRx1RqjAT+KD5xueqk/qd85TmINbqvKcrH0FBo4HJlep3zyU42nrSvysIMzeNFS
         O9IlGNXMhrAe4b+PSnnI9LPadmHhTqsXOOHGl9JyIJ93Ro5ytqZMjZ/X4NCZtntGwCzb
         OdQV/JgJ4er6diUt5imr0XezDK9wEqlTud7E3HGZZkE7Qd+qi/wqPsJRcLQawwy5ONYy
         lh53DNjMfhW1R4Uww8oQRt0SpMB6JmIhrxURzr/LJhH0g32iOKoH0E/K9zlpqrICK6f6
         x1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241649; x=1776846449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x78Ky5Ro4yhFj7Z+oKIQ0GQBczDEQvkM6QMGsDNo2XA=;
        b=bFoPDszLENGIRRK4dVl/oH23X0OKnMqhNoaQxt64um/bAfQoA/UrH2CjA+3pYZFAMT
         Yu9Y5sO3sQcCx5+d9gUzsA2f+9C/Wzj5WpTWvBmdcTfsy4n4z6UuvKct1d0M9+9yoH2t
         Fx2cw4q6p+tuN1L1N61Na+mPo7xzPJyxZhdiZstGTj+l1YwPB+04HrupLgZqY+NA3ErT
         LIuCR08D7QlRhg/ixXLnJAk4Vh+rlPUkrBKzRYQp5CKOFyH6cPkBHIh4KGaQey0P5ieH
         t0m1vnJigiXxpEAKVjQUSdRUgdgkMl+TD/5G8yGtE3apgsid82bWB/GgMQELrN8ml3+6
         xhbA==
X-Forwarded-Encrypted: i=1; AFNElJ9SUd5NqWL88tYHqa3/8l74KNzOnt+6PIkhJ/a4X4sIn4cg71aLo67s9yzWgLiceV4bN+uCe/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdIRrC2OTRLTlngxJn6QI5OWOJhE2NX0LbqAJRytE5JDMWUZt
	+JM1yQIZrz4qnF53alM9lo79g6d4niSZer3rtwi+MB5RiEYQs4VicETM
X-Gm-Gg: AeBDieuCx/EoGAWshuCIWXWqvrAdxDywxXrOvpi6twac2J5Mu/1GmVZrqFfN4PalyMn
	WpGO5qNFxJGD39ybfaHtQoZ+l25rQwR/FUFSrqO8IqnVyOL9nULX8f7fmG4Ogg+5GwbRLoKO/fa
	RUHAupUcXn0pEaKckDk2jc/OuBMCVGJgW25T4AMyIQhXObJUm7FvxzKDk/4dhqWi87wiS787ng7
	hLl11u7aVGgWdWZiTKV7rXENe+PGRTmX7oif7VHTTXryBItl7hq5EVSsgJxMXex+eX+5eDzqwy2
	xMsZ6BuXVLex/QmS0jb5ZFgZaZRA3PEDtUCnwXOz6bIotUIzNFGb+X5Su6wQGxzPVY26Srgvyu0
	USFpnkfaH0GrSe4qJqgH3ZOLcVvBPyxaD6A4pFDDWo/sRKrMrgMV1h8EDpe0zZdBOvcIWaO2pXa
	OEiLYSs8J2GVishGW0Tp++a2mm6myQm4KNN3xthridH/NxcCCccmDuAsjwSoDYHBow/VH3C59XT
	D6Evd3ykzUGAG7L42M=
X-Received: by 2002:a17:903:1b6e:b0:2ae:3b9b:db34 with SMTP id d9443c01a7336-2b2d5aa0becmr224418955ad.42.1776241648612;
        Wed, 15 Apr 2026 01:27:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:27 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 04/14] xsk: cache data buffers to avoid frequently calling kmalloc_reserve
Date: Wed, 15 Apr 2026 16:26:44 +0800
Message-Id: <20260415082654.21026-5-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-278704-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 46E5A401F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

It's beneficial for small data transmission.

Replace per-SKB kmalloc_reserve() with on-demand bulk allocation from
skb_small_head_cache for small packets.

Add a persistent per-socket data buffer cache (batch.data_cache /
batch.data_count) that survives across batch cycles, similar to how
batch.send_queue caches built SKBs.

Inside the Phase-1 per-descriptor loop, when a small packet needs a
data buffer and the cache is empty, a single kmem_cache_alloc_bulk()
refills it with generic_xmit_batch objects. Subsequent small packets
pop directly from the cache. Large packets bypass the cache entirely
and fall back to kmalloc_reserve(). Unused buffers remain in the
cache for the next batch.

I observed that kmalloc_reserve() consumes nearly 40% which seems
unavoidable at the first glance, thinking adding the bulk mechanism
should contribute to the performance. That's the motivation of this
patch. Now, the feature gives us around 10% improvement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  2 ++
 net/core/skbuff.c      | 27 ++++++++++++++++++++++-----
 net/xdp/xsk.c          | 24 ++++++++++++++++++++----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 84f0aee3fb10..2151aab8f0a1 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -51,6 +51,8 @@ struct xsk_batch {
 	struct sk_buff **skb_cache;
 	struct xdp_desc *desc_cache;
 	struct sk_buff_head send_queue;
+	unsigned int data_count;
+	void **data_cache;
 };
 
 struct xdp_sock {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f29cecacd8bb..5726b1566b2b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -661,9 +661,11 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 	unsigned int total_truesize = 0;
 	struct sk_buff *skb = NULL;
 	int node = NUMA_NO_NODE;
+	void **dc = batch->data_cache;
+	unsigned int dc_count = batch->data_count;
 	u32 i = 0, j, k = 0;
 	bool need_alloc;
-	u8 *data;
+	void *data;
 
 	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
@@ -683,6 +685,13 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 		nb_pkts = skb_count;
 
 alloc_data:
+	if (dc_count < nb_pkts && !(gfp_mask & KMALLOC_NOT_NORMAL_BITS))
+		dc_count += kmem_cache_alloc_bulk(
+				net_hotdata.skb_small_head_cache,
+				gfp_mask | __GFP_NOMEMALLOC | __GFP_NOWARN,
+				batch->generic_xmit_batch - dc_count,
+				&dc[dc_count]);
+
 	/*
 	 * Phase 1: Allocate data buffers and initialize SKBs.
 	 * Pre-scan descriptors to determine packet boundaries, so we can
@@ -710,10 +719,17 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 
 			skb = skbs[skb_count - 1 - i];
 			skbuff_clear(skb);
-			data = kmalloc_reserve(&size, gfp_mask, node, skb);
-			if (unlikely(!data)) {
-				*err = -ENOBUFS;
-				break;
+			if (dc_count &&
+			    SKB_HEAD_ALIGN(size) <= SKB_SMALL_HEAD_CACHE_SIZE) {
+				data = dc[--dc_count];
+				size = SKB_SMALL_HEAD_CACHE_SIZE;
+			} else {
+				data = kmalloc_reserve(&size, gfp_mask,
+						       node, skb);
+				if (unlikely(!data)) {
+					*err = -ENOBUFS;
+					break;
+				}
 			}
 			__finalize_skb_around(skb, data, size);
 			/* Replace skb_set_owner_w() with the following */
@@ -762,6 +778,7 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 	while (k < i)
 		kfree_skb(skbs[skb_count - 1 - k++]);
 
+	batch->data_count = dc_count;
 	batch->skb_count = skb_count - i;
 
 	return j;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f97bc9cf9b9a..7a6991bc19a8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1229,14 +1229,22 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 }
 
 static void xsk_batch_reset(struct xsk_batch *batch, struct sk_buff **skbs,
-			    struct xdp_desc *descs, unsigned int size)
-{
+			    struct xdp_desc *descs, void **data,
+			    unsigned int size)
+{
+	if (batch->data_count)
+		kmem_cache_free_bulk(net_hotdata.skb_small_head_cache,
+				     batch->data_count,
+				     batch->data_cache);
+	kfree(batch->data_cache);
 	if (batch->skb_count)
 		kmem_cache_free_bulk(net_hotdata.skbuff_cache,
 				     batch->skb_count,
 				     (void **)batch->skb_cache);
 	kfree(batch->skb_cache);
 	kvfree(batch->desc_cache);
+	batch->data_cache = data;
+	batch->data_count = 0;
 	batch->skb_cache = skbs;
 	batch->desc_cache = descs;
 	batch->skb_count = 0;
@@ -1272,7 +1280,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
-	xsk_batch_reset(&xs->batch, NULL, NULL, 0);
+	xsk_batch_reset(&xs->batch, NULL, NULL, NULL, 0);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1620,6 +1628,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		struct xsk_batch *batch = &xs->batch;
 		struct xdp_desc *descs;
 		struct sk_buff **skbs;
+		void **data;
 		unsigned int size;
 		int ret = 0;
 
@@ -1638,14 +1647,21 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			ret = -ENOMEM;
 			goto out;
 		}
+		data = kmalloc_array(size, sizeof(void *), GFP_KERNEL);
+		if (!data) {
+			kfree(skbs);
+			ret = -ENOMEM;
+			goto out;
+		}
 		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
 		if (!descs) {
+			kfree(data);
 			kfree(skbs);
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		xsk_batch_reset(batch, skbs, descs, size);
+		xsk_batch_reset(batch, skbs, descs, data, size);
 out:
 		mutex_unlock(&xs->mutex);
 		return ret;
-- 
2.41.3


