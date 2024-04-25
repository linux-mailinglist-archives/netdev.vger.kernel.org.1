Return-Path: <netdev+bounces-91179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F78B194A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4777C1F22FEB
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429F1AACB;
	Thu, 25 Apr 2024 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT3I28x1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE261DA4E;
	Thu, 25 Apr 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014850; cv=none; b=uXMdBBCw5TXWiU5c8lluufryI3uwDySTCoaxQhYx+Z4ZIPpXq5aMJeHCEYgaVbQpFfExK6VRw7TYP2ttIGLMlpy2MWzm2plNcKuxR75hduOSEcda/DbNAhwla7ut5PQbpUGxubHNrRCdO9+Bf8F4WdoUWMsh78urwuchqEXgva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014850; c=relaxed/simple;
	bh=v7U6oW3gDsie/i0ijCRs85/Eal6SYC2LrAnRuKhJdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeNGFnPTkoiwc2ztkGiQGL1e9k2KbJu1DjZMD3Qhq/M/rPUB8ViXSDLjX1Ar0/d/D4Kq3tCOm1IvYIC5bu9U0DHvRoZh0mlCGtHET8244bsj/6WbUGBM0tDGuE6U+YYB2f5KINxUXoHGxhJ7y395o5IB2IRSfLQFi6vGnF3rP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT3I28x1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ee12766586so484534b3a.0;
        Wed, 24 Apr 2024 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014847; x=1714619647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=MT3I28x1wvLM0NDHqArZKFr662SDmpjEHlWXKATvQ9gQs45zxpLzSBhT/bnZmb8LzH
         FIWkDrgRZcZBktb6KkBTw+AIb00Pz+YlN+xRLw+RaOjLhYj+G3LE2yWzBhgt01/9Eexm
         Jsj28YqjcyozMgqERhFUA9oLeSzDcwRyAwiseSBJlZUUArnR+CwYBaD4braKQ5QAxlOX
         bbyKtsYeOqFUsMxFqUa2cgiRlN/zwm9f6ZQ0PURUAEoRSpUj9JsrjShvPdew+4pS3a0V
         DbeX2r7rrzFFuL95bNr1/bxrgjujvfJGLoAesHMFQF6z+NIrhdv2xUUTufUEQXaCgCy5
         tOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014847; x=1714619647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=QHWG19LT0tOGj49q8kUqe4QNk0Ma6ykb7QrUwhPLNV6c2kvgnsYe0BGygJjLlMZgMB
         h/RM34vGfH0RdqaVtb60wp2Es3H7HzD0lK4oSsH7XTbKmBZ9O4qAhScR4x8ojGpf8SSW
         B1NgGmuxFy+D56hNyF1DEFiiBawDbb7BBplGfXk5GpqOilYX4xIWom10Bu4v3Ibj73Xo
         5K87up2llj3A5N1FPMlmqv7XhTbM3LLrfa3LNsJrP5QpFm28PMU3R6dhMMa/RoK+sWPZ
         EWB1rmqQpvjFZ0eM5jLIKEyF1CeihJvxJmu16hSpMttGpSHSkJ1HJwrmn94C+SYG3xQz
         PUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl2T3JFySmqNY6A8dlGN//G9IMHvpPUdzFhbbIoZrL7MGhccUmuqG78OdKYX5QXfcrQ83Q2Q5kAwXyWVxXSEGAzb40bQjjMk4HAvfTLMOUs9qAqBJkFC/W7Lk+wZ3Ehg1QbpCGu3OsFZi3
X-Gm-Message-State: AOJu0Yw2k+xdOZ3ctTyc+M4MitJx/uEjp3zM4MVMbm+BpdZRJrzbr9Vg
	bbslpV9lL3df93u/HfZ64j8HWi9ewNnJqB2TIkm/2P0jpozFoYfF
X-Google-Smtp-Source: AGHT+IGtwH1fE/Tcubt8Ed5lxBtcDpXwEXMYJQtyqMUjux9Y7TF9h7ABf/9vp6uIKgvCaOflWA4NQg==
X-Received: by 2002:a05:6a00:a86:b0:6ed:2f0d:8d73 with SMTP id b6-20020a056a000a8600b006ed2f0d8d73mr2487746pfl.3.1714014847386;
        Wed, 24 Apr 2024 20:14:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:14:06 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 4/7] tcp: support rstreason for passive reset
Date: Thu, 25 Apr 2024 11:13:37 +0800
Message-Id: <20240425031340.46946-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we can finally display the corresponding item in enum sk_reset_reason
instead of reinventing new reset reasons. This patch replaces all
the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 15 +++++++++++++++
 net/ipv4/tcp_ipv4.c     | 11 +++++++----
 net/ipv6/tcp_ipv6.c     | 11 +++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bc53b5a24505..df3b6ac0c9b3 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -103,4 +103,19 @@ enum sk_rst_reason {
 	 */
 	SK_RST_REASON_MAX,
 };
+
+/* Convert skb drop reasons to enum sk_rst_reason type */
+static inline enum sk_rst_reason
+sk_rst_convert_drop_reason(enum skb_drop_reason reason)
+{
+	switch (reason) {
+	case SKB_DROP_REASON_NOT_SPECIFIED:
+		return SK_RST_REASON_NOT_SPECIFIED;
+	case SKB_DROP_REASON_NO_SOCKET:
+		return SK_RST_REASON_NO_SOCKET;
+	default:
+		/* If we don't have our own corresponding reason */
+		return SK_RST_REASON_NOT_SPECIFIED;
+	}
+}
 #endif
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..6bd3a0fb9439 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v4_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2360,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -2409,7 +2412,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..317d7a6e6b01 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v6_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1945,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -1998,7 +2001,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


