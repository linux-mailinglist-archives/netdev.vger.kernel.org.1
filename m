Return-Path: <netdev+bounces-246968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D0CF2F35
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942623006F40
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DC27EFFA;
	Mon,  5 Jan 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEBxIm0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8210E3
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608243; cv=none; b=GcsOTqQE6eOVx7acnStI8RJGyT6dUe9jQzS34O8GcwUJ+09mOUmVrio6XyAedOUKNSeLZpddqcS4OvnGMR+haUvYxlJMgiVea20VdUqZQnTiBbEbjG4qDAVkv0DjbXPzGM+kLYQEahn8uJJokUcR7UZI9sijIVe1A3eWFzV8BHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608243; c=relaxed/simple;
	bh=LNkfbd9VCqqeFgaiMTX7p+FvdA8G0VgjLLy46Y+45rs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AaPgBYyG+haQysphnJSwDS2TIv1+2ogmuFIu+9SZWZsIBhxKxPP7QRRZ9obhBBDVn3kp9DFyrmz8blqiHA2DPnfECvQaKYEZ5MNlOvIFX8faGOgkbx+jdBnvik4KAeCfGSRyRCgTw0ACQw5XvfpMZ+y8AJpnGxVfcXwKQ/R+QuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEBxIm0H; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b51396f3efso2766854085a.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767608241; x=1768213041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3Y8ZU9lgk5CdGQQ/4sOYiFI8JZxPFhJB7GuY6YLGpQ=;
        b=fEBxIm0H+k3cOk/1MkfrgT/HZ2+tMi2HCefhXWgmKRx4N2/qAzQt0T/7SgRjPynoTj
         DA8Uzoa9XhfaWIlxYUVORbjDOmfBNpJrKvqrpGDh14PTNEFBd+4Qm3MLclfuW7prvV2w
         Bd1UCKLRlOa3QAPJpgTEVZM6cT16NnsFoD3pce3cC8uTVTkrn4aR1RSxpMcCGTjJDMUq
         Oys5J7DT3YsPNPumOqmeI6zFanmz6XMGTRSmV7ml//BiK3vBR5jn/XfKLaRI1qYdamhT
         J51mnEbutd4hFEJjSai96y4llFpVMVImE+HjmkghKlnn7UUbetRBvt8JmiIVP1hY3wiB
         rBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608241; x=1768213041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3Y8ZU9lgk5CdGQQ/4sOYiFI8JZxPFhJB7GuY6YLGpQ=;
        b=rjiAA7MyTu6e1T16DOepT18J993m4e7ANh2WbomKNhazjBsn8RsBLuelvpP06p1Mq9
         r8OjJwr7snPBgeeJsGPdnZelEoa5bMNd9jdJ7WpZUJkr409nWf/lmiYkuXONbrjGEwsg
         isEppgydF5GNZ86DUWcTkUt6vyvGs+KnMxbjKVM+OwikRvviqwv5sIurdLpnGmXpSfon
         4HM4bQm23jGKd8g3YoSo0MKKmlUYvYwnRDyah6dx+1cOGdSEqXPj4JWNwc0BETwTkQs7
         GV8AiKvDPpqnX0XOXhgR5W36gUU234pXhPrXlP1Qwcat3l7OC6C6q9yQ+zT/EF93+Bq7
         wl3g==
X-Forwarded-Encrypted: i=1; AJvYcCVlSYwgrjO3uoszYVO4sHbd2zlrcYqB9SHb0zmTzQQO7bC73IpFZHVSUzwIW4k8QqTd8+tURhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CYXELe/5oVk9vUFC628fl4pKr3u0lyRntV90+TFSKfouK8ZX
	rxUdmWHElsqi6L+r4RxNAIZuSJW+HAbgmupSyYR6P/5h8PZRrLuLjbPGuS9tR1aZx7Q0hVt0h2k
	Cll7PZ1/7jvXWWg==
X-Google-Smtp-Source: AGHT+IG3C0A/A7TgX3U4CL/go+KpcHfdJTazloF1k6GDd+JiL6rD4h6+o1J07BVZnSpOxwAE0wu5TL17rQt1SA==
X-Received: from qkho17.prod.google.com ([2002:a05:620a:2291:b0:8b2:f6c0:7162])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1901:b0:8be:64e5:52ab with SMTP id af79cd13be357-8c08fab3c80mr6748573785a.60.1767608240820;
 Mon, 05 Jan 2026 02:17:20 -0800 (PST)
