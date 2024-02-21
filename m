Return-Path: <netdev+bounces-73537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189885CE69
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D118B2188F
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13F28389;
	Wed, 21 Feb 2024 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvSLGKax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C52B9CC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484294; cv=none; b=Tptya1qxIXCAYhHYu1Gg5Yhf3XZvTwCXcrltBBpmZpD7rrx3wRgW5VB1xtDFa0t+H5iTRkooEugkl7CTwiyQfML/83CuCUgHIYZ0G5l4FUfUOAm/3C5FUca0drk/02oxJsBDo0iVghJX3hNxjEy7UzZ905y1+9LGjc8FeVvKwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484294; c=relaxed/simple;
	bh=wnwrmXeC9Dsl1gEInm4y0TAd1stBQJYle+2UWSzNLP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0wE/QIEKJP+KhMzrq1Ct5TdB7CcucvkFSvw7fEwJU5ggAsBC2zGvrRX3KZQ5fnBUhgKRrdIwY+uUxreXmpacaWNAb9oYbsl68pzwivTyD+JwCTqYiDzvL/r3V9z9StqGrWAqhDLVxzQh2L+vFPB1qv916cUF8sAA6lXP4LbR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvSLGKax; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299b55f2344so1828700a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484293; x=1709089093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+pVev56k4S6OfBszMhW/zhsK9iew0UVqFLmn8OKknc=;
        b=MvSLGKaxRg+iVLLG1kNyqjUiq1UKIZII8I9vrLlCtXrt+Hy+QlJ1ATpt6oOoyO/vhw
         nm8F7CiazHVgm0FQYgRipu3TcRhYi8dSbwkjOPEfV9BR+fZcEG8rQaaunblZRyiMjC81
         zZip03vYFUwiTJXuphgYtO6ylixvtaWxSjB9m/GynDqr0kbvz7Qsa0NlZRJzvzVCvLY6
         9ohDgfKSAEj6uqsq8E9famCcmG/x6LzwGBsqgT+7vB+5TkDpG2onlEoJmZHUIMGgZuSG
         GMZqzMVewBmqzC0eucKq8X045W/41bwkgx5tl6m3C/8s7IZNmjSba8IDNs0CUgWAMJ2B
         ZYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484293; x=1709089093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+pVev56k4S6OfBszMhW/zhsK9iew0UVqFLmn8OKknc=;
        b=Y83ojq9Mw/GgwjSOtQNgtj05bATBNbiFj4rg0q5Ol7VHujEdLOn698hHG2rBl7hyq+
         uiNydRl975xmppJsZ19yzOzMmP3ebhp6vEdAe6CIb5+N9U+nyc2z1k9USknbTB2yWjiR
         QaJvTA8nvNuCZyXl5vN7Q7HocJgn+h3Y8K2IYjPxQt8RZmOs134kX0WrpPTJZlepHuhB
         RQHCRK7WyUWVAjdA1ALrH4bnwvnUbGjuZ7YdLk7EAfUjrF2pjT6WgpSqaDjOjXaOpTBK
         TATbMRhWHemIJL83en17jXsQGret8mq0wLyVHi2w349FNjxorGiHPccXo16i/L2XRzy7
         EK8g==
X-Gm-Message-State: AOJu0Yz8oJKXr04KjeUtwfO6DPPC6KZpDhoesh1FP81giKkuagC+uKEY
	zgNKwV++iURMeDIBfTU7wmgqZV+2jbDHqijLMjhfZtvN32Kr1hPG
X-Google-Smtp-Source: AGHT+IGFzU+Uihadj1fuPejeVNqFA93hkZNc2ZqXSy5IJuHRtsWK0nxKoLwgAXgGa4DZLcmmN6e2Aw==
X-Received: by 2002:a17:90a:c697:b0:299:4269:b8c9 with SMTP id n23-20020a17090ac69700b002994269b8c9mr10057203pjt.26.1708484292775;
        Tue, 20 Feb 2024 18:58:12 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:12 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 08/11] tcp: add dropreasons in tcp_rcv_state_process()
Date: Wed, 21 Feb 2024 10:57:28 +0800
Message-Id: <20240221025732.68157-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this patch, I equipped this function with more dropreasons, but
it still doesn't work yet, which I will do later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..e5af9a5b411b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -348,7 +348,7 @@ void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
+enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 83308cca1610..b257da06c0c7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6619,7 +6619,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
  *	address independent.
  */
 
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
+enum skb_drop_reason
+tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -6635,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	case TCP_LISTEN:
 		if (th->ack)
-			return 1;
+			return SKB_DROP_REASON_TCP_FLAGS;
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6704,8 +6705,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_NO_CHALLENGE_ACK);
 
 	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV)
-			return 1;	/* send one RST */
+		if (sk->sk_state == TCP_SYN_RECV) {
+			/* send one RST */
+			if (!reason)
+				return SKB_DROP_REASON_TCP_OLD_ACK;
+			else
+				return -reason;
+		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
 			tcp_send_challenge_ack(sk);
@@ -6781,7 +6787,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6796,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6861,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 			}
 		}
 		fallthrough;
-- 
2.37.3


