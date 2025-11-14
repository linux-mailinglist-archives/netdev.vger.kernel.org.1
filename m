Return-Path: <netdev+bounces-238665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475CC5D09A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4146F359EF7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342E314D2C;
	Fri, 14 Nov 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uN+AyKZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295D3148A7
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122372; cv=none; b=YMJpTZMWLNUYzpC3W143rJA4D+yt7WnUS93rhhsnCHIXy0oRHTwsnWiKaul4Ck5H3pAYKpAX+Ga39MnK5oXJ/PTieMdXV0/ptr9cM6aW9iBhTgbFY8C8MgNY9x8fH6SOn5XXC29yNr6SJeX1I9BJYXiccYUjnJF3pX6NzoZeCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122372; c=relaxed/simple;
	bh=YSYk+LlyHFJA/s9qf8H0aw4dFddmy3PGJUo6TS2jwc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WuSVARj1kZZMyEXnTbZarEZ+eXqSI5+pfq+8pjyz88kBsN24n/vYV8NbBUcynx7aNEVOVNZ1jqKTCjb/XcQ6n3bZms+wMqdlNty31tawCRmh/DLAPEznTch9rovFHWxse2DSznWxy76TJi5sz3HsbqixpSQ1aQLlmHwb/+p+Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uN+AyKZG; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88044215975so73255706d6.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763122370; x=1763727170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vpoOUKVz2ev8hQJxw9R8J7tadn7vI6+LkfxM8shov0=;
        b=uN+AyKZGcBi9ksAVq2u/V3OzvFmsyMGvqLnK1blbJrY1HMdoAWBMUPHR12A4rR1P2f
         yciDg8KJiN5PJiQp9fJplrE5POevDbOkdltCKk0l3SXkfmg7XX02DX9IqzKS8KLap/ah
         NiR5ucQIgFa9djlKwJtM3aoACtqbiKajOyxZh/UW7359IcJjF1CKE/Cym4wZ6hwAhlRp
         yNs8EpIyVglOLjlI/FiwGeGk7m5W4HM8ZEgO4YzD12PtbitPYxuQNQq0kXD4rGFDnS+h
         aATYSM/pKEGTIw5dVXkIAxkJpHQ69sOK/GhZF3acjQY7Dnp5iPJcLDPF673/oI8X51hU
         ToYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122370; x=1763727170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vpoOUKVz2ev8hQJxw9R8J7tadn7vI6+LkfxM8shov0=;
        b=mvdi2SDRaQAwQwQ5mSNHRqu5J5x6qssnEUjEwD2zEwfELeuDnlsvd+656QOJ0Nlq/T
         z5FvsNRurzmabreMbuqfT+5hwDFmlo9vVfGwL8HP8S31snYzPrDs2Wu/gxX1jS8hxuy6
         Fe7eNTvDO7L10mNEQqemEchSCxap1zo70VQ69kBO2IG5j/YLXGBwrbKgdRtroriXazfl
         FLNRDu1nonJGaGgaH0A8Ylwr/6lGMX62g6Wzj000LtAMhnp4Oy7R73Tcc18wBX9e8csW
         0o53kAFPrC3O9HrDRyNDScJmdLClRSjq6ZXHnqO8AC3n61fTZhU5XW9KAeALnzHQe3t8
         NjyA==
X-Forwarded-Encrypted: i=1; AJvYcCVA7JUbHYghyPZ7kZK1I2h4od0AtubqM8vMaq4G6DJj4nUEW839txtrlOkIvLvPwpdHhLjGvns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxF98UBFFL3EhKk9XV/X8i0qIvaZBfEU+cgS0P8SBi5vheDLG
	GxevGpV/9otn/31+sMbsrqjbwAwSRN7LxkbqmvOjGRAlrl1uFExWT3YCybMXwywqm+c5D+d09Wo
	cQhiwKV8oQMFAkw==
X-Google-Smtp-Source: AGHT+IE+azqD3I6vI8v0di9ifyIIUhMuUqT0/6Cs2DoWr0puWouVi5NHuZnYuINsWeoH4UvK71vGOL2TnZ0K3Q==
X-Received: from qvbmu7.prod.google.com ([2002:a05:6214:3287:b0:882:48f0:2b11])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2aa7:b0:882:44f8:44a8 with SMTP id 6a1803df08f44-88292740070mr33657656d6.57.1763122369686;
 Fri, 14 Nov 2025 04:12:49 -0800 (PST)
Date: Fri, 14 Nov 2025 12:12:43 +0000
In-Reply-To: <20251114121243.3519133-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114121243.3519133-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] net: use napi_skb_cache even in process context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
with alien skbs").

Now the per-cpu napi_skb_cache is populated from TX completion path,
we can make use of this cache, especially for cpus not used
from a driver NAPI poll (primary user of napi_cache).

We can use the napi_skb_cache only if current context is not from hard irq.

With this patch, I consistently reach 130 Mpps on my UDP tx stress test
and reduce SLUB spinlock contention to smaller values.

Note there is still some SLUB contention for skb->head allocations.

I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
and /sys/kernel/slab/skbuff_small_head/min_partial depending
on the platform taxonomy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c6b065c0a2af265159ee6188469936767a295729..bda7e2196060f97c9fb7f8effd5276a7f5db3a74 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -662,8 +662,13 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	if (unlikely(node != NUMA_NO_NODE && node != numa_mem_id()))
 		goto fallback;
 
-	if (flags & SKB_ALLOC_NAPI)
+	if (flags & SKB_ALLOC_NAPI) {
 		skb = napi_skb_cache_get(true);
+	} else if (!in_hardirq() && !irqs_disabled()) {
+		local_bh_disable();
+		skb = napi_skb_cache_get(false);
+		local_bh_enable();
+	}
 
 	if (!skb) {
 fallback:
-- 
2.52.0.rc1.455.g30608eb744-goog


