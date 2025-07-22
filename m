Return-Path: <netdev+bounces-208765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE1B0D002
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67F1C21CF5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089F28B7E6;
	Tue, 22 Jul 2025 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSwMowVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3D1876
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153651; cv=none; b=obghaozNIGhLJUU0DaNeawkTRGBLHcJBkzDvxoFzIs/avItSayVGzeSWeMQGmB3aMp9VKzt1adLcwe+SLCN4VloFlX98befGKcVkQO+B4LQlcsZOofZO09eFy7uZesmkn2EKrSu0JYpKy0gcUUny4cJ5uKGL95EMRdjkjK4VFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153651; c=relaxed/simple;
	bh=xeYrifuNwAUrzUDngsSjIl8JpFuTUjFyMxEsK9793u4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I3SNoQ71vm9Iu38OtCQEPTypJlIzQTRH4AHtK7nfMWhYt4VOSlTiJNFp10NF4Ys8QnHcrGbZRJikyB+09jN4mqvk72HxY8tjUl4Lvap8zaeQn5ZKpX4zCKp9e+071wzV+UlNOpuXt/sAKEvq680lHY8G9AmBTK1JFdIaWwXQMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSwMowVM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-756a4884dfcso4781747b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753153649; x=1753758449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+EKJ9WpbLQwnzuzP0e/32ZWpEo7EFW5rm12U/0V0jA=;
        b=rSwMowVMqYUFAVggbbKkPhEnQJqcRiU7iY36D4aUyj73lVwqMaAHKpm9CulYgoGmhu
         C9avFJ2OmLqgYIVeg1eVNegvvYJkZkhwg9VT2NhO4CmL7kcuod9rA32YHJsVBTglFtTY
         ftTRFCFkp2ZnLdxSOtTfbKGQCgQn5e/Whsav3xCPVayav3wrI64Zm/QiTJ1ru9HgaDUs
         KyKScYL35dRDK4lmuthpQJV98773v/woE2VWq0H+DnRtQISUkf6fVa6Rh3xHFo5zN4ek
         iHfaLr+SuKDppNOndPyk8E8cPVjKpKT/oItdfcHF7dFZorfndPTeNBpGEsHGkYhVNgp5
         4E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153649; x=1753758449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+EKJ9WpbLQwnzuzP0e/32ZWpEo7EFW5rm12U/0V0jA=;
        b=TkS5OOUJmuspwDqrFpRfBi0T0AzIu0gk0ipKh5++tfj6BwzTK/ojwGjLV+4/dA73ZN
         2dSXsS98OF1Qq8KbCXBFyHDKAVc5gYacb1BixWrjjoQsBwz6idmClojd7hBTHngXz2s5
         uELbEwDjfFXKIb7a2AeTTGc7QzNH9zqMhZc9iQ/JpYNAY166RYFNZrCelGmdDkIuOi7k
         L4t5eIDvIpE4/B6NbWy9FSQDLxxDec4Wwb/WXcTJyh+xMKItOw9n7Uv2P36i1kYmiGIK
         pfAC5MZq7ZIHtfznAiKHFDYyHmOvo7nwEFaJvQhto3bJlEjms9FdHyyLx3UN8ILluwOi
         Wc3g==
X-Gm-Message-State: AOJu0YzsOS5Tvbc99DH+YLcb9FqefNEGhoNVlgYnUdSAAHvtstjMQxav
	lAM74fGLtlQmUgMs32wp2j5yVPtb3ZEdJMyuQqzxJaizs4rrzUbgzvh1E37RrB5ema2Z9/1QCff
	OWPua3JWy1QvRQw==
X-Google-Smtp-Source: AGHT+IF0xptWt/y8t7Xrj2XIKLxfmt25MxTA+78z9++3wB/TGZGu66xQ1sGzK5fP4KGENBiHtPcqmXT2xy74cQ==
X-Received: from pfbgt11.prod.google.com ([2002:a05:6a00:4e0b:b0:73e:665:360])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2306:b0:74b:4dcc:a150 with SMTP id d2e1a72fcca58-75722b73091mr30589830b3a.6.1753153649278;
 Mon, 21 Jul 2025 20:07:29 -0700 (PDT)
Date: Tue, 22 Jul 2025 03:07:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722030727.1033487-1-skhawaja@google.com>
Subject: [PATCH net-next v7 1/3] net: Create separate gro_flush_normal function
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

base-commit: fbd47be098b542dd8ad7beb42c88e7726d14cfb6
-- 
2.50.0.727.gbf7dc18ff4-goog


