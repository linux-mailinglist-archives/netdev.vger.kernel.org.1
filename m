Return-Path: <netdev+bounces-226875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8FBA5C53
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCAD4C0245
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8942C3274;
	Sat, 27 Sep 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D5qdahZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87F18DB26
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965312; cv=none; b=ql/RbyW5OMz6rWTw9kfzT1ozEf/tPgo8H6++y185mMxI7SJQ6cVhUTVKSey3U2ISsKeg/SmU6GjGL3QrhXfjKvGWD1E5uSqG/WNCl2JvFmDjIufQQcDnpoykKl9tKXh3HyuOsyhELJegxQFspN7VLpzkW3M8olLoyY0LKoz6CxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965312; c=relaxed/simple;
	bh=rcmDYtlLpSDEofowEkwBjp5a3ZQ+jqCnG3TKSi0pgfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nb7a13xruoVGgtHlBcYc0JHuJHTQ18cvMi2aIfldQuJAZ9zm/Mn7cFZklMzS4MMqwRrY/IcdEEd14FAQ/iKxMfpZfDDQO6iSBFYf70qSMYPyEo+FqM0H+DZa+q/BToYdqNSR1egUxEB1ikC5iItoDCNBv4tyqN08Rgo3V+JxoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D5qdahZ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4dfc05dec2fso985871cf.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758965309; x=1759570109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rka+a5FlfdtP6zxHcwLemDDeKFOYe+tH/66MfpNM3QA=;
        b=4D5qdahZErA/WqZjqzFVhAOZJfXo1HWJy4iSDfVWZvrjmBUg5CVYmJ2s8LfKi9PxZg
         ur7FHVxkzXOaYlspEk0SVoV4qjoFI6u9vyL5UNrNGlMDwbxeRu6ZeTljrkDSb/bwaHa/
         jF8rVmsQ0qNOhA1urYOQS2GwoSPkPg1m4aehO4uL5qTx339OB9lcPMr23JwLMpVI0x63
         ZEkRD3ZPvyaLOQ7hr0m+gxIlcapockHTIN/j+6YspUhai7KAuZzBb5vz01gXowx/j8iZ
         U0zxIEQzqWnsLHgMRl3952EzScEB+ek86mJDB3B8WJ251YoWaiC/65HsDga8zzXOYHSe
         z1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965309; x=1759570109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rka+a5FlfdtP6zxHcwLemDDeKFOYe+tH/66MfpNM3QA=;
        b=p0XlxD2oICeXczTlNNjA6bWJL7kUMpQX/hzKJIPMcsuXTKdqOHmoWoac/F1HzXkx2B
         6J1koll9wVD45q8GbToYa8yuLJx1eMhSBKSx+u/YAdeZuO49lFYn0XCAJtQ35mhm6vDe
         hl7RbAforRX+dCbSE09D1GRsDsuUR8yVHWaa/oMGEelAR1MhSXkucv0vEiJUWXKnURxL
         coQT3zsWcKFG6ozGlCiwBatBuKlaUnUVPQlzfjpHqQF0FlZrcuEor3EKB4Oit0tV7ZJn
         DwaZlLKX+ayIgnE72fTrwGJzmZDixSNggT2i/KrchvM1m9upY1uG0r6rHGXmFKvm+XIb
         /FQA==
X-Forwarded-Encrypted: i=1; AJvYcCVo6xMxtGjkF17kwpdfQ/etYSCBQSrCZbg6hGrvGrsiqCCM2eK2e/QkXqf5oyB/s47PrLZBfoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsjN+fxBsIGD8ieMvs6i+XY5jNc6BzGdctPzYwP+gW+uSKHKf
	5z+LZfT/PRpt2u/UWGxi332jd0rBuciA/l9d1qpOOU3bLL+wM95RAIG+gzKZYHgIOfagAjqnSiH
	hVA/hGp4VlbqDWg==
X-Google-Smtp-Source: AGHT+IH9wGic6tntILObc3TB3bHf6yk36j9DH3Vzh/EaWWJRNjIzXE5QQ2srXRhEcjtwhhy8klaBBehPWF3u8g==
X-Received: from qtnz8.prod.google.com ([2002:ac8:4548:0:b0:4ce:12a7:aaca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c16:b0:4b7:8d26:5068 with SMTP id d75a77b69052e-4da4782dab8mr166794371cf.17.1758965309343;
 Sat, 27 Sep 2025 02:28:29 -0700 (PDT)
Date: Sat, 27 Sep 2025 09:28:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927092827.2707901-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: use skb->len instead of skb->truesize in tcp_can_ingest()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some applications are stuck to the 20th century and still use
small SO_RCVBUF values.

After the blamed commit, we can drop packets especially
when using LRO/hw-gro enabled NIC and small MSS (1500) values.

LRO/hw-gro NIC pack multiple segments into pages, allowing
tp->scaling_ratio to be set to a high value.

Whenever the receive queue gets full, we can receive a small packet
filling RWIN, but with a high skb->truesize, because most NIC use 4K page
plus sk_buff metadata even when receiving less than 1500 bytes of payload.

Even if we refine how tp->scaling_ratio is estimated,
we could have an issue at the start of the flow, because
the first round of packets (IW10) will be sent based on
the initial tp->scaling_ratio (1/2)

Relax tcp_can_ingest() to use skb->len instead of skb->truesize,
allowing the peer to use final RWIN, assuming a 'perfect'
scaling_ratio of 1.

Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79d5252ed6cc1a24ec898f4168d47c39c6e92fe1..0a2511ce34db27a512a2f4d1a12e45069a2c12d3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5086,12 +5086,23 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
 /* Check if this incoming skb can be added to socket receive queues
  * while satisfying sk->sk_rcvbuf limit.
+ *
+ * In theory we should use skb->truesize, but this can cause problems
+ * when applications use too small SO_RCVBUF values.
+ * When LRO / hw gro is used, the socket might have a high tp->scaling_ratio,
+ * allowing RWIN to be close to available space.
+ * Whenever the receive queue gets full, we can receive a small packet
+ * filling RWIN, but with a high skb->truesize, because most NIC use 4K page
+ * plus sk_buff metadata even when receiving less than 1500 bytes of payload.
+ *
+ * Note that we use skb->len to decide to accept or drop this packet,
+ * but sk->sk_rmem_alloc is the sum of all skb->truesize.
  */
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
 {
-	unsigned int new_mem = atomic_read(&sk->sk_rmem_alloc) + skb->truesize;
+	unsigned int rmem = atomic_read(&sk->sk_rmem_alloc);
 
-	return new_mem <= sk->sk_rcvbuf;
+	return rmem + skb->len <= sk->sk_rcvbuf;
 }
 
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
-- 
2.51.0.536.g15c5d4f767-goog


