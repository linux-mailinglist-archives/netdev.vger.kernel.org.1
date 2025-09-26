Return-Path: <netdev+bounces-226713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC7BA45E0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089A61BC74BD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378411F542E;
	Fri, 26 Sep 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xge2J5Y8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9A1F1517
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899599; cv=none; b=b2qSIZ+sSXxnEcMljX7ViinTtQ6GVyhjeJ6LxPpD89j8b9AQzMzknNr5kURz4F9etbGiPJyYHqrrVoncEB+qqCPij02WOe3ltFpAaaW3wCvWMubY7hYbX5mHGdfx+BVLM+MYRh7qRRWj+NVQ+hXNsg7ci5vueF1Yx+lC2HPewNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899599; c=relaxed/simple;
	bh=VSxv0UVbjyHK2V8Dj3mIdaOzqxZQiSq/m0v7QOiqOi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hZFGL0sSHbXyOk8StG6BfcySU9n91WLl3qo/OiQTcjAxEBbpTm86Z4uB8/OWyZ5mAd6vi9ELzEQXoHPB/PAM1sYpOrXlUbw9NnhuojkEhOX6oMTlESmBuiBTOy1+AVVWDOPvBbVUGKPe2wagHAmmv09SjApkQjcjOM8ieLLzQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xge2J5Y8; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4dd932741cfso19176151cf.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758899596; x=1759504396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYQCaplEdg5XUWB2ik+LjHqLRAB0X0Dp5xBA/kGpOVM=;
        b=xge2J5Y85GfVCv/7Q/oi4/W3z9ulUnxvFHsIgGIMSDE1fR0liMJVJKpXy04WvPWOKF
         jquXFxApcIwmeLcu9P1oQJgRIC/FkTt8HN6DjXHGG4Ja970Dk9hzzhg9w6wsjCMfU3n3
         L3tOEmP8DG3/XGgQ2zlFGYa9YfzZp+S6IMGg5ug5D/5Xj2jSRlUGl9T6n0jMcHQHP/Au
         I2DTWMLJ+KbBZQJBD1CqyPNH53ZkNzHMTkCAYry2f2QP8h8m6yyyR+OWDZpWjkQE4Ebl
         eZBIEdOrXypig3nzJqrt2A131VAb0mDhK5OR3jKZgWNUL0c225cCMLmlQhe3+JKXVvgi
         iYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899596; x=1759504396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYQCaplEdg5XUWB2ik+LjHqLRAB0X0Dp5xBA/kGpOVM=;
        b=pkQJLO5HtXaDn8h1ZJlygeRyoBKkT6YljevMRO/QqRlA3KfsgRf45FceLERTdVbhq7
         6qxkHuGxXSzwZLvsmS3xO8pijNVS3Ny0NtXgUFHrZFJ5GBsEXFnV7dAsc9fjPnEmXcFE
         Jt1RZQkmgdP9JCErQGvLGHtT9lJqd5VE+2oDbslS1XBA3HDBUAvqqPV6PQ99xJ3zhmXJ
         DMfkdWf7FrwR7yI027ySKCF0F+QgLsSXTIqiwAx+BdFZpWe+N4tPz7/W3VtCi9Up0i+5
         H1shpPN8DWrpejxwH2JRkNEt0aAji6SZzJr5dw1tr5aav9iBI2QWQ+yyNscvw2OJ/O79
         nc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc32gxNw/0vDWAmPEpTnUM5gm3bTFiZDgq3ykY+hMOQDdfD2Ia8mMUkg4A93KIGtEGzJ4zBkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmxw5zxASxKGp6s8GdyublC7slNRjaNiGpTuZo65G7QpD7I46Q
	Xs7oi8druIVF/Nsv3ze5jzj4yJg9E8+WZBlmEd4heAGQmTT7cZqbessPayRw5F4+Wk/TDp/GAJ5
	vxv2u/d0AB3veRg==
X-Google-Smtp-Source: AGHT+IGMThjLlMK4WQcjkh31ZVbhwR/61DVv9e758D5LwrDCOdx6QpySYT+eEcuvuVRUwngEUIqIzSQyDeFt2g==
X-Received: from qtxm7.prod.google.com ([2002:a05:622a:547:b0:4b0:68c4:75c4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:7284:b0:4dc:82dd:5611 with SMTP id d75a77b69052e-4dc82dd5bb6mr34510891cf.48.1758899596369;
 Fri, 26 Sep 2025 08:13:16 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:13:02 +0000
In-Reply-To: <20250926151304.1897276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926151304.1897276-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: make softnet_data.defer_count an atomic
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is preparation work to remove the softnet_data.defer_lock,
as it is contended on hosts with large number of cores.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 2 +-
 net/core/skbuff.c         | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b85454116f666ced61a1450d3f899940f499c05..27e3fa69253f694b98d32b6138cf491da5a8b824 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3538,7 +3538,7 @@ struct softnet_data {
 
 	/* Another possibly contended cache line */
 	spinlock_t		defer_lock ____cacheline_aligned_in_smp;
-	int			defer_count;
+	atomic_t		defer_count;
 	int			defer_ipi_scheduled;
 	struct sk_buff		*defer_list;
 	call_single_data_t	defer_csd;
diff --git a/net/core/dev.c b/net/core/dev.c
index 8b54fdf0289ab223fc37d27a078536db37646b55..8566678d83444e8aacbfea4842878279cf28516f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6726,7 +6726,7 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	spin_lock(&sd->defer_lock);
 	skb = sd->defer_list;
 	sd->defer_list = NULL;
-	sd->defer_count = 0;
+	atomic_set(&sd->defer_count, 0);
 	spin_unlock(&sd->defer_lock);
 
 	while (skb != NULL) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index daaf6da43cc9e199389c3afcd6621c177d247884..f91571f51c69ecf8c2fffed5f3a3cd33fd95828b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7201,14 +7201,12 @@ nodefer:	kfree_skb_napi_cache(skb);
 
 	sd = &per_cpu(softnet_data, cpu);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
-	if (READ_ONCE(sd->defer_count) >= defer_max)
+	if (atomic_read(&sd->defer_count) >= defer_max)
 		goto nodefer;
 
 	spin_lock_bh(&sd->defer_lock);
 	/* Send an IPI every time queue reaches half capacity. */
-	kick = sd->defer_count == (defer_max >> 1);
-	/* Paired with the READ_ONCE() few lines above */
-	WRITE_ONCE(sd->defer_count, sd->defer_count + 1);
+	kick = (atomic_inc_return(&sd->defer_count) - 1) == (defer_max >> 1);
 
 	skb->next = sd->defer_list;
 	/* Paired with READ_ONCE() in skb_defer_free_flush() */
-- 
2.51.0.536.g15c5d4f767-goog


