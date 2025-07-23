Return-Path: <netdev+bounces-209164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74167B0E821
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1381C8879A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9017D19E7E2;
	Wed, 23 Jul 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWNG39nU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A83156C40
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234236; cv=none; b=rXvXHGjNpF0X1/kDaUewcHjONi0GWFWAV2e3muTI6i4LT48bOtQ2iSOHzsU28KfUqGdYg/lUFyGaLrau2UoDZ7yjDdY4iXCY+xeD6qdMithhGXz0qXLXny3e6sbQUUZeavHkPzr0NxiKQY9BfVNpWp6MRD/Ivv8DwKmev0/3xTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234236; c=relaxed/simple;
	bh=Xza4efusdERsQJ7qC2nh3fgWh96ZE4S7TwqU/KCq0AA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2BdIOMUZxOuMwX8Mbubv0pxlFzRk6nALvyml238T2W9VGgIJxQnvH+eTci82i6KuyfvvYKa9ycwMdvmvhAjY2rG+Up7+HbsG3RTW1/55N1/EzzaTgHZmOhxGRah97KFUxgBlwL4OJXymhg8346xbvYL8JTSkNFLtVBXzVHYRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWNG39nU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so58427665ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753234234; x=1753839034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nd1g1V2bLgmdFk5D7dc9Rwz4Lzy2zrx+cWAF9by1+N4=;
        b=rWNG39nULsePa2uNXiM15OtL9vg23rYKq1B3N+i1o+klRyGBOls99SrraJ/fxLJJBJ
         3kmH5O1S9J+2SoasP7vWnMezifsrceEMGbLkJ2BZ1bhE7vQzUr7asjbXzzGI2cUgEXFU
         lzZEOppVwxDlDXGMxqpopOSPMYuPlu7jvgNjhnwc7orVLX7/1IEddbLQRdZqvktyxJBe
         1vr1v6yvmlz5Wzkz/x9Z1u1vcYWBk9Fj2/5LZmwrkA1C1RwOMtjOuFNHlA3k8a6MgGtC
         B8OZQ+jVvKPqOeaZsPaC1RFb5326bgOmaEEqexASt9OuykY23awQYkK1/XmtBi46eq6B
         GzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753234234; x=1753839034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd1g1V2bLgmdFk5D7dc9Rwz4Lzy2zrx+cWAF9by1+N4=;
        b=H56Y+DxHttIb1y6HV1gHVtrgk9p7icdiNMswya700xG+Q6l3WKX4Fz003wHKwFiiCY
         sM2QkcA5W0igPh/Yn4T6emaaKwxEciptqv7CyPEgkrt2pvduRynxyI3gBfj5SWkXOohj
         7UaQ5hQjUZWc6gkqrcxML7oNJl61ZS+HLOz7bXhHH3xrYoCs8aNzsP5LoDmW9LC9dA6A
         jGSUTlzfHc30ru8dum1Ufmp73gA3yj43B7RZ8BSOWhDqz7Ag+aQF9cfx59adiHWxQz2M
         Qce/ALV89Ul4uczUM4tT5lJ1dxrEB9RKMDk2qvO6/cHHXUWS9k5Sm+D5EWSdcWrE31q/
         HNvQ==
X-Gm-Message-State: AOJu0Yx/1c9WjeGO9Ocdi0Dwu57pBJX6ORq2W/xlBwkZJblOnkvYRcxU
	QAQS0ls4DSvco47b2snvKYfAZRBYKxpzXFROmFi1uD+n2TN1f7G+9T+tqd7YQ/10Wsraxz1hhY8
	pzQWFIphxOCiihA==
X-Google-Smtp-Source: AGHT+IHymyMG6sf8bX4ZTdv3hqY5/5KA64NCsMaBYASu5Uw5TKBmDQJMK2zH0ShXxD76pu7M298Q6fPXXpqrWA==
X-Received: from pllt10.prod.google.com ([2002:a17:902:dcca:b0:234:952b:35a2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2352:b0:226:38ff:1d6a with SMTP id d9443c01a7336-23f9814697amr14773745ad.7.1753234234069;
 Tue, 22 Jul 2025 18:30:34 -0700 (PDT)
Date: Wed, 23 Jul 2025 01:30:29 +0000
In-Reply-To: <20250723013031.2911384-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723013031.2911384-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723013031.2911384-2-skhawaja@google.com>
Subject: [PATCH net-next v8 1/3] net: Create separate gro_flush_normal function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
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
index 354d3453b407..76384b8a7871 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6578,8 +6578,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 * it, we need to bound somehow the time packets are kept in
 	 * the GRO layer.
 	 */
-	gro_flush(&n->gro, !!timeout);
-	gro_normal_list(&n->gro);
+	gro_flush_normal(&n->gro, !!timeout);
 
 	if (unlikely(!list_empty(&n->poll_list))) {
 		/* If n->poll_list is not empty, we need to mask irqs */
@@ -6649,8 +6648,7 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&napi->gro, HZ >= 1000);
-	gro_normal_list(&napi->gro);
+	gro_flush_normal(&napi->gro, HZ >= 1000);
 
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
@@ -7515,8 +7513,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&n->gro, HZ >= 1000);
-	gro_normal_list(&n->gro);
+	gro_flush_normal(&n->gro, HZ >= 1000);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.50.0.727.gbf7dc18ff4-goog


