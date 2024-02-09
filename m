Return-Path: <netdev+bounces-70451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235C84F023
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C917B229CB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F18157308;
	Fri,  9 Feb 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXqrcYXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29957312
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459160; cv=none; b=dlM5HfiB1QtuwVyDXXhu4gVTFcdNWTZOO4EYT7/9Trt5EAPq3Uu+xGJPmvEJhPrQF0JIL3GzpclB1UphWfXZvHcRVguKzdhB8VfOo5Jy6R+ZbrxfdxjPYBYQO6m8L/A/LQ3YwYzsvVBUTXb37Nn56ANElKj62Wx7IlCC3kxvw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459160; c=relaxed/simple;
	bh=z93PNKFqub0HKDYjKFpBcZYzUodw0OtpShgHVlQEDEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sU3yYKBf7bccGXM5Tc0Z5AND442fdsPcw9hcDibrjkNzsYVOv2qjTiJGi0W4oPgdnmC9atPpX21EosYVwPpaqs2W7tD8vLghLb1/kUb3ttYl6ldxDEUV3TX58I3D9+KHszpCXIoa3PjXL1U+94lEVXgRiPztJD5p3UEY753SdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXqrcYXQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d70b0e521eso4560715ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459158; x=1708063958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQxeuE+THAoxxgZzHrkiMrZAbahR2A73QnIfW5P7hjY=;
        b=HXqrcYXQsoFIzq77a0zKTF4WBKFqBiPRourLD3LWLfRTgfB3YHcSV7wX2Km8li7gG+
         QFAS87qGO3CxNU8TUi7/CbXIZ2yUdHrcdyjNICNjpHUFsDRnzrz22mQNLFUlFMJIU7am
         o3xhhFf9iZ+UnTFz6PsLM350gj4Rff4ztiDlPeovAKUO0H2WA3bcrhCrM1TvPaCnqo1h
         ukaWl+AS7G2H3Jh9I6sqN4qlLjOdFPG9ungTVrmFIdJs2YOlbLqrFB4zcX3grVJq4UM1
         wY8X5zS/FXdIbf0SXK2g9h7LD+Sxa+VqC5Ebe8YH7z0uOJHQHcw4wy3BWBk0fsLvizSt
         bYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459158; x=1708063958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQxeuE+THAoxxgZzHrkiMrZAbahR2A73QnIfW5P7hjY=;
        b=pigeto8NpaLIpZhi1T4BC9sYFYYGoYmF23GxbFj/ezp9FvnauBwEfLybiNu32Io6Xu
         0T9KJVkx2wHXkksj98l3k262Vs+q1X9skIbyXv7jvZQ0F04mfBDMYxRqbfUo4mDntsL5
         /SrMa8kiqFaon6Lae0X6GYM7WCxsG3c09BXlAUsrYuyk2FRlTKhw/7ogAAp8erK5cY06
         JMorQdHhFIYVyC4gZGE30EY7RZ//P/TOKL8MR3GTlHep0HhDTzCnpOq2N3Q6yut+Kk2n
         JgEfwrvxus75Q6RTVJ1EHHZP4xeey2lE8uH4nGgGyHL1zo4u4iQQY7qdLGBHHqH34pm0
         TC4w==
X-Gm-Message-State: AOJu0YxvN/5p/HoJd0xGDtTzAot4svowpePQGwjLmoG7JEdLkcW+cu/D
	piYKuBPoNNzse2I4A9Ab2Uiu44ctxFmvmNXJYGx/tckc3jW/0iPl
X-Google-Smtp-Source: AGHT+IEHpyTg5X1XdBy7tkIsetav/NUOxO08y8daBQ5XhZ3+DON00LNHDHH0hz7NUJB13/163lTCSQ==
X-Received: by 2002:a17:903:2b0e:b0:1d9:a50f:9419 with SMTP id mc14-20020a1709032b0e00b001d9a50f9419mr837070plb.40.1707459158043;
        Thu, 08 Feb 2024 22:12:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJRm/ezg7DSbY0RcBcPub6qxLDDHRdoI7Ki8KJQ3mbCq9R+u0sSBk4/qoJKxCJxbjREdT43ko2pR4nWRYSW+336aHuSPbYi+M9pcBa+41EH5jzjyRNnxfd8ikJOdREtRnLs9V8i9BIASfPNe1NOurFlcGScWJQZI8YOstvUw1Ei2ac1OXi62jaElY3UqbG5lLmM0k8AEOA2m+s1lGW66Nzo4ywQkVJ4ilWSrfVrgw=
