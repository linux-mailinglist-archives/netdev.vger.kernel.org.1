Return-Path: <netdev+bounces-257634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIpTAHYmhmlSKAQAu9opvQ
	(envelope-from <netdev+bounces-257634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4308101249
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D2C43012403
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5E4219EA;
	Fri,  6 Feb 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qah+xgu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6004266A8
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399291; cv=none; b=L+gKf4GKy7tBHNz6NvpBamUQQoSO8Sj5cJye6EwHeVpy3792wwvd3rOHvkadSqryPyILZ+kREalsOUydWJwZiCksIECtXpYd99gzjy8bho8kVZiC34kkrZFZPkPxO/A45lUd4ybP3pZTJcfGz5Q21o5uT/Biv0QEvwOmxtcSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399291; c=relaxed/simple;
	bh=Iu3Uo2wVccjCY6dfztQhHvxXwAv6xrp4uBi6rMO9beo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oYX3/IDfxx7WuxuKzpRCXTCDc1PmJY1A5jwJ/F+GSc26Ir+J0LFKA1z2CPjHUyIlsOYAbLRuIcSt8vzxhXMSW4+jiDpMmf2e9gaEkA9b40PHRy6FiJVLxufyMuI0vOT18N+WWnBfwdexFYukxwwPo86KDFvM8ixXsXfc43IOuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qah+xgu3; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71304beb4so549314185a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399290; x=1771004090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixmsrO0HsEul4lWE5PgZWElbiGOroMq6IFAx3dRlQbE=;
        b=qah+xgu3IaAjTfqzoUtYuBVKzvBsag6QYXjBVb+6q9P+h67jCB5LKX1tJAy+kDJlAW
         WIEdYkNNDUxyLsxhdKlY3gxmKPlhcyocFQ0p0O4AEaassXKoYu/hcuJbYaZtGuHSCJg8
         K8uhg7KNIVvqM93WouwQmVZcm3/Ghy0VAupgqPPdVmFfPR2wuyt13W9FhDcY4L04Uivt
         ClNorMbnZ5kCYQ3m3cON70IBuZm++n0Q1byA9X0tFG55f47CmJj3P7PBD43MJ3EVOlSr
         Ov4wC25/iChCFG+kPyIWuHv35km6WBbTlf4EX21bifrALnCnfcOP9ZspZ3pEeLH/JOKH
         V3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399290; x=1771004090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixmsrO0HsEul4lWE5PgZWElbiGOroMq6IFAx3dRlQbE=;
        b=GFhkjYn/wCLB3FNpQBOMZ84zFw9npkemhhRqnVmCaOLX8GMtnZu+e+//HFvLfqjKJT
         N4eXZmvnEnCqFYdcczm81t0bY+dV5NaJTDeq4Bmy38p/VJtH3HFjLZobOZkK1LmBT3Jv
         RXe45iHfTWZhXXoBHg0evbYhE+2x2CQ89oB2yGcsDTjXd6/MFI0kYBtNXWMdVu4xaG4K
         /WVR0lEqBY8Gx/yvLtD9mhI/XA8Do/RGyevzjTD2iWYlFfN+De2iF9ACpn3ywrcLxu2t
         ZsznwDUVwGZSTswfFca7f4zah/aGby5CumCfJxSRA9k3Ga+Xn8KRRN5b6S1O0CZ1q1bw
         eGjg==
X-Forwarded-Encrypted: i=1; AJvYcCWotjPQnAsL1JKrqSwEnhyWtBKp4TTXD33yXs5a5YDEr43Z1l5SUvhMJcAos9Bm/On3IIvR3C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PEv/pSpHV4/m5JCptw9kTx4xDxew1XV3j7hIJ8lXNfNS7MQS
	f+yB917EUcRRu++ErPSPMaEdEubgjoc4HBWJfXO1MqPYgNuoSdK8fwZZO0lj4i9yPL8Bda1F+eM
	V0MrE4VLtk2nXGA==
X-Received: from qkaj24.prod.google.com ([2002:a05:620a:a58:b0:8b2:e1db:dc74])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3f85:b0:8c6:ed3d:be60 with SMTP id af79cd13be357-8caf15efe25mr470260685a.71.1770399290269;
 Fri, 06 Feb 2026 09:34:50 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:25 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-7-edumazet@google.com>
Subject: [PATCH net-next 6/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_syn_recv_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4308101249
X-Rspamd-Action: no action

As explained in commit 85d05e281712 ("ipv6: change inet6_sk_rebuild_header()
to use inet->cork.fl.u.ip6"):

TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
transmit in inet6_csk_xmit()/inet6_csk_route_socket().

TCP v4 caches the information in inet->cork.fl.u.ip4 instead.

After this patch, passive TCP ipv6 flows have correctly initialized
inet->cork.fl.u.ip6 structure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet6_connection_sock.h |  4 +++-
 net/ipv6/inet6_connection_sock.c    | 11 ++++++-----
 net/ipv6/tcp_ipv6.c                 | 17 ++++++++---------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/inet6_connection_sock.h b/include/net/inet6_connection_sock.h
index 745891d2e113707f5c2329cc4c4b14b55c0c7400..ece8dabd209a5b2fb42ec88b9acbc81c01b4174e 100644
--- a/include/net/inet6_connection_sock.h
+++ b/include/net/inet6_connection_sock.h
@@ -18,7 +18,9 @@ struct sk_buff;
 struct sock;
 struct sockaddr;
 
-struct dst_entry *inet6_csk_route_req(const struct sock *sk, struct flowi6 *fl6,
+struct dst_entry *inet6_csk_route_req(const struct sock *sk,
+				      struct dst_entry *dst,
+				      struct flowi6 *fl6,
 				      const struct request_sock *req, u8 proto);
 
 int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 03e307d5b6b9a2085b1e6b3e3c743795aa16879c..b6c4123aa0aeb803afdf807d8683156b710df2f6 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -25,6 +25,7 @@
 #include <net/sock_reuseport.h>
 
 struct dst_entry *inet6_csk_route_req(const struct sock *sk,
+				      struct dst_entry *dst,
 				      struct flowi6 *fl6,
 				      const struct request_sock *req,
 				      u8 proto)
@@ -32,7 +33,6 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	const struct inet_request_sock *ireq = inet_rsk(req);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *final_p, final;
-	struct dst_entry *dst;
 
 	memset(fl6, 0, sizeof(*fl6));
 	fl6->flowi6_proto = proto;
@@ -48,10 +48,11 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
-	if (IS_ERR(dst))
-		return NULL;
-
+	if (!dst) {
+		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+		if (IS_ERR(dst))
+			return NULL;
+	}
 	return dst;
 }
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0fbcb39b3aa709e936a518865e2d16c4027081dd..d10487b4e5bff87d4ff2a7b912a826964101a163 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -539,7 +539,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 	u8 tclass;
 
 	/* First, grab a route. */
-	if (!dst && (dst = inet6_csk_route_req(sk, fl6, req,
+	if (!dst && (dst = inet6_csk_route_req(sk, NULL, fl6, req,
 					       IPPROTO_TCP)) == NULL)
 		goto done;
 
@@ -789,7 +789,7 @@ static struct dst_entry *tcp_v6_route_req(const struct sock *sk,
 	if (security_inet_conn_request(sk, skb, req))
 		return NULL;
 
-	return inet6_csk_route_req(sk, &fl->u.ip6, req, IPPROTO_TCP);
+	return inet6_csk_route_req(sk, NULL, &fl->u.ip6, req, IPPROTO_TCP);
 }
 
 struct request_sock_ops tcp6_request_sock_ops __read_mostly = {
@@ -1318,12 +1318,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 					 struct request_sock *req_unhash,
 					 bool *own_req)
 {
-	struct inet_request_sock *ireq;
-	struct ipv6_pinfo *newnp;
 	const struct ipv6_pinfo *np = tcp_inet6_sk(sk);
+	struct inet_request_sock *ireq;
 	struct ipv6_txoptions *opt;
 	struct inet_sock *newinet;
 	bool found_dup_sk = false;
+	struct ipv6_pinfo *newnp;
 	struct tcp_sock *newtp;
 	struct sock *newsk;
 #ifdef CONFIG_TCP_MD5SIG
@@ -1392,11 +1392,9 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	if (sk_acceptq_is_full(sk))
 		goto exit_overflow;
 
-	if (!dst) {
-		dst = inet6_csk_route_req(sk, &fl6, req, IPPROTO_TCP);
-		if (!dst)
-			goto exit;
-	}
+	dst = inet6_csk_route_req(sk, dst, &fl6, req, IPPROTO_TCP);
+	if (!dst)
+		goto exit;
 
 	newsk = tcp_create_openreq_child(sk, req, skb);
 	if (!newsk)
@@ -1412,6 +1410,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	newinet = inet_sk(newsk);
+	newinet->cork.fl.u.ip6 = fl6;
 	newinet->pinet6 = tcp_inet6_sk(newsk);
 	newinet->ipv6_fl_list = NULL;
 	newinet->inet_opt = NULL;
-- 
2.53.0.rc2.204.g2597b5adb4-goog


