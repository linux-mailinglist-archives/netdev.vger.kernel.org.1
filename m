Return-Path: <netdev+bounces-177284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E9A6E8F3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F93B046F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1021624E0;
	Tue, 25 Mar 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qb9LfOtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756C64D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877841; cv=none; b=iSThvtLeokGJGOBXcs//g+achEyQj2+gim8wvPeikQZgy7N6gCljfTOjDpmrmJJ+oy/6p3mLZ+0AdWqMtf2dhGGgfw68C4ggIQe/cGcNd1kwOytQXTsxOpfMraBX8S2jsZBJ3fl/bKXWJQnHEaYe2Ql70FCrm5beCejsoNdj3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877841; c=relaxed/simple;
	bh=+FPzhCZfGPdmDFo2x1q16A4HJ/qH3OvYccxNznFks38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qYed0ZripLEtX1i9uSis3e+YjOdAbglJ2n2rEwG7tInPI9m+DJ+49Z1w1uc6qM8Ze3eWKLecYyIz5Kd1xBbjYbm1Bw7JCQ+U7NNhHhVy8qO3uFc3cSKq4pDRyhzkPbkYQtJ4gR1KkV01ZBALS5FUm0EsUoWWpkXFxP90t0UHdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qb9LfOtq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso4067252a91.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742877839; x=1743482639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjWrQnCEsyDVWdfFmfURI3li0SPXTS8MU5RMzqHNwgo=;
        b=qb9LfOtqI/F1ynfuveJrTO20YOGgA5pzpzZozZ3O2GyPiLXDNU3NyVCu2JE4pK/DcF
         dtPT71dFiI1g2eBrtuhxQVf6QhEUh5tOvFMzLabMetGzzMUTdGV3pxqjsmkzNsGx3q3C
         u6OxBgjqg2n2oDva77ZURjqMoPvQeES3JW1NaaBz1BT86H9k2VV/DHH6britfDdTYBnW
         YEmblZQ7fy+ri6x3lzf7LrzgJSCfYMgh+5VCeZcCxs7rtgyU52qPCiUj/qwGH4dwojjk
         MdMPGvJzTFCxfQtokDhwsO4zYqmcdwKHjpo6jWvGlpXdpHbE86Sggz5jm0N0KUyu0BmE
         uHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742877839; x=1743482639;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjWrQnCEsyDVWdfFmfURI3li0SPXTS8MU5RMzqHNwgo=;
        b=hY1Ezi0NAWJn1dAYuzK7+Rlz0j5Ge//C8u2+MjTofOy5MA66vChACL3j+pxASano6u
         TSKvuhaZt5FwQOGDJBjx6NPZPOZ/OI46YVeRVkGUd0B7iqPQpzbE+q+XEwnehz/l3dIQ
         Kdb8BnINjQPX6HYkdzGwRTG1V6qeOT+1Ggp5toTwoBx45+gQ4t1OVE4Ox+mxBukbZRto
         0r1VYJt0O8n0hW0WhStMfs2r21lKSnUGoVnmfQmnPsSWtmAhgyTMibsZaXTjTTUJjJ1N
         +GhFPdJF/RtGlSiizbZtVXo5M/wpn+vk/9T64zdml8ob1Fk5FXmKqqlauBHb6qA4pct1
         AoJQ==
X-Gm-Message-State: AOJu0YxTEmkzqR36hvKt5wrd1YBl3+MbzWyKPLRP786Krj7RIQQg4xy0
	LFX1soIgljHvyWzYPHpe6OTWzp2PFMqB3cr07W1gAjuPth/9CvfVt0bCidQQjYFFPK2CgG77PB9
	pcoBif8KcyA==
X-Google-Smtp-Source: AGHT+IGnJv7gHpTrZ9oTjzfe29J4iOp6YDtt3s82Qn2kEy+ToAIhI01oMRSxabZ1S8E+CkxIrP5e4RWTkuaylQ==
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2ff:5516:6add])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d8b:b0:2fa:13d9:39c with SMTP id 98e67ed59e1d1-3030fe813afmr29113348a91.14.1742877839477;
 Mon, 24 Mar 2025 21:43:59 -0700 (PDT)
Date: Tue, 25 Mar 2025 04:43:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325044358.2675384-1-skhawaja@google.com>
Subject: [PATCH net-next] xsk: Bring back busy polling support in XDP_COPY
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
busy polling support in xsk for XDP_ZEROCOPY after it was broken in
commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
support with XDP_COPY remained broken since the napi_id setup in
xsk_rcv_check was removed.

Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
can be used to poll the underlying napi.

Tested using AF_XDP support in virtio-net by running the xsk_rr AF_XDP
benchmarking tool shared here:
https://lore.kernel.org/all/20250320163523.3501305-1-skhawaja@google.com/T/

Enabled socket busy polling using following commands in qemu,

```
sudo ethtool -L eth0 combined 1
sudo ethtool -G eth0 rx 1024
echo 400 | sudo tee /proc/sys/net/core/busy_read
echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
```

Fixes: 5ef44b3cb43b ("xsk: Bring back busy polling support")
Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 net/xdp/xsk.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e5d104ce7b82..de8bf97b2cb9 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -310,6 +310,18 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 	return false;
 }
 
+static void __xsk_mark_napi_id_once(struct sock *sk, struct net_device *dev, u32 qid)
+{
+	struct netdev_rx_queue *rxq;
+
+	if (qid >= dev->real_num_rx_queues)
+		return;
+
+	rxq = __netif_get_rx_queue(dev, qid);
+	if (rxq->napi)
+		__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
+}
+
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
@@ -323,6 +335,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		return -ENOSPC;
 	}
 
+	__xsk_mark_napi_id_once(&xs->sk, xs->dev, xs->queue_id);
 	return 0;
 }
 
@@ -1300,13 +1313,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
-	if (xs->zc && qid < dev->real_num_rx_queues) {
-		struct netdev_rx_queue *rxq;
-
-		rxq = __netif_get_rx_queue(dev, qid);
-		if (rxq->napi)
-			__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
-	}
+	if (xs->zc)
+		__xsk_mark_napi_id_once(sk, dev, qid);
 
 out_unlock:
 	if (err) {
-- 
2.49.0.395.g12beb8f557-goog


