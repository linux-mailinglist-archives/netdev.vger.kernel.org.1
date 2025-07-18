Return-Path: <netdev+bounces-208269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055FB0AC85
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9247ACCE6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FB22AE76;
	Fri, 18 Jul 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcyn0q4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB1221704
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880857; cv=none; b=tkc4n14RzlmAb061lfH2/dzZnIJ5xsiWTa20bHOYwKuyAwoaWB6BpNsqbH5fNaG5ES6NZluA/w4WvugfiD7OLnHyV/bYrqtyuyEKfjySziY90kRKvq7djnG/k4agFShdX+O/zaPEeo+/ZG8PSevw7uFcaDVKcHYcAPuEa0G4XBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880857; c=relaxed/simple;
	bh=GdHAB1S1wrcv2EfdZzMY00uv154mLCh985BV0HnL1kM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DD48+I2mIE3oMFWihH3efslKcat8kUQsUDnDlcU4nt8sGWSac/87HiujP2kOh0k6xAiU0poNJVH49Z/tqb7RGUIecuiBwDC4lWodY/gebAZ/kudkPv6LBjVwOADS+zBhXB68V9MwaFSgFV+vpZlBhcSi2GgjhlsmxkklcdKcDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcyn0q4P; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso2207566b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752880855; x=1753485655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dT1xJaTnivFv2d1AeF6SLlE028dbC6EgrFNSho80Td4=;
        b=gcyn0q4Pq0HpK2LGka/xhfknQZUOmmUisYfuR0ZV7pASy96jnM2yWgcOS6U6DNC4sw
         MZMhGCSNe+QQlSIlHPPDIFmuQ576JrmjtPDXV6VbbaEObFwvizl6EtZk6C2J5kZy1ip0
         a8UdAabooH/eTU2DV1mo/ky70bdAj+PQFz+T23Yu1QSUSj3sAPOUoZTXouhLkC0I9qNR
         shBeKqvuG7ZV60Sch2gPg+g/R1i5T74L2HolRRsU5AuTWa5ass6rDjhBiIBZeBNaMEIy
         qXcWAQp8q5unJQXLd9FuVKIGO3iS1y/elP/aZ5qmep8IdDdPVZXAIaKKGJ6ovaRZVXkr
         T0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880855; x=1753485655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dT1xJaTnivFv2d1AeF6SLlE028dbC6EgrFNSho80Td4=;
        b=VSOs6S/OGzOQusQzRFHxUE8ZuiVls6LXARKYboa5IVGFByHbNpvID1x1rVx6+odmKE
         yGGIJ5xTcxBWgkByp3+WIS7DOJpqOkQi6rzopnbHVC2/uSF6sddtUQCUDrCDqEuMS5Fq
         YbQfRiuTWTPVORV+rRNRrsL2nO899nisN5pzDDxu4HXzg9kJcNvcFaA1pgmbhCDKKeHE
         fDqiLzmtvRSMelgCxwQHdnoXEVZyOKcgTeT3pbYVkKR6NkjkfqGzQEtEpJU341/V3whq
         cNArPNa0jQXjiWg+zkiYbTPZWpoEeJz2qVFsgRRZIzpSFRnpKbhDi+nySaRmPAHv/0vI
         lAWw==
X-Gm-Message-State: AOJu0YwdvZE/cCsgXGJo4eAmRM1CygioqMZHwHPXg6rFZqPCbJp9AkjP
	PpPnzo5zihYcjy9KqJL4M+m84EMxkDJ6fQbvLCsopwBzrX+OTJIh5v493f+wHnhvDcxBkyRpsHj
	w9bWXlV88+4s/Vw==
X-Google-Smtp-Source: AGHT+IE93A7G/KyIM4gtJnvot0zInhgIIT7wTYpmYI6nO37G8bbe5mmsVmTaB26XrmD9ThTtGRu0MV4H+mPaKA==
X-Received: from pfblj15.prod.google.com ([2002:a05:6a00:71cf:b0:746:18ec:d11a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e85:b0:21c:f778:6736 with SMTP id adf61e73a8af0-23812457af6mr22160490637.27.1752880854911;
 Fri, 18 Jul 2025 16:20:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 23:20:47 +0000
In-Reply-To: <20250718232052.1266188-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718232052.1266188-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718232052.1266188-2-skhawaja@google.com>
Subject: [PATCH net-next v6 1/5] net: Create separate gro_flush_normal function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into separate helper function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>

---

v6:
 - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Also
   used it in kernel/bpf/cpumap.c
---
 include/net/gro.h   | 6 ++++++
 kernel/bpf/cpumap.c | 3 +--
 net/core/dev.c      | 9 +++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 22d3a69e4404..a0fca7ac6e7e 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -534,6 +534,12 @@ static inline void gro_normal_list(struct gro_node *gro)
 	gro->rx_count = 0;
 }
 
+static inline void gro_flush_normal(struct gro_node *gro, bool flush_old)
+{
+	gro_flush(gro, flush_old);
+	gro_normal_list(gro);
+}
+
 /* Queue one GRO_NORMAL SKB up for list processing. If batch size exceeded,
  * pass the whole batch up to the stack.
  */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 67e8a2fc1a99..b2b7b8ec2c2a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -282,8 +282,7 @@ static void cpu_map_gro_flush(struct bpf_cpu_map_entry *rcpu, bool empty)
 	 * This is equivalent to how NAPI decides whether to perform a full
 	 * flush.
 	 */
-	gro_flush(&rcpu->gro, !empty && HZ >= 1000);
-	gro_normal_list(&rcpu->gro);
+	gro_flush_normal(&rcpu->gro, !empty && HZ >= 1000);
 }
 
 static int cpu_map_kthread_run(void *data)
diff --git a/net/core/dev.c b/net/core/dev.c
index 621a639aeba1..cc216a461743 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6574,8 +6574,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 * it, we need to bound somehow the time packets are kept in
 	 * the GRO layer.
 	 */
-	gro_flush(&n->gro, !!timeout);
-	gro_normal_list(&n->gro);
+	gro_flush_normal(&n->gro, !!timeout);
 
 	if (unlikely(!list_empty(&n->poll_list))) {
 		/* If n->poll_list is not empty, we need to mask irqs */
@@ -6645,8 +6644,7 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&napi->gro, HZ >= 1000);
-	gro_normal_list(&napi->gro);
+	gro_flush_normal(&napi->gro, HZ >= 1000);
 
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
@@ -7511,8 +7509,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&n->gro, HZ >= 1000);
-	gro_normal_list(&n->gro);
+	gro_flush_normal(&n->gro, HZ >= 1000);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.50.0.727.gbf7dc18ff4-goog


