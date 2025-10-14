Return-Path: <netdev+bounces-229158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D155BD8B0F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F883A862E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AA2F1FDF;
	Tue, 14 Oct 2025 10:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F92E54A8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436675; cv=none; b=jPhyZ4RfSzWuUIHRSUk/HyeZ2o0AL30Lr8o2Bl6gTVn1Ytk7ejPQH1Tewxz7nrP9SAuHJ87E4K13rGuIyTgVqRN7qlpJE0VYHOVUGlgNFL14kP8T2XzR10Hs4ZVqnAkRmvHX/RFRhQSu1T96hyOVkGV+JgwFTumPdiSTduy4pV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436675; c=relaxed/simple;
	bh=diJOq20R167i4F7BbQcP+KUQPlmtwyEeVhCpAACAcPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=th26gQ3v9hc18Cp1FOBAAZeXy8RkShZIQA4OcZ3mZY2wZIxoDSqcwauFD9KkXw7PmAjROyUaY6/8Jg7hHfNfrtWHHxqTWyAF9iCek2fmLV3SiwMq+n1ZIxq/9MPlXQCP0dwXjnJMrstbM8g4FF8a0H1uXxxdq8AlNaiEiRFDkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1085005466b.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436672; x=1761041472;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqlD9/jxWx+SqyVejHbNGdrLmCnbltXLXPbTGXfqaRs=;
        b=eAsfcXyDWC52kTZgJ1AJDHFYDLHhT6pPufq2BAAaTnqwZXgLivN9ZtV7Na07R6GZE4
         Xt1SUAZOJ7yUJMMlIXLYxd/4U+/Je5cCw3t56qcc2m0RfWhaaoU9FOqtsrMfTQNfK1uh
         HR59+mYEw/M7o+yfxCpybOQeYvcHixd1mrlpSRcXfflGveC1Crc6+vjERpiVTViTt95g
         pU+odbx09hAXXAtByf1EoxMBk39ArKGQm1Jt+UHAJXG+slFZIZ1rHRBgrWVo+D3Gt94r
         yfbnrztqPIvqTmNpzYEXOdHFbS5TO4Kma87R8BYLrr6CRAAyI58+wTnZ4tDY3+cSCWxO
         qhQQ==
X-Gm-Message-State: AOJu0Yx9n938IiVhnaGdY7pTb3F6trUf+Xx4Ksr6UBD7rXemWbtFfrdW
	IRllK3zISjc/RlGoxDqaIocrGyRu6WgpBrI5waAEBlXzQzXtNPMa5+H+
X-Gm-Gg: ASbGnctEyMaqYT5rtVLCF7ntPPxJV0wVJ3I9h0F6kuKLDSwtJwUDlnvBd8O4GffPKf5
	bAi4B4uxJ2UzJqxGqFRyT0btCPv8/v23nkesieJ+Ud96xPpqHrLJ10fuXmJeRalBwpT4W+4cyHJ
	MN7+KkQ3W4cEzMyAW/SE0Za8rGz9+Z9lvHlbF92wUaEe8cP8hxezyZzj1SRIR81Q3MNNihWY2w+
	08cdioKv4GPf4M7CIanMKuCgSoIvswUGrdQvOYjCGF9IT/mE0gAIlZrWVuU7YuXj78+/KxqwaKP
	hDK7aBG2ERtvau/pa9Bt1u0fJgoNBjcri1/VXirD4YaK5YkTz4CfbssQVvPud3Tu7VIW2JuCJQv
	NAuORYw81jAvQVMruQ8HqPJOn+ZvK1f7HFaxcJ37OGzG+IEQ=
X-Google-Smtp-Source: AGHT+IEwipovpqBK93TMYmLFdHdsp5nUq5tfJlCe61SggYjQfLXN+qxeGeAXS3mptg07SPANLwU9xA==
X-Received: by 2002:a17:907:3d8f:b0:b04:2ee1:8e2 with SMTP id a640c23a62f3a-b50abfd6d7bmr2772743866b.36.1760436671790;
        Tue, 14 Oct 2025 03:11:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900e52fsm1091637966b.69.2025.10.14.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:11:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 14 Oct 2025 03:10:51 -0700
Subject: [PATCH net v2] netpoll: Fix deadlock in memory allocation under
 spinlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org>
X-B4-Tracking: v=1; b=H4sIAKoh7mgC/3XNQQqDMBBG4auEf21KJlZoXPUeRSTViQ5IUhIRi
 3j3gvuuH3zvQOEsXNCqA5k3KZIiWmUrhWH2cWItI1oFa2xDhmodZO8jr5+0LL33enCO/NAES/U
 DlcInc5D9Al+IvKKrFGYpa8rfa7LRlf55G2nS7u7JOArOBvMc+S0+3lKe0J3n+QPsafDvsgAAA
 A==
