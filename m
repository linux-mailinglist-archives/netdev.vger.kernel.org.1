Return-Path: <netdev+bounces-70450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3993A84F022
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580A81C21A8B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F957308;
	Fri,  9 Feb 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmnd68E1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9456B87
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459154; cv=none; b=PdbmcCmzGJTSsvz2i6MbkB+3uo+LN/UT6grR8nFumKqQSLAau/kHs8m8Mwo1XsF1VdCIlOJJraMjDLsBAtBEGlTm3hwr84WPMhetRO+ZkD1ANzIe9TsKgD9qniy2Fgjh1zAzQ279VrwP4LCE6fEkCOBpshDwveCFPPe9Lrma5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459154; c=relaxed/simple;
	bh=BQE/bC3+WW8ii11NaGS708W+3XA3ImEGcgkT8wMj7Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgobTFRKunTsN1ei7d4WtQwd0uKMd53dwEii40TqGlSo9uzjEGhIRyf1OzqSyqe8ZdY8IAeLx56zwh/tShUc1RaLI5Lwp1QMbzEoPOHdMML6fYbS4sak+OJACQqctUsYvUVhJI4StcWabc8ytdIou6r9+YFpwQYYcgimI9fIRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmnd68E1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d780a392fdso4601725ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459152; x=1708063952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoKwYstFRXm8I59mmxBGPPMNXoMSCU16nsn7hkgtUWE=;
        b=dmnd68E1I4SjSbyfgCLJd4CcrVrPdgawWOJuc/4o5vuZ4pNe5En7fAfjO0E/YCwE5m
         9V3tQBlJCpm+48RmhlaM3JbzSTXWoRrsndWXJjcrPM0r9wam5KoHP+M6Vs2lhWm1j4tW
         r/GYviIlg8DNJPde7Z/gkwf+9J2IV20Ke720eb4/3SFBP3lMZee2XufH4bBd6ULc2nrl
         NL8mccfS/WHKHZbm0yu++8BB2IFjXmAxfcdYt/4Y8owT3q2Fjm36MLm3ONgCXf5DNuPN
         pebtg+eXcrjSjifzM7GnBuaMy60KtypcvEeavx7C0fE4VdpyU7PR39GdKPArJdVFhYFU
         yF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459152; x=1708063952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoKwYstFRXm8I59mmxBGPPMNXoMSCU16nsn7hkgtUWE=;
        b=nu2l3fYGiwsK18vvI51GW0FdSQ6xv65RgrnSLRA5kApsrXhTXsvWDkk+RLqiSOX+rq
         61QWhNR9xZpLYnsthB6+N2uN5wZdy5w31vSMq//GUQirtD7yH//GsAtApUZNKLymAEgi
         FpwtCEkYmKS4DB7DtZGykWndIbGhQCXKwr9MNy6P5HG3rCBuFOodPC2mUEbuNqp6X3OU
         n98p3EiV4DK6VigdcAg90UcJ3nyefYcu/z+Wb2UB36m+oWy0c/Hmz6Vu6RjLJnkndbOM
         4jVYL0Dk+ogKHoyFaEob/bhYG5Y59b/HkaiwiEz4wkEWD3nJfi+uJXT0t9mgXo9VxK6W
         OGsg==
X-Gm-Message-State: AOJu0Yxf9mmLM/0FVJl+Ge3dB89Byuag6DenGGollvNQIHwvU1MJVfUj
	JBcgsbrD/txGdZP2bF+CnSjieP5d8rVAhnAvgu9OnmMT3PtVNXt0
X-Google-Smtp-Source: AGHT+IEP12zTP+gJaOUBmHv1E1tGmjSyYn4zAGGZS+D2v/E08oRL+DPqjesgNyjdBlE41snHKMUIaQ==
X-Received: by 2002:a17:903:1c9:b0:1da:beb:167 with SMTP id e9-20020a17090301c900b001da0beb0167mr743197plh.50.1707459152070;
        Thu, 08 Feb 2024 22:12:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFAoCzBJJvkmfEZxQUW4vn/fCiJ2CYEDK4gzfTbGnZfryJG65xFYQTdGPNaqmYkQTt7QlNZTOM5Vm3VNWzIipC12Sut9HqDsHj9XonWk8DYcgJNhv65M7oqlUzf8FSMXDVNvW4BK+F3zDBcC9TYbRYEJCo/opA8jcBOxsH0PcwGtiofzDEAlb/ZaibTQbJhm3O/e9UoUJQlEnarE2o000Y28hQzjdkn/bHY0EGvwI=
Received: from KERNELXING-MB0.tencent.com ([14.108.141.58])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903320900b001d9620e9ac9sm746321plh.170.2024.02.08.22.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:12:31 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net-next 1/2] tcp: add more DROP REASONs in cookie check
Date: Fri,  9 Feb 2024 14:12:12 +0800
Message-Id: <20240209061213.72152-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240209061213.72152-1-kerneljasonxing@gmail.com>
References: <20240209061213.72152-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we've already introduced the drop reason mechanism, this function
is always using NOT_SPECIFIED which is too general and unhelpful to us
if we want to track this part.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h | 12 ++++++++++++
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_ipv4.c           |  2 +-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..efbc5dfd9e84 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,6 +6,7 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(NO_REQSK_ALLOC)		\
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
+	FN(SECURITY_HOOK)		\
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
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..6eb559ee20f9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -399,6 +399,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
 	const struct tcphdr *th = tcp_hdr(skb);
+	enum skb_drop_reason reason;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct net *net = sock_net(sk);
@@ -420,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		reason = SKB_DROP_REASON_NO_REQSK_ALLOC;
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
@@ -433,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		reason = SKB_DROP_REASON_SECURITY_HOOK;
 		goto out_free;
+	}
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -451,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		reason = SKB_DROP_REASON_IP_ROUTEOUTPUTKEY;
 		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -475,12 +482,17 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
+	if (ret) {
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	} else {
+		reason = SKB_DROP_REASON_COOKIE_NOCHILD;
+		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..0a944e109088 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
 
 		if (!nsk)
-			goto discard;
+			return 0;
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb)) {
 				rsk = nsk;
-- 
2.37.3


