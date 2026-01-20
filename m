Return-Path: <netdev+bounces-251486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EfkC4BYcGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7A511BB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04CE06C00E4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA3423A83;
	Tue, 20 Jan 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agMfH8Lp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEB426D3B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913639; cv=none; b=D9ak6QK5Zjdq0f/HWDlxI4fDO2I5r+fzXgB89m0ylrRM++ELN18mGwZSRtwElAZ9dLOqvDZoytqUT/FGrffS3AOTgrPIXi9M+t5NvIACnwlJgjNcuCU4iSzKEZ8J6ybefHTz3t5R/bP6t/qfDF9UJiQvVErKv1m40/6jUapQceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913639; c=relaxed/simple;
	bh=akqPmZbslxK3v6B6N7hcN3n72o0bCdhIhzOGh8bdL00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u3wSrQ/gWRQVacFkaYGqtPk/OwFgvmSelQ3zG4U3d4mI03/kPzPuKiBnTwggjWu0fuTmb6G5w1jbh3xqYtQceehPJojtJavSQmX++LEi85Cn1LC2AB2a10xv0ne7EjPo0aPio4Dg/7CArhhShEpTfoC1PRzhZHrY6DtABxuJnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agMfH8Lp; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c5296c7e57so1842298185a.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768913637; x=1769518437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LpZRIjqwYPfLxpQ9klxzvVdDpZhoc12Yd4NuHBr3Awk=;
        b=agMfH8LpYOqzR//jgt9jf5q/HVPyhWATNNPGUrE7vCp6tpYuj9mQGFHwSthIPKjemr
         JfS83cGJp/UoPS6rQLgcTr9NGfaCLQjUXtyp3Q68JV61AHyfFM6nHj8RToQpJKFADgU7
         OsjTsaG/6E4rkfL84/kuA/pT4xwqcfhH3H1sQZGImKtaCPlMfl/nraM38Y8CohzXiKoe
         kSyBkfXARZEJhIl66GfUHHzemP63CLVrA1hxeQH7RrERO5OWg7t2hPqiaizmDmY9IjBH
         nyf9Vd8dH3DyVBwc5a1oslZC1TCCIAyRF4oBpyp1bnqr/Guv5YBgw7O2EY6bhsHStqBk
         i21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913637; x=1769518437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpZRIjqwYPfLxpQ9klxzvVdDpZhoc12Yd4NuHBr3Awk=;
        b=ugR9qLwMhHfz6sbAPpcr3fML2hPLjX3hMxsJ31BAt8KSenEA7TrGF2VH+BXGuAymYe
         GxTSeZx3NPEhQdFncueINk2Y0GWkJwzGklA40DO8KH72Dk0khWS9iE+a/KjqWsxHfeIh
         bmmYb/54zeWCWe07yQOf3CgTMpdNkKaxZ3sygSQ2WtY+RZE0igz9K8C6wxh6Qv2dzSpN
         lvrB41JLnhpoYUTVSzNYpJ5ldKXYbsSQvWlJxTZtQNqA0dCBUV+mZdymFNBPrITt8Q0B
         3oiLjEcgk79W7bLK7VR4K6y6t0URWCUMb6YS9qtFOEICTp1nvODR06pFIezUg4J3o5WD
         9INw==
X-Forwarded-Encrypted: i=1; AJvYcCU4c1dXpCQkbzHSSFtw4ccGdpEf55zmvvk8iwQ9uLVkEpDcL/IGr4fbXQHBB2fbDBgtswLPu6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCMbfJ2sa08BC0+h9p32QDmszvik7YHcem1krJeIpNsNgcm8m
	SFfP9wCNGP23Bm0B8H9Sxuh52s1Q8osBWdanve3P0o8X/VslB5f1XxRCoTp4x6L59YRxgL2I/HG
	SMm0qRrJjlVEA/Q==
X-Received: from qvblx4.prod.google.com ([2002:a05:6214:5f04:b0:88f:cd60:3578])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4482:b0:8b5:5a33:22d2 with SMTP id af79cd13be357-8c6a69560a8mr1830452685a.46.1768913636688;
 Tue, 20 Jan 2026 04:53:56 -0800 (PST)
Date: Tue, 20 Jan 2026 12:53:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120125353.1470456-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: preserve const qualifier in tcp_rsk() and inet_rsk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251486-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E3F7A511BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We can change tcp_rsk() and inet_rsk() to propagate their argument
const qualifier thanks to container_of_const().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h              | 5 +----
 include/net/inet_sock.h          | 5 +----
 include/trace/events/tcp.h       | 2 +-
 net/ipv4/inet_connection_sock.c  | 2 +-
 net/ipv6/inet6_connection_sock.c | 2 +-
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef36984810541a06fcb7ba8f0c45b1..367b491ddf978061d5a88ab02546ec99be1cca63 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -181,10 +181,7 @@ struct tcp_request_sock {
 #endif
 };
 
-static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
-{
-	return (struct tcp_request_sock *)req;
-}
+#define tcp_rsk(ptr) container_of_const(ptr, struct tcp_request_sock, req.req)
 
 static inline bool tcp_rsk_used_ao(const struct request_sock *req)
 {
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 3370159556b8602d1ceef06c0c742479452602df..903b2263ec8031565990dc52b921352e6a642b1a 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -100,10 +100,7 @@ struct inet_request_sock {
 	};
 };
 
-static inline struct inet_request_sock *inet_rsk(const struct request_sock *sk)
-{
-	return (struct inet_request_sock *)sk;
-}
+#define inet_rsk(ptr) container_of_const(ptr, struct inet_request_sock, req)
 
 static inline u32 inet_request_mark(const struct sock *sk, struct sk_buff *skb)
 {
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 6757233bd0641778ce3ee260c9d757070adc0fcf..f155f95cdb6e910b8718e11d32d150cff8de3266 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -305,7 +305,7 @@ TRACE_EVENT(tcp_retransmit_synack,
 	),
 
 	TP_fast_assign(
-		struct inet_request_sock *ireq = inet_rsk(req);
+		const struct inet_request_sock *ireq = inet_rsk(req);
 		__be32 *p32;
 
 		__entry->skaddr = sk;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 97d57c52b9ad953d7ec1ad679237b5d122f47470..13372d2cbed53e83510e24a34bc57c7de0a17004 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1196,7 +1196,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 {
 	struct sock *newsk = sk_clone_lock(sk, priority);
 	struct inet_connection_sock *newicsk;
-	struct inet_request_sock *ireq;
+	const struct inet_request_sock *ireq;
 	struct inet_sock *newinet;
 
 	if (!newsk)
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index ea5cf3fdfdd648e43f4c53611f61509ce06d4cf8..3aedd51c9bdb18b3b45ff3f6b56666e2ffd1f515 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -29,7 +29,7 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 				      const struct request_sock *req,
 				      u8 proto)
 {
-	struct inet_request_sock *ireq = inet_rsk(req);
+	const struct inet_request_sock *ireq = inet_rsk(req);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *final_p, final;
 	struct dst_entry *dst;
-- 
2.52.0.457.g6b5491de43-goog


