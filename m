Return-Path: <netdev+bounces-88299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279F8A69CE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2BF1C21091
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52854129A7B;
	Tue, 16 Apr 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAooprGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DD129E64
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267649; cv=none; b=TjoNO1ZI/Jb1b2jfcYr3CxaKz8pCf0TbvgK5A98Cf7FMtjKHIPHn1NU2FaSu3xcjHhY25cRq8fsR2Tnz0yFehOKPHiM3KQCPbnXffBHhcEBZJT3yMcHKbWJCQZEKsxSNIWKBrbOSt8WzwXOGMghH1vn+sLrVNLNGxhO1bWclv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267649; c=relaxed/simple;
	bh=TpPs/G5lSMfwUSyl5wVFAr0dgNU4d3+Y0STOnkHAmzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xmuo/vEAewkdz/NfsP2dMpZKK5Ul7VCGIFcsCeG3fm6ZqOIoKh3rKS0BnxZgm+qGn76RaKM6Y2lNP/fQaKPRDxqv4h2uCOcKRixN1KUdm7h4KDvNyLaOci2rc1oT3b9ycxxBkiJ53W+twCdoT4FuySny6c+otVb9b5SRz1vL55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAooprGN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3801968b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267647; x=1713872447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgIm2mCCIOR76GdPrzThP7+upXmF5LtBKCvY2pmuYuc=;
        b=BAooprGN9DQG8pR6Twn2vbYshInd4LInTVbSfcMQ2zCJyfahqejFmH+LoqaEfpt4wU
         NIpY0VKBEMw5H6qDM3dF2epA3AAsEgbXqQfKwiVdA7bleOUpEucJ4eLmL3dK1+P9EJh9
         pu418nupPLcpp1Wp8Ob9ReU69cJRLFV7R0wDPUpBJEjTQQyA+Hx5J3AHUqKITVFGhPWI
         haguQfwHdXvc0Pk/CI/8wj+cf3nYFAktDf5ltdK2htZ7lxia8hUMKogyiWBWStoDOx2o
         ai40XKVdxbEKxYuMsIyIGQsNDTxNBZMFP6x3ryic91LhaxPIox7vjPgr7QkejjbzeVmP
         gc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267647; x=1713872447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgIm2mCCIOR76GdPrzThP7+upXmF5LtBKCvY2pmuYuc=;
        b=XKLc+9ctfanKUW8oZpuFTslpcyeoQgkqTAiLYXvozN/m/7PPT9GMflublsjz/M4Jgd
         RmlypzPOV6V76EJmSmFpx3v9uTmP1i75e93RKukWsNJUWMIfHU3hCT98aom5yWxylEsv
         5+t2pQRrVr2YurZqOipxqIRW2TrSIN5Ld5Zns4nB9Fv4Dgtl5annGyQHc39TNVKsRmJ4
         PkzxzIxoBNZSRvNjF32UJyTASYDl71mh+V003iKMUmjd8Xiazp86P/dYupnFCh2EfKNa
         4h7GGdOb0gi03xM8M+jWdhvp/RqMvYr8n9JK6g3EKNsZOkkQc1EcQkyVPpQLVIPy4UqZ
         5+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPrc7A2Sb1EPOmnmjTzz/tSu7YFtlr5PYu8Cp64D0KUWQJqtsqUBkQpL8kamNbNUSzVdaTFgQrp9Xko+BLfYr7TVBQGGe9
X-Gm-Message-State: AOJu0Ywv1Dh+0paB64RAUalb4tIwoYKZSw8kABNZZnbD1b0SsOQRbXgM
	b+stQHpqXVk26oU9mSoHFuGH67EiFIqyF744ToWMFyUjGL453W60
X-Google-Smtp-Source: AGHT+IFKRtzQXx+/htpH4Umb0BxSu4jMCQWF6uBdvoxmCBLNrYeRb2UGfuMS3Rl3qeeqSmJRM14EyA==
X-Received: by 2002:a05:6a00:1302:b0:6ed:63e:3525 with SMTP id j2-20020a056a00130200b006ed063e3525mr12040966pfu.31.1713267646714;
        Tue, 16 Apr 2024 04:40:46 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:46 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 7/7] rstreason: make it work in trace world
Date: Tue, 16 Apr 2024 19:40:03 +0800
Message-Id: <20240416114003.62110-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

At last, we should let it work by introducing this reset reason in
trace world.

One of the possible expected outputs is:
... tcp_send_reset: skbaddr=xxx skaddr=xxx src=xxx dest=xxx
state=TCP_ESTABLISHED reason=NOT_SPECIFIED

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/tcp.h | 37 +++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2..b1455cbc0634 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -11,6 +11,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
 	TP_ARGS(sk, skb)
 );
 
+#undef FN1
+#define FN1(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
+#undef FN2
+#define FN2(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
+DEFINE_RST_REASON(FN1, FN1)
+
+#undef FN1
+#undef FNe1
+#define FN1(reason)	{ SK_RST_REASON_##reason, #reason },
+#define FNe1(reason)	{ SK_RST_REASON_##reason, #reason }
+
+#undef FN2
+#undef FNe2
+#define FN2(reason)	{ SKB_DROP_REASON_##reason, #reason },
+#define FNe2(reason)	{ SKB_DROP_REASON_##reason, #reason }
 /*
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk,
+		 const struct sk_buff *skb,
+		 const enum sk_rst_reason reason),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
 		__field(int, state)
+		__field(enum sk_rst_reason, reason)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
@@ -113,14 +132,24 @@ TRACE_EVENT(tcp_send_reset,
 			 */
 			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
 		}
+		__entry->reason = reason;
 	),
 
-	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s reason=%s",
 		  __entry->skbaddr, __entry->skaddr,
 		  __entry->saddr, __entry->daddr,
-		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN",
+		  __entry->reason < RST_REASON_START ?
+			__print_symbolic(__entry->reason, DEFINE_DROP_REASON(FN2, FNe2)) :
+			__print_symbolic(__entry->reason, DEFINE_RST_REASON(FN1, FNe1)))
 );
 
+#undef FN1
+#undef FNe1
+
+#undef FN2
+#undef FNe2
+
 /*
  * tcp event with arguments sk
  *
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 474f7525189a..e9e95315a619 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -871,7 +871,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (sk)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 276d9d541b01..b08ffb17d5a0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3612,7 +3612,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e0b90049e3c5..88f7b0528ffb 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1133,7 +1133,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
-- 
2.37.3