Received: from KERNELXING-MB0.tencent.com ([14.108.141.58])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903320900b001d9620e9ac9sm746321plh.170.2024.02.08.22.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:12:37 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net-next 2/2] tcp: add more DROP REASONs in receive process
Date: Fri,  9 Feb 2024 14:12:13 +0800
Message-Id: <20240209061213.72152-3-kerneljasonxing@gmail.com>
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

As the title said, add more reasons to narrow down the range about
why the skb should be dropped.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h | 11 ++++++++++-
 include/net/tcp.h             |  4 ++--
 net/ipv4/tcp_input.c          | 26 +++++++++++++++++---------
 net/ipv4/tcp_ipv4.c           | 19 ++++++++++++-------
 net/ipv4/tcp_minisocks.c      | 10 +++++-----
 net/ipv6/tcp_ipv6.c           | 19 ++++++++++++-------
 6 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index efbc5dfd9e84..9a7643be9d07 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -31,6 +31,8 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_CONNREQNOTACCEPTABLE)	\
+	FN(TCP_ABORTONDATA)		\
 	FN(TCP_ZEROWINDOW)		\
 	FN(TCP_OLD_DATA)		\
 	FN(TCP_OVERWINDOW)		\
@@ -38,6 +40,7 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
+	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
 	FN(TCP_CLOSE)			\
@@ -203,6 +206,10 @@ enum skb_drop_reason {
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
@@ -227,13 +234,15 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OFOMERGE,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
-	 * LINUX_MIB_PAWSESTABREJECTED
+	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
+	/** @SKB_DROP_REASON_TCP_ACK_INVALID_SEQUENCE: Not acceptable ACK SEQ field */
+	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
 	SKB_DROP_REASON_TCP_RESET,
 	/**
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..1d9b2a766b5e 100644
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
@@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
-int tcp_child_process(struct sock *parent, struct sock *child,
+enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 		      struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
 void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6..81fe584aa777 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 				inet_csk_reset_xmit_timer(sk,
 						ICSK_TIME_RETRANS,
 						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
 
@@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
+			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
 			goto reset_and_undo;
 		}
 
@@ -6572,7 +6574,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 reset_and_undo:
 	tcp_clear_options(&tp->rx_opt);
 	tp->rx_opt.mss_clamp = saved_clamp;
-	return 1;
+	return reason;
 }
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
@@ -6616,7 +6618,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
  *	address independent.
  */
 
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
+enum skb_drop_reason
+tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -6633,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	case TCP_LISTEN:
 		if (th->ack)
-			return 1;
+			return SKB_DROP_REASON_TCP_FLAGS;
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6654,7 +6657,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			rcu_read_unlock();
 
 			if (!acceptable)
-				return 1;
+				return SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE;
 			consume_skb(skb);
 			return 0;
 		}
@@ -6704,8 +6707,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
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
@@ -6781,7 +6789,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6798,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6863,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORTONDATA;
 			}
 		}
 		fallthrough;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0a944e109088..c886c671fae9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -1926,7 +1927,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb)) {
+	reason = tcp_rcv_state_process(sk, skb);
+	if (reason) {
 		rsk = sk;
 		goto reset;
 	}
@@ -2275,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..8d23e28a9f04 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -911,11 +911,11 @@ EXPORT_SYMBOL(tcp_check_req);
  * be created.
  */
 
-int tcp_child_process(struct sock *parent, struct sock *child,
-		      struct sk_buff *skb)
+enum skb_drop_reason
+tcp_child_process(struct sock *parent, struct sock *child, struct sk_buff *skb)
 	__releases(&((child)->sk_lock.slock))
 {
-	int ret = 0;
+	enum skb_drop_reason reason;
 	int state = child->sk_state;
 
 	/* record sk_napi_id and sk_rx_queue_mapping of child. */
@@ -923,7 +923,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	tcp_segs_in(tcp_sk(child), skb);
 	if (!sock_owned_by_user(child)) {
-		ret = tcp_rcv_state_process(child, skb);
+		reason = tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
 			parent->sk_data_ready(parent);
@@ -937,6 +937,6 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	bh_unlock_sock(child);
 	sock_put(child);
-	return ret;
+	return reason;
 }
 EXPORT_SYMBOL(tcp_child_process);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..0baddbaf9663 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1657,7 +1657,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			goto discard;
 
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason)
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
@@ -1666,7 +1667,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb))
+	reason = tcp_rcv_state_process(sk, skb);
+	if (reason)
 		goto reset;
 	if (opt_skb)
 		goto ipv6_pktoptions;
@@ -1856,12 +1858,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
-- 
2.37.3


