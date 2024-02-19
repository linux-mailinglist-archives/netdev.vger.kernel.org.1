Return-Path: <netdev+bounces-72806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B5859B00
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E261C213C6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12763FE1;
	Mon, 19 Feb 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHboTGsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F75220
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313376; cv=none; b=HA7mXCKMuPIZPWBAeFFvZ+agVTBhmvmbaPwxuNgtuVHEu3Oq7nrbXZ1yRQ8wb5EeAA4s0IbC+k/+d1nYgi6vOxcsf28dFNTwTcjHCwlYoLDwygoJ8Mec5oaPiKNqtzMq5HDAtApOHTj4wMwkaj7gmdWpPwr3nC+BZz9PwF6UYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313376; c=relaxed/simple;
	bh=wnwrmXeC9Dsl1gEInm4y0TAd1stBQJYle+2UWSzNLP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hkhmo49FKaB1VQH7YvSHYhR/Eyxil1GUY4bRSbnOC8bf3AnLZfqTCQedQE0MSFbcRb30/9WV+yzptLH0ubAzu/fhIyWTeiheqSFFVEsd8c1ULCtflQRicyoL6wAPkdlR3ylrOVtAUhkiE9qXqucLoQN+mVHenx4dGGTOfTj1ohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHboTGsx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so37998645ad.3
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313374; x=1708918174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+pVev56k4S6OfBszMhW/zhsK9iew0UVqFLmn8OKknc=;
        b=IHboTGsxjYSjX85duSXTw6XX4cW2rcaBgDt1AIdOQtDtHhJ27Ef4MOGxf0TUB/CiKl
         6GC0od7JZZTtnlds2NicudYfeL3rzbNn/Xq9D7TSsqky/yz5DSb3/GUPY5KaC1TzvHD4
         a6+pZjhJZPsFUElnupIgduLDC9vhkTq4fvJaq9oC0LUA4BkpmEyL/HVMwWFXVjzXCUys
         bVQYEbHsBkN/6MqcsIQ1zTbKjml9hjkU4UOC7L84PE2XkrGC2qVT/EllIBQanC51BkPH
         aSYB+BkDTe21q6+ZXLKR0gStWHlTHQh7SunW8LWEQeXQL+1mb3A/Q1HpbenL6+rtVeRy
         c9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313374; x=1708918174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+pVev56k4S6OfBszMhW/zhsK9iew0UVqFLmn8OKknc=;
        b=pIyzNZletJ2heP1m+eZjc/tcTcSW0w9k8VChHkGYWHuZfASkh/d03oTnZqqntOG7Dg
         63aqeeRgj5TZ1RlMi0IxLDFDlLTTidg16XYOpAtxpDkZCElg2No0offyrvC7YAyYr2Ac
         GDeWdtJUpll/USxFYT+uGVva1fhY0LiXOGcm8p0d9yKjS0E2kDpTS7smwjycU95K1ALe
         3qib35zDyT4yMnJ1vh5+KXc3lwfXbYqSV0FaKMU/JvFOC1DCUF7UrVobtIeZEN89N95X
         cTcvQ+XOc5FJtcDVpR1t+VZ82ac36EiPZVveVsKQeSBUdN8aOb1Gr3EJjCG7B4JeIIEB
         KAZQ==
X-Gm-Message-State: AOJu0Ywe9lm6X0JHe1zr+1g0O9IzFSK4+oRD+w0yZcjVOc7klas7/r4W
	+5/Sbfnkj55uRWitP50LPvMnl0WDhW8/1/jnSBBaCoVOrVK1Wh4Y
X-Google-Smtp-Source: AGHT+IGkv1N2wojSlmUBKp0mOEWjxtg8+QVgANkii6B+Cm7nq7UBw0KMTAoCcBoXWTucFo3cA5G2YQ==
X-Received: by 2002:a17:90a:f494:b0:299:a5a1:46e2 with SMTP id bx20-20020a17090af49400b00299a5a146e2mr640825pjb.25.1708313374312;
        Sun, 18 Feb 2024 19:29:34 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:33 -0800 (PST)
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
Subject: [PATCH net-next v6 08/11] tcp: add dropreasons in tcp_rcv_state_process()
Date: Mon, 19 Feb 2024 11:28:35 +0800
Message-Id: <20240219032838.91723-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
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


