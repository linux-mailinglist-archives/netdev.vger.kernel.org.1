Return-Path: <netdev+bounces-235182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D4C2D319
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A891885C29
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B13191D1;
	Mon,  3 Nov 2025 16:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789D318155
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187910; cv=none; b=VVbndZTX8LPJlnuNm9DkhB9MLn93Fy9IkMjeUtEAGRr4o7WqjUIti0UWi7hfilEKBVLAHlZs6AkMD6I0WbEMKBqhHW/O1jKmWUsIZtT3dg2EJS/RPrNTCDc+4B7NQxHB8RJV/CNXTJi3s/Vu4vFd0owmwyffKR+qB9vKrjcS4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187910; c=relaxed/simple;
	bh=jQxnQvvfIs8diKVpsvOtCguMqOc2ncO9ok1BzECWTVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQKPWV3w/6g1jSjkJaAAHCkwaJQpxoFLlezx1SppOn2BL8a7V/M4QJ/fyD6zwG7m4mc6mLAeILrjPHaZXyljOWguc6M15fs8C2iocSKAnAFEVBZEGNi1/mKqv7Lt+7BCLWem2ArEMydKtRR+OTdbpaXqDbxnzzGvhGLc5g1ZSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d3effe106so711177966b.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187907; x=1762792707;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7ZE2RZuk+QsoWq/PXTky4rmmK0ONSAxL4QKqYmmxhw=;
        b=JuApAdv6hWlrqunsWR2DJfU7mwPrDyvBPXaJeyBomJdOGtgzUknR4+3rSMoJMoNgMD
         9bqfjyJzRcEsdK87taIDzHF77hcBSJxE/IbMxbHTBqN9Q3nObgNlpUn+Tc0WMFS6Jr0V
         XDNyefFpi778RdxKJNQjbxgKTnQ52sDXslVI02fZx9/yr0kwqIqtOlqbdLSx8dy2lR2y
         RxQj2IEq9NDYhFs2dFKChBh1Ha+V4oUanqc0iLT3kgSYG0WsoG5fcIknHfanDlbQyyMl
         C4nVWPA7V+MGaJcBV8fSXcZ6DcpTFi52wIPGjSwl3hWrJxo9K//ajU6RP4FEE/LvhxB1
         zk8w==
X-Gm-Message-State: AOJu0Yx7GOLRktPHQulKTI3xvI59gg1vLLGhAtoHvAwRdCmWLxEoDSeA
	saVSqkhFjwqpN9Dgc5Z8KX+9gwWeBeDE41XtzZIQgjdx7+dZGBgxfaaW
X-Gm-Gg: ASbGncsBQPvL5BmzbPc17dtjOqNvRkbvHNbQ729cQSoZfmoo2+ODpljbqFVKpe1HVVc
	LG5Cccn4WlQY3fdx5cZhzJ13s6v9mt4MaTB5FnGm4ERVZfiYX1UiQt05kj8OpkuEFyf1fnePWIv
	8/vPn+bl3y5dKGeKRm9tJwDGsEDx4jfedzOCw+2CrbfP6+XejLVuFDG/itOV3YYVPFZ54Z8b9yg
	j1ozO0YMzidgR8ibgxugQxa2JaIxkA5mkVXXhN+BrTEabTiOGVqtNDVT3ZtvEMqqCCWgEU6k/qN
	OJRfk42xNZJJe1LGndu4Pe283njDHOB0c1tCJdrBX33KVZnKn/drPasVYEVaDbNL69z6cuFxJes
	fqht+jMPytVBHo45NVcxPlhLJwoN2ZoNbg9XFrXqxAIYHIBSQD5y7eyLBuSDFKmOAv64=
X-Google-Smtp-Source: AGHT+IFFvIAn6+SkOd/+GZHr0dX4sWqgBNPdSfMNhxSZu76IRg9zE+m2ruLr+NbFONr3SWlQs2KsBw==
X-Received: by 2002:a17:906:ad0:b0:b70:a982:ad71 with SMTP id a640c23a62f3a-b70a982f501mr424027366b.33.1762187907048;
        Mon, 03 Nov 2025 08:38:27 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779cff1bsm1130772866b.27.2025.11.03.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:38:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 03 Nov 2025 08:38:17 -0800
Subject: [PATCH net v4] netpoll: Fix deadlock in memory allocation under
 spinlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fix_netpoll_aa-v4-1-4cfecdf6da7c@debian.org>
