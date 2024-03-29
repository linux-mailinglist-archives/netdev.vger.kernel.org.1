Return-Path: <netdev+bounces-83345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB192892008
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B711C29357
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABC1CD21;
	Fri, 29 Mar 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBhkpnS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0D2577B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723775; cv=none; b=Df/SnQEfLrP8+u3AfhB0c/WzcGgFxvLGzeYu5ae38HqiVOaKECnqiMBDUO6onAekBikxdb72LY3Js5+vgl7e3rvIs1LFGBZgaR+fm1VD/N9DQbHE5ghOOnkYp3XY+i20KVxL3BmjrySqhwaxF7CsnPMvuk0EFDGX1P1RtTAY3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723775; c=relaxed/simple;
	bh=05wDWj08msmk8RktLaXe+7HRf6zPWHhWWH02hVe7DOU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R/EjIAO7XXiXypADLdvf7bkkvafqmQTS/VXltfx9dYZXDsIzZ2oMV8JhcodeXf8aofADu1L7KLaIkFYqCC15keNHN7X5pwvoBobv5U6gbFkTieGHID1rbtSnclGMmKM7vokckouLivQ2hNqXf1561QYM0H0ptypVEflftmLJyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBhkpnS1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-613f563def5so32017927b3.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711723773; x=1712328573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKBS6wYyIdbv5gfTbYHv89wO7mofyNVJfNVnrcRttrU=;
        b=WBhkpnS1No7t3HwC29QV4TkGZUgWQ31buTBI9LSzSxyD7cYlmDgytRE4EHmdEi9RBI
         QffOFvqKB22CSuHFTrOs/tFeE3XYl40U+y0rTfhxkCKdLbtLgypGXDFiq8n08SymOjV8
         hg8acinieAMkilOseHWwAxrb9P9E9cfI7+BUBr4dwPY67kpwCAUM4FQDWwW6uLB4ogxQ
         68qlWSTX2cPd1pZZVTazGeKgkHYAUXwKM/JckCdqw2XgHGfVX5t1EtS0k/d3zg4+q8Oe
         wLuFq9Bko60+vhkHB6X/gWyoyoD5gYeG6a8ksP1sWDZuCEqi/YQe+rTH9PRuWDqHLl14
         JPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711723773; x=1712328573;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKBS6wYyIdbv5gfTbYHv89wO7mofyNVJfNVnrcRttrU=;
        b=dZWAhPEDScThM9yVF0DfabSxwOuy5Sztki9G+CPtDYektQbk5lc+NZv3YZfvJqhGmW
         y4KEvgToBlLLUzdVCyWBOwpJKA5xQf2hrddNVd9AwOm5zM9vxSQ+zymkj62yXUvw3Y08
         oIuyCszxQLaPxA1HPTY8x97kbWy4+/PNm/0Oeflx6eEXK2ve95/QJrqSvDtZ+AHqO04T
         CEWHkSf5HAsLO90UW18qraT86aGbyKOPeZptVP2b0CkoceYPhosrsHPwwZvAHrZ3NXH9
         L5RgCIeOHp5vX025d9XkzR8RtVRV37cKG3zb5Prea+aOPPWLkp5bfouFCL1/RtnU2+gx
         KQnw==
X-Gm-Message-State: AOJu0YxCaDT6MpOoU7Yc/K1gV9kZTyQ0PRuUrXxGga6OxzNCS0QPr/oL
	RMpbkczvb0qH0iO+pIOx2Gdrhxo3iMOE9v0jl7neICaV5e5d8N3DDN2iuw62GIp1eaQ9I1JQU3U
	bb+Bxtj5vzQ==
X-Google-Smtp-Source: AGHT+IH/m9NldgRjMtSAJwK7WMoGjCyL2oKGPzcRXlEDG2eJrKEPLUF/CO2YWnCCYW5KXWVUsKAaMhM9OEprMw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2409:b0:dcc:8be2:7cb0 with SMTP
 id dr9-20020a056902240900b00dcc8be27cb0mr174006ybb.0.1711723773007; Fri, 29
 Mar 2024 07:49:33 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:49:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329144931.295800-1-edumazet@google.com>
Subject: [PATCH net-next] inet: preserve const qualifier in inet_csk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can change inet_csk() to propagate its argument const qualifier,
thanks to container_of_const().

