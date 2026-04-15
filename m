Return-Path: <netdev+bounces-278711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPPmHi5M32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801E401F58
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D6F3040B0D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840763B0AEF;
	Wed, 15 Apr 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dStVBq0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F173A3E78
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241697; cv=none; b=Vgey2ZX5CcOWmqziBOajrlfCVpiz7ETh3Z210tEiILRlPQaKYZ32neRAnkVTtTDt0NwhYiVwjUBZd3y5cC2X+V727J+a5fhjdmJsthVUAnYxGH2n25yfdv/ZSWkkNMEXImK2/NhJBofyqdhRr+anezNWRJw7XgRhNKVNsyZmoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241697; c=relaxed/simple;
	bh=VFxn96JHNW5QH+1nLwEYppxJ0YIlpZL6X5l+KJFGafY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSKQZhTnP1reDgoL31pPc0mslj3IaX1bmarbFpXLSWQucLA7vZW1sNyXu/udMxUEC/4u9yMTx0xHwZ+uW+j05c57HzFLMsaB9BrOoRwieL/NMI0QNziBxN7hSbXaOQrb4t0s+urle2P7IPS6mxuBAa685XSrsvwDYP7mk6q7egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dStVBq0D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b458ca2296so22567735ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241695; x=1776846495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIyBdT4LGGdGx6wgDVyPUXcWl+JiGu8xkKVYACtK5gw=;
        b=dStVBq0D5Wq+ahbjERsatjlq35YuYAFEVBW5GBViy5lugYZxAmTcGM9pHk5bgcuX9w
         SKQliAlVzCl57V1b0Z4nRw33QW3foItyw6PZZQxHQ6N8qExg+iBcjs4dmbZoMATSbzvH
         GmXwntnRXhZNobkIGss8iMky9Cov69jeb9XLcMBg4s9EBuFsodg6fCI7ac3pShrTjhIE
         CnZ9z0JXRA7vGbrWfGCDnI9+3NhF+U1ZM70p6wOyRtsCLZPKX6xSaXtxv9WVpLCK2zI3
         vDIviXmYtFl0uC/7OLnWz7nn/K27LVGAAqx9NyqS5tD+UlvGYGa4VWSNX1xPG9KxZ2GM
         KpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241695; x=1776846495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIyBdT4LGGdGx6wgDVyPUXcWl+JiGu8xkKVYACtK5gw=;
        b=Rpz828p7sNS0Aoim2iMyNU0dyVrFeLJqUgvDb64Up5vvs8lJonD2oswq2iRUh02+J5
         Bh9VYJqMZewvx50E0EE5Ng2/pJzmpxD7Z1f5pHX52tfv56eplO/DOMjf4GMhWao5mgwy
         aLRJ941xldZbUKjUIHyogocenmpJEiMH7kbsYD5BNqdRtxPoqLrEfE21lO5oEYCGKPIy
         Gw7+PadHN7bwg61k5A401SDxDbpW6VxtQKDgfRPmQWSCFXMB88CanA2FlMuyrwPL+zgk
         JOMn2d0Nx0QOcAVWa4HCfdB03x4mDtjZiUmP7MraC2BbQ6/scuO1p+1NR9SnyVWkDjuY
         SRrA==
X-Forwarded-Encrypted: i=1; AFNElJ8XbY/oGZbxkksudXUpkAaH3NOx3Xa6UiUcZFPSDvyVIKENQfp87vrj22SZiFFuPS7jD0yybyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMYfmrudakirkhPYcV7WllkM7zylMLqOQX5BY7OW7Cd/wZ85/
	xYj3xdqFrtuPF1JP+NokS+U7qMn12uAMShdDkEA3gOqq+7gw3HzVyLJQ
X-Gm-Gg: AeBDiet23ZqtK+6dhizwbkITGJ1vCVQ8sVi6CgEmpCp0pmEfT64qoN97jqIZMXhILP4
	mwifSEwbwI/GnzJiC4elcM/mC0Eu0HuyecXRUyT/CkJjgqtHyi+goEg7449Bidw38I5tgncwRIn
	XPtO7zGcAEXiNV4Nh4ShWCB0FFedDI/flJlMFFANFJSekvxtlCpwfyRrm5LG5f//W85h2SA2FKa
	hhflZcsfsyO3jSrHjaEIwWFMQVxZW7xZOLBT2oPRUVHuEkRgWhf8ZVvTOnGwhoSh/EPk+36IDn2
	kR1YC3lREhJ0dhXJNn0XE6jTQVD/m6YPFt/XZIrBezs9G9td8i2IYDrcctcw/GUHXAsuCfyP+PK
	8ZHgUqUMFg67LjXyVklqKgysx2BleU1CfR77RzM0GmIwoJ7FNrpsaBMNdcFl0xmDSUUxsqrYVSW
	HW57mrFywIFg/F+Bc69x/i9EVOfUwEeGROXgd5T694FVftSqMOrmTGS4Ulle8gTayBtBRoCIDmT
	g5vfXmY
