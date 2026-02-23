Return-Path: <netdev+bounces-260082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAFpFAdznGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:32:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2F178C29
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD823054CA3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279A2E9729;
	Mon, 23 Feb 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qe6fAumi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136A2E7635
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860651; cv=none; b=KHmnW/+7Lq4k0CNG5x2U/9eVje35c/nLoLN4JqBWSeWqwLQVWdzC8492YEPDZCWhEq3qtEPprJKwoi64YqUlNYWCOo7RlKjH32pe00QQPU/A3FNpzFH3ORFLmzkqayI4hzKOkZid+eXyPbkh6cFHXi1Wtuq/KbNBYQWCL23Udic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860651; c=relaxed/simple;
	bh=hEv4Ae+QEC6lKjEUUGAvjSgbTkL2q4XylaJ+Qi9wZHQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qv8DxGADWcCgA8s+ROojJpo4cFIhYQHe2g8C0K3DEourIQYD8GENhHHTT6PuYzpbUVxw6i0q3F8JYDGwgqL9cLzx246Z1etAUBDqO1mRbdrVTvdO8sPzXO0GKgV2dybgRc04wlxqn8oVspz05y78BStSZ6IOcUGrkm+RTxRSwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qe6fAumi; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70ef98116so4844295385a.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771860649; x=1772465449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvWeIEq2VU3ENK2aRvqCap/GrjJulMo8uDTfHsPk6iw=;
        b=qe6fAumiTJgSnBy6U7unkaBxYYH6GpmcDVUU4s7qDbRGra36cB0iFFnkQMpCiud8la
         w/iKAEa+qEr0YxyCnyJTb3NYRAQBqbZQoEJKwfpWqDLm2m3G1o+wAiYUOldIxvg5gX2q
         Izc/eZzhgYtgLiNIarIHZUlG/FD8hp0Yr6XQL7hO6aI7+ivhqvo5Zaq9t4m/nsKL+Dkb
         WCZEbiXVsA8Su80IwIl2jIGwr0xr9IjBAcfcSzFYcoPkTAL6sQn5WQ+kvX2RNFeNZsMi
         +GGNerJJ/0PENOpuCfQuTNK01lDvmnd8FF2VdQmg/j80ci1e+/g57ZN+ZysnRnpNFfSi
         YIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860649; x=1772465449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvWeIEq2VU3ENK2aRvqCap/GrjJulMo8uDTfHsPk6iw=;
        b=S/F0fkJ0mYL210/ixQ7O8hfCFlT9Vs5JkrqWtrjGVmpTaOZO1rzWU/zUVnvUHRv0fq
         YGXRvhKFbKYfa4sI4we59OgbYUErguSrQi2wIJKWwdPAftBEuLDcZ0+0P6DULKgdvaUO
         TcpN1r5DLi3NpW2BuXHvCLYuIKV60Jht8FX7nbyo5h5zJj7meXce1jgPyFWs4ZOBYKvh
         uuwW/iVjv1m6cn3iFK+tw6zAR8wYAdhfb9Qe1NzU3NmTMUF7k7tCxzE7oi97s9VjaglI
         OR9vqDGdvkuB4Iup7t+3V1I4rFr2X1Cv9sv9pv6GXECQt6usWAuq0s+PEpcAs+e/clAC
         KYJA==
X-Forwarded-Encrypted: i=1; AJvYcCWE3N9VzyRrbjsH1O7jrewgvpgzTzqRKmXyHxf/R7ilEkX25Cx68A1MGKufiwAIBz/Ux5payxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEcRKUtvXAW8sHnc5KLyA9GLIVUVXiLgug60qy3tSsFS/+4SN
	V6qOh+LSnqj7LXz84BMcCff0dDLEVD/2zkPjYtE/GykuGr8i3FDyGX5iPS4GErINMv2IfkfGNws
	LK4JC+3ozNhSg9Q==
