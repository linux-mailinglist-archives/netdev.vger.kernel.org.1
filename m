Return-Path: <netdev+bounces-68913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E490848CF2
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530ED1C211D4
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D321363;
	Sun,  4 Feb 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9MI5cfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56C1B808
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043599; cv=none; b=KbfEintHeGOFHVu22Xg3nEmcSVVzoqJ15s/nNSYBWUq5//tk1AXLftl2XaA3jJpkn6RGuyjsRtQFY4d9Rrf6xaUCj7CC8oU5Gg7JpfIgCZH8rAUqZlySPdJstycVQUScoulAdXRKBsPmH7Xn2QEBgxKdQDZpXyOcebLfp6GqxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043599; c=relaxed/simple;
	bh=21DKPToyP8vfOxzJeXudCfCjb+ST9k7OQoMZV7Zxu8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4x/ss4PDoWt3MKNeNHxUdBt7bOAm9VZJ4aepn2+qkxi4iMcjRf8honp6BeasmDEP8nTl15WsqUZE1K1CYhBQNVN13VksRVbCVO9hVGliYDRT9LP1rlTVBdC+yHW7EdiMvOfynArGBxPfFmmLMCW5lO5VK2Y37oTqB6BWzXrcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9MI5cfN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21433afcc53so2218090fac.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707043597; x=1707648397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pjijQ99Q872W8sS4ZrH9wkRzDg9r3R+YgWYikG40R8=;
        b=B9MI5cfNW0w9LT59MQYK6ZVNJ9i3Wor+PnFYNrBkarL1UiiWfC9XpEXisgIOLDCoI3
         Fr0zE3XK8xiw/dUiA5o5dtgde4Ewk5HQ316TjLWyevnhn5u3/rEGYvWAKhjMqVaoT8B8
         lS1oOxJVDMg/GlQCSS036y7//JqBQ0tyhh7kyILLGrzFYjRCQFBFWzFCj0R9ojppqkvo
         cor0g29CkLltts1FVF718BAjaeUWgt/jbAPoYN9/flXn5wg+h1MylIvkPdNesGMmhG3/
         tOF0F0wTNsYci9IYUwriJRWujx90ZGlyePLgSbOx5/7X9+7lkTg8N5j96sQAIUysZ3C5
         TTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043597; x=1707648397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pjijQ99Q872W8sS4ZrH9wkRzDg9r3R+YgWYikG40R8=;
        b=r7Xm/YdTTvDnfq/IIYo0L2fYhs17Ib84s8lxJWTK/pkC2LRDTuqYaUs17tmM+pc2+l
         spmlX/QNHb33n4cDkRRGSDyV3plVi5N1wySxToDBd1fqfA7m3qCtrC0UsPsEcYeyGIsq
         yZU6kdqBDsRLamiEkcrrXLKBWUeDE1bcZ1MRw148ppP3qq0u75uuoqCgeIohlNBhOhfw
         Y5dx3X8uooR5rXj5fs2abeDpDY+coqDHVyDRasEsa+7Fvr88qwZ9d4yGtoqyhl/SwkzN
         2R8udGOgwqDWNUnaAdY6Ma05j0afTsx+RJrUl0kOZiGYGvJ33BaQQcSEBnd6cBlEALAU
         oi1w==
X-Gm-Message-State: AOJu0YxHZ/ObdaEac/R0XE14gDUKncrtVAUQuGjdx5+6gY07C1XJyeuM
	Os2Yy7JZwUxTxv/1QP+BdWHYmx1KdVB+ErYoaFpYXYVTGZRSI+i9x/7G1aDuYx47AA==
X-Google-Smtp-Source: AGHT+IHtZsu0D1qdkhzlbbPCYqz/c51wNkF8Zv22O+sVBsaT7r2CfM95nQ9OgtHRI05RlfciODR6Yg==
X-Received: by 2002:a05:6358:441e:b0:176:7d13:d70e with SMTP id z30-20020a056358441e00b001767d13d70emr7336596rwc.16.1707043596767;
        Sun, 04 Feb 2024 02:46:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW457LEuL7PzXbp7Tl+eoMTNsrhK9kuMOc710LoQazd6wkuaeh8sE91k1S5+B0pAd6PN2V4jED4f5+yyHclacfQtT/AH9IItlTdsx203KiZc0jm2+YAl06ZZ45XN5EIZLfjzbeius+njZEtkv2UOlLaH6ZAcc24Lhnv1/nu1nB84unDMUMMSUNSgOQ2jT7hhVrLTqG44gRJQmS99kDwNsQOQ8g9bcG6SOYAwlViBr8=
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b006dd79bbcd11sm327099pfo.205.2024.02.04.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:46:36 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] tcp: add more DROP REASONS in child process
Date: Sun,  4 Feb 2024 18:46:01 +0800
Message-Id: <20240204104601.55760-4-kerneljasonxing@gmail.com>
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

