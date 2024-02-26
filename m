Return-Path: <netdev+bounces-74810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB798668B9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE53C1C2171A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54613AE2;
	Mon, 26 Feb 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+mhvfdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00601B96E
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917796; cv=none; b=Bt4KfD6g2Wg/iIVlbQUQMJTMcK42QVieyx2pzd9aLsABdfXbKN/N2o9DbgJ6FPznLbQVp6/oGxfFEtR5+WjdXe6QYchyc3FASxXt/LC2ED+3YDyGmA+tvqqBnjnnqsYqfrDQVT6bZcLthCTOv/wGMe4EO+6Gq4Nd04iqFiJzRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917796; c=relaxed/simple;
	bh=6dJY0Cce8uN29hsDRdz4fvwunIYY2HUk8hZwLEWgNag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgOIYP2nQOua6w5dj6QjDOzYsmZKkDsq7Ml9lDMqDQSwTyQTtnPjWQax705Cz3AY2zSTIdy+BVONyi5i8BiE9CmhJYsgvTfNYMDLwXX+N13A+PF81OHu6wJH4iVnhwlEzXMcd2JRu4SYntPv9CqAdKdanaiYWFKLPRYBx/yn2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+mhvfdu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1976659a12.2
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917793; x=1709522593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhVJxnxsjYy1CQHjwp5CWR744K7dGB0pYYdgBqOzJhk=;
        b=A+mhvfduNbKm+eaLvhTD8svbgB9yj1tZqINuGmzhGVe9s6Y1X4+Mojn7PL9Ejoej/k
         elt9KOdMIOTofRQXATQrtuSvgJnwKmVf3yjpJ+VDKEVKDmRU0huRmW5gLgl+qR8KjB7t
         w4P7XVYEsqF1T5DkCj++S53YoTHT+mp7YnGPFFbyiaAxQdaQr7qM1nhXlmP81dTZyxw2
         ci/5qwIDaI3sq2U5YLco4ngVqHGk3j3Q8pU3l/35N6wAGadI5GMYvMkyNaLdep9tD5bW
         4EuHFmkdHcIZBQSc8Z4OJXgop2oqX0YXwEQ3P4g1bGe/9Cl0je31vTolcBqL3aGKrmUE
         /wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917793; x=1709522593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhVJxnxsjYy1CQHjwp5CWR744K7dGB0pYYdgBqOzJhk=;
        b=YXJW/9JcTEm8lSFDuRmH6YQgQ4/zabTrAWNV90jmBgzivXJf8OJSW3LYjnvux8B3Uf
         7zfW4HdfK+zztI+qqoTHZRWFjBy7Rgjoua3UOsRjQFpSvVmGE1FoczaRNlvff0KyVDGD
         V6dm0JWGLzv3FCkinjpwES7Fw/xVFLjgdw2W4EJAjZAhGngYr06KMTeToyCByXoYOLvk
         8d/ALSdrq2V2qswsD3JhK9nStAoEB1mua+UOkuzJfFRMS16ZIcwsi4Qbx53OJ6xYmQY8
         YQoMW21acPEfTnPq3Icn2zqAa6ZsMIPDtLxDgHtgkX8R1IpF5rHEPLvCaLxv1RVA9aHI
         o8jg==
X-Gm-Message-State: AOJu0Yxut4GdQCoYAHg8yZlc5TLIEVLmHQblrCvvezdMRdLUseGAC+BO
	n9QZerHG+DJs/9mjQWJFrDq5DNRB4hkdIfIC/bB68+/BDwekSbQd
X-Google-Smtp-Source: AGHT+IEEsDB+lCzO0ISkaqRynFKzr/IvgBgmxd9039hfDsdjo3KNm1QvbPaXdnwhjg6OYu8JTPCLQg==
X-Received: by 2002:a05:6a20:10a0:b0:19e:9c82:b139 with SMTP id w32-20020a056a2010a000b0019e9c82b139mr3670529pze.45.1708917793071;
        Sun, 25 Feb 2024 19:23:13 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:12 -0800 (PST)
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
Subject: [PATCH net-next v10 08/10] tcp: add dropreasons in tcp_rcv_state_process()
Date: Mon, 26 Feb 2024 11:22:25 +0800
Message-Id: <20240226032227.15255-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index 33bf92dff0af..af2a4dcd4518 100644
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


