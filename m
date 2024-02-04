Return-Path: <netdev+bounces-68911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BD848CF0
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008BDB22204
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25201B7FE;
	Sun,  4 Feb 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIbGL5n7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D52206D
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043586; cv=none; b=mHCFeZ7GJh/AZxb9eNYYYBe0NcUpbAHQ1Ohg0MYeXJDCHr9YYlIW+1ol0EUgIHk3YpwETjTuFZLEp60NIsMNxK/7DMNSXKt4dsO8kFjD3qRQYqvPt5EzjGnBqTjk+1JvYYWjDuls+/O9GhuVfHvo+F1QQ50I09yDtcILefqM7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043586; c=relaxed/simple;
	bh=wC2c1rER5sPvbea8MZA733oMmJucQ4DxsCXxKt8skYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dqlL72KRXg86TzFhKaSUQVVTTyI3Wz4FaTnpcr8gICX3l9XYXH44TbCNp2Rmk1mbx0krF7QVLb/7naA+JcyJImpcbgEWu4WuoAMUv2hlzB39sv3MlztN5mgFr+MzvEXjKKutaPRN0CSAiQuH9uPsHpzOVUUkQ87uxrt3Jd/XktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIbGL5n7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3266445a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707043584; x=1707648384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5CtxJG7CfG2KPK2uOaftVBppm910I8+3fU0rCDi4aU=;
        b=IIbGL5n7J3+eh+qkBl2Ib+ZSJZSCfFrnX0Kzww+BqiZDIX+3CJbvyq6i9B/CIlgRH9
         UdfnxndJWJWAiocEsq75Rwkb8jOKzdGJeok50bmGSb2poJBClfI30c3Y67n+5/9gsSo0
         KFM0yzgCoCcs1gBrvxxcoxuxVmsQP2YSSaF6KrSPvbfGjbL0QH5e928J8hoF2kvJwiuX
         fA+aCpLX8CRCTCiN0S04TEMN5fRqG4IPAJo0ZtrERKbnPdI4pQJ9XiFQwZ4x9ihIA1a7
         a9PHjG1nfkFAJHZS+WGlkCz6EImXk7qc7ugUo5Kg8tooSQR0qripMlZ2TR0zrFVZcXxN
         q0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043584; x=1707648384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5CtxJG7CfG2KPK2uOaftVBppm910I8+3fU0rCDi4aU=;
        b=dCTKYHaDmh6ypVnt8peRRUeGkkCQ21UAzczKTb/vvqLW3SIgctNuvW2X9FcUPLtjjU
         2LvytY6Psfa8f5lOvdy4nHDP4LhvMKnEeoWcvweS42qZ867ILr3MS/OC6k0s2S45zkk+
         tdIHyQWAeiu/8i8ld6MFYJL/1r1ZmKPQ3J/oTJmdJ1dJBu+x7+5vVkbVUsClm/ohOx9x
         m6ITrsDljwZDHrNYZ7+9/0CkNdFAwdmwAQfqJzvbroGULAS4va8uuf2E3UBvbYVn2bTJ
         noMl7KiOBVza851iWKfpc86jFRop+Eu6SBGU6Ag8xMa2GkaSGqlU2kCAUv53LoUklINa
         mqMA==
X-Gm-Message-State: AOJu0Yyae78ihOdoybeB6NO8Ekn67YecSXAO7SU2CiLz5Nu43YoNpK0i
	yOldPHEj1dKeZ2N4TYdm/OYXrHnBzs5D8fhxstlIFIiNmcixV2cB
X-Google-Smtp-Source: AGHT+IFGU1HB840FmlQs6peTmSn+tBMBEcEViWj4Agtv31ottkRx6Kk+CJG7QY3ov2uR0TvH8vr3nQ==
X-Received: by 2002:a05:6a00:1805:b0:6d9:bc67:8c6 with SMTP id y5-20020a056a00180500b006d9bc6708c6mr14076536pfa.8.1707043584231;
        Sun, 04 Feb 2024 02:46:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX15DUQzSN2ldPe/fXg0MS/2rF54zciAjHtSE4RT13j8qeDhPDpVSsd73oBC/MkW0Gbl1s5SXV2NWD2HeN6pmPvUKl61rqasRPOrC+m/IMV8sRfgJrrKd368XUxi3TVIzIbsp/h1fnQJIsF6irfjJweA4u0dqrrjtfbQHqi4flCPp7iKSPOuaIgl5KXAdkZUsVektLwkfL86g/Wgyj0ZLuXpQk54HwoR7DItyWtGbQ=
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b006dd79bbcd11sm327099pfo.205.2024.02.04.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:46:23 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] tcp: add more DROP REASONs in cookie check
Date: Sun,  4 Feb 2024 18:45:59 +0800
Message-Id: <20240204104601.55760-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240204104601.55760-1-kerneljasonxing@gmail.com>
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since the commit 8eba65fa5f06 ("net: tcp: use kfree_skb_reason() for tcp_v{4,6}_do_rcv()")
introduced the drop reason mechanism, this function is always using
NOT_SPECIFIED which is too general and unhelpful to us if we want to track
this part.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h | 12 ++++++++++++
 include/net/tcp.h             |  3 ++-
 net/ipv4/syncookies.c         | 18 ++++++++++++++----
 net/ipv4/tcp_ipv4.c           |  7 ++++---
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..85a19b883dee 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,6 +6,7 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(NO_REQSK_ALLOC)			\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(SOCKET_FILTER)		\
@@ -43,10 +44,12 @@
 	FN(TCP_FASTOPEN)		\
 	FN(TCP_OLD_ACK)			\
 	FN(TCP_TOO_OLD_ACK)		\