X-B4-Tracking: v=1; b=H4sIAHnaCGkC/33NQQrCMBCF4auEWXekM4mt6cp7iMjYTjQgaUlLU
 aR3F7pSRNeP739PGDVHHaExT8g6xzH2CRrjCgPtVdJFMXbQGOCSt1SSxRDvp6TT0N9uJxFsvSd
 pt4HJ7qAwMGQN8b4GD5B0gmNh4BrHqc+P9WSmdfrVmwkJvRMqPQXPodx3eo6SNn2+rK2Z37378
 oyEnQSpxNa7yvkvb/97i4TnEGquK2bv9MMvy/ICpOYVtTIBAAA=
X-Change-ID: 20251013-fix_netpoll_aa-c991ac5f2138
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833; i=leitao@debian.org;
 h=from:subject:message-id; bh=jQxnQvvfIs8diKVpsvOtCguMqOc2ncO9ok1BzECWTVs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCNqBT+7U697xwo19qPvDJYY3rxW33lTI9aJxR
 zQIoSAWYS+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQjagQAKCRA1o5Of/Hh3
 bdimEACr0W+KzY/YWtHRiCJwm6dRHunbtCERQccR0GgKS2SQ1sYDtj2IJQ2DcOfaagTIhCBpy3N
 GEKy1bGEWQfjvUqYqApNLQFLBCT02RbLMxZovwLygf9iMstlX2PGHA4rmHAiackcVXJIz7JoWwU
 gIljKcCFzwsFWYcIsVV66t9hex+ZDpV2CqIkg4KACTaxbsbSq2IaYwwyrTgJnxSpxliB79g6zbp
 eppL1w2cJ/dFuQndYvlMDkElxtkUhJgWtDzGmUgm+CLHBbjtrVGE7KIN1JJxI29o5kWxL9Xfa01
 8sVxw432SpoZOPTpKb77wRWOVST2U6IUn1HMIpN6wx8TX/xCo5NXl2krpbmeW8XvVvWrCvn4EpH
 KJNH9EaTQw/jBQhG65NA4m7jFh2rSOEZyKG/CWZQ9oabryLyU5OagXBjJJy+vlzbSLmO/21fr3v
 WjUTAj32XnUIf7IdG5hxHDd8avKbRsDMi3n2ja6k6kC/yqsgTmLk8a4gPUVJcP/xFZGSZoc4YfT
 IcpAq3KeTexdFtAt4w2StaF7Wpf1Gg3XUsQdNtUPCyn77FdeLZ0AM2AQi2avYACQHWGa9iyMfMI
 S/zbDs/iWi3AAEX22KSq3RJFcNOMAwHM1uR/xNSpGvGhYEQppwvPVDjqMRdl73P0AC7gR+laPxd
 Py04GnP6a8eLSxg==
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
printk being called from inside refill_skbs()

Refactor refill_skbs() to never allocate memory while holding
the spinlock.

Another possible solution to fix this problem is protecting the
refill_skbs() from nested printks, basically calling
printk_deferred_{enter,exit}() in refill_skbs(), then, any nested
pr_warn() would be deferred.

I prefer this approach, given I _think_ it might be a good idea to move
the alloc_skb() from GFP_ATOMIC to GFP_KERNEL in the future, so, having
the alloc_skb() outside of the lock will be necessary step.

There is a possible TOCTOU issue when checking for the pool length, and
queueing the new allocated skb, but, this is not an issue, given that
an extra SKB in the pool is harmless and it will be eventually used.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 248f6571fd4c51 ("netpoll: Optimize skb refilling on critical path")
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v4:
- Check for the pool length using READ_ONCE() instead of the proper lock
  (Jakub)
- Remove the additional TOUTOC logic, given a possible extra SKB to the
  pool is harmless. (Jakub)
- Link to v3: https://lore.kernel.org/r/20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org

Changes in v3:
- Removed the "return" before the exit labels. (Simon)
- Link to v2: https://lore.kernel.org/r/20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org

Changes in v2:
- Added a return after the successful path (Rik van Riel)
- Changed the Fixes tag to point to the commit that exposed the problem.
- Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
---
 net/core/netpoll.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..c85f740065fc6 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -228,19 +228,16 @@ static void refill_skbs(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
-	unsigned long flags;
 
 	skb_pool = &np->skb_pool;
 
-	spin_lock_irqsave(&skb_pool->lock, flags);
-	while (skb_pool->qlen < MAX_SKBS) {
+	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
 			break;
 
-		__skb_queue_tail(skb_pool, skb);
+		skb_queue_tail(skb_pool, skb);
 	}
-	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
 static void zap_completion_queue(void)

---
base-commit: 51e5ad549c43b557c7da1e4d1a1dcf061b4a5f6c
change-id: 20251013-fix_netpoll_aa-c991ac5f2138

Best regards,
--  
Breno Leitao <leitao@debian.org>


