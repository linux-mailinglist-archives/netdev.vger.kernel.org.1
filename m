Return-Path: <netdev+bounces-91182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316CD8B194D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE5228910A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AF1CAA6;
	Thu, 25 Apr 2024 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ffMgJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF551AACB;
	Thu, 25 Apr 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014863; cv=none; b=o2SNO6s6TIQcK/oeHEuTTP5o31U+mPiarGYccFjertnBPKtS/Jd/IhAaB9ID6SLLyKTeKnrduJolNzIMd/lvGr8bTf/etQ5Vnh7oGFbi9tNeAZRejSvWSzbTAME4XGA9ghmqbJ9oHgYNjXhA6FQdqATUHR+F0G+hj4qrApXfJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014863; c=relaxed/simple;
	bh=Su8k9rAmiQpz0eW3uCuyH9NG8vZCEsJsTNrN5666vjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsjAGsWLauSl/m4RgapJUoSK/sGpfjUCFvjIISYA0JsW/VFp+/ZtJPrGt7X+cSQiGj+ISMcFNHSG2gmazwxMwE6e438s52D1DCk1JS3g3mpoWQkduFsDDYYPi2eVsCpb5uX38uFE0/NImJD+fs3TZ3EkCud7Zs/YMx/gjuxxsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1ffMgJ7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso462718b3a.1;
        Wed, 24 Apr 2024 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014861; x=1714619661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoNx1z39dGPPZ78bCeD3rHzBhVr78CiU8JLx1x2utLk=;
        b=K1ffMgJ7SPXqqTwktMKxA53h2BvkYsSaatZPQfdjlHCvLBxFRC2y9DWcXCGacYZhLG
         J8V4YCAxcsZiqUXqTH0i7MN2cAknetQFLffLHO2aX1Q0ZF0qRDTISvSUoZcud8pA/cag
         WoSLsudVNbLhqdOVwiIMXvsX/+LPpzTkBZLHzxf/Eemtz+GQmRWo8uhmFBc0y3+Ye3s4
         fncbbPIDxuvC9T8e2LqECb9CYR8DLaQAiIL7j2MUS1KcpZxPRHeeDaqme9qi4yaxG/Jm
         iSanWE7bGE6x7A7QbowXsjatFR5rmbdVaHoKdlRmWNcZ6ya++qYTJMf5/XgMLoyIV9Z4
         SUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014861; x=1714619661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoNx1z39dGPPZ78bCeD3rHzBhVr78CiU8JLx1x2utLk=;
        b=df0lHuUe6HnHFeAwWi0TJK6a5MpnTe9qcktF7qFoKbD3eVV2Ndihd2kfyhPrMFePir
         9yOWQqEMZ1sMdt9LFdHsonSNjRRZHGKtG5qP9WyulTZf9izWFAFkZH3tNCWKEaz4fdmG
         16kodNybVg45HELc7kW9SAI733EtRDv/Oiln4JvHlhZK0hlbNSrkGtS0KLCaMfQew0nr
         e8R1iFrqcb+ohJAc88m791rFLZS6fMJFVvK9fFgs1s54YVIy8A6TZOU+iF0KCJ6lUo0G
         oGA8xpn4Fd/FciJGEhoTLfNL8rSXSKcQLI2xqYx1+qfWA/+taJM/tkoSQ+bmlXWZoAlg
         kZQA==
X-Forwarded-Encrypted: i=1; AJvYcCVxLAvoNqhmfVWjZnPbNH7bAJzpK8kb1JIjz5InXTVKwjdSrktBuCZ9+04oz3Kq0ZYENwHjWhlc1GKeXWofpyz0lP6a/BplF7aspN8p/WdE9yzhwO3R1YomeEAFY5vOX0Fhd9ui8TUOFftz
X-Gm-Message-State: AOJu0Yx2PbwargqeWYic8oTZAVfGAPNLMqgcXAPnAp8i3gHq8rZzkLyk
	8+nhDcQ3jZ6rSw4WEzG8CuMbSmRUPMyoMeKCATXYbUYyUyRsxXag
X-Google-Smtp-Source: AGHT+IFYaBM1zVxSogGDuroOQcY0k8FNcX9L+oQEQWL9Yqbgf12ULz5XXVjMcB/LGl8/XCTTSuPxZw==
X-Received: by 2002:a05:6a00:189b:b0:6ed:d3af:1070 with SMTP id x27-20020a056a00189b00b006edd3af1070mr5786765pfh.32.1714014860870;
        Wed, 24 Apr 2024 20:14:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:14:20 -0700 (PDT)
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
Subject: [PATCH net-next v9 7/7] rstreason: make it work in trace world
Date: Thu, 25 Apr 2024 11:13:40 +0800
Message-Id: <20240425031340.46946-8-kerneljasonxing@gmail.com>
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

At last, we should let it work by introducing this reset reason in
trace world.

One of the possible expected outputs is:
... tcp_send_reset: skbaddr=xxx skaddr=xxx src=xxx dest=xxx
state=TCP_ESTABLISHED reason=NOT_SPECIFIED

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/tcp.h | 26 ++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2..49b5ee091cf6 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -11,6 +11,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -74,20 +75,32 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
 	TP_ARGS(sk, skb)
 );
 
+#undef FN
+#define FN(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
+DEFINE_RST_REASON(FN, FN)
+
+#undef FN
+#undef FNe
+#define FN(reason)	{ SK_RST_REASON_##reason, #reason },
+#define FNe(reason)	{ SK_RST_REASON_##reason, #reason }
+
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
@@ -113,14 +126,19 @@ TRACE_EVENT(tcp_send_reset,
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
+		  __print_symbolic(__entry->reason, DEFINE_RST_REASON(FN, FNe)))
 );
 
+#undef FN
+#undef FNe
+
 /*
  * tcp event with arguments sk
  *
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6bd3a0fb9439..6096ac7a3a02 100644
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
index e4f5c8b5172a..a8d5f22c079b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3640,7 +3640,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 317d7a6e6b01..77958adf2e16 100644
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


