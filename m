Return-Path: <netdev+bounces-226979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CEBA6BD2
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E89189BB96
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667A2BEC5E;
	Sun, 28 Sep 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXf8Ce10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E529B77E
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049380; cv=none; b=pwMeC91zxiAh5VvAR+qsUgURN5tysprsf9maGUTH7km8GqQcZ75crqv2xLXOt9iKGX0C1uloHFB7LylsYQJi31Xe47TcuI1Q2QuWbKIGsd0KLlcUcjbAw/yLqkCsOQ5/GKbcSZ17txJbkF9OaIMiYNZCBlb+vsWFQSyWej91gFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049380; c=relaxed/simple;
	bh=Q1Nmj0pbMfbloc9gBNRrhrW9qst1eSFvcMkPuuUyXww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+8V8Qrm50aRD7gqn+XRtD7uvMUotHAO55wn01xJ+m+dH6Dj+0aMuTdgTBKC6GxUdZsl8WDk5PVETrLDWEDmFOOmyT/30hoDuer4ACAVekmlxaRm9sygU3n2r+abdtJMtFwQ6yLqtIsb/JtDf19DvDzYlUV+TMwRb4g+L8QN8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXf8Ce10; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-857003e911fso885690485a.3
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759049378; x=1759654178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr39r5aOYvMd+CnsaniMx/5vjCaLEoqIQlozYyoc7v4=;
        b=DXf8Ce108/IxIIdS032tL78SIzPyujJbLpM/VA07exgbDydyjbhv8JNiO6vyuFNkvW
         eNq24SqA8EIL84nvZS8+9XNzWzRgIxdH9zyPbSMtc+6afjKkI8OyunQsS37NAv3sj1iv
         vMIRr9NfA6mu3U/d4r8aJs6KLcJag52RtFOAgbu1CGrA/mK4EIAROiGb50PmNx3Z11HY
         yokCXqnY27p7sYR/vtnFS/rlnKLzfTYgtJvW3DakHQdqEX1WhlnjYsxWRnuCKs47bW1+
         gXbo3ja2CzUOff54H06r+z8d2rDu7iAJlpTeQMkG/tSZbgIdnGjb9lIddFaihjwdzn1e
         A8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759049378; x=1759654178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr39r5aOYvMd+CnsaniMx/5vjCaLEoqIQlozYyoc7v4=;
        b=JwCkVwCEPSkY+xu9cwh1V38BzXyTZL9hKKJu/gKcFVcf590vnIUrkWxrcAJ5cPr2Aj
         ibQAFaIAPLt/PmwsAdUNq1ArKJVWa2l3Kl/ui8CYLxFKxg0YoqzohuARLtv4v6oKrwB+
         klQAKC2Az2cUGp3JGDNdDSKqjDk8R4dH7Pu4AHTeRpjBmiSVKa+WVvsVv7GQudJEYr4e
         axLckXlrP6gmJdTw5TkYkgIqF/VptGPeDCLX881OukpdffVPWlVQHcwXYlqsRPTtyJvB
         DD8XXZhn1iFGeAJi7JZjRGxYLh5z9Xgp/+N8m5dsLWJPNFNkW2cW9w5F8S5ef1RygiAG
         01eg==
X-Forwarded-Encrypted: i=1; AJvYcCWNwyAX14r0RINNvo6r+hZdDQS3qLNhHxrECQ1JIKn/Nnd8HZZEAQGPhlngsUEPfz7RBP/yZCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgYcoLqngi/UfuNgtGq9z5Mdmr4sYQWf23XAozGJjX066hp+J
	J4cR/V2gAwxXcpyIFeh/cImnN6WRvzCJAMBwHJuT3kW0MWjWuyPrbYrdfnBRK2YsNi3kDoQGBeI
	v6o0jRX3Kfr8W6Q==
X-Google-Smtp-Source: AGHT+IFQNERdBNr4EUy+1ohIR+f0ixlN2sf/frn4g+2lnGr3eVURc9hQsMxleHvaSE9dFM/0JDTbVMdqmuBSYg==
X-Received: from qkay17.prod.google.com ([2002:a05:620a:a091:b0:7fe:9767:1b7f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:440f:b0:816:bc84:9e4a with SMTP id af79cd13be357-85ae94c6f02mr1654032285a.69.1759049377707;
 Sun, 28 Sep 2025 01:49:37 -0700 (PDT)
Date: Sun, 28 Sep 2025 08:49:32 +0000
In-Reply-To: <20250928084934.3266948-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928084934.3266948-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928084934.3266948-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] net: make softnet_data.defer_count an atomic
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This is preparation work to remove the softnet_data.defer_lock,
as it is contended on hosts with large number of cores.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


