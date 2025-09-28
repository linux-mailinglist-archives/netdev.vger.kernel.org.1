Return-Path: <netdev+bounces-226980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E921DBA6BD5
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423BC17AFC4
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E4E2BF002;
	Sun, 28 Sep 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XakYITKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E186329
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049381; cv=none; b=I9jqhrC8tr34GXPD3ZpGdFl4lf3N60Fe7MdELp8tbY5MpJoS/kCFuSLqI55jQVT2QO247+e8TwEUghglbJolPIZ7t5aggz/+mFtLY3BUWLv27RsQVw87SsTVLgrbHvpxtxvKpgM2vVuyIvOjRWCEE7jd8k1KGU/W9kC9qZUTkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049381; c=relaxed/simple;
	bh=A1BKmEO2jWL6UeYhb3uVn/KSDx+6UrFckJcXahOWMYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbqVdkn37blNl90kXiEoGJzVTeSHWXLSoTS+06f/QmBkLedAmUewKPtfmJfbUgov5b+XoXSSvO9lsmojYauIohqI5NDkpU3BifrJapjT06KxrDZ6bdPaaHo86JEGi+ek+8t7vEOZ3sI3udBELHXy6cz9hXAFwqbC9GSmUe41du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XakYITKx; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-79e48b76f68so103179456d6.3
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759049379; x=1759654179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQjNLzgXTz5SQSNUAbxni6LYKOjtDb7YrnKm7obf3Fs=;
        b=XakYITKx/1UeQnwnlDmgLmDUQNbXWcCt5ATqXtl4e5ErNJvEgZkdmaiNNH4EyRLlTh
         XRIjKScBPO+fHoqLAQz/j4r0+nHM0fn2xoNvtfvzlhigCX9DS2h83N9WEjZ1Nj3hohdd
         rYf0TyB750Phr/ct4FGMREczV/iIk7sKc5PpWE5RUdV/KyGD3DD9eqJtK0hh3Drrd+81
         01eKL9cN+US5/dcLvDTyX6WfZKOqfxkR7RGbt5kBGIjkQlq7F1pmyX94EhHp0fcUdkCy
         GTWNpC4xbAWWO1YXau+Uxy6DgsEXKLCoASachz9eSrya2faxAwm7+bKtYy223KXy4NXd
         hHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759049379; x=1759654179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQjNLzgXTz5SQSNUAbxni6LYKOjtDb7YrnKm7obf3Fs=;
        b=cF/mOpaTdoaVQTCaoDI3vhc5I/NbVfQ2i1/KkoFtM9lUfk6NHhfkMF6wuluJ/T4Omb
         K8WjuD3ijSyVvSew+MvHKcO4Y5Oq3vHuItMLUYUEJxmqX2qTfokx1ufxTK2TpEDzhE35
         9q3EZTZ71r27Pt+56p9DzguhPZxqDlieE5Jaj6S8KE3IjFlohY3bc2gWSod9X2F26Onb
         q0Fn3q3E2tQz9OQknnZWFdFnyytT5QJqH0m8bNv587pFaFaAELmGe/dyjPxPoCn7Culm
         Ml16Ji0a6a2ROPxk9GZbBA4CF4eg8HzPat0txOI0qrnO7XXYp1qN5TeINXvMXv/YVU+4
         tHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDcFXTPFc3FZZrl1Q/OBF4KbR6+dr69BfJHEvmyFc33uSnD7+yVBilqfFaN+jL+H2ZMTC2RgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQb8Fa+BG2vEH/r3ttYBE7NU3sAhxw3YhxmuNMptYH6nXq9dY
	jSb2x2e7k32phWQp4Kn6sqZrjnOj1AilYCXo0wfNsHp7Yto0dxrsRext6vM83RxQdty//fAPkxM
	q2HiStqsmm1zDSw==
