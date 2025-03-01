Return-Path: <netdev+bounces-170962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD82A4ADC2
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7712016FD1B
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB21E8351;
	Sat,  1 Mar 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUvUx7Cl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5941C5D77
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860070; cv=none; b=YbQbC02L8WGUtcUXEDFaO3kOA+PMMTIpxJuafzbgYJ+CQwBjH4IWje6pQFAos7CVC2SbzO2p2jysaCZg9d02hXjB1M8/06YNJSWeYLQ/uLbxzYh03Nv7YLYOPoofpkhl4DD/pwSclJbfM0KalAGVlpvXoCc8W2/qtPv9lXvNLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860070; c=relaxed/simple;
	bh=aB13b280MIcVuRc0VxldBo9bZY8SatpOVnXV+GjnvM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pxkxwsKndnng5TF7ckn++ZI7/2jlyBHZrxgiXJS8p3jqK9cDpZHN1OEJv5tu019lKa5kxBo5H6BZe/UokP64lTew8xNIkA57UFm+tUGEXjzXAfYZAyNHdAGuG4sPalkyOtR/z5FUxwlLjE3ltYVHmMa2zl1KvVbgyrIzpubh7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUvUx7Cl; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e2378169a4so69501046d6.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860068; x=1741464868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+sHfABVNcOpkFnI0atmQ4P/qaUHSlV5OBnOnZJOtrk=;
        b=bUvUx7ClSBsxHAyzIR8gg20swkVovXcCvbmpOvUKZ2nDt0T9tUvUEPGXUmA78WlyPz
         +REuG45sYxorc6bZ8D1gJ8DmI/3Sw5vS93VwO/uYrahriHxmPcx+aOVJ+sTQtCBJ3F8J
         JzpGNY3g40PRXZg9K7biVHXoOkF4zpnYCj2Va+x3CAwQrHKBNptT/eAzAneRujaSxaab
         qtkaC7ufF1k8xnlIYbbOjtGHemsfk+tRj4FiS6B88bvB5bx/GM2Jt2XrReGdidUmBOQN
         ptZDbCZdeux6tBHfzjMEuXLn5d6Q2gI7bwgPLLUXHGgsi1YnsroChWjP07ipUKNr2keX
         LlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860068; x=1741464868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+sHfABVNcOpkFnI0atmQ4P/qaUHSlV5OBnOnZJOtrk=;
        b=FhsVSZtnf+IeZxQ6FpElaO5ND8cu/cd524ZnGjXpa9n623OSGaOIVkLsx8XThIXRpX
         25hqGav7Gi3c4wZB6EYyGLvVtqM6PPq+MN/AYsKTHXbO8Bjgd4DNbO4TDhVaZogTP6tx
         vtClDjAQy78+Am5SjCwHppbFMgDcX8sry5IbFoBMVRzuONaF9FTCTHFWydHIkzVl78P7
         DUlKA4h27GLxr45y5nKC7BxZg7yhAoIwvemSCxPGFRn760H6yR0HIijtYp6StV4AIOpL
         oLhvmOyrh2QYqYeMHgG1Z+IOBEXCCdI6tc6G905E/ZX9AyKx5dcVeoHql1RUqeY2gg9G
         IBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUfW2B1izdeh9IqigKCSMB9tWD3VF8l5UceDdUqZj1MntW5GAe1LPLXvWMmrc/msdW/jJWkBPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfyQv09KnmVV18ZczpXmanMbcaAm1/ww5MaN0chwxyFk2H2x3
	wcMfKiA1LzcF7CLLdP9x559a6tfna67+aSd8JoXxOqacmHOaOW57Z0ZUj5OSkGKnUbCYbYVXn4T
	+P+c3g6f7AQ==
X-Google-Smtp-Source: AGHT+IHvwiIsFODfxSLy5j6cIxrSIBGWL71eXs+PUcfIigp3QmReeaZoPOp0SVZY0Vrag1HeCSSvbe18yqCnew==
X-Received: from qtbhh4.prod.google.com ([2002:a05:622a:6184:b0:471:f1e9:e151])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2a8c:b0:6e6:61a5:aa4c with SMTP id 6a1803df08f44-6e8a0d6d798mr128658276d6.31.1740860068108;
 Sat, 01 Mar 2025 12:14:28 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:19 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/6] tcp: add a drop_reason pointer to tcp_check_req()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to add new drop reasons for packets dropped in 3WHS in the
following patches.

tcp_rcv_state_process() has to set reason to TCP_FASTOPEN,
because tcp_check_req() will conditionally overwrite the drop_reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h        | 2 +-
 net/ipv4/tcp_input.c     | 5 ++---
 net/ipv4/tcp_ipv4.c      | 3 ++-
 net/ipv4/tcp_minisocks.c | 3 ++-
 net/ipv6/tcp_ipv6.c      | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f9b9377a289740b907594a0993fc5d70ed36aaac..a9bc959fb102fc6697b4a664b3773b47b3309f13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -392,7 +392,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      u32 *tw_isn);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
-			   bool *lost_race);
+			   bool *lost_race, enum skb_drop_reason *drop_reason);
 enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 				       struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d22ad553b45b17218d5362ea58a4f82559afb851..4e221234808898131a462bc93ee4c9c0ae04309e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6812,10 +6812,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
 		    sk->sk_state != TCP_FIN_WAIT1);
 
-		if (!tcp_check_req(sk, skb, req, true, &req_stolen)) {
-			SKB_DR_SET(reason, TCP_FASTOPEN);
+		SKB_DR_SET(reason, TCP_FASTOPEN);
+		if (!tcp_check_req(sk, skb, req, true, &req_stolen, &reason))
 			goto discard;
-		}
 	}
 
 	if (!th->ack && !th->rst && !th->syn) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7900855237d929d8260e65fe95e367345bb3ecd2..218f01a8cc5f6c410043f07293e9e51840c1f1cb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2265,7 +2265,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			iph = ip_hdr(skb);
 			tcp_v4_fill_cb(skb, iph, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
+					    &drop_reason);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 29b54ade757231dc264fd8a2c357eff1b2ccbb6b..46c86c4f80e9f450834c72f28e3d16b0cffbbd1d 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -657,7 +657,8 @@ EXPORT_SYMBOL(tcp_create_openreq_child);
 
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req,
-			   bool fastopen, bool *req_stolen)
+			   bool fastopen, bool *req_stolen,
+			   enum skb_drop_reason *drop_reason)
 {
 	struct tcp_options_received tmp_opt;
 	struct sock *child;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index a806082602985fd351c5184f52dc3011c71540a9..d01088ab80d24eb0f829166faae791221d95bf9e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1828,7 +1828,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			hdr = ipv6_hdr(skb);
 			tcp_v6_fill_cb(skb, hdr, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
+					    &drop_reason);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
-- 
2.48.1.711.g2feabab25a-goog