X-Received: by 2002:a17:903:1207:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b2d5939275mr213554065ad.7.1776241695479;
        Wed, 15 Apr 2026 01:28:15 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:14 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 11/14] xsk: support batch xmit main logic
Date: Wed, 15 Apr 2026 16:26:51 +0800
Message-Id: <20260415082654.21026-12-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278711-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2801E401F58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

This function __xsk_generic_xmit_batch() is the core function in batches
xmit, implement a batch version of __xsk_generic_xmit().

The whole logic is divided into sections:
1. check if we have enough available slots in tx ring and completion
   ring.
2. read descriptors from tx ring into pool->tx_descs in batches
3. reserve enough slots in completion ring to avoid backpressure
4. allocate and build skbs in batches
5. send all the possible packets in batches at one time

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 116 ++++++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk_queue.h |   8 +++
 2 files changed, 124 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c26e26cb4dda..e1ad2ac2b39a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -920,6 +920,122 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return ERR_PTR(err);
 }
 
+static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
+{
+	struct xsk_buff_pool *pool = xs->pool;
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct net_device *dev = xs->dev;
+	u32 max_batch, max_budget;
+	bool sent_frame = false;
+	struct sk_buff *skb;
+	u32 cons_descs;
+	int err = 0;
+	u32 i = 0;
+
+	mutex_lock(&xs->mutex);
+
+	/* Since we dropped the RCU read lock, the socket state might have changed. */
+	if (unlikely(!xsk_is_bound(xs))) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (xs->queue_id >= dev->real_num_tx_queues) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (unlikely(!netif_running(dev) || !netif_carrier_ok(dev))) {
+		err = -ENETDOWN;
+		goto out;
+	}
+
+	max_budget = READ_ONCE(xs->max_tx_budget);
+	max_batch = batch->generic_xmit_batch;
+
+	for (i = 0; i < max_budget; i += cons_descs) {
+		u32 nb_pkts = 0;
+		u32 nb_descs;
+
+		nb_descs = min(max_batch, max_budget - i);
+		nb_descs = xskq_cons_nb_entries(xs->tx, nb_descs);
+		if (!nb_descs)
+			goto out;
+
+		/* This is the backpressure mechanism for the Tx path. Try to
+		 * reserve space in the completion queue for all packets, but
+		 * if there are fewer slots available, just process that many
+		 * packets. This avoids having to implement any buffering in
+		 * the Tx path.
+		 */
+		nb_descs = xsk_cq_reserve_locked(pool, nb_descs);
+		if (!nb_descs) {
+			err = -EAGAIN;
+			goto out;
+		}
+
+		cons_descs = xskq_cons_read_desc_batch_copy(xs->tx, pool, descs,
+							    nb_descs, &nb_pkts);
+		if (cons_descs < nb_descs) {
+			u32 delta = nb_descs - cons_descs;
+
+			xsk_cq_cancel_locked(pool, delta);
+			xs->tx->queue_empty_descs += delta;
+			if (!cons_descs) {
+				err = -EAGAIN;
+				goto out;
+			}
+			nb_descs = cons_descs;
+		}
+
+		cons_descs = xsk_alloc_batch_skb(xs, nb_pkts, nb_descs, &err);
+		/* Return 'nb_descs - cons_descs' number of descs to the
+		 * pool if the batch allocation partially fails
+		 */
+		if (cons_descs < nb_descs) {
+			xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs);
+			xsk_cq_cancel_locked(pool, nb_descs - cons_descs);
+		}
+
+		if (!skb_queue_empty(&batch->send_queue)) {
+			int err_xmit;
+
+			err_xmit = xsk_direct_xmit_batch(xs, dev);
+			if (err_xmit == NETDEV_TX_BUSY)
+				err = -EAGAIN;
+			else if (err_xmit == NET_XMIT_DROP)
+				err = -EBUSY;
+
+			sent_frame = true;
+		}
+
+		if (err)
+			goto out;
+	}
+
+	/* Maximum budget of descriptors have been consumed */
+	if (xskq_has_descs(xs->tx))
+		err = -EAGAIN;
+
+out:
+	if (xs->skb)
+		xsk_drop_skb(xs->skb);
+
+	/* If send_queue has more pending skbs, we must to clear
+	 * the rest of them.
+	 */
+	while ((skb = __skb_dequeue(&batch->send_queue)) != NULL) {
+		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
+		xsk_consume_skb(skb);
+	}
+	if (sent_frame)
+		__xsk_tx_release(xs);
+
+	mutex_unlock(&xs->mutex);
+	return err;
+}
+
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 34cc07d6115e..c3b97c6f2910 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -314,6 +314,14 @@ xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 					   NULL, pool->xdp_zc_max_segs);
 }
 
+static inline u32
+xskq_cons_read_desc_batch_copy(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			       struct xdp_desc *descs, u32 max, u32 *nb_pkts)
+{
+	return __xskq_cons_read_desc_batch(q, pool, descs, max,
+					   nb_pkts, MAX_SKB_FRAGS);
+}
+
 /* Functions for consumers */
 
 static inline void __xskq_cons_release(struct xsk_queue *q)
-- 
2.41.3