We have to fix few places that had mistakes, like tcp_bound_rto().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/espintcp.h             | 2 +-
 include/net/inet_connection_sock.h | 5 +----
 include/net/tcp.h                  | 2 +-
 include/net/tls.h                  | 2 +-
 net/ipv4/tcp_input.c               | 2 +-
 net/ipv4/tcp_timer.c               | 4 ++--
 net/mptcp/protocol.h               | 2 +-
 7 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/net/espintcp.h b/include/net/espintcp.h
index 0335bbd76552a1ab0b509ef051536c097c8a2615..c70efd704b6d5dab81e7b22c40f9c164fdb47ce5 100644
--- a/include/net/espintcp.h
+++ b/include/net/espintcp.h
@@ -32,7 +32,7 @@ struct espintcp_ctx {
 
 static inline struct espintcp_ctx *espintcp_getctx(const struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	/* RCU is only needed for diag */
 	return (__force void *)icsk->icsk_ulp_data;
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ccf171f7eb60d462e0ebf49c9e876016e963ffa5..d96c871b0d581b06c660317f195094d5b2733614 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -147,10 +147,7 @@ struct inet_connection_sock {
 #define ICSK_TIME_LOSS_PROBE	5	/* Tail loss probe timer */
 #define ICSK_TIME_REO_TIMEOUT	6	/* Reordering timer */
 
-static inline struct inet_connection_sock *inet_csk(const struct sock *sk)
-{
-	return (struct inet_connection_sock *)sk;
-}
+#define inet_csk(ptr) container_of_const(ptr, struct inet_connection_sock, icsk_inet.sk)
 
 static inline void *inet_csk_ca(const struct sock *sk)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index afd929b71e9224af20fad84c5c905ac952138b23..9dab95f241d69b91202474414e16ece1ebf992ad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -742,7 +742,7 @@ int tcp_mtu_to_mss(struct sock *sk, int pmtu);
 int tcp_mss_to_mtu(struct sock *sk, int mss);
 void tcp_mtup_init(struct sock *sk);
 
-static inline void tcp_bound_rto(const struct sock *sk)
+static inline void tcp_bound_rto(struct sock *sk)
 {
 	if (inet_csk(sk)->icsk_rto > TCP_RTO_MAX)
 		inet_csk(sk)->icsk_rto = TCP_RTO_MAX;
diff --git a/include/net/tls.h b/include/net/tls.h
index 340ad43971e4711d8091a6397bb5cf3c3c4ef0fd..400f4857dc117cb7df00748b8b5449c3110f8dfc 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -361,7 +361,7 @@ static inline bool tls_is_skb_tx_device_offloaded(const struct sk_buff *skb)
 
 static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	/* Use RCU on icsk_ulp_data only for sock diag code,
 	 * TLS data path doesn't need rcu_dereference().
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d874817a78db31a4a807ab80e9158300329423d..1b6cd384001202df5f8e8e8c73adff0db89ece63 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6999,7 +6999,7 @@ EXPORT_SYMBOL(inet_reqsk_alloc);
 /*
  * Return true if a syncookie should be sent
  */
-static bool tcp_syn_flood_action(const struct sock *sk, const char *proto)
+static bool tcp_syn_flood_action(struct sock *sk, const char *proto)
 {
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	const char *msg = "Dropping request";
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d1ad20ce1c8c7c013b8b0f26d71c0b0bc4800354..976db57b95d401d0eec1bf77c1cfc9044a83b914 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -25,7 +25,7 @@
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct inet_connection_sock *icsk = inet_csk(sk);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u32 elapsed, user_timeout;
 	s32 remaining;
@@ -47,7 +47,7 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct inet_connection_sock *icsk = inet_csk(sk);
 	u32 remaining, user_timeout;
 	s32 elapsed;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a10ebf3ee10a1e06ecf0ca461c72c98163d8ff45..46f4655b712369ba0e4c0fa07d91d8b9741ab534 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -558,7 +558,7 @@ struct mptcp_subflow_context {
 static inline struct mptcp_subflow_context *
 mptcp_subflow_ctx(const struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	/* Use RCU on icsk_ulp_data only for sock diag code */
 	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
-- 
2.44.0.478.gd926399ef9-goog