+	FN(COOKIE_NOCHILD)		\
 	FN(TCP_ACK_UNSENT_DATA)		\
 	FN(TCP_OFO_QUEUE_PRUNE)		\
 	FN(TCP_OFO_DROP)		\
 	FN(IP_OUTNOROUTES)		\
+	FN(IP_ROUTEOUTPUTKEY)		\
 	FN(BPF_CGROUP_EGRESS)		\
 	FN(IPV6DISABLED)		\
 	FN(NEIGH_CREATEFAIL)		\
@@ -54,6 +57,7 @@
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
 	FN(TC_EGRESS)			\
+	FN(SECURITY_HOOK)			\
 	FN(QDISC_DROP)			\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
@@ -107,6 +111,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NOT_SPECIFIED,
 	/** @SKB_DROP_REASON_NO_SOCKET: socket not found */
 	SKB_DROP_REASON_NO_SOCKET,
+	/** @SKB_DROP_REASON_NO_REQSK_ALLOC: request socket allocation failed */
+	SKB_DROP_REASON_NO_REQSK_ALLOC,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
@@ -243,6 +249,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OLD_ACK,
 	/** @SKB_DROP_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
 	SKB_DROP_REASON_TCP_TOO_OLD_ACK,
+	/** @SKB_DROP_REASON_COOKIE_NOCHILD: no child socket in cookie mode */
+	SKB_DROP_REASON_COOKIE_NOCHILD,
 	/**
 	 * @SKB_DROP_REASON_TCP_ACK_UNSENT_DATA: TCP ACK for data we haven't
 	 * sent yet
@@ -254,6 +262,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OFO_DROP,
 	/** @SKB_DROP_REASON_IP_OUTNOROUTES: route lookup failed */
 	SKB_DROP_REASON_IP_OUTNOROUTES,
+	/** @SKB_DROP_REASON_IP_ROUTEOUTPUTKEY: route output key failed */
+	SKB_DROP_REASON_IP_ROUTEOUTPUTKEY,
 	/**
 	 * @SKB_DROP_REASON_BPF_CGROUP_EGRESS: dropped by BPF_PROG_TYPE_CGROUP_SKB
 	 * eBPF program
@@ -271,6 +281,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NEIGH_DEAD,
 	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
 	SKB_DROP_REASON_TC_EGRESS,
+	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
+	SKB_DROP_REASON_SECURITY_HOOK,
 	/**
 	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
 	 * failed to enqueue to current qdisc)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..e3b07d2790c4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -492,7 +492,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
 				 struct dst_entry *dst);
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
-struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
+struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb,
+				 enum skb_drop_reason *reason);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct sock *sk, struct sk_buff *skb,
 					    struct tcp_options_received *tcp_opt,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..9febad3a3150 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -395,7 +395,8 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
  * Output is listener if incoming packet would not create a child
  *           NULL if memory could not be allocated.
  */
-struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
+struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb,
+					     enum skb_drop_reason *reason)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -420,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		*reason = SKB_DROP_REASON_NO_REQSK_ALLOC;
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
@@ -433,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		*reason = SKB_DROP_REASON_SECURITY_HOOK;
 		goto out_free;
+	}
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -451,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		*reason = SKB_DROP_REASON_IP_ROUTEOUTPUTKEY;
 		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -477,6 +484,9 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	else
+		*reason = SKB_DROP_REASON_COOKIE_NOCHILD;
+
 out:
 	return ret;
 out_free:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..b63b0efa111d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1846,13 +1846,14 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(tcp_v4_syn_recv_sock);
 
-static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb)
+static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb,
+			 enum skb_drop_reason *reason)
 {
 #ifdef CONFIG_SYN_COOKIES
 	const struct tcphdr *th = tcp_hdr(skb);
 
 	if (!th->syn)
-		sk = cookie_v4_check(sk, skb);
+		sk = cookie_v4_check(sk, skb, reason);
 #endif
 	return sk;
 }
@@ -1912,7 +1913,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		goto csum_err;
 
 	if (sk->sk_state == TCP_LISTEN) {
-		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
+		struct sock *nsk = tcp_v4_cookie_check(sk, skb, &reason);
 
 		if (!nsk)
 			goto discard;
-- 
2.37.3


