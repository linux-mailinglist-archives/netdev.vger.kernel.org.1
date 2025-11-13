Return-Path: <netdev+bounces-238373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95841C57EC1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE734426677
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC226F2AC;
	Thu, 13 Nov 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcH4PdKo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BE26ED4A
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042643; cv=none; b=cpmj2T5jye68K+wl0L8+FrK2sEeqiDSWjokUamcs/v1A07ZXpdsVbEpyl774QkrdMmV4xBlQnj0Y+Nerxyt6I67nYq6NBk4ANS3jseWZ7crIaLyJ2xEcvPq+KpAQaW1/F7l6iryn9isZUE1ftTayFD19vS/akMDmX/XeguxIMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042643; c=relaxed/simple;
	bh=XLFd9EgAsul2aqYtpaudx522VHwh25Af38OQDufgxcM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IWGE8iDvYnbG1uEjOwrFKgtkr6Qpt7JuXRfbh8OTpXLaj+3b2G2XyfdUXFrukghKWtNvaJg0fBwkZZ2QsIclPvxk6hfoSH2sKSRzI1EFbcTmZzg0N5s+MxYOfzf3G+faGtMSMcsxxt/hgOAI1TPE47ezpOK2vHE+36/HwBOwhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcH4PdKo; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88237204cc8so12534786d6.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763042641; x=1763647441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCeU3nW+iP5XYcQT9xOpL90yw7proXQaFgefp89jcAw=;
        b=bcH4PdKoysuX+5v+HQIh7QP/LJ0HvJYW4+FuFER6244eRgfarcY8IxqJs9wALaPozc
         U/1QlRfRvJaMK94n7W0ID4+udaI9BDF6gb0czGnJH3lI1zpHpr+KVEyZebcAoOD4f7Rn
         f/XhHJo99KnqipzH7ugQxA6NAmFuIE042i3pZAb9AUgBaYQhDwaRiyCTj2hiBY4OwMQz
         dZ3hzYkXxQVOjU3vg8ExYSVVoix/G23ukxAzjHqkZdpwvjCHs7Q5Rcv9WV9lPV+JZLNF
         8oaBwGk8X0j4KE7TLT9G78UROytKdj4njD1LXU3g0YIVhEI5fZfzlnNo6BBc8M82CTfi
         0smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042641; x=1763647441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCeU3nW+iP5XYcQT9xOpL90yw7proXQaFgefp89jcAw=;
        b=lebCh2ZAYQNgcPdhGvUvXPrwLTqZh+Y8vu3H9op69dqYzDFhX1Re1X7PRsj5CVo009
         8/QEQjpqdlhB7+T31bd71FNbItQLq5dg9rRx729BgFpVRClapvD7WTiiBwvsYxzGCS+N
         rOPbjlti2cVjD+38rd9FcH25J38Pvr5Bc5mTSu2D+4NlQa5dQjQHt5Kp3O41CM2fkpKf
         /b7IpGu4tUq1tMEa1Xi5k7Q3v8uzBfLZsbcPfxzHUkwhaoFo4IDx8y8Dw2uaIlxib5lg
         ByKkS1Y9U4RpUVfGbuXmk/vIv8mqkh7vBoVK+HWeCfo2xf3VT3Jgldc1Jv3ALo7tvGBV
         WlKA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLVcmrm39jucp+IcU6f8NbjKaBAguzANyQ2brgI/adDWWjhLMA3Q4qDnyxaTDSUlUbVnwASU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxL0ehCo7q3dKO0lQeqmYiheLJTYEYWeChS/mGAkxmKKd9Cd1
	Q0Q63c0Br+f9E5UGuSKXD1Ob9HDCdY9Q+h1PQIkMrXA+dtxvZBR3Ph/hCSiyKCeHn9AApXu3b1V
	ZWK0ZXqOQY6CxjA==
X-Google-Smtp-Source: AGHT+IFTHdsyrBMaE4WGygCRl6j0WasSr3kpJXbS+8En0ZpFlIm1B9HrpiTp45QPV9a4mV9NfAzYZJJjo7AS9A==
X-Received: from qkao17.prod.google.com ([2002:a05:620a:a811:b0:8b2:a14f:3fe5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a90:b0:8a2:fbb9:9b71 with SMTP id af79cd13be357-8b29b820970mr803150385a.69.1763042641067;
 Thu, 13 Nov 2025 06:04:01 -0800 (PST)
Date: Thu, 13 Nov 2025 14:03:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113140358.58242-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_gro_pull_header() is used in GRO fast path, inline it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gro.h      | 27 +++++++++++++++++++++++++++
 include/net/tcp.h      |  1 -
 net/ipv4/tcp_offload.c | 27 ---------------------------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index e3affb2e2ca8b2c89a9ffd6f7fb1219a42200ac3..b65f631c521d7d9741ef86781add0038c9ce4055 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -593,4 +593,31 @@ static inline void inet6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *
 struct packet_offload *gro_find_receive_by_type(__be16 type);
 struct packet_offload *gro_find_complete_by_type(__be16 type);
 
+static inline struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb)
+{
+	unsigned int thlen, hlen, off;
+	struct tcphdr *th;
+
+	off = skb_gro_offset(skb);
+	hlen = off + sizeof(*th);
+	th = skb_gro_header(skb, hlen, off);
+	if (unlikely(!th))
+		return NULL;
+
+	thlen = th->doff * 4;
+	if (unlikely(thlen < sizeof(*th)))
+		return NULL;
+
+	hlen = off + thlen;
+	if (!skb_gro_may_pull(skb, hlen)) {
+		th = skb_gro_header_slow(skb, hlen, off);
+		if (unlikely(!th))
+			return NULL;
+	}
+
+	skb_gro_pull(skb, thlen);
+
+	return th;
+}
+
 #endif /* _NET_GRO_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4833ec7903eca45cd31bb4ab023a8d326ed8b436..0deb5e9dd9114641468f26696b086b8261a67f60 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2313,7 +2313,6 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
-struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb);
 struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct tcphdr *th);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2cb93da93abc2922fc347f4d62093741eb17c9d8..fdda18b1abda0f69226f6b59cec6d7d51b53555b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -282,33 +282,6 @@ struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th)
 	return NULL;
 }
 
-struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb)
-{
-	unsigned int thlen, hlen, off;
-	struct tcphdr *th;
-
-	off = skb_gro_offset(skb);
-	hlen = off + sizeof(*th);
-	th = skb_gro_header(skb, hlen, off);
-	if (unlikely(!th))
-		return NULL;
-
-	thlen = th->doff * 4;
-	if (thlen < sizeof(*th))
-		return NULL;
-
-	hlen = off + thlen;
-	if (!skb_gro_may_pull(skb, hlen)) {
-		th = skb_gro_header_slow(skb, hlen, off);
-		if (unlikely(!th))
-			return NULL;
-	}
-
-	skb_gro_pull(skb, thlen);
-
-	return th;
-}
-
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct tcphdr *th)
 {
-- 
2.51.2.1041.gc1ab5b90ca-goog


