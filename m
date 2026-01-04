Return-Path: <netdev+bounces-246700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB2CF0792
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 02:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 457363005F08
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683714F9D6;
	Sun,  4 Jan 2026 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9RkOXPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964A18C332
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489704; cv=none; b=XfTjsCSNtaHHLNb4eW33wdj2Ikx7mCgBFrBdIjINyzXZHa2+fnt0xfNpWBXFjlaaHzZCkdHIx8XzDtptXnZSsniGt+urmhfaulWabrrNTN/KrZ41SdxBwPzertwo+k9RyUhGtCCdrX4fJGaQ7a0ao3F7l0drVQKRQSS0SSUvlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489704; c=relaxed/simple;
	bh=8wGPoBC17Pvs5ona0WtPiKM0dyyrKxFlOWQ78mY4B7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3ohbvl3BE2UYVh6v5AmxNCbcUU5LSTyHIBcw7sKVKGWqmoEqEQJnfzD3tUe3cvT2UrT4QkjVzr1+re9TBoze+h4k6hNIeOk6QF3L9GrcrrhUDN3x54LJ1hzwnw57grmj93IpKC9bXd3LiHComN7CQL7taUieFf2FUEV5kfHD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9RkOXPR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab7623f42so14259736b3a.2
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 17:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767489702; x=1768094502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8Jkr4gptnr43lfvojhWFIhKYNObRq5vr1EGbHYpgkk=;
        b=b9RkOXPRO8wrd9C77jg/izJy8zMAe/Po8tQedjzNrrwnCz95np5s4gxbY8P3BuL+87
         NWRCLdM29ThSC8mzym2G8zA8xAZadibTwwiI955oVyiRbW8gqliCvLtJ3LAiLpcU48GW
         b/lRz/C3RpIM3xMHMOiLp1TnNUoBofIuzV26mWDBIhVHh+QgkOF4gabOmgSfpt3MoAkn
         uLSo4zFYEzbNAowoXbqtqov/jDHog8rg7n5O+oF6uoWv+h+imfORBy1BeiicPFKUOI+A
         2ovMmLOkXpfvngKTUfXVLKro+LR2+HWbiSRkyN4BZESJKHA1qfF0UCwTqvR02K0IFQJJ
         6q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489702; x=1768094502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8Jkr4gptnr43lfvojhWFIhKYNObRq5vr1EGbHYpgkk=;
        b=gfC0Red5UWNObI7HBEfxzwhGKmH3rFmblRdFZJt+PEl+WLkth6ArN8nZ8owh3se3zF
         lBY+vjZ54Uu1FsVzQw6rlOnvwzrtBFj4nyrzIbPjO2dODJYkbUAC+iL3VQrHHi8uwSJ3
         CmprKqNzt5pfCwTG87dkIzAGDlMIZMU8nTF0Xvt4sAzhtk6eChLdDn12Pf/sXjPbmDAv
         Cp1+wFf+mxk1TnCAVbwlyoCdPF6afZs2ia4DmMkXrXln4tvaSkAVvojwuCaLcoCwKCQj
         6kJ5eyp2L2EJ9NNRgnM+UBvJxb/kyBKpYi4Hik1ID0ivQYIbsAWEfvj/rYV4tUUF8VU6
         ECLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMjt5Y3C6VRGhdlRdAfX07OLxLxaAqWsz8a1uj2rWGLWLwVOA/yKAU4jk2qB6wqjUSa+teOtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2agPj2CiPXfr6l2fZKyL541suM2ftBI1JGB1FIH4p8NTe1Dx
	DCs6hmHU+6KMzNlgUYrc5LdTLbHk2rip0glvLm3JSsnjtFV9ghLQ39tB
X-Gm-Gg: AY/fxX64O+3sjIDwXuj3WKAU0BmZokeKiNh5V00F4yLQzODAG2xl8tN7R9pZS/vuFVY
	4zPk2zqx2rLRyX/x04G4Nl2dqso0lJAnIkZKxwI9gaxHO5YWvd2ZVEc+VMIXyx/i7rQbJjAbUpZ
	wlRc5afTiWr/w3I6R6QzQdRjN1uQoBLCLzphPxEVrXKZNfJrw3WB7aaRkkJcvxBgqxVhqTV0/DT
	h/+BgzYv9piJG2Slz9FwI55vNZyqx35jB4MudwFVkZ3JLQD14nB0slrRzjWaL0Ru04McD0mUpde
	24OLljBG0sBPJzNR/VlYT1n+Mt1Vhdwpc3GwrJn/qJEoFOjRkdDLc3jZb9thP8Lk9XfDDsatBJt
	sWh4eqXPOewwUJLWM6ebPsNneOWYaf80PC+wjtB5zAU5gUFi5ffF5yC9VjSrR15DBoSma0214SH
	pGAK3mIaa0nsm3y1uUBePKcL+indIUyackGFm/CR10yQvvvLKk2UEzFclVrDJ7QCisEoBe
X-Google-Smtp-Source: AGHT+IHXcLCj2DQh05sklNFFdl2iZXimH8QCanQzksf/yniKVaRnmrNAw6RARmyMQhoJeX4PlW/qWg==
X-Received: by 2002:a05:6a00:6510:b0:7ff:c1c7:4559 with SMTP id d2e1a72fcca58-7ffc1c74644mr26973094b3a.5.1767489701800;
        Sat, 03 Jan 2026 17:21:41 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm44484500b3a.51.2026.01.03.17.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 17:21:41 -0800 (PST)
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
Subject: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path
Date: Sun,  4 Jan 2026 09:21:25 +0800
Message-Id: <20260104012125.44003-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We (Paolo and I) noticed that in the sending path touching an extra
cacheline due to cq_cached_prod_lock will impact the performance. After
moving the lock from struct xsk_buff_pool to struct xsk_queue, the
performance is increased by ~5% which can be observed by xdpsock.

An alternative approach [1] can be using atomic_try_cmpxchg() to have the
same effect. But unfortunately I don't have evident performance numbers to
prove the atomic approach is better than the current patch. The advantage
is to save the contention time among multiple xsks sharing the same pool
while the disadvantage is losing good maintenance. The full discussion can
be found at the following link.

[1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 5 -----
 net/xdp/xsk.c               | 8 ++++----
 net/xdp/xsk_buff_pool.c     | 2 +-
 net/xdp/xsk_queue.h         | 5 +++++
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index 3c52fafae47c..3b46bc635c43 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -543,9 +543,9 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	int ret;
 
-	spin_lock(&pool->cq_cached_prod_lock);
+	spin_lock(&pool->cq->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	spin_unlock(&pool->cq->cq_cached_prod_lock);
 
 	return ret;
 }
@@ -619,9 +619,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
+	spin_lock(&pool->cq->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	spin_unlock(&pool->cq->cq_cached_prod_lock);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 6bf84316e2ad..cd5125b6af53 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
+	spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..ec08d9c102b1 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -46,6 +46,11 @@ struct xsk_queue {
 	u64 invalid_descs;
 	u64 queue_empty_descs;
 	size_t ring_vmalloc_size;
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: when sockets share a single cq when the same netdev
+	 * and queue id is shared.
+	 */
+	spinlock_t cq_cached_prod_lock;
 };
 
 struct parsed_desc {
-- 
2.41.3


