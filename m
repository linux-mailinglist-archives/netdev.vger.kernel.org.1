Return-Path: <netdev+bounces-89919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD028AC2E6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14434280E0D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB90D272;
	Mon, 22 Apr 2024 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAhDch7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA58DDAB;
	Mon, 22 Apr 2024 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754910; cv=none; b=XdahOUkBHsA1H0xXqoDLIg+7GCNSDPZyPv4xN37/+8pEQbZUkNR4D4SmZPyhFm+Onb6E+01unwj5j8e7VQHvUmD2enltUyFFLFVC4mfENisZieWklyxsMsowpUsy7pabrxVLc0CxahHi2gMNqIF5tqs77H2wm5qNi69e1ClHBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754910; c=relaxed/simple;
	bh=CxYn1VGv9BVyoGnuPJvlhKLzgZNZDmrSRnQIudaVJAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dz9xi2BxBBC924KcsVtACe05ZrlEawkvLPNEUpskSjtirHpwAuxIK0em3jC5fBTw3Ph8gQPOAEqg90BoZX+iCnjOxwd7dDhG7sXFDDyq169KpsseBRWsCDN78StiLHt1eFgmSfHezUL8uj8VxI+i/0QTHrLRZEewYjOWSCF1RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAhDch7F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9bcff8a8cso1650185ad.3;
        Sun, 21 Apr 2024 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754908; x=1714359708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p8+XBCRL6Hrr61VyGsGU7K/4kprn5SAx6dJ5viCQ54=;
        b=QAhDch7FEE3tnW1fmaNhVkxVxqNHkFA6qbrHqihccjIMpl4LnCFqxzOaTMqlOjNYf2
         hwud7zR3CieX+22Gj0e+7DBc8B3vrnaNsXrDwZNuvPrA27hmZEizuOhap/IplQ4jo38W
         1FDTphBBgEZVsfipSFimtYziBtuWQy3qzTUdMwuHjC9SqAxBMYD8JW2aF9vQuLLXrrnY
         3ZWpHyUXUeip7xKAagHPGF5URI+QCE8JL1yBP80jDkN0D8iQ7NSaIGcIob9bnSHO6dgO
         KqCl8AUZLf5AK2jBBRBV+GwC7BycCSp4rH9LyE+gqBRXVmMyebEDxf0NMv511ExwiFc3
         5Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754908; x=1714359708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p8+XBCRL6Hrr61VyGsGU7K/4kprn5SAx6dJ5viCQ54=;
        b=HPJWW77H8zjyyFiWJn52OpoEF5Hs+ZpXOVMWS4oPP1qMq3b6hjU7MHya9Omj2JI8LE
         rhhqQIfaENUp5mgDIX/yowcFH1Ci881AKWCaWjxgu6BM329tnqOSTDTUeInAZU+LhDIL
         qKKYheYCdwcuPBc6c793C3k0izB2+yantyKnFOuRm7TeWRUhpIL/c0IGpuF2w6xjWFYa
         zqtq83vvHIV7NpTszWPfJQayk2Z0JT7V+9V7z0kUuz8XjupWWTBOn+X1LJl7BfLNh5AZ
         PSXlIIqKJtvP8pKoqwKqmVlYamcVKnWaXdZQpjx9MyWtSCzz6cn7y0Jiq4+1zcDMpxL4
         vkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Xhh36zmVezINxgKQUe3478LTJIND5BQBdYwbG5hyRBwo9aSlcX6lRaxhSXGi5hJl6fxnybWEyS1VCVDkO79W8loMZjvEBHsxh4F+frs0fQA8K/bj7v4HZ3nRBIV9ejBwH3HvpziT1U37
X-Gm-Message-State: AOJu0YxmLD4/k6oxi81y6sgC/rUR4ndPZLj9qs6mePneJ41Ea79ZGTrx
	7HkMYtIbL15tj7EK95n3FlTA/tnTLmxpuOjP3QW0vvtTvnZCpgFf
X-Google-Smtp-Source: AGHT+IEmXSE6/YbEiEkDZXkV8Th4sWtQd6TKpikTRSCaVLJJfKnpX6D6nSHGbo4EvC969UyO0qiD4A==
X-Received: by 2002:a17:903:11d1:b0:1e7:f944:b000 with SMTP id q17-20020a17090311d100b001e7f944b000mr9643112plh.24.1713754908124;
        Sun, 21 Apr 2024 20:01:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:47 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 7/7] rstreason: make it work in trace world
Date: Mon, 22 Apr 2024 11:01:09 +0800
Message-Id: <20240422030109.12891-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
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
index 06f8a24801b2..5db2d55b65af 100644
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
index d8c74e90698b..966a6a9b0f44 100644
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


