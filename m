Return-Path: <netdev+bounces-68912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522C848CF1
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC681F2207D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27F210E9;
	Sun,  4 Feb 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it3VhGxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD0219E0
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043592; cv=none; b=GUgfVDUuqpBAcKAmwOniWpxNh7wowo/xamVGDxSTcwW3xC+ZUelafVnhZOo+kr0teVxDaX3I6FMTRvPjGCzbYELRWdf6zjiXEy505RR7Akqi6L13lmTiNr6RoCPgO+JnXJ9iXZBqrG+JwrTpD05O92nPcNznKdxs4NOoiE/nMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043592; c=relaxed/simple;
	bh=wC2c1rER5sPvbea8MZA733oMmJucQ4DxsCXxKt8skYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPyBpGP+P/lp77mfvayLAHY+5iKYaYcldxKhASlqOsNT2I+6tyhMNy80I5oIz9Isvysi39yuczcTkciUOjx5OvIDCHfrAwHSzCNvfKEwhVtq8WygHdE2d1cme2EtcDIxqZLtrGyLJcjiYP43bg8yH9qV+Nfar8m5LWd/2dELKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it3VhGxp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e02597a0afso912584b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707043590; x=1707648390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5CtxJG7CfG2KPK2uOaftVBppm910I8+3fU0rCDi4aU=;
        b=it3VhGxp+v1KDeL6J6CEv8JFtmrnPG510OZ1iG2z+VdRlDtalt7uH3cel49RCK7oLp
         dfCUIt7B3qrqZ05gsvFNX5MzJGigb39IxWMuCHT6ItuhmS1Yw3Z64cARODSTgyll7WXR
         JoFLMOiR5jt62b0USF8JXGyoMeRlOLcBdTFtNJau9YHfYzcKhzfLVQ1/aphbGAmCDsVy
         SDWAGtqbMfyWtZXpIviz0k96nzjkLdyaS2UPgAxlG9EvkiTPkwE6PUAi/YQivViPIrkz
         ia8EH5Jw8U0vReYC1vFNY4EpJ2useaLze5l5/RYDK5zOHHxFK+W73QXIqpPJjjdWT+6Z
         Mkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043590; x=1707648390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5CtxJG7CfG2KPK2uOaftVBppm910I8+3fU0rCDi4aU=;
        b=VveEOxz8qW2fWIg4hb4NptE3fl2lpqk0XPiB9d8I0DPNEzuKF8/CjG+gzh56nWnnmz
         YskkW0oeGVxb3Pv/YBULAYeaboqb12I3S2SHqUh4ckxwT9lyzisTVUVmngVsK10DD7jO
         cgo2yXaJyWKXiRpEkycLZQ1KrfAKXhNsYIzPJUQ1NPzyelDY5FsnSqpwi1hRfkUMbvMM
         zq3m4u7ltDudI3jcBBBXTGjSP2TJefX0Rel/9uzI5bh9U/FxofRWCWA1n5HO0dhTQCvY
         AwiRaId6phu/C0l+40kwE7q3XzGF19TLm8On4oQ+XZdxutwO3xBz0zaDZrxl83yoAPaY
         J7Zw==
X-Gm-Message-State: AOJu0YxNEoyWlkXbGS8Dt/ivZLawXoEIYndtDZqdBr8nk22+9fCHIiNz
	QxELgJHV6tFLBtGMFp17kdJW7/O0QUzSAD+wIYRaeLlim64VpPDC
X-Google-Smtp-Source: AGHT+IFsMw9FpVsfOZwfLH0tNQ4mAFhFKaNTCxrH3b5cvB7EeK/TJK7MEOv6Vb7KS5gJX9z0HrP6GQ==
X-Received: by 2002:a05:6a00:4298:b0:6e0:42cb:d794 with SMTP id bx24-20020a056a00429800b006e042cbd794mr149867pfb.34.1707043589598;
        Sun, 04 Feb 2024 02:46:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmO7W9wLDqbGmz/yYp1nxloUZtX4zzgjEBQVIWVae3tiPQxVV5uimcsvAaayqKxWiAjhRrWlyG8LoKiuUHHPdbk6pj9MRoh4FQJcobRbAWo6WTQ2NDnq2T1vSImRYMP+1oBqSD7w17p8tklcocRVubxtHU3AXnIV/Ybav5NelpYeUfRBEQ8HxbBz5yBC2t5Zn0Pm/lLBK4sc39gEDeeSXF2iiAUcLrD1j/0S+o5Ek=
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b006dd79bbcd11sm327099pfo.205.2024.02.04.02.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:46:29 -0800 (PST)
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
Date: Sun,  4 Feb 2024 18:46:00 +0800
Message-Id: <20240204104601.55760-3-kerneljasonxing@gmail.com>
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


