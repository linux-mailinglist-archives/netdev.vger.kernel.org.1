Return-Path: <netdev+bounces-226714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C962BA45E6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9D27AF686
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C7B2036E9;
	Fri, 26 Sep 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnTtZDgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5F1F4634
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899600; cv=none; b=dE7zduEt3Wc8k97U130iyZJzDaWuEhOBmW0XP5CH1Qh01yQ4x/KVYdLtN0zeSkU266xf4oPEAS6n3TBpdBF560qp0F/UgaILpoMEAbtjdDDLNDukqA15PqLdkO/Q0FTzaXIh6jdc2a33ytpEPy3ce8tRAHttVe+c/sC3d9rFCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899600; c=relaxed/simple;
	bh=LAZzIcLPLeqjOmXSFEDh4WppCjV9NE3CBx46FlgAUpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRhZUjY9KrRMX/8DnN/DoHub9vaoG3cLOh2xud+axDL2Mlfck4VqTOtkqSTCrAi2m3R7+ez+foHbQCKel3fUsMhX713o3vE+xS7qFfo+Cnh4TW1Rftgls5I7TEJKOegVCUnTtxJa8KF8XRAEZUW72XenzbqhgSKodGpazF6dr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnTtZDgt; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4d1b3c6833bso53199881cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758899598; x=1759504398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmI2SHtQzD4jn/PxCqv+E8/hD4UErYoihivH60RxTjw=;
        b=JnTtZDgtHVderzis+TIkvspJwyAOZ4Lw+FzTBkIqJE8oNJ/suY387XU+sxGwtfgfGd
         vnLl59bSyEh6iWBg3QM8vKAZfbSK6dQnXckSwj7GtCT6M7F7W+I/HD3DgqikVp2l0bI1
         StgC7YUx8AcoF3Ik2UxW0y25XjNCYqJsC2QWllsBViLSEDt29g+t5qlqS2QSXoWdQYqz
         BBtFQUuUKpDjmiDRSWHrlH+zBAk+i2BIc5q9ArmEzgEnwL8rNf81uOUIYHwHdzrQJ64v
         O70wGDNYyYXUADSrIowL1zeCL9yg1Vk2XQcAS4oheN9F08T2H8okMZO6rwMvZIn8WKpf
         cwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899598; x=1759504398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmI2SHtQzD4jn/PxCqv+E8/hD4UErYoihivH60RxTjw=;
        b=vgZb8niElx8FQCuuX7Up5Tq/YvNQ+qlT6xPXnOd4TmljZ4v+CeN2QgEkqztobcSj2q
         RVnrsXABrlDcjjjjU0nu1SMeW5cl7nfDNSVMVV23au0z1bqPBi5y1WbjRlmuR9DXizAt
         5VzNRr2CXWtuzQ3AO0sbCjuzKlLuVQdpXFgM/mvTSCKJYpaFdorN7MW/22YMYJmFMGiF
         mlrORwht5fG+FgIpLixel7GzJgZAevObnQzx/K3tW2zMphVhV8VcrYzGpEpQtdMTkM36
         nysaOducUbvMCxrjuUDp4khmHFFEZLxzrFeOgUEipmA3EwqR3j8HwMLiAvIzxqsu9n7d
         RbSA==
X-Forwarded-Encrypted: i=1; AJvYcCUxxgwHQ+ViBLQqHSH18y3dsFAQ3TLAJJcMY9HVXSZvDoUOnwpYv3VbNS2JPNTUP+HS0+yTcM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSWsnYSAVIF3t4gYaIu1TAz47odutPniQkCfZgqr41NVZe/+k
	OKT1AFWJrudcZVd5bY2XpJRhy6z8xHFEUZ2RowqqmxTAHOjmzPrKw1AJE645SubqKSV/UMPvoQ+
	hjOBTEe4wUcGu6g==
X-Google-Smtp-Source: AGHT+IEb/E6ZmE5OBOqtw85mjBeZfudAGNjWbNWA2WRuwYTOikvgJ9ayS8Sf5jKNLlegKERnnQux453VraXR7Q==
X-Received: from qkbdp2.prod.google.com ([2002:a05:620a:2b42:b0:846:929:4be7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f82:0:b0:4d1:7f1f:af5f with SMTP id d75a77b69052e-4da48d78e03mr88215841cf.34.1758899598001;
 Fri, 26 Sep 2025 08:13:18 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:13:03 +0000
In-Reply-To: <20250926151304.1897276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926151304.1897276-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: use llist for sd->defer_list
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Get rid of sd->defer_lock and adopt llist operations.

We optimize skb_attempt_defer_free() for the common case,
where the packet is queued. Otherwise sd->defer_count
is increasing, until skb_defer_free_flush() clears it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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


