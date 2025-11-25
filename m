Return-Path: <netdev+bounces-241460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F147C84169
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31B23B1AE5
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520F301493;
	Tue, 25 Nov 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY5soBnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5652FE075
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060894; cv=none; b=M0cAhkvSf+8Shae5FGyAHVjtnN9J2ae1I9ro9c9UA5P+N1VYJxnD/gsv92kp9gSGXZsWacv2ld1MDN7339IdwL0KMyMJ/NeB9DWLuRHPCbXdO9BDsKNt5y1RRQD7ggUskKyuFKy01I/syptSBLZDd/MXocHfpRK+TpFkx7fKtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060894; c=relaxed/simple;
	bh=Ok3mRBg8ae04myX6qaVX7TNLkRS3M+HoUfW/6QCdRcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hE2vFtqCNlL3+HcBHlvcr9+MiedenFSBgeOog3VLFRzJMDTRVYVhtCs8E4h0jSW56PO2HLiSisI8sMT3i1y1Gg1WlQFm2r0DUa/p4QliNnVh/H1PKGnRnedrkg1XlpPfwzTGGEX6nUFp1FMwjEqyy1vl+wCzF0p8G/uidpLPgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY5soBnI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6170201b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060891; x=1764665691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+Krjmil4qt6pqmJBfOpvopKmKzliP+4VSIbIi7K7CE=;
        b=RY5soBnIkr07UnkzvpBEOyzkVywDiDLJwyHUoolRqeiZddqJlLJYSoQHN+v4K8Nwa9
         RIWB3M57EwGw1ENz2OCoYDsrvlTucTzleR6Kue4Xg6LOuKe1nAQVbDOfI2WpsIif4lKr
         eyTYrtZr3kDQtVPa8IN9MerSebRNl+DbJTVjR+QrsuJuwq6H7zRUiVir/N8Q0BDhH9kG
         x+VXFLOKSAGMFlT/OWOb20Q8qlUqEluPx3Nj58u4npogQwUnwxA6U+kyZ/9Oi4llhjYW
         SuIT3hacgoLfLWKlqkj7djnIDB2+V52+rkFHa599Y0UaFMBN+y/Jq0bypq0I5+zts+fF
         FUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060891; x=1764665691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+Krjmil4qt6pqmJBfOpvopKmKzliP+4VSIbIi7K7CE=;
        b=jIvadNxB0iKDPMgpgjYAk4ncBCSSD1nhS361SB/qIi1sHF5uP6/xaEjKIPRpd8zJ6V
         4wy9IWB00dDXHrWSK4sViSwhwvm6Tb+6sRZ6F2BM7NbxUcvXt5a+liDr8xeP2lsQWTYC
         ZLNC6kj/sGtfls2DI9YZfiJVG60f9730/a0SmGMztven6jzrMsITpFpsrJBBVFQZKypj
         pi57xhx9rtmvfUYvG54YAUt2n+EWkKZt9eMz5sE6hPd8WC4p/OOWERXBmgZdyEwWshXY
         JL84ZT6S2DH9KxhilamXaZNIHFOYslZD4t+NGk0GkEbu0vV2gB46xjxtRp7rCs+4IYAS
         hnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWJvUVSWM5g/90KtLwr7r5FcQy7BwuXVkchFBeY0d6pQ93NxfIZJJwL86CuIDumq3HO56och+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8I99J9lQZBISXcgFN2/IXNfIrFv7myZb2vcph/5mmquh2IHF
	5SWd6SnCgl9EOg/OPqivdzbUujz7+lSkUtpArPRkXtQgmLxl+eJd/r+X
X-Gm-Gg: ASbGncu+aD6+wkNM3JfAJ4yNx67W7bBXf5H8kdAve8LtyEQby1zPPThdg73A1EivumG
	kM0ppiOBP+xw2r0lbsdlAoBMmV8jguArwY9+C8/emuw1tH62mja2YC8kX+7ssjzLlvXh3kg1n5N
	swuXD5NRZ9bQ88qdrHf1GPilCERxLdtkF72iiDV2vNs+lqG3HenhlLlVmffREdXRCUZCNCkqpeb
	ua0rkEi+u0406dGEIvDqgI7wfpUoDj2YGy8iEkMmk0Yp+TwXBSiKmGUG3kgUQNsQsRZWlbFOvYT
	lgFxluRs9S12VT7lm/yL2wek9a0BnEKxn+gn+LjorKEuAiAdUk3Ual+4Kjrhr776DGXI8EuJd/H
	IoZDq1Ctb2Hwp+fnKrvEaiYWdbvqmaKxjUDB8q9L9pxVIEoFibdXksoD0WngaDoc6vksFB5umjc
	evaPZxC7JkvFRY3e5e8fh0Tbv6NyaPFXHea8M+rZKz2J+++2G9iPSArwKQFw==
X-Google-Smtp-Source: AGHT+IEyEyLRi0GXMqk1SKyOfiYTlgjWnclkF+XRy98lS+QNqzCwjwwc4kl7eTdrnggMFRYlP/yN6g==
X-Received: by 2002:a05:6a20:3d1a:b0:34f:47f8:cca2 with SMTP id adf61e73a8af0-36150f424b2mr14021074637.58.1764060891146;
        Tue, 25 Nov 2025 00:54:51 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe6dsm15192263a12.34.2025.11.25.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:54:50 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] xsk: remove spin lock protection of cached_prod
Date: Tue, 25 Nov 2025 16:54:31 +0800
Message-Id: <20251125085431.4039-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125085431.4039-1-kerneljasonxing@gmail.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Remove the spin lock protection along with some functions adjusted.

Now cached_prod is fully converted to atomic, which improves the
performance by around 5% over different platforms.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 21 ++++-----------------
 net/xdp/xsk_buff_pool.c     |  1 -
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 92a2358c6ce3..0b1abdb99c9e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -90,11 +90,6 @@ struct xsk_buff_pool {
 	 * destructor callback.
 	 */
 	spinlock_t cq_prod_lock;
-	/* Mutual exclusion of the completion ring in the SKB mode.
-	 * Protect: when sockets share a single cq when the same netdev
-	 * and queue id is shared.
-	 */
-	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b63409b1422e..ae8a92c168b8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -546,17 +546,6 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
-{
-	int ret;
-
-	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xsk_cq_cached_prod_reserve(pool->cq);
-	spin_unlock(&pool->cq_cached_prod_lock);
-
-	return ret;
-}
-
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 				      struct sk_buff *skb)
 {
@@ -585,11 +574,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
-static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_cached_prod_cancel(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
 	atomic_sub(n, &pool->cq->cached_prod_atomic);
-	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -643,7 +630,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, num_descs);
+	xsk_cq_cached_prod_cancel(xs->pool, num_descs);
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -860,7 +847,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-		xsk_cq_cancel_locked(xs->pool, 1);
+		xsk_cq_cached_prod_cancel(xs->pool, 1);
 	}
 
 	return ERR_PTR(err);
@@ -898,7 +885,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
+		err = xsk_cq_cached_prod_reserve(xs->pool->cq);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..9539f121b290 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,6 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