X-Received: from qkbbq41.prod.google.com ([2002:a05:620a:46a9:b0:8c7:cb6:2f03])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:25ce:b0:8c6:a034:9224 with SMTP id af79cd13be357-8cb8ca72248mr1016764685a.47.1771860648450;
 Mon, 23 Feb 2026 07:30:48 -0800 (PST)
Date: Mon, 23 Feb 2026 15:30:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223153047.886683-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move inet6_csk_update_pmtu() to tcp_ipv6.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260082-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAC2F178C29
X-Rspamd-Action: no action

This function is only called from tcp_v6_mtu_reduced() and can be
(auto)inlined by the compiler.

Note that inet6_csk_route_socket() is no longer (auto)inlined,
which is a good thing as it is slow path.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1

add/remove: 0/2 grow/shrink: 2/0 up/down: 93/-129 (-36)
Function                                     old     new   delta
tcp_v6_mtu_reduced                           139     228     +89
inet6_csk_route_socket                       486     490      +4
__pfx_inet6_csk_update_pmtu                   16       -     -16
inet6_csk_update_pmtu                        113       -    -113
Total: Before=25076512, After=25076476, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet6_connection_sock.h |  4 +++-
 net/ipv6/inet6_connection_sock.c    | 19 ++-----------------
 net/ipv6/tcp_ipv6.c                 | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/inet6_connection_sock.h b/include/net/inet6_connection_sock.h
index ece8dabd209a5b2fb42ec88b9acbc81c01b4174e..b814e1acc512186108f500702836d98647cbd165 100644
--- a/include/net/inet6_connection_sock.h
+++ b/include/net/inet6_connection_sock.h
@@ -18,6 +18,9 @@ struct sk_buff;
 struct sock;
 struct sockaddr;
 
+struct dst_entry *inet6_csk_route_socket(struct sock *sk,
+					 struct flowi6 *fl6);
+
 struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 				      struct dst_entry *dst,
 				      struct flowi6 *fl6,
@@ -25,5 +28,4 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 
 int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
 
-struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu);
 #endif /* _INET6_CONNECTION_SOCK_H */
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 11fc2f7de2fe981ddb48dc008bf7fd4ae1e4e2f6..37534e1168992c44e1400dacab87e79d04c64a41 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -56,8 +56,8 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	return dst;
 }
 
-static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
-						struct flowi6 *fl6)
+struct dst_entry *inet6_csk_route_socket(struct sock *sk,
+					 struct flowi6 *fl6)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -118,18 +118,3 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 	return res;
 }
 EXPORT_SYMBOL_GPL(inet6_csk_xmit);
-
-struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu)
-{
-	struct flowi6 *fl6 = &inet_sk(sk)->cork.fl.u.ip6;
-	struct dst_entry *dst;
-
-	dst = inet6_csk_route_socket(sk, fl6);
-
-	if (IS_ERR(dst))
-		return NULL;
-	dst->ops->update_pmtu(dst, sk, NULL, mtu, true);
-
-	dst = inet6_csk_route_socket(sk, fl6);
-	return IS_ERR(dst) ? NULL : dst;
-}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d10487b4e5bff87d4ff2a7b912a826964101a163..010f3aa72499358a96327fcf096e7542bbb5cc81 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -349,6 +349,21 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return err;
 }
 
+static struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu)
+{
+	struct flowi6 *fl6 = &inet_sk(sk)->cork.fl.u.ip6;
+	struct dst_entry *dst;
+
+	dst = inet6_csk_route_socket(sk, fl6);
+
+	if (IS_ERR(dst))
+		return NULL;
+	dst->ops->update_pmtu(dst, sk, NULL, mtu, true);
+
+	dst = inet6_csk_route_socket(sk, fl6);
+	return IS_ERR(dst) ? NULL : dst;
+}
+
 static void tcp_v6_mtu_reduced(struct sock *sk)
 {
 	struct dst_entry *dst;
-- 
2.53.0.345.g96ddfc5eaa-goog