X-Change-ID: 20251013-fix_netpoll_aa-c991ac5f2138
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 usamaarif642@gmail.com, riel@surriel.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=leitao@debian.org;
 h=from:subject:message-id; bh=diJOq20R167i4F7BbQcP+KUQPlmtwyEeVhCpAACAcPg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7iG+e+KvlPELHSh3pE1LAOo9iBeEMaBEvy9Sy
 qdf0lFVaL2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaO4hvgAKCRA1o5Of/Hh3
 ba/hD/92wVFdGWwzjFmmcYXZPTFg0jTqu6d5M5Xb5FmrSxKsSHN9Tv0M32R5u3+M/kHqTKxrKBu
 FBCg78DOayY2+JrCogaKvvL0H+yqifwxpxuW787x5nlPyDyB/12CWLZSJr3aktrj8bT5CoqqHOx
 TS0qLwGaQz0DyPhwA3xMq3flHZSY487EWowdaqrZhyVFKD5T2qPbbfrUkTGfpphpMtxwNfgLcmh
 cqfX1EzpMzm4GZ9meLmlUAqr5fYHQlst+W0Avc9oDC3aKIAZBd+VJJIdamCrdku0vRa4gzWoPCP
 A4OFBkg0LjxL/P2/mR3RIA8hrzvseZBy1Bpw7C5IiXaBbj0um2EmXG95dsbXKtZGFXx7UkDSGAn
 jRsSVVuc1Jx7PmUqvnKkGRH9Tml1XwRGMUZpZ7CVU4B2wHkXl5jJsb9ediwkWguXUAAZxNVrPFo
 n61Mvcuj7ue2sL1NuTEEgBZBfmVSHUyUTa5Rgf1jxU7sQUlTrarWLL+LxzSjPgwJai/kEnJfPJv
 HdyfDNCbhZkqx/g9qLm8X89q+vpJJB4+wvalIjC9p45wb1Dkd41ZoCWN1Us/8U9zV/t6tFQ+vo+
 dO0TLZXZMMo5NK0PcjqXdkLInE4EXJeX3FE4gaymh/wLvUb6LpyTCBBbevNBMrYo09jeOtwIkxF
 xCmFaPWdBfarQ9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a AA deadlock in refill_skbs() where memory allocation while holding
skb_pool->lock can trigger a recursive lock acquisition attempt.

The deadlock scenario occurs when the system is under severe memory
pressure:

1. refill_skbs() acquires skb_pool->lock (spinlock)
2. alloc_skb() is called while holding the lock
3. Memory allocator fails and calls slab_out_of_memory()
4. This triggers printk() for the OOM warning
5. The console output path calls netpoll_send_udp()
6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
7. Deadlock: the lock is already held by the same CPU

Call stack:
  refill_skbs()
    spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
    __alloc_skb()
      kmem_cache_alloc_node_noprof()
        slab_out_of_memory()
          printk()
            console_flush_all()
              netpoll_send_udp()
                skb_dequeue()
                  spin_lock_irqsave(&skb_pool->lock)     <- deadlock attempt

This bug was exposed by commit 248f6571fd4c51 ("netpoll: Optimize skb
refilling on critical path") which removed refill_skbs() from the
critical path (where nested printk was being deferred), letting nested
printk being calld form inside refill_skbs()

Refactor refill_skbs() to never allocate memory while holding
the spinlock.

Another possible solution to fix this problem is protecting the
refill_skbs() from nested printks, basically calling
printk_deferred_{enter,exit}() in refill_skbs(), then, any nested
pr_warn() would be deferred.

I prefer tthis approach, given I _think_ it might be a good idea to move
the alloc_skb() from GFP_ATOMIC to GFP_KERNEL in the future, so, having
the alloc_skb() outside of the lock will be necessary step.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 248f6571fd4c51 ("netpoll: Optimize skb refilling on critical path")
---
Changes in v2:
- Added a return after the successful path (Rik van Riel)
- Changed the Fixes tag to point to the commit that exposed the problem.
- Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
---
 net/core/netpoll.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..c19dada9283ce 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -232,14 +232,28 @@ static void refill_skbs(struct netpoll *np)
 
 	skb_pool = &np->skb_pool;
 
-	spin_lock_irqsave(&skb_pool->lock, flags);
-	while (skb_pool->qlen < MAX_SKBS) {
+	while (1) {
+		spin_lock_irqsave(&skb_pool->lock, flags);
+		if (skb_pool->qlen >= MAX_SKBS)
+			goto unlock;
+		spin_unlock_irqrestore(&skb_pool->lock, flags);
+
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
-			break;
+			return;
 
+		spin_lock_irqsave(&skb_pool->lock, flags);
+		if (skb_pool->qlen >= MAX_SKBS)
+			/* Discard if len got increased (TOCTOU) */
+			goto discard;
 		__skb_queue_tail(skb_pool, skb);
+		spin_unlock_irqrestore(&skb_pool->lock, flags);
 	}
+
+	return;
+discard:
+	dev_kfree_skb_any(skb);
+unlock:
 	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 

---
base-commit: c5705a2a4aa35350e504b72a94b5c71c3754833c
change-id: 20251013-fix_netpoll_aa-c991ac5f2138

Best regards,
--  
Breno Leitao <leitao@debian.org>