X-Google-Smtp-Source: AGHT+IFSu46COMpvA7Uhn4v49u7T72rNKQqHaJL9T8XxlNudDmJ4Nv5PfGCWPM+6jzLoXU12I1itAwa1sunSfA==
X-Received: from qvab19.prod.google.com ([2002:a05:6214:6113:b0:808:baae:d2f0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2508:b0:7ee:ff0d:c4c with SMTP id 6a1803df08f44-7fc2711ec3cmr171710976d6.14.1759049379291;
 Sun, 28 Sep 2025 01:49:39 -0700 (PDT)
Date: Sun, 28 Sep 2025 08:49:33 +0000
In-Reply-To: <20250928084934.3266948-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928084934.3266948-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928084934.3266948-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] net: use llist for sd->defer_list
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Get rid of sd->defer_lock and adopt llist operations.

We optimize skb_attempt_defer_free() for the common case,
where the packet is queued. Otherwise sd->defer_count
is increasing, until skb_defer_free_flush() clears it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h |  8 ++++----
 net/core/dev.c            | 18 ++++++------------
 net/core/skbuff.c         | 15 +++++++--------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 27e3fa69253f694b98d32b6138cf491da5a8b824..5c9aa16933d197f70746d64e5f44cae052d9971c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3537,10 +3537,10 @@ struct softnet_data {
 	struct numa_drop_counters drop_counters;
 
 	/* Another possibly contended cache line */
-	spinlock_t		defer_lock ____cacheline_aligned_in_smp;
-	atomic_t		defer_count;
-	int			defer_ipi_scheduled;
-	struct sk_buff		*defer_list;
+	struct llist_head	defer_list ____cacheline_aligned_in_smp;
+	atomic_long_t		defer_count;
+
+	int			defer_ipi_scheduled ____cacheline_aligned_in_smp;
 	call_single_data_t	defer_csd;
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 8566678d83444e8aacbfea4842878279cf28516f..fb67372774de10b0b112ca71c7c7a13819c2325b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6717,22 +6717,16 @@ EXPORT_SYMBOL(napi_complete_done);
 
 static void skb_defer_free_flush(struct softnet_data *sd)
 {
+	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
 
-	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
-	if (!READ_ONCE(sd->defer_list))
+	if (llist_empty(&sd->defer_list))
 		return;
+	atomic_long_set(&sd->defer_count, 0);
+	free_list = llist_del_all(&sd->defer_list);
 
-	spin_lock(&sd->defer_lock);
-	skb = sd->defer_list;
-	sd->defer_list = NULL;
-	atomic_set(&sd->defer_count, 0);
-	spin_unlock(&sd->defer_lock);
-
-	while (skb != NULL) {
-		next = skb->next;
+	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		napi_consume_skb(skb, 1);
-		skb = next;
 	}
 }
 
@@ -12995,7 +12989,7 @@ static int __init net_dev_init(void)
 		sd->cpu = i;
 #endif
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
-		spin_lock_init(&sd->defer_lock);
+		init_llist_head(&sd->defer_list);
 
 		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f91571f51c69ecf8c2fffed5f3a3cd33fd95828b..22d9dba0e433cf67243a5b7dda77e61d146baf50 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7184,6 +7184,7 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
  */
 void skb_attempt_defer_free(struct sk_buff *skb)
 {
+	unsigned long defer_count;
 	int cpu = skb->alloc_cpu;
 	struct softnet_data *sd;
 	unsigned int defer_max;
@@ -7201,17 +7202,15 @@ nodefer:	kfree_skb_napi_cache(skb);
 
 	sd = &per_cpu(softnet_data, cpu);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
-	if (atomic_read(&sd->defer_count) >= defer_max)
+	defer_count = atomic_long_inc_return(&sd->defer_count);
+
+	if (defer_count >= defer_max)
 		goto nodefer;
 
-	spin_lock_bh(&sd->defer_lock);
-	/* Send an IPI every time queue reaches half capacity. */
-	kick = (atomic_inc_return(&sd->defer_count) - 1) == (defer_max >> 1);
+	llist_add(&skb->ll_node, &sd->defer_list);
 
-	skb->next = sd->defer_list;
-	/* Paired with READ_ONCE() in skb_defer_free_flush() */
-	WRITE_ONCE(sd->defer_list, skb);
-	spin_unlock_bh(&sd->defer_lock);
+	/* Send an IPI every time queue reaches half capacity. */
+	kick = (defer_count - 1) == (defer_max >> 1);
 
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
-- 
2.51.0.536.g15c5d4f767-goog


