Return-Path: <netdev+bounces-241459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56BC8415B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9501034D986
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A412FF179;
	Tue, 25 Nov 2025 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myp8+WwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FB2FE577
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060889; cv=none; b=dcxuZoyWG+LMa8le+J13NhWzN1q4MACyOI2AdlVtTiuU0zvS1cD3E4npjaYCvhjm3HrmST+w+bw3VCv1/mcC3R7sGyYJRh8nYnMHrRTB0eE1xT0OqjxeWeGwTUM5xbBJ9ZhiWaU2QJJnC/csVc5CjAknabBQR7iaVN16/2L6omw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060889; c=relaxed/simple;
	bh=7r2vnDBIkkBwynyhJVl8E7Woyk3ZesWca1pcrig45L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUX4raWhj6aPEzwbDrEUA7c9ZAEZb62cciGUPZ1lbxzw1l/eNOkCmt1Bjxb7v2C9MsiJPcwz2wJv/+SW2ic9xURrTfpuLcrMNg1Q2LHvDkBHrKYFt30KzSY84RjPEUFI9yGFOzBmxSj2eCq357fYrx3J9qqQKDYPjw6+VUZluTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myp8+WwI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso3233903b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060887; x=1764665687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCIqp7SX36crJHGdmwUuTq8EN9SoCdE7McdfFq6/BQY=;
        b=myp8+WwI7qJfvr5TYPSY3xP61qgFMXyvJYliRa1QmJ/fqtehM/nrqWXiiZPBIkUU5G
         WsLsSPeCzBnyIQgkZBJhYCX0mZFRLckh7auovUu7qv5mehJER1k0LlesNdpLXPwfWPMI
         LTm21sW34l8l1PwCLRdvfZp328f34JdzF4SCWGhQxmCtTQhN2vv7oXMWHcMpQ40xraDx
         8NmMG8actilQdF271W2rIvcL/ciqMQrxipq6SORc1iRHYArF18XHihVlTJfnr6Ln58xR
         f9u0DvRkDMbraNKuDMZtt3f1u33wPFvDgMraRrLZS8rOQ2un4kNBNDri2K0Rlko0nSXp
         eBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060887; x=1764665687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCIqp7SX36crJHGdmwUuTq8EN9SoCdE7McdfFq6/BQY=;
        b=KToTvz96L0Amqi4OJ8+ZSPJLghNWblU5tPX0+RZBXfjW7G9KrlXDfzzzC0BFQVxcEk
         ExHmTNeIgp6K/emrK/4q8uOU3yGjPI2qpt2pwWHx7bQvD3u7t0Z//JDbz98ZOnYIknPM
         eFLf8wLW0IFb8RVi7mC+5yS+hKgCmhF6h1z2Jy0LV3oXJOfzldVC+OsZ6ImHcyAgza8f
         PAkLDZCU0EoN9FLMIyG/BPU3e+Ym7tPEgBk0H9mpjEc/hIveVgjHuVHXp5sAkQ2FxvP4
         bezw2GaVhNs/oTz/UEE4zGjFLiNv46U2mvwlSeJHpqxT8sFpaOrZjpZNoBQqejENotXu
         ejaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5NhBagVuhHo/uR2o9eHjtY6FMlk3z4XPueMwWNx68JamGOVfZGE5xdqwIIS3BlQjQi8Jyk4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxafI8erfmFaiHpt0EJhieZ1SJeL8lFxR1UFG1xE1rg5iA66fc4
	Uar2oS8l0/nRSbIup4GUlQffCZV2fmAlLfZTRriec6wkbO9tNsTyyiyXRdDd4b8O
X-Gm-Gg: ASbGncuHJkkI9SpDnXIN5Hz5xE/cuQlv2Y9hKvgnZ6zO7c/0MNkS4gOdrGoLdFNEDto
	m/ut0Cex2Nrf/fyrKZpEblij1PJJijkeRKqVobztoP/0ua9KxHuQr6LulG06/ON44hOCzqZhs1G
	41U20mbi+Zxx6FcYpcEtFgg6i5pfyFFK/yg2spckN8Z2NtNBvdW0NSvM9ot1SKJjJop5A9PoQqZ
	DZw2b8WTrgcZvVax20X8ZBMDZi1B0frYYg/hQPFD04ovdkAAx6iF3/9KzeIMJj2+iJhVeVCRdVz
	M09r4O/swYlxU98fXwdEr4PR+i4krvcqxthrd4R1PDO52svCHXNNkH3caVE1NJ3hmtv6v18Hm9r
	3yLVXOeMAs/zWVClQXbxvCRl714aEwITvKYhKZG+P1IX3VQyAxfKRv3kWIHEcmrAfxA+w2z2A7k
	Ma/keS5u2VwWZ1kiiwRgaNWWTda3a39BFKXC9NFBG8UjHQXsISLC94r1UK+A==
X-Google-Smtp-Source: AGHT+IF0vZUezvoRwEu7z8bigdxCsrdTmmT40+B5Zp7BWH1xxqSqOpVRTU5O6mv5PhUol9AiofLqFg==
X-Received: by 2002:a05:6a21:6d9d:b0:351:cf08:93de with SMTP id adf61e73a8af0-3613e5ab9a9mr20372187637.26.1764060886888;
        Tue, 25 Nov 2025 00:54:46 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe6dsm15192263a12.34.2025.11.25.00.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:54:46 -0800 (PST)
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
Subject: [PATCH net-next v2 2/3] xsk: use atomic operations around cached_prod for copy mode
Date: Tue, 25 Nov 2025 16:54:30 +0800
Message-Id: <20251125085431.4039-3-kerneljasonxing@gmail.com>
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

Use some exclusive functions for cached_prod in generic path instead
of extending unified functions to avoid affecting zerocopy feature.

Use atomic operations.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       |  4 ++--
 net/xdp/xsk_queue.h | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index bcfd400e9cf8..b63409b1422e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -551,7 +551,7 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xsk_cq_cached_prod_reserve(pool->cq);
 	spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
@@ -588,7 +588,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n);
+	atomic_sub(n, &pool->cq->cached_prod_atomic);
 	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 44cc01555c0b..3a023791b273 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 	q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
 {
-	if (xskq_prod_is_full(q))
+	u32 cached_prod = atomic_read(&q->cached_prod_atomic);
+	u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
+
+	if (free_entries)
+		return true;
+
+	/* Refresh the local tail pointer */
+	q->cached_cons = READ_ONCE(q->ring->consumer);
+	free_entries = q->nentries - (cached_prod - q->cached_cons);
+
+	return free_entries ? true : false;
+}
+
+static inline int xsk_cq_cached_prod_reserve(struct xsk_queue *q)
+{
+	if (!xsk_cq_cached_prod_nb_free(q))
 		return -ENOSPC;
 
 	/* A, matches D */
-	q->cached_prod++;
+	atomic_inc(&q->cached_prod_atomic);
 	return 0;
 }
 
-- 
2.41.3