Date: Mon,  5 Jan 2026 10:17:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105101719.2378881-1-edumazet@google.com>
Subject: [PATCH net-next] udp: udplite is unlikely
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add some unlikely() annotations to speed up the fast path,
at least with clang compiler.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 2 +-
 include/net/udp.h   | 8 ++++----
 net/ipv4/udp.c      | 5 +++--
 net/ipv6/udp.c      | 5 +++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 58795688a186..1cbf6b4d3aab 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -236,7 +236,7 @@ static inline void udp_allow_gso(struct sock *sk)
 	hlist_nulls_for_each_entry_rcu(__up, node, list, udp_lrpa_node)
 #endif
 
-#define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
+#define IS_UDPLITE(__sk) (unlikely(__sk->sk_protocol == IPPROTO_UDPLITE))
 
 static inline struct sock *udp_tunnel_sk(const struct net *net, bool is_ipv6)
 {
diff --git a/include/net/udp.h b/include/net/udp.h
index a061d1b22ddc..700dbedcb15f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -527,18 +527,18 @@ static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
  * 	SNMP statistics for UDP and UDP-Lite
  */
 #define UDP_INC_STATS(net, field, is_udplite)		      do { \
-	if (is_udplite) SNMP_INC_STATS((net)->mib.udplite_statistics, field);       \
+	if (unlikely(is_udplite)) SNMP_INC_STATS((net)->mib.udplite_statistics, field);	\
 	else		SNMP_INC_STATS((net)->mib.udp_statistics, field);  }  while(0)
 #define __UDP_INC_STATS(net, field, is_udplite) 	      do { \
-	if (is_udplite) __SNMP_INC_STATS((net)->mib.udplite_statistics, field);         \
+	if (unlikely(is_udplite)) __SNMP_INC_STATS((net)->mib.udplite_statistics, field);	\
 	else		__SNMP_INC_STATS((net)->mib.udp_statistics, field);    }  while(0)
 
 #define __UDP6_INC_STATS(net, field, is_udplite)	    do { \
-	if (is_udplite) __SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);\
+	if (unlikely(is_udplite)) __SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);	\
 	else		__SNMP_INC_STATS((net)->mib.udp_stats_in6, field);  \
 } while(0)
 #define UDP6_INC_STATS(net, field, __lite)		    do { \
-	if (__lite) SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);  \
+	if (unlikely(__lite)) SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);	\
 	else	    SNMP_INC_STATS((net)->mib.udp_stats_in6, field);      \
 } while(0)
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5865..a5b9de2bd1a3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1193,7 +1193,7 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 
 send:
 	err = ip_send_skb(sock_net(sk), skb);
-	if (err) {
+	if (unlikely(err)) {
 		if (err == -ENOBUFS &&
 		    !inet_test_bit(RECVERR, sk)) {
 			UDP_INC_STATS(sock_net(sk),
@@ -2428,7 +2428,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * 	UDP-Lite specific tests, ignored on UDP sockets
 	 */
-	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+	if (unlikely(udp_test_bit(UDPLITE_RECV_CC, sk) &&
+		     UDP_SKB_CB(skb)->partial_cov)) {
 		u16 pcrlen = READ_ONCE(up->pcrlen);
 
 		/*
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 794c13674e8a..010b909275dd 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -875,7 +875,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * UDP-Lite specific tests, ignored on UDP sockets (see net/ipv4/udp.c).
 	 */
-	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+	if (unlikely(udp_test_bit(UDPLITE_RECV_CC, sk) &&
+		     UDP_SKB_CB(skb)->partial_cov)) {
 		u16 pcrlen = READ_ONCE(up->pcrlen);
 
 		if (pcrlen == 0) {          /* full coverage was set  */
@@ -1439,7 +1440,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 
 send:
 	err = ip6_send_skb(skb);
-	if (err) {
+	if (unlikely(err)) {
 		if (err == -ENOBUFS && !inet6_test_bit(RECVERR6, sk)) {
 			UDP6_INC_STATS(sock_net(sk),
 				       UDP_MIB_SNDBUFERRORS, is_udplite);
-- 
2.52.0.351.gbe84eed79e-goog