As the title said, add more reasons to narrow down the range about
why the skb should be dropped.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h |  6 ++++++
 include/net/tcp.h             |  5 +++--
 net/ipv4/tcp_input.c          | 19 +++++++++++++++----
 net/ipv4/tcp_ipv4.c           |  6 +++---
 net/ipv4/tcp_minisocks.c      |  4 ++--
 net/ipv6/tcp_ipv6.c           |  6 +++---
 6 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 85a19b883dee..980fd4442b7c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -31,6 +31,8 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_CONNREQNOTACCEPTABLE)			\
+	FN(TCP_ABORTONDATA)			\
 	FN(TCP_ZEROWINDOW)		\
 	FN(TCP_OLD_DATA)		\
 	FN(TCP_OVERWINDOW)		\
@@ -203,6 +205,10 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_BACKLOG,
 	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
 	SKB_DROP_REASON_TCP_FLAGS,
+	/** @SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE: con req not acceptable */
+	SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE,
+	/** @SKB_DROP_REASON_TCP_ABORTONDATA: abort on data */
+	SKB_DROP_REASON_TCP_ABORTONDATA,
 	/**
 	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
 	 * see LINUX_MIB_TCPZEROWINDOWDROP
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e3b07d2790c4..8c87170cb0b5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -348,7 +348,8 @@ void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
+int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb,
+			enum skb_drop_reason *drop_reason);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
@@ -397,7 +398,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
 int tcp_child_process(struct sock *parent, struct sock *child,
-		      struct sk_buff *skb);
+		      struct sk_buff *skb, enum skb_drop_reason *reason);
 void tcp_enter_loss(struct sock *sk);
 void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
 void tcp_clear_retrans(struct tcp_sock *tp);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6..bacb1140dab3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6616,7 +6616,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
  *	address independent.
  */
 
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
+int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb,
+					 enum skb_drop_reason *drop_reason)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -6632,8 +6633,10 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		goto discard;
 
 	case TCP_LISTEN:
-		if (th->ack)
+		if (th->ack) {
+			SKB_DR_SET(*drop_reason, TCP_FLAGS);
 			return 1;
+		}
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6653,8 +6656,10 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			local_bh_enable();
 			rcu_read_unlock();
 
-			if (!acceptable)
+			if (!acceptable) {
+				SKB_DR_SET(*drop_reason, TCP_CONNREQNOTACCEPTABLE);
 				return 1;
+			}
 			consume_skb(skb);
 			return 0;
 		}
@@ -6704,8 +6709,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_NO_CHALLENGE_ACK);
 
 	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV)
+		if (sk->sk_state == TCP_SYN_RECV) {
+			if ((int)reason < 0)
+				*drop_reason = -reason;
 			return 1;	/* send one RST */
+		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
 			tcp_send_challenge_ack(sk);
@@ -6781,6 +6789,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
+			SKB_DR_SET(*drop_reason, TCP_ABORTONDATA);
 			return 1;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
@@ -6790,6 +6799,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
+			SKB_DR_SET(*drop_reason, TCP_ABORTONDATA);
 			return 1;
 		}
 
@@ -6855,6 +6865,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
+				SKB_DR_SET(*drop_reason, TCP_ABORTONDATA);
 				return 1;
 			}
 		}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b63b0efa111d..7da62af0d890 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1918,7 +1918,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			goto discard;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			if (tcp_child_process(sk, nsk, skb, &reason)) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -1927,7 +1927,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb)) {
+	if (tcp_rcv_state_process(sk, skb, &reason)) {
 		rsk = sk;
 		goto reset;
 	}
@@ -2276,7 +2276,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
+		} else if (tcp_child_process(sk, nsk, skb, &drop_reason)) {
 			tcp_v4_send_reset(nsk, skb);
 			goto discard_and_relse;
 		} else {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..49a88bf47b79 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -912,7 +912,7 @@ EXPORT_SYMBOL(tcp_check_req);
  */
 
 int tcp_child_process(struct sock *parent, struct sock *child,
-		      struct sk_buff *skb)
+		      struct sk_buff *skb, enum skb_drop_reason *reason)
 	__releases(&((child)->sk_lock.slock))
 {
 	int ret = 0;
@@ -923,7 +923,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	tcp_segs_in(tcp_sk(child), skb);
 	if (!sock_owned_by_user(child)) {
-		ret = tcp_rcv_state_process(child, skb);
+		ret = tcp_rcv_state_process(child, skb, reason);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
 			parent->sk_data_ready(parent);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..ced52f7aa5bb 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1657,7 +1657,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			goto discard;
 
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			if (tcp_child_process(sk, nsk, skb, &reason))
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
@@ -1666,7 +1666,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb))
+	if (tcp_rcv_state_process(sk, skb, &reason))
 		goto reset;
 	if (opt_skb)
 		goto ipv6_pktoptions;
@@ -1856,7 +1856,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
+		} else if (tcp_child_process(sk, nsk, skb, &drop_reason)) {
 			tcp_v6_send_reset(nsk, skb);
 			goto discard_and_relse;
 		} else {
-- 
2.37.3


