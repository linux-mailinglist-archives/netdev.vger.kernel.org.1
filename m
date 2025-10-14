Return-Path: <netdev+bounces-229321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B52BDAA56
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3CA3B476E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE630217F;
	Tue, 14 Oct 2025 16:38:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C2302170
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459880; cv=none; b=fXb3slGPNLsc0lHYMoAwLv5WzuGTxB2Zy9+StYItszgIf+egadnEzbTph+HBHm+fvvTYXMYY9PZxc4Z58hLiu8L3A0EF9B0mYPyCHl7lvp29ulUZhVrWN/LnD7G3tevKWmD8f3CL7+1cnd1hN3zqX/zb6ieJMq0Z0HY/2W7+2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459880; c=relaxed/simple;
	bh=VLUT/Zak0eJFYf+vUFDm3/H5tddGfkgbKqNazhAEeXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=snCfxMcHtrxU7kY7ckDa+xF5xmYKO/NqvmP+4MJEjn6qCyWyHm86iuiU5dcevy3hnKdDCeKPSBi4hzZ8+X813xBqQ3gvcFKQ+UgsZaghlAJFtUQyut18rZqA53IcSKlnmtEiZJV8Pb7K9urswQr+rXgTmwa/CcibEs13hFX1WmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1163253066b.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459877; x=1761064677;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai5NPPC9/Ym23tMWjtL6MGaZBmWhR6SmiCQ/AVWFTZU=;
        b=Mqdd0fn/lYujLpEg32Io6TH0pmPPn5mX7riQppIoVTScvjuLmu4bTBlHpBrg111vOR
         gtQ7D5rUMABnN1NOY8ChjLBPs0lcA/rb8ouH2l2kUM3uua4fo6q3XKGbietd/DrIALNR
         uv96ia+fvBTxyHxLDz/jgQKA3EFFoYuIisRhihgdZJmPxvfsPBzHDskmtVkgygnAQHeM
         EEXQ1mQdq+cy6pITzIpnsU3LyL0rd68ENlx1RJApwsxOk6TBSE0jD4cJy7sp4iAiQAQo
         uy5Earlqr8Rim0M+MN/cXjUXAOXVo4J6fyZXDrGeDa6mXDYf+XIjynQ3UAt80SFMZIys
         E1pA==
X-Gm-Message-State: AOJu0Yz7yx3vva4M3/yLklRuc/wJ8kNUJXDH1U9SRY+B/soiHk3uc/Ff
	Qe55yIE7FfKiUhex9C3sAoCUPXOYtqpkwwVupNOjIJ33tD8QPH5i9BgA
X-Gm-Gg: ASbGncuB6r4L3amzjOt7TUAma/P/kABOKm4eN15DXaJA3Lo5yXrJrm2eumpTeezTuUZ
	PXwcJbLvYWPQ+qRVufXEydL7o7ZUxKbAeuS3QGjvGO4ouMYXZBIAPm75/qr2vIdhHpClf0WYG57
	OOKK95LAIxKCexnedPzcJ3K/NPt0uzsPrnpN4W8HyqQexgm7a7/TzE+weSp91cKMBVxBdwvkdwP
	1wj5pHWcjFmroEkvcjbTgi14L0Rug+kbEiv8nb27XbtwuuSI+kn095gHg4yO/3U2xvSkcIxO0QW
	d2oXb4DUuG069sQuFeYy7Z9pIuroQd7Vo1IMq263fCCSfkbHbDTsGGcWNpkMbERTu9TnSb9rlVA
	mSZjU+Ix9hSFlIFzln4olkJkYBnvfuH3UrLoNIqb/85SY6Q==
X-Google-Smtp-Source: AGHT+IGVUFCwDLtPhH5nf+lMT3scB2H3LqwuriPoyZ+kO6kCdQVrCBK7TqX8nlkEh4Suo/ZrpDrKBw==
X-Received: by 2002:a17:907:9710:b0:b2e:34f1:9dbf with SMTP id a640c23a62f3a-b50aa48d314mr2561991666b.1.1760459876657;
        Tue, 14 Oct 2025 09:37:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm19114466b.60.2025.10.14.09.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:37:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 14 Oct 2025 09:37:50 -0700
Subject: [PATCH net v3] netpoll: Fix deadlock in memory allocation under
 spinlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
X-B4-Tracking: v=1; b=H4sIAF187mgC/3XNQQqDMBCF4auEWZviJGqNq96jFJlqogFJJJFgE
 e9eyKqldP34/ndA1MHqCB07IOhko/UOOiYLBsNMbtLcjtAxEKWosUTJjd17p7fVL0tPxAelkIb
 aCJQtFAzWoI3dc/AOTm/wKBjMNm4+vPJJwjz96yXkyFVFWCo0SpjyNuqnJXfxYcqtJD599eMFR
 z6SoYbktW0q9eXP83wDstv+K/IAAAA=
X-Change-ID: 20251013-fix_netpoll_aa-c991ac5f2138
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=leitao@debian.org;
 h=from:subject:message-id; bh=VLUT/Zak0eJFYf+vUFDm3/H5tddGfkgbKqNazhAEeXs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7nxjWOTmes0RLTrb3yCHXTiWykBWkMTGZe1O+
 PT5CpSh2UGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaO58YwAKCRA1o5Of/Hh3
 bTziD/9THjRII8cu0DNwZXxwmmKVtfYzEE+9127iVOUa1ULpEKPISd7a5QCmRFYDC+K42SHFQ4b
 /u52e8JRqPBBYtcnkpPPSwiwnUYPWA8DzhRsljpjgaOOMdU3SmnWpBkWsMIzbI2xNi9gKcAUQmH
 TywCU6m9md8dbkU31P4Yox+kqQwfywelwIUZ4jcImTEa7rUv6YwkP7ZEMdtEFyGn8vnUMr3eFnw
 CeGTxb5VvDvQIZ+EtyLnQgTR2COMmpqzQY7V5wfMSsDll4ebGzWmhkU+yznf4UykBK+OOsV9p5s
 wM7GcRv39fzDLxkmp84JVwBXKa5ROZJkir0PBkwMeR4hCn1B0/XcGkKjW6TffI3TnL5wcq064AF
 KCKlJn9k+kUqowN4NmIwysQNglpPEOe7knaPU0ucOEfOhpvNd0G83YnXrn9m/Ii8bGTr55dtOS1
 fGEvIYOBjcz45eUsfxxHk/cqUTmj4NNVSKs4FGxFxewPnmW3eJXOngc/EPzF52OWU5ywuocMH+k
 M/0yx3nhtnNYfrdu5lMeVODYW365qA5xvqlMcyP0AXc97SEcG3LjqloY5nPNhb9SK5+RKIZldMg
 TNli6U7nhnSkEEdWxIbDudfUOi2jj2Z8q80b5LJbk7U5qbjy1Wp5gNSqN9f7T6Esy1yXHcO7y8M
 0R7iNLmRkmCwilA==
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
Changes in v3:
- Removed the "return" before the exit labels. (Simon)
- Link to v2: https://lore.kernel.org/r/20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org

Changes in v2:
- Added a return after the successful path (Rik van Riel)
- Changed the Fixes tag to point to the commit that exposed the problem.
- Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
---
 net/core/netpoll.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..b8729ec1daeb8 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -232,14 +232,27 @@ static void refill_skbs(struct netpoll *np)
 
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


