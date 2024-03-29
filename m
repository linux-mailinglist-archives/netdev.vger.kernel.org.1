Return-Path: <netdev+bounces-83166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54616891222
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88D21F22D28
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91939FD0;
	Fri, 29 Mar 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoSZfE62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626737165;
	Fri, 29 Mar 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683785; cv=none; b=GadVsxAzVMzYIBwIsQdAoBEq5CQCnxLB2KmVbZSGnnYyK0Qyr7MUzZ8IwRWnqHRk/FI9mp2XsmFFr1CvUVs09qvCpAVVtZ+Gq0tQB3sMfz5fVXORpcKh427T34gwRb4R6jLrYt3TFE10h2ieOaikFKkPIrM7IqIJbFKVzXGJodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683785; c=relaxed/simple;
	bh=5LPZ2946B5Xqp/aiDsr5B3ZSKbureFUqp/S1v1y8Q9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BU/8p3LJ4wMvhMjHhnr8FIwtP4GdId3vmYU3sA4eN510hXLCmRn1mtixG4WryeLyVn2xZXi5UoXVlFaVwv+J6F+TsP8MkqK6DZi+Mfi9Ibl9EtGplFB7lKMf6A5Hlwi2eFPfLxIIjG5Ee2u3u0oGSBP3csjmbYuJ2Xf2QNYml7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoSZfE62; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f060cbafso18549357b3.0;
        Thu, 28 Mar 2024 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711683783; x=1712288583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r12a3/P8xmU3vgygChQpw2sBXmb9HEH/zD9NGL1j+8=;
        b=WoSZfE62Tph4oTscwdmvhD8u4qkpVQ6UYpkViIqlAlcWaqVk/WzVUqL9Y2fdjuA+J5
         ySmQzVbYq7OPYFPk8u3A5oUfuaVrcHKfKb2ZKsg5i0dZTcUsbhT7e0/7RTupqa8L6w+t
         dQTf3eBVpVW4lG2klgbhbfJq6LTzZYl4vcSdW7UChrDXH8KKV5Xnk9qmgqtlXFoyEQxo
         6mN6XZiL2wffCUOqg198kbQCL/McZIk+inziU/XdLHMy4F6q9hjqcax+6L7RaFQnxMeJ
         XRupAV3sfY1lDe7tE4zdZ04MP+feNxub5Q2lA5IbGAG0rObI0tNSLotKxIfoo5ivI3J0
         2SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683783; x=1712288583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r12a3/P8xmU3vgygChQpw2sBXmb9HEH/zD9NGL1j+8=;
        b=Wo8BmABHDMwLExiwiGbPr/B4TosndKY86YEPJMlIojxopRM1Az8pMH6JmVg74on6qI
         LRdtEKm7xh8ZF+2mPrQSeA2ysRvSGARPrpupv8ZTQ67ZI69fx3TVIqWqZAj7MwfILhev
         NkUv8Azcn3ZVrPnUQbyo2y/TswdKI2uA+TCbr5EFVN2QuQDPAPBllOhkF+wzYtY06jut
         5eDvQmotsz0Ar/VqrC/SnRRdORQNtzhyBZ6XNmyefS7T7hnUiRpYSJdzyqy9TczgAuTV
         0HwrX7KucTSPu1uLm3QiWIG1Oro5krabDwY30c6DR2Or/RrljumAG4fodttJS1NixI3k
         d4pw==
X-Forwarded-Encrypted: i=1; AJvYcCW0WSQkbTEg+HobPJOyKz2KMjxTGbhNoqKbO8MWNrprmcLeq92NiJm0NtUz4Da4MzJfais/RMGdxEG17Md9CQc7Gfq6osiABlYHXACYDKiRZmBd
X-Gm-Message-State: AOJu0Yx8vApFcn4GMRNx3jXoyzNKTQ8FsF6FWRVMUhtvu5O34XnXyQK8
	lT3HYBBFyIUvyexogpIv7K0cIx1YfU+DhMM8nDoQdHVE1F1iUfDz
X-Google-Smtp-Source: AGHT+IEtTBKIvCkExk6lBXtM3X3usjWQBYXzXQPkQ6sXjJy5YkdzJDYhixfLZSgbRiSrD5+CQ3B9BA==
X-Received: by 2002:a81:dc09:0:b0:614:42b1:edd8 with SMTP id h9-20020a81dc09000000b0061442b1edd8mr513720ywj.2.1711683782953;
        Thu, 28 Mar 2024 20:43:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006e6c0080466sm2201854pfr.176.2024.03.28.20.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:43:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/3] trace: tcp: fully support trace_tcp_send_reset
Date: Fri, 29 Mar 2024 11:42:42 +0800
Message-Id: <20240329034243.7929-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240329034243.7929-1-kerneljasonxing@gmail.com>
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Prior to this patch, what we can see by enabling trace_tcp_send is
only happening under two circumstances:
1) active rst mode
2) non-active rst mode and based on the full socket

That means the inconsistency occurs if we use tcpdump and trace
simultaneously to see how rst happens.

It's necessary that we should take into other cases into considerations,
say:
1) time-wait socket
2) no socket
...

By parsing the incoming skb and reversing its 4-tuple can
we know the exact 'flow' which might not exist.

Samples after applied this patch:
1. tcp_send_reset: skbaddr=XXX skaddr=XXX src=ip:port dest=ip:port
state=TCP_ESTABLISHED
2. tcp_send_reset: skbaddr=000...000 skaddr=XXX src=ip:port dest=ip:port
state=UNKNOWN
Note:
1) UNKNOWN means we cannot extract the right information from skb.
2) skbaddr/skaddr could be 0

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |  4 ++--
 net/ipv6/tcp_ipv6.c        |  3 ++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 194425f69642..289438c54227 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -78,11 +78,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
-DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
+TRACE_EVENT(tcp_send_reset,
 
 	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
 
-	TP_ARGS(sk, skb)
+	TP_ARGS(sk, skb),
+
+	TP_STRUCT__entry(
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		/* Zero means unknown state. */
+		__entry->state = sk ? sk->sk_state : 0;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+		if (sk && sk_fullsock(sk)) {
+			const struct inet_sock *inet = inet_sk(sk);
+
+			TP_STORE_ADDR_PORTS(__entry, inet, sk);
+		} else {
+			/*
+			 * We should reverse the 4-tuple of skb, so later
+			 * it can print the right flow direction of rst.
+			 */
+			TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry->saddr);
+		}
+	),
+
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+		  __entry->skbaddr, __entry->skaddr,
+		  __entry->saddr, __entry->daddr,
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
 );
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee5838751..d5c4a969c066 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	 */
 	if (sk) {
 		arg.bound_dev_if = sk->sk_bound_dev_if;
-		if (sk_fullsock(sk))
-			trace_tcp_send_reset(sk, skb);
 	}
 
+	trace_tcp_send_reset(sk, skb);
+
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee..8e9c59b6c00c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
-			trace_tcp_send_reset(sk, skb);
 			if (inet6_test_bit(REPFLOW, sk))
 				label = ip6_flowlabel(ipv6h);
 			priority = READ_ONCE(sk->sk_priority);
@@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			label = ip6_flowlabel(ipv6h);
 	}
 
+	trace_tcp_send_reset(sk, skb);
+
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
 			     &key);
-- 
2.37.3


