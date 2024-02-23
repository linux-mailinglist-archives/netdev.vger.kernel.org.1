Return-Path: <netdev+bounces-74347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F5860F4C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C161F21725
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283785D467;
	Fri, 23 Feb 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdMNLaBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD38D533
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684191; cv=none; b=ZfMF6N5bIuWgRzw29s9M9c3QNeaWoe0xQf/Q2pMuPVHypi8+d2RxTEN5WLKBNt3o16jXQoi7Z8kyKPJTXxZA/Kurqtfb0vOtQ70lIBl2BmKujLwVX7kGBCROcVSerh3GrHLdLBjtxhNWaeu9O8gHP0joyr/Yr7zJOq7CtFFjlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684191; c=relaxed/simple;
	bh=OJyNQxskch6r8J2NCNPPhHcPQoogBWOJ2DdPpHf1mHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgUYtszpNWIUk09QsOhx9zn798u6rRY5+gRMn4z28w5dOsA0acABkoOAereRct158T2h+NOJIyBxLh+4PsIPnOe+Kj6Wnfd8dqaU5jkpaNld57iFEZ63VpnzOGQchRPH2dSxHXgszXhZwT/iRCnJSK1HmmU1Hp0yXl4aWTST6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdMNLaBY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7431e702dso966815ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684189; x=1709288989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwLzJvWqpVHxOpW3RD1ZVO8+ZftdgYXF0aN1hMOMMss=;
        b=bdMNLaBYeyRGZFF2rv55ZqWVANrkUgle930OJiXKHoB2+Sv0U1i0sSDtZd50sd06VD
         hs3jEMpOMwQoRClkZPT7c53HDPIyQy4XqBGS6j+TwTWE8nUH9DIkmQMldP02M6CX7xE1
         Bj1KcHoZdHQG431HLEdpeJ6g4bYOQAa9qOXpCHCOHcx6LUPSWSOkifzo2nE0uR5X33+8
         O0Xv7Ud7RavTYipWOALl27bEYe8MFamvtSthfb2Xzyqq5J9Yu4f2ufE9o9PD/b9Ahchi
         sNcHorP0d+EucVueRcPfELmmTBVUd/PpiJXB6cDXFfTqu5wTv5cu+CEeb6jAXeRAfFOd
         Clqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684189; x=1709288989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwLzJvWqpVHxOpW3RD1ZVO8+ZftdgYXF0aN1hMOMMss=;
        b=Xp7sSg64DVyaqi75h8fx4X8saZdj3eE1Yjrif/yHKzodX3WcDpDntRVV0Xme1VBG+1
         c2H+Nt5oredTY/41FBM8cbwjHYfyJpwe4SU1c7HIqOTJFBMCi5sGzkXjqpm8WhMazBs6
         fhhMQPhMGdL3+3dEoGgC5V/rzUQSFd1qi9u2GAGeP9Wa6J5ZFtK/Mf8GLIm+R/l/T0Lb
         1g1WYWHdgJvErbOcvXxqvR935mI8DojJFd0UK6c4emyEZFX/mpiLAo4OOR+Qz3KmT8fA
         4T6jfLe+6bRHTEw2KRYxT6hLlVt6tdogpqf+RhPX/oBJIU1vjo5pkxmI0azHZ/pHqHzc
         TNbA==
X-Gm-Message-State: AOJu0Yw5bg7kYVdSerchxLjVGApsV5AY/6tuU9sSm71DOJek+ajQU6Zh
	qin+Cf2ZPTDIgLCX8OyU0LLcCkXoABbRXQnb9xzje/BzkqIKeWEU
X-Google-Smtp-Source: AGHT+IGK/csm5/OhlKcxGDH55wTwTp97XKBCIsLPRaCK/Dj1oLfSbiiVqTBo2XCQvMaH10+njENX5g==
X-Received: by 2002:a17:902:d2cf:b0:1dc:4b04:13d4 with SMTP id n15-20020a170902d2cf00b001dc4b0413d4mr1835427plc.8.1708684188906;
        Fri, 23 Feb 2024 02:29:48 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:48 -0800 (PST)
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
Subject: [PATCH net-next v9 08/10] tcp: add dropreasons in tcp_rcv_state_process()
Date: Fri, 23 Feb 2024 18:28:49 +0800
Message-Id: <20240223102851.83749-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/CAL+tcoCbsbM=HyXRqs2+QVrY8FSKmqYC47m87Axiyk1wk4omwQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. nit: remove unnecessary else (David)
2. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89iJJ9XTVeC=qbSNUnOhQMAsfBfouc9qUJY7MxgQtYGmB3Q@mail.gmail.com/
1. add reviewed-by tag (Eric)

v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

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
index 83308cca1610..5d874817a78d 100644
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
@@ -6704,8 +6705,12 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_NO_CHALLENGE_ACK);
 
 	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV)
-			return 1;	/* send one RST */
+		if (sk->sk_state == TCP_SYN_RECV) {
+			/* send one RST */
+			if (!reason)
+				return SKB_DROP_REASON_TCP_OLD_ACK;
+			return -reason;
+		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
 			tcp_send_challenge_ack(sk);
@@ -6781,7 +6786,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6795,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6860,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
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


