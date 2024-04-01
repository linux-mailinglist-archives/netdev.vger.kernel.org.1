Return-Path: <netdev+bounces-83724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747D8938AC
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 09:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C7B281A3C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D24B66C;
	Mon,  1 Apr 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSkGR8e9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C70BE65;
	Mon,  1 Apr 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956981; cv=none; b=DpjNTtLpxJrpHSeV1Nqep3for3bgj73hVrE4UiYCNS+Mh9b0SNd/NNjnJGdkansjRmt7xvfUhlYybcbxAHINqmjpXQFDYkvfmmqK+qshYT4MbmyFYTw+qd7yyjkHLsootJlq31FKPZRVZWvie8ktsOhd3YlVIB/3AXOUixDLc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956981; c=relaxed/simple;
	bh=Y33lald868AEFBEAzQQpl5KnbN/ZlQxowvXyePULSIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Umuvz2/rmPf6m20WwNpxw5tO/9EhpaKYRg5lpvIUParT5x98v3Mx2eVezMI85HbTG3/7HvnMTRVBn9/njsIdF9aMPRgOOSPyvCntOJnR/cIagWnu0w/6W8xWNvFgvsZJAb8pieL/Fe1yLjhu2cwdIqlJYfsM7xJhq3ELBWQPLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSkGR8e9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ead4093f85so3438931b3a.3;
        Mon, 01 Apr 2024 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711956979; x=1712561779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X29dP94IyIxocgonpYmxURR3c3KlW1OjV0nE8Ec6lII=;
        b=VSkGR8e9khGPrSLHUoeA+S+M+gnNt4a34zWWHfz01St0jtyj6jiOMqVbSOHtIXXF8V
         l0BrxfEJEpBHS8J8W8V6iSWIh608TEZ+LGBmYVn+wwdXAO8TopxQpPBOVAE9xLikJsnD
         kAwN4fgW1QGUJULZkqR5Tf8fuEeSoADvW7M0y4Yh6sNWVNauVnFbQMVLSmqhWl9svdEn
         8qj76NvinCe8gJ+fTk/qvpoF5aKdfQRRimgfeW1ILnL/UDzzO2CcLQP230LYPe96Ytlw
         hU6fPj80FGIFg8/1eO+xed9Sbfk5e+jkp5iqyoUDFs1e3culqaVK+YZxJgUikMpIYtaD
         5NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956979; x=1712561779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X29dP94IyIxocgonpYmxURR3c3KlW1OjV0nE8Ec6lII=;
        b=QLEficJl2C8LVlzwkpzkaPlvR/r+qm1h6VpApTNj0dWxg9wgf+u1wd99HVhUDG7AuV
         OzTr363ZQHfHP6hkm2f45HYm64do3StwlAzd9V8UIXyNCyodU84eKCl8AY7E7CPv8YXq
         LQW0TyxALv1HX2XGUc5QBoiDouzj0xbTB6BEXwVbTDb7F/PzGKo+YADXArhyt/4gbsV4
         yZWY+Mu7RQd3p37KxxCVENSlEsgYSNqGTFpR9a/Knp7nK3e5p+JeoDKhMQ/hUDG1gtkU
         C0m65c81VdHmXZUMLA4u6OzOw0nzcsrmkx2aKM5lD8tJTxdxvUd5tMAa7UvDXboKXBsE
         hAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC7oCdEobhT//klukzP4BtVeIFIdnC9mB+EYcJH5gxTnFw2tI8CTF7PuVqa/52k5u9mbl9Ewoc1K7ZD/FDo/lezdGnyUlaCjVr/Ji8d1tDCAUq
X-Gm-Message-State: AOJu0YwJHeMeIefD2qRXboodNiq7QdJ2lMB0NyjDWsfMFFZn92nPaZXL
	SVpHAhxaczeAG5UxaVgN+L6ksh+L20K2MAukVNs5MhwOKbeXbbCS5oPk0KqPTZk=
X-Google-Smtp-Source: AGHT+IHpfRDhf7L5dWjzJRD9FKkRWD2qCxAKFikMfaxquj2dXrnJJzZKq8ak0+xUPV9CBNSZk/M4vw==
X-Received: by 2002:a05:6a21:9212:b0:1a3:e4fe:f6f1 with SMTP id tl18-20020a056a21921200b001a3e4fef6f1mr7831361pzb.58.1711956978931;
        Mon, 01 Apr 2024 00:36:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e0f54ac3desm8363497plb.258.2024.04.01.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:36:18 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] trace: tcp: fully support trace_tcp_send_reset
Date: Mon,  1 Apr 2024 15:36:05 +0800
Message-Id: <20240401073605.37335-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240401073605.37335-1-kerneljasonxing@gmail.com>
References: <20240401073605.37335-1-kerneljasonxing@gmail.com>
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
 include/trace/events/tcp.h | 40 ++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |  7 +++----
 net/ipv6/tcp_ipv6.c        |  3 ++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index cf14b6fcbeed..5c04a61a11c2 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -78,11 +78,47 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
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
+		} else if (skb) {
+			const struct tcphdr *th = (const struct tcphdr *)skb->data;
+			/*
+			 * We should reverse the 4-tuple of skb, so later
+			 * it can print the right flow direction of rst.
+			 */
+			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
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
index a22ee5838751..0d47b48f8cfd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -866,11 +866,10 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	 * routing might fail in this case. No choice here, if we choose to force
 	 * input interface, we will misroute in case of asymmetric route.
 	 */
-	if (sk) {
+	if (sk)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
-		if (sk_fullsock(sk))
-			trace_tcp_send_reset(sk, skb);
-	}
+
+	trace_tcp_send_reset(sk, skb);
 
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


