Return-Path: <netdev+bounces-79051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B664A8779E3
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E81CB20F6B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A62EDB;
	Mon, 11 Mar 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJRGaB+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D723A0;
	Mon, 11 Mar 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124879; cv=none; b=oLzvIAmEVYjIhpqIZcUDAIvyo//xgib0SQcGn/BoQjfVSPGEeeOj5+0WIjflbXAxowXyuQH//NWBDM14n9ZJWBj0HdhGFr/sQI8bxZcUZuq1kj+wut7uKJ1TQgwAZIEmMb12dvjGTw9WArLGdRtb6SDEjZEEp4MqMxRoIfei/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124879; c=relaxed/simple;
	bh=ZBjmOXi0qubXcx6EX51mfp2IYcr9vL77PckhzgCFqE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qpxr/kIDI1RkzIYto8yTyc0mq7byxLS/jrFLU5iHN+vylr5/zqKLc8OKm/8ooEqgn/v4oUOyhmkiUrLXkYBepzxqKY7c7mQDASXKf8rayh2OIINyadaUmXNQEY5V8TJ2ooDzBZeL2LPSEmp03uVC/5YOkAY1Zqv4MZ6WY8x10xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJRGaB+6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd955753edso4562255ad.1;
        Sun, 10 Mar 2024 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710124877; x=1710729677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8AorYRFqUOOnhfdZfjEkjTqC0gSsRIuuU+61AmJ9Vg=;
        b=nJRGaB+63RKs951aEGAWpSHP1V0J54Erih2f6M1VfMPvFaDAjawjnw/s6WyuKiGTbo
         cuuIQyR3qDgIpN5MdiVfSbf09+SDsGGZbZr6uU4s5eRXdp6XBfxI1dBLdkTA6EK+qcOX
         dvGNdj/kvUXKDF1Y4v6x/D750X4OJzs4tQ3vjXIaq5iLhlBpZWjb24b3L25nHqHgp8eV
         zci/s8Cc/W1il/83I/3tE/LeQ0zBFuPuahMxPL8vzsH1dcckiwr+5Mr+PhFk3GmxSQdF
         Yl6w7OBuwMPXRmOhdgAmmxyw2e44fmlBLe+T5g31DKc07xPI0ZjDngmtAtLAWK+mkSF2
         Pi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124877; x=1710729677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8AorYRFqUOOnhfdZfjEkjTqC0gSsRIuuU+61AmJ9Vg=;
        b=tRgGLy1FNi0k309XaTDfv59DpuAHKwBWw6rcJn8YWxTrLmZxplEUhvxGQoXLKpyLVr
         rG12rxXxRRGoEgmHjV9y8p0n6wURgWgvS7EBb/kvzs1y3GfjX/Y0+N9MnWjgFaZKGlkB
         qgn8f7YbAF2x8Gjk4JLqqPxoOJt6fakI5N7YYUJqVmhqh+CvDbnFskFuB/xUK2177UN0
         A+F5TWQFhNcgrXHCm6hRTEFyjdy/6x+6UidxRZbNL2RItUl1pBA0Pl8fxHnpDcRPlYal
         UnRnaD1BPjfU++VjQ3yHbWRkhfT+Tg3/nrEICmXv8G6qLSiMX071jRqD9Ut+Q8DsSlSJ
         hL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO8kRS3XS6Z3h5rs1HeF8X/hx/QuBLPtKHw/oZ6yE0IpmQjTYY6CYhWQ0UnfjU2TCOtX4/ThJHY+649XVhMsj2g0HxouZXfQWUG6qXCQRTQIE6
X-Gm-Message-State: AOJu0YwqwB+MwEztRd43QdWTj2U9mFmOumaCRuHQsjumLWDorzURIHAH
	vVVv8d+g59B0caUrWWEFiIJ2g3hNQAWL1rNNvsNl0rCDUGOPK1fS
X-Google-Smtp-Source: AGHT+IEe/ECoIJsaQ0OjCtnRyZIiCR0IRN/6C1dNiKgN6pMcL4hdzKML8qBys/iMNg9nyOu7nXvhrQ==
X-Received: by 2002:a17:903:2582:b0:1dc:b30c:694c with SMTP id jb2-20020a170903258200b001dcb30c694cmr4032863plb.41.1710124877534;
        Sun, 10 Mar 2024 19:41:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dd98195371sm1135120plg.181.2024.03.10.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:41:17 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] trace: tcp: fully support trace_tcp_send_reset
Date: Mon, 11 Mar 2024 10:41:04 +0800
Message-Id: <20240311024104.67522-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240311024104.67522-1-kerneljasonxing@gmail.com>
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
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

By parsing the incoming skb and reversing its 4-turple can
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
index 2495a1d579be..6c09d7941583 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -107,11 +107,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
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
+			 * We should reverse the 4-turple of skb, so later
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


