Return-Path: <netdev+bounces-239394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BDC67D7E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6EBA4F1441
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E92FB966;
	Tue, 18 Nov 2025 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3xDL1SL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C822FB0B1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449631; cv=none; b=jQ9Mt7kxBts9K5qFSSDImtvwHfzYfp5dHv4cZ3MCYjDZjJenRp+4RzkQL/XmrW+WU7uw0tenF373LnRt2ESmAn8noffYItpwsaF2/SsdYVXbUUvAeFC0B/zhMCI517WW0eNUtpL18DaOLBYXi8URUmvt2zc5ykvBzIkcao0nZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449631; c=relaxed/simple;
	bh=6weB9aHe65jBlGKdtfiZgtwSJ8azAGKpP5WFxbjSTZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkjpjDmYrCyZoRWc1CghzutSqDL0pSqobsaS8x60XdHPtQ+OdsnnsmDAzaV+rQCIXfYo2/CdGUctkC3ir2YPNvnjZwdH88WuhOgKJh+Hg7BkdcLDMSJpzUgXkv5wndtxiKFoKNPVHrnjcy1nCtqLaBJ/24raci5MiaBID5wCbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3xDL1SL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso7415601a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449629; x=1764054429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0LPZtU7RvgJepCeFQJuUiwu9eeUPZS9eny8TQyB8Io=;
        b=G3xDL1SLPb4Ybxr7p7k8CYBU2byYadc7EYUnCXWDqEJd/QIDhHTyxLuideS/nIURRw
         qA7KZquHvhJMAex+qtYLjbKiYvTLaWDDto/4Kiaz8IQpAy/9TksFBusRnInk69X7KCMf
         WWv9lfAkwO/bAmoky3vdmdWXfS4SwqfLtT9B/kq3EjzhZWCN1zvLbeZg3nZA0Q5nNOFf
         M7KyW660rPw77h42FxruvzPvkA5rI8kmOLW0HprQGuG+fI7jZmOn1/B1UQHWsjh1kIzM
         WhKyLi3bh/3NLpm8IKN9lknDjnVExkT26vZCkgxyUy3vKdPCSN0R1Z+hGZXG+0K5LWL+
         w/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449629; x=1764054429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0LPZtU7RvgJepCeFQJuUiwu9eeUPZS9eny8TQyB8Io=;
        b=Topseo/y+Dp6coKmzBJExDD9AJGSZdWL7rWaYfwrqYeyTtsOPC1tICj/vBGJV1jIDA
         9HJSFwMHaJTsQB4wMZ8VJLB1VpQAA7gGJLyCea9fgpIruhZxfQXLMH/EplDCfMczAvbU
         fIIhZ77QR+V9eVWTwFL3KaXhsLlj28tlybAZiKfGJvjLU4RwQAwzb4g6dLPL8kHbjKZK
         PXWuJnYdLP/Pkz03ckcb6CRNCIejtcPdKepbif5srqs5WMxp5+E9GDHSMIKEnG6D5wp2
         OvaTcY8NZxvXghWx0DebaPckUnFdvXsxUcCs2ZBweMMM1k1BvVImriQLbsRhJGukzc9u
         Rftw==
X-Gm-Message-State: AOJu0YyX/HOM9DvV1NS3nf+lAXiZAuKsfHUPkOMyBcXHHELxf+Lo3rYZ
	64Trxk1ee0Hir8hDOYSjdwrEYZgs41sQO4Dk49KfngqvK5kuTUhdbz0kzrbSAU0T
X-Gm-Gg: ASbGncssBGwqM4WAt6A61Wlo2GQ0FGv/Bmv6v5tzSuy0GaDXXVdrZsmDtBp8kVU9mne
	cov7/8HZh4c1qbvnduiSKBL9SXn6JMTfTHSdKfCGMMmAtkZtSeDFm8c9dPpHm+ihFnE7J/T6/ck
	Ae48klMMUwAysNMWKc9rlYD0fJcaY9Vax3CmOJ7wldfvIp8yLeo+GTuZYO1AU/ltbGg3khM5rtw
	ZMhi1eqFh7S9t7lpe7aubbV9x5wxz4xfN1eXc5ZZvNrNbC9R3LX+9Xa3HDAROFOqty2wZUA85S7
	9sMLY0YHf7SBfAHpCnCLmhPAJJQywg5OhxtiXr0EFLA7/EQcsH2k17vkNGcLs9RsdKMoEwKJuT3
	UsZty0t/JZNJX7y9MZmGqobTzH1p7s+povK2NdOQVedj/L8xibu1KkkioyXP1/d2Ei4rb9fyjCg
	3bkYDtcaSHQlW+gH+mFXdIZJOSj4P7avJ4o/KQC6zvuPjFye+g3ugfzz+7Iw==
X-Google-Smtp-Source: AGHT+IFjvrR9NWJ0ET76jkSe2dYBBOUrO0B1pgK6aHxa//cB2I4Ols4pyaslI1/Guedp8Ur2fKHmcQ==
X-Received: by 2002:a17:90b:4c85:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-343fa73b681mr18306503a91.24.1763449629357;
        Mon, 17 Nov 2025 23:07:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm11868494a91.2.2025.11.17.23.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:07:08 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/4] net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
Date: Tue, 18 Nov 2025 15:06:45 +0800
Message-Id: <20251118070646.61344-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Replace NAPI_SKB_CACHE_HALF with NAPI_SKB_CACHE_FREE
- Only free 32 skbs in napi_skb_cache_put()

Since the first patch adjusting NAPI_SKB_CACHE_SIZE to 128, the number
of packets to be freed in the softirq was increased from 32 to 64.
Considering a subsequent net_rx_action() calling napi_poll() a few
times can easily consume the 64 available slots and we can afford
keeping a higher value of sk_buffs in per-cpu storage, decrease
NAPI_SKB_CACHE_FREE to 32 like before. So now the logic is 1) keeping
96 skbs, 2) freeing 32 skbs at one time.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b6fe7ab85c4a..d81ac78c32ff 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -225,7 +225,7 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 
 #define NAPI_SKB_CACHE_SIZE	128
 #define NAPI_SKB_CACHE_BULK	32
-#define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
+#define NAPI_SKB_CACHE_FREE	32
 
 struct napi_alloc_cache {
 	local_lock_t bh_lock;
@@ -1445,7 +1445,6 @@ void __consume_stateless_skb(struct sk_buff *skb)
 static void napi_skb_cache_put(struct sk_buff *skb)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
-	u32 i;
 
 	if (!kasan_mempool_poison_object(skb))
 		return;
@@ -1454,13 +1453,16 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	nc->skb_cache[nc->skb_count++] = skb;
 
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
-		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
+		u32 i, remaining = NAPI_SKB_CACHE_SIZE - NAPI_SKB_CACHE_FREE;
+
+		for (i = remaining; i < NAPI_SKB_CACHE_SIZE; i++)
 			kasan_mempool_unpoison_object(nc->skb_cache[i],
 						skbuff_cache_size);
 
-		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
-				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
-		nc->skb_count = NAPI_SKB_CACHE_HALF;
+		kmem_cache_free_bulk(net_hotdata.skbuff_cache,
+				     NAPI_SKB_CACHE_FREE,
+				     nc->skb_cache + remaining);
+		nc->skb_count = remaining;
 	}
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 }
-- 
2.41.3


