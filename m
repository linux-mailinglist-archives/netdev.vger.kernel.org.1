Return-Path: <netdev+bounces-90370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957378ADE2A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A55B2164A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB3E47A52;
	Tue, 23 Apr 2024 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB7m8R8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27894776E;
	Tue, 23 Apr 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856939; cv=none; b=JDMSbIrqPXtfNMHQSL37FtLFY7+syWqfkos41iAu7PR2/fbhTevPh71cnoZZHEbhzHPb7d1ckb8ZBazryQYGCVkrL6FTk/beOyqq2VYVmvFwYnhozbw4ZYVkNc4S8Z+qmufHLU9BTTzUO0sZ54y1eplIRJvUntb2NeGhj0ljZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856939; c=relaxed/simple;
	bh=EKYMhUZclgItu8bZojekegGV/0jiYlqGYAss6oG3DpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hw9GIp4O/zHDf3Y/XrZIccG9uj9eJzaN1hJe6ojrwCoXNXTjRuByYIp0SMys3+qKOXKssKLa/wCQ8I1M5iczGcoL/4V94m0aL9bNqVwxUuumC8b18oyFzRpjMFE9hMoBNl+45iLo5HvurV4JEQlyeKLFEialInto14O+VApRtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB7m8R8m; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso4498721b3a.3;
        Tue, 23 Apr 2024 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856937; x=1714461737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSmjtgVuckfMZ8VC+OmMH5H1dLjbofpKgPRr0iJJo38=;
        b=TB7m8R8mtx2Kdwhd6CqAnoEjaboXOw7Pu4+t1YG8YPdX2a2CgS0BqlVJ40Wa6Rarqu
         MNw2QpuiTQZ6k9WXnPGe0Ea6DYxgxHyqrszI0REtUl8Q9TbEjG6qen3TZ49KQ/I82okf
         UHqhMVUqK3VeOHw7ssHFjoUa5BhWqWQVk6Nyor2KZXSB+vbk51sZ8aIDGJ0S3A/iNP2q
         m9yVRmW/MSliPSMniEAY5hL9ZgbMAlQOQ34iLmn16R6o0ancBJO74iWlgUNlGWtj6oX+
         oFVOr8zDo/8yC5ZKSgFvQgPNsxppjTN6L0oo2HxuL2pJ1ypvKbF2Kb9vrBHv7MhE4WOO
         dmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856937; x=1714461737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSmjtgVuckfMZ8VC+OmMH5H1dLjbofpKgPRr0iJJo38=;
        b=DaLJ/Q6Tx8WV+JMqPtmX3uyGIJO5X6GC8bYR0Po1t4o8OB2Q26f8pffeBbJdC2g4mg
         oLnvP/i4kzaTK6aXmbpp/TJvuOipJJf8ynqkQmrrVP5CP7VHoxJq8xVw+vscU8VHf/EA
         Sf52K3toSdffbrjmAjlcw0AaKmZTNszQxz+sdByRA1e7rYWLUsT5WOxSWF81Q9ugyIQz
         p93Ks8quExqXyazVUydqSAXmsBJ0GrgrCNgck1lh+4DDA17jjFKI3X6t+GxMdk9rfRS9
         FSGeOy+TiOamh2jo8PuyX3xARwhrWkmOIxdWNaPC1rdFgnxUuFe/A+2IELxgmG9P2Fjp
         uW/A==
X-Forwarded-Encrypted: i=1; AJvYcCW7uTgR74H50+If72VNRgw/3UOKlikpaqzrR9/Mx7gl/5IK4SkVRYyXv2aNiDAEw7v5GxZ1SX2NM+MU1yOlFjUADaU0WY+gGW/c12GS7xOjgd37ep0dyP9nQDi6HnF6hlEM/nIR6g16JKCY
X-Gm-Message-State: AOJu0YycT4p4JiXoKxAo4xzHvezbkGI6f3qBV9czoug2BlHM3RGfbQvf
	4uzkup3HwJeYwczS+n70HM9krVsvI3BWVF5fMLnFRUOaPR6te9iG
X-Google-Smtp-Source: AGHT+IGECVYwawMBLuHgOSRImd/V0atYzUdeUTVW1k4VHS5NdHvP5jhMq/LACb9K2IoLT372LftMsQ==
X-Received: by 2002:a05:6a21:3945:b0:1aa:9310:e83a with SMTP id ac5-20020a056a21394500b001aa9310e83amr14194404pzc.6.1713856937019;
        Tue, 23 Apr 2024 00:22:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:16 -0700 (PDT)
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
Subject: [PATCH net-next v8 7/7] rstreason: make it work in trace world
Date: Tue, 23 Apr 2024 15:21:37 +0800
Message-Id: <20240423072137.65168-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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


